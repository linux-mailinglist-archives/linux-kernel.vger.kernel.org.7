Return-Path: <linux-kernel+bounces-732331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC222B06533
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08251896938
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89FB26B769;
	Tue, 15 Jul 2025 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lm0sNmuS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF212272803
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600853; cv=none; b=pk9pCsho6epTjJYQOQ2Z4wamZK6XU3TIaSDOHPaYEY0bUSMQwJ2tr3M54D2fbGA1mLyHgg0504Qa+1MauFIk59YQ/7jfCAmJsR8G5mRZadtIs9TgBslmW0Myt/h/2Zq7vqlCeqX8iKE00JT/9sI0kbGXmWZm1+kGelzSna1tOrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600853; c=relaxed/simple;
	bh=nwBuJDFSMee362Y+5uNbcUsUqvmxAOxzANn+K8hlvdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8/bFf4LId6QlJYElsQmEklzhha3iqGnW/r/egxT5ljr8i7FF0uzf0saW1neZkICcxYRukRIwNTwG6mSI4mk/3sXwd2PwGoLy8F2ynfhZf6Nmud0EkamSMiljclZOCqSbpN4SuK0fM0d6HLA7VpiVSGKCndEXEqtvkdyPdqDDlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lm0sNmuS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDD8A007286
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JypJyhcFPpnntV0Fi6GrShtL
	07+iXRif1HlidBTcgdY=; b=lm0sNmuS2x+XCWmaFseLstBKv6hHjV2VnOcbQsqE
	m4vsZ6uFoBU1v6SIde6ad4NqjtsdfVYqG7BRZ7VdzDxvAonzBo5TuyHmiBa7AlK1
	e58hAlS4q3eEPhoEd3QPrRUjuhfLTGLz1asCgXsrZfsF/pgaF9MT0Ks1QoLxy4Rr
	Madhr/xqRmhRlWXq2NXMvrCvlo6L5WxcCMIKukJgJDE9UEYszhe0BnDYxVdmpeAH
	pMgry9I7roDBK+22QwQwUKD12rf6iYqHLnKcGl3+xCoHbLDMnXsHvv32BndIUsCF
	r3C4IjA5KZa7WAbFvSA7urg1/Ci41puF5ttNAML63GEGhA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh5s9vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:34:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e237c2f4ddso423266285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752600849; x=1753205649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JypJyhcFPpnntV0Fi6GrShtL07+iXRif1HlidBTcgdY=;
        b=CBNaGDuMelXmdmm1G6jmQ5JP3RHJRY72EqjVd/F9yl8tyULGu9BAYgiAVF8E2nDle/
         ufhNVdxiWJhye9SqKVg4R1aMBGINTglFGD49QAAU/gpZmZsRavzaFrOhRQkLtAJ5bgNJ
         Igr3lIl7kK2Qzg8L7mYH9npbaE2767AkG0sSjDVX4FrV+D6E6xzhsRl2m2+U1PTmKz41
         D7DypDLJDlH3UO2pPS+UErE3WNMIuijuulKZrp4YyCfnxzqskZ0PQHwGGdigtgpLKCqK
         dAemQk7bbiuPjCIo71mRwPnpdRHjHtXcis26JB0q2Njohep6bDYqbIvjd4amjTcrvmih
         mr8A==
X-Forwarded-Encrypted: i=1; AJvYcCW1VLH1fmc1LY5QTEu1xqHfJws/UdVJ+cSZzdhGaP/DuHDMPVts6IgUE3pJH8YQny+HBcDxTLphTPLS1BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCoNgoB8LeRR3+0Zh3PUdSj7rUpPtTNcB/2d3hSWFKcHwymLe0
	pfs0aRdK0OWJLGNDKZYXfMYPQKl+f4kHFl16oy88k7T3tySc912QZtDTEnzQ2/Qn2BXsre/5jwy
	hamws/AwRXDIczJGRNeAvoGj6R2S/rca1L4xpib+Jt1AJd2MbCyf/NWPZzV+J8hXIvh8=
