Return-Path: <linux-kernel+bounces-760521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC331B1EC60
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC9F189DC6B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B04551022;
	Fri,  8 Aug 2025 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="L+EsLG9Q"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB1B280004;
	Fri,  8 Aug 2025 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668197; cv=none; b=mNqZIyUS/kPMA3Bdd7v3002LR/Z53po6IEoZJ6/7O57VE0o+daSXa2MZRqKBfzrNmmsbSgB4JVprLcsRwUHYq7O5C/A9fSUp3nQQqBpmCOwJ2iZ6BpptHNFSQSKacoSULS2XXvT2L/O2GuY4IUClANOjfMGqwZuTPZTsJzSuTrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668197; c=relaxed/simple;
	bh=Rq0M4qn2Kke/HeuAK6ANde7q4jKlLT1dbCu7lGeVEd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMqafcjqlu/SY4mS5SuxO+5LPS1JjpZeo5X48hmp01uPTA3qNcr6XXNgiKdakdent/jlETYayKXvqxL+eRosbRoVBOec80HTyHM7JCCSRNpHkKN1k824cv1G19tSnf5j+iNF6BNqREeCa1A5yOCzRWJxX2xeUyd/r6HWp1srQ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=L+EsLG9Q; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id E0E9B485AD;
	Fri,  8 Aug 2025 18:49:53 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 63773485EF;
	Fri,  8 Aug 2025 18:49:53 +0300 (EEST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id C524E1FF6C2;
	Fri,  8 Aug 2025 18:49:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1754668193;
	bh=1TpnNQLScJc2Itv09Mw/jSyfwY6OaBIbVEpAdmP8cxU=;
	h=Received:From:Subject:To;
	b=L+EsLG9Q2S4fwuVevN6/eAlBxDMpR5RsmxW5Z5Ob2fdbMV9gMwQsJ3lAwb2aQqSKs
	 8Y+4iizNjL+XSBQIqR4pA4m/YubwS8ndmk+9SXc5iz8h+/gDDJS5B3UOpBNADj8opI
	 zs+yA6QDM5S/hHqU0cmel95XzA7ojmZ862ErvWtFJPwaQSEWR0KmBP9KHnu6PAXUQy
	 NYG0B99tBk1PJrd/DHIHxR0SDW3TGbN2zPm6d0wMLhBNyPrj73pggKq9efuBKVlQRF
	 ZICV7LUQzC0Cb8nq08X8mxGCeTLRvvIDu0DmPZYxyE1dTfZTCild3IIesdfVT+Rb8a
	 q4z9Zhv4ovxiw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.172) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f172.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-3324e2e6f54so30730951fa.1;
        Fri, 08 Aug 2025 08:49:52 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzlf/cdi0tEvcWfhrOrbLjI0NASeAV/g+s1NHwS9HDFH2Zu7l0p
	zzU9gzFe8HyHE8DbOoBiXzJN28ehpPY3N1rh+z4bZqevkiF88FzVOWaDZm2rCJay11QX0QDnIoP
	2iQhw07SgzrdO4Q3v9hsS0qwxrPLv4i0=
X-Google-Smtp-Source: 
 AGHT+IE+/V9yuzFsLUKHmcIJSWERnL8+YY+VtehALmxazqBBqQ41AUVlv5ItuFMl4n3Viu2w3jq/L4XJd10EjM+98IE=
X-Received: by 2002:a05:651c:1a0a:b0:32b:4932:d5ad with SMTP id
 38308e7fff4ca-333a263c9aemr10295201fa.10.1754668192302; Fri, 08 Aug 2025
 08:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808154710.8981-1-lkml@antheas.dev>
In-Reply-To: <20250808154710.8981-1-lkml@antheas.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 8 Aug 2025 17:49:41 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwE-Bw2zN5G24ArW9dJ1d=Q5_NLYWWCBmQRfu1zqUN8Qpg@mail.gmail.com>
X-Gm-Features: Ac12FXwFwrWcZzUqTbvaI0hHBN_tIA4j0Vh9Vf39brvFTjVZeu_eiywX-T6U3W8
Message-ID: 
 <CAGwozwE-Bw2zN5G24ArW9dJ1d=Q5_NLYWWCBmQRfu1zqUN8Qpg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] platform/x86: asus-wmi: Remove extra keys from
 ignore_key_wlan quirk
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Corentin Chary <corentin.chary@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>, Mathieu Fenniak <mathieu@fenniak.net>,
 Hans de Goede <hansg@kernel.org>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <175466819297.1699872.2965947503286872788@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.0.9 at linux3247.grserver.gr
X-Virus-Status: Clean

Also cc'd Mathieu on this one. Would be good to verify my assessment
is correct. I asked two other Duo users while making the patch.

Antheas

On Fri, 8 Aug 2025 at 17:48, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> Currently, the ignore_key_wlan quirk applies to keycodes 0x5D, 0x5E, and
> 0x5F. However, the relevant code for the Asus Zenbook Duo is only 0x5F.
> Since this code is emitted by other Asus devices, such as from the Z13
> for its ROG button, remove the extra codes before expanding the quirk.
>
> For the Duo devices, which are the only ones that use this quirk, there
> should be no effect.
>
> Fixes: 9286dfd5735b ("platform/x86: asus-wmi: Fix spurious rfkill on UX8406MA")
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/asus-nb-wmi.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index f84c3d03c1de..e6726be5890e 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -655,8 +655,6 @@ static void asus_nb_wmi_key_filter(struct asus_wmi_driver *asus_wmi, int *code,
>                 if (atkbd_reports_vol_keys)
>                         *code = ASUS_WMI_KEY_IGNORE;
>                 break;
> -       case 0x5D: /* Wireless console Toggle */
> -       case 0x5E: /* Wireless console Enable */
>         case 0x5F: /* Wireless console Disable */
>                 if (quirks->ignore_key_wlan)
>                         *code = ASUS_WMI_KEY_IGNORE;
>
> base-commit: 186f3edfdd41f2ae87fc40a9ccba52a3bf930994
> --
> 2.50.1
>
>


