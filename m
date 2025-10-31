Return-Path: <linux-kernel+bounces-879412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25316C230BD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42DB140764B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C962C308F16;
	Fri, 31 Oct 2025 02:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZdHArAHm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EZY+oN5x"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A883081B6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878607; cv=none; b=Iozm9HTCSjRCW6N5n7moLAEUt3vpjGhPNS4AYC6yVUJKauTuqJYXCWz9OyKe0qmJKnEdWVPKf0OuqlkIo0Ld2p8F5JCuAKJDowF8YGrfjCZoMj4Bv6WycivH1lboH3nv5cqqR/44rCkskpRa9CO2Q3imAhv2eAYIe+csNRow6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878607; c=relaxed/simple;
	bh=rmr+Ve2aWs/gB/s7MAe6Pw22HxmqWxH5KSfU27VzoIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QB1HdGd8S/gNfNGJ/AJALDHS8O7iBv+AJN8ksfPCs/iXac+RsyAj/TT97uURMG/8veuysa5DvduvtjyGU6/Gv3NcJmIlPRpO33MdZZ8qaVb2QylrfDlQOupO5bNVqEO/J/mOfzPy8yHBASW2nyKEyrSna4JUcn4ml+J1M3LMCfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZdHArAHm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EZY+oN5x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UIIs0D3116501
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	68Z9VSXVW6Q2ijW2mYpOsvswNsQdYdo/t5Hc9YHcyqg=; b=ZdHArAHmdokDpyAI
	BcUnFzOVnocHZ0l6iFFgt20WVf7euk4DQCYj73ah66fPxLM2r9fusut+bu0jk6Va
	QJW9sYbPNdInzCgjjZbsFucqlCJZbRFvNugfETZQWi83ivkazzKUAkRdyRJn8f4Z
	efaqkpo5EGWZ2fN8rsxkFke37nHM3HQH7IR/GN+mj73l9wp28y1hxKI6A2JsP/6X
	OEbbx5VjW5+9nSs7LarRxK8x74sBBws1+rV8a8f5I/9Wff81q/YcqSpfzRcleGZd
	IBDq1XbZjHAAMOwX2iRwk+FCGSoFrEJcXVHwItXDXn9CvTUVz976f1EHLllFuBur
	WNZTRA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45b42n6u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:43:24 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33baf262850so2034046a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761878604; x=1762483404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68Z9VSXVW6Q2ijW2mYpOsvswNsQdYdo/t5Hc9YHcyqg=;
        b=EZY+oN5xUJm6oMiuo15XekRzV3z3FQyJF6E1fiVlOGsbdn81wPrueYzczbiaJhg99c
         TT+3LMVd6WZuQHYc9S+hxvU5iFRXEgRRL0FjeGQtm8zzRDkxtMTr35lAdKF1laxyOQNW
         VfMkPQSZQ24VR2hZuSRtY4X45hOdub+kma9aAFy2sDBfc3GymA6HHzJY02MG1BFqNkaM
         UnXXY4DAHkX9RI2OM7iiMTkS7QAktDCO21+zUoMam5AVPZE8ycNHgYGvz8Dgr9xiSnzF
         4TDLfqDU2nzQLmPc/i3qcHpENexFERFu8tRsuDVG9NNcFQxFoNn/Qj42R4BTIDAHzjnj
         63nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761878604; x=1762483404;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68Z9VSXVW6Q2ijW2mYpOsvswNsQdYdo/t5Hc9YHcyqg=;
        b=qMrvYJX2/gOgZOGiHeZzquJSve33RBk9qwWpO+2jJRldJj4gV7M/quiqZ5oVFxhzOx
         3E0HPt+70C4vrt6Y/tjTjHWKDhZxVYABNX/HNDwqeWZF5F+DFQvbEsFRZozIC4E1GpNV
         JaEYsG6/VvFeAe0GNGhXBTsjv6692Ey+ADEGrnbJbpg6sUGV1JVKzUvGmoWvknOpdB80
         qcj9wGOsn+YHE1P4aZaYQm+sa1TsS0X5lFg2mLywTpnJNHavx6av2poUr6HhHFw+qNsv
         rvhW1eb01hzOPEn+fFPYtbt8LkR/T5TsSAPrHgcWauno65XfgNXv17/NLWRp3haQkWiF
         8i6w==
X-Gm-Message-State: AOJu0YxkY3nQa+RO78m91piWXMQpcbJS/2iZPh+Nhvdr5o7IbIsscrak
	NyPgkFbLmXVuIhVy0NVBnpShdaerXBaklqFZIimzJ/E65CFaaWpPpdLAqewAOQF8neMrSpTcntW
	AgiZjyQtxbH6JsQoyqLi3jfJ7ezuJASGfjKN3ISkeYl8IuApx4DzOni5z9/yB2nbfsH8=
