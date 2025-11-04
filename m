Return-Path: <linux-kernel+bounces-884635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F54AC30A01
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A1918C1D3E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21F12E03EC;
	Tue,  4 Nov 2025 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eef/FjtS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GIAmqPjd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABDE2D9EC7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253844; cv=none; b=aGfGZ4O5QYYx898bs+YHN31W1/u5WXOl4k4dHKR+7vgZghH2Jh3pVI8eY7Rk85zuSN6F7eF/N1WXlFwHK0iknK24LA67DUFTGJaDUqKyyZJDiKpzqKnpoRO3SD29OzbYYHAx68lubxnDme7Zqv/o3d5iZJT0hOhDIwiAXK6+jL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253844; c=relaxed/simple;
	bh=xD40Qn7ySb+G4ifOmdQ3plBa87zSBnrJ9YWsryZpG9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CW6au6eoiRNKBdsdiPsgf7kgloeV+e3Ur9U2DKaoDYSAz6GpDPwRqIL06kzFXJq4fTCzC+4ilODFtnoHhSafwhpLobDf5BLNbqA8YDMYtuw3rMnDMfLQyICZu4MKWDchbHjGRw5AMX8vIA+ibD2geShYMSiGDSyqlEYzAM2ii5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Eef/FjtS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GIAmqPjd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48gboA1458885
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 10:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	17iSZ0rQq9YOzSnIopSJVXFyQroZzaAj5ZsSQQp9i8A=; b=Eef/FjtSWHTDe0pl
	nB9UI/jxuKZvowzXTbsRmCAI07UniPq/9bJ2pFTZDTGO6wc0Xqb7mAk7FxQP4HfU
	RffICIUjQ6IkcOX9PsakdnXepvGebd1VQa1PXawQt9Ii5eOpB0f94Qju87IZBpzU
	+B3dEy+jqRrUpsJ1RPtLVwPrCyoYKXYWYah9Z6YJNrzy7FiBxrAu4tL+E4/w3Kwh
	9iXqhsXxY7xESbNpGA/t3b0Y65ESGDIFbWPJ7YBVvwYbzWfNI7gNrTGj7MnPBKJ/
	kjCq0KEsA10Dw+kyzkNCG7BgjdH/YHXD+ymBYE87Uah9WvqDTw0iWCM5NVtshkwZ
	+xbyiQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70geamwp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:57:21 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a28961ab86so4535756b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762253841; x=1762858641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17iSZ0rQq9YOzSnIopSJVXFyQroZzaAj5ZsSQQp9i8A=;
        b=GIAmqPjdwnEfc86Vv+d9dAtSN7A6DCWL5G/sOVYLaZK25Qx12KkStQH9Bi6Ol2iETq
         ULCj+WktHw2Xw6QO4N/XAYSIyN5618VkxW4VUqLJAZrCLBru/VPKdmERrJVwrL6hkZSL
         DZ1vEggZ8B/HHA+QCubpPtQyg2bVLCia8HUmkAGdPmcCWfAmWTOg0JGBWirYTeO/0wax
         QChk5i3tfliS2dzGCUQMGaruVCJAWoe/XWX1AwdVm8UjjHNQFsSXTlIxV9mHOFRu4Akv
         NHlcOH8R+P7oXJ1kfZgN0uXQEja7rNA6OtMgxbnRJFAuCnMVffdpivjrnsQNkASj837A
         szRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762253841; x=1762858641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17iSZ0rQq9YOzSnIopSJVXFyQroZzaAj5ZsSQQp9i8A=;
        b=AM4RsCskLNfaQhtI+3jWTT7/2d6KVIRKj/0SFiSmaPrB/Ita2GS2bu3SUhzYGyKPPn
         PiSA4gaGX/fOnrwZDXoJ91zLR9ICOwT/L+08Fyxhjlr/lasfMV036Gv+Lsy6q/ky0GmQ
         JVPmHEl5l9GuLrRW2k7/FnElePIhkzTtEvdIrRZHiipwHhs4+PwBVaS0yBOGhL3eZozY
         OFPzPkoJVk+YiNjbov9u2GSTp4SgN0kzJqtEZmzCKBp9jJe8yGi/0wMF23OfEpEmXzEe
         gB9dI+yve++JpJrM4fivlfDAYFZPR58PAjRr78IZ0qxRyzctd0Qwudf1cqM7aIyGEzvf
         jDcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkdZIPJt6ISHRIQNeyzVHYlP+uaPfBO+lTKbhachaPSKsV3Qw0w41tw+7UE/5rsP41egChjo8afRurVz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj0AaFh7StclHIW3t7AWi+DUY8STi4opUnkHkuZEKAM12XEnRI
	70aUf6+d7h0T6tmfCtXje6aa9tsY1NlV16UajVadIpNt91EyOj/SMN08ineuVW2hyMM6/5VU3JD
	REC2Vk8jLiMF6AiOuoTCOE8TlpsqbqR64rf9Ralbuv1O2G5aGVD+fwWCTC5x4DkxZSK0=
