Return-Path: <linux-kernel+bounces-739492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2734FB0C6E5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50EDC543B83
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFF218DB2A;
	Mon, 21 Jul 2025 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="InnDm18Q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CB7B67A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109501; cv=none; b=VrkDKfSZMnmglT2/20vd2Brnil00NL+vsC/SGwS5rruGSRlZno5S6k26KVVHt0dfq99ysozQfJTjkqVIN9K6A+KfwigaEhqwK4jiqdpLN4nMzW10PQfIvNzz/nTMUuzGZvMkxt7fmQWLUvDa0UiWmfXNcxvPqW12OQyXZi1bH9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109501; c=relaxed/simple;
	bh=2pvWMH07iqrBXEk2OWRv81HLnHYw7YmDApBoBqzjtKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbRn34kw+CfgLhpaiQj1qo4jBNxuzGwSV7IuomVZjpzpwshq9wbnP1TQe/9+I0AbI4ud+Tdtw9J2SnDUG1UvHxRzTIZAC5B7IuqRy6+zQzGmlCXvHdLwmYzQR8JSa+W1LjhaJ33KuklTJz3eE2XJnD7J3yND2EhoN/aUDM3CDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=InnDm18Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LEM8vU025721
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nMgkULWhFnNfv8reCcAzyxz1uD+6zucjoyW4qz2tQPU=; b=InnDm18QKyUuvqHl
	Jdk1ho/XBnLd4JMnlT4ifi3Zo+uNU29WAVqEvZTjgY2sfqNPG1vb8Yvl30w9SkJk
	6G4k8qy6ZJTMRPW7B33vmbJqh/GMelvuRlQNNO9ItELvZGB85WXP5vO1cCGG54Ji
	dfGEmJ0t6RNIyd3TyMt7HJ8dyQSnxgE5ENng0mlvr9knV5Er+Fbla4GuuDapmTvy
	S523aTo4lJ/44NS9XZY3uXU2NzMGiQqrAs3Uv4EVFH4C2WJczyMDN2akB2MEFGMi
	n9ScBSouhPqeXb7WnLgxppDaIbsLBQn3u9ldA9GjT0uzlVgLtpaqiG0EPIkDLW2L
	+F3m/Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048v52sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:51:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e33e133f42so63806585a.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753109498; x=1753714298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMgkULWhFnNfv8reCcAzyxz1uD+6zucjoyW4qz2tQPU=;
        b=ARZhp0kjUgWTXWVpufhCqJaQZGdH3QO6sq3CRJHDELNQJx5CxGUmzy84g8+m8lCItW
         gdXsuPP318OHShxa0bzXUVuM2b0IuoEGrV88pBS2LRaJFsZ/xLUcogMSW729S46z/irH
         qdYE4mhhdtA3rLwOfUi58R6Hn9c1wS0PjOoiAlj7+fBABbg9QCIpSie8Yv9JgpfXL0rn
         T+mRxrW4UfGOU0Z7na+EDNXCQ6rSYWhdfFn8g2hXr9nNRqQSZ+R0ynfiaNdzfxfjEmCK
         x/qKg/Fyt3meqeGF3qSKjAG0hVTbAAv/GaH7iM2G8IUrry8LKNQwI4HNqp/W3MjFjayQ
         fQhg==
X-Forwarded-Encrypted: i=1; AJvYcCUI4CjRQi05u6Yf7Q755axEaFKsANt5aOWeZIk8NQ3KjjcfR24i2IFLpa3KKi7esqv/ABR2K03oGY/kdTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDlS0QGZoQL5M+09Oj4FZa4YAgSP4gsO+20kxtCFFz0wkPTttW
	qOrQtI3MaHG3+HtJdXnC/FmPCAm7mx5aaPWVb8uXQRHKzB34NtW3LBVrcc1xlPXWK8HW1aeX2lI
	ODBUF1L7XzdMgpd2ZzREkjvmJDYbl3iXn90M4nFlY3VqdzdPUlIADVzeibiStZG2Ff60=
