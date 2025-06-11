Return-Path: <linux-kernel+bounces-681378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A8EAD51EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 12:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFE93AAA3A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 10:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88086269CE8;
	Wed, 11 Jun 2025 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZQgieEt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B41269CE4;
	Wed, 11 Jun 2025 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637879; cv=none; b=uYUkduwsNaRhN9UO/I7JHBy0x7xPhbHVpllbc99/6hdj4iwY2odNV0+hPMa+zgdpTUUdwMxdtvpkij9qVfeTbV8mdwEl9gYk9c1hv57WzgPI6QZDDaI3JShOeiayo1FAeMMRd95Q7GrkjePwwR9yc/d3mxfODDvycXLvtJsWkJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637879; c=relaxed/simple;
	bh=rOGSDuo602dxiGluRCUxmINW3AtCkdReRdX1F6GdxmI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pzpyxi7ER/2xtyrnzOLAEEr+Xj8lCPWVROa1uYGRl3aau8G+orahQAtC9EcIROpwO2ob4+Q6KVucQlO3CeekQnl2czf7QY5eTIY9nfhS3R18WSEIEWiyjKBiqv9LzAHMuB6uVmQgkyEZs5bnTIwhGkyZtIBXnwCgnZycLHpOtKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZQgieEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12811C4CEEE;
	Wed, 11 Jun 2025 10:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749637877;
	bh=rOGSDuo602dxiGluRCUxmINW3AtCkdReRdX1F6GdxmI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PZQgieEtDjx5oJh7vHgt29+M45nfiGEsZVpj5GvYhtKvOuZbi2A7gklhKYcZNZ52i
	 vkxo0kJ7ztqELE/ZhhehuChrkEuZpIr4Gnp756je61EnC56Hrc+0omuljHdaKTmquf
	 rsPMi5tqS3+cm8Ku1TF2SPFWV4vj6FlJV+/vY3Oce/dXfjtztAlyfzTNPZtXRfYxH3
	 EJ6CeshRSNoeKtGCMZEz75VP+gxeLgQF3wyAtrCsXZ2s9pcPn6UoVNZ1mjg0uHlTYa
	 /Ziif5rJx0sD+89EUz2yAwwuvpQ92lEDP9TL9biM+EHXSkc4M539DvWPCRqIYBr429
	 NEhlSKcIuTNgA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Philipp Stanner <phasta@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250610135413.35930-2-phasta@kernel.org>
References: <20250610135413.35930-2-phasta@kernel.org>
Subject: Re: [PATCH v2] ata: pata_macio: Fix PCI region leak
Message-Id: <174963787580.1635114.9212678796816994637.b4-ty@kernel.org>
Date: Wed, 11 Jun 2025 12:31:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 10 Jun 2025 15:54:14 +0200, Philipp Stanner wrote:
> pci_request_regions() became a managed devres functions if the PCI
> device was enabled with pcim_enable_device(), which is the case for
> pata_macio.
> 
> The PCI subsystem recently removed this hybrid feature from
> pci_request_region(). When doing so, pata_macio was forgotten to be
> ported to use pcim_request_all_regions(). If that function is not used,
> pata_macio will fail on driver-reload because the PCI regions will
> remain blocked.
> 
> [...]

Applied to libata/linux.git (for-6.16-fixes), thanks!

[1/1] ata: pata_macio: Fix PCI region leak
      https://git.kernel.org/libata/linux/c/3e537877

Kind regards,
Niklas


