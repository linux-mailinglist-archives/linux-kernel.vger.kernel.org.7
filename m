Return-Path: <linux-kernel+bounces-762758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C3FB20AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4012A4D55
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA2B1BCA1C;
	Mon, 11 Aug 2025 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="KxR+jFMl"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19090188713
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920136; cv=none; b=Yr/aeFiRoiOwabYjzA1WAr11WJqSeKqCSBQsY6zdufxoJ/oTtYuzLdzQ3Bz27HK7eQ0kf8Oa+/FjiZTw/C427V8D7lhwVwGKrApqVAO4p36VhloVlgFBb66wjLBs2nc4WtcbIGEFHWn+9EPxSZxyPAZw14SPOxLB/V09XHuMNKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920136; c=relaxed/simple;
	bh=UKSmwahiogqW1pXeYgXf8Eygszt2u88JnqRx0xZfhNE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CJvzRVTKgGhK7KkW9EUSf0J5mgTBCtc0umZeZRdPVngPXTnZQIjvhWt/IPM7+7/mGtEyKTMYP0Nh3ukQBJaXsW0vA8Sp+mUsQWn2RF8iGkwL3PGbUob9/e4h3J0WNtlZBmDZsS4VH8bb+bptZGlrc1TKmrFceQtJfI4Zen0x9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=KxR+jFMl; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-7075bcdbb0fso25443306d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1754920133; x=1755524933; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VWV2hjLplr0Slgw9ppK6HuD7SF+ufb5rfXPdExiThcw=;
        b=KxR+jFMl7g9MOP7OQkT8K39aZxS38oEgAzwBVrLJNvPwl5RvbiOGs3D2XdlcsNyrvo
         Sa8g5Xo5r3TTYHbzAXqHhb/Pqtb97nTgnS+c4LGQYvg3yf0r88cmVIwDswJhHIviesyo
         7TGALZ3txQEhwxQbMDwirB3hN9cq0599NfVQ+8oNTWMIjgux+r+2qBOsAphNxZJULfyc
         yQonSR2JKLgn6OCsznmzfi6QnctjKhjyAfvpXM0Qw+rB5ix+xpHrjO7b5fBvbN46Nwc2
         ZatVxIap0aatIEmpcrEpRTWmGYZfMls+4mE5otYq6FYzWGbqRFOracjGD9mulyWH0vGs
         g6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920133; x=1755524933;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWV2hjLplr0Slgw9ppK6HuD7SF+ufb5rfXPdExiThcw=;
        b=XDzyShD6ZZ9rEzpcqHVT5y6gmZqKRbCLXnvEjLE8UvPd0/zA5tIMjYxXzPI2Fc6odi
         KdkEWB2EKnSBTSbOZETC1xfbS7zKxeypvLFMWwbU+n2+OjH/cmFEUraltBXHdPOxSUdf
         tHzsSB3TQrImErFMuanQVDGfqutyFzUhKRAh70xI2SDYhr5Vafl+C937Usq/vAza9SiT
         hyvWM/VkRiBWdQJMtn5eX8tiYtvEq4TRthnq/Dj0fPmWZlTns9ZFCCU2XuXhrIzX664r
         8biEShhN02eUFq7XZP6MhzuXdvERyVP2/W4xDbCq/FvUL9//Py2w/HnkOiTuQF0KXVvP
         490w==
X-Forwarded-Encrypted: i=1; AJvYcCX0LKP5UAP8hG/u+8yzoCBc+v2vi/rfZsPD6/iL4haO6Mm8lH+TvBNEVMYMPNSDgJxQZHurj3AO1lm5Na8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD4t+MqJEiMMr6u5FgbojYM9K+HmKU3l+nQcsgFglz5y2uXqZz
	ZSDBxVlKGswLjnfVYBlfLYY0fckcacDWsCY5Bqebe/i9JhESk+bDrExqiQnnLZInEtI=
X-Gm-Gg: ASbGncvSCejJoECI7vWE2nE7OA1dTX12xXzgJG01EDzLYFzM+BrLwRtjnj7ZDhmfpmB
	kTRcnoTuXJmiv1myRKxGIwoshHQqlRzLFZBlei6hzqlBm6fXle48bvxvdXy92SGXHF7YL1zWoAT
	Vp7hO/kgEGSHWUIZDLL6hpk27Cfvv929iSFO3j8HgqpyLFIIR0HeNP/n5JKRndOGYulOfjPubc/
	o+zZFk7ffnNSwN26IQMpvliWDgYvc8awE6Tywu1stujW1AX9dF2wRJ1SayzPjIRi8dpDc3oh3DX
	AwNYGZqbCjR3PqQE06HWA6XnicdQlhSenrh7rrh62PJdLogCv92JRJRuHtMiJzM2tMvYQlCwn43
	Y0QjMtlcxalgbBeHlnm+qdIdAr1Y=
