Return-Path: <linux-kernel+bounces-893156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F646C46A60
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA3D634828C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9366430EF9F;
	Mon, 10 Nov 2025 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nbrt13bM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N48NBs2I"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291A530CD89
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778398; cv=none; b=JBF2OmIHQ6r8EqXE3RnTca5rrE5IGyiEwsX20cetInQYXDs+z6/fuW8RcoQiiynj1o6sP3V9/zzKngS4xnfGr4ScfuTKNFj5XGCMFg0JhbeEJGbtBgt/Rc03RrtTg2mW87oAQ41LQLQoC1HP6nSGzpwsnTu3Ut8iHpFJ1VO+M5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778398; c=relaxed/simple;
	bh=s5bT3zIoVvaOrqZjXmaXl5K/k9tFKIDXPV2xPakWMgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vm/nTTqT2iCpe0rcCDDZLXMO/fRwLd24yZF/fKAZ4KgrJ8/xnJ+U1mzAL3Rm/FYb5zRk5rUaMCWpbA0D8rmg1COT3Xpr20Nj4D81mfXgFJESwO6/NqgpPx3VAxk0+FGUHUIKgFA41CA6QUTubEpuoQk+kP/aX4FJp1BHleqmQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nbrt13bM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N48NBs2I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA7hN8W2861413
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=e2IgPVPyVRRsi/D1MFmgaBqG
	T72nrHauEpDjvZrgZuI=; b=nbrt13bM+lUj0jm5eumHNYlAygG8/VKbbvzM8gw5
	X+jVwMljLMS3JEpFW3rzvDMlPt1LnyOlutiKVaPRGkxXXOuDsfQn5PjjaZ560nsQ
	XqycPkbcBvTXTNOsO72XR7YXCwPFRPx8jU9GuHyfWLJAcuojz8cwfi3ZeSv/WP+6
	4D6X5S8D490C2Q8DbSvrlCK2h79ZO5gA7T9heFeaVCFzQW7GQEoYl9iOrgcxSIag
	tvMDk48I/v8B5zKOqGOXkNCEaEJBpb5OQSifyVrSB6JhbcpSWYXXkT8nJ2vkLUh6
	ai/k70HiQIoBqLnIwE8bysAKnsvmL582DUTIjIejPrFeqw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abbwe0y55-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:39:55 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b969f3f5c13so2896331a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762778395; x=1763383195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2IgPVPyVRRsi/D1MFmgaBqGT72nrHauEpDjvZrgZuI=;
        b=N48NBs2IVkdTHwPBPwf+3Vu2cNPkayqcmkek3NmdcvdY/gbyBP8kjGN9C+BZ+q25X5
         n4S5LU8w591t2njbpd1XA90YsqjPkLfg+IIXr6QZ60I/UJ57kS2k7rv6PfNtRPL3K2Lz
         F/HzRibs/tLcSLj0NuveKf5PG4tLn4BeN6bowzUsad6GiCVCR8JEhdE1sJ+cQqTXsOsM
         ZdRAQLyCaScWqtqFBPeqhykZKvCXo4HZxhk1mgQqLACG9sPjbMAQse6GRQP1fYhO6ChF
         RAWovhzl46tztC9WF55syZgtcOFXf9BcMk39uzrLxlpupK6ezLaArVXcV7OudRFVIjke
         pjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778395; x=1763383195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2IgPVPyVRRsi/D1MFmgaBqGT72nrHauEpDjvZrgZuI=;
        b=OOUoccHQdPnsJf7+Xzn13EDBTXCA5ydJrQcHALRYE2PX4G68NtAczeZ6NeHHYPVMGe
         aoek5Q7Zo6z15wuUpOMG+oZGOwwpFjCRf5GhTK7ulhtcY9uGw5AKPkgsIzKE3fJtNXHp
         ah8qKSwIijG00xpU3hEAGmKXMYPDuMIcDTjGdwCkI5x3AvDSvyKAQX5V90ssExu68jQj
         JrDT2tS+YrFjSsPlgIlkpTXwd3whtx3sboshhNk5JceK6iXfGfudQ5pSobghYuDdW4cZ
         wXB/fLeFI2Ne7Ey1tIyvCAEsspDPNugHxyVslQNC9ryhdCGMS+bzYvf3IJWS/teSrd6X
         1s/g==
X-Forwarded-Encrypted: i=1; AJvYcCVjsQCR8l9TjOpsttLu6mSR5aP+UwU0vTsuo3q4wQZ2Zi3YM3PKSP+m/gkiBX4SdbqkBGe811JltRrRsH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeqrKSgsnOrn/2ZL3OFiJw0wTrgMlrBXRSX1HstNtzE+tfySpm
	Q5B3mBSu0oxrBVOyxxS/rwiNzWAN/pgLVhFivJgTpX2m6m0YDJB8aA+MjMf97cYTHjMUgcEvocv
	KUVatfv9+joj2kXM360bEUdw663WAxFvA+3pLabIuknCttCmkTmkglFe25xtMGglMHBY=
