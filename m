Return-Path: <linux-kernel+bounces-888227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390F2C3A3E1
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A833B26FD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B3229346F;
	Thu,  6 Nov 2025 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h9JVmeRI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rs8BYo+s"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139D271A9A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424465; cv=none; b=lGfHb3dinV4zXi2+2xA57TC10DW8OnZfpGIsNFZEUhujpL38R+/uVdXVl0FJfgRYaKiE806LYrBOT4sVpQk4JNqbHgAQEwY4jmv7vX34aSar4dTZVVoYfbrRk78N88wQe+P7G0TyHxioMWP8V/v3hnXK7xobQvmfVUIjprAjIo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424465; c=relaxed/simple;
	bh=SKE309P5vzD4pMZXWCw8nYg2/N22ncl9XP5vSSLO5no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAc5J6Oq6jMcDPhmu/qMLc6KFDsPBbrbvjXkpqqgRnVz4NE6nj1fIDHXci9CELDfSJaqc7rPAUgAHA5Nd6qLEcKdxYRwrsRNPi4hER/cw6HKJvGqI8cufWDxcO3NtM1LfTE1IQMuSQ02F60Kj0F2WePkT9vxedfpOhA2MiXKEuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h9JVmeRI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rs8BYo+s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A655sT83217824
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 10:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WhBXZoFe7Hcg6gSpiw2G8HKPR5St1ckA/+z01wIesWw=; b=h9JVmeRIK90TZVFT
	QtK0eyuArJP2purjiK+4FDR/GrXg9NfJgjS1JEWicWYu9RMzMZC1Ru+qAHV12Kje
	ASAltgiyBYwv7RTF9IdzI7dNy0sXOTs9dM8exNOXygkRtiK01l1MTf7BK0aMWMpQ
	ufd3vcd0gRK9eXLYh2zu8bRF+VGheGRUa3UCKqbU5DA1vX+vHiJI0quBzweiPAKm
	hCOzj8bCqps4g8dn2IIHWp+vDNtQFuZHmmEocFeKZM8eiwT8xpkXihBivtsR+UzI
	GwMs+MFYzRdtGnX6Hd0x8jAHRvzghTZlh7zca2pAYla8vce6cOAVyCv3UV3MZKt2
	sC5JZQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8n7pgv9a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:21:01 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88088964786so749016d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 02:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762424460; x=1763029260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WhBXZoFe7Hcg6gSpiw2G8HKPR5St1ckA/+z01wIesWw=;
        b=Rs8BYo+sD72OJKdvyVQdakdm/KTbL44H36Q7s1sqwC+C2HDA8xkyOodt6Hb/vNIJrp
         bLLM5VBXNFCU6nt6u2w2ca4NS/GFYLh8E0bJGKoFWDkNzQgnPjrokNZRxtvtWcdUjduC
         5dQ2CXZ9UclbhKq4QRh28UzvWb78CE1iBQnrSXOCeo47FLdsc1lWihj8qg7alC3lAMF/
         CpDDK4z/ugfURQCd1oYxz0ni/lX6iaggNfzcKmaXo3tE40PeSiXaXLcs+qeptlVewkLc
         Up4R7qkTP2whhng9wcxxRBSq0R0uqNjQOj4RpXYNVPLt8Qagx0E4HPdV69YoOtmS3BhT
         f9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762424460; x=1763029260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhBXZoFe7Hcg6gSpiw2G8HKPR5St1ckA/+z01wIesWw=;
        b=R6SUuDZcHhNmiuiGinaE4A3cS5wUJoLzEFqS69zbscqCCwgyn4O/EGh/ye3pEWxvO1
         FZrh93mKt1ohrs4OmUdOeeB1Z3emXd+Oa+zQ5HaPw93Bl32XDzRmlxFY6UlUEG5z1B1s
         5zzsrS+gYReYX8C7AsKYEoN20LF8gdKxNbO/wS3jpEMF/YtUHDEMMs+ESeUy2r12TuUy
         sNNO5WxrnqvLcp2NAA7BQvhY17G1VuWkg5IRBJcE90tE9CptrMXyv+3CE3kPmYqWguEF
         zjaVHF3e7MnTwO7ckSlt2OLpT2qovmNdIaam1W5lAAmQhnLmw5z+3078Hkf1pL+jIHVT
         zHmw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ99uwq+8gcYR/tKF6lDNI/DULYinVx7i+4pGZPQpHYMfz7smnClLGwPCqBcGvRQ+S9gO5h3fT3jCSnJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNqPh0ff5ymRyE7+mP35DGzTLnRB3GLwHUxWMj+tFE4tFY7DXR
	SsjT8LM9+EGtG+QmPOxir2/uuA0jJdL+AX21SaWp9TZBvJ+2JmQiTS+qKPcGCmNJ33gstyyNPIv
	jCBf681GtVT0/Y21LJ4qu0kp43lgluICdsIL2/Y3Es8DlJZlDFHmr7yHrY7d8tp/60jU=