X-Gm-Gg: ASbGncvSaUIalyOlAbiovRPfFM3/XdxXd+1Nte1ZVnc9Y0vusmiWAHb9HAn6RTgPWP0
	CFHi7/ddrx99KkFL6i/C4E1qb/T0UqFxPRFz2fcbiWHQSvAO/X/xJa70k+5h5Rriw3GrG4KN73G
	aIi642820zqEiEQaliX3bm1lCI/tb8h/4IvZHQrjw5KgOCnfykHdMuIk12FnSN+t71ocqiOcmI4
	itspVso9JPnK8ksHn/DrYjOjV2LLOfMNGT7vCplQ1qBQOsOqnEGawzCI+3ySHRc6PXA5hnAXgFb
	UOFWkrRID1JlHzf7lv7KZP/RZj07ltMuYNt0H0C383deFP5jOiMGmMDWZIueqIOYR8Kiil14zAD
	lVghL9rsjP6RVDQ5LMLAvKH+9a+U=
X-Received: by 2002:a05:6a00:28cb:b0:7aa:4b8:179 with SMTP id d2e1a72fcca58-7aa04b80436mr8377818b3a.1.1762253841078;
        Tue, 04 Nov 2025 02:57:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHeauPRKvSaQfwjZoWhPXPVkD5UEZgsLll5lxQv70Owt2nEGVc1ASjz7ivNXbz+Pbfiny4nw==
X-Received: by 2002:a05:6a00:28cb:b0:7aa:4b8:179 with SMTP id d2e1a72fcca58-7aa04b80436mr8377780b3a.1.1762253840541;
        Tue, 04 Nov 2025 02:57:20 -0800 (PST)
Received: from [10.219.56.14] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd382ad96sm2563399b3a.22.2025.11.04.02.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 02:57:20 -0800 (PST)
Message-ID: <2dd128f2-d41f-4eda-a393-260098749a07@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 16:27:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] of: add infra to parse iommu-map per IOMMU cell count
To: kernel test robot <lkp@intel.com>, robin.murphy@arm.com, will@kernel.org,
        joro@8bytes.org, robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
        saravanak@google.com, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <74d4ddf90c0fb485fda1feec5116dc38e5fd23cf.1762235099.git.charan.kalla@oss.qualcomm.com>
 <202511041853.IxYgvWlc-lkp@intel.com>
Content-Language: en-US
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
In-Reply-To: <202511041853.IxYgvWlc-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YsZd25J5C4rvm5wHVGvShfEEA5fc4DKR
X-Authority-Analysis: v=2.4 cv=bqBBxUai c=1 sm=1 tr=0 ts=6909dc11 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yE59AjuNBYSqEwnZTzMA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA5MCBTYWx0ZWRfX3DfA4TQoFTF0
 6zHJYd0mD4589Nnjm3t0Et0kRaghAFmoDjOo9fucKh/awN0T0W/YgqkE5Vi/D6lxorBFQ4wN3qb
 vmClMc6FAvgRiCg56IR9G8c8Rhsz/l/06smSTneyOrH7B96fz+9UZLI0f25P/PisrrjloMUuvzk
 vK39Nnmt47go0XGVTItTRRPfGTfd/njfPe1rszYgW3kWegWI5cMkhqGsTpACOnPYV6K/Biz40EZ
 /5HkH/pWJKxnciZBvucpjwHVwlm6HsFCOQzAQA4uSBKS4guNl6Pt9jNLHADhujf1J2F3FdhGdSc
 pAptfkZcV2ng4RTCDyBNGPtYXBoHt0v3KHXP03hEq48PditEl/wNdm8KuVWU5lUAiw0Xx7PrjZF
 /YGO9teq2UvCvrALBUlic+2v4Rzy7A==
X-Proofpoint-GUID: YsZd25J5C4rvm5wHVGvShfEEA5fc4DKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040090



On 11/4/2025 4:16 PM, kernel test robot wrote:
>>> drivers/of/base.c:2127:6: warning: variable 'legacy_iommu_cells' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>     2127 |         if (map_len % 4 != 0)
>          |             ^~~~~~~~~~~~~~~~
>    drivers/of/base.c:2130:9: note: uninitialized use occurs here
>     2130 |         return legacy_iommu_cells ? : of_iommu_map_id_actual_cell_count(map, map_len, cells);
>          |                ^~~~~~~~~~~~~~~~~~
>    drivers/of/base.c:2127:2: note: remove the 'if' if its condition is always true
>     2127 |         if (map_len % 4 != 0)
>          |         ^~~~~~~~~~~~~~~~~~~~~
>     2128 |                 legacy_iommu_cells = of_iommu_map_id_legacy_cell_count(map, map_len);
>    drivers/of/base.c:2125:24: note: initialize the variable 'legacy_iommu_cells' to silence this warning
>     2125 |         u32 legacy_iommu_cells;
>          |                               ^
>          |                                = 0
>    1 warning generated.
Will wait for additional comments and take care of this in the next spin.