X-Google-Smtp-Source: AGHT+IGWo1UxGtBJWVYSzxpvE5ZF5/dBz2Is5MsjfG1C/pxYl+/rzztidkfAyi1zkWZdsKT8xJCVpw==
X-Received: by 2002:a05:6214:2466:b0:6fb:1c3:f527 with SMTP id 6a1803df08f44-7099a4833a2mr205043136d6.39.1754920132919;
        Mon, 11 Aug 2025 06:48:52 -0700 (PDT)
Received: from ?IPv6:2606:6d00:11:5a76::c41? ([2606:6d00:11:5a76::c41])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cd89d8dsm156083316d6.53.2025.08.11.06.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:48:51 -0700 (PDT)
Message-ID: <9b86fb9ac5b9cfdb773fef2db33fc13d011f53f4.camel@ndufresne.ca>
Subject: Re: [PATCH 64/80] media: rkvdec: Remove redundant
 pm_runtime_mark_last_busy() calls
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, Ezequiel Garcia	
 <ezequiel@vanguardiasur.com.ar>, Mauro Carvalho Chehab
 <mchehab@kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Mon, 11 Aug 2025 09:48:50 -0400
In-Reply-To: <20250704075450.3221972-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
	 <20250704075450.3221972-1-sakari.ailus@linux.intel.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0MU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAY29sbGFib3JhLmNvbT6ImQQTFg
 oAQQIbAwULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBO8NUoEVxMPCGgRvEtlBlFEpYHL0BQJ
 oLLLGBQkJZfd1AAoJENlBlFEpYHL0BEkA/3qkWYt99myYFSmTJUF8UB/7OroEm3vr1HRqXeQe9Qp2
 AP0bsoAe6KjEPa/pJfuJ2khrOPPHxvyt/PBNbI5BYcIABLQnTmljb2xhcyBEdWZyZXNuZSA8bmljb
 2xhc0BuZHVmcmVzbmUuY2E+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQ
 TvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyy+AUJCWX3dQAKCRDZQZRRKWBy9FJ5AQCNy8SX8DpHbLa
 cy58vgDwyIpB89mok9eWGGejY9mqpRwEAhHzs+/n5xlVlM3bqy1yHnAzJqVwqBE1D0jG0a9V6VQI=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-mWE7/NTeJOJLJAFXEhhw"
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-mWE7/NTeJOJLJAFXEhhw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

Le vendredi 04 juillet 2025 =C3=A0 10:54 +0300, Sakari Ailus a =C3=A9crit=
=C2=A0:
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
>=20
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> The cover letter of the set can be found here
> <URL:
> https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@li=
nux.i
> ntel.com>.
>=20
> In brief, this patch depends on PM runtime patches adding marking the las=
t
> busy timestamp in autosuspend related functions. The patches are here, on
> rc2:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git://git.kernel.org/pub/scm/l=
inux/kernel/git/rafael/linux-pm.git \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 pm-runtime-6.17-rc1
>=20
> =C2=A0drivers/staging/media/rkvdec/rkvdec.c | 1 -

This driver was de-stage during 6.17, I will port it, no action required.

Nicolas

> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c
> b/drivers/staging/media/rkvdec/rkvdec.c
> index d707088ec0dc..445f7c92eee3 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -765,7 +765,6 @@ static void rkvdec_job_finish(struct rkvdec_ctx *ctx,
> =C2=A0{
> =C2=A0	struct rkvdec_dev *rkvdec =3D ctx->dev;
> =C2=A0
> -	pm_runtime_mark_last_busy(rkvdec->dev);
> =C2=A0	pm_runtime_put_autosuspend(rkvdec->dev);
> =C2=A0	rkvdec_job_finish_no_pm(ctx, result);
> =C2=A0}

--=-mWE7/NTeJOJLJAFXEhhw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaJn0wgAKCRDZQZRRKWBy
9DLPAQCqPt0lXZfnbdVvPntu1sqxcp/kkdwbjcqoHkgLxA145AD+NS/iRHqsrNt9
OFMoxaM4XZImGCGuuAnhiF3H/IWu/AM=
=SIv5
-----END PGP SIGNATURE-----

--=-mWE7/NTeJOJLJAFXEhhw--

