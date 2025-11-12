Return-Path: <linux-kernel+bounces-898095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A386CC5452B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03B8834551E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1DF2741DA;
	Wed, 12 Nov 2025 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ECNC039U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BM0bXAIc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A73263C8A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977754; cv=none; b=HXk0+ZWaUdDPk4GU7PMVqJ8NDeluQm+fZeLNqrGmYhr8VrM0pOfvC8O/ms/hQd3BXLM8iKfdEMFXxI9ywaIq+duQD2JtGUQKHVkQz6oA1/5KclpAvFSoP4ns4TpbjWXKbeh/P3m+KjsS7pHERHVZILzGsziYC14XpHXdjRfgfuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977754; c=relaxed/simple;
	bh=V6s6BBEd/0bzrOGw6MMiaMzOlgagVmFadEX2XjoXe+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4pCsXqIu4dmrLgGFz8dKyAaXnwFSjYfKW5cA1BuZQO6otLdYC8m3P6sn7Q0T+Gqjhbgc883JvuiN4h0gBUF5INWo3aQVC/tZplqgz9fGUuJ8uSj6a79TsyKECTgmvtRElEx6u2K/cAAt5AR2DdsRsJX0uD5OiEx8YRG57yyjJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ECNC039U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BM0bXAIc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACHkDJ11109096
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FvNQaYtuqcShLxpZLFJffu01
	/PtxaNskpjDdIuG4fUA=; b=ECNC039UQ2ygFfkmUhTVw26uwTNiVrnAXw3Zy7N9
	diC1KCSFx6+zJUvbXfAQqwje0xh9vmBOnA8HPfyJozaAzUdY3qp2MHdpKS3+EsRd
	hDqTW51xISGwbXHpRm/BOYScFb20V3p7f1t3pNfp2BzL0mW0akIiErhfygZg0Wrj
	LDWFfsiOhn9MY/gIyMAfTJHF3SjbOXDdx8KL0dGxcHaDXuJMQRIIXS/GMVsaK0dn
	bJVIcI6b/FXNww0bEeiwnEfAIolIyjdtxKqpLiK+kjBQc2IK8ZCcji4S8rP8SdQ3
	23+Llr8kCf08sX4w+Wmf7Kdedbhk/8vtdKGkJWsCxHmuAQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqum1uy1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:02:31 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-93723fdb00fso236274241.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762977751; x=1763582551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FvNQaYtuqcShLxpZLFJffu01/PtxaNskpjDdIuG4fUA=;
        b=BM0bXAIcpmos/ab+9NqD9gpNLRivs2PJGuhy/0bHtsIsTzF/js9TojzJMliQGajjoy
         urvg+Udk3jcTyk6+8sneosvxW5BT0eO6s4DvPQMeH12ldgLtQ9JYBq78uEGHPkHnlN02
         mxHXhN5p5zyq5tutBJeueJhh6So8YapoDSSvyUqv5GHChQJqJ1wcoVywgGCoTGCyRfVC
         I3FY5lOPVru79GyKNhl8WtSVm18Y0WlBq4q+W6gEfnsPWEXHLT06719Zmn+zHhV1paIl
         3r6SVpVn2PFOtky9V1Jf51AKxhyFcyYxdtOZQcZbr8hAPgl/31nIbK+ISNS4DUTszFvp
         l+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762977751; x=1763582551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvNQaYtuqcShLxpZLFJffu01/PtxaNskpjDdIuG4fUA=;
        b=BVMXJZFx2IMdwo8KkztqBmtowM+xz2oE9+a+Yi75fB+aXDhCRWLWWTkrnEfjGNqQya
         j6n3SmxsWS6FxTFQG5TF8uNNb/9HfGvkOhvLJdw6QaSz3tdZKJLrU8ACUCl5grLMfRqR
         nQWM7kC4lyHcrWdgJwiOMFI+RyCKV8eo6w+YDF2ZIQcpMvHZ2leNuPNTZaol4trWleUq
         TSLl3C9vRpTrhqdQZg3xKaPSI+6dm6Rpg2TQOw3aENFjse0hbJgZjaMJbrtVsO+dGo0u
         OeCWV2QPxKe7kKdA1sZmao9OsbGz0x/hca4bgzx4FDVRXesylT8uRpsy/yQUSUJDD5YJ
         c1gw==
X-Forwarded-Encrypted: i=1; AJvYcCViGLtnQ6Q8M2lbn3+95XAa6JJkyvitwwwBpwUyrbDNln6kZ4zk0YsMlq2w433tRfv6WhBMMVL4rIZIlzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7KF5u1HaVm2dI9y16bb44Uyy/Z11bIkzG4QlyjphGkThdRPb
	dbAZPmHJWeiZvgvT5thVkewIqfARCwsujXjk/z6xOWzW7wIMTMIm+LfUF2L6WmbK+UE4UHJHR/y
	nHxFBLwF6DQqtryYLF/ewcwdrJr4CywNU5ile6nfssbsjjlcg6lZHyraIEZ8U3/L7EFE=
