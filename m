Return-Path: <linux-kernel+bounces-822533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D98B84150
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1549E7BF609
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716232BEC32;
	Thu, 18 Sep 2025 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xj8+bJON"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F932F28EB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191240; cv=none; b=Y077qbO1ejwKOOEl5tluLRT9+u9d9a39JJgtpLIUrSGDe7RCnOre8J29WIEAxS7UcKgmRrqiSN441vA0TB/xdiFPIBN5766MzetRHSazR5XrbPfTV66eVfDRlwIQoviCHC3EKabM9cPB6iR1Y0wcb8nbz/NptdiOnjOAEDZxbco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191240; c=relaxed/simple;
	bh=SFFv6NEMjbrj0MqTLSIDkcH/Ec5UzdpQKT06CrRKoh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQ/qpeWX/ukopnzDEBox5lFncii1BHud/BGBBNG0s7J4ILKOIc125Rx+oUGPt5HA9LYgrgFndW2C8dgqcKk85/LNDprCvi2lKCVa6C5lGM9GmTGe32FHkRpA67OtiKmxeX4gHSqWMlwzD6wrnVgjUS7G8VZ3HQhv//9OoPzaoHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xj8+bJON; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I44RAS029741
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SFFv6NEMjbrj0MqTLSIDkcH/Ec5UzdpQKT06CrRKoh4=; b=Xj8+bJON4h6M4tex
	eud08TlmICVdM46C3Tno3WLRmkhsbNqhTgCberXdpoMD14nQHmlRgjlnHEXKF/2r
	S+J8P8/fiV2JZRB6IsymMfqP7fIVxiS7amroKAScOlJUSy1NJomH6IwwfhRqqgj9
	pOsgXIDONGDPuCe7kEo5WyIhMMCjdyDa4Fwe0bV06eO3TXlDh0HbWW7J6QFnh2tc
	5aR5Xo9CkpAv6qyLtcM8feBGEi3aXP90Yd1yJtKNHZXBbljdopXYR3CgO/pfLQXD
	RH6tVxKP7ZDMibIcy25K4HSl0x5HyrBVpYvDWcSssdxiUbcI1LEFF3zkxLigFthH
	+eP9Bw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy0ww82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:27:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b79d7413eeso2693311cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758191237; x=1758796037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFFv6NEMjbrj0MqTLSIDkcH/Ec5UzdpQKT06CrRKoh4=;
        b=BngqP0M4XOae1TYdRQ5HlzaEX8p/6N4klCmJfxrQ6eaxAmRHORjB6fNZyM85ERZE3v
         ir5mIFUxIZA/1Wd67Kb1t+3rMYp/PCt+pcObGWK+8D+3VoQfXg3zXu8Vd/dWxwyuTMG6
         SSFH3w1jPyl/q1Xi8ZVsgXlt5fLe7fM97MHDE+EtQAFvh+m4U+x9Vg7R2xJlsZM4KDqK
         zIoRfQ6WUb+A+Pws4q3OUvx7igZ/0dC4/xOHgiM/qKPdwWbPBdFtqJvHA56wAnwxDWi/
         zhz/a1kIdaNc1pkGkhZTdmSuuoNM4jQSqE6Pv/2MmcPmiCIakq9Wfpwz4npXVgDP27bg
         o2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWobxQ06DDrRWlfOuvX3O+AEqMpXoKpNjPT8l6LX2lZP8k0OMJqH0Avc3FN2m9HlGrcwpqz0qCtvnJEuE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJxcQjL6JliJ19E4h1Wdjzp+wKPMeaufHjkJLRZs+Te/xDGhYw
	v26ZldRcVQ63d6GdAN0UNH3x0YHQulBZLZ53Ez8UVy9oKh2a7YraeTmQi1FK3xKykSLkvDqCKQb
	e4bZ5mpZTE5WlctIpIgM782GurhEPGi/du+NRx/Ztdf/nYoMEiGPKosKUvqmPyMiKTBA=
