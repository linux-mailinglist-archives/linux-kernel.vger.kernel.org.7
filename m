Return-Path: <linux-kernel+bounces-831681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 788A7B9D4EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DB707B5C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186012E7166;
	Thu, 25 Sep 2025 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DNQ7Qxab"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B4134BA52
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758770558; cv=none; b=mn4M/6w9555FltPc/IBH0B0HRzryUBshdXnJha/9fZuthpE7v/6swh2ButkLgbSc+n7KqmJ3lH9EZdMQKMf+1jrEFaaAqDnKe8Q1efdkXt8pA+hYObeeNh18D1ghO8JZ+GYaLcg2Rq8WkCRQk+KyZ7TpU+aIslWZWFwaiKZnq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758770558; c=relaxed/simple;
	bh=6pmeTUqKLAywnwstwRk80ICI60VTQgJd12zVbpW8u88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgEkZESQeFZbtvmm41OjAWH5LYHpwHeM8jUWH+BTRHBfQHW0GbEoh4JJPTANA28DLwi0KZBFZZhEdZMfZ9sEXE2OoWfHlmiWrq9McBWi9PnLNfBJIlBRTR1T2Mye5c4HxNZGhJ3nUcTMwVPbv6SlYRBDPYT0t8Ga/lXkTtI0tyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DNQ7Qxab; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P17Id7016452
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cpArUBkBwSCGSXirYH+a+MgH
	TCrTiPbzylW7/OuHCvc=; b=DNQ7QxabAyvg9uEPlYgehRAKOktqYaejEjwFOyAZ
	/ac4Rf4Zl2Z63RH3YpptKjE7xpJclHanT2KLfcT+JuyO8quzgoISSaKoT9R+PZDD
	+MRm8cGsyUYz509hI/35e1ivnXQ03+mZGzG126a0xL38cTcBBEQ6vUchsi5P09J3
	hf27GT0up7zM20LK1f3njmN8x5Yxdm5NcLXEMabTztb6hAsGs/3/IqIrtYmeK4JZ
	S3wqEbBLG2lBcyHh4axmPWWgNk0Km/oH08aqWyck7fyxrUnLKBTOoAANNDKfQ+Oz
	k6ZKnI2EijzsbdSQDhVrHCsYmi6Xe2AkwWNIHTtLNKShuQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyjd60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:22:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4cbfc51331dso7045801cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758770555; x=1759375355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpArUBkBwSCGSXirYH+a+MgHTCrTiPbzylW7/OuHCvc=;
        b=thtv+4EAnYFeQLW2F1u4ZAK/hszmnXmBMzpV2/7isB1ejix0cRppzDJ5kriD0SiZC8
         jNep+dFcComAkp+ff5vriofxDVS5MxQ3OSbfavrGk8gasZY1PFQXzEJJTj41p5k+owdn
         oM7MMQYh7PQhWkXaGPMrp+V2sxJTJ4Q2rJhvbT36KN2FOtRllZ5qQEgnxc6fCsp7059J
         FJ5lIirW1s51GNQGzPDbiHqjRkFysqF+sOfT/9u8zNsuRFeo53jExSD533/Ds/Tq90HN
         XCZuY/Pupvc3r0KqR/18EAF+PUhVRX/BTMZi8N/oc4jQjSRATyT0gc63iLbhnqru1Z8q
         KWAg==
X-Forwarded-Encrypted: i=1; AJvYcCXT9yZXuJdbbH73lMxbm3MRU/pqxgs2MgqwqBeqSkcuFR1DMqgS7gyQuQ4033RRqzrkFSQpLm99u9wLlpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwzt+TuZtbb5G5R2ksSk22XGVnpvKNiyWb/tgjTS8n5KxDwy90
	9KCpWscEfi8C23wNggG+xOe8d6zpAgmgb7pliLjF7iXHxaF9JsYTP+wFUTpY7kTSkD/wkGWF+6G
	UV4nX0OLBaH5gJTvupydLyLwZ/qAsCIG6/7Mmi7Vlqo4EEaxBTUloMag7JFQKeLWWA/4=
X-Gm-Gg: ASbGncvs0WiqpQBUyS/GLRzo5fdNGg+/cSd8QeQGnwV48wZNVO2gE5enNTKdkkv0pSW
	Qgs1rE890jzLIpLP0HZ7YZZ/YsRpFfUMfy+SOlWugraWPyJEl2Ua9h5ll8c3yzhsMknxZLzptNJ
	kSnSykcBdWjsYqmALWJsNOlB8waLqU3eke1oBrsphHy9dkxQrqs53UJP+dNpvTt8Zz0QkoNAwTu
	zh9zYnqBluz5vzj6JOeABSejjnDeiGbg4hCDeNOTlc6BKkZAlYCthWatvVNRX+LUECGNGp14H16
	HBy5FD8JeVpqAsoBUaeFYTl5og3u60XRbY6kUzLqm+IqRKpBfTmhf9OYVDxqY6VUzuxlbICqVMB
	Pl8564gIKBj7yPI2Rl87Sfl1NPfqm9emcprevaqYuyKDTKbwDRDIi
