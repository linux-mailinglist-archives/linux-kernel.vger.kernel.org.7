Return-Path: <linux-kernel+bounces-827414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CB0B91B55
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55412173E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E0D245005;
	Mon, 22 Sep 2025 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EEqJ3DlJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA3F213E9F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551252; cv=none; b=HVptykg53bPGqWWYWOSmVFebbyW3WyHIkn1XmwaiY71swAJJmmPYuAZovbkPWjTLyCcak99WRcl04HgD7aZ8OTgKcFINywKaHTYgwpAeSZaZNBhGr2QCvzS69bdLjp6nxJ0cgzoE405Vs2x0isQoj3XYc1eGClC+9GxOYwyRwXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551252; c=relaxed/simple;
	bh=p+DYY/6fj+Fdp+4xx5oswz4SUhx09sEWuzlwt6GtrJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvGiGKl0B/tOadcq7iHVwm8JiWiXfIv4jQT6aLCf8WN2CLNhrSSTDtN7NrT+AuFbVXpvUf7MA6Rp0/DAv69sCUg0p6RQRxZbWi8GGx0NROkmrJvV0jlYTg3j9jiq5RL3lYrHxr0d2kxgVZUKvch359vm3mj9UmVQsz8OgRpuUSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EEqJ3DlJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8vCCj010120
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fV5JuK1sD/lvBGjG3DhYlCxsRUd3KN7L4n0TphxwgvQ=; b=EEqJ3DlJuMsljbE1
	YLXjX47wCX+El+d/HSKQxOLSkPOYRuaqpzvOuVz8mRWZ+RLpgJZQJFOqlBuPfU2X
	5dRIrbwPztFlDC0cJJblgahYbpL5n4g4mCF7xOKmSTafjbUf55ZSCM7yCzvqJYan
	FweKwrJv1fUeiKmebEfrV5lw9jqcuYG97xIASa3qqJPv9AxzvFPbOr+8WbWCg8C/
	Pvyg5ctx7HPBexcWxI7BAeVzWVUZHDOucn31MtUvylLAfeRGK8pfDkuKJAdVjsfC
	ptudtJD4/oXnGG+V3WAd0HBrrIFqfMI9KXU6LOj78RwbYhnJeo7xXmrx4zFRqz23
	/ea1WQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnnakf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:27:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-277f0ea6fc6so25149105ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551247; x=1759156047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fV5JuK1sD/lvBGjG3DhYlCxsRUd3KN7L4n0TphxwgvQ=;
        b=U6jV3IRMN52NZvMbPXeCYM8fj0D3P4qbVzqT7PRvxeYqrjQu9U0Qp+ol1Nf2F/Sw2a
         KSt+xcYojS1OjP+68prtSQkVk4VfXLt/V8nBXEyOMuJmn/zK1jUzkY0iHFesM7CQTH4H
         bYOxsEwqAKFX3bMsuCSvUgwTSfDaDGXONrbg6PTaK2eRl37JoPR0H2E0UvFSUWc5iqZG
         ahyP0ufc7w/NUw0LJ8wtt70c8myNf+QbDJYynT+jFyNyAG57gUN865OZNtwv0GmiR6FI
         shlaW7QkjR00llQjDuZuu3z6LrTM87NPoETLqE4MM7mgzQYmCR/zrd/7vJEgqmF5DVJA
         n/PA==
X-Forwarded-Encrypted: i=1; AJvYcCXxyXgwPt2Hx5++coG9aYxiIfHErTfmQDzRPnKwEsJ5AKtuLGHCE/ZM+TLPfAqX5pzIUtiv4IoZrYbmfGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdpXM4MKVD2bQlCK3VQ3btiFSDg6q4eWh7O2NgqJ9fGaWNEpS4
	rpJtG+mfYgCpNS7OM82ev6ogr3d++zU+trc/AeTgHD6x/aRV1daTb2tdozNPpJyZbI7fnf7vW2c
	LT00PwW3+8BMgWqQ6g1U1RF0gzzcRrGB3OxCPcKC/aPGZNlzU1C1PtxzfJyLEk64XL8g=
