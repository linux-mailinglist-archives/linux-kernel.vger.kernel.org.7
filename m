Return-Path: <linux-kernel+bounces-875574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294ECC19540
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE821B26979
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0623A320A0D;
	Wed, 29 Oct 2025 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PCwb6lrj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VqeFxpYa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EFD2F0C7A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761729251; cv=none; b=MQim3o2iL0PhBcZuRXwtlQz7Td9+bxX1NdqljS07I3OMtIkQtGDeF2jtjNQq7Q3gs5GhQbyagreLGhXeZnD5K+6HUTtjenPRMCHIOse7KVuzPnaijOvnsQIHBhzZ4VJaicBc2RIedOm38DcWDHZJmuaLOnmw9z9vA1UrmPKeI+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761729251; c=relaxed/simple;
	bh=aUPFdpL33uES8kTlkAkCNzAAjB0JCnykVwWBibXh6+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHgvz5NXxx12VmA4Yb/RIBlOvAzKBw/powfyTo/7M8SJE9strJEuL2w27WOfOhyAmNp5Ha9c2gIcxg5+occ49Ua0HjSSfp9xjc+o2A6C3xgetcs/h5DqwUNa0PCdwxejuOs5ChI24PkKrsQgbFCpOvizd2kTKrk+14E/AmaZ8HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PCwb6lrj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VqeFxpYa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T93BeN4155409
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M0KeIVlGq15MElBeP8pO+CyR7dQzEqnN82GDubcNW74=; b=PCwb6lrjAp82TKWt
	H7sHwkFxeWhxoFzpTJjhjHDzacnvukYjohz+s6EjnXEja1tPY/AG5KyzNf4Fuyma
	ptiqwkQfvXd77RU3MbEZ1UA3QBId8/QMiDDAfk5izyuiNX5e+IFbiwRiACosVuDt
	2vkCogNPy49GCyqz5qTV6H2U5LmYm+aQfhOOB/tqPzy8s+18li4TLVNL+bBi3d+d
	96IGLAztTcMZ0CdXm3Dd0inlWISTiEkDLO2RxHC9OiuIXbtRa1hhE9b/9S3BD4YI
	yQTJHbgAOhBNXyyOrPrrmc8brycbDMrcmrBg3Bm7UoTj27TlBN5hrOJygdtdWmWk
	A0i4tw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3fy0r16p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:14:08 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87bd2dececeso27928606d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761729248; x=1762334048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0KeIVlGq15MElBeP8pO+CyR7dQzEqnN82GDubcNW74=;
        b=VqeFxpYaiW7jSZifvAKa9c8vb0vuXAI53eqBs4VcYCkmFxZgzWIsQY75PdHfmPuaRo
         VyvL1oLCDdkS9K5EuobpERX66GctODp5XH66FV6Pt/yPOteIOK/HSG5qeGUugJEYo7gX
         xKjG1rPVaN5PgyIiASOh6oDVOyMlk8vVKcDJxKbF2MeiHrvhsdVUpPBDFF8kZ70QhAEb
         YP7zCVaHAv8DSdTnRItMiSpP9Hvbw4m4IbfiICqTbbJ8ONcItqwksvK0T0N2eTDvEgky
         6LfeF+rrhFbNOO2sQXf+WgjaJFsOcgBaS5KhRn7K6zwCMuabtYhvgxVVMstzhd6BTTyI
         n5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761729248; x=1762334048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0KeIVlGq15MElBeP8pO+CyR7dQzEqnN82GDubcNW74=;
        b=MYCw83ZoYkZDVYMG7ss78cd85LOVwN1oc805pKrKUx6iGL3Ws4p9VlKpSb4nZ+B1Bu
         c3mNXfT16UkP/kKkLAf2YG3aCFyLJOU58FyliSBfrp6DxH3qB/yLhrHw0IQRCE7S+tG9
         WT2K/bTquZ8JSpV5OUpCF0uaP4wSQW+5+Y8+FIl+kgBeHk+NdHh/KikNrFAbsokVwnYS
         JaNG7l8rmDkCvdBaIJrk/PlcM4J/DhU99iRj7rAWVbxmKLJE9JyCBUat1pdObBGkRqcI
         crzCGcGyd9SUIXRIhIz+cbEtGVHZXNa4D+ja7bMThlxxSi/EsFbCBnvUEE6xapLO9BwZ
         VMbA==
