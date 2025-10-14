Return-Path: <linux-kernel+bounces-852195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D42DBD86AC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22BE3BB8D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3CB2E7648;
	Tue, 14 Oct 2025 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QQW0d/3+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003A32E5B13
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433776; cv=none; b=lDJjc1nLJms/LyxthtMOMdHE7w+LYhchUFE+zxPSyWSreig0/Pp2bPhPDH6JRWplA43BdW4rTbf7Ue5ecKIKDO9nrASl+T/CCkZLUSxCNowYYlO7zFEVhJU5R61G4kAwpa1KNE1aUKniodOBC/f0OCbtSRHO7j6mNjZbpT7f9mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433776; c=relaxed/simple;
	bh=4kdH9JwWn5BUz8jMj6r/TaxLP/NSVJU/tJpy1sBaGwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePeVGWshbfbsswCBAn8hIlaLMlznQh8XmC4dPaV6v5NKZfPIN7PG3Nkw4zZukhkAQoJ/PSbG8nfhmvoTZ9FjOxJ9j8JXCDhtcahSgtBHkebI8AVgfDeaOckcazIhHU71ffEATc/qE6r2sD2FFlc8diUry0PTpAz/T+YN9tJlxwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QQW0d/3+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87OVH001741
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pBRR5H2TkKxKF7H4pKihb9Oc+NcrIbt0tfqa5n/nEGc=; b=QQW0d/3+8jWCiqK9
	aXFu4NReDnyno1hQnDd9X1Jx11vJXCyQNNBumCgDiKLY0VZq6lJdEpMTmqI6cQRM
	uU/vTq3EwIHSOWzJj//TDDADPs5EtVlvLL7uyRRYkmvRv9hDI4qf2QyanIPc+S3p
	PP+n9huZ3z6atcPsfZS7gpelklaTApv4fjkZf4OKKEyE9j5k8GsSndCw0R9fcPOG
	Lgdam1Fl81MDIF3bSFYnnJIjdk5b4Oux7IVOvSEhUnjcSgZNygKhi0jhyGokAsxW
	Re/i48Izy0xnUje6crVmv+HE5mSiJdwZqZFpTD+WpOR06Q7qOmS8bm9kgr0xsER/
	ZSUiCw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdk7v4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:22:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8649a8dbff8so225704985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760433773; x=1761038573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBRR5H2TkKxKF7H4pKihb9Oc+NcrIbt0tfqa5n/nEGc=;
        b=wbbr27GCQ/m5NoaYMhuQykumuFJw1CPQTGvrNbBkzmgP9MNFw8U6/or19QE5LhwTY1
         KBP3PmK5gj9AsEWq0G3zo6XXppuygfp0LqC8jezzjasbjNSzi7fDgkTu3+Zhks0DIIFU
         ZjRHxjGIYX2ESk8HlYd1BSjKhIkGUgHDpZ/QuxXKpMu9njtA3OyXX4XWL6BLHmz5gEWx
         WvxJMxUGa6rmQlcg+PKbSUrnwebAOwrWu5o+zrr5zEJgGEk80A6p4ocWoFA4AM3a281r
         r4ON08nR4ulS+k5HSgHbl06qL9mkFvAUG4Z+15T1N8S4nbAsEeBYuraPxv/cXaGs9uJK
         ztSg==
X-Forwarded-Encrypted: i=1; AJvYcCWoZDthXoTtsxXrvNLHb9IAuHB1YHJ4IZs1GPIVy3MzsN2LmXQzIFRvqQKkt4G7MVfuf6x0KkXHTTOwPB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWjyKoSTwHzkMk0QqN4RV9pYGursfjhkvTNUF8IqQ+/6Yv8v02
	rxYdjz5vJYkRMknk5uCiIa5WmeMeJBDJKgnSr7Te18szRDt2S5yA7CuXk9we9OX+/V1vTaXBSRL
	sN0sPsT4u3A24dpywqqQq5gUB2yedloy4hMEn5C7Ro4QyzWd99B7e7luMVXr+HlCknvk=
