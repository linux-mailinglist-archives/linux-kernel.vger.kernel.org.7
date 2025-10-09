Return-Path: <linux-kernel+bounces-847503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D2DBCB056
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F514820A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46C528505C;
	Thu,  9 Oct 2025 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fp17ahPT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBBB27AC3A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760047624; cv=none; b=ZkF7xcJRcjVP7HBCzvJzhf/dFZQ933Cb4oBomUag+l/y/+C8J6BI4VH7pKAAhILJAyW53U0MJ6XE3tAIoVXsVPcEsWpOUYOwtUTVdzrM20s20cu29ykl4Scr96J8Twq5PPsx3mgHheVSBVZMxYOBfFodY42ZhepiFtAHNN99WSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760047624; c=relaxed/simple;
	bh=dQORkJk6lnXWVGu2OR0fRY18hl8zcwHvysnU6b6D/2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmM+abpMCFsE62mWg4UQIbr+Ps7tlboRQ+zh6UxV6T+l+jWUL8NgGH9b4aKAZ5o2sQeWMd0Bsaj8zzUQuol0mMqtfxPVoYnxkrtu8VLUBtXv/hzFVQG+aXPYv0+L5Bk08SJSS9UaeCyKDdL8qg6d2JWbTiM8pWQjEFjhWhep2Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fp17ahPT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599GG8rF023382
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 22:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PR41P3ZaU4FEtAYgEwsHsgOa9cZPdhmWSVDIIYk7xVk=; b=Fp17ahPT8DWjCQpt
	qouBdxGL1HMc6qfBQ5fW9eknKz0/5+fYAXH6FGfBwTVqeKnXsCrtGof8SNNFqChl
	vXB0p1CInUbxoMqW31vKUzukBG8LlPAY+IEhKUX9qYRTPK2aaCV3Umy4IqPsxF1Z
	SXZYRzGntiBxBIdpbPw1MTD/qjsmSCBn2o/mGZf5seTFB59S9odpAcMN921M0KzF
	vQwv+yLvRoH1N1oaJbeePgp1KDCm6Uu/gv1iid4CEI0KeNuygZ6mnT5QHiCJOKB8
	2X8OLjzYRY/cVhU2ii49bg060HRAN/F4ftjh83y/pP//xh4qQgU7yZWwE1Nzimma
	pM+cUA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49pgdsrue1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 22:07:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33428befc49so3632429a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760047619; x=1760652419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PR41P3ZaU4FEtAYgEwsHsgOa9cZPdhmWSVDIIYk7xVk=;
        b=RRyqW99PGoSvH3yNbBSkDg8jsOdBxUZTvgl293hOdsHKRHDyCSn8j6s17+6tkJJVsW
         LlaJiRA5euCKNRMV17pXF0Oy47cLfQ0KGWtAZl/UbMbLhtYGQq/oiVafAlc5U/A8cyAd
         j4VWm81JORidlHPnSAbT867SVGKVnZ5Aq8NXO7TAcGeFGdDJX3SiWdIXXRVPNLm8QOEI
         nIIZotfd9QANEhPypF1Go0sj6qvFRn2kJYwwnj/fmP5gGIH54gfFmKL2MX0jLuB9Nmb/
         HkfWKj2/3n9K1SbpmOAeoao1A7SyGTfg/mH5BfRAgY1J987bKIEmTHmVnqroxd5AWhJ+
         32HQ==
X-Gm-Message-State: AOJu0Yx05HPecadTlVEAqKcMLpwTs2LfYDffaSsl9ONpC5M/0VfX0ILN
	tARjOsLhJUX3UKS3ERsVwD5kAt3WyGtqEvvWAiwyaPyyZ1appU545WPGKfX+AFNZsFKT5+vUNtU
	cKsYnQqpV9bJvS5FQQQrlky8qTmCkzhhnQzdKx+pVD/NKhcb8iIfiw87RZAGt+bojSQo=
