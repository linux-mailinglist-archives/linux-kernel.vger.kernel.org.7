Return-Path: <linux-kernel+bounces-879792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 243D2C240B5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0138C4F57D4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC4332E732;
	Fri, 31 Oct 2025 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EFrxatGB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bEFZKWp2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666EE328B63
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901683; cv=none; b=jEXvii24wCKRUZPS9edM91NjR2EfIpbRYcjl52vYrSkhi5q5qV0BaFol/ocwd51Ay89P48er3EDZCg6bAjdrs7A1WreAN9x/i5ZGx0kIhsZpnXKiMoaY5rE7tJrl5e4my14Q9eUzE/21ym3p6fdXXxIXe2MkUbzAsvigEMc2n1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901683; c=relaxed/simple;
	bh=Ewxd37XtG8WkzebUz8uPzzAoNQU9BhX4kJCqJjTT+t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HR4WNr5PbdRx5jg8LQkYxuBAIA0v174keFnreR6QJ3NH9dQgDdxFXT3nQJx6bM0SgABgQ4wzGelYcGfTdyaVFu7vk2k3nPEPXzNMeGDodcrpnH2WLFQWxUj9Jrj4r+dNK14qSdr+u0hwazcWqVvHJg1Fb+D/PWdUT8sSxc3NGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EFrxatGB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bEFZKWp2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V8BLBU873155
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5y9p+glX5jcR8CDJg6FMKuFGzTtIc7gtljd6iwbypU0=; b=EFrxatGBZ+RGDv89
	43lUxTbj665W4SCXjkGxIiZYZkwMsCfYsft2OxeL48Wz5oR5pluKwkCWXfOUyLcK
	cnuemXxGjoJYmCuYtquqLTEpgzbO98Z28Jtwd2fmlclgkwR8Vj4b6Ncw5whRQyBe
	kGYg8O5YYfKCJ6fdnyBcW0zn63DnA6Ld7mholFTGCeAgVgTTUVRwcnzcuYoRxhxm
	nUpmhOMNg0KuK7x5Wau2KRGFBsGbfe6QDom5x3KMrwoXHhzenc0oRAcQZQOQJNel
	1CfxHq39SR6WKsjswBgTtqfte62jGo6paqbu0jdASslIt5KlBX5VDasCIneM3RcO
	cT6VAg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4fqn1jge-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:08:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ecee4fdb80so2632451cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761901680; x=1762506480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5y9p+glX5jcR8CDJg6FMKuFGzTtIc7gtljd6iwbypU0=;
        b=bEFZKWp286kms+So17JwHXTTAKbIqu80DAj1p72L2ny6mPlHo91eWt2I5/iZJnp1Pg
         L7rRlYhLGWDJJEl7zoyR5VeAwjVh8hjEpNkf2FKiiOm78NH00rP6p+wM6EdI/uwoE1I0
         WPxrulELlnF+dXVBnf0JgiyLt77RDinJlU7V0I3mRXyqEfBsbP8IOslGy0/PwlKRFLOj
         j48yW3pw8fcwBi+7AwHWQWNluXVy/eeZ0YZhMVk3sa5iiu/Zch8HG1GfU/v3S7Td+4Vi
         HJfepyrTpxPvLn3amOO0NuNKAIGKZqtz3Q1gVktum4YUI6/Zo6egm4eyAwMpVun7GphU
         FtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901680; x=1762506480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5y9p+glX5jcR8CDJg6FMKuFGzTtIc7gtljd6iwbypU0=;
        b=ZRopRP6CqUlNbdY99uml6b3ZmauobzYSHfuWRY8itnJKVgQm70MRfYs/iHs1ulkziJ
         2DowOIX35QlQF4n4cCq97z4CWPDwOWCjXikQ1efsqP0V6yfz1x9gbDwRcW8Zn0bZveDb
         wZ26ANJZsvDiIFv1fyM1sc5mVwxuwu0kH92X7//ymIBtYwV/aZPcN4Ak/SDkIHUt9NHl
         37LroFGwek43DAw3L4MHVFGLGsJME/Ld8hQf37PZwkBsnMBZ+03icXC7Vp2gZjs/uLG1
         KuC/3vUsg+JmMlVQZ2NUMWx0Th0G5c98n3VWP8flHD6+oAVqDAweo8HK9f4OtYOooVOR
         ahNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNBlfFaRqMF0eiZSZ7fRNWcdQtgsUIGTB2g9QpCvgBTpuTz83wUHEg02hCSw6RNDNqZhHQfZpCd5w9o2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAwmWmeZVkkrvLh8Djfelh1k6Pq4RhMYp54kysGanGxqMbd5Rw
	srmTGjayQGZJkQSNUS8hJDFq2oJ2Ot7hudz43O/FYlIxzRdqMaI/fXZmExDsXcUYJ9vK/UmV9sC
	rhG+dx3v3ioK9/SjfzC1WynvfmXPnxrSbCFce00oKBFhwK/aIaHY6FX2/WWbW1Z8LZ+4=
