Return-Path: <linux-kernel+bounces-814124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF35B54F90
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B593BED08
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686C0303A13;
	Fri, 12 Sep 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ftVbIivf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5AD2EC57D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683844; cv=none; b=aPWE+X8tcd3EF/QVWABsSMLWHVvCxc1svfh1aO/zZ7pkeeflj/s/mSBCYI0VLS7I/eTVNXvzG92acJ+obV6gyEbOi7Z/SRtWet7vIB6YCS1SXGvMbzkfHngMdBJwHzMSDGKICs6LSR+3GM9kHuDqh/Z0Xr/OE9YC4LbJFL1YlpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683844; c=relaxed/simple;
	bh=fAioL9Bas2bv4tHwQrJ8O9UO4A+GlYMuRsVG7WodBmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUpR81V1l0ZWUcgxeX82maApUg86YtEY9nL/ijWPEW1CV9ZHd/G4HjqM7R/PcI070E36rJif7t1KWQL0sj5UUR4ghIBIfPMX+f0CXJ9SVmQ2DOiAQsioE8kqZ9w8jfEDGLpib0BtZPWlUJ94fXMXjOjZ0dWllu4L2wCvnUZlyH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ftVbIivf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fKNJ014034
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+I1iSlLxK5uuF7Pl7ahNBK1LrKctG/GBJCIQxTn5JGQ=; b=ftVbIivfHML0u5XE
	6cz2eZmdLoYM8XjYp4ckfBp2LzuSP7DxR5bd0+NbmC+f0fu3wEwDhdEDgKz91xNg
	hDycnOEXzHq8fOLKsqYEplhHM4NMyDF7yv4YvhcNToX0J20Q1t4/72BZ77rIIvmH
	iYb+z07blGMD1f0qHDYY0zCRhYZccAxMCpjv/BZP4iDXshU1teeYNd+K1kEypVFT
	xphjsiHRzw8LNYW55kcPTQvdUMZIF5Kl2yofjwjqK0cQmlVPyrFjQkKpz3AcY1Bc
	q/wgRDDOAp6R7jg7e4OeysEMnl3ZYNxCTCjm1aP+TkdPUg2T5d+ZYt46c615nvpo
	h9vEjA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493qphwgaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:30:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b62de0167aso49992581cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757683841; x=1758288641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+I1iSlLxK5uuF7Pl7ahNBK1LrKctG/GBJCIQxTn5JGQ=;
        b=jJMh/dbawpP/5IAEcXs+KcsWRDIxQX32XeziQ8PuAlghEsov/vz+ODjb3qRq+ikXZE
         RCRaJ0nxWIpmLMnAD90IHo3wDrXkkilSC1ueXUTaqknIxVuQGgUYmPZLkYTxwjN0+GtR
         mAKpdRzeAUNh1M5aajrXHemOJgjjBOkVxnwe+Syt1RDkRiF+r8iG9RBdkmNrFGCu+x4X
         WbG9OYB9PnMDlNVudgLrf7/70oM+jPpD0AL4lrO1WtnzE3PyvBelRDVOaJAkf682aqBK
         vxLPQxG9bje7qnBbmO6w9I4q30PvvnFq2EKxrPJjXrfG5yUjhY4IIrqyqdX4s0rawypQ
         KPsg==
X-Gm-Message-State: AOJu0YzbwEkZJvmIwnHS9Sl3lDkK0C7FLmhTd94ThQ3ri4SGDZXEvLTU
	Mx2bVG5npKagktqLHWIyBIY/JkQsuH22L1KO5zkc59vno7YM8NeYiHdndXblg4SFRiLrNh49hqN
	wysF9mwVXfTZzl5oKNSATHwvOZB5/qALDpHPBA6sPxPryoug0VGrLgpiCORtEvmeW4EU=
