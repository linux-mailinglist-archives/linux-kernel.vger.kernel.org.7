Return-Path: <linux-kernel+bounces-744255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 296DAB10A27
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DF55A1A69
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331AC2D1303;
	Thu, 24 Jul 2025 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YfeEfHrS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F87272E66
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360038; cv=none; b=jMlYRiqw51eg1Bf6UxGPOKTcmjStf238P2OuM3WxMGWc2a48NvT3ZA95gzdKX3FMmfc9hfTv9XMISNhPU+xUC2L0MPwz8Toy/rdaBKIrrGfEKNL9K4va6qLP7vk4z4VeSRaso7xa+bfQZ4JbcaG30MW6Bkoh5Ozwy+qkHo02Wq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360038; c=relaxed/simple;
	bh=sMhp0wFjv4s+VblK/kTnh41T9LMryayKhKLgKql4oac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubZWJfmJMrWPkN7gbM+Rt/B+sb2MWkujw6iFC8vtfyzLcyewjTgEDa5ZamVQHWuZ8SrpcnQxarOaOrCFHZgdfwqdbrrRJPCCcV91J6+W/EC25PzN/LiV8FC9TqP+CL/pTODb247lLRAPXqjc5pJAPtz5pj0Lal0JEbZGKjCn3AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YfeEfHrS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9ixwX028516
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	igsMavPa7JPXTss/EBIRJaKGYqtyWBb48bk9Go1RYYA=; b=YfeEfHrSv2MTOUzb
	NGWDQXiHr3HzRI/5gH03QxpvEtoNKTxIZq3fQv0H6hUWeYOlxPViGD8y5dI2+HMp
	DuG4A2ns3OEEqdkwI+sYAOUS01aXKp7ihF2YbtzQ7mwxERrIk8dDB+qFf2EmZj0y
	+8NDw1M18AN4Eizqs48FVP2X6GockVJjV1Jn04DK5D2BPn5IzMfH1sZO99fSLFXy
	6/94LMMza+iw9y0X1d57LYPeo8p/qTxmY+BdPIehANSzM8+ygyFODGV5qRdoBRk9
	gq+A1KXxn7xzEhs4fhGOa5V8DWUYaa06cjUja/z11uW+R5h7ZNh2dBqiHWM7dezD
	xWaMiA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1g0yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:27:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab3f1d1571so1341871cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753360035; x=1753964835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igsMavPa7JPXTss/EBIRJaKGYqtyWBb48bk9Go1RYYA=;
        b=B07bx509CZ2Srvh0NFuJybZi4HXSsYhy4hr87M2qHlw0CqopahfjKaWV3pMTXwB8rs
         VK7Qb+Cpfi9ExSw/nDuyyPM3yr+pK9Xta8Vg19xbVVD4F35th0Uvlg6j/WczjnjaRYw6
         UqJkFzlRtKnd8kHrJvuBchJ2VWINEbY/SSHsjUvji7l2VP7W60M9hcKvFm3B4TnXAj7d
         fZD7xNBXxWyuTBlc6pbtSVZkPk1Rdo0zv4PlwPiUXErG034zOBwXnM6Fbjls8Vh4Ob8i
         4h8y46UMPcA0rMI48Nxin4Rn19Et7N2NELpqh3YLdSG9HoRMth8QdxRmCqCKktHISpJX
         JS0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUfeM0HWn7e9ymvyhEiDEDLXbIL6W2bjtWlmIRT0EyPnwMcGcFTmdD5pkoCC99MWvyPXTecWMv5VL57i8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8U6n0xb/zKfMY1rEFnwIGa+3FKBObJEs/3MOyIEtmTeXZmglO
	7K0lQl1zi0wI0PvZBkW/Wj82SYz1AT6D3VpJhtQQVu4i4MV1q6WbOUIbVjH0hY9LuPfU+orCKTA
	xD1E4ZDqaIt9/AydUw72y9YTvUwHxzNYx+FuH5RS+CZNwWyCFigjmGXhYhW2aJ5RStM0=