X-Gm-Gg: ASbGncvPcdishDU5oyHtxfy7wSL/MmCF9Ha7WQxg87E24N2lTaOnV+nAikJ12drprwA
	5twHh66vYwZTe9k2zKoDoJmQUQ6xLC6gLRQNLLkSIIn4fZEv3LeQW5Eg5QeMtQFZeIeMsPKSHav
	USZ9dAYIZ7/Q97i8RHlMVY58JmhrgWoY1ohecMEGtr0M3njJ/rNptQeZasTCLAY3XqqB1ZvrqXi
	lUkjZOj5Zjc4pGQKqn0IQ74D0X8Ix0zvslFjXfJGBgtEeNbSfme2Cg5TX0RmOoVpiHRqGF0qGcr
	EZZP2m9vdgQPGWto+OwUF30j52cUsMArVKgeR17pH2ftKcDc5cjJbFPk+yZRpXDBDkDnHNgyRbD
	YGRvaYFS8+6Mtg9zJWhk7yw==
X-Received: by 2002:a05:6214:519b:b0:795:c55c:87de with SMTP id 6a1803df08f44-795c55c8cffmr4039556d6.5.1758191237124;
        Thu, 18 Sep 2025 03:27:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYzlJJuyXGduZqx5WCoB3OgJz/oYERgYQ1D6+IglQ8GmpT3KQfYFFrtxzVLToClE/f0NfFbA==
X-Received: by 2002:a05:6214:519b:b0:795:c55c:87de with SMTP id 6a1803df08f44-795c55c8cffmr4039366d6.5.1758191236525;
        Thu, 18 Sep 2025 03:27:16 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5d1a89esm1217938a12.16.2025.09.18.03.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 03:27:15 -0700 (PDT)
Message-ID: <c5d5c026-3240-4828-b9b3-455f057fb041@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 12:27:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dma: qcom: bam_dma: Fix command element mask field
 for BAM v1.6.0+
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-4-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250918094017.3844338-4-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JJocEh-6IpsWu34-xxlHAXmaWRQkYxuK
X-Authority-Analysis: v=2.4 cv=btZMBFai c=1 sm=1 tr=0 ts=68cbde86 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=MmGnNXLGTzfTIO6JWNsA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: JJocEh-6IpsWu34-xxlHAXmaWRQkYxuK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX5EiEsq2m7gLC
 WG/LksB/LGc8yUcPkaI3HeQCS/Vac/Pqp9hZQNQSEwhLBgdFFtxmOfqjoMXoWapRdzbMOjYuCJQ
 23ndOranQfCvtLPAr9odz+pXXwRnLIFNtyyCi6r2Epks8huYIV3u8XMZL6bmqYb+t7tAE4qOPxY
 Rpk75l5VoauqCC9Mh1AJPE8iciDocdRgst99ygzKBZlsobnqVZ6ESK8nrF+NwHTm7WW/zhS6xH9
 0jO2VkyM02ove6tNEWHJcz7Cqo3TR1P4OkqT+o2dKeoOls83E+/sy3FHsa6//F9ggFZtDgE9ZEC
 W2lxpdQW7wBm9c6GZlyhZkVgt/4x46rNlVfVmWmLBTG9eooFf2fMuZ0VQ4SPQMNgKXKN8Bytt9s
 GY59aA0n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/18/25 11:40 AM, Md Sadre Alam wrote:
> BAM version 1.6.0 and later changed the behavior of the mask field in
> command elements for read operations. In newer BAM versions, the mask
> field for read commands contains the upper 4 bits of the destination
> address to support 36-bit addressing, while for write commands it
> continues to function as a traditional write mask.

So the hardware can read from higher addresses but not write to them?

Plus, you didn't explain what the mask register does on BAM <1.6.0.
If it really masks the address, all reads will now point to 0x0

Konrad


