Return-Path: <linux-kernel+bounces-762107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EBBB20239
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E69D189F8E3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E12DC348;
	Mon, 11 Aug 2025 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QTcq147/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B9C2DA77F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902232; cv=none; b=udrcsEQy/EXElnC3T2RVr7MRe+aE3EokgZyOJbTeTl5L6ejT23OaxmNuPUfMZZSl2Uz/6a38SlWXL6fpoNEMnhcsytnOYXg6nf/FT7M6fmoPtqFDTyb8++MPeZW4/ujAXANQXHFeXyiH31H7bitwCVgpIUxvfWeX130pJsO28VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902232; c=relaxed/simple;
	bh=CPGYrDDgQzIYUKiy0aUthSOA854YrLJiY4efajvuJCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bwe4QzN7Xn2VW/ZudLubNcLcWXGLz0by91thFAZtjR89VtKx3tS05VQv+wi+U6S6MnBgWI0USTeTYv1ehAX9JSTbznbvOh9y9fwbTIdnvE1TorwqgxuiupPu9xm8Apn9M013FcCIjgZ3S/9C5ppk9J9XPmapEdNA82TIACg5UwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QTcq147/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ANqrxu004213
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CORAd2r8QfE5VI6wSh8ExS3y5u32gjUiHVIBXtOTHh0=; b=QTcq147/b9gOi54Z
	MsLQigOnChXxV4MT8/Vp7U3F/gzGF0mARNbqo4TOEvFFpWzEFX/x9tA6Zig0Ah3a
	nZ4q+4G6/5DNTBG2qYY615/5wAQ/2LAKl4+BESCUTzgOEE+QvH6ZgPDKaaUYVUyS
	5GH4s8krsaGl8NdmNIrXbpDNaQCxHvb5mzjWlEwX2SDyBVanR+Pua80YD04ivzlw
	jSllyohKLQmoiF8DOAIXF18iKiMEwU6m3oNcGUvcPqatsrv0GHO32ajVIJMm2epy
	J/QxiHIV8OjJmV25BjxZuaE3UG3CPMjN5jdvM1msmPepTagC7EOQafQnm/vDvLTQ
	mepANw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dv1fkwk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:50:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b08f6edcedso12236991cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 01:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902228; x=1755507028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CORAd2r8QfE5VI6wSh8ExS3y5u32gjUiHVIBXtOTHh0=;
        b=nFFoTL0Kca3ZF14sGUn+BZG3ovNRrNeWdA1i1dZ1dBjjnVLTFE3WnOnqoz1REjKZD/
         sOOVMzR+hc1yrYoNJgvYfULzMcCfOkSrgJg7IW4AKU3k9Y1qH6K9uJwyFz2Qzxq+kcjN
         Bw9YihLInQxINQdvA/FazISYdRYmh4mQgovOj09B+UCCWzd+8pGdl+0DnurZD+dnYzJr
         Ie+aBL/5vTgS3qbSUXGHAPR4NwF495nrdU4Y9WfB54yIwwXHS3Q5+DrTo6Sv72cC1mmk
         wwIjyoQ0IPj72QFCWJVJD/SvIdUZY8va3wreW13FsNJs74I05MKsjZYa/+9rhp3g6Umn
         Ja4g==
X-Forwarded-Encrypted: i=1; AJvYcCUVUjsA6U29p4V5oGhV6QBcPXXvrUd1JU1erAgXLEQyCjxw+IJIltgnH4wvnDkzlShPGprUdENRFjeXsLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxatbaYQexL4eZKf981X3HubVcwaBjxpVEsoCbMMJ2cEtSJl8ao
	3WBSbGtFBS/gWQy6mLesTNQq+fcq4+NtPOjXUligjLQqeUBhCzKq0S8JYjY83Vh77GCwTO5gwZ5
	OcmZsoqK841IB31dPVdPN4xJ58im5Tqw3QcE3RYi/yuHOti5Fd33SFYcAZ1XyyzAhOsQ=
