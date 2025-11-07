Return-Path: <linux-kernel+bounces-890772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2BAC40E50
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CB404F0A65
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035AC331A4A;
	Fri,  7 Nov 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="tSd55e3W"
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49EB26E6E5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762533054; cv=none; b=K0Fo2zaasi5X3Ih1UDW+WOXysbJyhDUNCxHDWpRAbtmtV+X5b/mIE/9ydFlMSvxsnunlBf+SF6WCNTsJshQmgFQXgKkf4wXLpwVPIPVNkc+QZJ8ZD67NPvhX2MeCslzOZc0f5Q9osRV6K9gwiKvyyqQCcXtcn0gBOm030CspxoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762533054; c=relaxed/simple;
	bh=al2zZOjy1s9k9uG0J5tQ/tOLemu8rJl5iPBRWP7bhxU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=goMUfOuHCnabECzV3lLqZUIcIeDrxc7ToS7njVi59kiPwUf70cSUWiat5bS4gIMOuZODDOUJYdQzLsrv2CWAKmBTx/oYNfkZAY/ttgEyA3wo2P4ZVoT72TIE3OX6KKKg3pKJQ4g3suwpobtLouTU6XhxBn7NyrW0nYqOuUmwFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=tSd55e3W; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-88f8f346c2cso88810485a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1762533051; x=1763137851; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AVrp19hgKD6fn901dtJIwIEFWrRkipQPPUAVv1GRELc=;
        b=tSd55e3Ww1TieEAWlgavJ36jxccyWd1wLl+BhxPRIzihrjcOyKL//Et6/RzSn8lv7t
         aMhsAzdBF0qsZoIOw1wmylm4Any9yuYWimY5q6BvTsltlpWLNvHfppEcoGnO+532r/XX
         ctzZOLGjwHFzN398rhhAM5cotqNMh6XYdWEVlrTUCVgHAoBcKzZwLpICw1Qc5qasMLjo
         AHcrDVhWf+gkIFwTDToXxs/kZ3gTtoOZKaBhjTg0AQl8Fx3Xg++6BR5hOK4QXffcZCOq
         JwpCDJiDgG9HQP1nf5jdIkek/Zn1WaAPQpe3QBCajal/zFOUS1f5HWRJRuGfQk8PtIpw
         9PwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762533051; x=1763137851;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AVrp19hgKD6fn901dtJIwIEFWrRkipQPPUAVv1GRELc=;
        b=BtSVMBSBTpo2dDLmyXF2e9Q6+fZI2iQHjeGXRNQd0Q7kVpZiF89xxcyyV4NZ23V/wy
         2JExvfi85BnrI3Y+jgw5gfKigcEKS1APTm+Tb0Z7gXtkYFtPrPzqJD0FsyANCTWB2Frx
         KVw1bEP/KzHbqIaFkQJFfJbmE4ktuqp71gtVJiI+poiJLvygswa085OTfH+fh1hazY1U
         9GvnUlrk9CLhe4Ab8unT1/7zrGT1dehlQnoJ3xv8LN7LB0zMGNrzo3H26tUkbAtDs1WW
         lSQ3+6I4pEFFFI+gN5v6abn5ReVAIUJVnJjkxfq04BrpyWUvXl4bxDK7URbOBkRCtrpN
         Y8kg==
X-Forwarded-Encrypted: i=1; AJvYcCUpVnKEqmZZKBs9QYXjT7N9kU/g2obaDxP0PIp6Dh41oLFt2B/n6EUZu6hSEw9NUFZCSOYzChFBaoECBT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxonY7WIXkaP7oNpEwXVIBoaXtRIj9PV8g6NIPictbiYFBj/5/V
	t37XaTy/SwedCjYi2QObnCdSzndbE7agl5q8Szht52JTF0vy8cvF0qzz+r9tJ28Q4s4=
X-Gm-Gg: ASbGncutHrCS7sLLdFWtgRwc8+dfqc5YEC9NGTeyvY7rCDUWIWRD3mxl2mz67P8d0Tb
	obF8kfrjBxdRkvlqinl9ysEKRWnX2rWM7/jwNBcT/koxMUaMJ6ktzM0B4HpKB7cB+h87RnC3/Uk
	cYPgc9x5Ebdk4ghIRQOj09vRhHC5Dh5dCRy4FI6r93sWTiqGzKq7yE/zukPxHxfmVYkSQZAp7GZ
	nrR0UkOw8uwBojLk4Xx7ATNmKGRBRVrOVAzKEDhc28qiZKfrvMklcVSu9XOVnjqcnNAs3dzYtQk
	rTcXXs/b9IHv+irX2afQO/j2gwjgSk5muCHzu67HOajHN3gakbETJRL37vbW1LOFx01O6PusQnL
	Ew0OcrsqoKnesW5v8B20DDjy0o3cjrBZqv8jtfHssKCoaAiRd/bU3HJAB3gLdL0AerrMmI6ZmRV
	a2so78KQ==
