Return-Path: <linux-kernel+bounces-816579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D67B575B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9A0188AA44
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F46B2FB0B4;
	Mon, 15 Sep 2025 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fN2akOMG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785902FABF6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931051; cv=none; b=Vp2d5G/fYquVFSI7TQMd7CqRMurBuWYhsRWYwxxHVXanxzAAoaIihdQBnLDMu3IuOiWYv4PolJW+17UEJXDvOfjxZz8YQ9zyaczuGZRwKZdGnP8UrwdZcINHdnadVnBI0Toprw93J1FnfU+xev2qg/e3FWPKl59XVBWNZYRMNDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931051; c=relaxed/simple;
	bh=up4j8h6jtDg54emdcGVDa0vg2kAOizu71L43Aw1KSoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIHHyGP2oTd1RmLlCHWymC/9qoGQXkg1pfmKTd1Ctg7p8LXKmgEGdiFVmo3srou2qqXlnIJ3N1NPtc3t8cTj4YLfVGj9M7JoHOiEUhF6Hdn8omLwFXvSTH+sE6ycZa1fF/wqDNy77DM+k8hfNYRpwswNuiYtu60K7l1MsECuAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fN2akOMG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8FgYg005694
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bx8nSX7lM5/iTxOnkNxgDKcs
	szwsRzC2orzdwRqCT30=; b=fN2akOMGKv80kJnux5Ac6gK2O+dLakTojpIkbfxt
	8hCNe2HFtD/3CJOCDBOfLVWgQ0+zL0T70JDOYpAYRo3MyWF1RW+sFlLGSz/4YCHM
	2mnhJZlBqaqCfuQLmWfh6lcI+zidiGJDEoYnBoCmVvMjrKu++9NRKXrpNx3CCP5f
	+BJisTmF0KhQIGLwPjzy+pfkbKR5IYIYj7c8DZ/+lSRoYLgQiqtX7OhCnxR7x5XF
	puOLmLdUwk39jedrb7IbfokpoHV4MzOoo9cI772TG9vF/2tvEY3NBA3Nf49+dTYr
	YvTJ7vqaJhQGxBY7UNZxPpefzogEIcVRLWrQti1lrVjWbw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951snmbbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:10:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b793b04fe0so36600681cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757931048; x=1758535848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bx8nSX7lM5/iTxOnkNxgDKcsszwsRzC2orzdwRqCT30=;
        b=I9QMDtXwfeYoog8oFH3CblUCDzO67jIjUQCPFOohXFdcPz87yPM/5rDhMo9OBT+B/C
         l2OVhZME5Y8edo5QuXvP2OOO+pQ2MEvd09ozMzxXGUpSr4FM7f5ZGuP4rkvfGu4jeojS
         HBhF/RMW03Vh7H5Y0C3flSmNQdIsX+tL80XsKzBfRTD4wfrt5PAp90dmbXNp4rlG3oXG
         YOFpgsRm3UE1uHT9UfiSUH7Nv2xs4YCHZNXNKgUYFiTsEF0wpTV8UYOqx6FQJEVKK6FJ
         WnPjB4WDa/WwcCk0uJLtXa7t5cvOImOEhBDI0EPKlk3APFJ0/K/syCBWpu45ppfBk8i7
         wHjw==
X-Forwarded-Encrypted: i=1; AJvYcCUzQo+v9/aOWz22cbkM8A9sS17rJ/daK49OFvJDwZwMZReBI88K/KlhIzbx9w9yxzU30U1MLZ9jhiCKBvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn6JLsxjsETqOWIThULB5ArRJj84gYkXD61fG7ZVeF15HWQPZg
	fiiUx3GoxFmgfwRu7Lzi25oUN7RmGLpsQq/a96+ay3wKdfgiqxZYo5gwe2wqr5uDH1N3y+CBCd8
	XqymegQZhafiZ1KiZmBy+AUSyvsXvuzkYJB0MBIwNVSVYJTwHwbE7X9mEK6P3MyEvsYxqZVkXj2
	g=
X-Gm-Gg: ASbGncsklb7nkT5ar2pMNSYxeWEOWG+F8oYBU8wtqRdNguZkngqtjVFglCzz3DOvd06
	uMX8bLhln6/Zaj8H7ePps20aRYklNhYIGgjBcwHJUFLxWBBwAtUih/JD2nZOMfOeh3FkfWdmGsh
	arzHwsTvziul79uziNLuik/y+CqrWCyuULYpStuwMDr92Py46wjn87Y+ZyBHgM5cwzCcpxtdWrV
	8cH9YUaQfIqjL9+tpNiL/FazkbdT7ScNLkyBDL0QKdvevtIa4GWkoy8zitxt7EMyEreoKldSLqS
	6nklV6xfFkbIw2Au0R3p5dLCDmiF2jt5iHlOyEWrXhq0MoN+xCmCm9NrJepaoLI5+4Ukd4Swox0
	n37lAFFuxmKZk6z+e3qoNR4/sGuKJanblBQspmdFdXapQtotrOXnd
