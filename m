Return-Path: <linux-kernel+bounces-822191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B702FB8341B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BDBD54137F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420282E3B19;
	Thu, 18 Sep 2025 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CzwXGlfP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1098C2E371F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179157; cv=none; b=F9ZnYUKgQEn0PInkHJs8g8q1fbxP5SymlhYWR0zsq8HAnrWMUegRIBzdFFxTyvq7Z8wgCyZWPEwGYinoH3GSCUNLBu87LO10BnoghVfAj7Hhp2ySXh3VFTFJUmxDehloSz4G/0s43WNXkRMvuidLtVzA3un8KF2tEAv2klr/ETw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179157; c=relaxed/simple;
	bh=kHO8ThBf+XrP06ta5enGZu9Czqp7x1xx4kmAtv3FwkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MT/sbYKT+hSxFFE/HVm3Y4SBgdhV7jkFLRa8OksZEYVXqKZXywCAx08oLaht8AqYzx2IkUHrvb2Tfl2ffs6tB8yflrj34Mu9hTf6as/a6/xHAX8Exsk/E2JknPMOToj7p/YOovUHYdTH3/YmWVWs9tOHHt2qrFRS6KY22PQ3xCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CzwXGlfP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3GvCl019523
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0Y9SMRbrA8EfTA12V370ZjzmDEQEjVLQldlUuJJBEUk=; b=CzwXGlfPIZZ8Rm9v
	ih1v27tHolXYHI+S6bcDnGZrFBIabu+6GzYStzGhtFffoTTYVJMiWSc1x5PhnGlI
	V+mwX8F/oRysHinaf6sY+esqb1XW+lHqRDchiaJtubCm1Xx3EL1uQpYnGzxNWlov
	YiQu3tzSPJ6HobXwzYay6FxJ99/8/6fOGHMOrvisvDpAysCPO/rU8rhSzuIVLWaK
	4nV73y7n7A2dlaL5Uutsvqh+PFU/tGVYv0ikHAOC5nL+jYyCxE4ZUCGHcNlxe3Xb
	d+ck9o66yUc6kz3McIGX2sY4GYdENz2+dYmD5gLlhk3h8Gx9KbICcxgGcCO8Amt1
	6C3Axg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy1wd1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:05:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24458274406so12945315ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758179152; x=1758783952;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Y9SMRbrA8EfTA12V370ZjzmDEQEjVLQldlUuJJBEUk=;
        b=LEOgvI+LyB2ZLQsLr3CHWFUS1+hPAO60xoxRHAr5XcPWhst08r0SEvCkNYN1R17OwO
         E8ZYbhvFb2rgMi16wT+n03ltbRnJb9k1CW0j/aqDRsroLGdEmH7GnyAiiz3jFey1Eb4z
         2WA2KiG6l6V9/sstlpm032ig5Qkw2Pg9+YAEbmE4UMxAqiJIy7303vDf2L5sTwQOjfzK
         Ar2b51hONZlK3nRC8YJczl6pR/6Nuzb6p8l8IAEOUChJmWPC0p06+x9tUTSZibAvL0DB
         mmExswoTkQwZf7WmAdKdTopOcKs1RZEvXbGYhs7/BzGU21EWRWVdz+JVa8YMBxXTFxkY
         +AEA==
X-Forwarded-Encrypted: i=1; AJvYcCUNyEZopOHLk/F+jlJYU4aAOcJu1WkYw0BKNuryTgCynIhrgCWYStvL4ipFXHlV5SIP6HCtKjVfcpDONIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4XA3me1amQtuqWHF4gNL8di3sPvmkUEGAXHMrIKWv8neXGZCe
	MldQGP8OVKM5P0PcO5YgkHJYO6Pn4anVaT+PWwRkhnQxOlduOxx1I9znoCKYpPUH6woFRSqcycN
	ToMP4Co0PKF1zLzdCw582yPa81w+d10rfB/7lvj8D6rkGIdCjeEgW+QBCjHRwN83AFFw=
