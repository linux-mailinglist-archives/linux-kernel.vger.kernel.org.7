Return-Path: <linux-kernel+bounces-819939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32555B7C7EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FDD1B223FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50CF26CE2C;
	Wed, 17 Sep 2025 03:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="azFY920c"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F97625A2A2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758080763; cv=none; b=RonfVz1in6KoOaCuSQVqGOI+KXPNxX/lKP/RFog5K8GgwEqr5aMwnlNpDiDriypEB3jY3fszqoOjOOVkRPuCaIaeBH/h5G1ClymIzTt1g4+Z3kxBFo9wuGcc9hFFQbWo5Kll0e0N5+SeqWXFV+Y2nAssoKxxxQv6lpofpHlOdps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758080763; c=relaxed/simple;
	bh=sY7+9SKozhRu/TkYni/YpHN2Ml74bnH6lOQPxmF60jQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoJGJzuUD30p9jg8AWrpRx2g26+m1rL/QRmn+CduKtwL/iZMsd3HwEb0bE/lUdCLDfx48+bqVqJ0m3Yfu3TkqhY0ef4h5UeN7lP1/ysuCVWVl5dFS5bWgQS21YTcCvu7kpgx8NdEzHosw4Gkd4YbVgt+4sXZhYOsPQaBasu8Wf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=azFY920c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLahCZ008571
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AMuqU4rto6Tj0kKX2+FmkQgPqo1rKzpdESKn4BxVroY=; b=azFY920c9ghQDLkf
	fX1sqqg7aNP5Jffz9GSXh2VnR3wLXWdhE/kAGkT1J/6ydDFjA2lj8Bu75q+vf84Y
	HAzp0fPEqxhxWj5HdgwyysKxmo6FGp63iIJB86ImYVab7kK3JtyPW33HR4uCkiE+
	PrzdVmXHggxIPTwxuTTOWAnCnniiQL1A7zCUo6MhbbAcDCJXunrXvRw3jJUO3PED
	fGkoCLarGOX0u8YngLPc8fV1rszd5YPTrAfGevKaUU0MesqoqET6VuYMDWe63u0Q
	6WLWbOU7O/V9xBvxaUQ4ziZsDS+q69RMe5nZ+f3SsAn9NOYepWcPRygz/fH1zm2G
	+Q6abg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxxrshn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:46:00 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so6003911b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758080760; x=1758685560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMuqU4rto6Tj0kKX2+FmkQgPqo1rKzpdESKn4BxVroY=;
        b=gUtSoeIzQo63sEdXOentQU02pZupLcKqaFxFibJsNw82E55BmyCoX5a8fjyTbifQxr
         uaCkWnkbng3yRuXlCUgwluXmE40VPZsdsY/9XjMW2fm1XarINlZ/FNHZsRBJQpaUZy4h
         uYz9P8ChG4YYYLzvPExPPJ9SxBnRIfByhoAchKYaDwn7LpvZwK0bGTtreF7SF6jIZSdn
         rOov2HGmsXWjGPOLUnQuCHkBbjkNvMVNIGw+MlBuTZAvPNbZJU9ejgpqCNJE3enX6uuX
         qk6X+vcD4/QL5v5VuKjkaSaK2l87mlmP+clIr94H6hc6/BlMRbpOoeiGgup6xh5DV/if
         dTdg==
X-Forwarded-Encrypted: i=1; AJvYcCVR6SdQmYaGHj3kG2m7OL+4qspK6tQU9+iXPAOn4Q0aT1GcLf7k8dfFucPNgnVU5NMP2JayblO9i0V7hwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBY/Ynu15UuKV0Z5jUyYWMbXPyMNceoaT+GQAJ+ERVqAyV5rK6
	CFuBKWzIQ4Cqx8DejVgiWoCfuKS74m1iDZ0602lMdNBJ7YC8k6LumhArCN9cJAyWp63L4PyIkiO
	yyx27KpU3MN+grb2dSwUVojaMeT0rn/XGTNhZbyN43kqtbrDhrOvQ5nRoQtAdNAfRc2M=
