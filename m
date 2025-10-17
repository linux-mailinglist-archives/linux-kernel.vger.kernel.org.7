Return-Path: <linux-kernel+bounces-857079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D56B0BE5DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 02:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1030A4E61C2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D265B1487F6;
	Fri, 17 Oct 2025 00:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="35Ul1jOa"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8613FCC
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760659894; cv=none; b=N7+IrbBpr7UN9an3cUSq7990fbS11RIR9L3LoaUivxXK2EerMpSh4qbjjJz4Dp3Anjzq+BDnbNxX4gE60RvCToIKVn308V8eJxs52FQ9Dml2XTqKPTOTG08Nm2ESevYQA/ds7sXxCC7urlEjGdOuHc1HTImr9mevbvBOIU4n5PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760659894; c=relaxed/simple;
	bh=9qQ/Kaq1PQi1iQEGpE/Y4pRBJHUu5desBrWzjzYMp1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkDQrkb1OCiFpEtkkrDf+KTeDfj3AImsjoVcDchf+sbaLUISe8wdOZ4soqghXIgJlNS2sF6tYa/4E7f/qwOr5wRpnQ5VsLKec+54VMbPDEmcQwdOmuqKYdcFZl2d4auzzKmxxtiGZ4q85xlx2lyydt0Iuay+bOqgq9HLUu/fw9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=35Ul1jOa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-78118e163e5so2220446b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760659892; x=1761264692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rdlnJ4bFVxMl/yRGUabSawyz7mEAHOSqjDImE5CoEM=;
        b=35Ul1jOaA8k6hSHM5pY5yRZMWRSaezWC9IvE2E1zA0yZsrOIeLiCJ9UoouboPAor+Q
         QTj3LFgL+BTtibQRft9CfKT4etURCans9Yw5OoOtzvgVw3oBcl6gtkaE4UFDc8agcdW1
         8V53SOx364gb6q7Wfi2zRka72O4+aRzNd3FM0tX5EkWOKDrekRYZOkzaHt5BitYWlAYi
         RZdsh45/0AhFUUdMXpE/2TnjjlkCsKc7bCEP7W8yjYH3Pi0CKVgxtJOrf4/qx/ExOcWn
         AJZqpfLS16IJ0K2ueYpNTi6xWw96n51egktTVi4N8oe9Gug6K7pPc3C08M+57U/dUfIm
         lEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760659892; x=1761264692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rdlnJ4bFVxMl/yRGUabSawyz7mEAHOSqjDImE5CoEM=;
        b=sGf1ocr2TMZwEgc4K67NBUSMOx2iJtmpC19kjLkCPtbxMT0nk8DmyJx/khs9ZgCENL
         kX/0U1jIuOA8a+OaknQ5VcC+tJT9R8pA5Tk2NBDaT7KPwR8tpA0d8pii/cs2MBstSxB2
         wwXqwgV4nheLlYrN2mVLPwn0OWoleo2/RH4pcuCuMg+YHBJIhO0ZyO0avYmkLs+tgj2Y
         g+5fPRlzwMfJIo+qSL8oe1ttzY5WSMNsRKrwNhAyVp9fVxrLwNxaDBbIiifnNcMXYwRQ
         WJDHTgRhrWm5aTK1cpXymCBquMGL/4rPFqkS0XBb6d7mg37S97skF7x0RDSO+VWGp//v
         5I7w==
X-Forwarded-Encrypted: i=1; AJvYcCU4Azak0ZYCpdd0ZzwpGAQBRq3HFG3XJpYv2lIyfXMF5gsZ0BeC6rWhapF7GvUYOe0uBuAIRv3JtllitBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/+eVnEZa7m2oyDrjecVaO9YTGl9pq1LEpQ5D9qeXXvVRskyv6
	ZpxNpeQRp/PkAXQrbZncZt7fK8t1pH9uTDYuCRtfoatiCg1l1LYRCXlUM8wIAxW3wHOHaZQe2OL
	jqzJVW7dS
