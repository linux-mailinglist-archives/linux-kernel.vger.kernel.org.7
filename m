Return-Path: <linux-kernel+bounces-813769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE02B54A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA7317ACB93
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222272FDC2C;
	Fri, 12 Sep 2025 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nU/22Fnh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0A82FB989
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674733; cv=none; b=UrRm+kc1C7709+Xe4aMpLRqfkseubCLXQsyRzDANld8khoSdkqgL8M53a9tFVl80bKtF0NgxlM6tZsq/k3FfSjelLGZkVMkfka9/faGgUFiuEc/igx6jfFj2xFTWB3RmmDi/oBjzDCQBejP141oyRdfPFJxATFXBjlEIQeF8L4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674733; c=relaxed/simple;
	bh=o5VBkPOlbhWgQBK0/iP+h+Cmvhm2kWP0djdlvYDXhZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9tFEW92bvPU4xW4XxfyPhZ9F+0zR5s7/6uhLvNXK1vgM24RYrfaIva1h1N7qJoXKgWWSDesjUawCx14kpjxKMzB12YgtVgzCbPKlaKysLEQK3bwO43ntiKQJ4cHkWHSVN2XOowEBjtaP51Bd3nV3jHqBX1KT8KhigERfTsltEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nU/22Fnh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fHFc019772
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i7dFyZonuztP4v15xqELBBfstv28YyeHj10FzHoppmI=; b=nU/22FnhZuTi4Oeb
	NzzTM19E5cBFsrvpPC1rm09s36lkq2tmPNI6DbgaV5TZQZgltzumxJSM9ckAC9EB
	4lmEi2lV/aA+wxDCFaFB0wU2CCVaufAEjEJTs4oVdwJzaO261CKQZ1pYQQ63YJGp
	fn05ahqylh7l/6TSEKkD92dlrUirnnQoa6t1nlEVoK88tGowf5u15/neKwewBEAM
	MIXCjitmU1LMQAgDFmqH/L18ryj5VjkqvG/5NF/NV7srnzyapqgjhj172y2pOoTk
	4jQAJRFw6t1wKUvbspx+pc/zQg3Xnr5EYJCso3IL02o3aAXgrs6VDBC3ZyzVP1/L
	org+8w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t387t0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:58:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b4bcb1e32dso5133671cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757674729; x=1758279529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7dFyZonuztP4v15xqELBBfstv28YyeHj10FzHoppmI=;
        b=MbP8cWpTZiKksl31eFgukwC86TdbDfhkJVDURbgm7avkH4XsR0H58ejOFIMwFiXwqR
         +EwJr3tKrZrRBbwDBxEJcxb1cGllLWVEa6C1uVpbVtOi9U0YuzvoL/64WWDmYSblfEu1
         L/E4qPqS/UsQC0Kxp1gvmS4kcu9joMdaWhASjGgbpqMfaHEcoPnAUTCfo2xa9MER9F32
         5Svhx+w9dFTTHj3wZF/18tY9K3+oIXmxCeavRuPOicTot3e8KAE7kR2zYUKy5e28ulMQ
         m088ofkcLWTKTkFhq+O2ZWUKjhXNrkVlaYv1DhMN5l2K3E9YMR+D85HvEpFy0O0nNNEP
         xeRA==
X-Forwarded-Encrypted: i=1; AJvYcCXFhE7th09Efb9+g5Gb5sB0ipV14Ce7Nwk2GKQ2ZHGBVY1i/Kr5DSVSDpvUSSHLcopGFm+WV2KoMfBF7L8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe/IZ/FjkeIC9JvEKtqQzwKMbCJqHzIwNweKdtxP4v3g6NM9Zp
	Rr7TLJx8ps3a1RFhQSs7vwlKmVz7Flvq3OgITsVYBSVNqchlpuyx1vnuxH4YsZ/vXDNO0AXRJxg
	ew1GugpQeHukQz4AjQ2MRbxlYJ3og1dgeeGvOLdG06txTvq3hVC/QLUs2f7f/LDfmpj4=