X-Gm-Gg: ASbGncuOo6b6pIt2x5f8bLphNOz8RNYyvbTV07bov5lvjsgHMYbFMonm6GAvtZMSkRS
	O+gMpTlAHAT77qqpa1T332W0vmxRZ0NO/THedDl1q6IZgXk3NBzanaAC7x6ovCJ0qZzk7IuBw1t
	JR2rWReDQSk5OEWQ5VuntZwxLcSlWXiIOxJeKcIhAgZdiRhS8Bz+zU5SBKRZvGDXEi5AoEYx35v
	j+gdv6NeR8MD+xahXATN/pICaw3n8IcDC8b4RnE4ud6RlHEjElQVzixTfxDvrEwjiJdpaeCEqAG
	ity9ZTspyzL4P11ZQ97tb7RHJZL/PkcT7Ub1TW54LFdd8jqLCXaR879JCdcE2BAuQNJnti+W8ZC
	STT5WR15mQB+zpjXt9QM9fefELA==
X-Received: by 2002:a05:6a20:1590:b0:34e:a801:8168 with SMTP id adf61e73a8af0-353a3761209mr9029331637.47.1762778394780;
        Mon, 10 Nov 2025 04:39:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvhctT1tSMNG6n13hgt6Z/xjKjFvhH+tqumfj5n8eOBUIH/gDUalEKFufsKHlASPMhRfKS4Q==
X-Received: by 2002:a05:6a20:1590:b0:34e:a801:8168 with SMTP id adf61e73a8af0-353a3761209mr9029293637.47.1762778394021;
        Mon, 10 Nov 2025 04:39:54 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902207232sm12378012a12.32.2025.11.10.04.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:39:53 -0800 (PST)
Date: Mon, 10 Nov 2025 18:09:41 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
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
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Song Xue <quic_songxue@quicinc.com>
Subject: Re: [PATCH v17 12/12] arm64: dts: qcom: talos: Add PSCI
 SYSTEM_RESET2 types
Message-ID: <20251110123941.deecglwnwvhl3soe@hu-mojha-hyd.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-12-46e085bca4cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-12-46e085bca4cc@oss.qualcomm.com>
X-Proofpoint-GUID: Q8aHXFKXTa6wrCfZ9OVdhzVq0Tig579U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExMCBTYWx0ZWRfX+KnaUm44H7yK
 5NdH0/7tYlSdXVfbEW7b5OoivNBK7GeOXN18M1iY/7n22UPb1Ljte6mS9sztmjdaVL2DJ3IYe6x
 mBAjpE8jx7hFNdgwlF1ibUiEXG5L3r+IfC9Q+JAq5SP/4vS/983ZdS8NMh0HEWhoNlbY4gADZwU
 jHtOsrtJHLYCQokAveIbxPV32bMIyQOAoIXG6F6kEvLlemQhp0jXAta/zJ33FTDBGv1WJElHO4/
 tXVHGBrDZWX4GEZ5wgIFKyPmVEejrpKgFejrK9MDQWkipGmmBx+wz7L9EnpdhB4TnXtgVqANgeK
 vyNobjQHNYRdSvtRvzPxj5eDRKgY4z25ZquPW8VO42c8vfDV7XzAfyVHeY387bO7KU0oJp8oSTT
 NznME7ldNJxLnLT/0qIV8Mj22M7dIw==
X-Authority-Analysis: v=2.4 cv=GbEaXAXL c=1 sm=1 tr=0 ts=6911dd1b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=jMKWaxwz1VYOFM6W6AcA:9 a=CjuIK1q_8ugA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Q8aHXFKXTa6wrCfZ9OVdhzVq0Tig579U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100110

On Sun, Nov 09, 2025 at 08:07:25PM +0530, Shivendra Pratap wrote:
> Add support for SYSTEM_RESET2 vendor-specific resets as
> reboot-modes in the psci node.  Describe the resets: "bootloader"
> will cause device to reboot and stop in the bootloader's fastboot
> mode.  "edl" will cause device to reboot into "emergency download
> mode", which permits loading images via the Firehose protocol.
> 
> Signed-off-by: Song Xue <quic_songxue@quicinc.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/talos.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
> index eb6f69be4a82ea47486f5c8e39519d0952b146cb..c946d07c540f5ae40f147ccb06539ecf0de18df5 100644
> --- a/arch/arm64/boot/dts/qcom/talos.dtsi
> +++ b/arch/arm64/boot/dts/qcom/talos.dtsi
> @@ -612,6 +612,11 @@ cluster_pd: power-domain-cluster {
>  					      &cluster_sleep_1
>  					      &cluster_sleep_2>;
>  		};
> +
> +		reboot-mode {
> +			mode-bootloader = <0x10001 0x2>;
> +			mode-edl = <0 0x1>;
> +		};
>  	};

Feel free to add

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

for Lemans, Monaco, Talos ..

>  
>  	reserved-memory {
> 
> -- 
> 2.34.1
> 

-- 
-Mukesh Ojha