X-Gm-Gg: ASbGncvSg9sc9grG3bmpBujOpk7jo6g9NzdWkulWenv+yFDt/d1SQhA8OUrweyFvV1S
	Qd0lp7WlEFAX6s+aHoqET3LH1VPjZm5KP08qoAgF1GYliavA35vcVl1kQOVZcL0/u7dKPqaTG0s
	N8TyRzeYGTGFuGCptlCGXuOucK1zRPinMhA29uY9HzlMKBBxJozCuszdHytNIdAqvZmrZBo6IS8
	hivSagDjzLzoe6wEXsu/abDRmnXcoZ8A0QyxJncRKyXVdnyYYp7eq8/eAPLons0AE2gDZzoUSHH
	ahUjWDSBP0K+hHi8mYHSEQKWE9se/k3ybTrYJiknzDBfI69RsDBuEM94EHzq6YkkeiOD3J44OXa
	5Yse6+FoS/Wd6Vlbx23Xan2KnRnTni8AxQZEH6rqLV0WormuaEzBAFZ60Ng4S732mcnrGgIG07p
	VWTG63SJswyatTGQVub18DbFKURzpE0dsXGsOkPqFCD/I=
X-Google-Smtp-Source: AGHT+IF/mLPPhwDZ9pM3tExE2bPuXwl/05sO0pJ0F8y1gYSwfK180J5bWJ1YL2l1fjSo1vLni9n+LA==
X-Received: by 2002:a17:90b:5110:b0:32e:4716:d551 with SMTP id 98e67ed59e1d1-33bc9b8f4e7mr2440735a91.6.1760659891842;
        Thu, 16 Oct 2025 17:11:31 -0700 (PDT)
Received: from google.com (232.92.83.34.bc.googleusercontent.com. [34.83.92.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33ba9270049sm1592080a91.0.2025.10.16.17.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 17:11:30 -0700 (PDT)
Date: Fri, 17 Oct 2025 00:11:26 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	bleung@chromium.org, gregkh@linuxfoundation.org,
	akuchynski@chromium.org, abhishekpandit@chromium.org,
	sebastian.reichel@collabora.com, kenny@panix.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: typec: ucsi: Report power supply change on
 sink path change
Message-ID: <aPGJrjG6nsRQune_@google.com>
References: <20251016235909.2092917-1-jthies@google.com>
 <20251016235909.2092917-4-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fNlBXg0mnG7NeY4w"
Content-Disposition: inline
In-Reply-To: <20251016235909.2092917-4-jthies@google.com>


--fNlBXg0mnG7NeY4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 11:59:09PM +0000, Jameson Thies wrote:
> Update the UCSI interface driver to report a power supply change when
> the PPM sets the Sink Path Change bit.
>=20
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/usb/typec/ucsi/ucsi.c | 2 +-
>  drivers/usb/typec/ucsi/ucsi.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 7b718049d0d1..cad3913bd7f9 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1293,7 +1293,7 @@ static void ucsi_handle_connector_change(struct wor=
k_struct *work)
>  	if (change & UCSI_CONSTAT_CAM_CHANGE)
>  		ucsi_partner_task(con, ucsi_check_altmodes, 1, HZ);
> =20
> -	if (change & UCSI_CONSTAT_BC_CHANGE)
> +	if (change & (UCSI_CONSTAT_BC_CHANGE | UCSI_CONSTAT_SINK_PATH_CHANGE))
>  		ucsi_port_psy_changed(con);
> =20
>  	if (con->ucsi->version >=3D UCSI_VERSION_2_1 &&
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index cce93af7461b..35993bc34d4d 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -382,6 +382,7 @@ struct ucsi_cable_property {
>  #define UCSI_CONSTAT_BC_CHANGE			BIT(9)
>  #define UCSI_CONSTAT_PARTNER_CHANGE		BIT(11)
>  #define UCSI_CONSTAT_POWER_DIR_CHANGE		BIT(12)
> +#define UCSI_CONSTAT_SINK_PATH_CHANGE		BIT(13)
>  #define UCSI_CONSTAT_CONNECT_CHANGE		BIT(14)
>  #define UCSI_CONSTAT_ERROR			BIT(15)
> =20
> --=20
> 2.51.0.858.gf9c4a03a3a-goog
>=20

--fNlBXg0mnG7NeY4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCaPGJrgAKCRBzbaomhzOw
wmyRAP4qaYGumR/0N01XkF9UwvhoHVmf95YivCn2pzq/dyTTSwD9E9LvRCPYKeaM
kvdNAAOULTjT4h0VUuKVJ93sTEh0LQM=
=N62/
-----END PGP SIGNATURE-----

--fNlBXg0mnG7NeY4w--

