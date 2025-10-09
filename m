Return-Path: <linux-kernel+bounces-847492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5689EBCAFAA
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 23:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6F004F67F6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 21:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71D9283140;
	Thu,  9 Oct 2025 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GM7DdFSu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC322737E6
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046627; cv=none; b=RZA/NaGa56RW4xjR5AUsNkqVLNE1RUuugd3rU9eLUImo/psbeLtYIXK8wK3xWHiOXxtxaV/kpGC9uOnfR1I1sG9TNVVBGpYs7ZaOtVShJtqevVEWN0q7VOyfH7bLA8jtcJNE7vpbqH4FH3I/8QM7nWKehjsTFzS61pjFnSkGy6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046627; c=relaxed/simple;
	bh=BLu9bXh3SeXn9dhFIblYvzQIOzvUEK8VnsKSlzHhINE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isU2DVxUhXnoXZxJNMXh9xSrKv7MFshCtRFses7mgoQoZzrCfK0+n9oM6KiwmV9cdaQbTJW+DFgikgnN+Zpy+cTR7uUm840Sb8rPsGwTClUro/7eyRmu6BRyZ1WnbNhLxDpfzwhkQrkBij10K0JDHJpzAoQP6IRuOUFEaBKLJm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GM7DdFSu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EjXmK019212
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 21:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3udW/M/VUzzZH0gW7X2AQK2bRMAqZazBYqPcaZEzJEU=; b=GM7DdFSuwT9vIcaS
	2997nDmppuPfyQ5gHfVDIldiO6f/sfdMXJuJfFwgTZ4SkahEw74O4vvhB/6I8pPy
	0B/BeX8Z9M6ZxP6ui7muaNPnOWZT3dmrhQysLrGXvSyEjJDwo3FWYwB3NmUZljr8
	v8tz7S5XCxvjAy+Pgmn7G0eZ4CnvLpy7UVqVqhsqB+qc0lpXnCepgXmTodkWHN/v
	09wGOSvq15oCoUr+THLTKRcfn1tZiNof+ryiFTC9sMS2kBNlW+k8d3Taj6OQwBho
	5V0IMXltSzb6bLomfwx5TRFVzcR0zU8TjayyCsbpEU3PYdgpm4rEvQ4WcC8DlqGG
	9KPJvg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nvbxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 21:50:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4df60ea7a1bso51045231cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760046622; x=1760651422;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3udW/M/VUzzZH0gW7X2AQK2bRMAqZazBYqPcaZEzJEU=;
        b=cuPOxH7IaFrOZ6Bzy9WFeQQim4BHN0cM++Td2Baoj0XGPi3MYwB3PxXJQwofLkLLYu
         DL+D+RtjSXnOk7UIcoF+CoctkP/0GtW4j8ujYy69/Xp9hGHtl9ERbUb//c1eZZDgRWtd
         gL+5ExT5FfZf2wb3IaGpAAxsPHXWIrh35ZQmv1GYaAMMVqdYFw6WPS5/PvKyVvw/bY2J
         JdxaR0U1mkCL5t/3I/dzDwrEDdZVe+8/tPyembSiusVSbVZfPMsJ+Ll6M8qWMyx6Wre5
         xTjqt8uyZ4pq6jM+yXnrpA7db6LV5Vbc/elthKz9lXQGrPs90AZQJ8dcizWB+O8wk6nl
         fUmA==
X-Forwarded-Encrypted: i=1; AJvYcCXMtQjq3AKNxRRDzirPeK6P3Vd6YQhv0hVWYdh62U1pVFpedQK+k9+xs0+DpUKX+d2ngTVnvB7epRyGeS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0EzyFrcQZQBh5N6svHrb90b5okg4k48mlCwIkw5rP1O2w78OU
	w0l3RVOpqSf4lkoQwbQrqHD6BS/uDIQdOfHjYfeMAtgCezke6vdyrWHuEiCNy/7l2oFYrvxmOkO
	1PagsS+fyiI+tFZ1OviEJfxkBcehncCD3tObtmWwn/HvMtUUaGgXfYDal2cYdkpqn5n4=