X-Gm-Gg: ASbGncvr1duqyy5E1Os+QvNFkZR2woBRRL23maoklv79VSh2hwJB/PmfjNVwHY1QNBs
	qXOwJ0YLe7HlwWbS0YZuSlvHBFB1kLfM5BoMw+atTLXy6+45xZD4H97XRqgGu8taFueattJSAsd
	XEOfwcJSEzsdWQZxbniNfRnskgR3So0YI6iqclQFrAai/z1Ku4pUEJ2EDyp9dZIr8pcmgqdOjpL
	pSub2MvfEQnL5HNn6O86EAODa8SbNWNIVsmdzzHXRCcOBT+UWN3FOmbjhS5bj+exGzCAniC3eW/
	H8njcjLx2hp3dnwOkvCPXG/tVqnrmzJfb42n7485VZi3E9ECDBdW9J7PiQLIiT/Gc9DnEafwLgS
	Teta45ED5ja61N959eA==
X-Received: by 2002:a05:622a:351:b0:4ab:a762:4c7b with SMTP id d75a77b69052e-4ae6df4daa7mr38084871cf.11.1753360035269;
        Thu, 24 Jul 2025 05:27:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4Hbl/n74fVwqDjYfUnzurZ8t7bnLxSNLYhNI7jtGJZAgoemmv7JgK5Z7eWdh8dpJjt4oc2Q==
X-Received: by 2002:a05:622a:351:b0:4ab:a762:4c7b with SMTP id d75a77b69052e-4ae6df4daa7mr38084671cf.11.1753360034869;
        Thu, 24 Jul 2025 05:27:14 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47f44e0bcsm103949466b.74.2025.07.24.05.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 05:27:14 -0700 (PDT)
Message-ID: <d71d0624-7730-42a4-8aba-77b095572906@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 14:27:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sc8280xp: add empty mdss*_dp*_out
 endpoints
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250724-move-edp-endpoints-v1-0-6ca569812838@oss.qualcomm.com>
 <20250724-move-edp-endpoints-v1-2-6ca569812838@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250724-move-edp-endpoints-v1-2-6ca569812838@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: t22bH1NU1MkaRVM0olkCvVuiarnYELIq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5MyBTYWx0ZWRfX3vX7Gl3lSOKW
 QTs15BY0qkMMrgm3c+yUvOq2hFUjrHeBkM4CyMmOP2KRzohtP9oc/2GKn4e8rleGBefdUPD0hrY
 Tnm+DslJUyAA/JhHj/BEOiHr+Sq1Aj2p1TTbJ5Qm46xj3LYgPyvyT0qOwAh5ELkGVQ/DA4RNZcS
 3pDC1q9VPDnsxLPz7GXGysA0yQMAYtYx/CT59QCh/YRkxe63KmMQ1IddvbjTvycHL5/cxHN9RBg
 1JWfCZuAmOOTt7NwH46f/iK8GLZVnzqzWNoMOTNkDktkwRc2TRApFAQeItdn1LCcO77KhsaUTgL
 q59OQXjKy6ky/wDhlt81CV63pMyAWFedQ+l42dKrjYD07mYXIDjnxbwaNB5JREH8Ov4hynT2yAq
 VaYapFgXuXYCMN7uvPATPE86AxVHhdBWO4lD8I1TMrMnAcpSh10EV1kuaH5A+X2IiJAmOR0x
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=688226a4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=NQC8z-4SoV2Hx17wLY4A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: t22bH1NU1MkaRVM0olkCvVuiarnYELIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=818 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240093

On 7/24/25 2:23 PM, Dmitry Baryshkov wrote:
> Follow the example of other DP controllers and also eDP controller on
> SC7280 and move all mdss[01]_dp[0123]_out endpoints declaration to the
> SoC DTSI. This slightly reduces the boilerplate in the platform DT files
> and also reduces the difference between DP and eDP controllers.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

