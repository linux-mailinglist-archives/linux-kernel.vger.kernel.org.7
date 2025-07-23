Return-Path: <linux-kernel+bounces-742261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C73CB0EF4E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13023AD02B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BED128C87F;
	Wed, 23 Jul 2025 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XPTTaDIp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E89289E07
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265143; cv=none; b=bW/CcduwGB8AY7bh4At4XvqfzEZn3E8SBQquBiVYs8L6gJMAgOrJK0yuhBcT70ZT/ENimAHzdqNJ/XeJm4a9sPiLysOuHgvKzSYSNPbsCgDeaobTnb05eE+hLmOITgcjLbzOL5xmAhNR8+xguxI5nsPTomMhAslA1719ZIJFwc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265143; c=relaxed/simple;
	bh=CfG63TX7EW5eJHNMhHKCpCZ4PTn1maRn8k8Etpme2PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urWoYdo8rrL/mTV849Rjr7AdtgujqnPauLsBC8KwpgwcQINckxHjB72Fv1EuPPyDtHHEbTUDcUeWp6ULlTY92hkcFeUXkDZPF6TNrwex5jwRQ37HsSEK7ddefiwzIcAVwvfWOnwIFE3wOHudyjAdOY+g84a9a3NYOeI5rz0OwwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XPTTaDIp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9Qn35025715
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4dITZrpRLLfNiDzDsVfXaS3NGw4vNmfg16p169LKj68=; b=XPTTaDIptBlmsY4D
	J3KoAXcU0LlrUtSSv/ydQYsoYVm4ubWkmo+qnBgCXqxasXzMJhFSIAFeq/juxEby
	YNTvni79dr3cmG9NkxPWuGZ6a2QXMmy0oyjUwCxGRGK1a3aNlBuYMNJUeV5PigvW
	VVicywIpxy7cYY08ZLr9JFNSdx4cFaGSS+VNevzxOr0OC7UdT5r0sXQ9Xcwym4c4
	kWO93xX9oX7roWNLHH5XHE/diJ+LGe7p5MHp2Y5hSBVgjewjT8hS4cld5eIASRu5
	OjrKvxXHS3OzWUsOXO9okrDFbR0ZO1kcWUXz7gfR4Rc1XnIiUAehS77/ElUOwNpc
	uO4WKQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1ub8s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:05:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4abc1e8bd11so15486801cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753265139; x=1753869939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dITZrpRLLfNiDzDsVfXaS3NGw4vNmfg16p169LKj68=;
        b=OMCbP+h0mjV2nhtn7Gh4hMqUhjxvKC+gYq4sgqVNRorTlKFAd0HKPkEW3TOTggDnuA
         VgixaTEeeqGlODPk1RiawSMAhSu9rKXhMtWnUFWswGnMraJA5KmlKaQacqvK/FSzPq3m
         bN1GSQeyK2Xw3Bqff2Dt+N8nnpnWg63VmmEamZwRRyRseTY7xlukh6hEceiK18NLB2QU
         Ehz1Gwrkaj1nUTHdREWxuMItLBTn3535uyR/2Gj5PTHnMiVGhYxErlpA1gz3o6fnoOLU
         W8vSjcCyo0epV9FedbgJ/Rqu/lbFW34IBpYmOreVc45wTPWm4wIkyPnS5cX/gRaezd0Z
         dNRA==
X-Forwarded-Encrypted: i=1; AJvYcCVvQO4g/mkZUuORHmfQ78PyYyGryF28sTr+YOb26J7esNSDSopnljOpsfq7/GSjWbY4gja7mgSRBCCb+SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznU+25SX4yi4s7FMSQvun1dm/+9QNVthWHuBD4okaclKrCLiHM
	C7SXfRr3vYBl2O+3Rav+6XYHQiWqt0we2p5NXv+iiCCf1qiAdUR/s8RJ1zFxcPGPxgna52Xcbyk
	avsJixefuuWlNxaprCw0yVNPVX2fl1Ebvei5tE3ZAP1C8Ub+CUdnjMXgxZsLPN/tQS5I=
