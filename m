Return-Path: <linux-kernel+bounces-864207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAF0BFA2C4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA07F564D35
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665A22EFDA6;
	Wed, 22 Oct 2025 06:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bbT4OSXS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6642EC0A4
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761113282; cv=none; b=PWDXltvTjWsR3xn6qRJd3C+fNq7Cz1GRRA1rnIQikGfF4yImhsQ9HsTFoSqSI50iMaSuIXk3s+k8FdpAWYZfNcBF61Y3aAQ18uEEzXmtBTRBX9kRV0pB54bMJ9hMBjvBYamInzRUUkEehK/WUMwq8vQH3xmKmO11z4FFd6t2/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761113282; c=relaxed/simple;
	bh=Sglu3AHsdA56DCF5eQWWlJB8wv7B+UPJmWstntDnA1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOl/bgMkaE/HfWjlfDp8H/VaLlJkrGsSbdRrBcQezi9at46+WhUzmpKvjbQB2GXf4rOUXh+FsRuds1VyDaxEcmSiYV30s5yoCRGnV3a4Y5uvW0Uk0e1A2+Sba6NSDOKbXLenDu0fGqtR07JiiL5klYxPx/wYK78sa3xo5QQMiyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bbT4OSXS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LKfDhR012317
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jFeybT/HfJvpZ870zvEnUeOgeVUn3AqbfdXfhS0xCBA=; b=bbT4OSXSVy70ojXg
	GZLEUlW4Cd+rDP2onY9nC20OE9A4Z3PskmSXaO09KYOwqeugQjj578EncreSYzlV
	GC7+r5aQeeH5h5WKmUU8wRkcPW5GoOT+LzQJ35mFa7Neih8SKDTiuSErYjkXdgvB
	kTlzOCNJxr1Y81o0KmFSIfkH0kRHHosf7U8m9q6dh1+41RQKeRdIc17S+fzl1/dI
	3WhQsdi4ansztVJiWk7U6/1/mcexZTdVMJaQ+m3pKIKzRhHol4uvSM1TRTR35qcn
	3itZ5s2PjSJjglbe9xtW7qoJix1ov6z3GK+S/xyf0FiZLFX8NOCD10WjsQ+IbmO8
	8GKLbQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0h9g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:07:59 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-798920399a6so639194b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761113278; x=1761718078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFeybT/HfJvpZ870zvEnUeOgeVUn3AqbfdXfhS0xCBA=;
        b=SI3cBU35jiOGxpYToeaQIxT8phQM8s59ElItYWDJZ6fdIw0x0nIWPPP/o/mrVqf/e4
         wqSI0AZL1CoPCzRWzGcGFCoYxHMDxwNuizxdGl4RsJ4JVhMEdMQTlq6fk/YwBJWqNmcu
         Gswk+RzMujVhbtSe0Fdt1/1Aki37Vs8tFMcrHwfa5YyFrUmqd7TVw42iFnHhjTI1wNCm
         qsIdGV8UWVERGHGxaAWncAnAfGEW+MKb9RcRkHJOHTN1qJiMi5Rxag3bo9BNE/umO1DR
         Fjd7cEYa7bBMXbqyYy4Mhli0bf/yOhwlsmyR88jenS3wATzLzpBkdwpX1y0DE8BOLoBQ
         4GRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1DHVqHnPYAnx6E9jujNjAqZH1q4wKmGqNvkeuf2IvjCZp0pVHG4fEeoGm/q9Gft6DbNt5EX4LnRSjLcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySdQ5/Ki+jUhXzBOsridevNq50SZkiJQivXH6f9UdGBr4i0v8h
	vEiQpDb9sgV1N/SPow28RBsI+PzUbrPyz5MCXHqvTUtq8dmhWoQMS8xrDIcSn3tm4u9eNfh3QEV
	wGmbjyDbU4odayPBeFbVAHVoxgsSnUu+g0jd8eIlfrCh13fTbicdIQMpyNGMo/IXh9pDd75Nx8I
	c=