X-Gm-Gg: ASbGncsgUX7aOPyXtnHv2ZrPX44x5KU8nA98DWpZw49Gl7YEDtLqvyLikuTD/lbrAgH
	OynctOaxVjoyp3X20a75IzDLcnlrsZfmr5zqav7wy1mXLP9pKpI8/tM3EEnzLjhA+omY+XPext2
	Dn9ZXo3nmjui56twQscvZLZLdrv2zpzekyfuSv3cOLYgEkIkaFwGfn5/vEZJr0DPojqk1D96x6e
	ol11FkEhens2PA466DxNkP5cKpqOqom8d+kOLPhB52eeyTJJMNx9wghuxJGsakB5pG0AUoTfwZ1
	wV0A9d25ay4rVji59FfLtjtHo9CgiBJ6ZnMfx5LR22maRbw5xWnoiKwDBEwwLhA5RycK4x07GvT
	BfnzifEQ86/lCPow=
X-Received: by 2002:a17:902:e550:b0:272:2bf1:6a21 with SMTP id d9443c01a7336-2722bf16e99mr115069855ad.14.1758551247077;
        Mon, 22 Sep 2025 07:27:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnurI6wavqww/i4EDVMJujj3eWajrXl8/5g/qerXs7rQNtYufXniembA5tMmTfhGRq5eJXgg==
X-Received: by 2002:a17:902:e550:b0:272:2bf1:6a21 with SMTP id d9443c01a7336-2722bf16e99mr115069495ad.14.1758551246652;
        Mon, 22 Sep 2025 07:27:26 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.98.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053248sm135186355ad.15.2025.09.22.07.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 07:27:26 -0700 (PDT)
Message-ID: <2b16c982-90b5-0eb5-df93-465a8c2f4d60@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 19:57:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath12k: enforce CPU endian format for all QMI data
Content-Language: en-US
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250922061607.11543-1-alexander.wilhelm@westermo.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250922061607.11543-1-alexander.wilhelm@westermo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d15cd0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=jURWspusQOjhl1xubyy6/g==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=N9GNhs4bAAAA:8 a=EUspDBNiAAAA:8
 a=iy7eNMHqqS-0pUZEvd4A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-ORIG-GUID: UZCcAbtteWEGKL3ILOvFaF1TyWFuGC10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX3PV9xhtnCgOF
 /TzzG8v7KZ5TWPCtNyV4dVXrc9i19TmulkKD1cAJ/ujhUEEn6G3OSk+2Sv7NAuoxNajj8zYzgnf
 u0cJmrj3ll0N9zxWX58bg3O5FOwUZLJVNGdo62gmpeam+czOWF+yDcxmTnH53iU7EKNc5z6D+aw
 iGnpFm2NTMOKFeSxoJbmqp37LJV3Tf+4C/SCt2a/TppIVI9pjEFzPwHSnCVR8/rHMuAtoIl79Ij
 4l6Xp218Z35kzG5LTynZusXCXkakEiaOkCj7o+jIu1b1/scBiK79++3B8M9vgHcjMd7dGEBPMKH
 au5JPr3iPc/4PUuvPphlgmpb/pb/cyDksS1dXrXyUkvjLMMnPYw93zEBFmLX1462vX2G9dyhm7M
 g73RrXu4
X-Proofpoint-GUID: UZCcAbtteWEGKL3ILOvFaF1TyWFuGC10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000



On 9/22/2025 11:46 AM, Alexander Wilhelm wrote:
> Currently, the QMI interface only works on little endian systems due to how
> it encodes and decodes data. Most QMI related data structures do not use
> endian specific types and are already defined in CPU native order. The
> ath12k specific QMI structs are an exception: they use partially endian
> specific types, which prevents the QMI interface from being extended to
> support big endian systems.
> 
> Update the two affected ath12k QMI structs to use CPU order types instead.
> This is required because the QMI interface is being extended to support big
> endian system, and that support depends on QMI data structures being
> defined in CPU native order.
> 
> This change:
> * preserves compatibility with existing kernels, which only support little
>    endian system
> * enables future support for big endian systems
> * aligns ath12k QMI handling with the general QMI design
> 
> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