X-Gm-Gg: ASbGnctPCbcFjudEDGSWPFyRip2/qx9jIvHrj+xBMacOKDxTQxU5TxAj1FWMRiMnZ9Q
	Ir3Ld6b9sOHH5BHrjSZDISe836K3OiOkXU9GvRTCHFb99tFdy+F1TWH21rm20mDPJIexYPZotMa
	12TDE0cNDLPky5ixz46sgo5wHlplWwfg7GrgsQGfqr6i+E9JI5rfOTuoAHVBi+VfprHSNBJExpu
	mEO36KO1S+B0B9W4R5prv3w0edvf8lHh28TopZ+Pso76Z4gYiTv2/z7xEiT8nRiuqFf372sm1WS
	ITkNn0Z+gx7I0QIM0U7KuqPRxF/X3bsoMbADVWWm71uEPyDX/VvpkpZc8yevp61+rKdKboJD332
	lwVv9sIBUpaDjh8kTVw==
X-Received: by 2002:a05:622a:1ba1:b0:4ae:dc5b:5fee with SMTP id d75a77b69052e-4b0beb027a8mr52893961cf.0.1754902228381;
        Mon, 11 Aug 2025 01:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2gL+G3g1eE6R8szJqv85HPPf+VErr9fLPtt2IIDrlbNUHP7zeIYNUyGibJo//rQDUPs1VWw==
X-Received: by 2002:a05:622a:1ba1:b0:4ae:dc5b:5fee with SMTP id d75a77b69052e-4b0beb027a8mr52893851cf.0.1754902227923;
        Mon, 11 Aug 2025 01:50:27 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e820asm1977227066b.90.2025.08.11.01.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 01:50:27 -0700 (PDT)
Message-ID: <cc24ea01-549d-43df-a3d0-62f60c79d5f6@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 10:50:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: spi-qpic-snand: remove unused 'dev' member of
 struct 'qpic_ecc'
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250810-qpic-snand-qpic_ecc-cleanup-v1-0-33a6b2bcbc67@gmail.com>
 <20250810-qpic-snand-qpic_ecc-cleanup-v1-1-33a6b2bcbc67@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250810-qpic-snand-qpic_ecc-cleanup-v1-1-33a6b2bcbc67@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OgSpSuewqpHaf3P1ER4JMDCfbwY2_LND
X-Authority-Analysis: v=2.4 cv=cLTgskeN c=1 sm=1 tr=0 ts=6899aed5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=rbI749AxHwL34t2NiqoA:9 a=QEXdDO2ut3YA:10 a=bDEiuqbIbRIA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMyBTYWx0ZWRfX6uiDJLPYWFKy
 VPsbdjuRX0lZwW2u/9CtxC9tqdmXe84zW7Pyh/NCFYZBIhOdGIe1wBGNZSR7mFZT04y6KGW354x
 XQtuepVPr8FSNipWegmXE46t1Zw0djNcD5VdJWDSG2H8YLrPZSfG9cbHeASVjYvjWeiDSjHoulX
 gb7uljLRY8MdBBQZ9hc2eoBEc7TsFRNutukKzU+ZdPhreKwUtFAKkuvSCEbYmVw0ul2YUFjvu+V
 /twYi1RfpZuRE6YPuOfm0EqKuVObgSl8CHY298q3ZPnZb7+lyAt83Cinq2GBBHUVhbk2aoZysmV
 YI90NGQizQqZwHteoYCAqIYghXZKIi4ebJXn+dEnrEz9izYHiw3qWWvIqPmiUJIDOqkkn+oL7eA
 wokl9ueY
X-Proofpoint-ORIG-GUID: OgSpSuewqpHaf3P1ER4JMDCfbwY2_LND
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090003

On 8/10/25 4:38 PM, Gabor Juhos wrote:
> The 'dev' member of the 'qpic_ecc' structure is never used in the
> code so remove that.
> 
> No functional changes.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