X-Gm-Gg: ASbGncvzK68xrycEy8sDyXY0rmm/EIvRHjFLZrCYZiBqkVQgeH5mDtaM/8HlIsgHOYf
	0BRcy2XbFuNIiOwsaDcA2QCi5LIf1bnRjkMM+qapu8MMLb2YpoHZ/snjI5mrHxrT2KxPlsUxXae
	2qv3nkN/Hn9w0iNFUA5Jb83NfHg51xaD0BzY3r11o65bdBo+XzpSvhXaEgddUmzlxlfv8ifitTA
	4C5SW4A7OrwpgSQ04UmH5zOhZdgMsUCyKsuQcJMxXr+fhWBf4ocVqqCSt4PXQnj+VVptcqG8w52
	pYjgWQlRpoUkWf09Bq3VQlCS95J6PpalmXW0P6zs1E2pNsKN4UWm4kLOvJUgVqdzzNEZfBDywCn
	7UVt07McUF7K5JhQDkBe03o1iDPAxv2dqkAFbgEp7hVffarqIhhrG
X-Received: by 2002:a05:620a:8804:b0:7e3:2db6:1163 with SMTP id af79cd13be357-7e32db61251mr1076167285a.43.1752600849368;
        Tue, 15 Jul 2025 10:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL6kyp3qxt9/dJrs/jluSwSavkVrcfUF4Y8b4Wh9p7uPXySyslxIIgIxjH20UBXqn/LFCbcA==
X-Received: by 2002:a05:620a:8804:b0:7e3:2db6:1163 with SMTP id af79cd13be357-7e32db61251mr1076162885a.43.1752600848967;
        Tue, 15 Jul 2025 10:34:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bbd4asm2349248e87.2.2025.07.15.10.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 10:34:08 -0700 (PDT)
Date: Tue, 15 Jul 2025 20:34:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ling Xu <quic_lxu5@quicinc.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        quic_kuiw@quicinc.com, ekansh.gupta@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/5] misc: fastrpc: Remove kernel-side domain checks
 from capability ioctl
Message-ID: <u7djktpqezpscjjuvdwa45x77cnkkiis6wdvah7uhjonbi6r7m@cyjqsarrxegu>
References: <20250715085227.224661-1-quic_lxu5@quicinc.com>
 <20250715085227.224661-5-quic_lxu5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715085227.224661-5-quic_lxu5@quicinc.com>
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=68769112 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=yJLdw4DFOlQ0Sc0dKNYA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: norjj5CAxle6uahiig8Fj4k7WhKCFWNt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE2MCBTYWx0ZWRfXyXvwuJINTXSz
 NPqTjySA67Z/hBSergPACWkLg3DwkCF9+XpXLVHuFpLzdOPfGGfRGY6H5fVDB4GIxy2VcqHhw00
 RrlUcVC2Qt/qUBtiqGOyDPLD3bDgd7BI15vLjbNGlkWk8zYMDszOTzPuM6eA/YBKdKHqY8BpJYs
 U5PVhaUiU/FP4vZNh4is9I/yYEffaD7QrXIRDQbgd831N6pEindqTYC95iJHCzKo+5c5178vHrn
 GAHwTnKFQ0/mcLRduWESmiDaz7doeyeUV34r54jXncHVzGJlGoHdszrQBGR8W/ZSnAsOAjm7w6i
 SCRQ38Lmcky/XxEoEB4KWp9QQcfQbAGJC96IQQWaysiQM8b1EMXcjSPF/4d7a7nt/SX8UVTGm4x
 156RE88PrvGfLib06+Cr2zo5ZVL3H6xLl+ZJ0l2zNqtNHFOqZJ7Boyu4vnnc/Dwvmt3eKVL4
X-Proofpoint-ORIG-GUID: norjj5CAxle6uahiig8Fj4k7WhKCFWNt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=963 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150160

On Tue, Jul 15, 2025 at 02:22:26PM +0530, Ling Xu wrote:
> Now domain ids are added for domains, which is different from userspace.
> Remove checks and log messages related to 'domain' field in capability
> structure. Update UAPI to mark the field as unused.

The order should be opposite:
- Domain ID in the uAPI is misleading and should be ignored, drop it.
then
- As the domain ID is not visible to userspace, drop extra domain IDs
  and assign them to the DSP kind rather than DSP instance.

Otherwise you break uAPI first, then "fix" it in the next patch.

> 
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
>  drivers/misc/fastrpc.c      | 15 +--------------
>  include/uapi/misc/fastrpc.h |  2 +-
>  2 files changed, 2 insertions(+), 15 deletions(-)
> 

-- 
With best wishes
Dmitry

