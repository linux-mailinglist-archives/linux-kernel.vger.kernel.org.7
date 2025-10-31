Return-Path: <linux-kernel+bounces-879411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B7AC230B1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516DB4065E0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF454307AD2;
	Fri, 31 Oct 2025 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DMbdBDJy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wt6bgqZ0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506F17A2F0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878587; cv=none; b=DA/NTFy3B5nlwCqtfCvVlTzwUNkxj3SmiwMuI4+0dHQ31BQcTC+xi5UU8afEh1X2hQxehU1CsZMxiVbHjmj324dmCgTvrdBtdVUiszMd0c/lPMssmg3MrWHnkaRbPfucYgFRUvEHRINGOJCsmNYJ7Xfm0ME7mshlqdxdUayIdlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878587; c=relaxed/simple;
	bh=3xpe/u+umBwh3iWjjLU3VUCqiNVzlIwOoLMx1RqSURI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkDrGHbg9y0KyYgE1pgkP2qFEGjYG456MtOFMwSuP6Dx1I3Q3gITGDgXBQ9BT49X6J5FD+FyznEzjRkLL5RIoW6ZAUivk6mjO90YssdCNdCOcGHYXCvcdFT0EbnKKEqmnCh6VePk025j+TiFr7bbnAgJebVJ3tRdE0Qe2FqHris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DMbdBDJy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wt6bgqZ0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UKsPfu832799
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zaaBloIJGhaoPgQ7d71zW2258dFe1LLg6EVGK/EBrpk=; b=DMbdBDJyehDD5EkG
	3NYYD9iuLX2ZZjLN7z//9yHqBW5zaf1leAY2I3+vf7LGxHr8E0igItnzHFZV1vgs
	TcBLpQuj66vCxy9Ldaqw55ktwx/8GdarNR4jBIamzDGw8dIxPYE/A3WPl0FhYy3h
	Lab3GZUPWmvmY7R0ClpqE5XqjGeHN5//qWNfmXmypiT8IncfIJE8RlG4ys3YpEfy
	HU6KgL+vsyOcMfmEUb7y54HiaDDu0UUkLvPy0VeeOncMEtMBtra7FT8VwMFGHSRF
	E/PjF4lf8YhCnkvN0BqwaeO/zfPpdRMqvN4s+Gj3xl7w4UQnMYoS31Ryd+02Q4TS
	l4TzRQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ffb0pm6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:43:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29526a908c4so1961625ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761878585; x=1762483385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zaaBloIJGhaoPgQ7d71zW2258dFe1LLg6EVGK/EBrpk=;
        b=Wt6bgqZ0dbdG9w7/idtIJNTFdUGlzCQUXCYWs1XVAaWrkpDiTliXTdRFLWq2gYzAlz
         Uuf1W8RAnLtpN+8mV8pAMaTe/CJw4bPwvo0bPZMi4ynfokV3a/O3n1KMDuyUIh7a/0Gj
         fk5Pf5+V/NW3XWVqrTtz6WeLgEOXlvdkW4kEGeHozDokaYiLKtgRxcwIrlzTQ3ifTpaz
         cct5huuh6V0176VX8QnAHeLlrZOgSuw+2HhVaY+fJpxHJ/lU8XzTBpfejIdAfk7yyUyU
         Utak1LKcyQEuFHMOt1GIagCwF+ujC+sswi5yVXMMSrjNqh8uFJBz6uvqLb9Bqwqy4V8h
         4O2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761878585; x=1762483385;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zaaBloIJGhaoPgQ7d71zW2258dFe1LLg6EVGK/EBrpk=;
        b=i6NF70RB7KRUjW9akOZwmJIqGTor6DlnyTl7GGfi93S3CZ3CTF0Ib8mK+wGwoHnAOf
         tk44+wbqwH5PscI+8c9i8DWLNDeir65vZRrXoPg+rqULVwz0sQRVt1Sp6CPqURk5B3hJ
         vtrhwEJaUOqKXH+fpYnk1iAQ60VfY2rQMq6EU1AqoHohRBcjH71Y/0h3UGs9J77nY64B
         MkWz+byFG+BLEgMnVhPD3zIhEbqSKyAVxx6B9bGHu5/XBl7k2GJA3Ad0HgJKcTXvpHlW
         dIcfex2/WWE+EXATxx1jGvjWhClnmIf+2wDW2OtuLF0xkYxpvPYFCo8FVX8stj3oQwMi
         pcig==
