Return-Path: <linux-kernel+bounces-801340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B106B443E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41621899814
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78C02F3C0C;
	Thu,  4 Sep 2025 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DElUdKsm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C277E1E9B0D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005567; cv=none; b=XlEtNCmeHG/lyFU6FE8ZRS/0Yama0Il9VFMVQon70OOEatADelTeS7VYrYxl3jzgc+yCKD4DwQ7w0Oq/UwjmG5jkafyGTdATCr6VyevSYxPR5Ue8EmwgMu+j8cU0aMPjoz2DJR+Z1fpCeIlSZTi3NTBM+Cp/Frgi1l1+x1teJTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005567; c=relaxed/simple;
	bh=kex9c5ksWfEy4HCkCcEs7BW59/eVjTYWD+ai1fAWMMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7XDehLZ/TNEYi5cSREL69hA81XjTBRaWEnle3lq7CPqkFiuZJiRmJMRSsVyE2IIl3AavyhbLvSvnn4ZyyJIU0DXnFHR0hEwMAh6mGCkYRCvWcP949nNxxXYmMjsaEMyPU/oSV/tvJfQDOY3kG5uOPogW1lOv9Ekcijqui+AVhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DElUdKsm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584Ba5BL014923
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 17:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3TzY0hMaxnKfqA1+sr6FktM0
	GXuI/kkBpqMcqTX1ICw=; b=DElUdKsmHvnopTMyaZF3Di+MG2ZJ4rZMh1DSoVVL
	sP4nkXD6wVBujv8ed0Ov8YPMOpf3/Rzj/MbsbDRdfQrkVhO4EeD4UNyhT7j8JZrL
	BYamhpU98BRZqL2uYMoJyazUwD6lb2zcqpHqXRu6bCeBUDYJEfmGqaPDn8HXVKTN
	JdURNvl/qezicwLXXxbTuczXMj1uYVqbw1uRk+bJfFjfTzaFZaUvTQGVDDrU5pmP
	SYRe+5nTutwPbr3B7+14ADvFI34GkbaqzUDP7ZvhFKXFJGNquibQJ4+ExuCHNvxe
	7vQUCe23lhY3muyTM9tvrDYBj504fHQt53gqVpCDuOwhFQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush3861b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 17:06:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b52047b3f21so166362a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 10:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757005564; x=1757610364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TzY0hMaxnKfqA1+sr6FktM0GXuI/kkBpqMcqTX1ICw=;
        b=NeoYxxx3X+Nngj38I0jMCurEoQTyX94zdifEb69OlfwCZwSZvoJlj4np8EJ0WEO6if
         gw7/sGPYkHMKV/oPqcFrGKNJOmg84ZLhJFD5vFwL27fAaGuvo+/dAzGtJ3Goxl6p2zTE
         U90Kbc99r5im4HmXhA7nQ+bb1afcwPDnfofB/ekgD8WnaZYA6wbGv9E4CWi/mjGDSXUw
         T1fFzNXkZSn7yzJac3OtQdKUIVwKgLtem2W+VoyPnFbPi3+m6s5ZHgw9+g5yxsDuOvPa
         7Z9H2zf6DVFSia8qBu4O64eMB4B7qATheKL0iNQU54uDWKks8JVvbGUmfz9/dcBzF8gU
         /r7w==
X-Forwarded-Encrypted: i=1; AJvYcCUvS4yGHEAOj7MKT3yb/Hd19g13Y6arGIZ1Mbc7J7gHSRFDjWDhW12qyy6eo5juSmiE4nT1e+eFD0XCm0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHkcsOW0wQTJUzNUQTQVUCeNGBYjSEJYSIdvTcg2V0zU0quJG3
	V6LWDFyZKSjbJIqzVe1Td/qgVE6itsozSKfc6YdPB2KMN4TMXu5gAQWE5rc3F7yFyVZfOvPJq9S
	ie1kUCKJPi12dll0MVEFPFoLZ5j5JPPmgK/1jiYTf9vElCjM14SjPa/dIi/eFqJ9fBxQ=
X-Gm-Gg: ASbGncu2s+00CW9m3Af8yp9FihvVIDhKS8dKvBVho/OuSc0wYR9hHjwRBAimXmcne9S
	0zKk1wblMu8MIQB2jq3OZclcjb+joNfi7x7oYAKJwA79bizNUd/9jdVN120g88/BRrMmoXBh7EQ
	NongsN3ScrLt6gl52A5ropEc4r3cNmfLwCSGSIabQ01SJgrHi9sDPYV0I5HtTZAb2zIMwaVRWUI
	SaOYsr2x8Hfk4hUighZvxeQj2Jj4cT8Xbq1hadl6AOovZ4gnUxcUvqIuZxpIPIQ7mr8t+eiD9gH
	yURq17NHlIVvR7BCw+1ffZII02xlQYZZffsgu8HWTsp0aveptDWYZ6VVNyQzvTWOBELHpg1h1Q=
	=
X-Received: by 2002:a05:6a20:5493:b0:243:d1bd:fbc9 with SMTP id adf61e73a8af0-243d6f7ef68mr28359325637.56.1757005563995;
        Thu, 04 Sep 2025 10:06:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjvSHSjScVhR0qGM4Bgt7y43u2+FjqX3ZFKJAbEdvUCzRzNDRc6FFqe8gLPFasv7ahFh/NAw==
