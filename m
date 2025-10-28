Return-Path: <linux-kernel+bounces-873652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0695C14599
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68D384FAC2A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B176307AF2;
	Tue, 28 Oct 2025 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DCdJFf4g"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FEA3074BA
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650816; cv=none; b=W4qxfloIgSnARLv+UXcHo6G9+f6xikbw5NruxeWjMUsAi8OGVhbpglMbegKAhwQxH1PCgUesrqPPI+MLKhMj1sQ25+b/w4vCCIDnO3GM5TWnwK59t2yc1Yvd/0sC6MSxwKKxe3B4EZNe5SsdCalzCOJtYaJq1up3yKpgEEZd6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650816; c=relaxed/simple;
	bh=fBufmoiCsGgn84g8PYJQQN0ig+1uXDDqG60gqXk1NoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ab2OsRbAakK17fkBLVky+DkmWvr2qYZBsYdRXlpEl7da5VR2QGFfuGkZ3eKlwxy8oqhKFHg7YqjLNT6U3SaYA5b3F8GyAioJE4bukBak4eM4lX7lt2yWl1Z0raCBJEnviW0IBc3L1aIn5ylHKtXOxn7owPrJA5XAYIYbH7i8WgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DCdJFf4g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SATgMU3166319
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CxtEXxyjpblH1VkRqNJLlrUhubXxvJIKK5oYF03s0To=; b=DCdJFf4gvZ517ofF
	nGY8WnAseGDEFBoaLpyMtbN8khAuIFnGBNuJ7YoOCdjHGQAFMKdLHtyjCXv9naVc
	G4Qn/fMz156ukvgkfGVX9XK9Lx2lozqLOrTmTfBIfV8nxYX9Mae4x7U6PjZMVy9J
	fo47om5K9W3tNzidex0+VYvMP6ml9ifgOoElcsB395PbmQHUwFYP6TZ8PeZEZv47
	75MzaeR1z3fnrZOdTJ6GeGh2LJ1NKQhThdBGSP2a0gzfI5WfgwCCi5B7pCTZE+Ey
	GX3fVQUfu/6NUNv2gtIT3kJMHbxrZQ/EJ46YPVTZVROuS/9dlHW4pYDEKbAkwol8
	9/AkDA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2bwx31vv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:26:53 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-798920399a6so5847757b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761650813; x=1762255613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxtEXxyjpblH1VkRqNJLlrUhubXxvJIKK5oYF03s0To=;
        b=wXmjp4KYl9vPaJLDkwDtwLge3A8suf6zWP5Pu/BOFasnoq7dcgCoT0GJHNvpFdqqea
         O777FI3DHNFcRubVnxeeWJr+QjwgwSPpCWSxUc2uHvQ/eStXvoHOlxhWJSSUa6KPSFv1
         iVja1ZoRPf3JbVOAppVUUhesYKeBaiJkcVLlVX/EeF/oBs58dXoI8g3u4xlik8Bi5wyF
         KKnrKDkjifuctfeSqLWA8+STLz4S0IPeuqzPq35zcRCzFXlLPNLIxUI6N7MS+oh096iQ
         xC9ooU9cv6EaWMmGVTBJW8cmN0pU1kWmedpHGAnaacR0/4h0oKy1OiWsPi//HXrVb6G2
         FhMA==
X-Forwarded-Encrypted: i=1; AJvYcCUs34IG9qN9XbFm2z8uLCpmDVqRQc/6J4ujGKRo3zIOTwbQuuixgDSHNxGcQRcy6x6D+DXoBnGYXV1qr54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuu00cA9cUotovBHNNJ2ih9Y7IqX7vzXnI5OTlkcbhvnHP8BKG
	tV1p9XpvRrgNgYP7acLxnzWeGz1tjPFj8ZRKmr+nYII9zLXprMwSzZ2gPiRAKhz3pz03OBgVx/j
	L4mVx5BMEhoynZuUN8o6HMWB3yEMjOcewKmP68uzRn4n42GeLpHngLPUref/ku5aj+jE=
