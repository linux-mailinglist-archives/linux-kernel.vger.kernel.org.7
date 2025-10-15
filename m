Return-Path: <linux-kernel+bounces-853881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 147DFBDCCD0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB27A4F3FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02960313260;
	Wed, 15 Oct 2025 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QqUadTo0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B956821A447
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760511316; cv=none; b=E45L0n8fcIJAkAdaYCK8O4HielAsVgg7mfuzSbEoz626+eg8XZAcxOUKYcDEXyKL8k0Vsh19S0fFJV82HNIyoz1Fewl7clmDfbZi/njcXhSr6hceCiRQ7Swp+Fu2tkSgerJZSSXjxihnCP7JqFFlMRzMPyB88mO3CnjH03F0O+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760511316; c=relaxed/simple;
	bh=sh9A9FOiaFSj1NrSmBjEHeyuo7+m+MPI2zTeMPcWPMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsRmiaxnBRKgmvp5R9H76d0I+wKCQ4e3FtZm5iDlxc7LyLZGw3NboXfQG/a3KT7CbKPrZkSYAoZgG1uzH+Aougff8jayu1jJRF84yBt6H7EBxg3Gn8r1SgZZxJR879I15Xbkxdk9DyincLzwyPviPN+H3mJMWvRRk8q7S71RD0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QqUadTo0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sKoM015803
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TXB5nJozBeUSUfmi0Lz+MYki
	JUeY6V0tmx/cboDkFLY=; b=QqUadTo04FZBGSEHNT3wH2hmQAOObsSR2bX3r/Xw
	jdd9pY1qeVHvYx+42EQ/WitzbGb3MmYbcIDGFXo1CFkXWaI4B4GchmcUnQXbJV/9
	BH86iYFa7Jm7O4wdqMoC5sQ8L3ToA9QgFQkpPva6wp6lDm4KLWSSnacqJdnPSYvy
	Y/vFak9EgeeZ7o+68+xUYY7IqrOJ1OHstbN2mooGEYLdDXDosjQ8dB6G0xju7O9C
	5Yb53L9tL9dOYF1az+3paNWe8eagwYY/iOoemckuHekwFkpZGd4MTXoBFrxa//E0
	umU6/Truog4dPnX2MOe7QMtwyF7YZf4jsf0FLHwO2nLT2w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5kgbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:55:13 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33274f8ff7cso14300977a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760511312; x=1761116112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXB5nJozBeUSUfmi0Lz+MYkiJUeY6V0tmx/cboDkFLY=;
        b=c42LE5LpFFbQMZZUZ0AOwwa/q4LL7RSC9lbyBXzIsUK66FhX7dbrxtwZfsMFqhpyqg
         f1pVoTt10H51eZLahEPVlqLZ64QQZqitZicr50HnoFrUnlkzTRNAP9ndGFjnlyYGIIdr
         virnf2P9kDHLRloYcDqzEj+YFAMU35HMbcEUbKcAnVGTbNnbMvFxVoQVaEAnizRx2n0C
         IhYCD0Os7PdjZTcJ3J8gxyFj3mlY4Sc3up3NNrq+rmyrClewFRGkmE9+6wRsG+/ol/C9
         LqzxKdvAn5eTKZUlj6AO8v9sMPR3gG7hmGpNOPoSNkt/Gtia99W/99vsRKyzGud+xbhA
         W+iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU2zEse8WyASRw2lOUB8/sFrhxT52jd4qlYMaph/bgWECLnBo2qDKs1qHVWkrExc2r+eyLZJqBhqS2meg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxipmvBEvzE7GwXm5vDgPdGVCoS8Ldl56S/ThOunSWt7KNHYbjv
	khn4LcrMs/ntVAMfU781vDpUV59+6jtYOZkox7USYC8uvb+X/r7DQP0cECuOHHRLhWXS1YEEtEU
	DRBS+pwgyGTq3+HSfSSvleVJRRNRznqpiqvlZQLEF7rM5M1dFGyQLwNitwFgulAJ+F9s=
X-Gm-Gg: ASbGncvqIn+fXWVMAMbxypKpiNaIEm8CwCOQrMgxthkMDu0lpNRAHQUjX3xkvUrd0Fi
	n5jgtboZ4jElALtgJhXUvA0gG/KLlS0rPBBySwcLV+UIXtRQtob/0SeBKH+jl735WqXo4yaMnkr
	qfl0JN++EMcH/CTQJgZCLvmOXHX8pvC/QOLEj/fsyzFUGZdHcQuV+OgoDyz45Nev3tcynmM7SRe
	jTW4035UzEq6HYhySk2munVWKb+R+N4OC25zRq8pwtbqPAyhbED2Ofqd8cwqEcj8jjzE7bzm3cD
	hJ+YmZmTxDenCYIFSfUGOgtoA2oEkqrJi1/UQma3AIBQItPwce6RcbyN9VkaMevL3uqUSSVJJQ=
	=
