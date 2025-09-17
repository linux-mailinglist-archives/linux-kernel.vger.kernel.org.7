Return-Path: <linux-kernel+bounces-821621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA407B81C35
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9184807BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB882C11D1;
	Wed, 17 Sep 2025 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O32RE3ri"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC62749E4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140993; cv=none; b=VfD9nJfsCRya5p1Y0xaYvGbzLqk+nrv7SZVgKDiKHc1Zy0WG0hm6x3x8ri6v8gprsMGq/0Vmv0GQNCxCS1xdLXrwX2sFSoB6nHx91mWt9poLh7lpq6BF9UPhQW6Aa+n4QLuRsCkOzAEb9gybCciZlf5m/LKwZjekLu0tUgYfg6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140993; c=relaxed/simple;
	bh=rxAati95/xUI61030WJWld7Jg5f/fH5oCtuvlnPZI1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QB+DD9ZK54DnmcFCv6tchDhk0mPAxFopdsLceG968hlv3cqMLlhOKP+2GRnRC2KnG/vnm8WC8gq3QVejxxJNSJA6JRBeMjzrNZudSTJG+RyASV6hi1CbkxXDyfAO9su5uOlwXZXE7hZmLeYJphjrCnj5tNoe5wPi8YBiNsIvhAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O32RE3ri; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HGQTER014186
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HEM1lJMKa2QVcYthJ1BIIXMBnRFN8LfFqYTZtb21724=; b=O32RE3riyGSoQUA3
	q1AU52H69/hFWKxCdkNT2rE9A5iLo9O2DE2gH3UigCTJWh/IhPNYpdk/6/T7rPV/
	dRxVGsbUMtE+V4iN+zYI6w40/OKEW1d6Sbztnqhi9ZNpWabFlEDTj7FqKdBhknfP
	PtoAXuOEl+TX8ni9ogB9Hs8kqbNtxtAO2cnLFJjpoMcDVeg1zv262qAaiQI6wOLu
	frgsJ9YRwVZKFw0wCWi8Vw5UHqile123TQ4Jwp+QDXrOF57S6gra+EInum6rW7gx
	pnR9gxL7Tn3l54eh6bm3o4MRRVn3DO11RHmYj9HTZ+7iTlLFsBrDTGrUISaF3Ydz
	lgPv3A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxu3syh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:29:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2697c4e7354so2894385ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758140989; x=1758745789;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEM1lJMKa2QVcYthJ1BIIXMBnRFN8LfFqYTZtb21724=;
        b=Q2/3+jISPi9Rpbtp9tQhHMkuWBM69BTpqpjTdOaoioBpLZ0ciX+Sxnftc3oDlGiHIr
         F0fl5+jP3qtQNj4WefMI83VsVG5SDmd7B6XDdenUTfVpF0c/gPA5osabuDt4M7zgXMRl
         zbaflZb0wsVQVHnjUgfHZ720aywViB+v7qJ3ETDHrERUVz1lKmYIWWCyk7C3zknCE6ik
         8xftBU4aEdCeSOBRZQ0Uj06AXOOLDNqZAWEr2u8RdeqvuqlS9j5W3lKSkdCHwKv8YeWs
         BEClCy9qhsGwroqwZq1HIPRzv/A+wPaJq6KwZRZ8STASsVyQV4KRkdfpPSHoNiJCBn/d
         6Yjg==
X-Forwarded-Encrypted: i=1; AJvYcCVxbNKrhvN4qSkOJRFMsSbxKjdpxhbuL1yWDNktorU9NatDpF3/qijZSB5Yq/brmn5xpMttMs1Nkbpnm6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz32DDJWCMIM/+/o7dO6gO4ygMhgUylpi8HS4Em3KncYuSYLkcA
	FJ9Soro0EwQAb6WkHN0QJJ/rDd5s4aCbMVkC22O+wMcjV1hBf8dDrkMu2n6xeT1Jt0nxLFbwgdM
	0nBmyJZsY0c3/CdQB9RUjZvaUz3nrl4UdGLCTn03kKOtpJWx/JexvGRxvgIxwKGq3fLbR/Y9ZGq
	I=