X-Gm-Gg: ASbGncuIddVP+8LUG8iFtblKQlqTU+gcX6n2+6kmbQZiFAgz+whOKWkYvEnc8OrYwh7
	fc3TxNd+smKjO2+T4Cyermhy6Xo23a795go7ErUAqLUjF0Pe62sXdPB9oRWtrIWg1hzB44pbZk/
	ABUM1qLU3ke4aTXecm7r/t7rJAhl49LR6G4fPOkP4jKF9i472QT7Vn90x9a5kvB2mceeTmDIiS6
	WtI/b5Z0VlY20jxpR853jTJkqJURiba1Y/vuo1OchlnauMpFLpub/x2yMC5MwVIchZCV0gsFoy7
	BMuPFwTU5/w4XdC5mhE0t1WfoZqn8LECQgNSiutjwEPGoSSh9CeSNmTTTjARN6416armQ2GKVAy
	5+7hZJGxNm/22sQQlpr+z
X-Received: by 2002:a05:620a:4014:b0:7e3:39d4:4286 with SMTP id af79cd13be357-7e342a8e398mr1151687785a.1.1753109497899;
        Mon, 21 Jul 2025 07:51:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSt5/RDO783Jsf0Dpjg6Xj5kzj9H3igzttfEVO974rPIh65MJIGlIMPiuiECbGupg7YZMCMg==
X-Received: by 2002:a05:620a:4014:b0:7e3:39d4:4286 with SMTP id af79cd13be357-7e342a8e398mr1151685785a.1.1753109497420;
        Mon, 21 Jul 2025 07:51:37 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca315d5sm693468166b.98.2025.07.21.07.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 07:51:36 -0700 (PDT)
Message-ID: <21c75060-eb8b-45f8-bddb-816fce787240@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 16:51:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pinctrl: qcom: Add glymur pinctrl driver
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>, andersson@kernel.org,
        linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_rjendra@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250721143037.20983-1-pankaj.patil@oss.qualcomm.com>
 <20250721143037.20983-3-pankaj.patil@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250721143037.20983-3-pankaj.patil@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 84YpWuK5o1gQr-RUhMOl8ML5aKzLiBSm
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=687e53fb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=PtIsU_pUeB5Sheknjl0A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzMSBTYWx0ZWRfX+o5oKvQzwntP
 HRL3VMShmY+1JCYOsJ5rl9A+X53wXK71kS5eMSIm6/93exJohX1ReQZ3zj1yD07Z5DV8yqE78mP
 Q8+2VCKhnmMl511GuKrPEJU4kl80dqnzps/PhDmyRoIMC67uKi4r6p0Eob6+4LWdeGpyNDG9tuq
 sTb4/OleKiT4yQkfKmPGP0MjCglAU1GSRcwEGjhYe+8/UPyqOuGOaO/FQjJpfpyZygnzPPItb5R
 UlR3KvcPU419ZuYGgUYeVcljfH/0ws3C1iTUaFK1x1XZC8frsCjZX5+H9Hn86PX7oqLO+15krZS
 VOMLaDmO6zvzDxuH78LjiNOPKLCHUbRKXrQ3Qftwdcx2ajg4C3U+DlyiqKkCWx+pOZrn+DYHued
 zCAkzkgn21Hn1LqxmNDIt5+txgIcHEZHBMblCkx5Ek2sjQqQv5XCeNubDpzYRVi1pDdwGmWx
X-Proofpoint-ORIG-GUID: 84YpWuK5o1gQr-RUhMOl8ML5aKzLiBSm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210131

On 7/21/25 4:30 PM, Pankaj Patil wrote:
> Add TLMM pinctrl driver to support pin configuration with pinctrl
> framework for Glymur SoC.
> ---
> Changes in v2:
> UFS_RESET macro updated
> Removed obsolete comment for msm_pingroup glymur_groups
> Update gpio count in glymur_tlmm struct via .ngpio
> 
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---

As Krzysztof pointed out, your s-o-b is not part of the commit message
(include blurbs under the --- line, which Git will ignore)

[...]

> +static const struct of_device_id glymur_tlmm_of_match[] = {
> +	{ .compatible = "qcom,glymur-tlmm", .data = &glymur_tlmm },
> +	{},

Nit: "{ }"

(no comma, as this is the sentinel and we most definitely don't want
the list to grow beyond it)

Konrad