X-Forwarded-Encrypted: i=1; AJvYcCXl07TeKdoCG2KdFDYUQF9mhNIWhc/tUVObp5UrzE9YG2nZJZvkTSYCVDDD20klfJ64c74fuXdAv4MMnm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxduM1fzjh+Qyp16h1KetNODXQQ+NJeViO6TMQ0i0r/lfBzpPyZ
	C/ANKdVjaSNyXz8ZGOWuheFhJuGiss/38LTwIDXPFevIEDo4oOZyBye7Bd37J0HlwDAQkKgekb5
	bagj+JhyZG6dMKhOLSF8SzyRPGUx58sot83kA33cuX7+DpNWvpZy97XwGkv6hqJosqxE=
X-Gm-Gg: ASbGncvOk9fIhLIeVKA5x2DlJVxiuU2UlcWfuiYgHPV7S2oSNWpgTcfH+Nqpv/eZRIF
	L3BxNnd5udpdHXisVDZTNESSNuZheFF+IgWq/9nJLejLhRCVTyuu2yhk6iEYLSBgF6yLiZzG/KH
	g79lx89bFH2fPjN/YjqEk85k6CtzKr6+/LGlijG3HTT3dQljCJrj7YJKW+Jd0HmP3hkTE7neKPJ
	DmZsH7g7bvCthCAWw2nrITCrUADsiqhPNtntNVLLwWwnSU5AB2TTvVDtLzpRzysbmgSnyUGnDxr
	KCUgH6l/kGRwj42o9wNYYHFm9dQWxldwBxn2Q/pG7WQ4Al5vaV4EofcLRe00UX5QDRt+KfIUWBO
	KdG9RuQ3LZ1dWEqYY40zo5z76FQuQsP81Ffe6kYUQBOe7NG/6EOg/5wjv
X-Received: by 2002:a05:6214:20a8:b0:70d:e7e1:840f with SMTP id 6a1803df08f44-88009bc1287mr16767236d6.3.1761729248148;
        Wed, 29 Oct 2025 02:14:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFedfub9hPMXqka5Omkn6HWRz5eWUuH5SfzNJk+9Zb78dwYmTiFm8qVdmrVCzSFnA0a2DyWig==
X-Received: by 2002:a05:6214:20a8:b0:70d:e7e1:840f with SMTP id 6a1803df08f44-88009bc1287mr16767066d6.3.1761729247648;
        Wed, 29 Oct 2025 02:14:07 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85338663sm1360523266b.17.2025.10.29.02.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:14:07 -0700 (PDT)
Message-ID: <f062bc4f-828a-4a91-9257-1b1164f6df28@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 10:14:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: smem: fix hwspinlock resource leak in probe
 error paths
To: Haotian Zhang <vulab@iscas.ac.cn>, andersson@kernel.org,
        konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251029022733.255-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251029022733.255-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VJLQXtPX c=1 sm=1 tr=0 ts=6901dae0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=JRTpi7JZ6PypFw4hOZ4A:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: tPM_HBSLVwipogmF-poTOGgOstA107xn
X-Proofpoint-ORIG-GUID: tPM_HBSLVwipogmF-poTOGgOstA107xn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA2OCBTYWx0ZWRfX6aMDjCbfp9EX
 p5Dp2a7SHL+xg0mYx8zMLeOoj5fcfASvprqUL3PBxHxoAKw19BdPE1BdN+Zoqdi6k2Usbdk0sPo
 eWdrvIreu8zWqq8XpWwmc13ebNPnqCeLV+GkHKFU+rY6B7RRpvcAMziPmQ77jlpFSs2vlg5Hj7S
 UH+uAafEunTEwrysCRFP8IyQhcjw/GZG2plmXbdNAWeXiVdHMnAs4X4av7LCxR5Tf9X/qDk1XHQ
 HeTmk39xEcUyJXcsom7rs7SxYyazhDJgxYJeyqX0LwHj12WVIe0F0XX9PuOoYuP7yv3US81HdCA
 da2y8QcA/X0KYfLrnG0md9aUKPaEtAo1EAQ3bASdfxid+tZ4P2r/SxVYcmn9d34RzS+3DjTaFQm
 hfQmcR3WodQHN2jSFFPEp6cEqDcAlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290068

On 10/29/25 3:27 AM, Haotian Zhang wrote:
> The hwspinlock acquired via hwspin_lock_request_specific() is not
> released on several error paths. This results in resource leakage
> when probe fails.
> 
> Switch to devm_hwspin_lock_request_specific() to automatically
> handle cleanup on probe failure. Remove the manual hwspin_lock_free()
> in qcom_smem_remove() as devm handles it automatically.
> 
> Fixes: 20bb6c9de1b7 ("soc: qcom: smem: map only partitions used by local HOST")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

