Return-Path: <linux-kernel+bounces-844894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECF4BC3019
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A5D434F024
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF54326A08F;
	Tue,  7 Oct 2025 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+WOPiJR"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A112126A0A7
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881108; cv=none; b=KPxSJUpoYkbcwuFAY5hmJ/iQjZays9yEI8cREBsQrMHZ2QfmaqJmuRcVg0pKCbg40mBg9DzENOtOh+dCm7AOeEmUvk9Qi1drN2Cs69TC+GpGB/vrmLGLmJho8lsCCHODG7GoYApt5XWpyAY9BgJ6NDb2s5EyYfoedZb4+SJwDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881108; c=relaxed/simple;
	bh=pi53V1uF/tYf7fHEgh+OBnrKV9Fo/NCn3Rjh7pmA9Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgbCLOk0T2LaY39EdYaPTBgllrjmbHFMTUzcoA4UAsrgNSSRWliabfusru7yE7ljl8oUvDGfVAAWdKRCFqmNdgCthX1o8lQYqeKTpxcBh26OcL86I3GCsK8GYTYwDMdLxz0ZLtdQBL95ueXA5PDhJuqNcDanUQHwfLOyBI0Hgd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s+WOPiJR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781001e3846so6187348b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759881106; x=1760485906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AfyQRT41Mv7RuOOAZnPCvsDsbq+2FeHyfKl7ri6/0g4=;
        b=s+WOPiJRad7h74QFr/MjwfCGVyumX9bxeq0EfAITDIB9q3VYUUtka+mEeX78G0MnBq
         +gYg670SsOopZ6jfprShXLOSlGPbs7jsWj6tYlrPbpByLU2LEbECw1ACRgcqgkgv201C
         /WCfaeFhaWCDAfasiiLw1tjMd/TQaEkSb/XTT+5aOpGqfcUhpB/BpSvm/w4J6yq3PQ8F
         zHu4p4d7AsKv2n5cUVcO7oMPRN9neAwRm5TEvQKCwR93f0B2xLmFqu9Jn3kY2UZCF5EU
         +x0AoNXLI0dMvsRL1dlmjDRwZlh9Mmzmae6Kixx8ohaAb7PDTMWy/NAWsHF1d+BRCm/j
         CHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759881106; x=1760485906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfyQRT41Mv7RuOOAZnPCvsDsbq+2FeHyfKl7ri6/0g4=;
        b=lYXs94wKwaj675ahJ/QDQC6zktsiyIQHF3kJWQF2khqu7L3wigw6aiLUFsWPenZwM2
         ImpVS9pMa6vOvW6iHo3uHBAYncHqoZq++N2G7JQOpEe2/sUiAGZgF0luZD1B/wXDAhqI
         7dTddDrNT1ZX1OJvPXNNZsc1M8ZVk7xu21wj0HClxkGhTbpsN7z6YjpNLxptFOwUyVDJ
         UtFbrljRalut9++kYGTv+f4oQ+kk6DhRs23QO2KBBxq/UZ/CGpBAWbnpsLk9Ai8tNVcS
         WkWLl4BrONxfz9imGXhW26SlPmwNuQ3pEn+a3c9m3TbC2XS/kj8zL7NGyoLQnLD1ei0R
         ttFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnb5O2NDSE7D3Fv0l7fuIQjM/boZZZB6bwG1r4JOJvscqVDpT1bYuNS65TP+4JxnJs5Vj9VLdszyxwP70=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjTT7kA8lIAWwvHRFD/pkUSMKVJC3KexniSK8mUBexdY47yrUh
	oTPVipN2bB5fPnOoKsgQMqyLeEEK2HN0cEry4mvtPrIrVkzFeMyPfXSZGsKApnEzfgr8gl225kP
	D0S+9BA==
