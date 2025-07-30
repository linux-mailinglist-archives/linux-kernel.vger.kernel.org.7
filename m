Return-Path: <linux-kernel+bounces-750565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E23B15E17
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA72A5477AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF3828312B;
	Wed, 30 Jul 2025 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S2lhwnMD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D970D27FD54
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871139; cv=none; b=t8ktus2RzizCPeqtj0N2Tbndup5gaG4poX3dyrrr/ktyZcDUSnWNBJLWUmntNNC65FL+jNB9v5a/5yyYXXF2tUPGQbPxI/X6JYh72nNQo0UmCn+Bnx5HF/n2qlrfq4quOAfNvfR7GVLiJ4mgHNsTeue7dNWui2Y9IlrcvB6KxY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871139; c=relaxed/simple;
	bh=hfgO/8yLce5wklzCy0SXQn/TWgh4OLbtWWSwWhKoY+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxDu6lAuzgNKIk0vwHBB9+ylej12RYgqd700cjYzEPFfkVEwLqwGIPS8br2EaGkA39Ow1Pcjbq8wiQUWNHeE33BIXmRF35sMwD8Ae8ZgazypcEqjDDO8C5p2NviJb730LPB9nx9wJ215yk7IIXGgZ22C0HD6o8D0OPDEiFEDLWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S2lhwnMD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U6DG9C031480
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VU19aOSOm56x7/zn9FprtBwoPEraQQ7b/Aj6oWD3uuU=; b=S2lhwnMDthYf3/EN
	Hl7XfU9ZkRuv2ao8FYOqGVW913VXGcItCUnpfYKFW0PxM96Z+t/h6NAT6guwdsB5
	O+q1oCOsYcuVJSioQEHzFE24jaw9O/k2P1WpKKhh9lYRQ1B+EDz4GeuJl+FF0nH8
	r0vKNZEtWq1uMBPzIx7Xu9Sx85jkLwcC7g+ypMkea5KnnfjuSEhlG9m3mD/Zmk2N
	rqME75PTgjBSMCsPNXp1885TdEi63yO7O7bmuXHXSvmajpDbE/T2YX2v7PWHxcQI
	ogchR9HfBo/f9uvqImgkLaMwW4+yZiMAtOWQaKFzCr5+0H4sa8FpL9awKjs8AyGr
	ZDSxUQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 485v1xgspg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:25:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4aba4196db7so6088011cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753871134; x=1754475934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VU19aOSOm56x7/zn9FprtBwoPEraQQ7b/Aj6oWD3uuU=;
        b=BPJ7a3L0w1vMUzTqZ48lhfLWn92+w7q8vBq8ZNZQvvNPp3+OFV+WhQuon5Vvahl9cQ
         vFl0uZiei/Zml+9TSVSkvn/XhbMtPuk6boUDhl/u1x7g0zV0YXLsxMqyxBJ5InXT9DRM
         05c5xcWmiF71V6LV4qPDbM3IwEgalBkP76mBTkuKoYH/iHtKyYOTh46MO/rsWMQ0pVFN
         pEK2nkFJbOVi/wrNBykL6eLMipLDVo1fUJ1LMhN1cnSnwhnWfKLoAMJ9FW2jChUojuyw
         uGuMBXdlvs7vlHYvmB7MBsfxp6l5+lt2/JP9+R3iDI58Dfm4zZJKWY+2RyeAtNvgQPVy
         xXVw==
X-Forwarded-Encrypted: i=1; AJvYcCXwQZB2n8741b7Mo4kCKs+X9vzpNf/FyKbVbd9emVxxap6BKmjmrKt78Le7bxygfcAijMjyiIth/enCndo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0PtfCUFzEM5oqb+gbLfoez3GIY2Z3K/6JE8iyWlEWGIeJH3lU
	LCPm2Ld080oT9jAr/DtVumCxClYZtE1fWLU3Bbw2bwLAfWugUJd0APj47XIs+AkhpfgI7vR08Bw
	W/QWSsArgeB6SncCiooBpUnaXtf58RlIlJ5nbeTxJuffe35zWmL1dGpvbkwOlqIL1FVCsJC6Sjl
	s=
