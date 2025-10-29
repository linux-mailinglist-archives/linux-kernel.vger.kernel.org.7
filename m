Return-Path: <linux-kernel+bounces-875684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C8AC19994
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A043406E77
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BF52E6CBA;
	Wed, 29 Oct 2025 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BJw2n+VV"
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338282E6CC4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732609; cv=none; b=mXX1Dci7Qf4xIFapxNfVI87eFtFBeTqfP72EItvqq+ah02BSgVVLVe+Ok6PvyGbOMcVjmNHEDYryVZpAP1FmsByoydrm8dHpm8N3cV53BgqLVnseAHJnys8pb/Y1tpQgdQQyG56ahYzBiEtqNrBrsoNtviGSyqszuyrKC5mxd6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732609; c=relaxed/simple;
	bh=IDv0t5Pc339zcB+OsAtVt1D2dyTl9x0PzoXcrMxCEmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDX8zP5g6M4l2AOFDtlGUewdacuD2ioKGBn5x9PsLbUVIDQqBz1jchgxyclAntDaQo4F/UgWCN5/7ynmIQ7op8JD3dA86cMqmIUGNODUQCctVNbrGkhwlDJGrjNh/5q0FuaJ249K5N/iFevnFOz16NHrPyrfthrR2bk3nKk4i8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BJw2n+VV; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-93e2c9821fcso643643839f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761732605; x=1762337405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WuiirnkGpa9fnFfVy8gdg2pYbghlFikhmLMTYXI7D1I=;
        b=LD1n5O6CGNO0/QPwZZQkkKw0+ZbVVQfg3gLeExP/Hg6JcHt4/fG8TjG/YB8e4K8ttw
         IfgNep8t7kp9VN/VIx+utehiko+KEiFeQEuZFwlx6OsLwyTIs+zkUTh45IdhO1cn2lXF
         bALj/hbeI4pXMdD9ZJ2j9s7a7W/dMGMzRju/9oJXy4lZmSNIw/RWWLlJTXXOcvUotIBG
         8LLSaVuBYjxeUxmJnPlZHzkw6iY4pitaZL9SMjSRD/sA0QS+0syxuvX+2YauEFiNX9mh
         HOhLUZ0CWMAdp2J/WGYPUk9uGT2yuAz1ss4yPYzre0a0RkU/1vm/vaxZdUGxVtLoAjYu
         AfVg==
X-Forwarded-Encrypted: i=1; AJvYcCWk4hFkuRdhq3XNyOPR0UrlRVnT0rii8BaGe+37LtwYKbGLAIZRY4mct3F62aQVgJ2KjmlWVs9+2OIzyRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGmmq/b0dtBKLXgRF+VDibN+UzL2yiQr6mu+eeRFtIq/NcUkGW
	HzlKoM6blU3iifPdLSl560PvG2eo0io796E2a3LMNgI+sQaEBPVfV6Tnp0jo/KjASzo1/xIhHVG
	2iU4NO6JISkgKIyL+FgTyKQr+8CTxyAH51oU4Xo++QJLynzpBXcY4tzpf6m09613GmE/m4t7GoK
	Fu5p9s8FC40b7NxrYX38Ed8VrwF/Ly3QP++Dq6iieW6MyD1rRVvMhj3YcdzY0wMXJrnk+JinHJy
	b5ZdGAFzzBeksPc2lw=
X-Gm-Gg: ASbGncvx7gfCpuKgL3JfJGGPqYWQsqpj8G58VJEQ1hlVxPdva/TrKUU990IyWe3FyA6
	ZfhnFfiQKqDCiRecMpNVljL7hP5Di7Ea/Lr+UYn5owpVnvPC/uJdNIrMK5R8ZhpYvDVLF7rMx3D
	3XI+yYK7BZSgCjnAax5TmhRevNHvWEQInuLuF8ShTDGuUfJifrgSXII5Z/T6dmHfWp+Wc+I1OuS
	Cdw6DRDEpiUSCvtjSA8DPxSGYLG3TFGNmORkCyg+tWeOGQUK4/rD0NLUxnGDBohu+g2AYzMrQqJ
	9oX8S65A0K76Jjf80HcB/c9GxDTqGdKqbI5Uy8vGdAk/8siq/YOan6fHOdB8iVao1Y/uHRX4amp
	R9FJgEbgPLJutJDuIWSz1yPhUAHm1Oe/ypiQf5ditLqbRapl40Jk4xiEwLRL+sRbofGCP5RVyXX
	YiJOJtLTb0T4bjElYYR7nqh9uz8mUIbliqnkuy