X-Gm-Gg: ASbGncu3aXfENOBNvFsm+ilAeKUBR4EQ0bvIpDHvXNISA0GDs/NnXj5dyc2BkH+HMD6
	+VSGonhD2jYJr6bm7t3MFTormDmVRTGYJYrXi9SOz0xJ3fPTjs7IfvUoz++2iL2He7LMM4fMn8l
	fH7Qf/q+VlvMqkCoYXrp9037Xww+uDCIKTvBUW6jy8Qtmj4juhfG0i4dtLaAjYu589LPYgvA1wf
	PzZ+85mSDfbYV1jCG9f+r9reMjmmR3IaqvyWAdihnMgGJCcnLhFXiKBgb0jKU9roZtgR1knbsHR
	/GzfZaQfru3k2tBd86iDu9qJoVqiDK/GcmGuxN/EfxVw7p2M5uoYsJPzY2mIC4DsI/lWyhDAidM
	p+64bJjVUQCSwrE/B3ubS1Q==
X-Received: by 2002:a05:622a:1a1a:b0:4b4:9655:9343 with SMTP id d75a77b69052e-4b77cf920afmr22702521cf.3.1757674729164;
        Fri, 12 Sep 2025 03:58:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlSmyF+Gse2lNQD69+IKUgQt662LJkJWbTIuY6hl8QE56qi43llUixSvAFTFZLJvm5l7CXAw==
X-Received: by 2002:a05:622a:1a1a:b0:4b4:9655:9343 with SMTP id d75a77b69052e-4b77cf920afmr22702341cf.3.1757674728681;
        Fri, 12 Sep 2025 03:58:48 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b316e2d4sm348001666b.45.2025.09.12.03.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 03:58:48 -0700 (PDT)
Message-ID: <d95fc175-359f-4559-b680-36de87d75a40@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 12:58:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm845-starqltechn: fix slpi
 reserved mem
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250911-starqltechn_slpi-v1-0-93ebf951a932@gmail.com>
 <20250911-starqltechn_slpi-v1-1-93ebf951a932@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250911-starqltechn_slpi-v1-1-93ebf951a932@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QlQfpopXCrPBmdF2mL5mwp50CDre3hjq
X-Proofpoint-GUID: QlQfpopXCrPBmdF2mL5mwp50CDre3hjq
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c3fcea cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=gQzuMllvLFwwXPv8Qg8A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX9HBtUHFI2q5H
 jkP0HRi64RpeDf0Zqj24n4IWNgtncGRB1FHL1kau6oMv2jkzde0QmXINVac/UM8rO2hQEJrlXUu
 RsXj74nJnkqWXzSBmEpA4A6+zyq3uE4Bf2/rqxz39nFueQcGSo2KV7v7g1CgnZApZ408JerDCIL
 Ftl/CBXF2E3+0p/8Dex8LuITYf2vq0grnwmLCJi9zMopqnppy1t8MFDdIgoHXtQ1KXrmhSsD0i/
 +71ihRSQBh6ivvfOUgKPg/J/qoNi8i4T240n8eyYBJzZWS8QeHSCQgo/p63QNnynv8PbFJgB7Af
 WqDtX34zGKy26kRpzz/ZV0a0LEptYqdhkjlEO2JJOpoJrGCysmVkrCcXpaQ0ATmIxazCbbhZX0a
 cko0SJ1/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

On 9/11/25 10:56 PM, Dzmitry Sankouski wrote:
> When adding adsp reserved mem, slpi reserved memory was shrunk
> according to vendor kernel log:
> 
> `Removed memory: created DMA memory pool at 0x0000000096700000, size 15 M`
> 
> However, kernel refuses to boot firmware with 15MiB reserved region.

Why so?

> Increase slpi reserved region to 16MiB.

It would make sense, given the PIL reserved range is now almost
contiguous (bar the hole between spss_mem and adsp_mem.. you might
want to check that one out as well)

Konrad

> 
> Fixes: 58782c229e3e ("arm64: dts: qcom: sdm845-starqltechn: add initial sound support")
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> index 9eeb4b807465..32ce666fc57e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> @@ -118,7 +118,7 @@ removed_region: removed-region@88f00000 {
>  		};
>  
>  		slpi_mem: slpi@96700000 {
> -			reg = <0 0x96700000 0 0xf00000>;
> +			reg = <0 0x96700000 0 0x1000000>;
>  			no-map;
>  		};
>  
> 

