Return-Path: <linux-kernel+bounces-762375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD252B205BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63BD53B0C86
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2A223E25B;
	Mon, 11 Aug 2025 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lqLnyDLa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DA51F418D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908600; cv=none; b=GkK1f3h8v8JpA5owVUliYJtdoqQ9YiSZ54bOsVtl0CFaBMtRdSvV0u6+YJB50kwarhH82vzJ8vUTD7FPg1sXi0zF1Zhc2GzxPN19GG1PU0Kz51a98oD2LgrEY+BY8Vi6W/YoxjR8VfWRgQCduQLKp/CtDZsUY6suxRXiUdJZ6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908600; c=relaxed/simple;
	bh=wsPL+6gIeIwozdGOg2zkCWC1N7aKS9aXDDnDAwnCyWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQJvXZpoBEcgb5SQ+kwkIIL3fLZqqM/gkOCE3JEnKems9TkGgPQAVDXiGxS6RtaxjiYfDnGV12sJZVoQpki2VXA17F5WDnAeECUgLCp0k3vcjhFQDnshuS0G0Cjp5DmSvvc9D3tr6TRtIfJSd+8zLfP5G+YZMSQyrQN90ilGG6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lqLnyDLa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dHDv005228
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SXMlWa5HL3QmwtlgJpH4Z3z739VIBK+LB8Zp4WNnwz4=; b=lqLnyDLaYQjLcnWe
	FyypZAxHsbY4Q+RIXBSk08vROgb/WoJJDdDYYBKV+dTXu15FHAOeG42gyO3EeRef
	LG1VDqLoyW9+8XY7J5WcpnLgA3VuKkNEFT59RbLxyB9jr+jiQCYpeX5bAMQkfuli
	5dxDBeKzSKOwut4SYvw9UC6K20AeEezUJz24KnnrDQDvS2t97Tfp445Yljp7vv4S
	MDNySFQXeij4UBGKwgCpJ9yptJdl2jigB5kEe+7dUsvDKdZDdN+eYPx8GhXGs4wz
	d4A1V1MKL20NR2VuKmGIskYLCX5w7C4cUtNc/Jn3qcPvGVckxPXEmeN/LaxSyDjs
	dYzR6w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx28ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:36:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e854f77629so5434285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908594; x=1755513394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXMlWa5HL3QmwtlgJpH4Z3z739VIBK+LB8Zp4WNnwz4=;
        b=sBxfWTamXa37lzIG1s9PIaRd9haPuZp5rzBiUumIZ0Vo/0LJb5VniohqpYDPfV2qD4
         l708w0AiEbz56QQMP4GlmNEX4UPGH0ymQ0qYGhxcbuIzzwJITQmAA/W+ZsJVn4nM04ZX
         Ijl+omZa4L7qJYmezBFECv4YphP24VdmtvLNvnu3MetQOhyorHGdKKS9IIJ77N2tFZqK
         TdmOsiKNKyhhl7KGSEnxjfDjRU9pLSwYiLweZrTfEIVWGmTqpdEgKeRTY07aFyuFIuNE
         wstKgQD7UKFzOBMmcLTf3ZmcS2eoU2yPXgEgjWvr83gpma1y6A9VNwnK9JaIHGr46hK3
         d/dA==
X-Forwarded-Encrypted: i=1; AJvYcCUkM1GHuXKkWdwISQOCwwmviwp15Sc1llc3YJBJjhrUPQosytlyLGf8+9+oj0+jH6NlzAfZPNp6KfTDuFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1iHi41Iahb9019U5Ybkh82x7TYlxynY/pRRCF+RLjGHUeO6XZ
	kezfznr5rtWbTuZ7vstm71tV3T/WknA+bGlZtUs8YjAxHwvDt9qa78z94Z1hzKlj6M7PKp97Aq5
	uhuggHBSO6jAKDoo7gLErBwEvh/rySugZgKuew4/cKKeuQeLdtAOfYk7re95w7dJOiyw=
