Return-Path: <linux-kernel+bounces-885632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA8BC338D2
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 01:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB373AB0BB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C73F23D29F;
	Wed,  5 Nov 2025 00:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GfDnKDcm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jkzWBslU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEABC23ABB0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303938; cv=none; b=m3JntE0JNQHrRirsOccJHEARcRwyZjofmRaF5i1gbmKqy08gq9XzmEmhpUvStJLxyTLEvEoi4UhlNx1h3OKykV2Hy5Kfqyk54UCSHQxYvFF8Ck8ZZCmXxQC6pIit+4PONyZ5cbpWvl97TNn32D0HoL9tZ9wNZrwPTAW4nXMQgp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303938; c=relaxed/simple;
	bh=aXaS20XfOO0yOYPDtdD/ohFBCnm7CTzrYLH2xYcxTmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HE6mhbBQqqoo2g6CAapApMLESdmlBaCcCxUCCdcdrlvI1xBWpILDNwYddUfL83fs0ZOVDMo47gvUYUf1ZHOUrXW670glKM0EZhb9sRFNYCkSMGGMtCEPzSzrlp1A6uuVd9CyG8a+D5dGmy+NNFK8JB/0OwHYDbIgCckqiwqehTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GfDnKDcm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jkzWBslU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Kftpl2967375
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 00:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mF+cLKKVRQFP3GvNceM/xWFx
	mZNCdYIyW4EQECMmO9I=; b=GfDnKDcmJbgEjVa1R/Xi+95GqnRXT7sVjR2jfZIN
	Fqc/jht0INTlofOpx+e4LJlUoiI1KbPU/iViAXvdmmcPcEtlAgdaix2pFl749Y5i
	Gqtntd8ZRhkHEpuDHWdfegIPe63fJBVO9sKlhqOUWGXhyf25o+lnvZw1Duz3rmDs
	pGluoIET4yW2TdnZb4sXhZbjDyO3jc1rjJriVDVOFGYD4k+DZ6ph6Bb5wX/ltIcT
	hCqKqRzCIJn9Juvv/LietW0Edeha8xrOzH6kXvURaXOLrC1+Ub19y8rcagLPVab4
	m3vMNetuG2Py8zVt7gcTR2kgXG9pCbM3duI3XggfTycvRg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7heaj2yy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:52:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4eba1cea10dso225239661cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762303934; x=1762908734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mF+cLKKVRQFP3GvNceM/xWFxmZNCdYIyW4EQECMmO9I=;
        b=jkzWBslUX0LewY2Qh9e4baptnblSZ4lGXzsPPujRSiVGyp4fBvkwTUJKBnBuDCJmxb
         rlKNRrAU6Zin8wgLN59dxYV/XBHRVb+vgOG7vpmKfoIOP6dWVkgSVucLpbzZDO8EFtJB
         Nth2J3bZurDYq7c3mNp07Flgw3EYzPKtCGmI2vk1vcPwAVwbNJY61V8K+tsvqfH8Iuyg
         KtJeq5sUyZ7Tw8tlQnom3w6G0DTMcR3L8eaMsHj/JOxjI1okCpjWRFQCLOjyNeT5ztd+
         c/ivPyT+7lriLausyS7Gy5pfF0/HthhpQbfq3mqt5OeTQGNSz7ss0Q4PGkDJVZrv5HYo
         +p0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762303934; x=1762908734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mF+cLKKVRQFP3GvNceM/xWFxmZNCdYIyW4EQECMmO9I=;
        b=mcRWm+B7VMFKygn2+Dt9EmVLX6Q6OLJNtTTMRX6BSD1/6ZU7GQwvt6TgVSg6INTOjR
         MaECeb93utDME7wkUONVYnJGon82LFjEXRUGItMsVcSabtAXwXO1M2bTQc8XhQZMAZn+
         jjHRkL71t+srcogoWumYgPEurf3zfm/8oFqHBuyrIFDdEsRQbdN5/tCjC1QvAGDQBfu2
         wGuemOnJ3ZH8fG830ju8uIDF41zK7xpXOQ/QqtCqdAwwPCbiw2VERyBDBSwlnoMFOHsB
         nTLzw4Sxx8o2m/hO8DT36dFA8plLdvgROBAJhHFb5CIRjT/pAWi7EEU9ArSHGrWT/l0p
         01mw==