X-Gm-Gg: ASbGncuvKHVwBeRPxcSvtcfbMaV5GNxUxspUssyNrIqX6dR8FQjO0YYsphLwbDbSTpP
	DgasA78dCgvSpGGoKPgedfTl0cCr88JzTKwHBeDQ0JHEVL9hYe20VTp/y5zG2/7sSLv+DCYDLhL
	I1SoSwirR61lvIEe2DZwQyTyVTyd+UlEOAMr1jRFzEamRhLY8F30evFq3itwwl/mpIMaAHe+WAB
	LqydTQL1KHjL2qU+4kv1w2DkbNRAVWgwBZzg87yEqoK5Vz6wb3hHcU11JVs1nIrvpTXef0PwIFT
	HsyYE+IhkDHW2KuoKU6Gr/E6+lFJHjp27Hp0ZRdMZDJXIM3jFFO1YYA2OJzrfWZNKBgHDkA98Gg
	qPX/1OzeYZDvCAZwovaehQv3KN3DsgPUAR0I6tJGP/gcl1kJ98wwGDZB+FA==
X-Received: by 2002:a05:622a:2c06:b0:4d9:f384:769f with SMTP id d75a77b69052e-4e6eacccf16mr95744631cf.12.1760046621796;
        Thu, 09 Oct 2025 14:50:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKNW2IrV/xJOYX3FCvpP8yoGVs0AIBQ7rbhAcz/8DxXr/uXaCm4UIW5hZbtDy6JTKSPbOnRg==
X-Received: by 2002:a05:622a:2c06:b0:4d9:f384:769f with SMTP id d75a77b69052e-4e6eacccf16mr95744181cf.12.1760046621214;
        Thu, 09 Oct 2025 14:50:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881f91c0sm219883e87.41.2025.10.09.14.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:50:18 -0700 (PDT)
Date: Fri, 10 Oct 2025 00:50:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: David Heidelberg <david@ixit.cz>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Casey Connolly <casey@connolly.tech>,
        Joel Selvaraj <foss@joelselvaraj.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add support for Pixel 3 and Pixel
 3 XL
Message-ID: <6yqj2yblobathatoilox3fk75mvlsif4sley2zb2o4qv2elvt3@y7t7rsaczpad>
References: <20251005-pixel-3-v1-0-ab8b85f6133f@ixit.cz>
 <20251005-pixel-3-v1-2-ab8b85f6133f@ixit.cz>
 <n4xims4y5sssqxkchg2tikc7idkzds5ru7ayidcgxdfx77je2d@qo34qucbebnn>
 <0f5f2793-13d6-416e-ad0e-1840e22b753c@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f5f2793-13d6-416e-ad0e-1840e22b753c@ixit.cz>
X-Proofpoint-ORIG-GUID: oDXu0SHlcaBKe4q-oKF7iCioEDJixscK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX4dN4DyUE0icq
 cCXNAVEpSS08EE8neSWVL+yrkle7cDg3bv8BzWhxSvpKYTzqvMHM9CeghFfcFm1OFMcAxM95Q0R
 nE/XQPG0cd5ORmIh9cSfWukMsZ2xvbas037esYJ5052a2x29Yz82I4Dppss+ST4wN/IQQzrGZow
 dDy/gWdwh7e6/yRSjmO2qowHzOwu8On2awok2Y8bXo5+hoTxAlbzyhbdjamr+H6yJtofzLskQZ7
 SM7fyo+J0bWL/KtFVfmE+Eyh1c+trNjI/Che1HFh8HOlsMpL2nf5gtHpWV4pXgx464jOwBi8kJD
 siPozhq3h+THkFRG9JRF4UYYaoAQQxqt5+p/nHmJ1uaJFfE+PScSId13s2L5X1Se7JYVsAZfoOT
 PuU1Ka1c/H1O5MoIwjApxVjdqn+ySA==
