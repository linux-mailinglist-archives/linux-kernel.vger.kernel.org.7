Return-Path: <linux-kernel+bounces-738386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BCEB0B7BC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 20:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBA5B7A2957
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEFE1AF0A7;
	Sun, 20 Jul 2025 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YKjn9yuC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15047217730
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753037041; cv=none; b=hJMba2KHSRjoGWhpV7CpjCnR1rWNdGB1lWzPNLrNf1FogqqqOUIa5rbs0xuv24Gmmv3Jibz3vktxgK+SqANFjYLzES3rodDnGGduEAmlhcyqWffo368f5pK8IXD9+4WBy9y3nEqh031gvD6WaQaZK7MZfNDB0YkKpSNcqjiBzvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753037041; c=relaxed/simple;
	bh=Dtnj65qGAU/bEcaBcIJGLO5spuU0SWL74QmsOuDmy2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oubC+QhJxZOlzc54Wp8fDwW3lbvq85onRwQkI9+I+J310BHZcWeHi/+QBxKniaBml0fFfV/nsT7pQFzCZBjtOgcH+kDgEunGTPYJXpskcjLix7j3+3aOqIQkXjy78rypRD9zplqFG2rLWXE3jdzwU6CqFi0J40uEU3SmFxi4KkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YKjn9yuC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KI6dmP029346
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7DGjbmN9sPVvKAeVUnrmEAYM
	XlcKkrf96eMlLVCBSP8=; b=YKjn9yuCwhTXrwZmhQAlmdmkiMhJwCC3zO19Pqes
	fm5b1b8PrWR3WgOyoteZO8pn8s96wQMWh9YExZHY4P5knYn2N+wCNZZePBdGdW32
	lPmEteEpb2XCQkIBu7tXJSzWI/skpYItlzUje7st0v//pSi14AGgXSKYmeOCxMwv
	DBt5rjE72KAjyB4fQAHUsJWTcF+I348ot7YtMGGhuM94OyHsL3vaosCCT6XYjDrv
	UNoTtKw+r9adxaRvekTw2H1d3sk5hQlTQcjyNQYhxGw+NFYEqMT7ZzTWxy0uf08K
	juBZWBJEyKC5LebRNNHJMDVIVuqO8GQJjZWcd0VpnmSpjw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045hajup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:43:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e350826d99so555840385a.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 11:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753037037; x=1753641837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DGjbmN9sPVvKAeVUnrmEAYMXlcKkrf96eMlLVCBSP8=;
        b=vBXwMyL1VC/JuukLcDto6Mwxc9TiRlP2SnsBzN9X7FBS1B5eGTl89RQbQLGWSD5h58
         fSLIPnufv8hvJHGDmwreJChTa+13IFRZgplT9YuLegv1KLpwjecfMCC4alV/7bHW+srp
         ooXAiKrigsGbDaXbpcyFcFCP4jM6RTU5h3JQxq32BnJJz0DC0pyVrAx8l7ynFzCrusmx
         AoZ1NqEXhO0jc0ShT6gb6eOg+idor/DGGYC2x/rvMe/6k1pSHkZ+I5woiah7laCRYZiU
         YVKoXRLZwYo0XaGZyBoZ/JGRQ1rCF0uDBwKFRKERBBsYDm8Xq6x5s4m1m1mDVHsxk/p9
         DAFA==
X-Forwarded-Encrypted: i=1; AJvYcCXPTU2q//veF5p+wCqGeRxyE4GZYPq91mZ6dlGcgtq7r0PRbReD5xhSYQUKzRkQS7wrfSCHFcDXw0uxtiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4lxd8DLINtchHEn4GQ3o378i6P45GdLbb28S6UytfFoVM2VZF
	Izw/udqqu16lDHCxBR2KmeVci3OvvxJeUW1HdVQuppILOjNcKAg1mEOl9WVj9RNkOz+Ql2Pyudt
	PVwRE3wTzDoY8v5X0Aq9c5wJUZFEsd1XgD9ODDvwHeUS1TEzb1CXvKo3i9CC7rn+7Gtg=
X-Gm-Gg: ASbGncvJXJIAJGFOtklgTx+DGNHXIpJlK40NDQqPbzcv06WCS7uxfkVSVMrPWK07Pxf
	voXvS+C9nHlk7DV5jiIL22W2kElxRncCX6Wl44kbebbYd6NiI9Empj+NrtybTHQ1TYlIYOXTnYW
	pgYlVT5UeFZ+GRuO5+frwx0385u3QrLhv9lPdyD6yz0BsW4lcGK8x3/hyCDN469/i/kEJ11L+kQ
	ACVR5Jtoeqw8DdWCqAc5KVIhdV+uavdCjuwysp3JdaBgyn9GSDoC4ZV56niYBTlfUMiv18MeBml
	Ub8KHVEGmrdH4bk0h+ZWfR8fm7ItPK9E5AhMhrKGQSbLmr9WBoHV4hRz1HL45uhtOk0wRkc+2wj
	0Bs5s87UiPgCMczvm6Nxy7ysqF3b0LNUoOJNzvwZ3PCJJSdELMh2n