X-Gm-Gg: ASbGncsX8PqYxMC1gszlQL4A7Hm+zE4ZwKhO/H4hY/QSUgjrvwCzoR5AVn3rDjYlS7v
	RsQSuuCQ3qK30pMaBMHuzkNSxWI5CMiABVYy14g6jaVWROwnCtiphO5Tc8rfqkg3en9R53t2UiY
	ZjfHFKAaYTJpksMszNkQo/JF1llrImwTovByMQNYVDi1j3P4JFdfK/F0jYhtSppWqI3xiHpDkEn
	VWzmNanYm5Q0f98ZYg9VtxFurpSTWfuttbRttOehQzSDfI96dMufdztAGip/mgidN85aY0GfZZw
	SNYC5QswGAAQaseJ8YfLsyL1pwM8ggHP42JefMknvzkCrxzWqnGHMMhWIq0DQxEJUNR1joWm3q2
	J0g06tZaiGxyHmmynTg7Q2p9b54CGdPUvUw88Cvx2fM4J5yIzpKku2tjvjD7Gy6WFo8yjsvK6qE
	SkemcytCXgkQ20crNJCv4d
X-Google-Smtp-Source: AGHT+IFtxIjyYd1PKZvljXTufwBzE5tHAEMUoqY4YO2sjkFUBWHg+zaMyKMODS4B2h8OZmKwJMFWKQ==
X-Received: by 2002:a05:6a00:23d5:b0:781:d98e:ebda with SMTP id d2e1a72fcca58-79387a233fdmr1306707b3a.30.1759881105262;
        Tue, 07 Oct 2025 16:51:45 -0700 (PDT)
Received: from google.com (232.92.83.34.bc.googleusercontent.com. [34.83.92.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f99863sm16900862b3a.14.2025.10.07.16.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 16:51:44 -0700 (PDT)
Date: Tue, 7 Oct 2025 23:51:40 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	bleung@chromium.org, gregkh@linuxfoundation.org,
	akuchynski@chromium.org, abhishekpandit@chromium.org,
	sebastian.reichel@collabora.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/6] usb: typec: ucsi: Report power supply changes on
 power opmode changes
Message-ID: <aOWnjAgB7rEERd1-@google.com>
References: <20251007000007.3724229-1-jthies@google.com>
 <20251007000007.3724229-4-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gNnsiOG0NePRMiU7"
Content-Disposition: inline
In-Reply-To: <20251007000007.3724229-4-jthies@google.com>


--gNnsiOG0NePRMiU7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 12:00:04AM +0000, Jameson Thies wrote:
> Report opmode changes from the PPM to the power supply class by calling
> ucsi_port_psy_changed(). If the current opmode is USB PD, do not call
> ucsi_port_psy_changed(). The power supply class will be updated after
> requesting partner source PDOs.
>=20
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/usb/typec/ucsi/ucsi.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 3f568f790f39..7b718049d0d1 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1022,14 +1022,17 @@ static void ucsi_pwr_opmode_change(struct ucsi_co=
nnector *con)
>  	case UCSI_CONSTAT_PWR_OPMODE_TYPEC1_5:
>  		con->rdo =3D 0;
>  		typec_set_pwr_opmode(con->port, TYPEC_PWR_MODE_1_5A);
> +		ucsi_port_psy_changed(con);
>  		break;
>  	case UCSI_CONSTAT_PWR_OPMODE_TYPEC3_0:
>  		con->rdo =3D 0;
>  		typec_set_pwr_opmode(con->port, TYPEC_PWR_MODE_3_0A);
> +		ucsi_port_psy_changed(con);
>  		break;
>  	default:
>  		con->rdo =3D 0;
>  		typec_set_pwr_opmode(con->port, TYPEC_PWR_MODE_USB);
> +		ucsi_port_psy_changed(con);
>  		break;
>  	}
>  }
> --=20
> 2.51.0.618.g983fd99d29-goog
>=20

--gNnsiOG0NePRMiU7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCaOWnjAAKCRBzbaomhzOw
wkFtAQDcbLui/sCiiAQpbwPKX+ot/X2L7Vr6dgaazf2MvSJBBgD/edscmgdUFSsX
b3hORrAlZkcfotX4hVo8Xv3K9Puq9QU=
=fKBd
-----END PGP SIGNATURE-----

--gNnsiOG0NePRMiU7--

