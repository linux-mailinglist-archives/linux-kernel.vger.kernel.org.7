Return-Path: <linux-kernel+bounces-863666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 239D6BF8C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9701019A7D42
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D554A27FD49;
	Tue, 21 Oct 2025 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="r2CVWWUu"
Received: from sonic308-9.consmr.mail.ne1.yahoo.com (sonic308-9.consmr.mail.ne1.yahoo.com [66.163.187.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BAF280025
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079389; cv=none; b=ojBzZFCWnYTbC7bBhmjJ8kxyG4am4KmaSnsjIds3mPTMSnNsFSFkycA956F4syEjkiYuJ+g6cl8qVJdvP0XUwqsZr2FK9FVSF9O1fjolmRmrYMruQeSlKY3db7KDSTGkSHYVSIwURw213gdBzDV+PPfNXAsuoKlLDppqKYjhrJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079389; c=relaxed/simple;
	bh=XlqfIXuaMRD0eFhOGou17ZQR3uRj8Whl02Jp5BzhT5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiXDMn/glressa3GFD8PaQXpVQfxYRPuW9mphxiQsyEe84K5RXPKJ12nYT4EcNw5ck6Z+hBU2nIsaePEjDn42+5ven6/ij9FnV/bTTCdRVORvEvxO/Ydn4S+V7Pq+UW2rK+hAcrAUPfrEbvi0WCi73VpyOzBvdwIoBeULJL+0zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=r2CVWWUu; arc=none smtp.client-ip=66.163.187.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761079378; bh=+qU2vcN541UGYB33IHwPZz2xTN7BvKjf4TwHbds2f04=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=r2CVWWUu7Pi0XCYFTUTq40/7/bE1t5jPDfoi5vVV01eQ9V/wVDE1Ucgxn52K7cz/6BZEJwrCPS3g3FpKuS7MINxL00rtzVCtWmOOR81TnjrkO41VpPpEMrIfHclxIggtEWi+t/xiuJXi6W72XM1ptKeycEykYPqU/LYircBCJ9sbfUxTf3WnqY7gxoz83tK0LrXNSYx01EHErakXQ8z6kjPZrhXX2LmR+AqgWMRLrXLeoOtLKV/tsCrEqsQmavu8Ca+rxbdawJK3e75YkJQtCGZZq+/Lu9m2mg40y2kIH509KI6tdyE8so1OLjR3ZaG8M4Vm5+evfX9EY2zaKjW/Bg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761079378; bh=gy3nSjXqB4obiSFjmrWmHLXG23AIMSjGdqQtLZNiINx=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=OwaYZFyEA7CM85NlPKMusnSmb9FG6PhH+vq9lWlXNrUwALGohg5zQC98VEqTKgB/6C0B6h7KwVixXHbhW1IElmDgX6CPMGD2u76II4c3zFVFqmkMbBmasv8kf7IUPPHHfUEKMwO3W2lK87lytXwXDq6dEbg8wlG7TDg/V4azvlccIQHKZrtkKdbRBSHlEVorkoTywqPbtCmxzEq18L7IGm0/tJS7s+3kGbUEV07bFfDYxbsRozrjhJrepzQDqlIVOTs3B12YLecGpiKKqKwYjIjyRBmcBu7C0pj1a9BJS3h2DFp/no3FgEg6e8Dtxx0kIhCKirGFl4GlYzuy2qKIMA==
X-YMail-OSG: 4xvKBJMVM1kehxOE8bOYQU15B.LpwrJNx.kBwYcopwuPmyUgUIV86fLx53VYQGr
 5RxWOf95G5VqewfQmNu5lUu.ipsxHP7og8xLnwuwlvU5t42b09cGctI1h5EzDo7X89x8JFJPPc84
 rTd22QuYAjGlN5TnQqe08WJhksMFF5olIljVYhX8sdqIDKlv34qtWxGtFKOO9iuNVQTVZL39o4Zx
 RBJPTEq7UJAjmaAkvQuyIM9g_GECnudTPVACq5boyytdjzUfNnviSV2lR9GFVPlIPqZaB1QP26Y3
 9aKtcWEsGh_qIZfgaGWXXTLds9EKvcWjmpHcmd8bLTLFTvyBX57x_jTebfzopMTbKT3c8wKxIWcG
 ciFwpQOwuvmYnQZWDJiKUsL1IOSalrCiM8SswSlbUZNO7hVJEqMsgpfzE7WpIX2HGai0DQoptEo9
 7DYt74TIbeJo8UyRXEIYc.7mOOa3ZKA_OER6h2ZCbQk5Z_p8d03RuB_xXfJdWOQ_AnCNk_MLquf.
 pVzBp12xrm9Bk55YCJoY6BaYOVWLRzZAITN1efdgHl9jd4PvaIrgjsSdIPB6_mvtab7LCF.WGLW7
 LmNb.L687BaGjw6TlhZhC7I5U6SVTHwFKow8gBaQCeClqG7R81Dn6.z8j9erIrfEI_yJnQITM0eM
 ddXMmKrc9hx5PsQ1tYUSvrevkKMJaiEepglu2blseU.UBTBU0O1pzlgLCyZ8Lk2Q.IMTSx_uUSIr
 DeGJTGfKwhmBT9E17pPZB50L35J5t6ZBFTTPdjHYZui3Xg_cAZITHXnoC7YgSOzlYOxp71csKjj6
 QiL.9cqCWuuErOL20VAuakyohs9fBvwq3kOWXMK2iFXUONvukFZsXp6Sh0GKkpBzNA_UlvyVlQvb
 o931TKmI7VMKi7fajgZjY8FmPNvq.ZTNduiMIU_Qa65oAecTUg5HmLfFpm4P3yzhPJIwwkn1_zw9
 hnQNKwOrvReimCZKqM75atDYJLNJASIKaZp90G8ahu7bUcDKb2Meah048b67t5YB1x1SYfHEOIdb
 80xRFAnpfTWq2V27hzwp.4QNjp27KGGY579NJKKbBVopGMjJm3R1s0sD2NOgaKJmFrDxA7pVmRCW
 Hmb7yFflJtm7dtPFoyaQY5HGuLzFCbDpyQj7xuI24cI2hVd8bEn_ASuJYgRSOGOp4E6zIKFPEJ2.
 mZlRURUvcesV4ligy9q5V92AJSm5SkwV3T3rwwiYvXt4RVcOEBiGwRFgnMg3NRk6XVgkObXGcBgw
 x1eBEEDqaVkbvfPFgHrV92HRO5JZWy4wJgcE2s0rhGg_yhrmHPpLpnqxu8tSrkh0SPTgS17NQ8pp
 DamNQCONkWbjISGzpvbVN4jgeFUWQMXVFDrONeAZlof6hWCqLHWiOxA_rP07rjPe8R.1koGoA94W
 zerFZI.tCttnGznA4M0gTPhhVTc76Bqg5p5jvY6lX1G65yjZxcx4uUaQ0WQ1sTd71eeKCYZcA7SN
 I_Xr3.ZreCHRbhOsLpQ0P_dEBTxJelOSSVBjklCaGa049dKdA0o2Ir31vWxN0e_vraLUsD0_SOlX
 .IwZqypZZZJ7UlZ3XZE9C_atW6dKsSKWl.ye3WjhtL.nCx8vfRpRGTsME8T4NtuF49JGC.uqooPa
 doDhq.EMv6VnjHY8fCq_2WdRNYEu6LK1IKE5xoe16rUORkOwVi_f9jJFNXFzZ2j58Sgl0.Y7p6pk
 p31NbtG873dCMsDFW3qdYOhMJw2mviMMa6ZSXXMypphJbVqAB4JhgshYBOXAB1ENc9EYI3eQiaz.
 Vepl5z7FEXUuwE7NrD5MUYiCXvG1i3qKup5QahRlZyem_vF_KI.fh5Vi7mRbE.JU7hX5z83thwAj
 Gl6KgCU6OlVL.eqsqZYv1GEvW3nywc9ZLmXh06PopwBZHCEximekXhpSbVxK0LCl7Yml.nNdUp0u
 yedjo7k7lsEGzQhOKQD_VM5u0KKUxXB_Hve6Mr_HW1EjwKolOmp.izvNkdG4V33PIQsPL8fjpJBd
 5pAeZb.wsp7GKDvo_46VC7ilCVDP98D4Vztt9i7Jz_6aBQDUGcVsFD.KGukUDJR4vOFcMcwvqrtR
 cqPhq_W5TIx_W.OOf_tiBzi2O.k_DHBSaqPZ8Nbbcz4eERi7An7B83Dey.4XxCx07afZ5FYuh4AX
 SOkwcI5Uk.U7MTHdr8MhwpAESH0D5tQH.PJsBIOXM6j7XXjQjeJf_BgOv01qCzhOlVVzkKEjQPUh
 woB3kAEMKl5.P8iNS8HeTYKsWAgvDPzMH4iTlZbbsXrsY8ilQ6DJnijBxagi6kGKIIFvZ_C10j5C
 i2vj0L3E7QYlxWYVEVVgT9kQ6wuYr7rkN2ORkfG9g
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: f67d61b1-ada2-42a2-8af5-224d50fac4d8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 Oct 2025 20:42:58 +0000
Received: by hermes--production-bf1-554b85575-dfm4w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5ac397cd68ad3abcccfcc5e9735fbabb;
          Tue, 21 Oct 2025 20:22:41 +0000 (UTC)
Message-ID: <0e93a7f9-ae77-471a-b14d-2626cca0fb0e@yahoo.com>
Date: Tue, 21 Oct 2025 21:22:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: rename drm_ioctl_flags() to drm_ioctl_get_flags() to
 fix kernel-doc name conflict
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20251010002520.359824-1-adelodunolaoluwa.ref@yahoo.com>
 <20251010002520.359824-1-adelodunolaoluwa@yahoo.com>
Content-Language: en-US
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
In-Reply-To: <20251010002520.359824-1-adelodunolaoluwa@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/10/25 01:25, Sunday Adelodun wrote:
> The function `drm_ioctl_flags()` defined in `drm_ioctl.c` shares the same
> identifier name as the `enum drm_ioctl_flags` defined in
> `drm_ioctl.h`. Although this naming overlap is perfectly valid in C —
> since functions and enumerations exist in separate namespaces and do
> not affect compilation or linkage — it causes a symbol collision in the
> kernel-doc build system.
>
> During `make htmldocs`, Sphinx reports the following warning:
>    ./Documentation/gpu/drm-uapi:574: ./drivers/gpu/drm/drm_ioctl.c:915:
>    WARNING: Duplicate C declaration, also defined at gpu/drm-uapi:69.
>    Declaration is '.. c:function::
>    bool drm_ioctl_flags (unsigned int nr, unsigned int *flags)'.
>
> This happens because kernel-doc processes both identifiers (the enum and
> the function) under the same name, leading to a duplicate symbol entry
> in the generated documentation index. The build system therefore treats
> them as conflicting declarations, even though they represent different
> entities in code.
>
> To resolve this, the function has been renamed to
> `drm_ioctl_get_flags()`, which both removes the naming collision and
> better describes the function’s purpose—retrieving ioctl permission
> flags associated with a given command number.
>
> All affected references have been updated accordingly in:
>    - `drivers/gpu/drm/drm_ioctl.c`
>    - `drivers/gpu/drm/vmwgfx/vmwgfx_drv.c`
>    - `include/drm/drm_ioctl.h`
>
> No other symbols or behavior are modified.
>
> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
> ---
>   drivers/gpu/drm/drm_ioctl.c         | 6 +++---
>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 2 +-
>   include/drm/drm_ioctl.h             | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index f593dc569d31..313e8bb7986a 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -912,7 +912,7 @@ long drm_ioctl(struct file *filp,
>   EXPORT_SYMBOL(drm_ioctl);
>   
>   /**
> - * drm_ioctl_flags - Check for core ioctl and return ioctl permission flags
> + * drm_ioctl_get_flags - Check for core ioctl and return ioctl permission flags
>    * @nr: ioctl number
>    * @flags: where to return the ioctl permission flags
>    *
> @@ -923,7 +923,7 @@ EXPORT_SYMBOL(drm_ioctl);
>    * Returns:
>    * True if the @nr corresponds to a DRM core ioctl number, false otherwise.
>    */
> -bool drm_ioctl_flags(unsigned int nr, unsigned int *flags)
> +bool drm_ioctl_get_flags(unsigned int nr, unsigned int *flags)
>   {
>   	if (nr >= DRM_COMMAND_BASE && nr < DRM_COMMAND_END)
>   		return false;
> @@ -935,4 +935,4 @@ bool drm_ioctl_flags(unsigned int nr, unsigned int *flags)
>   	*flags = drm_ioctls[nr].flags;
>   	return true;
>   }
> -EXPORT_SYMBOL(drm_ioctl_flags);
> +EXPORT_SYMBOL(drm_ioctl_get_flags);
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index 8ff958d119be..fa4644067d46 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -1257,7 +1257,7 @@ static long vmw_generic_ioctl(struct file *filp, unsigned int cmd,
>   			goto out_io_encoding;
>   
>   		flags = ioctl->flags;
> -	} else if (!drm_ioctl_flags(nr, &flags))
> +	} else if (!drm_ioctl_get_flags(nr, &flags))
>   		return -EINVAL;
>   
>   	return ioctl_func(filp, cmd, arg);
> diff --git a/include/drm/drm_ioctl.h b/include/drm/drm_ioctl.h
> index 171760b6c4a1..585dda7550b0 100644
> --- a/include/drm/drm_ioctl.h
> +++ b/include/drm/drm_ioctl.h
> @@ -164,7 +164,7 @@ long drm_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>   /* Let drm_compat_ioctl be assigned to .compat_ioctl unconditionally */
>   #define drm_compat_ioctl NULL
>   #endif
> -bool drm_ioctl_flags(unsigned int nr, unsigned int *flags);
> +bool drm_ioctl_get_flags(unsigned int nr, unsigned int *flags);
>   
>   int drm_noop(struct drm_device *dev, void *data,
>   	     struct drm_file *file_priv);

Hi all,

Just a gentle ping on this patch,
please let me know if there’s any feedback or further changes needed.

Thanks,
Sunday


