Return-Path: <linux-kernel+bounces-850962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 600C7BD4CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82EC518A62B6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CE730B529;
	Mon, 13 Oct 2025 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V5BhJn+I"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1B330AD0F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370841; cv=none; b=erXsvs2H5XyZa5rgo//MesYolsXbkUe4kNEn2Xm6O+oPq+TLYXX2Z5c/f+LDBc8vE5EMDjjKtadwp/YYCYVaoa9el164uppHt4UGB41ouP3iKC/r6JuzxXyv28Dy92Pz0NmveDB1XMV//9mGbs6OyRRmgdaWQvkYIhegfX/F+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370841; c=relaxed/simple;
	bh=HbG2wBq+kzrvixdmpzlPy9Ug5SwqZucflfyMkiRs8FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjggnjVhenrW03l0jDcRAVgtx8oL65uaUn5pbiUXHGSgas5iSkHgH7uayRhuaRYajClDUwnL3iJ6qRg76CJ5qaeJJKNe7YCL4szRw6fBXptQtVgM+eYk8rIaeJJbsLRtYLF9/omGWeUVCWiVlqih8tSGv8lQIFLpWJMTvc2TItA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V5BhJn+I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DBAmhS021336
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FLZHcYaWOwdVaCOJVJU11rWTvsHsE26FRFeT3K+SBCc=; b=V5BhJn+IcxAdoGZO
	vNMBg7xnwOPwRSWa/Y7MG09KPu7GaFA7RrWJRJryoFu1scJdjkAN/jw7akLPAtx/
	3AGWaMDWpfAS0Q7ZupteR57odeTgprt/gdprB7wFyjEGE5IsVBvzBpJ8wBQRkc/U
	F59qdzVG9dhQoFPhPRU3dj66aX4zA67g3WyyTY8/lZTZDT8NMvBX1aB5GPonkr7Q
	xhm+yd1+8pJFjPe7EjkSKZSuOcYMsh0lN7amGKVeP6/8yEoVteSlqHSfZEKpMu2F
	qUZuSr0jZtSXV1KFMu7j6Is2fpGRRLVr26gsROYBzgm5CUIAt8YxvPreL7B7Emc+
	Rdxj/w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgh655xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:53:58 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78105c10afdso7228856b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760370838; x=1760975638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLZHcYaWOwdVaCOJVJU11rWTvsHsE26FRFeT3K+SBCc=;
        b=QwA6LPCT22TVRMtjcsbMvzgUdbBdUgj5QWyifd4OUsXB5Kd6bI89LfdD0NU6rqXOBG
         f10KdRkHQlmugyU+HDOnQ2ljzGCqhF7wGNzivPMpqwYK5IIvddNgC5dP9hRdmzu4OZjb
         m53J+QruvW73kUH+5JAUTAqjIk2LJFp8pVqnj7oButioo5zV+zvG1S5TXQmXiNv+T2gN
         d1iY5A11vk6QKCAitXSPrwW+Ln9X/3qZcuoxiXYANZS5Ac4H+M9izYK1MVNCVf758KYg
         kM75jJQE6738P5O0h1zJ2shQ/+Agb04xm9L68On3719uOR2BZaFaSusMuF9tGOIpbl4v
         CsYQ==
X-Gm-Message-State: AOJu0YzrobHOiEsdfXOOxwxQgNVwlIZ3tjilgBNT6VbZLeZp36N9+j/c
	XuJpml9pJP/yasLMdv0Ghl5CSwbuoCPH4GQLeW/YyffasDYgEeTUPDmMDG362ROUcmNZSIq395k
	2LyWrce6AQPt+5WmKdkQnDNmvMCKCcChQrOFTiqJPFFrMtxmk4QlAxBlp8tY1Gex+mZk=
X-Gm-Gg: ASbGncuiArerqR1pGpXcQdEa+qRTxjJNBiTTB51h2YqB8TkGOcgrbfxjlKmayTHsdqU
	rqpA2NPkiiaJr8eJwThD8eSFmUDUbP7RZwgXENn6dXEt/GdMT9cFVCOYPw5NtHhb//ZL3SwSaRO
	CFvxkCjGxxKojVMOSEU+9FVEkvafbwTIBFrasveEbgZHdS4va/z0wXWY0Zo+1SlQmQmvgJQwOEj
	25hG6F9z1v8MP9PZ6ioF7G9ooJVbFu6bMvfZygqWjjo1D1hi8XtEboAb8QTyWc2zRJrSuVAdJQF
	wch/MkGxMpOmiQncjRtRw8gHuGx2rktD+FiIZhrgu4cAJmW8FTxJeyLK/gqhljuCL/EtE91eFLq
	U9Xm1KoBc9+LMqoKNsPdseTxs
X-Received: by 2002:a05:6a00:2444:b0:781:1cc0:d0ce with SMTP id d2e1a72fcca58-7938705204dmr23432410b3a.16.1760370837991;
        Mon, 13 Oct 2025 08:53:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfBsZAhL7dFU0TP/OXXaf1VQDK54KxbV2/t0a9unz8l+QOuLf/jfMSlOxH/EZT6mdYvOQe4w==
X-Received: by 2002:a05:6a00:2444:b0:781:1cc0:d0ce with SMTP id d2e1a72fcca58-7938705204dmr23432387b3a.16.1760370837543;
        Mon, 13 Oct 2025 08:53:57 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060b59sm12346851b3a.2.2025.10.13.08.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:53:57 -0700 (PDT)
Message-ID: <2e90f3ca-0752-4594-be92-094d4f251187@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 08:53:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: wcn36xx: Add linux-wireless list
To: linux@treblig.org, loic.poulain@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <20251010235735.350638-1-linux@treblig.org>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20251010235735.350638-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H/zWAuYi c=1 sm=1 tr=0 ts=68ed2096 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=3WJfbomfAAAA:8 a=VwQbUJbxAAAA:8
 a=zbSwXIVSrdAPPfZg_F0A:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=1cNuO-ABBywtgFSQhe9S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNiBTYWx0ZWRfX/Ooi7zZzYkmR
 nF0pep6EGqfdaIKT/1QdvcKvO+OjyhJ1hvzXFFVW4mu5fNstW3ZZqDz+CU/Zd0l2J5jjcQbfGrT
 BORg1S/cx1KHG0RC1iUe2/d3TWoScAL1O6nnxLwmmU5xn7CMpc1oqkt5X1f5jv6SK9tqhszRilJ
 1RNK5qnzWgkCrJwnaQugn4k/VzgGmK+7mEiiu2Lc+06+DK1FqiDdqMqF+WngpgySJYowHFJu8EU
 fEm4q7f3m3SjgKw1rtaRjSA65cAeyzcpTZ/Ub6m5zedq88uhdKvN0SeA6Bp3niyYwXWdWf9909e
 mIj1P3KSJDRRAIeqJTjIA2FqH+4kGjTnsTJtOUiQjrr4RYA1xMZUOwxisq4LH78EYsNJd1GbHWk
 Ew+R6zSDLm5+pK87434dth5XaHLxsw==
X-Proofpoint-ORIG-GUID: llVpGW9RdEe00er-jx98DDkItLdNLvAL
X-Proofpoint-GUID: llVpGW9RdEe00er-jx98DDkItLdNLvAL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110026

On 10/10/2025 4:57 PM, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The wcn36xx is a wireless device but doesn't have the wireless
> list in its MAINTAINERS entry.
> Add it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Jeff Johnson <jjohnson@kernel.org>

Johannes, can you take this through wireless to get into -rc2?
Currently wcn36xx patches are not getting into patchwork.

/jeff

