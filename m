Return-Path: <linux-kernel+bounces-789313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC3FB393CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB6357B1B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65021272E75;
	Thu, 28 Aug 2025 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SqmU7GkQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FDC2192E3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362742; cv=none; b=NgC5EZ5+JqSSrL8meMRZJR92JZ+az6MnlUTkBxdeAKp+MSayGpIXNlzRlUgZuafUJ0nH9S0Dt5x9es1h2eWEI9E5I1YWw/uGiCZgxXx75hm2DGbfNYbNgOMOJv8Fc+cUu3hOFQxs8SDEtz/kkS5cT6X/JnNvu8l5hYMDuRgj73g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362742; c=relaxed/simple;
	bh=Q2021Pe34K0Sr8t6+35XLrrYTx646DxiOfOHLWWB3DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6wNZmqEilE2wB4RLKIABQWl9CGBblOkNYnH2JTFFlg1yassOks6VuGUPK9nXn3pm1TwgD5LfPY9joOKrIVTGO+/jDyEMPL1rrsX/o01lpa0M0kSYwJLs2WXwbR96Trlg0cFHOgA20QH9U/g9t9txc8W7yrV6iv2NawjvvkHBlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SqmU7GkQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5T0fg031340
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zTj1+Lvk1yn7ZHBLETS3UVFva4Pjn5rnBY/gKCJ4AmA=; b=SqmU7GkQ91YJIPT7
	FinQAMTtWqPHkC19SvuTZDsfCeDlJqvHUKpyvkzqrHkI8lJ4MoMjwJx5yMu1aGGM
	XIWitkwKvEj7ACIhewAAv6iv9Oky0OSeWZPCTCgMP8HKxQYryXNuTvsbvWNCDkB1
	MgCme5Lhba4cm94HCt8Zhsjkh7PQVVZPVIQkm9+PwqeUKazzuHvSBgtcP7Wu6COA
	ga0E/igxbnDiSVHbqovEERKIspBIG9jE7t9ywvIandIgNGZ32XdW/ul7alQCfMVo
	xczpNuV+ahkVqT883jKV6bkpEiOz7CVFGceABSrFRx/xLtMofvD4TfR9qdMydzMu
	6XTh/A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615q350-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:32:18 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-325ce108e45so651093a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 23:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756362737; x=1756967537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTj1+Lvk1yn7ZHBLETS3UVFva4Pjn5rnBY/gKCJ4AmA=;
        b=FnZns3nMY2qhoY6LnGt5ENUqRmd5N51kgDVE6RC0vqH9Yf08wkN3LnhNu66kKfTxGW
         viLmc1TCSfyLZSljHdCcTJhnmtXMsBhHuFTeSC5D23PEZ3SzkCt8B+9Yikc8TvJq7nfN
         11xvVpG0w6d1FTt+j6MRISwbadQ3xWgeA/Dty6tFlJnVC8FxD4xb39jLZ2pnH4Qk5aj4
         pbX30n47RGAztVS1WOzRUc0WpsBXof2uOvFzVS6RJg/V1RkQlizrjorHi4v6SnEYdBRw
         pLuEM6vycXMYTEKbuZRo9yxRraLs6gbVKu34VQAnVIsL9gy4XuJys4X30aBjbmkx/mdN
         Ug8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGS0NDRlkPXou5PNooZji6s+eKbiVwnRbRKP74J8um7MpdOB3uuRT8+6TvRukuoHVbZqxSa+QWhE5GUyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzekbVMAz/AX+aLZ9e0LA7JXeZH92GCiXw2tWSo18GjKL1O5wC
	up+OH1uEbWWocCkQlmRUGDuLhvMN6Ir+YMaMxGgJf96CIdP6JytORwqQgcmKCsCrfETUesNzmrg
	5cUNaI+tzbuYKxY2Dbpop43U/wgCBrXpYqDlEk3k+B5mAtxRx7R3hvsCbpbMtnvnhvKU=
