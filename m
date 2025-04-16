Return-Path: <linux-kernel+bounces-602445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C54DAA87AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 10:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8C03B4016
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 08:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389AC25D1F0;
	Mon, 14 Apr 2025 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NI9ZkgYR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B94B1A23A6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620449; cv=none; b=f0uUXGAdZSrrIBpvHkN1CNxoNeKvt/YepN/Q/dEMM7O1ch22MzmkYXI1wD3sjbkKxm9Tk6HXYWEeqQ2MSz6o6oulhvudADOpl2T5kyvZ4p5llV3yq1iQW2ACAIdqtM7LJ9spjCKU+OAFwQGjy0chxQecx48vwQmFZm3MjI1KlP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620449; c=relaxed/simple;
	bh=4sgW7KzE5H5V2TeIgpcbKStUYHAAHnIaMnL0eP2VeHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5dcV5TNRA4Lc62fKE1GdGQxFLKjW95q9ybgDYR/YLfGtj8sMbET3vZj21gWIjsEdnhza0NjdgNydZXN/lD69thJBU8Zq29a/3UnHi7la2RGAfDmDuY2SbqqmNg5l8YbQTgwWLLFrpTq0IdTcxtF4CAzlXdaOOPM4N+QzzmNmW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NI9ZkgYR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DNIkiU021108
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 08:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZELbaDv0U84tC+LLC7Z/j4gjcJscb5SfXUMMBbX6orE=; b=NI9ZkgYR1ZTqTGzr
	KAOhZqd45aaMNjOy6p4IH8aWj/94xCBfCitjHevabkKqxbySJTmNKes3J5MNLWYp
	scAPuP0lFL2mrtwhA1PRVju8EtPZNmGC/OC9NVN9+K1OrAFFFfC6ZBd2CexvVn3N
	3tFztWtEJQ+ho/n40K6U6JLcTKs0XL+DeMjRmg75yVVeX2liIhmXACfrThs0XPxK
	HfXtXLdtHqNSzFnksBY/y+v6zxVNo7XA31R2OHXPUW431I5ZuUoX5Zkt0uwsvNPk
	yI1P0to6n2nm0UOqxc7Gsnv4iqcQ7eoNKRjMPOlT9nmGsT5vRmEB85QBW2/Y9Wgl
	2wZ6OA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf69ky85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 08:47:26 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-739764217ecso3327137b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 01:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744620445; x=1745225245;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZELbaDv0U84tC+LLC7Z/j4gjcJscb5SfXUMMBbX6orE=;
        b=rdPkPcSqVYx4Ip3YQ7+7BIXvb3ZB+gxD45VzozEfal4jmbh1UD7D+m/RRtQORh4Im2
         yNx55oQL5E1qGI8QhTKdJV43ldP+w2aCB8FynJLNhncWsPjQ3hZCk5UTKQglBfgnRXlj
         2dtj4FxwyF4obFiZ2C0PghtCvq98rcqh3nNSl1xk2VdTcL2Ozwfpm8KmQYEPghCl8trq
         5gVrXHqlsutb3Coq9Mdylb6eyQKK8c/Av7WGMpxS942YMX9WeRBOk9Fo9rMlllxVWjX7
         mk2C0SDH/7CRL61eRgE4XkRiPTixWhgRVaRYKCheLJy+IBrB0Bu51gWbjsv44gKY14zb
         kpqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV/BmCvKmgx+06lszxVVaywH5Oua0ZENVIzxim6ZUd1T6Xi4BEgZz48t3UhTLiT/20Keds4jYqKI9tlsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIZJkCd+u5QW3zUzR5esclxaa6WlhgCJV3HRXh+asgw5J//F9+
	iP0JM1Jd0uhkj3WxqkS3O7KloCWpdTBWWX0sD2qoB3vSQMLhyUvAw9vXJ0qZ+BQsfLgnN2wznyR
	F7jfVHJCY40lDJf1OrsXksS2Q/vib+eHXIkyWYXET8P4V+KOIo5KD2G4Gyh/oaXpFIpjlBV4=
X-Gm-Gg: ASbGnctNJAlPZ4t34db+bZhFK6YlbkV4dNWkk3JuWsCPUYhzvL1RnygGUTN5y+mN4NL
	vzdQMrI8FMhPkANQvkCWDipoFFLaMz4oq3jSl1Hd3hPFntirfcTGzzMMbNbpcII9A940/ZqG0+3
	KzJRTTpd0XV9ZjFjZ+mszS4vn7btdP7mk/ngvWHZyZz1Tz5TFtxnet1FPa6YFFt4Me7KOFJAQ2w
	e2GRuIVeUcdJaXWLTJr/g0CITkigaKZFkpQ3k02AqSDp/aGzSLgfoLVs7Bm4p5kliTt3yB/MOz7
	m1rpSmmWk6W7wyKQPqdYDKRbVzfqR/wAc8Hi9rSodUYmlBZnvuAdtw==
X-Received: by 2002:a05:6a00:3cc2:b0:730:9637:b2ff with SMTP id d2e1a72fcca58-73bd0cda1ecmr14619310b3a.7.1744620444986;
        Mon, 14 Apr 2025 01:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJWLlQ30HfEaPv1YPRJFLijVISI9iFiCOfu82TsEXEVpSgZrX0hTvU7P/GWv75CQw+8aNuGg==
X-Received: by 2002:a05:6a00:3cc2:b0:730:9637:b2ff with SMTP id d2e1a72fcca58-73bd0cda1ecmr14619279b3a.7.1744620444335;
        Mon, 14 Apr 2025 01:47:24 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f10f4sm6113090b3a.113.2025.04.14.01.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 01:47:24 -0700 (PDT)
Message-ID: <c7558e1e-7030-347a-96c3-4682f32558f9@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 14:17:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2 2/2] wifi: ath12k: Use scan link ID 15 for all
 scan operations
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
References: <20250411-fix_scan_vdev_handling-v2-0-b6740896c144@oss.qualcomm.com>
 <20250411-fix_scan_vdev_handling-v2-2-b6740896c144@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250411-fix_scan_vdev_handling-v2-2-b6740896c144@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sBmIj1pa-9T8mdz0RiGNWTtHj_g3jJVw
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=67fccb9e cx=c_pps a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=I5J-iTEKvd7tQp2LRP8A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: sBmIj1pa-9T8mdz0RiGNWTtHj_g3jJVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=782 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140063



On 4/11/2025 8:46 AM, Aditya Kumar Singh wrote:
> According to the code documentation in ath12k_mac_op_hw_scan(), "if no
> links of an ML VIF are already active on the radio corresponding to the
> given scan frequency, the scan link (link ID 15) should be used". This rule
> should apply to non-ML interfaces as well to maintain uniformity across the
> driver. However, currently, link 0 is selected as the scan link during
> non-ML operations.
> 
> Update the code to use scan link ID 15 in all cases.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

