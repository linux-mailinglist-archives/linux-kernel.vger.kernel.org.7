Return-Path: <linux-kernel+bounces-893134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA0DC46976
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21A824EA9F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DEB30B533;
	Mon, 10 Nov 2025 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MvnMhZxl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ctfAxeNS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273E92FE585
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777720; cv=none; b=l15+ukijpIsDX+GAywoJ82S1kgWakBnViVdShcNKPw6lPt6kmvvQNknZ1YRag30wboK/YgPoobMT2ON1zHOjdUnrXVVDPNt0Y2cs4wPxprXMKxMaS9HKuD/qFNaK175jnRE7HrEMGmi0zh2Cwan3fTvjjDvFJYtFqwvse2tfr3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777720; c=relaxed/simple;
	bh=wvQv8x5QLsGOu8cOE9WdXI12O/iTMNRil3FtOPEraWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfzI2lNvGzw2CMTHT7e8sw0ASBuvwCvESBq3KfrRvy849iqz7WmHtUswIY1sE7im8hn5HsaQU/WVFqvzWL6iOWZ4NA4S7k9lRVT9FD8+TB8a0fQv0kS3Lq2HZAeKeH04l+qWW733KfuVWoKDiFes7g6qdoGb4975JfH3dQpTDpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MvnMhZxl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ctfAxeNS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA6SLvi2407322
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xvC5tylk1sHK0qkeaSY7kYE/
	Js6EfOGyj+3jgzqwPC8=; b=MvnMhZxl/iW4KuAs8Wm7Gw8jAuvAb8KfulrNlYNg
	EScblnQuteuG8Mra9hOdYcdbij+rPGyoUgdeWje1mgROtnvIS8haMsfs/IIOeofj
	3OtdieslBjRPqjtWo14eD8P6TMFhdWtbNd/dqoIpNzkRnBr1c0T+vOkK6oYuP/go
	hxUzbPEAKu5DoWc9l3WEkYoqAPjHidipz7IWNAhEQU2KvIZQhzJ5JWYI2YvSJyfM
	lmDYkHh8oOr0OiDS6ELrzOlRLKgpMxWtrVCGG4InRuCseYx8Tx/rdNxl0TkeFHg3
	M3whPPYegtzsIw8C6LYu+p865PVPDaqjGAQv7bu/Ht0B9w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abatd93e4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:28:38 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297b35951b7so52194835ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762777718; x=1763382518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvC5tylk1sHK0qkeaSY7kYE/Js6EfOGyj+3jgzqwPC8=;
        b=ctfAxeNSfmkiP4URySTKfJJn5s4+45vFK6O3wA6TDYuyycuXZQtinC3e4TaCS/IKkn
         E9wh7B4+bddFgD/rxn7rRVKBQnav7X55FFUlXvZAQ2fN5njdTb1l2lOs4EmkAnbhYXYr
         qsu5bccrlUh+SxPuDalHPI2LPBxDcbzxr8iaesOwqnmuP/MAiXSAcYulLXvSUd7NZ9p+
         +A7v0YV9oHcLR4GmjgytQG8qA8QqjyRtzNjmSNe1WK1WZeii9uwjm7fpsr1jgnaDmPqx
         iChXXnXfH/YF+oe5LQQzlvNYbNg70BClomzUz3WRX33DQKfJLvlrrq5DOLBbxZjxfWHA
         NTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762777718; x=1763382518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvC5tylk1sHK0qkeaSY7kYE/Js6EfOGyj+3jgzqwPC8=;
        b=jmR1HD8HkiZCJzYrdfiZWche+M06yUPonkQ7D7506WahaHkK+DsaPUntwNoUht3yde
         wYB+LyrE0v9TxR5iGcn8YmF/IGVyb6gFWJ67Oqp5x10muBBiNII+tDFMpSfWdeXPLzES
         CbG7AEhLIp/hkSQ1FwfJYykfsWhERy3IhSPr4HjUER/eKWw3XVPeZ1tgVelRadYo36Yt
         F5e4I+eG2PPyl7hbc+8tOKrME9VxPuQOKp0zNMgX6s7CXuiJNuBZi1vYObb5Ll7IxIra
         +4c/aFRz2XQ6h/p4ezkvIWSQHTseFQn/WTbUfHUYAmuKTZLY9Xe0qJaqNya/doF3oSr2
         mR6g==
X-Forwarded-Encrypted: i=1; AJvYcCUUZk4CqQZjR648rleNn9eTo5XIa/95og5/edszKxPghUIyMdh50eFHqRTBv0EEKRKDELX4njPsbo7YQVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrnbe0O6cTLk2Irv4wLKKFpeKZpOjMyMOsmUkgSHwksa2kVegN
	b9qsbvNgUVk2pcdk6mWS1ZceO5d26RroixwQLiyat4KS8/gbCVRQWK8+UPE5X43VFwVy44YGA2F
	bPKMhhbId0mQ7kBP/ERW5Srug6HPWzU80Mpd9kMcCpCm81GoyCJ6gzWef7PkIgbQWJK0=
