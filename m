Return-Path: <linux-kernel+bounces-848589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAD3BCE1AA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CBA19A118A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B902222B2;
	Fri, 10 Oct 2025 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eCXD/oji"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B99120D4FF
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117908; cv=none; b=G3qJ9XGUUBc4f+g9LEbGFgiQSpQsP0WaIUY61cqYTQU3bBriamQkRYlYdhyY05aelHzBqRsQNX6p8Isw/+wmCKA8KnB/ihTWCNALCse2p+AIIuEBH9GjTMzmiqyGUbNu3XBFv3OK+RZJ8OpLzd8NYtQkVv/tWfFzHJHlinqrATU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117908; c=relaxed/simple;
	bh=WlMRssIh5zYebG/2qOucIDbKqlW9Tme8xzWY4T8SErc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbFOROBDET6noRBR9PwK4VVPQOBOMZDokonZ/07s/QSOnAMI4wrtfv4byd7gYOQqv4Tj1X7QY766N6givGKHyWXrVWAbrFEHmxDQansb8lRYk4Cqul1JTOD6GuUQVVibUyyC9IoiLha4WN3RrIAbPDyo0sN10BVv5ZckZWhThuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eCXD/oji; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AFVD8i018532
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bHopJWpMCYVDcAtBNZFS+e4d
	nBu6DmW8XDXrseCiOq8=; b=eCXD/ojiHGrMPEvKSChJR8lmJv2FWtHjBM6MQNwa
	C8h3O14kpQsEABo+IeaxcNbtq8M5irtYvws2H0DbxLfHPQTS+VZZOgxAaRQ3JFZe
	364CygO2+85Lo16LjbyZfWS7PjMyJpJCNogy6hK5BfNFIbuluuzlDbKBypTB13V4
	tAiehVEyHJ9AaC7Ab2r0CjOZfBNB+oxf5ttrF60zcD+xrg/aDZe9x51nduUZsx3N
	xDTCcYefXddrY2ZJo3G135m010sMLYTVrarWhriy2h5hpEG3NK26aO5a0R5Ys0Rp
	rOf8z6w2IUZqSEziGpm8VaeTKB03VFggFaegY8XKrnjUYA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4m799x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:38:26 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-78eb8a9d229so78820146d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760117905; x=1760722705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHopJWpMCYVDcAtBNZFS+e4dnBu6DmW8XDXrseCiOq8=;
        b=F2UR12KQZ1jrl2QiX4HOkTpQUJGOQSOQxsVY/knLB87YYnCP5pIVYYlqO1DZFkzh2F
         IDxTVnxuswhip5AnxHMGXSRgemY5UVyYthAusrQ6Iv9YUv8AN5ZUVNJ6UHcH5Ch+iU9f
         rqNJh/w1nYuTR93v/0jnsRBp3ZLy2ZJLQt+hMPJyjZpJQxArrh8yG8LmZTSAm9K5opCh
         qKDibHIWBD3ANnzkg7ccryKOm0dbjAlxEItou9ZVO5EKqqMpnNWnC16GlOvE40PcKQHo
         g3K84esvxdFVQbaEI0SaohuSRu80PpsXMdm7ivbOvl8OBxTs/i4TTktys5rHFymmB6LW
         PPzA==
X-Forwarded-Encrypted: i=1; AJvYcCXbhr6EM/yV+ezMSsNL5ddGvgX+1p+L+TeIzgSYDKF51TqebEyB6smJ2meC7ZDb9a/HKiciPO2HfTh09Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVrkXN4js3foWCa4lJB3l5i/AWoL0m39fZGVw68n0zKsGnwAPg
	LFWgEL/ubzbdAYGWUVvyN6jP/kiSIb6kj/ftArZjHkhINou2RBrK2D6aZqUdWVVO4y6hmaK7h0L
	kqKbGL588m35OQuTLmBw9QH/9eVxOeAbfDCuvxaLtrbUzRv2Nges3id4XPNK89XsygxQ=
X-Gm-Gg: ASbGncuCL4yid/EGtV18loAqHbMRrefWRI2UIz7JOBdJYYPcD7YC00YlJHHfqMjRia4
	2wk+f0K9MIn11nxRJXD1EhD3ESA6A6ybBtqlcnH6hJy8WN7LZSVF1c2/SYN5ALZ13kVPVLc9Bhk
	TgX0/eANCv1cC42Dvp/GUucKywzXSuhEyU4Gi7aZxKiWOMEQRmO4wCuFRTfU5Hj/WPz8w8e1GED
	VCwOdeMocZClzITIJtY3BxeroO+cJfYqX5p/U4J0P0WQwQ7Pyh96AoqMUeG2/r+ctyf9RZKwl4j
	5wqZXv8NgKxwADU6acVRxpq8mI3QpHiRoQDRi1LZyAEdcryV+reDrBFY5sfY6CHXJeRvBSe6K2i
	CDX5owSpFUwbBRMK2aSTW
X-Received: by 2002:a05:622a:550b:b0:4d8:67fb:417c with SMTP id d75a77b69052e-4e6eacc6653mr200002881cf.16.1760117904786;
        Fri, 10 Oct 2025 10:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKChfLnLv6uMZuWTNjeEXangYm9IkXBq61vh5oNYRc8TIuCkU2/pQdzdpKhqDcWyE0R351rA==