X-Gm-Gg: ASbGncu6Yp3/n8Oikiw6ZcI0OWn7Z4TGvJYFqT4E3nHn9wDWdB1GKQU50JpDN7A6H0B
	WxRQRO9VwCQrbvU7/QHg4p2AlNRbDmlEwLD5yYYwwSgEKIHkr5H7RhPFMrRuAcVUOgeCVagsgXw
	0BWmU/mCDpyKMG+RPz0Pu0thWUFHyrYONtL8jOELT0K5nq2u0he+AJ/uOJeMFxOJa/RxgDJ7Eom
	jGHnTJJCI8dLwxdlLhhnQK/kOu7OpYZObMAHezAcfI7i81QWaS2brj/vAdbYp4U+NUH1LBWnjJF
	4DArasp5xFL5pukPPKU8HjkjQSJKz7tbp62iw2i/ZFAnJIZCpHiiNb6YGV6yyWf03a7PxBl9l8N
	DcIbidfuhRUc=
X-Received: by 2002:a05:6a21:6d94:b0:240:1d4f:720b with SMTP id adf61e73a8af0-27a9760c9d8mr838019637.23.1758080759689;
        Tue, 16 Sep 2025 20:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0SDPT67Q8/Cmh9y8XsaaAI5lLTinSzkTWY7gbKUtf+kghwj+ZUL4wfYqfmIlqztAHU7GdLA==
X-Received: by 2002:a05:6a21:6d94:b0:240:1d4f:720b with SMTP id adf61e73a8af0-27a9760c9d8mr838000637.23.1758080759189;
        Tue, 16 Sep 2025 20:45:59 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.98.234])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54f4aafde6sm30670a12.23.2025.09.16.20.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 20:45:58 -0700 (PDT)
Message-ID: <e2809c34-7002-f189-a10e-21695b529ee2@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 09:15:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: fix 2 instances of Smatch
 warnings
Content-Language: en-US
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-0-56f1e54152ab@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-0-56f1e54152ab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX1k4jv/7rh1ON
 PksrZSZh/z4kpCJM864PyaWK4mQnU6xWBuEVxM6Aj6PhAeq9xi5Fb9ISWSBcBer5sHZmdbFM7rf
 t5Uosqx/0YBEN6Fyzevih/ephT2M0DQ3oDgXU6uA/H1MH0J5jaFVwTCAa6ezDTb86WxoKL41RbQ
 HzmIBo2s/zd+qcGBc05EwqfQ8UEDYwRGz/wy7hvtEThlMWUL3OpYknPe6nLm9+1UrvMlk+QR6xn
 6L/JsDEYLrFwxU1qs+RbUPt8HrA4Eqc8nFYzyz6kMmQF/nqTM8lJB6bQAgs9iflv/+ohdfkdP60
 ewqK7qzEn6s5vVZ9iGTg72wPIKu7Wd4rh71iDpz+KS1TdJmHsp+5GBlfQ22tWx1Uy41nkSST+L/
 XwYl3qw+
X-Proofpoint-ORIG-GUID: Tksx2EKsENzkIkAekJzSlTYEp1i3kDOz
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=68ca2ef8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=r0KOKur2OvuaYElxfjaavw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=BoDogKCtvrOBLCu30DUA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: Tksx2EKsENzkIkAekJzSlTYEp1i3kDOz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 8/4/2025 8:33 AM, Baochen Qiang wrote:
> Fix below two Smatch warnings:
> 
> 1#
> drivers/net/wireless/ath/ath12k/mac.c:10069
> ath12k_mac_fill_reg_tpc_info() error: uninitialized symbol 'eirp_power'.
> 
> 2#
> drivers/net/wireless/ath/ath12k/mac.c:9812
> ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'local_non_psd->power' 5 <= 15
> drivers/net/wireless/ath/ath12k/mac.c:9812
> ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'reg_non_psd->power' 5 <= 15
> 
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
> Baochen Qiang (2):
>        wifi: ath12k: initialize eirp_power before use
>        wifi: ath12k: fix overflow warning on num_pwr_levels
> 
>   drivers/net/wireless/ath/ath12k/mac.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

