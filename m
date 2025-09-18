Return-Path: <linux-kernel+bounces-822094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2941CB83025
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A181C0846F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C3229E0F7;
	Thu, 18 Sep 2025 05:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WL9KdHv7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF8029C325
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758173168; cv=none; b=n/WquHQuKmFGURn4GNMQ5NJJTyxKDZMQ7CdND2UgY5CPLXNu23vw4M7JBxCEhjzeZM0PbW+5bgFsaDrabDUJSfrbLhOGK8Uul7ARZKqgbcTzVGvUthJ3vBw9lghdMUYJMx2O+jcOEhrqlx9N+VFq6TRNTCn6e8p/vhGb2xJFNFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758173168; c=relaxed/simple;
	bh=4QtD3PPTO8FXZFLGpokMAo9A/yPWm/TWfx9Z+Fa1zRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIz1t3BxGVe0QXQ+PxtbkNjElfvbrzAkf6jyb6xju23TY5ZCo1i4RmD9DuaLKYKcAWkUi5XJScpTCDZDXCEuodwFWzI8bg9EG3M43/LJ6zIfryztQpzf1wkdSZAdRARJYaM6gotg2E9CYjcqrxIiwIVY3vRwhzQ3QQs/JP5sgGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WL9KdHv7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I0VD22003337
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TxLEQ1yAcsKflfwl/4WqUC9+qcQ3v/8QuoGR2gXv2U0=; b=WL9KdHv7HW9HW90u
	d+7MCah+mYm9FJJHBOJ4+Nra6vgICv7wWVTvka5SuO6C6vzuEvjpQEH7NJSGv+vZ
	0DMSF6G47Xc8nYoQ9k1rw5eW6+onbyyzU0zJXeZQpRNhZeETgp0T3DTwOrFl4HA1
	4FhiON6lHwfCP5vjmk4uDxAE5eLPTkQUznyNhtL3PMeAY7lDUJoK8v+eWa568lGp
	Cx8pAJBOIbyCTsX0+/ru2BNGm1gjlmHLIPTB2vU4XaLtmWUJrHAXvc9pE1eRD7nc
	Zu6gNNeoWBZ656GGX1TEVJxipOH7N+7WAMqgUKC9sh3ssOLgtfgvnJ3mr8AQqgi6
	h2W38g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497wqgtkcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:26:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2445806b18aso7424135ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758173163; x=1758777963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxLEQ1yAcsKflfwl/4WqUC9+qcQ3v/8QuoGR2gXv2U0=;
        b=GJmitSaY3R45seNoz1i8ixGl1VKTXgAS9ruoUAzN0qULE/ksIjpEHe9ptLmafx+XTj
         HpxMB1be+BnAqd2O/MKyMlKBtvPT/b1FIMzEkCUxW87oRTCKzwmoLhgyu6b9S/dL2TVd
         2AUY1JzIxpzAeYnF+ApgC+9zG0reFUdM4a8NzoG0eesKenJdklzyTo9dkwb4/mIpL6Jk
         CFo7zKOO8nsR2EJhiRbKrPU+gCQrJU9Ep3dn1bfrcJC0AO/ZPXxwVDFHPEN1852cMijX
         txPVM5Gdj3iYfZmgloYYlF96/gspeqMb17zjjNmkL5IWTuwuxWfb7SVfkQIn1FxwII0j
         0POQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTMDxPgKAJsX70N2aDIOBgTZUOFypi09XqUjXI/dEMNr6ah719M1A2F8Za1T6pNoPs4CUHJbnguT4kz0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS9nZCOzGLV97N6jbLTAVGvDLEs4QH0nzuk/9SvWe/Izdkso29
	IRTEetVzek7FHqrwdQmEea49ixFLYlNK7YrCXQcu9PSa3VfQB2wZY75mlGl5Vm+5MEw0zy+yeOS
	4QTAH6fEtZc7AUD1DgRRmFo5mn5/7Vckv1VBBoc5Ha5kcrCqWAHEWxaRxcn4k9UY97ZY=
