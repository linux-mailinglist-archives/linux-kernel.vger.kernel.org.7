Return-Path: <linux-kernel+bounces-825616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2680B8C531
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 12:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627D856334C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 10:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9CA2F60A3;
	Sat, 20 Sep 2025 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Pig9Ow5s"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9189F19995E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758362849; cv=none; b=DbS1PK1SEDx9USKdv4etmbMZrnCdZRZxDFo07+EkRyVV502SLcywBOGbhXcN6TkOSN3xDxuOHfBEOd4wXyzx9Kg5vvFkCQSGRspfCcDpLkota2Gl/+AwUjfCJ/Kw0s/JtYkh7eDi4VeimpsPUaJpMM4brId0Dy119UXAU6+pyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758362849; c=relaxed/simple;
	bh=MKjIh5L0lgCsmyp/QdgGqJ1Fyf1zkeMIjeQIFMOmoCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnZYuplI2w8Jk38qQHrWmqhUaNPsnXCEMyhM4w/SYlKzDFZ+mdge9qr12lhRQXrwiAvFGl0Enp9cVSjys1UFaf2EvInQb6Lq87KsNaJQ7Mc1c4KkkYBXxAI6gcsBNNK49YM4hojCjhBfvILDjp7Ew4wEXws9B9d/1R6XMe5crCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Pig9Ow5s; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1D79F40E019F;
	Sat, 20 Sep 2025 10:07:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uiLeUKyJTZz7; Sat, 20 Sep 2025 10:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758362841; bh=d7aBv0w8oce07dNFwKVMTVTPTJZ61ysWVuVAm5Hd4Bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pig9Ow5sxIGCihKX6dyfc+uxE42HYL/zvyiHlJw2TJlKkCrp2V5eECpgWQ6D+3uTf
	 jZglAvzL80varCEJjXmBWSHYn3riaoHOMwRiPN0nhfOJhnfeGMaAwDKOdRDAE23vrW
	 04cK3A/whxRJBHApzHCx/vme1jA3KUTtoWdo1g9zkOsO/YlBK7rvbG0ei43PJFkHXH
	 obGShGUyeP8OMx35HNN1G99LZIUb+KFsTAHj20Vn0GuV3dviRfgSKVkDobcUcSdpKA
	 BuZ3OrFGpLFHXDALf8T9RabUWPLTQQmVNOsm1434ddczoJYRA3ijyQElHe0reor7+C
	 GbgqIOB0gWlgAaheZjhE+An0p75wN3QdWSPkOrfD5EOSvRJJsk3micIhJI64tL2FJD
	 hBnRE11Vrv3hfjCQaayO7szqrZu1WEbRXhrlOroU33Ks5S+xWdpezc2/z2vgXXABFI
	 GXFFiIqlZFm6gFz5+phhbknik9dSSqK1Lm4a9/gi3c1AYVAmyAWl5Q92uhlPT8nZPq
	 07qfZVULhGdpaMKa2oOX4J0YHmcBbMGdnIYYDn6DUkO1IiDeaXrjnl9sw3dsOdecqE
	 fjsK9pAWVVJz5euqIPCeQ3njIL5P8BNVbF0d4rhHTMeWo5HtIhSp4dhazQ+7JKgLVt
	 C9wPO2KwtWdxXMW6VSYumyLY=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 2D01740E00DE;
	Sat, 20 Sep 2025 10:07:13 +0000 (UTC)
Date: Sat, 20 Sep 2025 12:07:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Dan Snyder <dansnyder@google.com>
Subject: Re: [PATCH 1/3] x86/umip: Check that the instruction opcode is at
 least two bytes
Message-ID: <20250920100712.GBaM580B8WQipOrD2f@fat_crate.local>
References: <20250808172358.1938974-1-seanjc@google.com>
 <20250808172358.1938974-2-seanjc@google.com>
 <20250919181635.GFaM2eA8GFtZ48sfb0@fat_crate.local>
 <aM3KKo84920sZ4Nc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aM3KKo84920sZ4Nc@google.com>

On Fri, Sep 19, 2025 at 02:24:58PM -0700, Sean Christopherson wrote:
> The "weirdness" I am referring to is purely speculative; what I was trying to say
> is that I deliberate went with a "bad" check on nbytes, i.e. it really should be
> "insn->opcode.nbytes == 2".  But I didn't want to risk breaking some bizarre
> userspace that happened to be relying on a quirk of the kernel's decoder (I
> haven't dug into the decoder, so I genuinely have/had no idea what all could
> happen).

Yeah, after yesterday, my todo list has one more item - to dig into the
decoder and see what's going on there.

For example, in this particular case, the decoder should report an error when
it cannot decode the insn instead of emulating a totally different insn...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

