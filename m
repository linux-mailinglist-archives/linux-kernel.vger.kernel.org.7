Return-Path: <linux-kernel+bounces-848582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AECBCE15F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AFE74E1709
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149E6221578;
	Fri, 10 Oct 2025 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RLDfrb1s"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221E521ABAC
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117355; cv=none; b=flSt0oL6J3lga+qt6hYm7UfzIqYHoLM5ygWYjpnEkHvbYjiszmO7uD7LfXu0pSr97c2M1Ld8NrPinE6mPygWLeKLKRuby91Fgz18iymC4RR8rnp4VRRDjaSueqTH4Ii5hwg1UCrDNNUEQ4xHAY4dH5qv4LTTtah+2rlvy8/+19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117355; c=relaxed/simple;
	bh=1jCvcJTXVwA5O1ApKoCsAYG/yC8rSzDqgspSodn+WO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wa4mBIV4d7ETXxU/SJGp8lkFdg9FDlibLWzxlf/G4+RZDmsIE7M1Z37DmdDegOpdE7iVZVwJEI1ukJmQjZwn9jvrDfKMYWut0zdtzlOdTODWtVC0shamBKwEzf5ycD6o3vTsuPMXU/f+PTuqzjCfL5DfpKFX1PpXQkfFMNPXPTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RLDfrb1s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AFjo29025098
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vm6XdexpWZwlzx/paEBfThj6nvdnnZd+ZlsrP/K4+mE=; b=RLDfrb1su/DFgEtU
	zoxLm3CNAQQEW4VXMs2zsEi0wmTqNABwVnEh9JqTsAXtPoeIbPl6zyV3kTvsKyMV
	xHoQpdGit+tLLK06eKbLeKZIXWPo7gzL/TCJEE/7YQBVVZqBciqNXFvPSM+CRxxJ
	3kdlOYUhSyuHrSamaf/m5qPqnzD9SE/aIi9YUkMu/GJst70xB/Y6o3oCAygkCizl
	BOvi1D2OBf07P517tmbdTgQm61hVab9oVvoeAmXDkPbwH+BP7JtGFFCbMssYB9a7
	TGHj4vyT27UHRcgPhuMJTvHlR3jF/0jOcmwXH0sNHxaBmKCcYxOpr21saUCWYVUB
	Jl2FWg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nf7sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:29:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-85d43cd080eso98799385a.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760117352; x=1760722152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vm6XdexpWZwlzx/paEBfThj6nvdnnZd+ZlsrP/K4+mE=;
        b=pw0iuUsDYYaMh7CDkoat0ZRCb2oGZFgdPwd9H0q108ycNSq5hegc4g6Ms8VY7Lr9KC
         MQlCg2owloSeU+BNQP+Lx/XoIEazC6RV9yr8JpekjTGYrdJ6LUDNUCCUhcVkAavPHAgF
         rPptzZVbgRrMsnsI5VQsQgc6WEc9iKFKWiZABrAX0WwcY/MPDg3SJeAod+2bBZzkyaCo
         E6ENF2l+UBI3Dzlg8XzZOUuPHkOvPck1e/BY5AU/I9hdQ3C4fDM7Qva2DYzl1HCI43MP
         eQyNa4f5/83QFRoktWBxE2pMugtt9mQUlVRe5NdS+1XPC9Tfg3PF7fbVUqwp50VO4lYJ
         fLcw==
X-Forwarded-Encrypted: i=1; AJvYcCXaCY3vIv0pTit35OAJAwfQoR983L1nbxJqodsAdBj5GidOlA8+dwuWIJElMytXcv4KeIj2b3HmsflN79M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwirLbXHwBm4lVCscczxkoXVwIlYgvXvdF+A1kl4DlER43uazWO
	wYGpdh7pMqA7OwrguU15CfqIJnUE9zaRa5cX4klCkk6nthtiFvznuhewdmq7eboY+dPKKW1Kdzd
	wmWoZpEm1UnCa0xXCVwjMAwjJDjPOPcMP1gukPcsEnuq7EJSFkTl9LcRoIePvch+IY6c=