X-Gm-Gg: ASbGncu65ZF+AkQ/vhKA57kVjlDJzejnrLSJHLW+KpjnR2QWyZN8b3y75ETKw2iZjY0
	+XPv0j2+9hzMppPpbZamI2QERXCDoUkYj/cabPDAP9e/2pCu14wfeHFOWmLEmJ0vfJDPfy5Xl4r
	Li8c3RUR+TlxdR94OsuAxGLQL9FpcBR3IJXsUWnrqG+tgaRazUuAFRFlh/JkN2N5v5gLTQy8k3v
	MyniEujHKwtOcwcwXhKukPOdeE5appOcsOx4rL82BcAieczeElTXzmGmUsLWKmWlJsos1vYnDRf
	AVPnllKu3s0caML+1FjvxdoIfrqngZC2ZPg0HYB9W2az4Rpyu1OkbT3TlDh0aKgMnRo872wP6A9
	1xagMdtzVTG1xjA4N2g==
X-Received: by 2002:ac8:7f8f:0:b0:494:b722:141a with SMTP id d75a77b69052e-4aedbc28da7mr22576471cf.13.1753871134229;
        Wed, 30 Jul 2025 03:25:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2MoFWPpyzdfwxYmpNHy2wlZZRbH85Mua0jLB3ZlgUxjY101B5fuxUH7O7k5j3qpTqRTcx6g==
X-Received: by 2002:ac8:7f8f:0:b0:494:b722:141a with SMTP id d75a77b69052e-4aedbc28da7mr22576281cf.13.1753871133823;
        Wed, 30 Jul 2025 03:25:33 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615923e13d3sm514484a12.49.2025.07.30.03.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 03:25:33 -0700 (PDT)
Message-ID: <f3aeacf5-f178-4e61-b34a-60353f89daae@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 12:25:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: qcs8300: add display dt nodes
 for MDSS, DPU, DisplayPort and eDP PHY
To: Yongxing Mou <quic_yongmou@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250730-dts_qcs8300-v4-0-5e2dd12ddf6d@quicinc.com>
 <20250730-dts_qcs8300-v4-1-5e2dd12ddf6d@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250730-dts_qcs8300-v4-1-5e2dd12ddf6d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA3MiBTYWx0ZWRfX51umuBKT7fby
 EvmUWqauqbyjtyx5vtSMdDgnHNPHpanGSZWDlYym/UkwmTJ5H3WeL9sy2ClPJ57kBaOU9cOLQMN
 e8HasRVQcpGSZCWFZfJsWaetprDyi3AmaXjnaL9zcw0e7Xheg6FRHHZM0SB1/rk+cwdvD9wW8tY
 TIRycPhefmnytk0GK9Fx6dXjVJOdQjWp4BcXUl7SCJDFsTgfaf/E36bhCtEMAi6vXfdSn2GmEY8
 zD6i4iHQhvK0b6zbIg5SOGKsfaHrmTSE5LLcYcTEnJs+EmJvREQzaYOjia4Plr3hmqVsM7NKvIB
 Ma6gU2wjgVRw4krz6fFOXZT7q3TRrDIaW0UCNhGLbZ2K9E9uvl3W5RQDvTTnytNfWt4TSpz5MXb
 ImdII8vofaF1qp7QNHKB0QV65HzlqjZ8DDrtmIZRpSNO9eS8cQDIV+o0DLrMtn6/iztgwdfO
X-Authority-Analysis: v=2.4 cv=JKw7s9Kb c=1 sm=1 tr=0 ts=6889f31f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=ggSMAipNaOlLgWN-UjYA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: OPqY9003dkRjNahUOjEccPIHzX6NMUx0
X-Proofpoint-GUID: OPqY9003dkRjNahUOjEccPIHzX6NMUx0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=902 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300072

On 7/30/25 11:49 AM, Yongxing Mou wrote:
> Add devicetree changes to enable MDSS display-subsystem,
> display-controller(DPU), DisplayPort controller and eDP PHY for
> Qualcomm QCS8300 platform.
> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---

[...]

> +
> +				assigned-clocks = <&dispcc MDSS_DISP_CC_MDSS_VSYNC_CLK>;
> +				assigned-clock-rates = <19200000>;

is this necessary?

> +
> +				operating-points-v2 = <&mdp_opp_table>;
> +				power-domains = <&rpmhpd RPMHPD_MMCX>;
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <0>;

interrupts-extended, file-wide

Konrad