X-Gm-Gg: ASbGncsMvAD1jXy+PgApfWAEbNZCxPt15kM+Sfvbfepbl8oh/vdi5+UfBlCoWy/xPEH
	iMHJH7Urcn2m8T6MNk5YQ+HePc8pSFe1pso7dEKtIRax/xEGdYihqQ95DomE7ORZX7OYPdbsQ05
	6kG6QyW1VF/iz60A/jcu43MEM7hHtmKMX8GVYtPRZp9zpwdGHxK0+owgHKw3U6AjJC62xaP2rvj
	Q5qvXkb+8NAkOQYBAvKAzIWQ8Xf1QYjFyhZFMZj4AzX/MpJfPeyQ4Y6LABY57UT/94JgxNmbu4r
	5amxXm0YzQODagWZtoejlNaxOaMwoN6Iw1tgN1jc1NyLc/sHHKFq4GzIitP3NOPIIi2OeVx4Tyr
	LuqDvWote5Uk4t9cuqI10VJHyZCdY91/c2KHlHd3rLxOTNKVnZqGAULkj76BCPASJt+eps1hH/C
	+gKb8LEI1dFJr5
X-Received: by 2002:a05:6102:1629:b0:5dd:896e:7b48 with SMTP id ada2fe7eead31-5de07d2a66bmr1591368137.14.1762977750842;
        Wed, 12 Nov 2025 12:02:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFws5LrkKqeobybDIptCgapHUcvU4bSEg8lJzPhSfBeVBFOq57rCuoMQrcd5gvzYZuvugA27A==
X-Received: by 2002:a05:6102:1629:b0:5dd:896e:7b48 with SMTP id ada2fe7eead31-5de07d2a66bmr1591122137.14.1762977748845;
        Wed, 12 Nov 2025 12:02:28 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944ff427d0sm5899727e87.68.2025.11.12.12.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:02:28 -0800 (PST)
Date: Wed, 12 Nov 2025 22:02:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v6 1/2] firmware: qcom: scm: Register gunyah watchdog
 device
Message-ID: <e5awatsfe6qksjj3z2vqn4fpc6pnlzuezu544f4oiyduappihp@zxgvyvyro76a>
References: <20251112-gunyah_watchdog-v6-0-38ad01f8dac0@oss.qualcomm.com>
 <20251112-gunyah_watchdog-v6-1-38ad01f8dac0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112-gunyah_watchdog-v6-1-38ad01f8dac0@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE2MSBTYWx0ZWRfX0xFM6QPgrc1h
 Ffz8tK2Bn9G2N74nFQCSwhf0jubkDx1oswAy32gZQERPqM/Wm5yVEsntSU8AK1jsdxBZJRE4jo3
 5HrsCzpnJnglr8Az/DlsPE3hauCzN5As20m0QHH64UxCvIyepgSdC9Ve0dXYEkeEJdxXexShWRj
 jujoj1CgvuQoRj7C7yivPo/QH1WDtNg8rgkedeMZn7gidsaKKXy5mfnceBZj6wQ3jk4RdoVlS9z
 rD41Ll+aKYg07IgQuOvGNCf6bs4hgxPkMHtGz85k51LeoLFOZVImuNdzDMwHKA5Z3Kkf8faPuMc
 yzUgFlOxdfAK81BDjEnJB/ZEpaI6QW4p+HetkOdRv65Rrb6fPXOAwuwUmO5qPOCyuFgEU+N5xyt
 a2CoBJ4ql2QVx7P7nMqI/xtyrkGRFQ==
X-Proofpoint-GUID: MuCbYNsA7jh93t8mJQd28JgfV0HXMeYm
X-Proofpoint-ORIG-GUID: MuCbYNsA7jh93t8mJQd28JgfV0HXMeYm
X-Authority-Analysis: v=2.4 cv=KeTfcAYD c=1 sm=1 tr=0 ts=6914e7d7 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=aeXaUF_9NkvhSBek5i0A:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120161

On Wed, Nov 12, 2025 at 07:35:20PM +0000, Hrishabh Rajput wrote:
> To restrict Gunyah watchdog initialization to Qualcomm platforms running
> under the Gunyah Hypervisor, register the watchdog device in the QCOM
> SCM driver.
> 
> When Gunyah is not present or Gunyah emulates MMIO-based watchdog, we
> expect Qualcomm watchdog or ARM SBSA watchdog device to be present in
> the devicetree. First, we make sure we're running under the Gunyah
> Hypervisor. Then we move to check if any of the above mentioned
> watchdog device nodes are present, if not then we proceed to register
> the SMC-based Gunyah watchdog device.
> 
> Signed-off-by: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 53 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index e777b7cb9b12..3f45cc69ef83 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -2182,6 +2182,56 @@ int qcom_scm_qtee_callback_response(phys_addr_t buf, size_t buf_size,
>  }
>  EXPORT_SYMBOL(qcom_scm_qtee_callback_response);
>  
> +static void qcom_scm_gunyah_wdt_free(void *data)
> +{
> +	struct platform_device *gunyah_wdt_dev = data;
> +
> +	platform_device_unregister(gunyah_wdt_dev);
> +}
> +
> +static void qcom_scm_gunyah_wdt_init(struct qcom_scm *scm)
> +{
> +	struct platform_device *gunyah_wdt_dev;
> +	struct device_node *np;
> +	bool of_wdt_available;
> +	int i;
> +	const uuid_t gunyah_uuid = UUID_INIT(0xc1d58fcd, 0xa453, 0x5fdb,

static const

> +					     0x92, 0x65, 0xce, 0x36,
> +					     0x67, 0x3d, 0x5f, 0x14);
> +	const char * const of_wdt_compatible[] = {

static const

> +		"qcom,kpss-wdt",
> +		"arm,sbsa-gwdt",
> +	};
> +

-- 
With best wishes
Dmitry