X-Gm-Gg: ASbGncs004wuq3SL1gise2IuceEd8tDLHHSF1l+3YXyNlkvuJ3w0Xncn47C25fJ+RUB
	gKD61PYLVa/MVyrVNpXDdzb5ixyi+JdBVv+JxkPdMEmJbWsORutHVOPyGsw6a20Csu99cEL++AL
	OHx/5QunGYzIC69XLrZj59+P/t0UhNwIFS62bvgKquZgviWPq2EDghy+e4SDxcYBUp+tUopD1g2
	ih5pH4sQ2hsY0KGcbxW94D7tAmdKQotHtFnQu5Khp2E6QAWS70rdHeSv5wGJfJob1LIHvZhQ0m4
	kWIvrwDbA7mkWES5VuAjZg0mfPwpPANmb9GXuSjy2f9q7ckA5Vvs344+kmA0E2ZXAlWYCaW+fyX
	NX+FJQ+GnkKMAmDp9WtmauphUgZxyiJ9fwOVaOPln/hAVNJbWs08gjdBF
X-Received: by 2002:a05:622a:1a9f:b0:4ed:154:1a70 with SMTP id d75a77b69052e-4ed30fbe3a1mr19533031cf.12.1761901679581;
        Fri, 31 Oct 2025 02:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnHAzyEkRs64K2/BOqNhCBYrqcMKQ0l8gxEreNmH0fMCJjYKxJseuISAeoQ5NGaAYGYsRUbg==
X-Received: by 2002:a05:622a:1a9f:b0:4ed:154:1a70 with SMTP id d75a77b69052e-4ed30fbe3a1mr19532861cf.12.1761901679065;
        Fri, 31 Oct 2025 02:07:59 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70779abc36sm125468766b.25.2025.10.31.02.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 02:07:58 -0700 (PDT)
Message-ID: <1398b513-0948-4775-a71d-dd06ee2296f9@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 10:07:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Use 'edp_hot' function
 for hpd gpio
To: Amit Singh <quic_amitsi@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_riteshk@quicinc.com,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com
References: <20251031085739.440153-1-quic_amitsi@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251031085739.440153-1-quic_amitsi@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RL2+3oi+ c=1 sm=1 tr=0 ts=69047c70 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=7M366yyIwzBhkVEls5YA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: qGxPMGK8xAfNcm84mI1MtwPmc54cQS2b
X-Proofpoint-GUID: qGxPMGK8xAfNcm84mI1MtwPmc54cQS2b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA4MyBTYWx0ZWRfX0Kqj3Lw4zEle
 qavkW3xlIyMpO9ckP1jtYVN7rrdm3BOBR+0ktnqC/1+giQWhjb+gT9Wa7AuyqSYzlQ88KwI5FuV
 wnlCDDsXanG2kuLBuwufnfH6USfhENaZm/BtweJo3/tRq8TGgpXlXeQWg62TQZtqL2hZfqJPVEx
 TvjopMbSOfQZF5Q4zEZEujnhtpule608hw99qN7iF+aDkHIqyxe4beFwA2SjFv/p8owVozQkCOP
 dBNDkykFa9ccKNa7En2xZOOMEekxxhzypqM2xA/xVD4uuWK2ja2I5N3tnuezmqo5dvm5isB+GhL
 vqqWjSkPtS6Nzb/qItKbNOhHzr5IVA23R5sbLrp6ahipCnCne6xJefpZx56CgzKs2oLPZf/a+e6
 N17LGJYr6Sd1b3MeRRCxD+g+GPwszw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510310083

On 10/31/25 9:57 AM, Amit Singh wrote:
> Currently, hpd gpio is configured as a general-purpose gpio, which does
> not support interrupt generation. This change removes the generic
> hpd-gpios property and assigns the edp_hot function to the pin,
> enabling proper irq support.
> 
> Fixes: 756efb7cb7293 ("arm64: dts: qcom: qcs6490-rb3gen2: Add DP output")
> Signed-off-by: Amit Singh <quic_amitsi@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index c146161e4bb4..caa0b6784df3 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -49,8 +49,6 @@ dp-connector {
>  		label = "DP";
>  		type = "mini";
>  
> -		hpd-gpios = <&tlmm 60 GPIO_ACTIVE_HIGH>;

I think this change will take away DRM_BRIDGE_OP_DETECT which is very
much desired to have.. (via display_connector_probe())

Konrad

> -
>  		port {
>  			dp_connector_in: endpoint {
>  				remote-endpoint = <&mdss_edp_out>;
> @@ -1420,7 +1418,6 @@ &wifi {
>  /* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
>  
>  &edp_hot_plug_det {
> -	function = "gpio";
>  	bias-disable;
>  };
>  