X-Gm-Gg: ASbGnctn91cDezlb/J4xLkELqo9xkTRC8SWJWd/csL98ho65FYVVVOIYoC3xybcLRkk
	EnCeW2VGe0mE5mbFwiK2InLhu5Ic3UMRqgMGNem4u/l96osnB6GteG/gPYFPl2WjpkhHN8yEnWM
	sACvvnFFyHqD5QovmO4kAcQ9AsEHrTQKJZT9aL1zd5cFei0SUkJeKEScEHVlV+hSjUqgJeKOoVA
	p4FsLCLmeYNko2w5zyqFB2jSamVrZn9efsAF34LeNWzOJT2SS8OceEOFsj8v0GvJ1S3UpWFyVw1
	AJh7yNLkZ/6IXyk+jKY99UX4fqhZWFw8JJlJCqcHWAy2YedG1u4LYv/C23FGXTuPCk7avNNo9/X
	aztJsQLLw2VxrGT6D1JEAtA==
X-Received: by 2002:a05:620a:31aa:b0:85a:4bc8:3d2d with SMTP id af79cd13be357-88351fd204emr1274386885a.8.1760117351710;
        Fri, 10 Oct 2025 10:29:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFogdMoGDOLXhTvrD261l4hPgK1+3hErleDIhKiMNxklPDKrnCjnpDVPPlCJiKdHsWHYFcxXw==
X-Received: by 2002:a05:620a:31aa:b0:85a:4bc8:3d2d with SMTP id af79cd13be357-88351fd204emr1274383285a.8.1760117351125;
        Fri, 10 Oct 2025 10:29:11 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cac037sm270610166b.12.2025.10.10.10.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 10:29:10 -0700 (PDT)
Message-ID: <f03e0223-2722-4d5f-897b-91209b6c12fe@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 19:29:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: Add support for Huawei MateBook
 E 2019
To: Jingzhou Zhu <newwheatzjz@zohomail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251008130052.11427-1-newwheatzjz@zohomail.com>
 <6199698.lOV4Wx5bFT@debian-vmware>
 <c6880fe5-029a-4f8d-a08e-81a066a79450@oss.qualcomm.com>
 <2386127.ElGaqSPkdT@debian-vmware>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2386127.ElGaqSPkdT@debian-vmware>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZJzaWH7b c=1 sm=1 tr=0 ts=68e94269 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=6KThAjY6i_W56qehSegA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: GjzwLZuMoG5_syGxd6ZIeXGzhC-fY19p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX6z3B5cPJ3tWe
 gWtaRWYuvwc6YnpfXzS4PweqbNq246xrDGE1U5yWGAQxijcITdj5RVUMPrLDUswSS/KGrYYEmss
 1FB9mokvUoZ6pQh+pdZOjCq/bNyAEHb6sfYvC5IimxLIpYSfG9z5GUl3gxkPlAkw3Y5PQFemLGf
 q2K7namcvadylw0VeGUGeqNnjvKCHX8o9JYMBkM5HLfNuAyXs1rcOBikraxQ8CRyt8Gw2aoxqjs
 QUtJRh52UnmZhhFup9+p5e7wrv6Fmw/4yYfbsCuFi45gqS2PWON0YyM1f1y042ffMMPMSDHn7zm
 Vemu4r9DEdJwezje9k9fcOawH5e/tw2HGa7SbCfFgXB44rkdvHu9eu4oBY5xkU2yCOomm2JI5S4
 qoXFx+8MrUf15NNe4ZB6KXQ0agDZwA==
X-Proofpoint-GUID: GjzwLZuMoG5_syGxd6ZIeXGzhC-fY19p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/10/25 4:52 PM, Jingzhou Zhu wrote:
> On Thursday, 9 October 2025 21:58:29 CST, Konrad Dybcio wrote:
>> Please refrain from resending if it's just to apply tags, maintainer
>> tools do it for you
>>
>> Konrad
> 
> Understood. This is my first time to send patches, so I'm not very familiar
> with the tools. Should I wait for the maintainer to pick it up, or is there
> anything else I should do?

I suppose I didn't answer your question fully in the other email.

TLDR: you're good to go, it should be merged in a week or so

Konrad