X-Gm-Gg: ASbGncv4E6J4rgvSTfTyyNo8LQlWtpaRMNJJSkvhoICKIagKCAX1p60dXnqsxGibWzD
	2j2/F+A7zWxHB2XVH4W9yc3bmPlGwdIuGNrBMOR3Xs/dUcbPQcfSKek0Ly/QAOOtTSTkXz2Gm+Z
	VKMgkaVjC5QkwFPFOzMkylaAoIxQMtC1xE7nibHEcElKMrnkdfDGQmX3XrU+pNd32K9ltiCL20A
	1H71ex5pRFihDLzeUTn9Q6hlP3s3eSqOkdHOUit30hBvdYEYsz6yj58/yKjpKni7iSPYU4DBRwC
	GexdPJnzDhfY1SkiayD020emUbSTJ9Cm3hZ+D4cosMeSOxULyY1m0UCx6DR3nB5mSvsnfzuq8OC
	0j6MmX8hUn1wUP14ZheQv54Y0iI7G3TYMsoaiqA==
X-Received: by 2002:a17:90b:5246:b0:321:82a0:fe50 with SMTP id 98e67ed59e1d1-3275085dabemr10058706a91.5.1756362737240;
        Wed, 27 Aug 2025 23:32:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzi0sS96jT+LA7Vd4RQyv9GmttL0b1pHYtJpEfUGzXSzx0mdrwZTiyymIqRanTlSNCHIuSdg==
X-Received: by 2002:a17:90b:5246:b0:321:82a0:fe50 with SMTP id 98e67ed59e1d1-3275085dabemr10058660a91.5.1756362736751;
        Wed, 27 Aug 2025 23:32:16 -0700 (PDT)
Received: from [10.133.33.184] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f59e29csm4065656a91.12.2025.08.27.23.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 23:32:16 -0700 (PDT)
Message-ID: <ceee4a15-b31b-4c8c-9a8f-7093b85f99cf@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 14:32:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: is dma_mapping_error() check necessary for
 dma_alloc_noncoherent()?
To: Christoph Hellwig <hch@infradead.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jeff Johnson <jjohnson@kernel.org>, iommu@lists.linux.dev,
        "linux-kernel@vger.kernel.org >> linux-kernel"
 <linux-kernel@vger.kernel.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <ff6c1fe6-820f-4e58-8395-df06aa91706c@oss.qualcomm.com>
 <aK60Py3r25U43k1E@infradead.org>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <aK60Py3r25U43k1E@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX2ZMoaYa58Vi3
 Ji2MDTsxRxmpbMzWlVnGlu/ZXMIS1MTp8UYiJyxdglwXWpu2M2RXvMlmZUkSGI+P/b90RXMY4l7
 pkqY3Wf6SeZDEeabtS9lhNGsIHmibIic6VBLgT4pKoJnCR83HIXk06Srw4QPhv1BLLWofTtkbjY
 3TmmqwVH2G+Ynm0S0MY7BQ5kiI35f7F4ubuZU7pBfJiJybZaCBAN3tFqvo+R0RMXN0eqy1f4BT9
 WesGHzg9GvsauNJn9Rnv5Pd+GuzR9oNn4mg8PK4hi3eXh3nOmkeOQcVOxorfRdI5MmfZ51sAYpp
 OQJBKepO2d8Q4hwjrn1sBn+xUjszUNToXFONqU0SZd+Ud3v1H1qBYYBIaEohVos/ncn18BPXLUk
 refK0uM2
X-Proofpoint-GUID: FvOgC4M_4wP9cYJI4B13XnCUD-l4ZSyq
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68aff7f2 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=d_vTzFHel96VW_NBT_kA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: FvOgC4M_4wP9cYJI4B13XnCUD-l4ZSyq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034



On 8/27/2025 3:31 PM, Christoph Hellwig wrote:
> On Tue, Aug 26, 2025 at 05:44:42PM +0800, Baochen Qiang wrote:
>> Checking code gives me the impression that I should do dma_mapping_error() check as well.
>> And indeed with below diff the warning is gone:
>>
>> +       dma_mapping_error(ab->dev, paddr);
>>
>> However this does not make sense to me since IMO testing the CPU address is good enough, I
>> can not imagine a valid case where DMA alloc/map fails while returning a valid CPU
>> address, no?
> 
> Yes, this doesn't make sense.  dma_mapping_error exists to provide a
> error handling path for dma_map_*, which return the dma address only.
> 
> For the dma_alloc_* interfaces that return a pointer and can signal
> with a NULL return it should not be needed and dma-debug needs to
> be fixed.
> 
>> If I was right, should we remove invocation to debug_dma_map_page() in dma_alloc_pages()?
>>
> 
> That allocation still needs to be tracked, so it can't just be removed
> but needs to be changed to record the kind of allocation.

Thanks, I will submit a patch to fix this.


