Return-Path: <linux-kernel+bounces-851578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE19BD6D15
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFF6189A965
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80022FF177;
	Tue, 14 Oct 2025 00:00:09 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1584262D14;
	Tue, 14 Oct 2025 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400009; cv=none; b=G9S4mZ6653rFkBXoT5oZB2/FDeT4ptRg0DODeBg1mYytUUqKrHfuVf6MDR/s8kBHQi+Ie1TfvWlZbKoElfMhyJiTkAQyX4Ajarc/SRGQxMNe6ZLGGBi4lEru1rQtjLeQrSIVhmF/cOeVMp3RruMUWIl7l5izk2XqbBDuBar1JWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400009; c=relaxed/simple;
	bh=jD04CQcR2sMnWWV096+/CgEVkDbC8TYbBtJl3+xjcqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uR+CSkgd4wKQfvs16SU8ILWpiXIF+9yBgOM3R+NTisJtIJHwTTbxQx7M0N1LYjpfJqZg/wNjfhSKg+Zs1jKP+DCiy5dQELig0+YArDaSJaoimaKEzz4Nl+n4v5/qqpPHCcxXpeLEPTOb+CAMJER8uC3LeqFhKXwvWo1V+TQZ3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from ofsar (unknown [116.232.147.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id B457E340861;
	Tue, 14 Oct 2025 00:00:01 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Cc: Yixun Lan <dlan@gentoo.org>,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] riscv: dts: spacemit: add UART pinctrl combinations
Date: Tue, 14 Oct 2025 07:59:41 +0800
Message-ID: <176039992624.852221.13654333780922349248.b4-ty@gentoo.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917065907.160615-1-hendrik.hamerlinck@hammernet.be>
References: <20250917065907.160615-1-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 17 Sep 2025 08:59:07 +0200, Hendrik Hamerlinck wrote:
> Add UART pinctrl configurations based on the SoC datasheet and the
> downstream Bianbu Linux tree. The drive strength values were taken from
> the downstream implementation, which uses medium drive strength.
> CTS/RTS are moved to separate *-cts-rts-cfg states so boards can enable
> hardware flow control conditionally.
> 
> 
> [...]

Applied, thanks!

[1/1] riscv: dts: spacemit: add UART pinctrl combinations
      https://github.com/spacemit-com/linux/commit/1187f9b3f6ebde806289877fa710ffd58f950104

Best regards,
-- 
Yixun Lan