X-Forwarded-Encrypted: i=1; AJvYcCXHSVg9cMsuSYzgdYuZCLxPcgLeW6V1Mifv5VIJWDuxQuZ9kBQfy2bJOdmGVFLV5iBAIHzY6S2tr1SMPZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YywJHOwI6ZMpqZftw64gDM8QaP/lt4Ay2one/mIHc2PAeFKz2xk
	PxQ2DoZ1RZN5a7veWkis7iddKGCEaF4rFa4BoEHi45sGOKQWY5lfEWDYxzwbK63amKCbx08HjOL
	VPwoS+8pdx3X1U/LMJwj9OYfl6WaIC2Fd0Mf8DC5UoAJKXYf3pr3i7Y4JY7Fl4mYaODA=
X-Gm-Gg: ASbGncscqON3VK6PMxv3UKuHAFnFSSF6cLUEOlwn7vUgVVsffnicWh7W+wovD/PAhgq
	f3JT1E/vWDZwFcjotlYBgXWVMRAs4HZ/dfCmEUQ1ALdzC/WSde1r172cU4D6/dePIQVUYX22Rxu
	zn29+qGZqtUvpsz2fC49wf2UehZljRpSwMgSLcjKF/jGmuyNY+uT1P1nsF8HO89TAyBX4jFYjVb
	0sEI4mJsdvpb6rnL26jMZn5s/zvW0qf7EMHXAn1Rn9svhQ9ZyHJCRTKTD5pqX8XinHrr5eYCth7
	BVfRH3IZ5p7Drgp0JiKvr7To31Nto1i9oRVVw0KK72chNldrNASC/cPMrQarXjX5V6r1geuaaX9
	VB0gJgPTYfDy2spXYboFX+tfNUQB+UqW/GanqvfP7UPJ8LuF4P2g+TgWDc3sq0WyxO+bfmmBtd2
	Ux8do6xg3Cxlu2
X-Received: by 2002:a05:622a:50c:b0:4dd:2916:7980 with SMTP id d75a77b69052e-4ed723300demr20380871cf.2.1762303934240;
        Tue, 04 Nov 2025 16:52:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEW0DgYaDDDgZj+/uKyzHvi8EHOj7DGy29ph+Uz3G6jt85XoV7F46z+h4bslY5sXRqHQFhVIQ==
X-Received: by 2002:a05:622a:50c:b0:4dd:2916:7980 with SMTP id d75a77b69052e-4ed723300demr20380661cf.2.1762303933833;
        Tue, 04 Nov 2025 16:52:13 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5943443db87sm1187433e87.52.2025.11.04.16.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 16:52:13 -0800 (PST)
Date: Wed, 5 Nov 2025 02:52:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add Akhil as a reviewer for the Adreno
 driver
Message-ID: <icgutv7idot4h2fqx5iwhghty6h3gtqcsp5vbdgtw6jwjliy2f@536e2qcqpzmq>
References: <20251104220245.240480-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104220245.240480-1-robin.clark@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=GekaXAXL c=1 sm=1 tr=0 ts=690a9fbf cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=V8cJkdWAq56nonIdhLQA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAwNSBTYWx0ZWRfX8+ndTCCEJjar
 gvdnTNOb+wq8n1NH5gWV3IdBj+EVqp1ELUxl33SHqyFTWGjToHygvliIaSgi/8D5hcCCfjeffPp
 qWSB8Jemv0ZzziQzopS0Ftx/2OcpiOONfmYp6x1N7MuQQlkwcjB1zxFPFEJK2paER5DGR//MUay
 orttGFQ3gdZmSPOxC3m94PsJg9ThQPhK3xh08Of+Z78TmZaeQZlXjgi7oREJIixbgVSu/DlqVTs
 fveD8VokDy3UVJAjV4kOLjp9Sqe4K2oqN1RJjidakryI5t7aptml3sb4sWcq+3lAEBy1hlywV4+
 Dvvz7GAymLliQescskrZVH7BfIrqKJmbJiuxL8r24wwRsSvyFVEenolhPOYd9//4tP4gtA4Vx5+
 kir/9p41+tWI2CbuM17X3tyt6uxcjw==
X-Proofpoint-GUID: 9nepnVhBG4XUEaKU6vhP43vhu1-lqbl1
X-Proofpoint-ORIG-GUID: 9nepnVhBG4XUEaKU6vhP43vhu1-lqbl1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050005

On Tue, Nov 04, 2025 at 02:02:45PM -0800, Rob Clark wrote:
> Akhil should be getting tagged to review GPU patches.
> 
> Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

