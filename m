Return-Path: <linux-kernel+bounces-737203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E73EB0A917
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3BC3A6DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B95A2E7198;
	Fri, 18 Jul 2025 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BhVQL7bg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1497C2E716D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858586; cv=none; b=BrvCgqYXGnhaKKS2+k7gxxOoDnJeYcNUhYhFL2dXNaLTFs1/Z9QPnPHJatXDd+DXysqK7Jwz6APzoiPUpbL+aL+4PiFbDg0we39bbTumplN+oiqEkP4zCOxyRyR1ee/XbZzHYN+zXXWbx6m7e0LKGdLvDMbH3kJCzofAYQuyNOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858586; c=relaxed/simple;
	bh=7jRgCSNtMJ+4XBY+7GdkIf+b0OTtc3sZXlxYI5FwFc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFiVyb3j5SIeCLZDtY9tbqAY2Mse+qtR6byhW2Ttimy5eZp0+Bd4Ecq6Nk/73Q1LgRVsauIN8yPh7oWsX9Aigp+IZcjdTIVHZ5SOYEpokgEoDvXzxJKoKA/s6L9prluLKpuHB4g5IWqAfDNCst65qKEOSsXwxvOP30XQy3GS2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BhVQL7bg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IG6Ylk032365
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MvWIjxTgsWqTg+EpU1jF6w7w0dCuZOGk2IF4h2JIZKw=; b=BhVQL7bg08dH1Lyy
	sCNahyhXgLOooPUk6k8lhKr8X6uJk+1Pa2UywOtv1yU1ysnUtDgNZt4yqdpLZuE+
	K0tv2dxCzW6dvx8A4AAJj193IuREjeMHuDLlmtdnunNxuIVo2SkVCir+j0RyVX/M
	DYLgDAHww3n9z70tbq466VWkBPIVGCMhK+FGx8MfhiEBU9WEbLjFPgNtruQac7W4
	H0ncRaq33YzE0XB6rSNXGqFRZcmgcu5MhyjlXY0V7iyZJUiP7XPWZL0Oj9dh/qRa
	WzKiISQhUKpSQuddWBkeXHQ2hpidzoxFHYU6x5T5fvEiwFh+6mY2YvQkzlkNqfQh
	hbR8bA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug38chrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:09:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2369261224bso23969355ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752858583; x=1753463383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvWIjxTgsWqTg+EpU1jF6w7w0dCuZOGk2IF4h2JIZKw=;
        b=nnslDXYDU83qXtIx07p8oCXv7x1/pkKvbqlTlqTDqL2XU7pxJXoEGMAHtk+U8bfXtW
         gmAcgHxEn/8qeSmG6/R3OF8vImQSBv16R85Fe0/eC++c6KBh0hI4XUyBSd2o5DGD+lIu
         EpsgHKRmdq7MuRu8pV6DROlwlmI+wXRyyWu2kC98j/v7hb1G8X3AZPVxf43DGjPnfPaB
         UXFHh5pRq5pv/LxL8mj3OQO30STCCyMRas2vjsTPJ9K/jNEdrWNqRveFewfWSwcV5X+e
         tYQNHLHM9zzi8CiVucuWaLy71/L3BSeTWhmssJ045xYkAXybcxKZllsELV7uYhDGki+s
         rRDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo1ldQY9fp4JYPPeDoOcUgw78xnyTbtM4gp1FQM7d/5l61mLCJAk2HMIk/3XZhwDpg3yIJjxOFMz0ti+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLXBuHy4g89LYXNvBBJw4HToJpKqE54nK6co6WTN91GxAOoToM
	mqGqk5k9FHiBWwko0aGKdOBO2SW33DDu6sbJJhmIAnbilLmO7Ew44hvf32xOcf6LNSX6hT7AFYQ
	787s3+/32lL7zuGlHxCAXnH8Ag5s3hNKAVjCPi43MIYu/eN1/32LaCVlIBbCTcavwmac=