X-Gm-Message-State: AOJu0YwEIzbnpFk8tZGQtMGkwJDeLU8QuEuyEDzS7LyrHW2OWKLuVOuM
	oGGFOXp918VMyBz0iV4qK7TTMRMGew2ZIlUBlKXxFGUzsDS1cu0lMly7a5a7JxmurjtjYcXIafC
	cbm5qVel9/6iwexn7odceaEUycoUIwOH1rMuEcTe4P1x9rrlnK3jyIFz7ekI2KvFKa0c=
X-Gm-Gg: ASbGncumUImYMtfI+V3vPp1U8geAH1ye1y+HJMdZ1oRU7UtbE8YsfFGGg57Ju7O0vpd
	0xtRne5UhMJx35RkotDsj3kwBIaFkVsDhzgov971r5BRj2faTn7menVdEbowlmW5SHuMG+c6CkP
	lbFW1ANe0cj0bg/PKttKNhCu4A6lTJV+0+b1i5xQBLU+euuR6zw5oQK8JwJ7anKaYUWYh1SJ+JV
	K541Bjf36pyPiKYP8QYo8q/KK21xbdWMxdz87VtrYe0cpqRjzwXbLeyMZ3OQtg6rwA1blaVuKU9
	aBIE+hDgcok9R1zIJhJw5h0gsbiVIWd5bHNE8/OS+U0aOvDv00xZN7mX0DhXoeSceYzz0X64Z+N
	tujn8WJHQjmZYyNFG78hNfrI8VNJr1gh/PsGEwFwzxQI7W4c8Ji6tHBrUaHuFPBcvAq9VeR0=
X-Received: by 2002:a17:903:41c4:b0:293:b97:c323 with SMTP id d9443c01a7336-2951a4d8a1amr22756885ad.32.1761878584943;
        Thu, 30 Oct 2025 19:43:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYAINtH87QCRpaxqVNeNSoSEV2daxmlFd7YpOAhUp+qFnEbICbCWiL3U2ZX63kl/mhI4m9tA==
X-Received: by 2002:a17:903:41c4:b0:293:b97:c323 with SMTP id d9443c01a7336-2951a4d8a1amr22756625ad.32.1761878584373;
        Thu, 30 Oct 2025 19:43:04 -0700 (PDT)
Received: from [10.133.33.51] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268cdfcesm4592145ad.48.2025.10.30.19.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 19:43:04 -0700 (PDT)
Message-ID: <ba928aa0-d1d0-4e10-bfd4-ab7a577dc8c1@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 10:42:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/6] wifi: ath11k: Add initialization and
 deinitialization sequence for CFR module
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
 <20251030043150.3905086-2-yu.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251030043150.3905086-2-yu.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cb26hDkng3Zs9gyrSbUIUuMjcYAJwsIt
X-Authority-Analysis: v=2.4 cv=fpjRpV4f c=1 sm=1 tr=0 ts=69042239 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=d9LWlda1mWfGAY6gbx0A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: cb26hDkng3Zs9gyrSbUIUuMjcYAJwsIt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAyMiBTYWx0ZWRfXzAmXDEJ/TaD3
 yDOssFsAE2AdaEnMGr1p/yZ+ElTt+NFTpcNGFeEmZXqxRhlmERTxP6BCqTvAl9m9UmHQNa2oAOw
 5srHZDOY8xETREFvUKMdOPNhnNCGp4+HaBe40s7rygPW+ZzkYipzOupbPMne60LDQ25EsqEJV2p
 U3Dr8b1vYwD8xHmSNJQnNNbMAjRDezG1Fthr4hvU6W9ebZst3BYebUD3AmyX91UryKLvk77XpOD
 yNRyhB5F6TiHYKHXrY+ol9T5MkY+LBJRVmxZtXFP4MErLVVgxmHGD8ZmoRK3gDgBsSSDivpRWwX
 5oKIAwFJynwT+TAoUIBTY4HixWvKdub7Wc+xum+zKD28+ERsYnbGaG6mEnuVv1+qb7+CoTQtasD
 AcSfDys66Vmg1u9EY6+C5NozkSIGuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310022



