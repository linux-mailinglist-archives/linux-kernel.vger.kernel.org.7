Return-Path: <linux-kernel+bounces-849216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D667BCF874
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8938C1898C53
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 16:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8CF27F166;
	Sat, 11 Oct 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EvAdmvm6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2CE34BA2D
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760201509; cv=none; b=dTxcIiLOJuodfM3EGRfKKttWg2EABu8batg+SHnk5ljhgigN6HtC/xEKJR7s7I/IV22zMWNJuRcd8HyAc3LPQWwZLRq3rErddtHxs11QRxdsFqXYBUnGMG2Hve42AHLMoWCtXNYihdezK+lNigpXGfgNzOf71eK1b0a9mYSo3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760201509; c=relaxed/simple;
	bh=756nAZI2HsvJeu3L8Lk2/V/v6E2LwBB2KcFEklPlkNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFOo29UPLvr41rX9nXsmouWuQOZ50rC2+Rq7hsCYpWA6xWwijZ5EjNerLt62g2R/jIZyFQOvkq2GaeIjy4xGlFG3WyM39gmuDJQI1YlbOQsaDbDdEqnijafbur0XzvVg5CeRC7a3udzcwWVUEllMG+I6gT1z0rcJnlH61RZnlRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EvAdmvm6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59BBIx5b008938
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 16:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xDql/hmPHmbhLyPjNWGht0Ir
	lePqDSoVlgpyDaLxB/g=; b=EvAdmvm6JMiBwFtspv0DVRebMaZ0aXzHvBjDTmh6
	Pl60vwPGKB0cy3LVeUlVVjqCfimlC7XL7NnbIhmMZ5worXFZG91+Siul6cbVZs0L
	/tYDYwhfev7fPrgJq8VIpAhQ7xY1tndC7UIOZzQNtAtgIOpFU9lLhrlSlZ/tMh00
	G4rXeTkQIwVKyC9ovm5cMzFOzx94tfTYYTPcIji09/iwL63WTS2Gd45X9PBAW6MA
	YYde0awJMTCsglI/bbJwhzW00Y2bz+0MQmivyjvX1rPJD0xqfMcU8RutgBgNGbY1
	HiCWWxsnlZUDXyE/g5bcjD72dU2gQvJZLDvITIxdLDojUg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qferrwqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 16:51:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-856c1aa079bso1725568085a.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 09:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760201506; x=1760806306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDql/hmPHmbhLyPjNWGht0IrlePqDSoVlgpyDaLxB/g=;
        b=pOCHevzUWD+rM6oK3M9RCOy3wEzo8LtxOlfy24555E41oLcVwYfKSRDXosCr6ez5Z2
         j+TrLmwzU1mOZXo0+nIT++a6tJoOSe3uNL/jsZT7j+SOjC9IffYF7CW15tgtJSFua/9x
         trr+cKCCJdnt5yLv1ibFGjYTSFcIl4NO2JID7DceZnpZy9os6p1OR4abycE8tjnRbPIM
         dcdMXTLCCIQy+/lPznXCSAHFKFax+0Jo9+II9ozoGj3AfXdJyX531f9gLsYLABDritqU
         faY3U+NncXdIdEF2wiznE9hObAEvPJKi7SXhy+4M66yInGzDKv5PsZ8N5TgCjuPcC4uE
         v9Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUUJc5nDXiB4TYcDd/17h3WPa87mmvig/tVNS8TIueti7HO6dwpwgAaBBcl9kPwl04e2XTBkgaXGHGqJXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKhqUjbGLZYzHZOFkr2xBgKxfDsfG7za1dGXP55BGMRaok05KQ
	E7Tt5kNkqf1Qj/4dRPkY2n/dPaCRb7OaZwIiDPvpOlo5RNpHS1dll8oLgTrxbxo7UdlIy1F3zDN
	91lFcO4DQlTUCINPYMIs7/DmmM26t0oloYHBJja2UOzZ8/y7gwcHH2UjJ6GDUrI36qZ0=
X-Gm-Gg: ASbGnctddyxRM22O9kkAiTR7kzLyux3PNvZB7vrbaQAtvqftogYAyqo+D9pbYCZ2aHa
	fEt/kHg1GT9wGx+8AjQNeTlJ2fvpzzNwk1jGlhWxDTOcr8T5SBt2QiDGOUs7GDjTxlmHmAIlGfr
	PySl2+LyS+T8rQlGYdbcYOx6G3NdLSAyDMCmZ6Dld4h+tmymbX4PfMPbwfys630CZwzxJXbGnJW
	ZcvoRBEEi+B9JI4y/CuAtGrhpPYoW45PuT8pBrQglD6ixm9flZRmhevsrT3olpyMOJBJaLX7nRB
	C04JMblyjADThtSaGwSWPKCQ5aH3+kFv+nKIsLemU6oJb3i0Yup+WZPEGSa4WVg0KQZNI9Nn6sc
	h25kq4apP3yrX76aCLCMhVRdS1pxClX1qMoV3sTgYb2DcfdNB1Jyg