X-Proofpoint-GUID: oDXu0SHlcaBKe4q-oKF7iCioEDJixscK
X-Authority-Analysis: v=2.4 cv=b6a/I9Gx c=1 sm=1 tr=0 ts=68e82e1e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=Gbw9aFdXAAAA:8 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8
 a=KKAkSRfTAAAA:8 a=WFa1dZBpAAAA:8 a=VwQbUJbxAAAA:8 a=9PFAu1EmyVEcRf1xKSUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=9vIz8raoGPyDa4jBFAYH:22 a=cvBusfyB2V15izCimMoJ:22 a=MZguhEFr_PtxzKXayD1K:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 11:20:49PM +0200, David Heidelberg wrote:
> On 06/10/2025 00:03, Dmitry Baryshkov wrote:
> > On Sun, Oct 05, 2025 at 03:16:29PM +0200, David Heidelberg via B4 Relay wrote:
> > > From: David Heidelberg <david@ixit.cz>
> > > 
> > > This adds initial device tree support for the following phones:
> > > 
> > >   - Google Pixel 3 (blueline)
> > >   - Google Pixel 3 XL (crosshatch)
> > 
> > Great to finally see it being submitted!
> > 
> > > 
> > > Both phone boards use the same identifiers and differ only slightly
> > > in their connected peripherals.
> > > 
> > > Supported functionality includes:
> > >   - Debug UART
> > >   - UFS
> > >   - Charger
> > >   - USB-C (peripheral mode)
> > >   - Display (Pixel 3 only)
> > 
> > No remoteprocs / IPA / GPU / Venus / WiFi / BT? The firmware is
> > accessible to download from Google and it can be further repackaged (but
> > not redistributed). See [1], [2].
> 
> Since I didn't have Pixel 3 at hand to test (I sent the series when
> attending event where someone had Pixel 3 ;-) ), I was aiming to merge MVP..
> more precisely, Minimal Viable Device-tree (MVD).

If you have Pix3 XL, you can use it for both. I think the only major
difference is the screen.

> Until the end of the month I should have also Pixel 3, so I'll definitely
> continue to enable all the mentioned features, but as this DTB is also
> needed for u-boot [1], I would prefer to get MVD in ASAP, mostly because of
> the fastboot is useless for loading mainline kernel.

Hmm? I was using onboard ABL and fastboot.