X-Gm-Gg: ASbGncs7rxlRbJlPYlyLZksTQsqhJbTqZ9r4Ln9OoIqQdy3CVfdpSShWx4hR4pifDVR
	3ihepzdAGZzoGilWSt60eXuyeo1BZe6oggh9ZKHiOk9RW3+oES3nLGV4jSauppkAlmkUbGfY6t9
	uMMc2m9Zsr4aOV4f7VUzJh2B8tn38JYWgpLxNm9nUUbe3BdXFs8k26+Kupf1BHo7QJisNA71TAz
	oAhvz5PG0Rs9RK98VwZEkwRyeqGULy6sQt0rauwdVBiOh/XXTjZlwMJmzck5DeBoBuqoNM4vxH3
	TLpsL4fQezLPmZj9qKZuMTuKqI54dAAwecvhFmtwQnH/QP8Y2Z19KaIIi7ZnbQrADYrHfJWAbTN
	nFD5si4SG/PfIlhUmVhkA/m2BqItL+1EDtg==
X-Received: by 2002:a05:6a20:9149:b0:246:3a6:3e47 with SMTP id adf61e73a8af0-33aa6879675mr3426048637.12.1761113278332;
        Tue, 21 Oct 2025 23:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/8gASKFn2EzrOtCVC4l7qI8001cLdClTDmvQxCAmZe7gdni7lRkjnTKbSZfKe6wvNF9YvPw==
X-Received: by 2002:a05:6a20:9149:b0:246:3a6:3e47 with SMTP id adf61e73a8af0-33aa6879675mr3426021637.12.1761113277873;
        Tue, 21 Oct 2025 23:07:57 -0700 (PDT)
Received: from [192.168.0.166] ([49.205.252.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff3f6c2esm2019810a91.6.2025.10.21.23.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 23:07:57 -0700 (PDT)
Message-ID: <c3a468be-39b0-5c3d-e4d8-9e45f3f6ae22@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 11:37:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/8] media: iris: add support for video codecs on Qcom
 kaanapali platform
Content-Language: en-US
To: Nicolas Dufresne <nicolas@ndufresne.ca>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <quic_bvisredd@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20251017-knp_video-v2-0-f568ce1a4be3@oss.qualcomm.com>
 <579c8667827cb1ac5778b48077f4f84e875b69da.camel@ndufresne.ca>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <579c8667827cb1ac5778b48077f4f84e875b69da.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX6TeZVewpMJEA
 p4W+eGon8LwqvYc7nGKTT0e25pg2Ez5P5dMjWAuwqT53z5vrfwEw1ZHUJ/Ve15NFo4zdsFsxJwh
 WnaiYf4Xjd6P/CO+v63pJrA/T1ul++TykJwZ3pJOd2KfByWvpkfdjzT143bXWGQJRLJVrJ/j6At
 yyM2Gi5Aglrix0nLPZUPwxceQL7o7o5TkMWbCtPUNbuIY0+SVm4wsyP5eIYTSmWrNeBiLNSsMnS
 rcb0tDQMTIMu6CvY6dMT4t2EubWRooYy+3YqrmkOT4PXRsDrhqLTvZo5L6Tf7NgpwoeyOt1pMAx
 ODVGK+oubibovwpFZ+iZKTozROz4cSiaod3lklkIxWJ7gYroUuksZmCazh3C2RIkcWWILVqAev2
 3YFFF3qhfDJa4EQAgTA49QE0f2ii4w==
X-Proofpoint-ORIG-GUID: oBf24HJrvuCgBA_rn94a1wk9MCWK61DZ
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f874bf cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=FoPg1IWog9mqHsjG+aRTFA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=PfT22KiLOBK7PLsoD1AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: oBf24HJrvuCgBA_rn94a1wk9MCWK61DZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

Hello Nicolas,

On 10/17/2025 8:06 PM, Nicolas Dufresne wrote:
> Hi Vikash,
> 
> Le vendredi 17 octobre 2025 à 19:46 +0530, Vikash Garodia a
>> [  350.438406] qcom-iris 2000000.video-codec: invalid plane
>> [  350.447079] qcom-iris 2000000.video-codec: invalid plane
>> [  350.458821] qcom-iris 2000000.video-codec: invalid plane
>> [  350.465860] qcom-iris 2000000.video-codec: invalid plane
> 
> Just a highlight, the driver should only print stuff on default log level if
> something is malfunctioning. uAPI miss-use should only be trace on loglevel
> manually enabled by the developers. Mind fixing this up while at it ? Hopefully
> this will be obvious to you next time you encounter it.

Agree, this specific log should not be part of default execution and more so
when this is not malfunctioning. I would remove this log as i see it can be dropped.

Regards,
Vikash