X-Gm-Gg: ASbGncvIa1snesnYJvvsIQQfgDSX6uca1iqkRjxkHMdNQPgzihJ1vzB/tOVMh72e0/Z
	zMLfQVGxJFC48vrvCFetfEeC7WC9NS/LIw3aB+A3ON28CbvwraNZw5TQ/ROeiC1RiBGTer+w5Wp
	jTEii94R6rbVrVXPa8qUkd7K8r/UqEe03chct0aWUTYAMvcLxosNuEWp0UYjtf1po9by/afZC2l
	UOBdvcuAK+z4RDuCSAj7QNMa+jeodtW8HyLdVGJzmWKFxZl21C8+f/3YTZPQUGBhpqkpRitUF5k
	Eie/pPu+C+qyoNBMU4JJXX4wtt9dbIYhX9f7gvQCN1Z9H9Q7br82EpH8PN8FCStEP2SiTFnnci/
	vuAWlW04Za4e9VLnmz4JayWbGP7XSv4heWjRo
X-Received: by 2002:a17:903:11d1:b0:266:3f63:3500 with SMTP id d9443c01a7336-2697c829fd7mr9913385ad.12.1758140989443;
        Wed, 17 Sep 2025 13:29:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoM/05y1CwkSSQcd6Pm0FZF2zcDhD38jOzV9/eRqaD0ZUm8ijYqgE/YnLUSCVJPnWy0wFC1w==
X-Received: by 2002:a17:903:11d1:b0:266:3f63:3500 with SMTP id d9443c01a7336-2697c829fd7mr9913175ad.12.1758140988955;
        Wed, 17 Sep 2025 13:29:48 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802fe08bsm4163555ad.103.2025.09.17.13.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 13:29:48 -0700 (PDT)
Message-ID: <b2efb1f2-df89-4c88-8f97-e164e89c7532@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 13:29:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Remove redundant semicolons
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jeff Johnson
 <jjohnson@kernel.org>,
        "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER"
 <linux-wireless@vger.kernel.org>,
        "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER"
 <ath11k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20250812075259.6921-1-liaoyuanhong@vivo.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250812075259.6921-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX3uhQDtI+Qkkm
 L/8CX7l5Wqfy9Chteq9hlMdj3NCsgLbc6XTmBtTBBvXXR4XNWpL7KF7fpATJPJkXll0JdcY72E0
 ZraMoTlTa9dA7ZT3jJaYUOyyFQPzhg1FFSK/cPmYPE7fTCMIiOXVzeIrfLDpPuTaTB1N4TEFoZx
 eT0MTHCF2Cw3r4tS4KWoJZFSeF3booY/aDNf/qgsgxb3A4Airp/WLCd5mCtUaLlvtqep/k3Jwoe
 HSyht6NLIcNpYOhZyHyvXgbuYv5rtTCLjDtde6Fc4X9jxySoWOy4OMgeOqo2vpprVaNuwrTUDUX
 6eCXb5zzpOL1i9UnVStA//vMPA6iVAHNQXGmIZGONrE0b4ATY1waS/bPRKDi7upgfBnbkW8MSdy
 jROwBbFp
X-Proofpoint-ORIG-GUID: QlunFZqFcyVjk4zyYiD07B4bR5WXcc2A
X-Authority-Analysis: v=2.4 cv=R+UDGcRX c=1 sm=1 tr=0 ts=68cb1a3e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=1WtWmnkvAAAA:8 a=mgvM1FoPK4XduYGJcSIA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: QlunFZqFcyVjk4zyYiD07B4bR5WXcc2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On 8/12/2025 12:52 AM, Liao Yuanhong wrote:
> Remove unnecessary semicolons.

There is only one so s/semicolons/semicolon/ here and in subject

> 
> Fixes: d5c65159f2895 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")

Drop this since this isn't a bug fix that needs to be backported

> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index ffc7482c77b6..b9e976ddcbbf 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -4615,7 +4615,6 @@ static void ath11k_hal_rx_msdu_list_get(struct ath11k *ar,
>  			      msdu_details[i].buf_addr_info.info0) == 0) {
>  			msdu_desc_info = &msdu_details[i - 1].rx_msdu_info;
>  			msdu_desc_info->info0 |= last;
> -			;
>  			break;
>  		}
>  		msdu_desc_info = &msdu_details[i].rx_msdu_info;
No need to repost -- I'll incorporate these changes when I process the patch.

/jeff