X-Received: by 2002:a05:622a:5508:b0:4d6:3a5a:269d with SMTP id d75a77b69052e-4da4c39c529mr25537641cf.67.1758770554799;
        Wed, 24 Sep 2025 20:22:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTUdtmrhyn0t7zzPYoXxLVVNyi0tAdluJQRBBaRFKrF7eL5xwBNXuv++LT/1rjvjlu3hyNzA==
X-Received: by 2002:a05:622a:5508:b0:4d6:3a5a:269d with SMTP id d75a77b69052e-4da4c39c529mr25537391cf.67.1758770554315;
        Wed, 24 Sep 2025 20:22:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5831665624esm285483e87.69.2025.09.24.20.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 20:22:33 -0700 (PDT)
Date: Thu, 25 Sep 2025 06:22:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Tengfei Fan <tengfei.fan@oss.qualcomm.com>
Subject: Re: [PATCH 02/20] arm64: dts: qcom: Introduce Kaanapali SoC
Message-ID: <oitgxbjkjftsq6an6dbtqrb2vfwrpv7tybmo4zck24hzh7p6gr@4gochzskawnm>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-2-3fdbc4b9e1b1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-dts-v1-2-3fdbc4b9e1b1@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d4b57c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7sPlXishrNHXYsHdOZMA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: F78asSauMDobEQWOO1YYTQTpJzuTGapp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfX7B5D2vg2K+8D
 2haD+d0IEasSW6tbeDv8AWUN/QxuX8GXgN24/SYgf1+IJQw1glP/HwX/szkF/8raG23kf1JuidL
 Hj7zgk2lU4rzBe2RSfcEMUif9qBlM9vnkaSD/1XSGw611F3EDEf/C9K+41wrUViObhCTinjTaBN
 vtcG/cGd26fjmuz6WxtlX5HV/ZYzBpO+ihKjmWXkOkcS0DCdTo+vYmIL1Sk0sqoTPHR5ND0r+lv
 1GQ1+DNyX3Nvyp50RjrUw12AevNHPVDQfTE3tLGUxEF2Y6ey1QmZmiLYZQDhJRqI0xqFjSnOHVs
 djSzZdAwVjYtAb9tnpNrxgN7SVr2CAKiDNMKyYTDhRwsQELw6/w2aaaqMzDcqUt+j6xDMmhS05N
 tkSPea4P
X-Proofpoint-ORIG-GUID: F78asSauMDobEQWOO1YYTQTpJzuTGapp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

On Wed, Sep 24, 2025 at 05:17:19PM -0700, Jingyi Wang wrote:
> Kaanapali is Snapdragon SoC from Qualcomm.
> 
> Features added in this patch:
> - CPUs with PSCI idle states and cpufreq
> - Interrupt-controller with PDC wakeup support
> - Timers, TCSR Clock Controllers
> - Reserved Shared memory
> - GCC and RPMHCC
> - TLMM
> - Interconnect with CPU BWMONs
> - QuP with uart
> - SMMU
> - RPMHPD
> - UFS with Inline Crypto Engine
> - LLCC
> - Watchdog
> 
> Written with help from Raviteja Laggyshetty(added interconnect nodes),
> Taniya Das(added Clock Controllers and cpufreq), Jishnu Prakash
> (added rpmhpd), Nitin Rawat(added ufs) and Gaurav Kashyap(added ICE).
> 
> Co-developed-by: Tengfei Fan <tengfei.fan@oss.qualcomm.com>
> Signed-off-by: Tengfei Fan <tengfei.fan@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 1320 +++++++++++++++++++++++++++++++
>  1 file changed, 1320 insertions(+)
> 
> +
> +	soc: soc@0 {
> +		compatible = "simple-bus";
> +
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		dma-ranges = <0 0 0 0 0x10 0>;
> +		ranges = <0 0 0 0 0x10 0>;
> +
> +		gcc: clock-controller@100000 {
> +			compatible = "qcom,kaanapali-gcc";
> +			reg = <0x0 0x00100000 0x0 0x1f4200>;
> +
> +			clocks = <&bi_tcxo_div2>,
> +				 <0>,
> +				 <&sleep_clk>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>;

You have UFS clocks. Why are they <0> here?

> +
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +

-- 
With best wishes
Dmitry