X-Gm-Gg: ASbGncuJFgVfmXhQNg27eZK2/WQR8Tjd+BaLty2xlCfK8q+s8bJjSgCl0w8FaTTxDxK
	asT/yo+vpwQVWrtGzt3t2HGGs3lhvPJcprDPqDmqPwoofkVzqUSR+fXD+T5ZNf4lND6HqH1Bkr3
	0T6w9wl5N2vTuPvWfw2ARzPgl+CmdMNIMqhDp3cjAPxwKt2dxIFRmq0QJfEldhf6Ql60IcUSPZV
	Ekz5C0nnniPQ+eeRRYp87/yO3mmMilrFf7CSCFL4EIsKFkY/PRv19AWdImK8KfkFM8ge7vfJV0i
	RGzqDD1NDAsZYfq737JDy//yoZzTbaiIDkFWVBEIrTWGxSXLoGSbmt5rg/Uot7Ps5OOWtRrwsBw
	C8fMiqWNVkdpsDRN1PreHEMQ+LXM=
X-Received: by 2002:a17:90b:58ec:b0:330:a1ee:e119 with SMTP id 98e67ed59e1d1-339edaae564mr18570378a91.9.1760047618901;
        Thu, 09 Oct 2025 15:06:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4fyyM+GG4JOApDItPR8uaTlgz9TNMfnQuqAW3pfKetHHZhA+J8uV0VeyiU+3SyCfTwZRmzQ==
X-Received: by 2002:a17:90b:58ec:b0:330:a1ee:e119 with SMTP id 98e67ed59e1d1-339edaae564mr18570335a91.9.1760047618340;
        Thu, 09 Oct 2025 15:06:58 -0700 (PDT)
Received: from [10.71.109.75] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61b0ed20sm908807a91.23.2025.10.09.15.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 15:06:57 -0700 (PDT)
Message-ID: <55709a7e-21bd-4728-a818-d2739fa1a86e@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 15:06:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: Remove dead-code in
 dpu_encoder_helper_reset_mixers()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <8e3b2fbbf5440aa219feb667f5423c7479eb2656.1760040536.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Mahesh Bharadwaj Kannan <mahesh.kannan@oss.qualcomm.com>
In-Reply-To: <8e3b2fbbf5440aa219feb667f5423c7479eb2656.1760040536.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7eUHrbUKpVj73tzLA-UF_4AD7ppCUdON
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDA5OCBTYWx0ZWRfX6+O9tLwb3sX6
 wbAYNyqgsA3v7X7VtqNcLWpAYqc5XXzN0xAiqnCOidQi5n0a+L36N9ZfYki3SeV4YkSj5nA1Fj9
 ksy1OLwR/4pMdPE55nL/tB5lI1GlL0cJDaYhzOt3WpBcRfDQTNVIuDTIILn/U/H/METdJ2PJLfg
 1X9Z/tEaF0t4TTOJDmIp0/7VIGwd7Mctcz0yrkbQYXJ8dZwMoSeoi/pG5L3SZk+fDxyxGfwvePp
 ZQ/fjIueCgFpOfpaq1xtQ0pB5jGoOOu78ZI2oj68unxS5JUZUCxRUGShVJ2fmrfsl9CYEYs1THC
 RB2oi1mON6V/5M6nHg2Xc784PqEFQkgdKvApfKLvRpPTfmxp4canwa3Cp9j5qG7pspuqUMm8rLE
 nF+/xdIJq+RLOqJupQCnK30yesRldg==
X-Authority-Analysis: v=2.4 cv=DISCIiNb c=1 sm=1 tr=0 ts=68e83204 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=HXVKm-MKDGyxfSjg48sA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 7eUHrbUKpVj73tzLA-UF_4AD7ppCUdON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_08,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510090098

On 10/9/2025 1:09 PM, Christophe JAILLET wrote:

> 'mixer' is only zeroed and is not use. Remove it.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 3 ---
>   1 file changed, 3 deletions(-)

Acked-By: Mahesh Bharadwaj Kannan <mahesh.kannan@oss.qualcomm.com>


