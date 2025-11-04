Return-Path: <linux-kernel+bounces-884201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E490C2F995
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33EC423B28
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504CB304984;
	Tue,  4 Nov 2025 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="NJGvQ1Qc"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD92305957;
	Tue,  4 Nov 2025 07:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241041; cv=none; b=mBU4KNZ5O+XLHLwx00ZBPMYOavb8n/afSy+dB+kKJHtOJsctQWUqcb6HzyDtb2zIE5qjjlB7NZnAmMylbPO9cHkM9IQL4TjnKo/loURoMfBp1+Cx/BlobLk5FuyjsUr01fvFsGN9tope1bNIWSLQbyzIX6d+Blbz9gs4ju3lqY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241041; c=relaxed/simple;
	bh=Z+8z2TtIfZ6CF/p3Szhi45qmytqVLySL7vXcNECjlmg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iByCq05AvLhXuVIgIgGMDwaXizi/3APogF2jLq6tP0ACrpYGM4rk2skZL3JZNKsA4vvUce+oiT4R66VqJRZ4BeOAYiFv8jLD9gLKrIstwsrJSbOqKNGFPxExmgh0ZvwxPqxeXoOV41a97jT0jXUzAPyss3KyoWgpEiloty56Bg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=NJGvQ1Qc; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=T4riu+PinaG5BryGjBVvoVIR9LnCCKl8rwgqgPWiAbc=; t=1762241037;
	x=1762845837; b=NJGvQ1QcEwuVymj5THfpHpf8irbPAtd+rDoTyWtHaHs/4eJcA5C7x1L5hjfJ/
	Bqa+6geybfqgWI9zmzqvoaDzXxJFQUaAndotli1hsq18zsqejLJS8t9WhA2zt4qmKpXCKMCuzRblV
	xE7Ojj6Eckf91FxNB6Q73bSPma1IQwfrWQvYeLVJL0yR24dMpl+dvPB0Rvy9OU5hHh21ncRCnEQ7k
	1aPCS2bI9WvpEOw1VitWeyVF16JoqQ86eu0z162OUyYHYYw4uaux9CyJIxyA97CCSmP/Ken2WSShs
	umF/o3ejnvFoW8EhTFYOYH/D2TLnZbJ5AqLe851Aw5RSooGdKA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vGBOP-00000000iJU-2MFO; Tue, 04 Nov 2025 08:23:49 +0100
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vGBOP-00000002VTF-1ZME; Tue, 04 Nov 2025 08:23:49 +0100
Message-ID: <0ba150517e0fd331f1227e068fd37e6e6ea42228.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] Alpha: MAINTAINERS
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, mattst88@gmail.com, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 04 Nov 2025 08:23:48 +0100
In-Reply-To: <20251103213656.25912-1-linmag7@gmail.com>
References: <20251103213656.25912-1-linmag7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Magnus,

On Mon, 2025-11-03 at 22:23 +0100, Magnus Lindholm wrote:
> Add Magnus Lindholm to MAINTAINERS (Alpha port)

I think this message should be in the subject of your patch mail.

Did you use git-send-email to send this patch? If not, you should set it up=
.

I recommend this workflow:

https://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-first-pat=
ch-to-the-linux-kernel-and-responding-to-feedback/

Adrian

> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46bd8e033042..49ada25357e7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -915,6 +915,7 @@ F:	drivers/staging/media/sunxi/cedrus/
>  ALPHA PORT
>  M:	Richard Henderson <richard.henderson@linaro.org>
>  M:	Matt Turner <mattst88@gmail.com>
> +M:	Magnus Lindholm <linmag7@gmail.com>
>  L:	linux-alpha@vger.kernel.org
>  S:	Odd Fixes
>  F:	arch/alpha/

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