X-Gm-Gg: ASbGncsHMGpGiIHnZeak4ygrrnZxbvrWog+jTRZd0VkpsbwJLfUlMmDmTbYaU86TOXT
	Jibm5KUzcyBWWF5sH4gdDoowb+9IRRbUE+C/HiRy0uor0ihpOVx+ORk6bz0G1uxNdRY45evZWFc
	cF79T8VLozn+iJuMdomdg/ZHtSdfieT7l7GA5yhnzATTVzVUPbVsVl5wGoRL5WANfOx3wGbaDnQ
	+pAFr45sS4POGMdCnZu+4WgArl9lDuAl2i/jBwYhkEoWNjVGkKZFbupAv8FcEQ+hFzmJLvMBnjN
	gZZ6P7BybnqDzms1Hk9r8Fv4cmfrgoooMV6cxk6Mdv3/RDWw5KJqeN2/9mxaOcAuuZMaRX2QcDS
	yt5QLFm9SopwBGtZwaA==
X-Received: by 2002:a05:622a:1454:b0:4ab:635b:a309 with SMTP id d75a77b69052e-4ae6dc94975mr13062501cf.0.1753265138764;
        Wed, 23 Jul 2025 03:05:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7VWxyiO/uqaEAXmfUFM7818+WHuRXfXtfClF+Ol27/qeXk++n++ym4I/iG/5MBDbAN4drlg==
X-Received: by 2002:a05:622a:1454:b0:4ab:635b:a309 with SMTP id d75a77b69052e-4ae6dc94975mr13062291cf.0.1753265138140;
        Wed, 23 Jul 2025 03:05:38 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f0afbdsm8405149a12.6.2025.07.23.03.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 03:05:37 -0700 (PDT)
Message-ID: <644a81ff-bbce-4cc7-a364-8e0c591898b3@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 12:05:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] drm/msm/a6xx: Set Keep-alive votes to block IFPC
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-8-9347aa5bcbd6@oss.qualcomm.com>
 <jvn44gmttkidyy4emnz6mytqqjbwltlxibywfr6bfbqjfbq35e@fuvvefesqbzw>
 <0427769f-62a1-4a20-af94-b340413296ab@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <0427769f-62a1-4a20-af94-b340413296ab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=6880b3f4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=w1FpSeGnf3HiULV0hxkA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA4NCBTYWx0ZWRfX1sK+0cY8EDei
 nNSzy8gtfGhxVsoNQefMYJo+YmQkT3may9tJhzAdqlFRSLBOdIIw1L88g/sd6PrZTbFF6CrnspP
 H4GRAYnPQUPAuXJKxugr96emSzdm8L+HdHpTRUKzxVRcX9b7rULCS5S9qqQ2DnGe/kFah50Iupq
 Ln1H3uErPCmyNanG5dURxm+agdcrAewFzGRGuZ91BceEVt2+HCJvAkK9XYobpj7PBpObxJVIVgn
 nl0VDbXdY2XJb0wqSvnDQtwW04JL8enKMnFmykFuBJJP9fZdXGSTviapsUUKnOs0LuZv8qrQHqI
 h5R8C7PffT7OjujMUMMEFtf9a4wR+Q84Mc+6tRp2y3zf4aVkY8ACHAf/XeC00vcKkvEDlqvgYpF
 8yIbIRdtb6DrgPDCLHGNI5AGWUOFf/QI+9kulI+fvpy7PeTGcsmHkNQF5ztzjIf6oMLmIYdB
X-Proofpoint-ORIG-GUID: 0ChRRpHjfeZ_Qe_7f-pMbBqVIUi8m45k
X-Proofpoint-GUID: 0ChRRpHjfeZ_Qe_7f-pMbBqVIUi8m45k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=942 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230084

On 7/22/25 11:24 PM, Akhil P Oommen wrote:
> On 7/22/2025 7:14 PM, Dmitry Baryshkov wrote:
>> On Sun, Jul 20, 2025 at 05:46:09PM +0530, Akhil P Oommen wrote:
>>> Set Keepalive votes at appropriate places to block IFPC power collapse
>>> until we access all the required registers. This is required during gpu
>>> IRQ handling and also during preemption.
>>>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---

[...]

>>> +static void set_keepalive_vote(struct msm_gpu *gpu, bool on)
>>
>> a6xx_set_keepalive_vote()
> 
> static fn! Why do we need prefix here?

It's good practice to namespace-prefix your functions, so that you
can more easily find them, e.g. in a backtrace.

For a prefix, adreno_gmu_ would be even better, as the register doesn't
seem to have changed across generations

Konrad

