Return-Path: <linux-kernel+bounces-843009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 049D6BBE310
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC4354E7E9E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AEA2D0C7B;
	Mon,  6 Oct 2025 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VO+V1ZNW"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5F920330
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759757511; cv=none; b=BKbG79sVdVt+j225NoeE3f49vgsT33NATbEyC9jIALfX0yCkJd9O5XOil9m+Jd33zljG6KCt+NUUGSlkR37N31SkFKCxj95vwn4DtEh8bl17sNw06K29nEEjZAt1gerUjNIQREUBWKLjW/AX2Jpulk3hJ1d0EaA62ymknHZ5xz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759757511; c=relaxed/simple;
	bh=DqULx7OzGhVZvldtgJDVJjS9EzOntOWcDaUYk91ctHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYOHno78dewfBn2mC44VRWgo+Qrv3h+j29minQqIyzZyX6HcPpGRBXmfFsCFC7Mr10S5Iv3l/OFflQfzMz65o8Ejq6JByDlqRR1l+0VnGFZ5AiAA+oonknbfIsZjiQ1ZtKurMxnNnHbyqu35CE8CLejLPyhiGT2Ts40LREcgqjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VO+V1ZNW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C07E540E00DE;
	Mon,  6 Oct 2025 13:31:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3eJ9uyeo1yOA; Mon,  6 Oct 2025 13:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1759757503; bh=uLzs6Q1ZS9QMR/ROOs/UFruOdJjpboa8xAlFKS9dyt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VO+V1ZNWQvvaa5LPaItvre0UGlO39hzdnvY69Qsk+lQdg9hIaWiVFI8NHaIJ0gIan
	 JVQG7Z3k3CSKJV9u+y++up5J5u9Xrl/AXdsLjHSI3CJanROCv5XnPEQDoxpVu1lwo3
	 zTct6AlO+EH71WsstKmFi/WUKx/jPo7m2+KVuSeYs0YPlTUUS9GKvuuEnG3irILxVQ
	 rWesGnC1RIWYALmgdz4AAwezouz/8ie+Fn8sSHFROMRSSKQPPrpLxnp73fyL2oejBF
	 BizsR1zjZldtbp9pD1daq3BboeV7Q7DmGLIzvr6bF50Ctavf3NEGzYnLcwhZDtneV7
	 btBlgy1uQHceamfH69bypPnTWr27vLf7goai7oa+fufT93htpcNa6awiw7gaRFohEz
	 fFjyc0U+kwzOrXH8c1U/fcM5+RS+PUzK0UG6RbpanwJIZ11KKJr2zADpXDVHpS9l2B
	 o4x+g3eIfiWlMV4Z8yUuXjJ5eTh4u32VZGXgOK5kn2SONt9nbJoQEUI96BmDovRafX
	 BpFqY/ch2f+vLLxNVgdhzVvSQPhwI+lh8KiwJbY5LxwxC+Pn8ZT7ohw33a5monnDuH
	 4ld6Y8LGMC+nK/UIbWA8XhHUc3c9bvLWe5TqRg68Uptxl/AY/Ro6yar93l099Ufo1n
	 NaY9yyc0dbbyYE7D2nKYYoOA=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E43C140E0196;
	Mon,  6 Oct 2025 13:31:33 +0000 (UTC)
Date: Mon, 6 Oct 2025 15:31:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: Rong Zhang <i@rong.moe>
Cc: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/CPU/AMD: Prevent reset reasons from being retained
 among boots
Message-ID: <20251006133128.GCaOPEsFuhJI89YG8L@fat_crate.local>
References: <20250913144245.23237-1-i@rong.moe>
 <20250916140227.GGaMlt8xSp3eMI8Veu@fat_crate.local>
 <1e07144c-da10-4817-a2c6-ea11988936ee@kernel.org>
 <a1eff492b192bbe68716b46c18cd7152951c6550.camel@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1eff492b192bbe68716b46c18cd7152951c6550.camel@rong.moe>

On Tue, Sep 30, 2025 at 06:18:30PM +0800, Rong Zhang wrote:
> A user may feel confused: Two bits are set, but only one reason is
> reported. Hmm... Is there a hidden failure?

Why would you assume that 1 set bit == 1 failure reason?

> Unless the user has read the PPR, it's hard to realize BIT(11) is
> already set in the reset value. The debug message is here to help:
> 
>    Cleared system reset reasons [0x08000800 => 0x00000800]
>                                     ^   ^         ^   ^
> 
> Now the user realizes that BIT(11) has nothing to do with reboot
> reasons.
> 
> This was literally the confusion I experienced. I had to take some time
> looking for an appropriate public PPR and reading the PPR before
> realizing this fact.

Please explain in detail what confusion you were experiencing so that we can
address it properly.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