X-Google-Smtp-Source: AGHT+IFz/UlnV0OMfhq87mlorD8XvK8vi/cdNG2hzp5O044mKb/ma/Fx+Ie3hyppzhpm+e9TfHmw3g==
X-Received: by 2002:a05:620a:1a23:b0:89e:72fa:ba8b with SMTP id af79cd13be357-8b24529f1f3mr550636985a.34.1762533051280;
        Fri, 07 Nov 2025 08:30:51 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:ef24::c41? ([2606:6d00:11:ef24::c41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b23580b649sm435035985a.48.2025.11.07.08.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:30:50 -0800 (PST)
Message-ID: <e99ff4f12d52eee03075f911e6b904290b47a961.camel@ndufresne.ca>
Subject: Re: [PATCH v4 2/5] media: ioctl: Add pixel formats NV12MT_COL128
 and NV12MT_10_COL128
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>, Sakari Ailus	
 <sakari.ailus@linux.intel.com>, Laurent Pinchart	
 <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list	
 <bcm-kernel-feedback-list@broadcom.com>, John Cox
 <john.cox@raspberrypi.com>,  Dom Cobley <dom@raspberrypi.com>, review list
 <kernel-list@raspberrypi.com>, Ezequiel Garcia	
 <ezequiel@vanguardiasur.com.ar>
Cc: John Cox <jc@kynesim.co.uk>, Stefan Wahren <wahrenst@gmx.net>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Date: Fri, 07 Nov 2025 11:30:48 -0500
In-Reply-To: <20250701-media-rpi-hevc-dec-v4-2-057cfa541177@raspberrypi.com>
References: <20250701-media-rpi-hevc-dec-v4-0-057cfa541177@raspberrypi.com>
	 <20250701-media-rpi-hevc-dec-v4-2-057cfa541177@raspberrypi.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Q5o4lQgKYevCwoTHFi6w"
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Q5o4lQgKYevCwoTHFi6w
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dave,

sorry for the long delay.

Le mardi 01 juillet 2025 =C3=A0 17:01 +0100, Dave Stevenson a =C3=A9crit=C2=
=A0:
> Add V4L2_PIXFMT_NV12MT_COL128 and V4L2_PIXFMT_NV12MT_10_COL128
> to describe the Raspberry Pi HEVC decoder NV12 multiplanar formats.
>=20
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> ---
> =C2=A0drivers/media/v4l2-core/v4l2-ioctl.c | 2 ++
> =C2=A0include/uapi/linux/videodev2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 4 ++++
> =C2=A02 files changed, 6 insertions(+)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 650dc1956f73..3bdcbb12bb30 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1381,7 +1381,9 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
> =C2=A0	case V4L2_PIX_FMT_NV16M:	descr =3D "Y/UV 4:2:2 (N-C)"; break;
> =C2=A0	case V4L2_PIX_FMT_NV61M:	descr =3D "Y/VU 4:2:2 (N-C)"; break;
> =C2=A0	case V4L2_PIX_FMT_NV12MT:	descr =3D "Y/UV 4:2:0 (64x32 MB, N-C)"; =
break;
> +	case V4L2_PIX_FMT_NV12MT_COL128: descr =3D "Y/CbCr 4:2:0 (128b cols)"; =
break;
> =C2=A0	case V4L2_PIX_FMT_NV12MT_16X16:	descr =3D "Y/UV 4:2:0 (16x16 MB, N=
-C)"; break;
> +	case V4L2_PIX_FMT_NV12MT_10_COL128: descr =3D "10-bit Y/CbCr 4:2:0 (128=
b cols)"; break;
> =C2=A0	case V4L2_PIX_FMT_P012M:	descr =3D "12-bit Y/UV 4:2:0 (N-C)"; brea=
k;
> =C2=A0	case V4L2_PIX_FMT_YUV420M:	descr =3D "Planar YUV 4:2:0 (N-C)"; bre=
ak;
> =C2=A0	case V4L2_PIX_FMT_YVU420M:	descr =3D "Planar YVU 4:2:0 (N-C)"; bre=
ak;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 9e3b366d5fc7..f0934d647d75 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -697,6 +697,10 @@ struct v4l2_pix_format {
> =C2=A0#define V4L2_PIX_FMT_NV12MT_16X16 v4l2_fourcc('V', 'M', '1', '2') /=
* 12=C2=A0 Y/CbCr 4:2:0 16x16 tiles */
> =C2=A0#define V4L2_PIX_FMT_NV12M_8L128=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v4l2=
_fourcc('N', 'A', '1', '2') /* Y/CbCr 4:2:0 8x128 tiles */
> =C2=A0#define V4L2_PIX_FMT_NV12M_10BE_8L128 v4l2_fourcc_be('N', 'T', '1',=
 '2') /* Y/CbCr 4:2:0 10-bit 8x128 tiles */
> +#define V4L2_PIX_FMT_NV12MT_COL128 v4l2_fourcc('N', 'c', '1', '2') /* 12=
=C2=A0 Y/CbCr 4:2:0 128 pixel wide column */
> +#define V4L2_PIX_FMT_NV12MT_10_COL128 v4l2_fourcc('N', 'c', '3', '0')
> +			/* Y/CbCr 4:2:0 10bpc, 3x10 packed as 4 bytes in a 128 bytes / 96 pix=
el wide column */
> +

Nothing to report here, it looks good. I can't remember, was there a reason=
 not
to add this format to ./drivers/media/v4l2-core/v4l2-common.c ?

Nicolas

> =C2=A0
> =C2=A0/* Bayer formats - see http://www.siliconimaging.com/RGB%20Bayer.ht=
m=C2=A0*/
> =C2=A0#define V4L2_PIX_FMT_SBGGR8=C2=A0 v4l2_fourcc('B', 'A', '8', '1') /=
*=C2=A0 8=C2=A0 BGBG.. GRGR.. */

--=-Q5o4lQgKYevCwoTHFi6w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQ4euAAKCRDZQZRRKWBy
9LGvAQCRyeU868ClTZ8TOWAm+66FB54e7PZmn1fgF9EQ0WmVqgD+OzrEF4eJkgtd
36v1rz7DSr3XtmcoiIfkHMDBuatl4wA=
=KmUC
-----END PGP SIGNATURE-----

--=-Q5o4lQgKYevCwoTHFi6w--