> 
> [1] https://gitlab.postmarketos.org/tauchgang
> 
> Before I'll send the v2, the progress can be tracked in
>   https://gitlab.com/dhxx/linux/-/commits/b4/pixel-3
> 
> Thank you both for the review!
> David
> 
> > 
> > The phones share all firmware except for the bdwlan, so hopefully you
> > can add 'Google/blueline/foo.mbn' to the common file.
> > 
> > [1] https://github.com/linux-msm/meta-qcom-extras/blob/master/recipes-bsp/firmware-nexus/firmware-qcom-pixel3.bb
> > [2] https://github.com/linux-msm/meta-qcom-extras/blob/master/recipes-bsp/firmware-nexus/firmware-qcom-pixel.inc
> > 
> > > 
> > > GPIOs 0–3 and 81–84 are not accessible from the application CPUs,
> > > so they are marked as reserved to allow the Pixel 3 to boot.
> > > 
> > > The rmtfs region is allocated using UIO, making it technically "dynamic."
> > > 
> > > Its address and size can be read from sysfs:
> > > 
> > > $ cat /sys/class/uio/uio0/name
> > > /sys/class/uio/uio0/maps/map0/addr
> > > 0x00000000f2701000
> > > 
> > > $ cat /sys/class/uio/uio0/maps/map0/size
> > > 0x0000000000200000
> > > 
> > > Like the OnePlus 6, the Pixel 3 requires 1 kB of reserved memory on either
> > > side of the rmtfs region to work around an XPU bug that would otherwise
> > > cause erroneous violations when accessing the rmtfs_mem region.
> > > 
> > > Co-developed-by: Amit Pundir <amit.pundir@linaro.org>
> > > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > > Co-developed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Co-developed-by: Casey Connolly <casey@connolly.tech>
> > > Signed-off-by: Casey Connolly <casey@connolly.tech>
> > > Co-developed-by: Joel Selvaraj <foss@joelselvaraj.com>
> > > Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
> > > Co-developed-by: Sumit Semwal <sumit.semwal@linaro.org>
> > > Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> > > Co-developed-by: Vinod Koul <vkoul@kernel.org>
> > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > Signed-off-by: David Heidelberg <david@ixit.cz>
> > > ---
> > >   arch/arm64/boot/dts/qcom/Makefile                  |   2 +
> > >   .../arm64/boot/dts/qcom/sdm845-google-blueline.dts | 128 ++++++
> > >   arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi | 467 +++++++++++++++++++++
> > >   .../boot/dts/qcom/sdm845-google-crosshatch.dts     | 137 ++++++
> > >   4 files changed, 734 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > > index 4bfa926b6a085..ba05dc935dc7c 100644
> > > --- a/arch/arm64/boot/dts/qcom/Makefile
> > > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > > @@ -239,6 +239,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c.dtb
> > >   sdm845-db845c-navigation-mezzanine-dtbs	:= sdm845-db845c.dtb sdm845-db845c-navigation-mezzanine.dtbo
> > >   dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c-navigation-mezzanine.dtb
> > > +dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-google-crosshatch.dtb
> > > +dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-google-blueline.dtb
> > >   dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-lg-judyln.dtb
> > >   dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-lg-judyp.dtb
> > >   dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-mtp.dtb
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts b/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
> > > new file mode 100644
> > > index 0000000000000..df88982018b9e
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
> > > @@ -0,0 +1,128 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "sdm845-google-common.dtsi"
> > > +
> > > +/ {
> > > +	model = "Google Pixel 3";
> > > +	compatible = "google,blueline", "qcom,sdm845";
> > > +
> > > +	battery: battery {
> > > +		compatible = "simple-battery";
> > > +
> > > +		charge-full-design-microamp-hours = <2970000>;
> > > +		voltage-min-design-microvolt = <3600000>;
> > > +		voltage-max-design-microvolt = <4400000>;
> > > +	};
> > > +
> > > +	chosen {
> > > +		#address-cells = <2>;
> > > +		#size-cells = <2>;
> > > +		ranges;
> > > +
> > > +		/* for u-boot */
> > > +		framebuffer: framebuffer@9d400000 {
> > > +			compatible = "simple-framebuffer";
> > > +			reg = <0 0x9d400000 0 (2160 * 1080 * 4)>;
> > > +			width = <1080>;
> > > +			height = <2160>;
> > > +			stride = <(1080 * 4)>;
> > > +			format = "a8r8g8b8";
> > > +		};
> > > +	};
> > > +
> > > +	reserved-memory {
> > > +		framebuffer_region@9d400000 {
> > 
> > Can't we use cont_splash_mem and let bootloader set it?
> > 
> > > +			no-map;
> > > +			reg = <0 0x9d400000 0 0x02400000>; // FIXME
> > > +		};
> > > +	};
> > > +};
> > > +
> > > +&gmu {
> > > +	status = "okay";
> > > +};
> > 
> > No need to, it's enabled by default.
> > 
> > > +
> > > +&mdss {
> > > +	status = "okay";
> > > +};
> > > +
> > > +&mdss_dsi0 {
> > > +	status = "okay";
> > > +	vdda-supply = <&vdda_mipi_dsi0_1p2>;
> > > +
> > > +	ports {
> > > +		port@1 {
> > > +			endpoint {
> > > +				remote-endpoint = <&panel_in>;
> > > +				data-lanes = <0 1 2 3>;
> > > +				qcom,te-source = "mdp_vsync_e";
> > 
> > &mdss_dsi1_out {
> > 	remote-endpoint = <&panel_in>;
> > 	.....
> > };
> > 
> > 
> > > +			};
> > > +		};
> > > +	};
> > > +
> > > +	panel@0 {
> > > +		compatible = "lg,sw43408";
> > > +		reg = <0>;
> > > +
> > > +		vddi-supply = <&vreg_l14a_1p88>;
> > > +		vpnl-supply = <&vreg_l28a_3p0>;
> > > +
> > > +		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
> > > +
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&panel_reset_pins &panel_te_pin &panel_pmgpio_pins>;
> > > +
> > > +		port {
> > > +			panel_in: endpoint {
> > > +				remote-endpoint = <&mdss_dsi0_out>;
> > > +			};
> > > +		};
> > > +	};
> > > +};
> > > +
> > > +&mdss_dsi0_out {
> > > +	remote-endpoint = <&panel_in>;
> > > +	data-lanes = <0 1 2 3>;
> > > +};
> > > +
> > > +&mdss_dsi0_phy {
> > > +	vdds-supply = <&vdda_mipi_dsi0_pll>;
> > > +
> > > +	status = "okay";
> > > +};
> > > +
> > > +&pm8998_gpios {
> > > +	panel_pmgpio_pins: panel-pmgpio-active-state {
> > 
> > Are these two actually used by the panel? I think they were only used
> > for sw43402, but not for sw43408.
> > 
> > > +		pins = "gpio2", "gpio5";
> > > +		function = "normal";
> > > +		input-enable;
> > > +		bias-disable;
> > > +		power-source = <0>;
> > > +	};
> > > +};
> > > +
> > > +
> > > +	volume-keys {
> > 
> > gpio-keys ?
> > 
> > > +		compatible = "gpio-keys";
> > > +		label = "Volume keys";
> > > +		autorepeat;
> > > +
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&volume_up_gpio>;
> > > +
> > > +		key-vol-up {
> > > +			label = "Volume Up";
> > > +			linux,code = <KEY_VOLUMEUP>;
> > > +			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
> > > +			debounce-interval = <15>;
> > > +		};
> > > +	};
> > > +
> > > +	vph_pwr: vph-pwr-regulator {
> > 
> > Nit: BCP is regulator-foo-bar
> > 
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "vph_pwr";
> > > +		regulator-min-microvolt = <3700000>;
> > > +		regulator-max-microvolt = <3700000>;
> > > +	};
> > > +
> > > +	vreg_s4a_1p8: vreg-s4a-1p8-regulator {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "vreg_s4a_1p8";
> > > +
> > > +		regulator-min-microvolt = <1800000>;
> > > +		regulator-max-microvolt = <1800000>;
> > > +		regulator-always-on;
> > > +		regulator-boot-on;
> > > +
> > > +		vin-supply = <&vph_pwr>;
> > > +	};
> > > +};
> > > +
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-crosshatch.dts b/arch/arm64/boot/dts/qcom/sdm845-google-crosshatch.dts
> > > new file mode 100644
> > > index 0000000000000..dc9938ffc0ab8
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845-google-crosshatch.dts
> > > @@ -0,0 +1,137 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "sdm845-google-common.dtsi"
> > > +
> > > +/ {
> > > +	model = "Google Pixel 3 XL";
> > > +	compatible = "google,crosshatch", "qcom,sdm845";
> > > +
> > > +	battery: battery {
> > > +		compatible = "simple-battery";
> > > +
> > > +		charge-full-design-microamp-hours = <3480000>;
> > > +		voltage-min-design-microvolt = <3600000>;
> > > +		voltage-max-design-microvolt = <4400000>;
> > > +	};
> > > +
> > > +	chosen {
> > > +		#address-cells = <2>;
> > > +		#size-cells = <2>;
> > > +		ranges;
> > 
> > These are all the same as the -blueline. Please move common options to
> > the -common.dtsi
> > 
> > > +
> > > +		/* for u-boot */
> > > +		framebuffer: framebuffer@9d400000 {
> > > +			compatible = "simple-framebuffer";
> > > +			reg = <0 0x9d400000 0 (2960 * 1440 * 4)>;
> > > +			width = <1440>;
> > > +			height = <2960>;
> > > +			stride = <(1440 * 4)>;
> > > +			format = "a8r8g8b8";
> > > +		};
> > > +	};
> > > +
> > > +	reserved-memory {
> > > +		framebuffer_region@9d400000 {
> > > +			no-map;
> > > +			reg = <0 0x9d400000 0 0x02400000>;
> > > +		};
> > > +	};
> > > +};
> > > +
> > > +&gmu {
> > > +	status = "okay";
> > > +};
> > > +
> > > +&mdss {
> > 
> > More and more common properties. Please move them to the common file.
> 
> Sorry about this, the mdss nodes got in by accident, the display driver for
> crosshatch is WIP.>
> > > +	status = "okay";
> > > +};
> > > +
> > > +&mdss_dsi0 {
> > > +	vdda-supply = <&vdda_mipi_dsi0_1p2>;
> > > +
> > > +	status = "okay";
> > > +
> > > +	ports {
> > > +		port@1 {
> > > +			endpoint {
> > > +				remote-endpoint = <&panel_in>;
> > > +				data-lanes = <0 1 2 3>;
> > > +				qcom,te-source = "mdp_vsync_e";
> > > +			};
> > > +		};
> > > +	};
> > > +
> > > +	panel@0 {
> > > +		compatible = "samsung,s6e3ha8";
> > > +		reg = <0>;
> > > +
> > > +		vci-supply = <&vreg_l28a_3p0>; // downstream
> > > +		vdd3-supply = <&vreg_l28a_3p0>;
> > > +		vddr-supply = <&vreg_l14a_1p88>;
> > > +
> > > +		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
> > > +
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&panel_reset_pins &panel_te_pin &se8_spiflash &panel_pmgpio_pins>;
> > 
> > - Why do you need spiflash here?
> > - I don't think this uses pmgpios too.
> > 
> > > +
> > > +		port {
> > > +			panel_in: endpoint {
> > > +				remote-endpoint = <&mdss_dsi0_out>;
> > > +			};
> > > +		};
> > > +	};
> > > +};
> > > +
> > > +&mdss_dsi0_out {
> > > +	data-lanes = <0 1 2 3>;
> > > +	remote-endpoint = <&panel_in>;
> > > +};
> > > +
> > > +&mdss_dsi0_phy {
> > > +	vdds-supply = <&vdda_mipi_dsi0_pll>;
> > > +
> > > +	status = "okay";
> > > +};
> > > +
> > > +&pm8998_gpios {
> > > +	panel_pmgpio_pins: panel-pmgpio-active-state {
> > > +		pins = "gpio2", "gpio5";
> > > +		function = "normal";
> > > +		input-enable;
> > > +		bias-disable;
> > > +		power-source = <0>;
> > > +	};
> > > +};
> > > +
> > > +&tlmm {
> > > +	se8_spiflash: se8-spiflash-state {
> > > +		pins = "gpio65", "gpio66", "gpio67", "gpio68";
> > > +		function = "gpio";
> > > +		input-enable;
> > > +		bias-disable;
> > > +	};
> > > +
> > > +	panel_te_pin: panel-te-state {
> > > +		pins = "gpio12";
> > > +		function = "mdp_vsync";
> > > +		drive-strength = <2>;
> > > +		bias-pull-down;
> > > +	};
> > > +
> > > +	panel_reset_pins: panel-active-state {
> > > +		pins = "gpio6";
> > > +		function = "gpio";
> > > +		drive-strength = <8>;
> > > +		bias-disable;
> > > +	};
> > > +
> > > +	panel_suspend: panel-suspend-state {
> > > +		pins = "gpio6";
> > > +		function = "gpio";
> > > +		drive-strength = <2>;
> > > +		bias-pull-down;
> > > +	};
> > > +
> > > +};
> > > 
> > > -- 
> > > 2.51.0
> > > 
> > > 
> > 
> 
> -- 
> David Heidelberg
> 

-- 
With best wishes
Dmitry

