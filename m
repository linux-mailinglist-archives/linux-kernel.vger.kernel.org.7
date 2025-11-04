Return-Path: <linux-kernel+bounces-884950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEB4C318F6
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 934424FC22F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2A53314D1;
	Tue,  4 Nov 2025 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8Xh3gnV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471CE32ED22
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266699; cv=none; b=lBlUdUaT9Ud3aY2d3KRCIJTfcclg7W6Mc3Yyyj/c6EBOWL43vUKNq7bh4NbyyxfhN4gVGgifWC5k5rlM9hEtM35sbxr7nrz/2tTyPSFMRUBOdaQt8gt+f/ieQrIQiO/HSFUGtYJHi1+FYSVDZ+U4Gk2CA8tcpxRbjhnygjCine4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266699; c=relaxed/simple;
	bh=0SPlbyjso/mwT4FGB3u+5KyJ2qpQpBf099rWRXcddn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSb1OEK3Pq3zcLwRkmTcZMZj/zgrQR4wcgz+0bpfstr/txJEmCLlx5k6nJv5pN9u/M/tgqr/lJiGlxwYI18HRpcggo/VX/FKUuwK9DYTga22oyqT091L5k9vv3T42Ce3l/fEsBt3RbRNu2Dl/prKlCoKH7stbHm20gT/PyzPSn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8Xh3gnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C8DC4CEF7;
	Tue,  4 Nov 2025 14:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762266698;
	bh=0SPlbyjso/mwT4FGB3u+5KyJ2qpQpBf099rWRXcddn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8Xh3gnVJPcqdE64pMFhkUD14Yva2zvXN6u37/PaTVEubw2ni57Y4j/nT2Jjqj3Cd
	 xudVFbbUMaH6G8Hd5gaGRNhVeOLqbvDc5hUOFJg5Y7+lUFf78PY9+Ul3gYQbW5DOnd
	 K5HA4v5YnscM3xEYmcZITR6pWLXf7HJ5nJTd6/zdm9VxfH8bV/KK3ikm9J/pcNBtyX
	 NrThHcbZrdl7lkRDtf3d5izGQGQlVB+8nWWqVrZ+MWBZDt/tD1XI0IsAzFu6owXe57
	 Ffzw4zS0+dBomhcEusJt802pS5ljd6ekZBy5O8TEraht9Z2O5HI19sEFIps7IAK+an
	 jtSHf2vRQ/3cw==
Date: Tue, 4 Nov 2025 14:31:34 +0000
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, ryan.roberts@arm.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Add a fallback stub for pgd_page_paddr()
Message-ID: <aQoORmgliayA0s_a@willie-the-truck>
References: <20251014110633.304961-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014110633.304961-1-anshuman.khandual@arm.com>

On Tue, Oct 14, 2025 at 12:06:33PM +0100, Anshuman Khandual wrote:
> Add a fallback stub for pgd_page_paddr() when (PGTBALE_LEVELS <= 4) which

typo

> helps in intercepting any unintended usage and which is also in line with
> existing stubs for similar [pud|p4d]_page_paddr() helpers.

Are you saying the kernel compiles in this case without your patch? Which
definition of pgd_page_paddr() does it end up using?

Will