X-Gm-Gg: ASbGncsvcWECJOmMUfLmXv1ZWayZqxr3BZ+LWtx/DIofb4ekjN1s/dWmP3fSzV5xk2q
	zdauoN9hmANxbVwOA3M9KeUTU94zoxJyE8h5sNJcMVXxHiQw2F7oMV2zRFPUQTcEXgFExgsHVoW
	oH3WBPn89H0vQdKEHiYxP5cQR0eX3CCw3reWXCy182cbDEztcu/khPDWpnXFyTJKoLelszgeMO7
	jOTmN0y2T+QRzYEZDFqf8/tz3D+6qiOGDLeeLypSsy9cmTRCYhAlJx5I/4uPFtEj5KN4XcvZZhC
	8/pJk2a6tBbWwF5MQbb18zNW+u9Xet3DJmCDy/9MU9v8uFPEM51YrjNhb3vyQZkSyBpVluLZOgX
	el8vwGx25P/KSjfzO4QUZpMmRbYDfZ/a1q3bR98mZlqEpFDTfB08UKCuF
X-Received: by 2002:a05:6214:1256:b0:880:4585:da69 with SMTP id 6a1803df08f44-88082f24070mr21110666d6.4.1762424460277;
        Thu, 06 Nov 2025 02:21:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGENdLTnbqe8qV6m3lzr0Uih0SmnxtZVhyQI6O0w4f6eSU5i0lI7OGbFbNFszMDE28ml7uXsw==
X-Received: by 2002:a05:6214:1256:b0:880:4585:da69 with SMTP id 6a1803df08f44-88082f24070mr21110446d6.4.1762424459673;
        Thu, 06 Nov 2025 02:20:59 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289683783sm176948466b.56.2025.11.06.02.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 02:20:58 -0800 (PST)
Message-ID: <3b4fb0f0-aba1-4396-9dc0-e470fdf253ad@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 11:20:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: Add device tree for TUXEDO Elite
 14 Gen1
To: Georg Gottleuber <ggo@tuxedocomputers.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ettore Chimenti <ettore.chimenti@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>, stefan.schmidt@linaro.org,
        stephan.gerhold@linaro.org, wse@tuxedocomputers.com, cs@tuxedo.de
References: <20251105154107.148187-1-ggo@tuxedocomputers.com>
 <20251105154107.148187-7-ggo@tuxedocomputers.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251105154107.148187-7-ggo@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ePE0_v6J9adqDkZy7bM2i_RLZ7PZ4k-N
X-Proofpoint-GUID: ePE0_v6J9adqDkZy7bM2i_RLZ7PZ4k-N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA4MCBTYWx0ZWRfXxlo3lr1kG4UT
 3JqE8WK6W3nNhYz0TKKyRzEM6RIomG/WSp+uc2Ff27uJcqh+6jkaNbGGuIq2ARqVh4o4j9rNsEb
 399gf9haNW6XLaJ+1iOpaKCs/AZFEctm4xa7/tPy8LnWcZYfQIBuPlmJ7aLvbLzSleWfP7bdr9w
 q4oPA8O8tjOS1d1bu9NuRfhlE7jRWw3DCZI/NvSWFGwQVydx8QEogkb2bHkNJejqCtWP+i+wGSt
 X6JUvEHIKIi0hXwcV4hg/agr4tpO0Jam8evuhqCvPwGarPmQ9nO8JkLBZCQ3Vct84EeHZH0hotP
 ZPkDgEdZqGPzvPqBhjfIVBuGv2fIdi87Xm11svuSfsUJz2mP/etvHvVipy2Nc3scz05/9QRqvjg
 6n0NRYApIXyD9bF2v53G5oKbddzANw==
X-Authority-Analysis: v=2.4 cv=ErnfbCcA c=1 sm=1 tr=0 ts=690c768d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=mU-DN6NyoY7MWAXVNHAA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060080

On 11/5/25 4:41 PM, Georg Gottleuber wrote:
> Initial support for TUXEDO Elite 14 Gen1 based on Qualcomm Snapdragon X
> Elite SoC (X1E78100).

[...]


> +		wcd-playback-dai-link {
> +			link-name = "WCD Playback";
> +
> +			cpu {
> +				sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
> +			};
> +
> +			codec {

'co'dec < 'cp'u

Konrad