X-Received: by 2002:a05:620a:28c6:b0:7e2:b955:c2f8 with SMTP id af79cd13be357-7e343615de3mr2383895585a.41.1753037036649;
        Sun, 20 Jul 2025 11:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKbzT9Pz+u7y26dS37ikzmepswmyTtfuYp7Ru3WXjYRaeG4jYtpnsywS5C/gVypdLhcPj5dA==
X-Received: by 2002:a05:620a:28c6:b0:7e2:b955:c2f8 with SMTP id af79cd13be357-7e343615de3mr2383892985a.41.1753037036107;
        Sun, 20 Jul 2025 11:43:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d911c9sm1220334e87.147.2025.07.20.11.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 11:43:53 -0700 (PDT)
Date: Sun, 20 Jul 2025 21:43:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v11 1/8] power: reset: reboot-mode: Add device tree
 node-based registration
Message-ID: <ciaouxjcluhxj4hi24ajc4yr3r4xwqd36donieazxood23hcne@sjmwbabkdeuq>
References: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
 <20250717-arm-psci-system_reset2-vendor-reboots-v11-1-df3e2b2183c3@oss.qualcomm.com>
 <y7xhfbiwkduo3lytb5gbukdu3yptx6uajtbngbspqbqkyt5dzo@gy62zoxwr6ah>
 <54eaf8e8-2b4d-b0bd-b65f-1262e72a54dd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54eaf8e8-2b4d-b0bd-b65f-1262e72a54dd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ZtDtK87G c=1 sm=1 tr=0 ts=687d38ed cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=s3nfzRnEEBKEZTuRKrAA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE4MCBTYWx0ZWRfX4M3csInHLiWK
 nZm0BF8Ya6LNDh7EwV0p+e3ejHI215AhVerdNVanemLxXG6ZNzdZ1933vLYhx23z0LXdeDwdm6/
 6uNEneCWDsLhEbQZpcGOAIsh407UhHzslxquc516hQNYolgfv+FItS2d+95t7Zb8Y0QqzyzmCzb
 3xwV3CR6i2QTbA0yqwKbTuO/weu23lIdsaPdo9du2qI8mzv8vfXqTTUH3tO3oyILCdL2t5TIKWU
 MHqQRx3JHMfH8sP5wq5rhUQIB4cLWgeu6mQjHvpbU1CSvb3fBcRkdFuMHVgzrj/FDAF0dr14YJD
 1HlwZunR+bdLnacOvsXVrYyYz7ArbJpmPhP8SZt6hyI5UkntqcWFzHVPuYceaagI0LX7jVxoNaO
 sCffDnfz+UuBPDRMN30syNMFNm5XvVFFa/JcrCwsltdzYmVB5gidnwow5jU+eXu9PcyI4vpN
X-Proofpoint-GUID: 0ALpNjA6VnUKFbXtTmww5QgqcEFHiypC
X-Proofpoint-ORIG-GUID: 0ALpNjA6VnUKFbXtTmww5QgqcEFHiypC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200180

