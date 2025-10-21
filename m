Return-Path: <linux-kernel+bounces-862467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F32BF5601
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15861883818
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B833F329C5F;
	Tue, 21 Oct 2025 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="el53CvSw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97791301034
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036973; cv=none; b=q+hhNZGD8WhRLTYXlcWzjgf6pBYQoboPsUD3/GN/ryLgUgY8+coNIhKM7plcrCp92Z6L4IjLBoQ8wT48mYStDfYfg0Q1+NLibYnleRwAi4W4QVzqfKstB58mx6nE3kvJarpWF7D4GyToCR6jqTkvYA2mlHHTuFzmldhEVMGsKpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036973; c=relaxed/simple;
	bh=p1HMLQCAtIqg0gUPotjCohNGE4o5HyZj/UP6M6hYo+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gojjY8QgoWS2z7xEOVgAZYBY9Y1cHrR6gxSrxQm9ODNeq2aQqVO/r/lnXm3M6h/Vv1NXtjClN4cIZqTJiwQBA2XSFJjh++Yf0frnPTPAVP7H603ujdCsbMdCI/0Mu3jTRdkbNQTPYLH+Fbf34sdXbbqb4ukFVJC51flVMgNiAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=el53CvSw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8MQdC005407
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gPkYKty+NWUtDKsrjdBKt0tpiMSu2WxnR7dA7Llh8jc=; b=el53CvSw1pdSqS7z
	6YzG+RHH5ma05ImFxOFA1bfe+NPfH8OAQUR77mLGhAbqkg+X+22lB51L0EtmgTrA
	Q1kEzFMVsZd4ogv88YXlwCzRFZJSmR4wlVqFQJNL7/P4ck4UVMT2pnb+AaJUmQua
	5nC/0koNF3dqAjIPvryzkkGGkksiMRzBJzYD5jGUyp4v484WypVKweauPP1Z9E6N
	VN632yiSGRQ7wPh2mI0VKZfUjAS378Rs6SPE6hpDpTYtyUcNFjsYdB6b6W5w3c1Q
	IbC+yHEsgvdsCGGEoZSkxygzaT7YvWgZeQN6lexm3NsTzzMSm+HYNjwYpZ7C6szM
	BkZYuw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nffxp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:56:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88f3a065311so199108985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761036969; x=1761641769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPkYKty+NWUtDKsrjdBKt0tpiMSu2WxnR7dA7Llh8jc=;
        b=jvZchY+lSPjj1GA8X1inDaN29X7SuWgumYKl9qdmJFwMr2IxBWYrHixIIZCigglFgT
         btcVuVape30HBYT29jyyUPrZqgp+R2fgY38VExZxKSlxBDp+ZNOpIWa9dQW779pKI+SV
         BoqfCbWzvXm5/61zbgN/8P8tI3iTBjMkfgQc40hWLfN/ZKrUFFSNvU9jfKTMatErYkSX
         FWKgbF8z+uSo/AbQXa8qotKiVFvEMpl3d8ZkxlXwY6giGiyB6nWK7+cuiUMvUk9P6Zij
         699z1BVsTpk2G2VbV7xj2nGS08JQUWn6swT0OD0GLE3anmU8mviYHlpFzBL+By3ZEhdE
         GhVw==
X-Forwarded-Encrypted: i=1; AJvYcCWPPfOxy3XLHiXBibZwkR+okNvuHQZfSYRASubuhWWi+3nVSlORoMSU569hX+2lv4BSr9iGua4DKzUb+Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd3qRYnr4wDU/dVhHd+Vfw2BbXVMEAfZ77kZsq19GIfcfmP2sA
	S07Q7pecjNwmLMKboLMRVPxQns/Cc9RE3VmdsPfMqNgLIaoTo87rtQhCgECSc0z2kb/+/Nm5IFa
	onYQ+q5YzcZ3Pf/qysooA56WsBvsQQxQUEtbxH5qYN6bMc3dh+78usnA7Ryym1xebpyU=
