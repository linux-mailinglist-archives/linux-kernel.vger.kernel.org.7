Return-Path: <linux-kernel+bounces-893025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7158CC4660A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FCDB4E8EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF15930DD01;
	Mon, 10 Nov 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gk76Bm0H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kvx5R2QP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759630CD89
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775405; cv=none; b=OBeahkz4CoZ74wbF+70c+yw3adcG7HXR1ZZ7dDbLc70o30Qnkk/Hal/1by8vMbics9tflCQ7wiUKf2N/g25SS1Fzbnz3l6rKTOmdAAmoxSzR1DeaYy9Tg30d5vaeLpJ3SFfjqWkCjErcfRkgy9nzFB6btYP82JH4OwbuTEWPDEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775405; c=relaxed/simple;
	bh=PbfOgtPT0n2UXrEeiTGt3mSbUyFEmdqiEYouVpjeTQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwtJQy0oMOzdHFojpVnPsF3mdnye4f5pbd1zkVzC1umRhksw0Z7FmsPBCWIuu+Yi1/kpNTZE8YklRDTU2bHKhe49XqkRvCXBm0EhsFzBe2FkVx/Gh9shE7kE3hVB8PmgpZUjfVR9SBeqyasMS7b6LS4KiIpkkWF7E5aqJkoeGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gk76Bm0H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kvx5R2QP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA9EhIq2992285
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	toGXLTCJlydVt4OAEmWhLmfjiiINqMpQruYYZvrtmdI=; b=gk76Bm0HEIR3QPsF
	p7UsJGZS/mEfyH6qsxu3gXJ1AhsXIYhbfNQg94YOOVS6o8U+T8h5Sek35YtId91i
	cqj7Gj5N77/fYFyyw4EeC7KvyVPlkTSAzOMj9OLvf66DoA9hxsP/IM4bc/0JD2hG
	8RONuhFUHeg5hLuJHdjoJWcGeIL8P+QU0wlD+o2/KDiDkst/UXG7WGXItqYXjCW6
	5W0BQfPmLHk+Wx2Ygy7+mvpRdbebCFsDvDo3LE6IXZBODMirnJRHjLyRCRG83Dkm
	UGiMb7fYn/bsJEIgYcKKKcUwUBFa7ic1wERFslFeSMTEEb8t3uU4DvJginSUOso4
	6AIrTQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abd88req1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:50:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b23452ec2bso84183985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762775400; x=1763380200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=toGXLTCJlydVt4OAEmWhLmfjiiINqMpQruYYZvrtmdI=;
        b=kvx5R2QP6T4yRuayO5k5s6nvc9Balhe/8wpNMPyn7BFeA0dLjbAp4pLoTNFkss2dTC
         nESxj2KPlakZtFHJTm7KAlKF5uItfjNVeOHI+tfSrh3y9Z692EExyk7bfHbQsgIWCRTH
         9k0n8pENWYSehv+Q0GL+DUzv1mNaFK6mfjDbP2uTjLwKu10hSSHxRIaXtb0exuiIze1x
         ibVx0ENVa0EBxD0tS/pF/c0nEZXnN7/a+nDvsjLuWWCB0MzdDuxiLY9kKFFuhWyuLIZW
         EGpq7TNbe6TGcB6WaMBzhbzndmec8yVDUU+EMlym0o4g8piGt3aSrgvJdcvuDp3ni7rR
         73WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762775400; x=1763380200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=toGXLTCJlydVt4OAEmWhLmfjiiINqMpQruYYZvrtmdI=;
        b=cVu/Q+KVhhelnl4+fqGQKF09zV1ezFvRvNsgMAwtNb7qcYVMvY2T9nKG1thBCMt63W
         Fv+T2s2/9ckQz5AbPSRLVK2lRAl0PR/m0iBOrwQBCce/0fTcs144BaHivI1EVmbrS/Ru
         mhoefIv8MUSomLil4mQaTLMKrm9qgBMOVL7LfxiKWpQk+vdEapZ7w6RCaNWJXu/SVSw9
         vwcyz9kZWtl7a+7QqGnxiIMU+aykkYcQi2Cx0o0mI7k08gkc4vtULUoiFPb1Tk+onttz
         A4ccE5AJvn8t3X5iXXlvNhdZ1Zr6azDio4IN3AhxndHGvuZdoxIrxzLhmohN2QB4Jmj0
         T8jw==
X-Forwarded-Encrypted: i=1; AJvYcCWvUQ/hlj7nu8MO56VqhaeXJgbxKqqM7B9rWXrYU98lWky3rvYLdQYPzhrFMGj4wMBCi7aRZFHWt/zow5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpghBUs9zO4ESUYOR/SVR4M9JCBQFaUR7rPPFnaOXBd88HAULa
	4ZTFfmDK2C8cwrXge9o5clS6tGIb2dh/wbSSz2jlVT7cjn6JcW1/47QB/4WFh8lNmOQj4McIuz4
	KffFsXl986GPNXnn8ZLXLZ/dY/S4zDrQxRW8ifeemOqHH3EqJWPdZphSs1+dXNf8cAUc=