On Sat, Jul 19, 2025 at 09:05:16PM +0530, Shivendra Pratap wrote:
> 
> 
> On 7/19/2025 12:07 AM, Dmitry Baryshkov wrote:
> > On Thu, Jul 17, 2025 at 06:16:47PM +0530, Shivendra Pratap wrote:
> >> The reboot-mode driver does not have a strict requirement for
> >> device-based registration. It primarily uses the device's of_node
> >> to read mode-<cmd> properties and the device pointer for logging.
> >>
> >> Remove the dependency on struct device and introduce support for
> >> Device Tree (DT) node-based registration. This enables drivers
> >> that are not associated with a struct device to leverage the
> >> reboot-mode framework.
> >>
> >> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> >> ---
> >>  drivers/power/reset/reboot-mode.c | 29 +++++++++++++++++++----------
> >>  include/linux/reboot-mode.h       |  2 +-
> >>  2 files changed, 20 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> >> index fba53f638da04655e756b5f8b7d2d666d1379535..0269ec55106472cf2f2b12bd65704dd0114bf4a3 100644
> >> --- a/drivers/power/reset/reboot-mode.c
> >> +++ b/drivers/power/reset/reboot-mode.c
> >> @@ -3,13 +3,17 @@
> >>   * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
> >>   */
> >>  
> >> +#define pr_fmt(fmt)	"reboot-mode: " fmt
> >> +
> >>  #include <linux/device.h>
> >>  #include <linux/init.h>
> >>  #include <linux/kernel.h>
> >> +#include <linux/list.h>
> >>  #include <linux/module.h>
> >>  #include <linux/of.h>
> >>  #include <linux/reboot.h>
> >>  #include <linux/reboot-mode.h>
> >> +#include <linux/slab.h>
> >>  
> >>  #define PREFIX "mode-"
> >>  
> >> @@ -65,33 +69,35 @@ static int reboot_mode_notify(struct notifier_block *this,
> >>  /**
> >>   * reboot_mode_register - register a reboot mode driver
> >>   * @reboot: reboot mode driver
> >> + * @np: Pointer to device tree node
> >>   *
> >>   * Returns: 0 on success or a negative error code on failure.
> >>   */
> >> -int reboot_mode_register(struct reboot_mode_driver *reboot)
> >> +int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np)
> >>  {
> >>  	struct mode_info *info;
> >>  	struct property *prop;
> >> -	struct device_node *np = reboot->dev->of_node;
> >>  	size_t len = strlen(PREFIX);
> >>  	int ret;
> >>  
> >> +	if (!np)
> >> +		return -EINVAL;
> >> +
> >>  	INIT_LIST_HEAD(&reboot->head);
> >>  
> >>  	for_each_property_of_node(np, prop) {
> >>  		if (strncmp(prop->name, PREFIX, len))
> >>  			continue;
> >>  
> >> -		info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
> >> +		info = kzalloc(sizeof(*info), GFP_KERNEL);
> >>  		if (!info) {
> >>  			ret = -ENOMEM;
> >>  			goto error;
> >>  		}
> >>  
> >>  		if (of_property_read_u32(np, prop->name, &info->magic)) {
> >> -			dev_err(reboot->dev, "reboot mode %s without magic number\n",
> >> -				info->mode);
> >> -			devm_kfree(reboot->dev, info);
> >> +			pr_err("reboot mode %s without magic number\n", info->mode);
> >> +			kfree(info);
> >>  			continue;
> >>  		}
> >>  
> >> @@ -102,8 +108,7 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
> >>  		} else if (info->mode[0] == '\0') {
> >>  			kfree_const(info->mode);
> >>  			ret = -EINVAL;
> >> -			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
> >> -				prop->name);
> >> +			pr_err("invalid mode name(%s): too short!\n", prop->name);
> >>  			goto error;
> >>  		}
> >>  
> >> @@ -130,11 +135,15 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
> >>  int reboot_mode_unregister(struct reboot_mode_driver *reboot)
> >>  {
> >>  	struct mode_info *info;
> >> +	struct mode_info *next;
> >>  
> >>  	unregister_reboot_notifier(&reboot->reboot_notifier);
> >>  
> >> -	list_for_each_entry(info, &reboot->head, list)
> >> +	list_for_each_entry_safe(info, next, &reboot->head, list) {
> > 
> > This feels liks a missing lock.
> Should we add a lock here? The list will mostly be fully created only
> once at the time of registration.

Does it matter? The code should be correct. List traversal should be
protected by the lock in all the cases.

> - thanks.
> > 
> >>  		kfree_const(info->mode);
> >> +		list_del(&info->list);
> > 
> > list_del should come before kfree, otherwise it's possible to access
> > freed memory while traversing the list.
> sure. will make it list_del(&info->list) and then kfree_const(info->mode).
> - thanks.
> > 
> >> +		kfree(info);
> >> +	}
> >>  
> >>  	return 0;
> >>  }
> >> @@ -162,7 +171,7 @@ int devm_reboot_mode_register(struct device *dev,
> >>  	if (!dr)
> >>  		return -ENOMEM;
> >>  
> >> -	rc = reboot_mode_register(reboot);
> >> +	rc = reboot_mode_register(reboot, reboot->dev->of_node);
> >>  	if (rc) {
> >>  		devres_free(dr);
> >>  		return rc;
> >> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
> >> index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..36f071f4b82e1fc255d8dd679a18e537655c3179 100644
> >> --- a/include/linux/reboot-mode.h
> >> +++ b/include/linux/reboot-mode.h
> >> @@ -9,7 +9,7 @@ struct reboot_mode_driver {
> >>  	struct notifier_block reboot_notifier;
> >>  };
> >>  
> >> -int reboot_mode_register(struct reboot_mode_driver *reboot);
> >> +int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np);
> >>  int reboot_mode_unregister(struct reboot_mode_driver *reboot);
> >>  int devm_reboot_mode_register(struct device *dev,
> >>  			      struct reboot_mode_driver *reboot);
> >>
> >> -- 
> >> 2.34.1
> >>
> > 

-- 
With best wishes
Dmitry

