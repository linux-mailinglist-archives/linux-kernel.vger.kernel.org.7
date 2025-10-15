Return-Path: <linux-kernel+bounces-853723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97469BDC6E9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D692219243B4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4427C2ED87F;
	Wed, 15 Oct 2025 04:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zvP+mUCa"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12CE2DEA6E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501496; cv=none; b=KRAMpcETxm2dEumIaSyGArXuRdd9mt0MIF4LTJcZTNJkK36NgHzbFbw7apquPsDz/441DX9z3/J5kb1yI428a1wEq751EZ0miW+SrqnxY4pciknbCe8y0TbUsNiJbRY4TE6gfKQCj8p6ODeerRW25JJhmNlCZioA1QXZRzS2j2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501496; c=relaxed/simple;
	bh=XKLV3YxJp6jmDmyvNRTUILoHp9lj0rLuGNUzVfpKt84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2QZyWm1txREeP/q12hZRZvuZRR9qwH+C6YoOikuvvaxBi3Bh1QtViXS1oWCrR8PFVTzWTy1XqlbaGAemIhga2eGl8zYOZFCXdgn3xWolccU1kQ5rGQjr8QYOPrDEUOB6RIs+kdWSDuvMWmoHufDCK/HaFBKm21/rTLw2p7kyF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zvP+mUCa; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7b06f879d7bso364402a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760501494; x=1761106294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r0fI+xZNfXjKMSybXqv1PmlGO0rs528EjJ7nl2jjSE=;
        b=zvP+mUCaCwYvVzX7ZPA/C3cbBpVcqhGYTCzP4sCB0GCSFgtWrgZaMSzXmBF1rGuVbk
         K9/EwErPwgVrpcJZXri25udCwvndVyXoAtnlD7zeCnuaArK/AWEqRSDGMf2MKoMR3jXQ
         N/8kYKRx8tiDxwMzjhI9qG+J4ZKDrxpA58J1F7JGCPt/NcjagX8cMgfqiIT9v2ynZGH+
         IHm8Wl8h2ShZm1WbnoxJ/0T2E6hUk8gI5wCDT1EbGUp6lPzu1e1mq0Oh4bvSucju0n38
         F+ogaECCFlYnQFx82cDJ8Csw4HvzMj+niYGIVBBIJz06ZBOymR7mpqV04ES4fVIKrvd4
         /lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760501494; x=1761106294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r0fI+xZNfXjKMSybXqv1PmlGO0rs528EjJ7nl2jjSE=;
        b=CjYWTW3BizBxivBNpaawTssSUv9Ngon79yMAKqxMzCwAc9gEQw1W1I2ZbLpy3tnu0e
         J/9coBF8DsqbYpNWO8xir+KrMT75Gr3lMiGUfaUpRStCkk38eZ3JzIHIXMkCPQUTE+jK
         c4GlPs+YUHg1/NZeJgYI99NEgEJv7sMWQ62Ik5qrmlW9BMLIPCXwJeVxpzaadkw4E179
         X6zrdtW2lszZ4qlR24K5QTdwmTgY2gDH2IrG/8mfI7a/kTvADMmwXCOWKduNtFqFswhb
         HT8LFvAhJUBldI23vlTByhn6Sw3FiByd6y8YNLkuWI285BVh4wQkDUYyUvUCSc14Cdn4
         A26Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRDDpzojQMEtrgkmqVRtt10MI6Bfn5YDM9UsfiS9m9+xtWC0uj4b8QhzL8MONf8Rf1OYRLpuGHU54RqaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd7YYGtDbTf3YV9m6sd4/FNFOqktvyJyyW8F6NMVFJBc+CtqqN
	aSg/04YU6zwNLsugivu+tS2qbJIoQ8i+hkGJtpJwFUd/P0S1t3GSh1iRQaDOG62Ozc0uME2spD6
	5Nk8E8o1Dm5f9bHrt6oyA7fOOnbPtqn0cyaxtXH+x
X-Gm-Gg: ASbGncvD5XZtbP6vsCJstMRs07ymmCE3SiGDwWuKN2IXaPvAjJw8olJUx7LekevZnJU
	zx49nEZAzdi9b5w5meUkXIcKfeX7SlsskUJM4ZZiTu+kz5eG7ZtCUb+pHiM/qDoxvSSFWpa4rcB
	Z0JM/wPg8LZ5vou4ssE7Swy4SfDTB8SE4AZbYNHSMbYsFgGQ9b6tOn+Gvi4OlWyNIC51Xehpd8W
	jj8XGBr19S0HQvlYe88qN+7yVcnJhOlvbl3Gz0MChyKFcZhBY68F6b+fUO7nhc=
