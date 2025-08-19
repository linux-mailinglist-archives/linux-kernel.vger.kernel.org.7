Return-Path: <linux-kernel+bounces-775465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB0DB2BF75
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFBE5A0C63
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591DF322DA9;
	Tue, 19 Aug 2025 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SIn+QCUR"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1155322C87
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600952; cv=none; b=bdOi1M+zaF35acfpV4BxqZo11tchyeUgPUmtD0L2fP2iOS29Yy8LTPtLeH/SOs8pFjrkJSFRHt1Y6HsNKSSES1VVoaCO9tJt0u/OTpXY4da1jalEZHzJfbM9pXT5305sQYy29loPe6MG5qLmoMYizi3Zw05OCzGzOgq+dz9iumE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600952; c=relaxed/simple;
	bh=hGwv0JuulP5KfDiAf75I2usmOX66r2Lm+Mb1RkBSXr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vlcx7yIG3VzM8gtPdQBPB/5AdVoNRRLMWzCfQs0HuG9EIiRu3c3kxK/TXaDL0NMTIGgRIv6aSesD6E+rnbfZoiav0NNl4306jYiDNvOilnA+5YAdFvvUFQO0L5YC/+frIqReudivOPdRCvA/cItjPUPZQh3GQ9y8dNCOQC+nBLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SIn+QCUR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C63FE40E023B;
	Tue, 19 Aug 2025 10:55:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BfPLwpdZ8bRL; Tue, 19 Aug 2025 10:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755600937; bh=sTvsMQ0ryv8kllMOrtsRhxf7Fs9JEFguhGf+UXQ/WDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SIn+QCURK2hsTduVLZu+zGzkacnte9Xw6ui5Lpc/Us/oYftunkXY1zgfluLaPwcCI
	 UjGMKvU5xLSuYK6b+3Smuaao5TKUJaNgaJsxkrTnFilsf4HPM5Ln6gaYL7APcREwHl
	 kLdYBHosObFGAuDMCY4BQlKuvV1ZUtr5eC3fb9u+DCnT+9kJx2lPolnilamUb/alWJ
	 kOISiPrCsE/ql9XecBKt1szSxtojD8GhKZ9yGmxLa6OW42DcBuJKUfgipv90Be0eAc
	 aTp4CAwQtP1nAtqdAQSI1b8q4PJ76fVLMgXY/AsVpHi5jXEQbPlMoe/CGX47QWbhwc
	 nhrhzZoePh7+5vG4MqO1ps6eCmWuwFXGN9qf1WR6QPs1Qb7Cy85ct9/2jwzPWJ/Dgo
	 s3+wmVD4gHXz6Iu/PliGZjEdIxWAQWQWv0w/pksCh7tq0pRDKpFTZrCLTtrp9yshuo
	 PIGF7hrLHm0b75367BAIW2RJ9fgRQYU6dkeMRgrvaz4/8m4I+DTeuQ9qrzOVurXhZW
	 6E9NU8v3hTbHm/dMDj40UsTfNiqhlqKGgRPreXk5XLgb4zDwSYkb2zuHAKbi78+uXf
	 jqbRNU0fK1I9qF8QXs6R+HrFuX7O3Ind0ISLYRsWg9KdgT+cy5DAs/j8QRo/WOK7vB
	 TRFWvhyX+SK1bz1YXzisoKDo=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7235F40E0194;
	Tue, 19 Aug 2025 10:55:33 +0000 (UTC)
Date: Tue, 19 Aug 2025 12:55:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: x86@kernel.org, linux-firmware@kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] amd-ucode 20250808: "No sha256 digest for patch ID:
 0xa0011de" on Linux 6.12.37
Message-ID: <20250819105527.GCaKRYH9VnQaVdl7gQ@fat_crate.local>
References: <CAMGffEmFm8wvgiw+s0ZpOhRxBLOz3dQiS=sQCkgJLD6qC3VwJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMGffEmFm8wvgiw+s0ZpOhRxBLOz3dQiS=sQCkgJLD6qC3VwJg@mail.gmail.com>

On Tue, Aug 19, 2025 at 08:14:50AM +0200, Jinpu Wang wrote:
> Upon boot, the following error is reported in dmesg:
> `microcode: No sha256 digest for patch ID: 0xa0011de found`

[boris@zn: ~/kernel/firmware-linux> less amd-ucode/README

...

  Family=0x19 Model=0x01 Stepping=0x01: Patch=0x0a0011de Length=5568 bytes
    Minimum base ucode version for loading: 0x0a0011d9

So you need to update your BIOS in order to be able to load 11de.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