On 10/30/2025 12:31 PM, Yu Zhang(Yuriy) wrote:

> +void ath11k_cfr_deinit(struct ath11k_base *ab)
> +{
> +	struct ath11k_pdev *pdev;
> +	struct ath11k_cfr *cfr;
> +	struct ath11k *ar;
> +	int i;
> +
> +	if (!test_bit(WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT, ab->wmi_ab.svc_map) ||
> +	    !ab->hw_params.cfr_support)
> +		return;
> +
> +	for (i = 0; i <  ab->num_radios; i++) {
> +		pdev = rcu_dereference(ab->pdevs_active[i]);

_deinit() runs during driver unload etc where pdev may not be active hence issues can be
expected?

besides, pdevs_active used here but pdev used in _init() ...

IMO, we don't need pdev to be active here

> +		if (pdev && pdev->ar) {
> +			ar = ab->pdevs[i].ar;
> +			cfr = &ar->cfr;
> +
> +			ath11k_cfr_ring_free(ar);
> +
> +			spin_lock_bh(&cfr->lut_lock);
> +			kfree(cfr->lut);
> +			cfr->lut = NULL;
> +			spin_unlock_bh(&cfr->lut_lock);
> +		}
> +	}
> +}
> +
> +int ath11k_cfr_init(struct ath11k_base *ab)
> +{
> +	struct ath11k_dbring_cap db_cap;
> +	struct ath11k_cfr *cfr;
> +	u32 num_lut_entries;
> +	struct ath11k *ar;
> +	int i, ret;
> +
> +	if (!test_bit(WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT, ab->wmi_ab.svc_map) ||
> +	    !ab->hw_params.cfr_support)
> +		return 0;
> +
> +	for (i = 0; i < ab->num_radios; i++) {
> +		ar = ab->pdevs[i].ar;
> +		cfr = &ar->cfr;
> +
> +		ret = ath11k_dbring_get_cap(ar->ab, ar->pdev_idx,
> +					    WMI_DIRECT_BUF_CFR, &db_cap);
> +		if (ret)
> +			continue;
> +
> +		idr_init(&cfr->rx_ring.bufs_idr);
> +		spin_lock_init(&cfr->rx_ring.idr_lock);
> +		spin_lock_init(&cfr->lock);
> +		spin_lock_init(&cfr->lut_lock);
> +
> +		num_lut_entries = min_t(u32, CFR_MAX_LUT_ENTRIES, db_cap.min_elem);
> +		cfr->lut = kcalloc(num_lut_entries, sizeof(*cfr->lut),
> +				   GFP_KERNEL);
> +		if (!cfr->lut) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		ret = ath11k_cfr_ring_alloc(ar, &db_cap);
> +		if (ret) {
> +			ath11k_warn(ab, "failed to init cfr ring for pdev %d: %d\n",
> +				    i, ret);
> +			goto err;

you need to free lut before jumping to error handling

> +		}
> +
> +		cfr->lut_num = num_lut_entries;
> +	}
> +
> +	return 0;
> +
> +err:
> +	for (i = i - 1; i >= 0; i--) {
> +		ar = ab->pdevs[i].ar;
> +		cfr = &ar->cfr;
> +
> +		ath11k_cfr_ring_free(ar);
> +
> +		spin_lock_bh(&cfr->lut_lock);
> +		kfree(cfr->lut);
> +		cfr->lut = NULL;
> +		spin_unlock_bh(&cfr->lut_lock);
> +	}
> +	return ret;
> +}