X-Gm-Gg: ASbGncv79tyFZfO6IisxeOw3xEjDplsm77aMcPhiZG/kiYM7pYK8WN9lBa2bs8IxZqR
	ctk87R2tcaVbIoML3ATJtFQ55ofCJ27ZxVFubzIpbIAf0dtLC8OhxPE0xZDZRwAKCae8gdAzzVd
	o+ljs1VefeT2oK/MoahdWfsa/tq1JG76mqtzNpc5+cqGdU5Z+A5PVGjBL5hUK1dZeBhYjJVlXuL
	hp3WfuiMFw7GbX51Pluc2kLFnYnBBT8yJHAHaFyZ2C7pzAZOm5J09JzzzU64VILdqBrn3xahPjN
	3QSlGdnjZI/Kx4GId3l+csYibse8lvA2URoyghXSXn+mmlZAwMtZtPmmNylEi/Fg8PH966XGOJe
	wkmk7EyffCsOQqw==
X-Received: by 2002:a17:902:c40a:b0:235:1706:1fe7 with SMTP id d9443c01a7336-23e25693727mr159582635ad.4.1752858577931;
        Fri, 18 Jul 2025 10:09:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETvEp5rZykda6Fkwq9ZXpRv9woHFJ3xh4GKGF4HzLDjXZN+/v8QGQrNtiX8DgvikLdgkWCIA==
X-Received: by 2002:a17:902:c40a:b0:235:1706:1fe7 with SMTP id d9443c01a7336-23e25693727mr159582215ad.4.1752858577500;
        Fri, 18 Jul 2025 10:09:37 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b60ec88sm16079385ad.65.2025.07.18.10.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 10:09:37 -0700 (PDT)
Message-ID: <b7653a05-f747-4764-9c33-793346cae223@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 11:09:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/10] accel/rocket: Add registers header
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Daniel Stone <daniel@fooishbar.org>, Da Xue <da@libre.computer>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Robert Foss <rfoss@kernel.org>
References: <20250713-6-10-rocket-v8-0-64fa3115e910@tomeuvizoso.net>
 <20250713-6-10-rocket-v8-1-64fa3115e910@tomeuvizoso.net>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250713-6-10-rocket-v8-1-64fa3115e910@tomeuvizoso.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzNSBTYWx0ZWRfX7NWYjxhK+zqe
 ikdYKVMz3QNUbXmxzE+FUh/m5fWPuqGsjjl2097EHVK51h+hw8nnd+QGnZAiXwfUTY+JZUcPuL7
 CAKXsCEtmdfGjcxnqtv4fLI5Y7YppI7Fx+hc/W8uwn/P4xdjUnRY5v4PDY9OrgGocC09bHyqevq
 3fAwezpecRPGpUcY6E/npv+42XX6sRxpw3+sg3FKl8l/ePdHpcjR2kKLNnXjca/dbBRLzjFFSpl
 Zcp4YKl7Fcy1/KrRW/DDZmRWT11LH7YtFr0y0yeYWhOjJ4+Y+x14BWfGyj779zwrVZEVcBeklak
 UNN4HwXRIGjMkJBfiqS8Uf5KTJ3u1wqnUDNzCFjAoWMsy+OIbKljC4At3XoHz4SQrGBHgXVoHrN
 E2l5MBwl+yWavTd2vKkdtPL5s5Km9TU+6+46sxHQLYPgsns49dn1FrSDFWaOe1a/R5qSiOqz
X-Proofpoint-GUID: WACNh93KO1MnAIE8g5tMuv_TtVivvmvf
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=687a7fd8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=DISFzqtZAAAA:8
 a=EUspDBNiAAAA:8 a=4Ppn7do-3_l0xiadvqUA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=aug85vrO5LANNmmtkfAW:22
X-Proofpoint-ORIG-GUID: WACNh93KO1MnAIE8g5tMuv_TtVivvmvf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=811 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180135

On 7/13/2025 2:38 AM, Tomeu Vizoso wrote:
> A XML file was generated with the data from the TRM, and then this
> header was generated from it.
> 
> The canonical location for the XML file is the Mesa3D repository.
> 
> v3:
> - Make use of GPL-2.0-only for the copyright notice (Jeff Hugo)
> 
> v8:
> - Remove full MIT license blob, to match other files with the same
>    licensing arrangement in the kernel
> 
> Reviewed-by: Robert Foss <rfoss@kernel.org>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

Structure of the file and markings look sane. I'm not familiar with the 
hardware specifics, so the autogenerated content is a bit over my head, 
but I guess for something so large using automated generation should 
minimize errors.

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