X-Received: by 2002:a05:620a:690f:b0:878:7b3e:7bc4 with SMTP id af79cd13be357-8820b47d5cemr2727436885a.11.1760201506233;
        Sat, 11 Oct 2025 09:51:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1knLg1ejAD4VBlbVpVAYhUPHuhDgVtfBnPSvgk3VxA9bjqCPn8ECh/NUyGL80y7radiIDxw==
X-Received: by 2002:a05:620a:690f:b0:878:7b3e:7bc4 with SMTP id af79cd13be357-8820b47d5cemr2727433485a.11.1760201505751;
        Sat, 11 Oct 2025 09:51:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908856394bsm2060654e87.66.2025.10.11.09.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 09:51:44 -0700 (PDT)
Date: Sat, 11 Oct 2025 19:51:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Yubing Zhang <yubing.zhang@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Amit Sunil Dhamne <amitsd@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaoyi Chen <chaoyi.chen@rock-chips.com>,
        Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
        Diederik de Haas <didi.debian@cknow.org>,
        Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 1/8] usb: typec: Add default HPD device when register
 DisplayPort altmode
Message-ID: <4eizpzejw43gqt5jauvkeij65rracols2voa2osflwyjrwbvun@sovgqfuhg6mc>
References: <20251011033233.97-1-kernel@airkyi.com>
 <20251011033233.97-2-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011033233.97-2-kernel@airkyi.com>
X-Authority-Analysis: v=2.4 cv=R64O2NRX c=1 sm=1 tr=0 ts=68ea8b23 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s8YR1HE3AAAA:8 a=RXhTPAuaP42idGtAG2cA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: CAAGtv5SK8SyoEUgTh1REX1Eof_sCJ9F
X-Proofpoint-ORIG-GUID: CAAGtv5SK8SyoEUgTh1REX1Eof_sCJ9F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXxLyEi+flDo44
 omy4d74/yTGwTm03IaLW/bVzCFMJ9wxsNaYI5LIbBc9dyI7j50xg+VYmdd9GcURD6QG/ne4guA/
 w5seh6B4BoiYK77RMH6TkirGZpEM2wzIf2EcvOe8aPbzJSYjjAWDzXBREVh++uWOZDhRY2HTvm/
 p0VYDPKnq0fupYlX3nK6/BBbLpeWG8R3g/MGUE2WaSQIS5i4hl5DbNp4NKVkK7I1m49QDFZtQ7b
 lmziRFVbbSz6Ll6hpxBkPlEqOSmmz9iXUNyCwX44njxyKFnQJWYbLGK88zAit73awMTdTD9BUSa
 vK5SBhMgn6DHOb9vk8UvhzDBogiGQep9KV3kcso/FubvjXDCOHtJQlTQMDEdk7Ql5+CthPD3YH9
 sGcFV/oK72bVX+xSl7VEX/fW1OfDdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-11_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

On Sat, Oct 11, 2025 at 11:32:26AM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> Add default DRM AUX HPD bridge device when register DisplayPort
> altmode. That makes it redundant for each Type-C driver to implement
> a similar registration process in embedded scenarios.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
> 
> Changes in v5:
> - Remove the calls related to `drm_aux_hpd_bridge_notify()`.
> - Place the helper functions in the same compilation unit.
> - Add more comments about parent device.
> 
>  drivers/usb/typec/class.c         | 26 ++++++++++++++++++++++++++
>  include/linux/usb/typec_altmode.h |  2 ++
>  2 files changed, 28 insertions(+)
> 
>  
> +static void dp_altmode_hpd_device_register(struct typec_altmode *alt)
> +{
> +	if (alt->svid != USB_TYPEC_DP_SID)
> +		return;
> +
> +	/*
> +	 * alt->dev.parent->parent : USB-C controller device
> +	 * alt->dev.parent         : USB-C connector device
> +	 */
> +	alt->hpd_dev = drm_dp_hpd_bridge_register(alt->dev.parent->parent,
> +						  to_of_node(alt->dev.parent->fwnode));

You can not do this, unless you make TYPEC core:

depends on DRM || DRM=n
select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF

> +	if (IS_ERR(alt->hpd_dev))
> +		alt->hpd_dev = NULL;
> +}
> +
>  static struct typec_altmode *
>  typec_register_altmode(struct device *parent,
>  		       const struct typec_altmode_desc *desc)

-- 
With best wishes
Dmitry