X-Received: by 2002:a05:6a20:5493:b0:243:d1bd:fbc9 with SMTP id adf61e73a8af0-243d6f7ef68mr28359260637.56.1757005563354;
        Thu, 04 Sep 2025 10:06:03 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2b97sm17564167b3a.67.2025.09.04.10.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 10:06:03 -0700 (PDT)
Date: Thu, 4 Sep 2025 22:35:57 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        hrishabh.rajput@oss.qualcomm.com,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support for Gunyah Watchdog
Message-ID: <91002189-9d9e-48a2-8424-c42705fed3f8@quicinc.com>
References: <20250903-gunyah_watchdog-v1-0-3ae690530e4b@oss.qualcomm.com>
 <a3af076b-ca0b-4d5e-8294-2bf5a9814959@linaro.org>
 <ec0dc13a-30f7-44a0-9a4a-5f44eccd3933@quicinc.com>
 <qd22epqcu7sdza6jrl3tj7pceohqh3clsywv44uau5bvszux54@ajqseswmwf6x>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qd22epqcu7sdza6jrl3tj7pceohqh3clsywv44uau5bvszux54@ajqseswmwf6x>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX060jZpufoTEg
 C5nwMRsl0AcaxnzrG39aPum7ECrrZeOLGarIHX9kcrWRLTsmDGedhK7ywxxOeJd4emCCOgWtt4S
 SoWihhh9t7Z9qYHw5IdDJIfGuEH5MHZLUtCMSh9AV+zl1oq1okkj6wrDm93Ke2XZkyGblsns1ga
 E1v6sLJi9NqtKc1zahxiB4qIqF7KKX2ivE7JIbBvnbXtu9/9jrG0anIPHCj8ztu5PevsdZtDhtj
 Qja/J7zE/CdgdlWYhzeB0w1fVx37PHmukrTQhT8ozQ97BVBoAJfIppE9xr4WuHSwN6GW1EVMWMd
 /mLKgn/Cy3SmoBDhDUffWy3cKWC7sNzYWN/lGRfzXLF5auZu4ARBOE/8oKAv1YGzqbnIM+uxT0p
 aRhYK2Qu
X-Proofpoint-ORIG-GUID: pP12JO0adBhUS2yVeX-gYEu6_W_ts4m7
X-Proofpoint-GUID: pP12JO0adBhUS2yVeX-gYEu6_W_ts4m7
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b9c6fc cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=GWRR-jdfUFecq8Rc7ecA:9
 a=CjuIK1q_8ugA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

On Thu, Sep 04, 2025 at 08:53:14AM -0500, Bjorn Andersson wrote:
> On Thu, Sep 04, 2025 at 02:48:03PM +0530, Pavan Kondeti wrote:
> > On Thu, Sep 04, 2025 at 09:13:23AM +0200, Neil Armstrong wrote:
> > > On 03/09/2025 21:33, Hrishabh Rajput via B4 Relay wrote:
> > > > Gunyah is a Type-I hypervisor which was introduced in the patch series
> > > > [1]. It is an open source hypervisor. The source repo is available at
> > > > [2].
> > > > 
> > > > The Gunyah Hypervisor doesn't allow its Virtual Machines to directly
> > > > access the MMIO watchdog. It either provides the fully emulated MMIO
> > > > based watchdog interface or the SMC-based watchdog interface depending
> > > > on the hypervisor configuration.
> > > > The SMC-based watchdog follows ARM's SMC Calling Convention (SMCCC)
> > > > version 1.1 and uses Vendor Specific Hypervisor Service Calls space.
> > > > 
> > > > This patch series adds support for the SMC-based watchdog interface
> > > > provided by the Gunyah Hypervisor. The driver supports start/stop
> > > > operations, timeout and pretimeout configuration, pretimeout interrupt
> > > > handling and system restart via watchdog.
> > > > 
> > > > This series is tested on SM8750 platform.
> > > 
> > > Would this driver work on older platforms like SM8550 & SM8650 ?
> > > 
> > 
> > This driver should work on 8550 and 8650 too as long as the hypervisor
> > overlay is applied to the device tree which happens in the bootloader.
> > 
> 
> You have easy access to 8550 and 8650 MTP/QRD devices, please give us a
> definitive answer.
> 

Thanks for asking this question. I believe the overlay part needs some
discussion here.

I have tried this series on 8550 MTP. The overlay failed, so watchdog
device did not probe. same is the case with 8750 too. It works only
after applying this patch. I will test and report my observation on 8650
later.

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 140b0b2abfb5..b200e8faa6df 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+DTC_FLAGS := -@
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
 
 apq8016-sbc-usb-host-dtbs	:= apq8016-sbc.dtb apq8016-sbc-usb-host.dtbo
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index eac8de4005d8..7536b1a4ec97 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -328,7 +328,7 @@ cluster_sleep_1: cluster-sleep-1 {
 	};
 
 	firmware {
-		scm: scm {
+		scm: qcom_scm {
 			compatible = "qcom,scm-sm8550", "qcom,scm";
 			qcom,dload-mode = <&tcsr 0x19000>;
 			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
@@ -4855,6 +4855,9 @@ compute-cb@8 {
 				};
 			};
 		};
+
+		qcom_tzlog: tz-log {
+		};
 	};
 
 	thermal-zones {
@@ -5913,7 +5916,7 @@ trip-point2 {
 		};
 	};
 
-	timer {
+	arch_timer: timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,


Thanks,
Pavan