X-Gm-Gg: ASbGncu7gNAfgdQpVxdbF0vfe9T4+ktATGP0rnkbnKhctdylWlUIVc5K/+LRQmPItDV
	L8bAz2M5qXCtUuOij/Cwepif1j0Dr5N/MBI7AKe1bVa0melEX+r6HyH9ck8P7+PApktwrqbqS98
	aVhJ/5mpiuf6rI5KSw76Gfmrz/gFjlyXZcAt+7uIxPYh5GMOMxhN+6Q+Pg2GMqkXqXLSQbRFzt3
	f4tk9X6yoGNLVdf/MUXngSuDtiVc+gKoWZlvazJHYbL3VPNlkT1tjKJkJNLkigAN5gBWWwIqKb0
	YakoFy7KFBInpKHYZenhlhJtmW9Gpbx2KswGd5r96iAXVdIrO1JbC2tEMNZGZgREMeOwQZRs97N
	fHTsEzMI4ZTjAHg7gXL+yvzGslrmDaz/sff4/
X-Received: by 2002:a17:903:41ce:b0:24c:cb60:f6f0 with SMTP id d9443c01a7336-26813ef9e7dmr70240695ad.58.1758179152481;
        Thu, 18 Sep 2025 00:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7dkYXHMRO6tV4bI3uZ2zCxGvRmSsCJrG/bAY29MaksfKUnV6mW/CITxSJyjLu2qyBOVYXhQ==
X-Received: by 2002:a17:903:41ce:b0:24c:cb60:f6f0 with SMTP id d9443c01a7336-26813ef9e7dmr70240425ad.58.1758179152014;
        Thu, 18 Sep 2025 00:05:52 -0700 (PDT)
Received: from [10.133.33.30] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26989844036sm11100095ad.31.2025.09.18.00.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 00:05:51 -0700 (PDT)
Message-ID: <88ce11d8-52c9-4170-84c0-d364367646a9@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 15:05:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix NULL derefence in ath11k_qmi_m3_load()
To: Matvey Kovalev <matvey.kovalev@ispras.ru>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
References: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -QGwElK7AW1LkIlUe8CerpEWtRtrLXRv
X-Proofpoint-ORIG-GUID: -QGwElK7AW1LkIlUe8CerpEWtRtrLXRv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX2c1D+xngDR0X
 I11FQxHyDJrhYkCI5u8wFG4ddYUoUOM/BFL862j1U96ITIIpZtGhShT6JQal2UyI/o7p7bXGaDT
 Wa6EKluOjYJpMIjIcr9Pv6t9YkC6xadBObxnfhrNFIPQUd4xynbNxUTia7Wcatb22eL6fXW0e0n
 xUZsy97QJsPVxzYA8+58xJfqQSPtOkAWuGW1AEvvg3ma2+jgT4SToXK0YU4weGppUoOxepe1n4Q
 TGDAF9QvWHxLCepr0QeA1A3jRBBClfrIgZcAt0EwVExrN3LXqjgkNRmuRL85ZrokwHcZaxS0Ftj
 8WKbAWZu1u6oYi0G34c+mQsCOOEO6LWLkroUyxB8SJlbTJfmv7iEeeItbteSJhzroaxRsT1CLB3
 JL9F86wn
X-Authority-Analysis: v=2.4 cv=cf7SrmDM c=1 sm=1 tr=0 ts=68cbaf51 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=HH5vDtPzAAAA:8 a=VwQbUJbxAAAA:8
 a=xjQjg--fAAAA:8 a=EUspDBNiAAAA:8 a=CFS23snBG6XJB5ISPFYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=QM_-zKB-Ew0MsOlNKMB5:22 a=L4vkcYpMSA5nFlNZ2tk3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/18/2025 3:20 AM, Matvey Kovalev wrote:
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
> ---
>  drivers/net/wireless/ath/ath11k/qmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
> index 378ac96b861b7..1a42b4abe7168 100644
> --- a/drivers/net/wireless/ath/ath11k/qmi.c
> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
> @@ -2557,7 +2557,7 @@ static int ath11k_qmi_m3_load(struct ath11k_base *ab)
>  					   GFP_KERNEL);
>  	if (!m3_mem->vaddr) {
>  		ath11k_err(ab, "failed to allocate memory for M3 with size %zu\n",
> -			   fw->size);
> +			   m3_len);
>  		ret = -ENOMEM;
>  		goto out;
>  	}

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