X-Gm-Gg: ASbGncvlyw1P72UhETSVA+EJg0YIFSlbDlp76yFLdvc9qroS55MZyhs8PNcV7GGzV76
	ynjR2hhj8tlKbLWgr8DOoKFt4jJfIbgojcZD633KEf9TqPBgWluDE2pdhVtMMA8kSaXuu5QsyeP
	5gKBXWaQ8uACodev5YA6y9xOdyDxjU+yNqhcLSf7GIpkrxj1rH6W7B8BniqRJXqXpqyCFQu1l8/
	m1acDbnSOjAN+K/Poe7aCXdmG5C4trY/ZcWKmldgG53M5l68RAFaOPek5N5Ev5DsGT5E2ZACKtC
	b1oIxVhPWda9ILGvp9/hyqE1RCvn+Rj0co4mDBR65d4rhhkPsDMxnYtbd0BMk+3EgZpkZaLRlJI
	7b0ER3D3KOgckNtU2HQ==
X-Received: by 2002:a05:622a:52:b0:472:1d00:1fc3 with SMTP id d75a77b69052e-4b0becffb44mr51535771cf.8.1754908593888;
        Mon, 11 Aug 2025 03:36:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEofb0nG3bNmj1Nbdu+0B+tsQeV+xQK2a0YZ0/dVDJLm8BgaWfm52BhC7cv0p80m5kMtNIO5A==
X-Received: by 2002:a05:622a:52:b0:472:1d00:1fc3 with SMTP id d75a77b69052e-4b0becffb44mr51535581cf.8.1754908593423;
        Mon, 11 Aug 2025 03:36:33 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af985e63730sm1174315166b.67.2025.08.11.03.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:36:32 -0700 (PDT)
Message-ID: <388af03e-a9b8-47dd-876d-104d9c549957@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 12:36:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: nand: qpic_common: use {cmd,data}_sgl_nitems for
 sg_init_table()
To: Gabor Juhos <j4g8y7@gmail.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250811-qpic_common-sgl-nitems-v1-1-a71b5ece54ab@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250811-qpic_common-sgl-nitems-v1-1-a71b5ece54ab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX9X7Z6wcRTdk+
 igm/06lnLS4BdsOsCfdXGybRs/qo29yK90/6stNnM/7lTq2Zk+zY2kg2D7uG/0gNK2aEh7zes1x
 l8tlRhsf4SD3A7dygXM+HCojccVI7rWbZ8gl4aFTwJwysVUTgNYcjyvk5qX3L57cZEnlClp5sFc
 lIDHPtZTi5L8G/gNCU/7KNTNydU8PFAsd6BQzxiYSGSmH9Hgu8DNT7qhK1046gMhZH+pUf3ab2x
 aL0RrdbHbbvX4VD+QBd5BqCuOxdfoniFUX00UHWm3UhfoxNKMk93uFbKb8ZtnWeiDPr3IzIV549
 mK2ed48hWq4PumBzYVDKRIKz7u7A/zJohtnZXCwXhiHQEQGh8S6mnKF4RDJQWjNSLffMYBVrp97
 AIOUDICw
X-Proofpoint-GUID: VJTODUeGjMtGaKj9pPEvACnmn61UiEDs
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=6899c7b2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=3CxiO8553sRBInyl-lUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: VJTODUeGjMtGaKj9pPEvACnmn61UiEDs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

On 8/11/25 10:30 AM, Gabor Juhos wrote:
> Since commit ddaad4ad774d ("mtd: nand: qpic_common: prevent out of
> bounds access of BAM arrays"), the {cmd,data}_sgl_nitems members in
> the 'bam_transaction' structure are containing the number of elements
> in the cmd/data scatter-gather lists.
> 
> Change the qcom_clear_bam_transaction() function to use these numbers
> while reinitializing the sg lists instead of recomputing the number of
> elements to make it less error prone.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

