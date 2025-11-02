Return-Path: <linux-kernel+bounces-881916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A71C29387
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 18:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2984A4E6EB2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 17:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41D12DCF50;
	Sun,  2 Nov 2025 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aye8SA+T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L/54NvK5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B890B2750E6
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762103895; cv=none; b=fiU2bpApsoO+7+pK5zdZ8rWnPGzTXWomt2XI4z4wW4/Hy9AkEGqjoIJP4DkaUwt70Ex+g85oAL3J64xhInYmI9UtOM+3d4kft4mW++zAcsR81nKiIVyjGUNzMn5wtxUnNh4OngHuOx+/XruD6NFMZ//z5GkOelpgtjO0GCTvrr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762103895; c=relaxed/simple;
	bh=NtlclFDbgys6p/QZHwkycv/xOaVB2gh9fmk/1OBfx+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=POS/+boM79Xmn3ZRHkBRUW93EhYD0aV2BgX6aqgY+mull5Goh/rDSOs+RAIM1ZpHpF99ffG8AmjcUiECpYr8nkN09+BnrZkWOuOHWiZQYtkRwZY7brEASiJq92JcQo+Uh3lKTB8jiY+qot7RVM/KiaMR+Ln2+1VYje8q3i9Eu4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aye8SA+T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L/54NvK5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2GgEuW753986
	for <linux-kernel@vger.kernel.org>; Sun, 2 Nov 2025 17:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aeRZyUZYi7aX+RIWfhNiPeJfiMbKLxGi7DdTStgd/lY=; b=aye8SA+TyfdJA0q8
	kP7bvDa+LzwXA+x0BQ7mIzZTrtd8EcQs1D77yFy34t7mDozG2puIVEviq1qWJZEp
	hT0PXOqdeglDSR+2o3XWVYjbhWsy+SaUs6c8V+JI8DePuKJcGasmNlblPEkjCA6f
	Wete+uYpfeXhG+VNG9l+0XhpLC9Uu2Sou2NZoykIopKYjGiKgz3dqxAL5HNvA/rm
	hLsztnELG8QVZZgM2fmorj9IFTdEyGs5UR/wNR8GZZA+rOvT7ESRsboQRjqzxVAh
	/+g12HuOH6e4ywEQAQ/wIQWhwlEsDBUmgm4Gl+Ccxn0Re+JrkC587gv4ddGNNRbH
	u2eJjQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a57jn2ky9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 17:18:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88041f9e686so57282016d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 09:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762103891; x=1762708691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aeRZyUZYi7aX+RIWfhNiPeJfiMbKLxGi7DdTStgd/lY=;
        b=L/54NvK5K2oEfnGJz9MuqHwHMvmiJIW3BHe8MUOf87uUCLQ+RwsQbVfNJUL0b5kRV3
         BQM8f3mSmVLChFpuob2kehnc1Seq0cCU7Gk8RmEZInmJvF4U5FhMPOC88UdfXhE3fJix
         bO0Q+qEEImrpb2EMvpXxbWJZ5oZP5dtj3lhVR6vnd8wKDRDiwmnfDieXLlFdATo9tEkW
         fSp1Z1ynus1HqsM0O98/d0lwoVF/dL+h8j0JWCwYisDUZVhrYd/kj804W5ERJUcm6Hvp
         PvLwISyJpDo8zKCikF0qJTU7/xrhQZZgUXDaoXb0bOJae3IufuO8OG0r/tcIfmv6IV8O
         t5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762103891; x=1762708691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeRZyUZYi7aX+RIWfhNiPeJfiMbKLxGi7DdTStgd/lY=;
        b=j9yOO7czhrmvUiBGl7t/MOfgQ+Tts1rB0rv1XefCPFOEotJKGzPDj+FpKwL3iPloeu
         gcnFCwaMR4kBEzD47RAunhRIU9AUK+8HdIk9Ekypa4GRKfGE0QCeVSMYFSZpSzbZOb3V
         fb2AR0Wb49s83RGanObYkloXp35BSyTvtlWO00ZZ/V8JSlC9vKuqmk4VJCkaWf77+oyT
         qWTOmAXn0kRLi68YjHEAAT250asRxcRGl7+LDWlK4p0aVLLk7REOvSk7ec/hTO0FX5Bu
         IjluL2eKyuIdHCIHsmYuqWBWcWM2AnySsU5MnKaOdXOM9NPAFMQNp2ke7aardlLcRbOs
         jiDw==
X-Forwarded-Encrypted: i=1; AJvYcCUfkT4MVD1CzmHm4M9MIWJ1P2mzJOnuXTHGsdpVoJwuvEQIY14NwXVOG3Kscfqjx8sgQi9cAsXgiwniK4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Tw7hWuiElytecDX20BjedmQIVgk5KO054kQIUgI4tN6Fw+si
	JBXKCXg7lHGbH0Somx9K5+c9K+5tcISLHGaocaY3VONfbkH2Ra0T8yPJhKKJ0yUe1esIq6CSt2Z
	5pqjDkY+wN1nt4sZ2NAHsjT1l1MW/6k5Cbtvj+wdR3PjyKT24uEkueO7MztJZqsv06oo=
