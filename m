Return-Path: <linux-kernel+bounces-855707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ACFBE208A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B31401730
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569E42FD7DE;
	Thu, 16 Oct 2025 07:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H8yIfGgN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBF02FB989
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601091; cv=none; b=LJD459H9tyuqeujrUb+04vCMD2DeA3qgvZ1Sw+MXv85UoqLFTwEWvksPVA368Dfybzo9zn+otdos27iJoOuGyGTWoYOgnBDtScFlD7yvbMdf1aBUo3adKPZU3zjY0SZ9ZmbCtsNOMepRv266TvE2qWEYtv37NMdF7XcnYwfyjTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601091; c=relaxed/simple;
	bh=2VFedUnaQCv3d4QtXQ4yKZxmJf80+KvjvkBPEnLIhDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okN4+aDDBKSO6uEw0hnmnShka3P9yzoLEyMm0XzxdFszdQ4IfUuFVnP8qENFxaTcSvTXe+Qlq+73yESMHc5uGLfjMO0Hhkcn5ODoUBYcUnFw75nGt7YEcAX9SjI4FguHtKLcFchNZvwWYn8KpskyuZHuxBOev3w89/Fhy2myGZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H8yIfGgN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FKiLaT002648
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hF4W4Pb67pimHUF2lUJMLPPpWbgUCRfxD4sGD6fblL0=; b=H8yIfGgNVJU9lXU7
	xE36ywOmTTxDMPOZuRYq6LRNXacYNfwnkUUtlbs2jdEH8kVdwCJ//rjg9J467ZSP
	KdV8nhdrRKKkjVrjQMcCe16ItfaiDM6A80tuuXXWZ2JU/ncXalUnXSAvSyd9cWD7
	1dm5TP7uMFOxcSDtFECERNtCt0e7edXpJkENBHaXPP+l/Q2V6hgi3QsIwqUflW7L
	i3U8fRk4b8/m+g0GZzQcasgImkkcF1IsjzRGsikWP3YffBTnxW63iNfyFkYqNUQk
	Q+JQrkjF7JOfs5B+ih/vrOi2fVljc3vOM+lVEPMLEUXp8wlwTKyeocBhLGKrbp7q
	MjHsCg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd97hfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:51:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-277f0ea6fc6so11228275ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760601088; x=1761205888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hF4W4Pb67pimHUF2lUJMLPPpWbgUCRfxD4sGD6fblL0=;
        b=wTO/VoE4eAZd5fBcrCVmbuBjCuVIcssuLUfojIbt/MVDmiTSb6Qk1/q75T+i/7AS8L
         6HTbHxS8FF1ZN9W6RpaVQnSJEP+N8Toxwd4Qr0OyaP2pixtCngVoyjEzX9Wd3HLUdNVS
         alWpZ3bQ4pZmhn5+ffBuRUWAFMhW29wy6/qKBHZhe4aoNY/u4WvqMjkH9CUaM5s+l47C
         ksjfaY1UD0XrxUT1+IJ6z008U31Men2MZAq55ikp+6fuoJc09DFLiJuCWn52OkE7ifCL
         JjBS8/k0TdFwkpjkswqhzQy5QOCZd/YqIV13NArjusHjnmYk4DJp2ihh1Gc8KiWF0Zbf
         MXMw==
X-Forwarded-Encrypted: i=1; AJvYcCUK957WUHc2HMvCKxIdQEA+7ObKFv5xz91AcRFabdkdhhmxazZs9sjsXSZEE2Y5EKvmdbYEZDXSaU+cGng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhp9+6uw+yAzlbLqG3V6Yhzdm8k4f8BNkNXSH1WZL9fHWAxRip
	hOmrAg/olGalf2S7i+2ZCJ6KWPydr/1fh6Qs9V55zIyK6MFcT00WacIoiTeaeIUxG7J2KA+Ekkr
	1k7D3rIL9f1qoCW4FAPw9vsCH4WII33w9Jylvv+Pc89IwurRU1I3hqrVYYE+6duTCa+c=
X-Gm-Gg: ASbGncsCN5mGGeMGFzppXISxm6TsrM7bZddtBaH0Jr/4j8hMFyy95o0IaHjQyqyNzH9
	dSMZInEMjLQljTXpH1tuQ9lTHjuM2FBKV7VEdgeVe2WtQxbwyE/eT/V+RlUFXYJEfn2UNB7i2ym
	vPyyTbgpsSfR4NSADhlBuWKSjeRktvEaposyXNdXsPtTtLNT1nSyTOO5IIYSd3SMdoflrwa7e9i
	fkq6WmUXlD9vE3NF6EzKHLGEtnhRwP7yhVQdNvxhhCGr2jpd7l77qXjWV8H09pphIdpFGjVvCHQ
	a5MmndUsvPrP07qJJMIKbxop2WuI5faK2YHpLrar31AV5R2zIgs7csiiisKX3OghjAFOxqiuYp6
	xKURuv2L+touAmuauA8F7YsSYkmxMW93E