X-Gm-Gg: ASbGncvm3fhY/DMw7uUcZVEYRLXprwuBa4GTq+NslxfxPcdL5O2hRQK6DDrQAbS783p
	ZdswZZeAuweUuF8yhRK7s9AspeyfsN345qkMqXPK/vwuUE67cXq3XeoRUlQ8pl/JEdABAZro+bZ
	9cUvQmrmzyp91ROqsbhYPa72WxzxtdgU+Sg2OCuprU54SBDOpn3nWokXZBmdney12wktrWFohC2
	N41fzCqBeFrHoh1f/ONnn0ARYYqvoZbOANmvHDSWXRu62a6BjKLdOAtQqwPU/kIwO1mE4tpARN/
	kktB8cCfP/T7mQNWvCemxQddr+pPydb8kcOsUv5uJgHv4PnrUwadWm7rXgEBfIa44qwnncFOjKa
	8YuK44A==
X-Received: by 2002:a17:902:d2ca:b0:250:b622:c750 with SMTP id d9443c01a7336-26812382744mr59356185ad.27.1758173163194;
        Wed, 17 Sep 2025 22:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2eKaVeUCfIArMi6p8GZxEhLIWooff9a8Rntl8i99RgFCyRT1yLmP+U1U71pJsFcKLBylAJg==
X-Received: by 2002:a17:902:d2ca:b0:250:b622:c750 with SMTP id d9443c01a7336-26812382744mr59355985ad.27.1758173162768;
        Wed, 17 Sep 2025 22:26:02 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de963sm12704935ad.77.2025.09.17.22.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 22:26:02 -0700 (PDT)
Message-ID: <36e9b150-fcf4-db45-54d8-a157201e516a@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 10:55:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath11k: fix NULL derefence in ath11k_qmi_m3_load()
Content-Language: en-US
To: Matvey Kovalev <matvey.kovalev@ispras.ru>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
References: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LTAAEphnRJkuf5SkUAnz6T4oxtW84UzK
X-Authority-Analysis: v=2.4 cv=HITDFptv c=1 sm=1 tr=0 ts=68cb97ec cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=HH5vDtPzAAAA:8 a=VwQbUJbxAAAA:8
 a=xjQjg--fAAAA:8 a=EUspDBNiAAAA:8 a=nfJR6hy_ZLdhEb8FW4cA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=324X-CrmTo6CU4MGRt3R:22 a=QM_-zKB-Ew0MsOlNKMB5:22
 a=L4vkcYpMSA5nFlNZ2tk3:22
X-Proofpoint-GUID: LTAAEphnRJkuf5SkUAnz6T4oxtW84UzK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDEyOCBTYWx0ZWRfX9GtAFCOYrH69
 R/Wa4lCq5TJym32Z9NHsQ01jg18ooP+GUCy5TEYeBdUVctosd8RO7IgF9eiQSURGkE5k1dElXOd
 iIVx5o0Y2Sc3sojmRWmtmRIbDqE+mQJKSj5/RRiFA11Crdm1BJBUX6Pbzz70F6Ula+1mDNZ5fVQ
 TvVbC8MWXXDgqDwuHEXrWuMYHnPZNxLpftonUkpoN1Z+qE71Q4E/JnEL1VK1IVLqJtSPLn/q8iX
 5nLg5DmsiJpGv/zCfFRnVa7yz6yamPf/sfcv/q9Ex3qCMMHNamJZdw5UxoPNUBEwaHyDkeyjp49
 HyLwfOhsQeBZiMQybjDhWBQ7q8TUgq3gZwSfdu26CJVXOpJN6Ue/JXxTjz3JYzBQO6ry2Gt32M4
 f4xhHldm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170128



On 9/18/2025 12:50 AM, Matvey Kovalev wrote:
> If ab->fw.m3_data points to data, then fw pointer remains null.
> Further, if m3_mem is not allocated, then fw is dereferenced to be
> passed to ath11k_err function.
> 
> Replace fw->size by m3_len.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 7db88b962f06 ("wifi: ath11k: add firmware-2.bin support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