X-Google-Smtp-Source: AGHT+IFFKVjmWHWlJesuYbWJpM3jGUXWZXuLIKa9Vij78QOHXiSxxupn/+fyieMebL/8jnvycWXGiJUFViOWZHyJqKM=
X-Received: by 2002:a05:6808:384f:b0:43f:6444:4e45 with SMTP id
 5614622812f47-43fefccfc7emr13806701b6e.23.1760501493648; Tue, 14 Oct 2025
 21:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015040607.3005975-1-badhri@google.com>
In-Reply-To: <20251015040607.3005975-1-badhri@google.com>
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Tue, 14 Oct 2025 21:10:57 -0700
X-Gm-Features: AS18NWDtp4GhDccF-PTmXP1jg8x0ab0zWbRvtcVgAbq8kRdI1GBvRJoIIh_2zZM
Message-ID: <CAPTae5Lq3m1=79E51ps=Xby+Gvcb4U8z-zYDg_6rehr1quRonQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] tcpm: Parse and log AVS APDO
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	badhri@google.com
Cc: amitsd@google.com, kyletso@google.com, rdbabiera@google.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Apologies, kindly disregard the v1. I incorrectly squashed a fix.
Sending out v2.

Regards,
Badhri

On Tue, Oct 14, 2025 at 9:06=E2=80=AFPM Badhri Jagan Sridharan
<badhri@google.com> wrote:
>
> The USB PD specification introduced new Adjustable Voltage Supply (AVS)
> types for both Standard Power Range (SPR) and Extended Power Range (EPR)
> sources.
>
> Add definitions to correctly parse and handle the new AVS APDO. Use
> bitfield macros to add inline helper functions to extract voltage,
> current, power, and peak current fields to parse and log the details
> of the new EPR AVS and SPR AVS APDO.
>
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Kyle Tso <kyletso@google.com>
> Reviewed-by: RD Babiera <rdbabiera@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 15 +++++++-
>  include/linux/usb/pd.h        | 69 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 82 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.=
c
> index b2a568a5bc9b..6e6c27df3c2e 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -823,10 +823,23 @@ static void tcpm_log_source_caps(struct tcpm_port *=
port)
>                 case PDO_TYPE_APDO:
>                         if (pdo_apdo_type(pdo) =3D=3D APDO_TYPE_PPS)
>                                 scnprintf(msg, sizeof(msg),
> -                                         "%u-%u mV, %u mA",
> +                                         "PPS %u-%u mV, %u mA",
>                                           pdo_pps_apdo_min_voltage(pdo),
>                                           pdo_pps_apdo_max_voltage(pdo),
>                                           pdo_pps_apdo_max_current(pdo));
> +                       else if (pdo_apdo_type(pdo) =3D=3D APDO_TYPE_EPR_=
AVS)
> +                               scnprintf(msg, sizeof(msg),
> +                                         "EPR AVS %u-%u mV %u W peak_cur=
rent: %u",
> +                                         pdo_epr_avs_apdo_min_voltage_mv=
(pdo),
> +                                         pdo_epr_avs_apdo_min_voltage_mv=
(pdo),
> +                                         pdo_epr_avs_apdo_pdp_w(pdo),
> +                                         pdo_epr_avs_apdo_src_peak_curre=
nt(pdo));
> +                       else if (pdo_apdo_type(pdo) =3D=3D APDO_TYPE_SPR_=
AVS)
> +                               scnprintf(msg, sizeof(msg),
> +                                         "SPR AVS 9-15 V: %u mA 15-20 V:=
 %u mA peak_current: %u",
> +                                         pdo_spr_avs_apdo_9v_to_15v_max_=
current_ma(pdo),
> +                                         pdo_spr_avs_apdo_15v_to_20v_max=
_current_ma(pdo),
> +                                         pdo_spr_avs_apdo_src_peak_curre=
nt(pdo));
>                         else
>                                 strcpy(msg, "undefined APDO");
>                         break;
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index 3068c3084eb6..6ccd1b2af993 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -6,6 +6,7 @@
>  #ifndef __LINUX_USB_PD_H
>  #define __LINUX_USB_PD_H
>
> +#include <linux/bitfield.h>
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/usb/typec.h>
> @@ -271,9 +272,11 @@ enum pd_pdo_type {
>
>  enum pd_apdo_type {
>         APDO_TYPE_PPS =3D 0,
> +       APDO_TYPE_EPR_AVS =3D 1,
> +       APDO_TYPE_SPR_AVS =3D 2,
>  };
>
> -#define PDO_APDO_TYPE_SHIFT    28      /* Only valid value currently is =
0x0 - PPS */
> +#define PDO_APDO_TYPE_SHIFT    28
>  #define PDO_APDO_TYPE_MASK     0x3
>
>  #define PDO_APDO_TYPE(t)       ((t) << PDO_APDO_TYPE_SHIFT)
> @@ -297,6 +300,35 @@ enum pd_apdo_type {
>         PDO_PPS_APDO_MIN_VOLT(min_mv) | PDO_PPS_APDO_MAX_VOLT(max_mv) | \
>         PDO_PPS_APDO_MAX_CURR(max_ma))
>
> +/*
> + * Applicable only to EPR AVS APDO source cap as per
> + * Table 6.15 EPR Adjustable Voltage Supply APDO =E2=80=93 Source
> + */
> +#define PDO_EPR_AVS_APDO_PEAK_CURRENT  GENMASK(27, 26)
> +
> +/*
> + * Applicable to both EPR AVS APDO source and sink cap as per
> + * Table 6.15 EPR Adjustable Voltage Supply APDO =E2=80=93 Source
> + * Table 6.22 EPR Adjustable Voltage Supply APDO =E2=80=93 Sink
> + */
> +#define PDO_EPR_AVS_APDO_MAX_VOLT      GENMASK(25, 17) /* 100mV unit */
> +#define PDO_EPR_AVS_APDO_MIN_VOLT      GENMASK(15, 8)  /* 100mV unit */
> +#define PDO_EPR_AVS_APDO_PDP           GENMASK(7, 0) /* 1W unit */
> +
> +/*
> + * Applicable only SPR AVS APDO source cap as per
> + * Table 6.14 SPR Adjustable Voltage Supply APDO =E2=80=93 Source
> + */
> +#define PDO_SPR_AVS_APDO_PEAK_CURRENT          GENMASK(27, 26)
> +
> +/*
> + * Applicable to both SPR AVS APDO source and sink cap as per
> + * Table 6.14 SPR Adjustable Voltage Supply APDO =E2=80=93 Source
> + * Table 6.21 SPR Adjustable Voltage Supply APDO =E2=80=93 Sink
> + */
> +#define PDO_SPR_AVS_APDO_9V_TO_15V_MAX_CURR    GENMASK(19, 10) /* 10mA u=
nit */
> +#define PDO_SPR_AVS_APDO_15V_TO_20V_MAX_CURR   GENMASK(9, 0)   /* 10mA u=
nit */
> +
>  static inline enum pd_pdo_type pdo_type(u32 pdo)
>  {
>         return (pdo >> PDO_TYPE_SHIFT) & PDO_TYPE_MASK;
> @@ -350,6 +382,41 @@ static inline unsigned int pdo_pps_apdo_max_current(=
u32 pdo)
>                 PDO_PPS_APDO_CURR_MASK) * 50;
>  }
>
> +static inline unsigned int pdo_epr_avs_apdo_src_peak_current(u32 pdo)
> +{
> +       return FIELD_GET(PDO_EPR_AVS_APDO_PEAK_CURRENT, pdo);
> +}
> +
> +static inline unsigned int pdo_epr_avs_apdo_min_voltage_mv(u32 pdo)
> +{
> +       return FIELD_GET(PDO_EPR_AVS_APDO_MIN_VOLT, pdo) * 100;
> +}
> +
> +static inline unsigned int pdo_epr_avs_apdo_max_voltage_mv(u32 pdo)
> +{
> +       return FIELD_GET(PDO_EPR_AVS_APDO_MIN_VOLT, pdo) * 100;
> +}
> +
> +static inline unsigned int pdo_epr_avs_apdo_pdp_w(u32 pdo)
> +{
> +       return FIELD_GET(PDO_EPR_AVS_APDO_PDP, pdo);
> +}
> +
> +static inline unsigned int pdo_spr_avs_apdo_src_peak_current(u32 pdo)
> +{
> +       return FIELD_GET(PDO_SPR_AVS_APDO_PEAK_CURRENT, pdo);
> +}
> +
> +static inline unsigned int pdo_spr_avs_apdo_9v_to_15v_max_current_ma(u32=
 pdo)
> +{
> +       return FIELD_GET(PDO_SPR_AVS_APDO_9V_TO_15V_MAX_CURR, pdo) * 10;
> +}
> +
> +static inline unsigned int pdo_spr_avs_apdo_15v_to_20v_max_current_ma(u3=
2 pdo)
> +{
> +       return FIELD_GET(PDO_SPR_AVS_APDO_15V_TO_20V_MAX_CURR, pdo) * 10;
> +}
> +
>  /* RDO: Request Data Object */
>  #define RDO_OBJ_POS_SHIFT      28
>  #define RDO_OBJ_POS_MASK       0x7
>
> base-commit: 877c80dfbf788e57a3338627899033b7007037ee
> --
> 2.51.0.858.gf9c4a03a3a-goog
>

