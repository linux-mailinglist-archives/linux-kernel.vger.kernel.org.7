Return-Path: <linux-kernel+bounces-819949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5328EB7CD35
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B16A582D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2EF276028;
	Wed, 17 Sep 2025 03:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DQ5IYe8z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA326159E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758081224; cv=none; b=oNgPWoDnbKO7/uKbZ9iN1cEkPAaDdEjBuzozWye/2MeA8gMc5Xj4Hmp3KNfyK/WJxwfOAtGLkPTZCngh/Qe1pWv+GIpKv+/iyhmVxntIhVKv6sIwnfBD42PLDdWzaFkiJTPFvvMskyXjiwiP9z8AhdK1fLC/W5/nH8r8PbssM9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758081224; c=relaxed/simple;
	bh=KlTGsGVXqwBej59KeF874/Bo/ROethgpLYZEmN7KZsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mKpN6mgSevgn/97Nd1M6wd8delefuJ1dIJSQGvI7Qy4vyLQazAYDFvKeHGfoV7VPr6SugSJJY5awML36TSeSvLkEP8mO+PZXsk/bOJCKLRkKhjBkcSNbUzN+fbezIpPKZoWknplLRxDphj5Wf4HmGys/TArPCnOKyb/sjRMstr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DQ5IYe8z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLZjbP005527
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cep67SnTfnADXcOmFM0wZ+47pVbXaqSC/dRePINIa3M=; b=DQ5IYe8zCWBQgkrP
	1OkP6M8IejcEYdrmuxaD90k7mzkhy2nbk7OW4h5jYcV35u8THXsUcrHMDNddolsl
	de8DbAQcEQX/q6SENMcb0zZuXxgV/4DOxNJxJbcC3DqD5+Qbyfk2Prw0RwVCv+K1
	kJ03hsNB3VKm20eR8LIRMTOUy4RYkslF8lUrZxdEiVypg3bCB2EreZFI+kaalfmw
	Fzkl5nZd8pVLPflxYWhgzySvVRuBK1Cpx1UnBwpWJ5eEUG1x30n/VCpHJrUCS+5N
	6dCYy1KYeI8UVXMpqCIc4WRuE88GxINAgRtoyS5g5Xc3iUD2AsoyRXrp5OrtnDKD
	gJDP6g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxu0trw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:53:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32d4e8fe166so8700412a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758081221; x=1758686021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cep67SnTfnADXcOmFM0wZ+47pVbXaqSC/dRePINIa3M=;
        b=rlbYg3F5gXB9Pqjhrkkq5Epy6Ir1+TLxkA1Wn6AMUBS5IJ0JW3KFqD4RRbp60AexJQ
         v6EWTRXA/rsux2q01/2qnGTzgoSrKpvTCht0ePjjGyui2P/uwraazQn6lo5mcipJkRhY
         v8ku3vC9si1c/qeXdgoXLz+eqf9EBQuH4XB6v6iO2bGGKt6HJPw75/J6HgkE7eBxfvIP
         +ROoXfAlhumT+hfIQ0mKxpXLLfdnFtgv713qERe0BZwWiXEb2Sa45S22h9YuzTbtaVrK
         XbVuQctA00M9Vi7Y9vibVnTrNPZZZOeuEdE5lyngSxGLsZgiEyVG1hUb6JX6Np03O1IK
         4CGg==
X-Forwarded-Encrypted: i=1; AJvYcCUPX3O5nUP54VYRjK7+v4zUUAB05G57mesR4Ok7nSQtn7zHzRPV9rdZQ9iCr6j2T+H4lz1laEyn+wYMEHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQXTvC+7zWQI5aLaVu3XrRr9dvBWdkGLTqmt+KXfcWFFwNT/WQ
	xdoZXP0H6cEjjJAf76rIUUoy+8B4hZjqUO8nRgyj61AqU3oUcDGbvQIVrqCmEDzTzxDa379ASbd
	syArLy4mhm4ZiEU64szXW8SFjrLD1wE7yreGcdsZNIn6d/NUUlgCPgEfRah0WEafZ5NY=
