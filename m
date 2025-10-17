Return-Path: <linux-kernel+bounces-857302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD077BE674B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D88A4F1FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0072DEA64;
	Fri, 17 Oct 2025 05:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hx1e8HAF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF338187332
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760679836; cv=none; b=Arws0YtBC03p8reUe3rManCM1qK+SGZ/H8V/7V9NCePxqSVDnVn34pcj7cEwmeFTDO9eUtNU20RZb0oKA/+MOoXTFisWsKh3ifVS+vx3Tn8Xa+txRg2fEQ7Dm2DkeKSp5+XL2WfqAqdKvmafKSQGtc6TA9Gnp1KivLKfSrYst08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760679836; c=relaxed/simple;
	bh=fnigGc0tuE0Cu8RTpydT8F42NNAM0ID7srvItgLzc48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMX7O6nJJ9++LLfJj8GjWmCYLsPJCs6VQplJs/WsRRYOF4aEkrN6eu4hrLznMDf8TTG8B0wSb8eRA+zfi26fBuUEdWyZOn3eSXNPJfbePVcVZ1AT3zdxX2xVucC6khr6gALWqiKvmfYWzE3mmOeRVksMpnLAUfK5S9X3bv8n1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hx1e8HAF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLPBm001756
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t3HNTZG61tyGQ354XRaFA4/AZERq12Hf2Z0ImUJ6OR0=; b=hx1e8HAFCx6uBYMg
	m7yR/nOd6c5lUCIGDTJ0wQwmY4zNQIH+jhhRsPuKHhke7Btk23+h2C4KZIARnDIT
	vjfxB27/rRtgNc2pX5Ty6od64uwMfT6YYKCJDQhwo5GDdbRlCCRjX23knDnq2bG5
	9tu5/vcfOSsb7k7n3I2aI19dCdwgmIRXHwB54AA+wYmBKklY+hGO1VAeeYG9wR6N
	WMPzMDBTsSg8zTOn4JjWrKl9Ct86vrzXNe3qqHMQAWsJnx5DcOc69aVMnveA8uK1
	gcKAblYccMr/rXB82ylAO2rj74A5VSLl4v5Y1EOmnU1dmhj35/NXBJmEq0WED4Zt
	KXTEyg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd9b2j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:43:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-336b646768eso1813121a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760679833; x=1761284633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t3HNTZG61tyGQ354XRaFA4/AZERq12Hf2Z0ImUJ6OR0=;
        b=doOB09dSdTPIaSgQXqzIi6M++H5fmq6J3ip4b2CL4ZlehfeiC7IjBvlU6ZRzLYiVq+
         3OHk5Z1UucR56bK+wFRq8LTi07GqhPMQ+zzS4es5WORuXT/XYuSrqhHzYXeBNUb/Aw5C
         NNiDa0UGB3g/N4jiYp2UQMzuHXSNEvJ0eT1YqSo4FJDPZUIpAB3ulprxk4i5ct8CcaIj
         jpbh/MBHI4KHnqKDCW5OEA1DIbwLZ1X0WLuP9ulYr2RSLSJYz0SuOcTwi8pp3yHIP/xL
         eoudymGB7qT5AxILKqVgOI2lUm9qXUz6SYeOFH1JQFmap+NT2M5wnaZ2ofa5OKiwGzut
         uyrg==
X-Forwarded-Encrypted: i=1; AJvYcCVYi9I3NwS7sR5VVhyHdIdFKW+OeTSayrhGjKE6vmbMA/R7BfPipLw1rLVwLxSsZutXl6LaNbH9DTOsdWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOmmmAdt0Pbty14oJJj65HN41X+F7OFPGZvYGTz7zTjeTDQ7L2
	O1ZKPz4UOyzFajcvc4x9So0KL8wXBYq1ES6Nw0AUi9eSIa+DspOzAuqJdcguid55w1tO8J0Rn8g
	ZH/h5UvQ1S1Hb0n9TR3qURsgXg24koyVVlueDmVfnqHv9LGlaj8qDoPeHY/bxDH1Ug4o=