X-Gm-Gg: ASbGncuWMGexZK1eUm767RQ27f1RMqSEwdnIXKOvKz/RGJDDg/L+o6R0GzUTncSh0Yu
	/biTBvCoxYtdDeFJifVzw31FuY9cm940wqQqCDPzp1QoNNsRc6v2hxfd5X1yn/yeOzgJG32CBDV
	45nNHosr5dvLN7947V0lCRSspGrnpj6tHpbhMHbRTtwl3hS0PDtg82GOljB+F7+64v2HLHzDHvH
	3ad2dUni5UobJnMtFt41Rwea2xSISQW+elaRh3dabrRsDI7OJev1OBvc10eKNs4dzRWUfZat8Tn
	mrKD+Rru62/h/rFQNd2YOk1P77wZVImyUStghXIR80wSg+bk019Ifj5Z+bGDonJSzpBxNkuPWfW
	G6oMEG9xjKTcxEYfI454KUVhHKg2/oxuqDgJ5NJYlm7ZsfxUL64KDfhbo
X-Received: by 2002:a05:620a:28d0:b0:8a2:a5b2:e3bf with SMTP id af79cd13be357-8b257f06a92mr604941685a.6.1762775400428;
        Mon, 10 Nov 2025 03:50:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVjQGFZFRM2pmp/M8zDXVLETjOwEc3uxHXPygKZvWFAmQzq7WVw+Rm1obV6L2pDPnFYmJtbg==
X-Received: by 2002:a05:620a:28d0:b0:8a2:a5b2:e3bf with SMTP id af79cd13be357-8b257f06a92mr604939685a.6.1762775399998;
        Mon, 10 Nov 2025 03:49:59 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbce8f9sm1072113366b.2.2025.11.10.03.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 03:49:59 -0800 (PST)
Message-ID: <28ffece5-29b7-4d6f-a6cf-5fdf3b8259ef@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 12:49:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: lemans-evk: Enable Bluetooth support
To: Wei Deng <wei.deng@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com,
        quic_shuaz@quicinc.com
References: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oI1WMAPKyYcSyhCKA4wPvm9wEcEWY6EE
X-Authority-Analysis: v=2.4 cv=PL4COPqC c=1 sm=1 tr=0 ts=6911d169 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=b7yh_2p2DTCkp5fgmd0A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEwMyBTYWx0ZWRfXzC5oEplg98lS
 mSsTrJuX9NhaYQS0R8Q6UhPs+AIowYYjh6b2YvCIEvgLibBxIbO8mFh5Y7kYzFc7NCGh+7G0Tvg
 trACFg09gKlfdiB52DgckUGD6Dut95gYtK/gYIUHapVHGiee2bU6Xm+T3ALWnzPc5TwxB2vVZlb
 QFtBMsE0jCyKJPaPYk83HHsv7Paoq9LlRRyraxJeC2FpkidfsLeEa+E81MfhLA899g8cfIa6HXZ
 5gs5Gq0mI1L2Ikhq9p/J2Qmb53UPHrBLiGYga7gbZYPpIEMDufgt0jgqmOOJ5SIssAOCZ43pd3R
 BybZCakdJc9hOAbNp4Z+9BXr706VZ+dOJAvxsR7EC+jk4waqxWDTnPZGP5DTjWn9kHLUB9YkSNh
 L1AsvxdD9CkHJJSnOS4Jcz2bmIEJxg==
X-Proofpoint-ORIG-GUID: oI1WMAPKyYcSyhCKA4wPvm9wEcEWY6EE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100103

On 11/10/25 6:57 AM, Wei Deng wrote:
> There's a WCN6855 WiFi/Bluetooth module on an M.2 card. To make
> Bluetooth work, we need to define the necessary device tree nodes,
> including UART configuration and power supplies.
> 
> Since there is no standard M.2 binding in the device tree at present,
> the PMU is described using dedicated PMU nodes to represent the
> internal regulators required by the module.
> 
> The 3.3V supply for the module is assumed to come directly from the
> main board supply, which is 12V. To model this in the device tree, we
> add a fixed 12V regulator node as the DC-IN source and connect it to
> the 3.3V regulator node.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---

[...]

>  &apps_rsc {
> @@ -627,6 +708,22 @@ &qupv3_id_2 {
>  	status = "okay";
>  };
>  
> +&qup_uart17_cts {
> +	bias-disable;
> +};
> +
> +&qup_uart17_rts {
> +	bias-pull-down;
> +};
> +
> +&qup_uart17_tx {
> +	bias-pull-up;
> +};
> +
> +&qup_uart17_rx {
> +	bias-pull-down;
> +};

This is notably different than all other platforms' bluetooth pin
settings - for example pulling down RX sounds odd, since UART signal
is supposed to be high at idle

see hamoa.dtsi : qup_uart14_default as an example

Konrad