X-Gm-Gg: ASbGncvHBY0rCKe7rZmx41NPbqCa67dsvvHE86/24tDEq6nIkSb/NXXMs6mV/OjGJqH
	C8bHgSNRFJbObyA7kuSk0tsv8AGBKdlIEEOzKjYkf6BHtGUxgixo3gBjIRGf3OTwL1IJYS7AW4q
	g+UZwIxZClJSrlnLaIWTwdi7dTJSq8PczX5zAjCT6qZbEB9+kRPMBEXkQVpftby0sQnfacE4I1G
	vX/qc3Wnsbf1ehG6xM2XvmBZteBjjQ4x3UzKSTBWQlMMnIVU8oje0fEX9lw8wFYm29UcxhtOstg
	IfBRJvqjCnhwk43A+4glkhGV138j8HTaIcxssAVk6k16TqtSRjuJYkOZU0rR9k8XqElCv1fAsPI
	tfYheZ7NQKULC7M46LDe/pA==
X-Received: by 2002:a05:620a:bca:b0:862:dc6c:e7f3 with SMTP id af79cd13be357-88352e8e8eamr2066568785a.5.1760433773170;
        Tue, 14 Oct 2025 02:22:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6lBPtCjgj5B0ks8xM4dqV/qBR4R1q23vBYNJs1dE8aUXN8FmTT9yYWz5xoRUNmm6qC74jzw==
X-Received: by 2002:a05:620a:bca:b0:862:dc6c:e7f3 with SMTP id af79cd13be357-88352e8e8eamr2066565785a.5.1760433772666;
        Tue, 14 Oct 2025 02:22:52 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d63c9a3csm1127034066b.23.2025.10.14.02.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 02:22:51 -0700 (PDT)
Message-ID: <87650853-3b4e-4a05-b3f3-4fcb8820ea9f@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 11:22:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] arm64: dts: qcom: sdm845-oneplus: Correct gpio
 used for slider
To: david@ixit.cz, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Gergo Koteles <soyer@irl.hu>
References: <20251014-op6-tri-state-v7-0-938a6367197b@ixit.cz>
 <20251014-op6-tri-state-v7-2-938a6367197b@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251014-op6-tri-state-v7-2-938a6367197b@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0GWD5Ye5wYFAyHsr5OXBFvtlWl7_Y7kq
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68ee166e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=b_3gLtI3ev4ASzC4froA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 0GWD5Ye5wYFAyHsr5OXBFvtlWl7_Y7kq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX7gkB56BcaFYY
 ymDKMkYbsMtgUbCuDHkkFlc41Avjzsi98RQnYMM2ToMemoDeLKJOAyBXwE+jTxm2HQH4CvmudKu
 lsEhs/7hCPCIIRzDwd4nTvBZ35Y/rbxX5PF8rpV9o1ObdkwaLfSv9O7dBD2KjxjgN0pY7RKpk5u
 sGJtggvCfqPLV1GIo7eHi727ZaXnmGMg1g1I71LURQeq7sNEaAqsgScYOcNiXmaSQuKSMkb0nse
 ri0pDLMdLX9oPZzirDDq7Pt3WG/LKE1aGgok5VrDn7tgqGRoGI/4bKsqX8BbwYy/euzieA8Xrdr
 CkbsesuxIqwJwzW1NrEtaNscMeScKkaYlvkLEUAQnZRzXc3g571ArTTNxlpiQZEiaj5yBrU29T8
 xClaWVZ0qq1B2ZYGohz6P3LUGHDlfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On 10/14/25 11:20 AM, David Heidelberg via B4 Relay wrote:
> From: Gergo Koteles <soyer@irl.hu>
> 
> The previous GPIO numbers were wrong. Update them to the correct
> ones and fix the label.
> 
> Fixes: 288ef8a42612 ("arm64: dts: sdm845: add oneplus6/6t devices")
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

