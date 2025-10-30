Return-Path: <linux-kernel+bounces-877414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D50E4C1E0FB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B874F4E0F46
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48312DF126;
	Thu, 30 Oct 2025 01:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jeffgeerling.com header.i=@jeffgeerling.com header.b="E5jYTwwU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cjsBhfss"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F8A2DEA7E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789316; cv=none; b=svcW8rZFNRTIgWfliT6QOactk3RwVc92RwxSk+w312UK0A+1/TuWzen5d2AKbwZQE7Ydzi0vpeSGY5N8Uw0AyQKbWA3kwDvIgAL+VUiR5a1tDmrSklXhH7o90gGjTLJw8NTMpzgan/UOqzUO2IfLltwe6y8m1WF52/QcDK17uOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789316; c=relaxed/simple;
	bh=2/zykyKf/QYnxK3h3rexy4kv1cLs2qf/4P9kRXprOik=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KLz/nqktiheNFEo6S+TgVFPgGnsmFvKNwbdIWK/k9VNEks1PhsMvDfseFhRvX9ThZzf/hUlt337Ns9EtAZvfHFCD2xOpJWgnKc5SLiUg4a0GG3DB1Km1iadYsHgNsOZjUkpfzKl6a6P502YOvo2SuygADtgOyyCb2HiSH8g/9RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffgeerling.com; spf=pass smtp.mailfrom=jeffgeerling.com; dkim=pass (2048-bit key) header.d=jeffgeerling.com header.i=@jeffgeerling.com header.b=E5jYTwwU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cjsBhfss; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffgeerling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jeffgeerling.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 84013EC0169;
	Wed, 29 Oct 2025 21:55:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 29 Oct 2025 21:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	jeffgeerling.com; h=cc:cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1761789313; x=1761875713; bh=w+DZY/7oOKw/rQOX4sQIf
	1LjctoWQQr2OLZSbKfwR7s=; b=E5jYTwwU4UG28ThP+GtPeUAs4KSv91yYEchd9
	i9LGymUYp9Ulp1EsWa9GXqpjQ06Y7LTB0+t2h2DHLoG01h8ItKpUfMI/bESqQZMj
	y1d1jqexdMC1iyOhHRlRCnaqzlmiDk6S794nwRzSUT8sGDAilmhbEUiZVctPXYMF
	/yj0oJeF52x25EN61mVvo+zxlgLcAYbcso0W66JqzN125v3TgQ6C0RfFqq9EF/de
	cwXW//EMycYoLs20PcQUlBX16koxrhKo4E/OSH+o8pQm5isZB+kpZMXTsnloQUxG
	vYgv9k1QR09zchG1bjvbmVYdkQus70dezfUmISHskStBhYAuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761789313; x=
	1761875713; bh=w+DZY/7oOKw/rQOX4sQIf1LjctoWQQr2OLZSbKfwR7s=; b=c
	jsBhfssb41c6vezECDq0FtUHQxQc3AhEw0cI0PiIaY/kCtCJgSxRN63J3qLr3Gti
	w30b9zngZttYPtAibk5m4+65CymmQ2AiFWbKqPfY9KXAz4laq1AyolQIknCmnLzg
	wZhK6RLSEM3H5bMlb2a4V87XObOdopHs7yKEgWCF7AJQpPVUXFPHmzBZxuIOah6d
	9hdZ1qIvGwQYazFygf/gdfERkxVGWWSsDAjOhcA0Cjs5l0iBcCM0ETghNBh39Ul6
	gqy3IbTA6LNcnnCGFCRuOqOz2pA32U/bZJZ+pdadbR2E7Iw96n7Hdw28kp/bS2OM
	1/kgJs4veEaFIjedhXmFw==
X-ME-Sender: <xms:gMUCaYXB-3_MnhUbBz7MAjfDtfd9E47i5-Qk8MQJZTEeklfTEaba1w>
    <xme:gMUCacAHEoYjaZiE6hXYL0DBmvoj7EUE1uw3TJxIvkhDrUXPRwPiUnFfUpvMsqhts
    8x3kA-OaB8JDmXSJrkbn39wJQsb93s80WcAS-TLTG_zC2rqYoELLc8I>