X-Gm-Gg: ASbGnctgZuzkcxb8p+5zYD91hBUCJnQHg9eydVujbNk2jtlsG9WQ+35US4b6ECQd8V4
	V+Oj1A38GpKRAw8Oq5FrH43xKS+YwCeKZ1arHWnSRxN38TCxauuQRXTGTCZ5Cbf4yz2I8yfCAiN
	ij3YWLFyIU5hMXpaRVBFo4+Iy9umsnRd0m+W4ApbiZGOLc284mOAJ6r3QNykqsIluE6IH/IVNvO
	+Y6Xy5JNtK7bfz20JuqjOFoEa6jlgGSvJC4ErNpRPquPubrL+w53vWhrP/vZ79W9P3zssIKSQgu
	fWiQvcXLJnXQpNNfuNjC5KwgqPjgJGuHbiyNnuN8GDTnRTjYm6+emUXlWVNepfoIXR8DXnllF8a
	YTtNaQO8Zkyk=
X-Received: by 2002:a17:90b:5348:b0:32e:d011:ea1c with SMTP id 98e67ed59e1d1-32ee3eefe77mr975455a91.15.1758081221364;
        Tue, 16 Sep 2025 20:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhkw0YdOtL29ExmK2v3LOWKcGCk1jKtiEcNh06EUhootqyd/kiRmyV7nVn1zQ6nwDbzwHsFg==
X-Received: by 2002:a17:90b:5348:b0:32e:d011:ea1c with SMTP id 98e67ed59e1d1-32ee3eefe77mr975422a91.15.1758081220864;
        Tue, 16 Sep 2025 20:53:40 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.98.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed27724c9sm985762a91.27.2025.09.16.20.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 20:53:40 -0700 (PDT)
Message-ID: <a5778370-d889-fb9d-0ce5-498342bbfb2d@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 09:23:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 0/3] wifi: ath: downgrade logging level for CE
 buffer enqueue failure
Content-Language: en-US
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Carl Huang <quic_cjhuang@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        ath12k@lists.infradead.org
References: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-0-f955ddc3ba7a@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-0-f955ddc3ba7a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXxGoeRYAaRQI1
 rhVvMjipv9FmWyhSnS8dqUTGNhrBN0i2d+BYg7Vx/QYmk7eiFTPZVJE2OaiByfXxsAMBFu5g70q
 V8cJhiZROJuxTS+6xI4IijK0vrfbCuSFNhmPWYwyQVglr/WIhssuh9L+En67cUczwYNP5pNOH/Q
 Mf/EPbJY82fFkSFKeHiiwnPxwJilT5aiq65ma6TBAj4pseGftI3S4ZDI4bTZMLyO0r/262ojxl2
 pmfQx1rAkGXFErUs2oPjAzgvQZbFQg9NysU62h4PP/lV1/vUv74UAG5NH+pWquUAsMmNs96nT1E
 v7BBeo/uXe2+G4N+YvkUm/m5sRQRK8qNLJA3DOYS/d0RsJlEUMe6LQtHAqyQSJRWGYPwxKdC5yG
 FIBCf2HS
X-Proofpoint-ORIG-GUID: 3w3SK3_ie4wOi0pc9Aeu6I0Y4Uf9eRxr
X-Authority-Analysis: v=2.4 cv=R+UDGcRX c=1 sm=1 tr=0 ts=68ca30c6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=r0KOKur2OvuaYElxfjaavw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=TpeBPK0GJKfZ0rfD3RcA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 3w3SK3_ie4wOi0pc9Aeu6I0Y4Uf9eRxr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 8/15/2025 7:14 AM, Baochen Qiang wrote:
> The CE buffer enqueue failure won't cause any functional issue, downgrade
> logging level to avoid misleading.
> 
> Also fix an incorrect debug ID usage for CE.
> 
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
> Baochen Qiang (3):
>        wifi: ath11k: downgrade log level for CE buffer enqueue failure
>        wifi: ath12k: fix wrong logging ID used for CE
>        wifi: ath12k: downgrade log level for CE buffer enqueue failure
> 
>   drivers/net/wireless/ath/ath11k/ce.c    | 3 ++-
>   drivers/net/wireless/ath/ath12k/ce.c    | 5 +++--
>   drivers/net/wireless/ath/ath12k/debug.h | 1 +
>   3 files changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