X-Google-Smtp-Source: AGHT+IHwaeBIpL9ujlUWmdkuiFZDP9wIXev4yqRBwm3L/T9xhzCye2kFDRCtb2WyBJIgY0GyoQWb43yWeSzW
X-Received: by 2002:a05:6e02:318d:b0:431:f808:6223 with SMTP id e9e14a558f8ab-432f8fc7461mr30909485ab.5.1761732594518;
        Wed, 29 Oct 2025 03:09:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5aea76ea6a7sm1061232173.6.2025.10.29.03.09.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2025 03:09:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34029cbe2f5so4233717a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761732593; x=1762337393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WuiirnkGpa9fnFfVy8gdg2pYbghlFikhmLMTYXI7D1I=;
        b=BJw2n+VVLJv5e6LgL/wiuJx+aTrHu0ysQjmA2XojLXPVU0o+Q2mSGZa6rLiZ8SXnVH
         T4t05K2wWTmTi3KvktJ8/pgXrRItOU+TwdZDI3Z5+gKSs1bzJ9mSYOertKEHmLDXqmli
         jSjFX6ElO5gN24EUcjj4VQCByDkl2fQ9rkQkc=
X-Forwarded-Encrypted: i=1; AJvYcCW7PteqfU45M5+RJdBhDx+cgkp0cIiH8JXtpY4cVxD8BmNG/qCKOxE8AMitaCgjnzuxdv8b5zv11bDonm0=@vger.kernel.org
X-Received: by 2002:a17:90b:3c48:b0:32e:70f5:6988 with SMTP id 98e67ed59e1d1-3403a2911femr2846085a91.32.1761732592431;
        Wed, 29 Oct 2025 03:09:52 -0700 (PDT)
X-Received: by 2002:a17:90b:3c48:b0:32e:70f5:6988 with SMTP id
 98e67ed59e1d1-3403a2911femr2846038a91.32.1761732591550; Wed, 29 Oct 2025
 03:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029083813.2276997-1-cjubran@nvidia.com>
In-Reply-To: <20251029083813.2276997-1-cjubran@nvidia.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 29 Oct 2025 15:39:39 +0530
X-Gm-Features: AWmQ_bl3D6Qpq6QadtY_elNEjPlkBvPoYNi8liWb36M5G0NHsKBBhPL4Li_6je8
Message-ID: <CALs4sv0qPsfLqsrr4Wux=Zb22dQFKDngWMQbEq+qN8Yc+wNsyg@mail.gmail.com>
Subject: Re: [PATCH net] ptp: Allow exposing cycles only for clocks with
 free-running counter
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006b0f550642495533"

--0000000000006b0f550642495533
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:39=E2=80=AFPM Carolina Jubran <cjubran@nvidia.com=
> wrote:
>
> The PTP core falls back to gettimex64 and getcrosststamp when
> getcycles64 or getcyclesx64 are not implemented. This causes the CYCLES
> ioctls to retrieve PHC real time instead of free-running cycles.
>
> Reject PTP_SYS_OFFSET_{PRECISE,EXTENDED}_CYCLES for clocks without
> free-running counter support since the result would represent PHC real
> time and system time rather than cycles and system time.
>
> Fixes: faf23f54d366 ("ptp: Add ioctl commands to expose raw cycle counter=
 values")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/ptp/ptp_chardev.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 8106eb617c8c..c61cf9edac48 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -561,10 +561,14 @@ long ptp_ioctl(struct posix_clock_context *pccontex=
t, unsigned int cmd,
>                 return ptp_mask_en_single(pccontext->private_clkdata, arg=
ptr);
>
>         case PTP_SYS_OFFSET_PRECISE_CYCLES:
> +               if (!ptp->has_cycles)
> +                       return -EOPNOTSUPP;
>                 return ptp_sys_offset_precise(ptp, argptr,
>                                               ptp->info->getcrosscycles);
>
>         case PTP_SYS_OFFSET_EXTENDED_CYCLES:
> +               if (!ptp->has_cycles)
> +                       return -EOPNOTSUPP;
>                 return ptp_sys_offset_extended(ptp, argptr,
>                                                ptp->info->getcyclesx64);
>         default:

LGTM.
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

> --
> 2.38.1
>
>

--0000000000006b0f550642495533
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCzmHqh
jiaIA/O86YxzZxPQGNXqlVVr5zyWtPQwSWfUBTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMjkxMDA5NTNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCA06qwgrrecEC7yhnYAcXLx0Ldf1zN9FkqrNaX6GBD
tuhRQ+PR+B+P4GqVfULCxZJ+SGBCoZR4ePGMY8SWsHZm911Q3LMAgaHDcIrkfAeI+SrvB+KsyDqc
sghsDWjQ8psCfw4uHiXGttMkjtLDsb4bzs+fdcy+EB51mqynPLGgjE4rfkW5B84EKJ/tqG59Wvbc
rRV18/+AzzHeD66sOaOdapjWzOB7pWUVY6vCHMjrS7QkSil8OPELOQsjfI4Oy6GklMymllKU7yIi
hOxiwg8RzLzFCTq1+F1OLWaw3KULd3qUfQItZ0IJBCOqVuABEfMDFNXRWaiFtIk9dKwZoxjD
--0000000000006b0f550642495533--