X-Gm-Gg: ASbGnctFJr1MAlau+IjxBS+UMZRoMgWrIIwt+jtURQYU3RUeTrYNj4HT3KmhnQ2ClGP
	/A2oCu7+IogxeeiE7j6k7A9HJ4OgTjCQYOW/ATNXWbPbwMEcSfihG1COnP/q3BnH4wVd9jCiLc9
	3tNUVDgfLfjmZoagdiJAeWOGIUTb0nx1YUC+WW8Vez66akan+9KTM/XVzEuZu7qYGVvdtwCRNHP
	57sGQ/VSCkjCOcEolrwbAebkM2VQ0VuOPTCum+jKcim0Au7TccJuL5Db7qS02qPN/KhZX3QF/dO
	viaCZVezox1QKC7M8YV15+EVZ9W6Bo0tNm9aTrbZ399LiCJ+dXCAj804qoeSGDEQGPvzxoux0ZN
	fd2Ro4Eq5uK8PTmvp4sXBioaO4h7c8LYTBi74jphtEDCi5GUUgU7sYsa9zHwincKWZf8dAw==
X-Received: by 2002:a17:90b:3f10:b0:32d:17ce:49de with SMTP id 98e67ed59e1d1-33bcf85130bmr3076498a91.4.1760679833258;
        Thu, 16 Oct 2025 22:43:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkKGplr1e0FIgqAkn9VUk4CK1gCDjmZzv4MNeOLxFkbKA9yNA7SDpBEBqH4wd5+MQPSwf8Sw==
X-Received: by 2002:a17:90b:3f10:b0:32d:17ce:49de with SMTP id 98e67ed59e1d1-33bcf85130bmr3076461a91.4.1760679832877;
        Thu, 16 Oct 2025 22:43:52 -0700 (PDT)
Received: from [10.249.28.124] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bd7b3da16sm1465311a91.18.2025.10.16.22.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 22:43:52 -0700 (PDT)
Message-ID: <49032ce7-a954-49d2-ad73-305e154aeca6@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 13:43:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] media: qcom: iris: Add support for scale and
 improve format alignment
To: Bryan O'Donoghue <bod@kernel.org>, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com, abhinav.kumar@linux.dev,
        mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
References: <20251015092708.3703-1-wangao.wang@oss.qualcomm.com>
 <1pcfuFRPOvlbfcSRFpaPmuhVvjNGodlAA-7UuSbGcqo5JUEv5bhYSaVjnriJNG4fpngOAgeasXFZDGVWzX3ZOg==@protonmail.internalid>
 <20251015092708.3703-2-wangao.wang@oss.qualcomm.com>
 <a1edafeb-af41-4c96-8c39-a327528e0802@kernel.org>
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
In-Reply-To: <a1edafeb-af41-4c96-8c39-a327528e0802@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: s9Sk11kIAAST3Mm7Zq0R8tfV6A3_zNQn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX3t1amj10dBo4
 QRbWvb8b63s2o59ohe5RT+z9w+Lq4bYNbqt5MSGkvywxxVXHQn9N8t6lTBYdHdM6WQ1XZkEv/p5
 4LGCcNIY5Yg2Q7frVUO24ruXOLSoi1s4tF2F5SHHEOCfGZkffts6AfbZwohle/s4efXew7gftG8
 gW9sdykdWBmQ3kixG3GrB1KgKngEpMUl3tkAnR/S7XJX3Q8y9/nCaRLhPgo14UfToQAoEE+2PNX
 TmSXUNakk8weo/9GhF2jlmDuDZRNe15kRvpXjorTvy5axN+VLClEQ54EXNlJnb6rAeFWeiU5Eov
 5Krtva3wyKk7B9311FqRgYLy0g4ZEkEgkVlq88cJfT2c30Q06UWeD3xAY0LA2EuTCuZsEyc1t9i
 KcQutxQkcSVplRoSSyhUeUGnBnrb4Q==
X-Proofpoint-GUID: s9Sk11kIAAST3Mm7Zq0R8tfV6A3_zNQn
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68f1d79a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yaWMp7WbkpMwZxctSSYA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On 10/16/2025 12:00 AM, Bryan O'Donoghue wrote:
> 
> Generally a patch that contains and "and" could be split into two patches.
> 
> Please do that here.
> 
> - One patch for your alignment changes
> - One patch to support scaling
> 
> in whatever order is more logical.

Sure, will update in v2.
-- 
Best Regards,
Wangao