X-Received: by 2002:a17:90b:3ec5:b0:327:e018:204a with SMTP id 98e67ed59e1d1-33b50f85081mr37168960a91.0.1760511311969;
        Tue, 14 Oct 2025 23:55:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7PQa4vHNUgbJuh2uPKnDF3CrlxsqSIGMWHhVoDwTgNv+/9QY6DRirS1HikY5vDY9hqKN+Rw==
X-Received: by 2002:a17:90b:3ec5:b0:327:e018:204a with SMTP id 98e67ed59e1d1-33b50f85081mr37168927a91.0.1760511311418;
        Tue, 14 Oct 2025 23:55:11 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9786e602sm1207949a91.11.2025.10.14.23.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 23:55:11 -0700 (PDT)
Date: Wed, 15 Oct 2025 12:25:00 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
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
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
Subject: Re: [PATCH v16 07/14] firmware: psci: Implement vendor-specific
 resets as reboot-mode
Message-ID: <3978e740-0589-4872-8f2f-1162084d3818@quicinc.com>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-7-b98aedaa23ee@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-7-b98aedaa23ee@oss.qualcomm.com>
X-Proofpoint-GUID: SZDTW_XaYRxE1goXi8iui9CAM7ehSGfw
X-Proofpoint-ORIG-GUID: SZDTW_XaYRxE1goXi8iui9CAM7ehSGfw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfXwxK4DU6zsqyh
 3yB+eZ8uHA2Hj/T2ENoW9Tc0dQb/wLpiPROoa5uba7hbmibjatibmhyZS4B4ypSyPHLqSDQ8stZ
 RQVF1CGcds0ZvVHzkgdLUJzPp222dU5/3lsId4kTTIQl/4ebq6FDQR6CTNKHjTKXEe/CPETBSYV
 JX+YBvJYZc4DUblVs6q5VmYageOi59xBuhDak/rn3IPI9w2YxSA4sonLG7BQbyAl2T2f3YHvSex
 pPi4VashrzEC1sz7ET0AAUj3QPPZ5H3kMZEy++pVo1gbLNLFjhFkhvQnCcUatw1TxD2dW93NTTg
 dYvrt5/Fd+w280bu1DpL7dCyHdKiTk9X2Jg8UXNOTki+DJovT1r+xlh6hFtdkcb2bLlrNRxeAow
 53qJM6OAp4ShUK75JJAE9Z0u+gcyZA==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68ef4551 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=BmsMZzT-mW5IMwsoq18A:9 a=CjuIK1q_8ugA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

On Wed, Oct 15, 2025 at 10:08:22AM +0530, Shivendra Pratap wrote:
> +static int __init psci_init_vendor_reset(void)
> +{
> +	struct reboot_mode_driver *reboot;
> +	struct device_node *psci_np;
> +	struct device_node *np;
> +	int ret;
> +
> +	if (!psci_system_reset2_supported)
> +		return -EINVAL;
> +
> +	psci_np = of_find_compatible_node(NULL, NULL, "arm,psci-1.0");
> +	if (!psci_np)
> +		return -ENODEV;
> +
> +	np = of_find_node_by_name(psci_np, "reboot-mode");
> +	if (!np) {
> +		of_node_put(psci_np);
> +		return -ENODEV;
> +	}
> +
> +	ret = atomic_notifier_chain_register(&panic_notifier_list, &psci_panic_block);
> +	if (ret)
> +		goto err_notifier;
> +
> +	reboot = kzalloc(sizeof(*reboot), GFP_KERNEL);
> +	if (!reboot) {
> +		ret = -ENOMEM;
> +		goto err_kzalloc;
> +	}
> +
> +	reboot->write = psci_set_vendor_sys_reset2;
> +	reboot->driver_name = "psci";
> +
> +	ret = reboot_mode_register(reboot, of_fwnode_handle(np));
> +	if (ret)
> +		goto err_register;
> +

minor nit: np and psci_np reference must be dropped since we are done
using it.

> +	return 0;
> +
> +err_register:
> +	kfree(reboot);
> +err_kzalloc:
> +	atomic_notifier_chain_unregister(&panic_notifier_list, &psci_panic_block);
> +err_notifier:
> +	of_node_put(psci_np);
> +	of_node_put(np);
> +	return ret;
> +}
> +late_initcall(psci_init_vendor_reset)
> +
>  static void __init psci_init_system_reset2(void)
>  {
>  	int ret;
> 