X-Received: by 2002:a05:622a:90e:b0:4b7:a83a:e2a1 with SMTP id d75a77b69052e-4b7a83afb2amr25074101cf.46.1757931047876;
        Mon, 15 Sep 2025 03:10:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG43syCijOLlrPYBW7Mul9l7sbVMRPIZS5uLeq5awhyyoTo/hiZcqkxUruOCeFa+VO5PZdiww==
X-Received: by 2002:a05:622a:90e:b0:4b7:a83a:e2a1 with SMTP id d75a77b69052e-4b7a83afb2amr25073821cf.46.1757931047493;
        Mon, 15 Sep 2025 03:10:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-572a5cde069sm1706782e87.13.2025.09.15.03.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:10:46 -0700 (PDT)
Date: Mon, 15 Sep 2025 13:10:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcs6490: Introduce Radxa Dragon
 Q6A
Message-ID: <33vm6uzxqbs5bukswpzdkrn3ronl7mp2q5d3j772t7lqcnvqvg@5or7jxglcynf>
References: <20250915-radxa-dragon-q6a-v3-0-a6c32d988ed7@radxa.com>
 <20250915-radxa-dragon-q6a-v3-2-a6c32d988ed7@radxa.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-radxa-dragon-q6a-v3-2-a6c32d988ed7@radxa.com>
X-Authority-Analysis: v=2.4 cv=JO87s9Kb c=1 sm=1 tr=0 ts=68c7e629 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=ksxQWNrZAAAA:8 a=ex1cviSggc2TnLhPxoUA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-ORIG-GUID: FygSRIZ2Ih-dyxsgix0aefSAJDPeHNbW
X-Proofpoint-GUID: FygSRIZ2Ih-dyxsgix0aefSAJDPeHNbW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MCBTYWx0ZWRfX6+q2ebWTQrua
 S3P73DoxfqT1Ne6D9TESTaa2uHFOsWGmij82egdqAng7u4qAyTwivHO9IBhS/RKfbt6Qic9SB3E
 cbHRwjdsqfazUF0l24B3OkL8zsR3bl4tDiwBjBX2p2JklTDRKdCzR4sI/bQcMnlyBiQDkmF9tEN
 SmIARBK8EtWPfPJBAsCe8iE6b7qbkePtLyXXaBQZAlchdWUB5wfsOJEOZu3wX0JJEi2iuwTFWeK
 mOYCBFge6gGrvUXy66nRUOFkItwHk8xNje/ikK+Gyboxh38/X7LV0z9FOPGL8ubYhG+7ORequE/
 MvYYHaUpPptKHeDYduiYWeqj3cCSZMVJ7baX8UIn+LxD2zJdjZSmnUh40r+Puuv4477Tf+dSMlk
 wJXuFu3d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130040

On Mon, Sep 15, 2025 at 09:31:44AM +0800, Xilin Wu wrote:
> Radxa Dragon Q6A is a single board computer, based on the Qualcomm
> QCS6490 platform.
> 
> Features enabled and working:
> 
> - Three USB-A 2.0 ports
> - RTL8111K Ethernet connected to PCIe0
> - eMMC module
> - SD card
> - M.2 M-Key 2230 PCIe 3.0 x2
> - Headphone jack
> - Onboard thermal sensors
> - QSPI controller for updating boot firmware
> - ADSP remoteproc (Type-C and charging features disabled in firmware)
> - CDSP remoteproc (for AI applications using QNN)
> - Venus video encode and decode accelerator
> 
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>  .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     | 961 +++++++++++++++++++++
>  2 files changed, 962 insertions(+)
> 

> +
> +&gpu_zap_shader {
> +	firmware-name = "qcom/qcs6490/a660_zap.mbn";

Is the device fused to reject standard qcs6490 firmware? If not, can we
point it to the existing files (maybe except the ADSP)? Anyway, could
you please submit the required set of files to the linux-firmware repo?

> +
> +&usb_2 {
> +	dr_mode = "host";

As Konrad has asked, please describe the onboard hub and the USB ports.
This will ensure that corresponding ports are correctly marked as
hotplug in sysfs.

> +
> +	status = "okay";
> +};
> +
> +&usb_2_hsphy {
> +	status = "okay";
> +
> +	vdda-pll-supply = <&vreg_l10c_0p88>;
> +	vdda33-supply = <&vreg_l2b_3p072>;
> +	vdda18-supply = <&vreg_l1c_1p8>;
> +};
> +
> +&venus {
> +	status = "okay";

No separate firmware?


-- 
With best wishes
Dmitry

