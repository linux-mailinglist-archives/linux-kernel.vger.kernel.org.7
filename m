Return-Path: <linux-kernel+bounces-732811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71315B06C55
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09D856117C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4C81D47B4;
	Wed, 16 Jul 2025 03:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="njHT6tqO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB491D63C2
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752637014; cv=none; b=s3xhxIdB7+545YAbHAjqLtgXoUZPKMsh2aA9LsfGS/gDW+vW8DwTOcOMAzfVOQqXqohe/Ag+d6BPYMjhUjd+IqbtMHv/Jm90LuJbQHOQIJ44HeXwWJ1Ff2YdEG/wvWSO78kbM4R6qqs7O6LLjtKXX6g3+OaMFKZZIRL6QGErSuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752637014; c=relaxed/simple;
	bh=5uBxKQcRMq7FuUbLA04O+2zy9ZBIDYXotnLF7dcFbFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqaLoHmrSlpsVORji5FcrmP4XCaWoGSoMlkmjO9ULZ0eV4l17gWyhDO4tnpvyHbwgWymNbyodpjG8gFM50vSZc3wEB05L/SooHr1c1bR0hldqu9M00zrpcfb3J6vJlZqT01Btrcu3eVwAeYI24L4dPIIkfmZVkyjIcX1pOxwpKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=njHT6tqO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDN5w003467
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G77P3BAiQ9+JrIzTbcmKzyn82sbdg2M/vOIxw3VV4ec=; b=njHT6tqO0EHmcmux
	KDBWMbGIrbwUvGnj5uFNYPrNvqLM/rB6/s3cxutv7adJaINKRR4scDwInhAMBMZL
	YspqgDZiD4GGFFQ5FwyddnvNLSwOyv/2bnAfwl1dUwf13YCW7ifG7NH2A+tormxp
	LQC+NUGyoSjpgx1NqBPr+yFxiig9UwchmT41eXmZymJYkVxjjAFr4Dp9GV1In6In
	+z2/Zgz013RLwpyINmQtCDSKa3hBMp3POFgf9WrHgulJDfU0e6rOw4AZjgz3+STz
	DHfUT7CQX9ukZ56AVEMMoZlPqadcQYYpjC+ckFRReLp1U04irItrTqyCfmfWr3oH
	9pDdYQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5drn9js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:36:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23494a515e3so53886835ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752637011; x=1753241811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G77P3BAiQ9+JrIzTbcmKzyn82sbdg2M/vOIxw3VV4ec=;
        b=gK3/DHsaaaY4Mcu3V9Qgvsg5wu73a043hxe0DW1MbemmST6DBJqnUamanGD+M5nc9Z
         VkzAVU32FWm2kTmF5Wr67Z5Ed4hsSmVJ7YNXb4T/B0UH8cGGgnwdP5I409iS7BzbY6iH
         U8gOv+FNdYFhxbImarjPrcrcmFWneJliZU8V/XNErQxqNTVx3I4nw+wcsj9DwSUPlw7q
         5wV9qt4m4DouRQbgiOcgQCulNvDZ8XuwbsQd89CNuyiaU+fbOxuZ6qc6OKnSJ6CsBMcO
         hQ+XOR2kcKPvrarPuZzrDRTmb2kh9kNGpCSRbFAeoBK2YqcIv3FCSiL/8zt1/p80ihsc
         xKfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLcSr8zdseFtnVSsUpR9uxHQPgbjqW8Rcj8DmrPb+7WT56XtSiMxvxdUvRzBaifak2M6whfBWtG7Xx23M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqKAYfWJJeQHzn3YZ9h3ePHbNG31TgqxaKlRNRT9chRhUaSMJV
	cpZhxsivh8hhnggaPG2eocNtKxZyyD4mXDEGJj3DSP6vFXM7ygDUu6N4ivw3/cZdhbmSsFlVqjD
	Tly8WLnvwiUh+SZkRJszx38XplhjQZGCL1RIIw+YopugSMCa13Do5E9LYqF9yQTYg9Y4=
X-Gm-Gg: ASbGncsEYL4sM2NLlhp6iVpU2+EOX5EEXo2UxORTwWxRlrYVLSlJJBvOvEWLAiagxWW
	YgXhQJRVK81h5/MFy0dZkIKVtJ42fbynD+DNdv41XqRgEJaDyaRLoWdt2jD1OwY647+BVUuqoia
	JQGGk8TevPli4aSRlrvHoGvXWDX7PN8pGSYh8PbKE7ZarnNLb+cfCG5Nb6zU+S/xHHcLex/t5TN
	JN3QJ+W9sJ5ABt2Z74rRZL2mEPSMDjz/ZC5+OdNGQixoyhdsFcFEkSUqaiOJYos91DLqxd9toBs
	MdGpgOudIecsEliO4cmFu257aETPjYBKMLeyUVYu8Vc3YKgrnlJPG2AHCalfHcA/Kdd6jFVeg3d
	pDwu26OOh9DoDcc7Y/r3UkvccszrmZCXM