X-Gm-Gg: ASbGncuOTFnvdD3vFxNq7dAcPJBRHqtXAEaAWZOtfgDFTR1mM6/RaMkCoDYjynbaPHb
	OKa5Er3ZCVB59y+DzET88rj++Oyk55IxzZ5JsKCZP/TVzxjIXEkaI4DeEM3fiJpemB4pZ37f5OK
	qHgYXsqsqLgIifAkYoF9ZLXBFuAXt5qs96Az3r6B9YL1Y64ufcz+PMDDcp5PyPlOPPQfgryV56b
	uQiuESprZJIqE3r1MQ/hwp9QPt0Y94PWRSy8WCQeScCSRk34pMKVJ/5OdpcHacr4HoHMWVnjcXK
	fn7CCHYMMcNJMaTmmkagwZ9nUd2K8nIsm7gty7hJCH5g64JNI3TOnSODlPFcbsRm5jd3Gm5uuO4
	yNPP75NGPrPFDnAq2yUOp6voxePMjZNTx+qYtyaQq8FOn/dCxECvAtMmd
X-Received: by 2002:a05:622a:245:b0:4e8:97b1:2f00 with SMTP id d75a77b69052e-4e89d07b665mr125492421cf.0.1761036969322;
        Tue, 21 Oct 2025 01:56:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwBLXqTI6f+Bzi2R6wECJZwkz+yvm9ue+XiJIYIwB6PxHU0f52M5+P+xVtyMO9HaSWzM+hQA==
X-Received: by 2002:a05:622a:245:b0:4e8:97b1:2f00 with SMTP id d75a77b69052e-4e89d07b665mr125492291cf.0.1761036968808;
        Tue, 21 Oct 2025 01:56:08 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e89713ffsm1022412766b.36.2025.10.21.01.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 01:56:08 -0700 (PDT)
Message-ID: <f284c279-a283-4cae-b405-02d7a0c44348@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 10:56:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Define guard pages within the
 rmtfs region
To: david@ixit.cz, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Paul Sajna <sajattack@postmarketos.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
References: <20251020-sdm845-use-guard-pages-v1-1-64d714f8bd73@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251020-sdm845-use-guard-pages-v1-1-64d714f8bd73@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: R1pjOUHEtJw2QS48xOgPomb8IXbWMneb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfX1+Gbt5BYbJi2
 NqwvR15TUaf7Yx8rdqzfZUJHTt8uVgx1u9AaCEVcqpAw99Qj/pR//gIx5fM1sfIzsJgWW7LWnGP
 cxvKukFWebeUP/3v4C/8By44kIAVV9zGZBR0R/Y17vk6Jg+2LTVFG1PuR6rxPSmR1WOFRfX5i+z
 zYllWX0p8Ej7JmKXHxuULcGm4IDijXQxrg42VWs6Wk4DTAR/NEv4VjafuTg84Yo5NkNTuP//mUv
 ZG8sRIcckJBl7H/tLhfMr46eScT9nqVAYHKuLJUWxcMfR6fqrV6CSMz8H5i8x03EKQ2VC4jnmNx
 q5Yq1cCw1fM6FfglCN89LsuCDKBlHp4iFlhm9vn9J8OdOACXtRtm4p9gU6nVtlEugXsUUMRyAKQ
 Tck/MHwhJJKT1YvQyGoh2MVSNyMZgw==
X-Proofpoint-GUID: R1pjOUHEtJw2QS48xOgPomb8IXbWMneb
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f74aaa cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=WIiUZGVdasX2BrCbfdgA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

On 10/20/25 11:12 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Use qcom,use-guard-pages property instead of polluting device-tree with
> lower and upper rmtfs guard nodes.
> 
> No functional change intended.
> 
> cosmetic: set name the node rmtfs-region.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