X-Gm-Gg: ASbGncsrR76zu5j/dTIZYsh52AiJap9tWfqrEmjg92htBt0nLAlZQxJ7b3K8wPwC/gt
	nFUAq5PRNR8zbxBzNTm0STRerPc4P9D6v545twU/MA3Y2yagfFnwv2bMb3HxX8FQP105WtWNCfI
	MeEmxOf8X03ebRAAIbzeb8ZNzY9F+dA21u4bPuJKvwJv56lZDY+uxZ/Q3Bq29Mg6MT0u/ijVSdr
	57Y8UXAVCCshnAHo94X9+IkZlBXAl2red8eMGsI5H6bu7DyEUYq/+66tk0I903D+ShYnmdFccjm
	P/T72ttWyDZ5vsw6QYUR2Pbc+Vb50oxWR9pkcQpRmibGLp0j+QORqkO61BdGcuzUojnUpnFP3v4
	SB4VU0EPu1nvbCG44Qzk7BFDSgJRZTA7x
X-Received: by 2002:a05:6a20:6a05:b0:343:5465:bb99 with SMTP id adf61e73a8af0-344ddcd8a01mr3908426637.6.1761650812680;
        Tue, 28 Oct 2025 04:26:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGq8RNQDq78SryaeLfUbPZNmMQJGMYafxHnDpHHZnEWn3AO6zvI3CRYSi3qIUs5L7z7X2/ng==
X-Received: by 2002:a05:6a20:6a05:b0:343:5465:bb99 with SMTP id adf61e73a8af0-344ddcd8a01mr3908389637.6.1761650812224;
        Tue, 28 Oct 2025 04:26:52 -0700 (PDT)
Received: from [10.204.100.217] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340299e6fe2sm1297385a91.0.2025.10.28.04.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:26:51 -0700 (PDT)
Message-ID: <ef879fc3-b437-919b-7ba7-d67671cacd77@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 16:56:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/3] media: iris: Add support for QC08C format for
 encoder
Content-Language: en-US
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251008-video-iris-ubwc-enable-v2-0-478ba2d96427@oss.qualcomm.com>
 <20251008-video-iris-ubwc-enable-v2-3-478ba2d96427@oss.qualcomm.com>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251008-video-iris-ubwc-enable-v2-3-478ba2d96427@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA5NiBTYWx0ZWRfX3SQ2OSTzTo7i
 uaQwTIG7cmByR86yi6wBiqBXMfNcny6kxRAyLuwVhfO1VhF46o8hP2KRkDMx3QUxEeWU7DSj/bk
 fw3RligMxc+kp1cWpEX1EDUZnbv2YMo+0ko2TUERQ5N8ZNi7IS/9EeH2gvu+fSnwCTIbAHp3zYq
 LrimKj5eUPJ9l5moKEwS5xvALY+pFUhAmb9vD2hlVAEQbj74CPgkkuTUqaFvvSuqma7tUYXKp+d
 DGnKOIW4HRpAh36HXvgEB+ti7sZbf7QX3Av8gvcUt66Zpdm2uhEzafkY8npzsczsnv5Mp4vYTU6
 P1tsWzIXSlPodgkkPEolUWcFx7Ihp2w5N49tqCqDnvTA06Ruh3/l0fSNwIK1fJi3aMeI3SVSGw9
 uAqMASKnBFtUzK3wBFsUtty3dBM2zQ==
X-Proofpoint-ORIG-GUID: AqwYgWGeoZBflCK7VdL1xPoXEsii7DTF
X-Authority-Analysis: v=2.4 cv=U9WfzOru c=1 sm=1 tr=0 ts=6900a87d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=tQ2HcwaAKAc4KCduFuEA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: AqwYgWGeoZBflCK7VdL1xPoXEsii7DTF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280096


On 10/8/2025 3:22 PM, Dikshita Agarwal wrote:
> Introduce handling for the QC08C format in the encoder. QC08C
> format is NV12 with UBWC compression. Update format checks and
> configuration to enable encoding to QC08C streams.
> 
> Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_buffer.c     | 12 ++++-
>  .../platform/qcom/iris/iris_hfi_gen1_command.c     |  3 +-
>  .../platform/qcom/iris/iris_hfi_gen2_command.c     |  3 +-
>  drivers/media/platform/qcom/iris/iris_venc.c       | 59 ++++++++++++++++++----
>  4 files changed, 63 insertions(+), 14 deletions(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