X-Gm-Gg: ASbGncvDLfNdVN/LHO3TSRy9e6p2KW3MxOQt+uXOne/WJCaNeNpoeSjp7BCdT+/PzPc
	gCdjHrVDuUMsqhH7xqOoscRex4hqDxh01YIEnflNHhOSsEPqk8hkslil4js3qUN2k7JLMAMpJTf
	TeASmAZurG6TaqdjMmtEZnHqXCQq3RA/VNFDhkbjT3pOh7dKF9MvFph6E+Mj1fze9U3aVCl4PP7
	WAuft28KWFAwZpzN7fcphnfzfP+wAYdaQM/r1KXWt01TUuS/Zq6IQ8pb/Pb5K4rXF8hvBWouCNh
	qx5FK/KNgedwUiljdm9TK0SFona9u4quaPN/s16pvrGUx6njZWu4YBlBeWvF9PN1hQUPA39wWXs
	DmSo5w8LT4fDfyNsFw/Kbnn3igXvCvX39jO3EM/3fCfgIjK0w5AKGiaG/TOf/xj9owjsNVj0=
X-Received: by 2002:a17:90b:3c05:b0:340:5c57:d00b with SMTP id 98e67ed59e1d1-34082fc3dc1mr2586370a91.5.1761878603589;
        Thu, 30 Oct 2025 19:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuvmyhPreqEqyhgrmhj2nI1Gs4vA99T3cAVTW6zl/IO9uqi9s1AbPjZp+LJPV24OQB1Vh95g==
X-Received: by 2002:a17:90b:3c05:b0:340:5c57:d00b with SMTP id 98e67ed59e1d1-34082fc3dc1mr2586350a91.5.1761878603119;
        Thu, 30 Oct 2025 19:43:23 -0700 (PDT)
Received: from [10.133.33.51] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93bda59f56sm360095a12.21.2025.10.30.19.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 19:43:22 -0700 (PDT)
Message-ID: <0b4ce00d-78eb-4b5d-88b5-7d5b8de663a0@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 10:43:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 2/6] wifi: ath11k: Register debugfs for CFR
 configuration
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
 <20251030043150.3905086-3-yu.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251030043150.3905086-3-yu.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAyMiBTYWx0ZWRfX9vBDaT+ug4ph
 ffQhnHfip4G0c3AZB5Bymx+hmJ1QfS8dpBOCn95GRKIThRf2MPDjqxzU4YUS4wW0wlul5ilcP0J
 gtcIrOT8V5Zoe1DG4kIUXmv8MER1mBeUXLpDItOB6vYhcy5CmtC98301a+eeVge7YJm6BflngOI
 RSlLhOra/8mc9hmLn2GZVf8Cjk6GjoG5JP7r1UFRQ9r2JwykK27ZRm435Hp2JmNHjbygl+YG/ue
 NWAFiC6MYfKCyE1MT/qqh5+FxFxW4PnlSNmp1FKoltKnMJxkvfrdlKAaZLFen8oYJCEGxfkQXWp
 n7bOFQrMSy3hkwYVdu21hT0O+MBxNSSYnL1RgNwa/L8JSR1Y264DxKQZcSjEK9TPF2zwq8XAmcl
 mVax4BRKLt9WnHYH4IgoB/+36pWOlg==
X-Authority-Analysis: v=2.4 cv=KePfcAYD c=1 sm=1 tr=0 ts=6904224c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Xa9_aeIGFnoHwIuu90YA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: RBg1ZRHoj8DB_JhjyMovzyCMqP4bbTbR
X-Proofpoint-GUID: RBg1ZRHoj8DB_JhjyMovzyCMqP4bbTbR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310022



On 10/30/2025 12:31 PM, Yu Zhang(Yuriy) wrote:

> @@ -88,6 +275,7 @@ void ath11k_cfr_deinit(struct ath11k_base *ab)
>  			ar = ab->pdevs[i].ar;
>  			cfr = &ar->cfr;
>  
> +			ath11k_cfr_debug_unregister(ar);
>  			ath11k_cfr_ring_free(ar);
>  
>  			spin_lock_bh(&cfr->lut_lock);
> @@ -140,6 +328,8 @@ int ath11k_cfr_init(struct ath11k_base *ab)
>  		}
>  
>  		cfr->lut_num = num_lut_entries;
> +
> +		ath11k_cfr_debug_register(ar);
>  	}
>  
>  	return 0;

miss _debug_unregister() in the error handling?