X-Gm-Gg: ASbGnctePH+tqei7mY4ugPd5Abjz81o7MUXcl6xxHUFv6aGUJzC34jZK6LIhXTk5r4O
	tGymFD2ePR9hbRZ2FaBkzl/R6XD8n0Lrb1yLXPNGS+RlQj+0dcWhTgo5caXfskD/gaROEd7oqxD
	qAtt307sKhminI566pbhNHgyWGjQqch5l0ooAkdzdtWnqYAPy8orqLzAUv1OdawX74eYybVtyaz
	2Mxooa7Sj5EkHQpBkzpM1+UbTd/gUkyI1CVLhoWxxuUE3YrSasLZOeH4p9cOe/U4rv0LzzPl61S
	YbGZgImQdOWnwGvaUX/1Jfm+vdjftduPuFkzdpLtwYGeYtnbwj3YMLkrXgjW4HZqWWTFH6WJTnL
	gKhKpa+1HiNCinCrinNyqerE+7xMFFt8=
X-Received: by 2002:a05:622a:418a:b0:4b3:285:91da with SMTP id d75a77b69052e-4b77d1050b0mr34489151cf.68.1757683840336;
        Fri, 12 Sep 2025 06:30:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYmWbZo0dH1JwnvPH4Z3rxYl57hbbOnCwM9YuJH7QrVtktyhqm6UzfgF0Pidtf6m4wri18aA==
X-Received: by 2002:a05:622a:418a:b0:4b3:285:91da with SMTP id d75a77b69052e-4b77d1050b0mr34488481cf.68.1757683839672;
        Fri, 12 Sep 2025 06:30:39 -0700 (PDT)
Received: from [192.168.1.188] (87-92-23-212.bb.dnainternet.fi. [87.92.23.212])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f163f401bsm8841111fa.19.2025.09.12.06.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 06:30:38 -0700 (PDT)
Message-ID: <31a37e24-0044-4987-89a9-d891200592ec@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 16:30:37 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] misc: fastrpc: Save actual DMA size in fastrpc_map
 structure
To: srini@kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, Ling Xu <quic_lxu5@quicinc.com>,
        stable@kernel.org, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20250912131236.303102-1-srini@kernel.org>
 <20250912131236.303102-2-srini@kernel.org>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20250912131236.303102-2-srini@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aPDwqa9m c=1 sm=1 tr=0 ts=68c42081 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ADr2fr9vtsuHB99cpUQfeg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=63YoszGqDLn7tnGNrREA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: OSCaW6faajYozSXgbSeTfkNW5L9k6gXm
X-Proofpoint-ORIG-GUID: OSCaW6faajYozSXgbSeTfkNW5L9k6gXm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA0MCBTYWx0ZWRfXxwuqf2JuhOHw
 vIAVJxL2O2Bw1UYLF3ye9RnT1lIFbwDIauElvpY8qpc5nKTOWgW7NLgtnrw5VoM1/K2bw15S0/Q
 4nouiaNhOuqGjBSkXoFyE0elRO6obm+F6CxwJ6WNzxasFQSCUej6wzinJUQP0pVE8yakv/qZC0E
 Kky+WyqCd5O3eM/QQhgfQf7swS+MZ1Za/BTk6MwAtsavhPbvUgkPmmAjg6HoDlHnLP9I1KaoOGU
 NsGvS205wHqve9GEgJ5BUgjxStJPaqUmx7eEQoj3/05lots1MftUvCxe9ZLqfBl/T5QrRii5pFh
 RNWEMqbSu3jPj0JiOwm9ki9/7d8UveRxav+A4zW9VhW2o81/26P4Vqe6IRQbYncdQeUKgDABZSE
 +pdftPVP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509110040

On 12/09/2025 16:12, srini@kernel.org wrote:
> From: Ling Xu <quic_lxu5@quicinc.com>
> 
> For user passed fd buffer, map is created using DMA calls. The
> map related information is stored in fastrpc_map structure. The
> actual DMA size is not stored in the structure. Store the actual
> size of buffer and check it against the user passed size.
> 
> Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
> Cc: stable@kernel.org
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
> ---
>   drivers/misc/fastrpc.c | 27 ++++++++++++++++++---------
>   1 file changed, 18 insertions(+), 9 deletions(-)
> 

Please use correct CC list when sending patches. You've missed several 
entries from the MAINTAINERS file.

-- 
With best wishes
Dmitry