X-ME-Received: <xmr:gMUCadfRzoGzVCanRtf2Fri9doRHUDfg9Kf2MtEdSCf0FIRNL8CWA-g-PZEYYauiN22CjUdtWvkRGed-VkM0lFTm5gOAldX2-C1RFO70EQzAab-nQ0aNtfI32w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieehfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpegtggfuhfgjffevgffkfhfvofesthhqmh
    dthhdtjeenucfhrhhomheplfgvfhhfucfivggvrhhlihhnghcuoehjvghffhesjhgvfhhf
    ghgvvghrlhhinhhgrdgtohhmqeenucggtffrrghtthgvrhhnpefgtdevvedugefggfehge
    ehvddvfffhgfelleeuueeluedtuefglefhffekieegkeenucffohhmrghinhepghhithhh
    uhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhgvfhhfsehjvghffhhgvggvrhhlihhnghdrtghomhdpnhgspghrtghpthhtohep
    udefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiihhgrnhhgiihhihhjihgvse
    gsohhstgdrrggtrdgtnhdprhgtphhtthhopeifrghnghhrrghnsegsohhstgdrrggtrdgt
    nhdprhgtphhtthhopeiihhgrnhhgjhhirghnsegsohhstgdrrggtrdgtnhdprhgtphhtth
    hopegurghnihgvlhesfhhffihllhdrtghhpdhrtghpthhtohepjhgrnhhirdhnihhkuhhl
    rgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrohgurhhighhordhvih
    hvihesihhnthgvlhdrtghomhdprhgtphhtthhopehjohhonhgrshdrlhgrhhhtihhnvghn
    sehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepthhurhhsuhhlihhnsehurh
    hsuhhlihhnrdhnvghtpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:gMUCabr1dC37ks7vDdFD0XRvFgsQLh72eplQ-1TVEDy3c7kAhtopbQ>
    <xmx:gMUCaWQs7aOzf5YpE8XE2EEF3WXug1MD_tW5A070n5WPoBrPpYrPwQ>
    <xmx:gMUCaTWOn9yY7-bUvRNgH4d8rncQhlWL3mu4I3vl5mbJ8F6WTkMA7A>
    <xmx:gMUCaTc1OnOREIBOjqs5MFdulQgx7FNjRx6LMCx4mT9-KzTuF7SElw>
    <xmx:gcUCaebA9PJaS9HFCe8FHDYl9h9gJmAT_Al5z-asHcwi__jASYVnGzPr>
Feedback-ID: i66614745:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 21:55:12 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v1] Support Intel Xe GPU dirver Porting on RISC-V
 Architecture
From: Jeff Geerling <jeff@jeffgeerling.com>
In-Reply-To: <20250715061837.2144388-1-zhangzhijie@bosc.ac.cn>
Date: Wed, 29 Oct 2025 20:55:06 -0500
Cc: wangran@bosc.ac.cn,
 zhangjian@bosc.ac.cn,
 daniel@ffwll.ch,
 jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net,
 airlied@gmail.com,
 intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C67D4EC2-649C-4E46-A55D-8B48A31E8928@jeffgeerling.com>
References: <20250715061837.2144388-1-zhangzhijie@bosc.ac.cn>
To: zhangzhijie <zhangzhijie@bosc.ac.cn>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

+1 for this patch, as it would enable Xe on any non-x86 system.

I've successfully tested this change on Ampere and Broadcom (Raspberry =
Pi) systems.

We've been using the flag `CONFIG_VGA_CONSOLE` instead of `CONFIG_X86` =
but either should achieve the same goal. See: =
https://github.com/6by9/linux/commit/6bd4cfe79b5111986dd11a5c6e48d4a963fd7=
740

With some OSes a later Mesa version needs to be compiled to support =
newer Xe/Xe2 cards, however I've successfully tested a number of Intel =
dGPUs at this point. Sometimes setting force probe to '*' (or the =
particular GPU ID) is required, but otherwise stability is good.

For example, the A750: =
https://github.com/geerlingguy/raspberry-pi-pcie-devices/issues/510#issuec=
omment-3383284831

> On Jul 15, 2025, at 1:18=E2=80=AFAM, zhangzhijie =
<zhangzhijie@bosc.ac.cn> wrote:
>=20
>    inb/outb speccial wire not support on other ARCH.
> Should detect whether arch platform support or not.
>=20
> Signed-off-by: zhangzhijie <zhangzhijie@bosc.ac.cn>
> ---
> drivers/gpu/drm/i915/display/intel_vga.c | 4 ++++
> 1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_vga.c =
b/drivers/gpu/drm/i915/display/intel_vga.c
> index 4b98833bfa8c..5e48e3282670 100644
> --- a/drivers/gpu/drm/i915/display/intel_vga.c
> +++ b/drivers/gpu/drm/i915/display/intel_vga.c
> @@ -33,6 +33,7 @@ void intel_vga_disable(struct drm_i915_private =
*dev_priv)
> if (intel_de_read(dev_priv, vga_reg) & VGA_DISP_DISABLE)
> return;
>=20
> +#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
> /* WaEnableVGAAccessThroughIOPort:ctg,elk,ilk,snb,ivb,vlv,hsw */
> vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
> outb(0x01, VGA_SEQ_I);
> @@ -40,6 +41,7 @@ void intel_vga_disable(struct drm_i915_private =
*dev_priv)
> outb(sr1 | VGA_SR01_SCREEN_OFF, VGA_SEQ_D);
> vga_put(pdev, VGA_RSRC_LEGACY_IO);
> udelay(300);
> +#endif
>=20
> intel_de_write(dev_priv, vga_reg, VGA_DISP_DISABLE);
> intel_de_posting_read(dev_priv, vga_reg);
> @@ -80,6 +82,7 @@ void intel_vga_redisable(struct drm_i915_private =
*i915)
>=20
> void intel_vga_reset_io_mem(struct drm_i915_private *i915)
> {
> +#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
> struct pci_dev *pdev =3D to_pci_dev(i915->drm.dev);
>=20
> /*
> @@ -95,6 +98,7 @@ void intel_vga_reset_io_mem(struct drm_i915_private =
*i915)
> vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
> outb(inb(VGA_MIS_R), VGA_MIS_W);
> vga_put(pdev, VGA_RSRC_LEGACY_IO);
> +#endif
> }
>=20
> int intel_vga_register(struct drm_i915_private *i915)
> --=20
> 2.34.1
>=20
>=20