X-Received: by 2002:a05:622a:550b:b0:4d8:67fb:417c with SMTP id d75a77b69052e-4e6eacc6653mr200002151cf.16.1760117904234;
        Fri, 10 Oct 2025 10:38:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762ea3aae3sm7638331fa.45.2025.10.10.10.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 10:38:23 -0700 (PDT)
Date: Fri, 10 Oct 2025 20:38:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jameson Thies <jthies@google.com>
Cc: akuchynski@chromium.org, abhishekpandit@chromium.org, krzk+dt@kernel.org,
        robh@kernel.org, bleung@chromium.org, heikki.krogerus@linux.intel.com,
        ukaszb@chromium.org, tzungbi@kernel.org, devicetree@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mfd: cros_ec: Don't add cros_ec_ucsi if it is
 defined in OF or ACPI
Message-ID: <zcs3utvlaac336ezw2y7mzbbjsqocbls3e4nx5sc4tufiig475@cekebowcrpmz>
References: <20251009010312.2203812-1-jthies@google.com>
 <20251009010312.2203812-4-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009010312.2203812-4-jthies@google.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX/pje+NZRcnZL
 ctHOi1MA/eFXX37hj0CRaXISei/hAqrbTAD4eKsgOsXBsnacwCATUcNh0+QlDgvkVcl6SXrFjfC
 2oxleS0phYb+upQo7gV5uuC+rlOYFDdUdFT20ZwxgY/vj2o9G4yDYUwMCSQCSsMH8zB9KkuXP1t
 bC+1HwOQLRCLZ6sjoFePqy91+UlMcwDFKdow++n+YdllWXSWZhrcBuSgp3NDUO3+JK+6A5xQXuw
 UlG16IPhdgQTnfHpzSHHprzqVfqrHYFssJp5qU/oQ9bkabOfNyCB5l5KttDV8XWGCc6sMJ4urR4
 cg4AHLDjBtJME2yuqjOfQYkebC6fxK+f4pW153AiRDo4DJ+f4MxkSc3aNMnToR1qwpCxBTPmWjY
 FLKD8bYyjJxU4kmfdyd2sDzfi8Bi9w==
X-Authority-Analysis: v=2.4 cv=B6G0EetM c=1 sm=1 tr=0 ts=68e94492 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=1XWaLZrsAAAA:8 a=aqZUw6bxmdrI7EJOglwA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: -6nSoY68X1lzKBNiRxx7E6L69aYQdxSb
X-Proofpoint-ORIG-GUID: -6nSoY68X1lzKBNiRxx7E6L69aYQdxSb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 01:03:08AM +0000, Jameson Thies wrote:
> On devices with a UCSI PPM in the EC, check for cros_ec_ucsi to be
> defined in the OF device tree or an ACPI node. If it is defined by
> either OF or ACPI, it does not need to be added as a subdevice of
> cros_ec_dev.

It still can be a subdevice of the EC, if it has a correct DT node.

> 
> Signed-off-by: Jameson Thies <jthies@google.com>
> ---
>  drivers/mfd/cros_ec_dev.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index dc80a272726b..1928c2ea2b8f 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2014 Google, Inc.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/dmi.h>
>  #include <linux/kconfig.h>
>  #include <linux/mfd/core.h>
> @@ -131,11 +132,6 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
>  		.mfd_cells	= cros_ec_rtc_cells,
>  		.num_cells	= ARRAY_SIZE(cros_ec_rtc_cells),
>  	},
> -	{
> -		.id		= EC_FEATURE_UCSI_PPM,
> -		.mfd_cells	= cros_ec_ucsi_cells,
> -		.num_cells	= ARRAY_SIZE(cros_ec_ucsi_cells),
> -	},
>  	{
>  		.id		= EC_FEATURE_HANG_DETECT,
>  		.mfd_cells	= cros_ec_wdt_cells,
> @@ -264,6 +260,23 @@ static int ec_device_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	/*
> +	 * FW nodes can load cros_ec_ucsi, but early PDC devices did not define
> +	 * the required nodes. On PDC systems without FW nodes for cros_ec_ucsi,
> +	 * the driver should be added as an mfd subdevice.
> +	 */
> +	if (cros_ec_check_features(ec, EC_FEATURE_USB_PD) &&
> +	    cros_ec_check_features(ec, EC_FEATURE_UCSI_PPM) &&
> +	    !acpi_dev_found("GOOG0021") &&
> +	    !of_find_compatible_node(NULL, NULL, "google,cros-ec-ucsi")) {
> +		retval = mfd_add_hotplug_devices(ec->dev,
> +						 cros_ec_ucsi_cells,
> +						 ARRAY_SIZE(cros_ec_ucsi_cells));
> +
> +		if (retval)
> +			dev_warn(ec->dev, "failed to add cros_ec_ucsi: %d\n", retval);
> +	}
> +
>  	/*
>  	 * UCSI provides power supply information so we don't need to separately
>  	 * load the cros_usbpd_charger driver.
> -- 
> 2.51.0.710.ga91ca5db03-goog
> 

-- 
With best wishes
Dmitry