X-Gm-Gg: ASbGncuU3LNUaRmLmR0j/FvndE16y7HPopRGR6IY07VCxFOJUyF62M3/1wRR7Ars6mQ
	Isc+zs6+LbcU5tyYCKsbF/Xc5MTjyDD3y3xAFPkPtPSuG3F58F0hWTYQM2J607BZajCbrbfLuRd
	Fx1johoKiTfHKg+WLZPWyeRLpJFXwajdAFBexK784RHXCi0sbbSG7WrqZqJNYxtNzewBTrRUhq+
	ek8DXLd77BlVBldzlmTlDTxuviTTTA9kpaGc8l4YWol8aboQFLGIVcMh9MSXnUvyzZx9MfWlRqP
	xgKUYAcUN0YlSmPHDEl6iihhtrr0ooBf7PD+oOCCdfn69SOZDdV4d4yHfd+ybLpIcKa5YvaegRo
	zFAi82P2bf448b5lLNKiGs2uSr5FjVe0J2kt00rQX6TYrfNHmsMtA3vWSOcLX2Q==
X-Received: by 2002:ac8:5ad6:0:b0:4eb:a8ba:947b with SMTP id d75a77b69052e-4ed30df2e84mr137632171cf.24.1762103890785;
        Sun, 02 Nov 2025 09:18:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCiw3q1aivkOxuxe8tCdcM9EP+t0I9h3ckG6VtvfFNsJQhBR6kF6ZE1dwvvuxyHVpWI1743Q==
X-Received: by 2002:ac8:5ad6:0:b0:4eb:a8ba:947b with SMTP id d75a77b69052e-4ed30df2e84mr137631821cf.24.1762103890321;
        Sun, 02 Nov 2025 09:18:10 -0800 (PST)
Received: from [192.168.10.38] (91-154-146-251.elisa-laajakaista.fi. [91.154.146.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59425d28de5sm1164418e87.59.2025.11.02.09.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 09:18:09 -0800 (PST)
Message-ID: <d777a9e1-43f9-4028-a342-e723dd2c800f@oss.qualcomm.com>
Date: Sun, 2 Nov 2025 19:18:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: dts: qcom: lemans-evk: Add OTG support for
 primary USB controller
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251102165126.2799143-1-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20251102165126.2799143-1-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=StidKfO0 c=1 sm=1 tr=0 ts=69079253 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=CKk/IlMN6Gw3Dq31eR3Dfg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=7mYrOhUVQ_mZITg_WmQA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: n0YTKUWInV9KAhGs8QbWcdM4Mpx3qUAD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDE2MCBTYWx0ZWRfX+3dXEx0ugy/N
 uhunCDgICO4kRsq2kTcqCXU4+iJA7dWJ/nkybMy5QpVnoYntE75wDdrl9shjj+6bb2wrg4WZLdh
 EpMishSZ5uyxZMDCzRwCvHCqa5jzZwgkyTE1by3hLkLK7MHe1R+jO+JY0AkW1x5/MCp/Ku/KUUS
 DZa3kM9b2a0Yn7zE9AVCJYe9y/dS9Gzrts7jOdwHAZcqeafbmkChQ/T5zJGnbNPl4/hedZKjH4y
 z0XcBtU4m7gE1Dde9h/ihN2eO9Nmgn2Ng98uT3uZ7/ahUx3i4mc/m2GUhnRRlIIjsfUGN+XHx2B
 CDr2GYvKWOu9Eo6LeJHRM776xxgUKU5gb9g8SXkicCtYYfOcl5aj5kj8YMxUspX29hJKSwzB+i4
 bU/LH6h6ut2EO3BG7jvVhKjpxhArwg==
X-Proofpoint-ORIG-GUID: n0YTKUWInV9KAhGs8QbWcdM4Mpx3qUAD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511020160

On 02/11/2025 18:51, Krishna Kurapati wrote:
> Enable OTG support for primary USB controller on EVK Platform. Add
> HD3SS3220 Type-C port controller present between Type-C port and SoC
> that provides role switch notifications to controller.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
> Changes in v4:
> - Moved remote endpoints to SoC file.
> - Renamed vbus regulator name.
> - Moved usb-role-swich property to SoC file.
> 
> Changes in v3:
> - Moved "usb-role-switch" to lemans dtsi file
> - Moved vbus supply to connector node
> 
> Link to v3 DT:
> https://lore.kernel.org/all/20251024182138.2744861-1-krishna.kurapati@oss.qualcomm.com/
> 
> Link to v2:
> https://lore.kernel.org/all/20251008180036.1770735-1-krishna.kurapati@oss.qualcomm.com/
> 
> Link to v6 bindings and driver changes:
> https://lore.kernel.org/all/20251102164819.2798754-1-krishna.kurapati@oss.qualcomm.com/
> 
>   arch/arm64/boot/dts/qcom/lemans-evk.dts | 108 +++++++++++++++++++++++-
>   arch/arm64/boot/dts/qcom/lemans.dtsi    |  20 +++++
>   2 files changed, 126 insertions(+), 2 deletions(-)
> 

> @@ -454,6 +492,53 @@ &gpi_dma2 {
>   	status = "okay";
>   };
>   
> +&pmm8654au_2_gpios {
> +	usb0_intr_state: usb0-intr-state {
> +		pins = "gpio5";
> +		function = "normal";
> +		input-enable;
> +		bias-pull-up;
> +		power-source = <0>;
> +	};
> +};

Why is this chunk here? Please check that the DTB is sorted.

> +
> +&i2c11 {
> +	status = "okay";
> +
-- 
With best wishes
Dmitry