X-Gm-Gg: ASbGncujd+2EmLTVlipvZDVZ5ZIxdhq4z6XLg8lfPH7Noy9pxy42boKHp4pYzuG4yb9
	2KNg2fR5lZg4GaZLShIiWlV/oJbW6A1TzcY5S9X9WVMSh01GScJvTQAK4bPOMxngOxtWk9Grc26
	kJWhQDMvuQa9Ml/xdsIpnxjTF2M1WLsn0SITISIZ9MltPpBqNzUND6OVDXYrwtb0XupAlpf0zna
	4dzPx6aqVOpIRi/Fn6A4Utc59/F9EeHJYyIGNIhqXyuaVTd9r1sWO9T4fV1eDu5DpG3BYbaaZkQ
	YKQ0zjL2lhgUYWRlqbvYcj4SB4Ur0K48WROkXf9ntwPOT40Lp8ygvMKlPQf7o/w+QRIKk1cTwmH
	odBVFIwKGDLpSVJj6vhm73/OLpQ==
X-Received: by 2002:a17:903:2c03:b0:296:5ea8:ed7c with SMTP id d9443c01a7336-297e562e81emr111981415ad.17.1762777717524;
        Mon, 10 Nov 2025 04:28:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwNP3fxkUJGLqN8FHuaSG3OfyFaMMBHENbvYTPgP0pEg/sV6ty2vZFcY/LvfBaaJEc8EM4Tg==
X-Received: by 2002:a17:903:2c03:b0:296:5ea8:ed7c with SMTP id d9443c01a7336-297e562e81emr111980905ad.17.1762777716858;
        Mon, 10 Nov 2025 04:28:36 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c93cebsm144992255ad.90.2025.11.10.04.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:28:36 -0800 (PST)
Date: Mon, 10 Nov 2025 17:58:24 +0530
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
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v17 09/12] arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI
 SYSTEM_RESET2 types
Message-ID: <20251110122824.5je5jfoanivl6xrh@hu-mojha-hyd.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-9-46e085bca4cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-9-46e085bca4cc@oss.qualcomm.com>
X-Proofpoint-GUID: vT1B1bfkjikCcQqfpaikj35e7BMB1jqd
X-Authority-Analysis: v=2.4 cv=eZowvrEH c=1 sm=1 tr=0 ts=6911da76 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=vzLQbmpfVAQOsT_rZiMA:9
 a=CjuIK1q_8ugA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: vT1B1bfkjikCcQqfpaikj35e7BMB1jqd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEwOSBTYWx0ZWRfX8F/YfT4TZvnh
 kvKZDbLdSwt6dRyhBnEAAJJJur31sqBkZM5Kgjy5fnNbJLMf4qDpgrzx5wK5VQ2YUHYXdXVakzh
 iX5ESlkZx8U9B93wLZECcdERIjIX6tqaHXXSaiuKnv4sf8rK2JV3aSLBJLkc61ZA4CtBaBUs2YN
 UjowC3esJEhRCvXrGAmX6mGbofQHLBk+UL199hPjhopWo44zojFGOiE+DvSiM/0nIBhy2OkCdh7
 XCZJJWvr8qbaBQUuB4NTiPC4Z+Gb4ZmbFUVeuNhvCkZ4WkV01u3mu7GIzm2EGnkVDvYGNHi4jt2
 Qzbn1fI7aR3P1OaS7ZhutbYaWWw+oC1xGRlbTZiXqXseFd7fOhuaZTWjHrijRpTFQiXH/vH1h9U
 v58z7GiZtAcgcfl87rQX9s9Ze1t/fQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100109

On Sun, Nov 09, 2025 at 08:07:22PM +0530, Shivendra Pratap wrote:
> From: Elliot Berman <elliot.berman@oss.qualcomm.com>
> 
> Add support for SYSTEM_RESET2 vendor-specific resets in
> qcs6490-rb3gen2 as reboot-modes.  Describe the resets:
> "bootloader" will cause device to reboot and stop in the
> bootloader's fastboot mode. "edl" will cause device to reboot
> into "emergency download mode", which permits loading images via
> the Firehose protocol.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 721a26d49ccaeb1429e2cc1c3a5c8d9517da3be6..cebdedd5d614b9efb6dfbee91dd67f3c3e322a38 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -935,6 +935,13 @@ &pon_resin {
>  	status = "okay";
>  };
>  
> +&psci {
> +	reboot-mode {
> +		mode-bootloader = <0x10001 0x2>;
> +		mode-edl = <0 0x1>;
> +	};
> +};
> +

Make sense for this as it leverages sc7280 and adding it there would not
have made sense.

Acked-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

>  &qup_uart7_cts {
>  	/*
>  	 * Configure a bias-bus-hold on CTS to lower power
> 
> -- 
> 2.34.1
> 

-- 
-Mukesh Ojha