X-Received: by 2002:a17:903:1510:b0:25c:982e:2b1d with SMTP id d9443c01a7336-2902741e7fbmr390196175ad.59.1760601088305;
        Thu, 16 Oct 2025 00:51:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkWk699Cs8rJdoNF7c8p30aWtBOTi6LJBDiXqz6Xzdy6iqBryCPq1dLN+Bddi5eDeq4uxmdg==
X-Received: by 2002:a17:903:1510:b0:25c:982e:2b1d with SMTP id d9443c01a7336-2902741e7fbmr390195855ad.59.1760601087832;
        Thu, 16 Oct 2025 00:51:27 -0700 (PDT)
Received: from [10.218.1.199] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099b0215esm20054995ad.112.2025.10.16.00.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 00:51:27 -0700 (PDT)
Message-ID: <fac1a1a1-43a9-4bec-a6be-812e7d97e807@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 13:21:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] arm64: dts: qcom: sm8750: Add USB support to
 SM8750 SoCs
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wesley Cheng <quic_wcheng@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Melody Olvera <melody.olvera@oss.qualcomm.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
        Eric Biggers <ebiggers@kernel.org>, nfraprado@collabora.com,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <20251015105231.2819727-1-krishna.kurapati@oss.qualcomm.com>
 <20251015105231.2819727-2-krishna.kurapati@oss.qualcomm.com>
 <80c71cfd-e12a-4707-ad03-e03b0ac48838@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <80c71cfd-e12a-4707-ad03-e03b0ac48838@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1lEfWaBo40ngB1FhbyRC8L3IqUHiTvq_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX9VdInPwtb5/c
 fEETdpb4dlsiHnBziyRkAiYjhRlSF8vCMjKKBz2/s2nW4RSZA4DDj9PkhSOMnUKh1d02mRPS/zl
 N872ZPcCdI0Z8Z/tndnet1Wv6/jGzm+H+ec5luITKpdt89x/Ax8KXjM8GCpdl9OWTsSb8UAN1om
 oDhYuCar4IDPRtZbxBeFCvwtq3KeVeNUa8vuxdz6ClH53VOpNDXdQjR+FY7U3xvl33/dvu2eL29
 n1O+NOa4SwvKWeJ6ro8VOJmGsHUwdQmgKyLEV1Ug7Qpr8t6xOIB7wNJ8VDhRGWGfz28sMbwmlSH
 nZn1NsgYL4Ms45GjM5WjiSGAySNJ2xIPWW7n1aIbQNkURC3zuYmVLgPHaZUHM8OjE5cNxGb6xyy
 CunwaE9MRdGSPoERYXTtBfIAL5oOMg==
X-Proofpoint-GUID: 1lEfWaBo40ngB1FhbyRC8L3IqUHiTvq_
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68f0a401 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=6obPUMqE8-fqOp28w3wA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018



On 10/16/2025 12:59 PM, Konrad Dybcio wrote:
> On 10/15/25 12:52 PM, Krishna Kurapati wrote:
>> From: Wesley Cheng <quic_wcheng@quicinc.com>
>>
>> Add the base USB devicetree definitions for SM8750 platforms.  The overall
>> chipset contains a single DWC3 USB3 controller (rev. 200a), SS QMP PHY
>> (rev. v8) and M31 eUSB2 PHY.  The major difference for SM8750 is the
>> transition to using the M31 eUSB2 PHY compared to previous SoCs.
>>
>> Enable USB support on SM8750 MTP and QRD variants. SM8750 has a QMP combo
>> PHY for the SSUSB path, and a M31 eUSB2 PHY for the HSUSB path.
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> Signed-off-by: Melody Olvera <melody.olvera@oss.qualcomm.com>
>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +		usb_1: usb@a6f8800 {
>> +			compatible = "qcom,sm8750-dwc3", "qcom,dwc3";
>> +			reg = <0x0 0x0a6f8800 0x0 0x400>;
> 
> Please resend this using the flattened model
> 

Hi Konrad,

  I didn't want to disturb an ACKed series and hence I just tested and 
resent the patches as it. I will flatten it out once this is merged. 
Hope that would be fine.

Regards,
Krishna,