X-Received: by 2002:a17:902:e74a:b0:223:653e:eb09 with SMTP id d9443c01a7336-23e24f363demr19174535ad.7.1752637011353;
        Tue, 15 Jul 2025 20:36:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+ZtNZV8XXqxRue5LR/rmeqC3k8eKrkmqjtuyqxnAf1b6vc2jc5Wwz/7sBQDCUzZ7rGc91qg==
X-Received: by 2002:a17:902:e74a:b0:223:653e:eb09 with SMTP id d9443c01a7336-23e24f363demr19174085ad.7.1752637010830;
        Tue, 15 Jul 2025 20:36:50 -0700 (PDT)
Received: from [10.133.33.219] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4289274sm116045285ad.43.2025.07.15.20.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 20:36:50 -0700 (PDT)
Message-ID: <bb1a5f3a-5ac0-434b-8da4-e43c996cfa30@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 11:36:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] bus: mhi: keep dma buffers through
 suspend/hibernation cycles
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Youssef Samir <quic_yabdulra@quicinc.com>,
        Matthew Leung <quic_mattleun@quicinc.com>,
        Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Kunwu Chan <chentao@kylinos.cn>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Yan Zhen <yanzhen@vivo.com>, Sujeev Dias <sdias@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
References: <20250715132509.2643305-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20250715132509.2643305-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KtbRV5BiivIlaDHayUU1QU7tPZOVE6oG
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=68771e54 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8
 a=hUY_jMkgKMZyhPis8EMA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: KtbRV5BiivIlaDHayUU1QU7tPZOVE6oG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAzMCBTYWx0ZWRfX3aORe5QlIKaA
 Ykf+dXVRB9e+NgUU1poBGLz+o+X0sTrOMek3oEex41yi/Rn1sBw8Q4fzfdE8Xn3oiypt10Eu+yH
 hlWpOWRNdrGXRv1ns3IdXsKhE5hTpq3bspXfmmQ+UWETccGB3I2pbPd8m9sqiBm60dJaMl8Wjps
 vW1TkhmMpOO/ojncqydbnHYdteWtl5noYz+Se/+bAGQWSEhadSrmX1asCW2Ta9TitxF0dqCEhjy
 YRezdE2Y4Luc1+13IyvcwOhInLFpjpcMQHtd5ktBLlp4NGMZUFdi2NjkOxvWnewplh/0Tarft96
 himGd29eSVcFpcrecqRrqjEpwMXrFD7YQB5iV33D0jNXtbYZlMHgOHuZvIW/rvMQt2TK2+CRxS7
 eQ/Hoa7897gQ+k9TSmABcbbK3w+61q+4sa6Bxywgt86H0r5l8SGR2OEk7Hr55gTBuEFtdjrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=763 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160030



On 7/15/2025 9:25 PM, Muhammad Usama Anjum wrote:
> When there is memory pressure during resume and no DMA memory is
> available, the ath11k driver fails to resume. The driver currently
> frees its DMA memory during suspend or hibernate, and attempts to
> re-allocate it during resume. However, if the DMA memory has been
> consumed by other software in the meantime, these allocations can
> fail, leading to critical failures in the WiFi driver. It has been
> reported [1].
> 
> Although I have recently fixed several instances [2] [3] to ensure
> DMA memory is not freed once allocated, we continue to receive
> reports of new failures.
> 
> In this series, 3 more such cases are being fixed. There are still
> some cases which I'm trying to fix. They can be discussed separately.
> 
> [1] https://lore.kernel.org/all/ead32f5b-730a-4b81-b38f-93d822f990c6@collabora.com
> [2] https://lore.kernel.org/all/20250428080242.466901-1-usama.anjum@collabora.com
> [3] https://lore.kernel.org/all/20250516184952.878726-1-usama.anjum@collabora.com
> 
> Muhammad Usama Anjum (3):
>   bus: mhi: host: keep bhi buffer through suspend cycle
>   bus: mhi: host: keep bhie buffer through suspend cycle
>   bus: mhi: keep device context through suspend cycles
> 
>  drivers/bus/mhi/host/boot.c     | 44 ++++++++++++++++++++-------------
>  drivers/bus/mhi/host/init.c     | 41 ++++++++++++++++++++++++++----
>  drivers/bus/mhi/host/internal.h |  2 ++
>  include/linux/mhi.h             |  2 ++
>  4 files changed, 67 insertions(+), 22 deletions(-)
> 

changelog missing


