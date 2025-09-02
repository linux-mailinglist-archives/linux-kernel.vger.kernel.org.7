Return-Path: <linux-kernel+bounces-796513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 169B7B401DA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F411F1753D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845E12FF67F;
	Tue,  2 Sep 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YAdgjWr2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5193D2FF661
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817898; cv=none; b=YB6kbjcG+jVd7SjZYNfxeFydAO/ole13S1SBnZ2LRL9iXIRjU7hlJXw8WVRXGi7xvbHuESnEZZziK91nQwIgOC7sd37AyrKfbBvZpRsGdz+J3LVS9auF2jMuaP4j/A8QZ2NU1AJCUDiMWJxjsMkY3Los8j7XZXfwxTUU5/s8dRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817898; c=relaxed/simple;
	bh=3r+3aP9oEXGjarOxz+gcoeAHKeXuUgWKYwDy/xBY4E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0BjVT416gport0OeUeEP23p1KhlRf152067asZJ5/C9NDJvV55gWY/4gmTYqtJCBe6RevRcR8V0GdyhobLLR8bVcru8d7k0v7LdZFsX2NS8PGHLbP03d5p7LTrveMHQI2+HxIJWhbO6WP322UAw/ykwypiMJkQUTNXpkw0BtYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YAdgjWr2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582At4vK025556
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 12:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fv4hoRlbFBP5N7Upej1+05+LU+4LqfFdEDRxkF1OiEY=; b=YAdgjWr22TSmLYIj
	RYpu73v04tebNgf3SCDlDDdNgb8eP+wTz6lf1FCPytzZ9+iE+1LtnVF4v5i2Srna
	ZwyvDbVGjn9/e/Gnj3lyMc1nn0Ex46w6UoyLbW/fdwomP9R3KPJkOt19j0evxYEg
	0xgWrLRr2v8ZbNxIBbajnZeNOKRfUcuugLII/CtgD/Tg3m5an1N1SJi64tiewzto
	nwOs0h9nD1Jg9L3SdvuUj/ZxquwhM5lXp1UFkgwubG2ji03FbszQ5SRddjL2PVCV
	GFC6UvbklwKUD2boOzCjMPvTRvwoc6OyiZHT9QKTxxwV054nzfVBp0JLQd5XI1M6
	DnIdpw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuyves-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:58:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b2d1c2a205so16134081cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817895; x=1757422695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fv4hoRlbFBP5N7Upej1+05+LU+4LqfFdEDRxkF1OiEY=;
        b=PhQqPZDwg5l2Av63BRCTwkatb19L13Y7bovcQHSvxNYDDygSlLjIPxHel6NbQYVaV9
         UCsCZWUOasR0sP3SLEgdmpbqbxBpR9PyuCWZ8dkztKYJJqW4HK9EpuOlOVaGZk339J19
         9fzyjN4iKe/7E5bSphLpSKxjY8aNLS/oGR/6xTJsleuTDpxJ8ctNurrJzB0t3OWA7d+M
         Zj5DlhRt/kRQCW466/sQgVQAAs2ujpRW/CSLlaFH4r5+J1nwbn0VfYhTJFJrXj+VkEAk
         mKyf3Ch4C0iZsMvUXbIp+8zKYJiDWwD/tscmhXCrSPvWE1es3XLKwRjl4TMjcQp8ZGLA
         wsVw==
X-Forwarded-Encrypted: i=1; AJvYcCWzxlrvZ3qnblhxWaA3hXCI5L7Jhvr7A04PhHGXIuJtNvw7B2wKXefPim3aXJVSWvom3jdSFKMXsOMHbno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYW5BfwpAUBGs8Dd3aMiWNXMhNtKn5YlwSprrahju7LmFcq9ky
	+AJsDBBU8obRlhor0LNAI/PFdVlhX69bjL6KUEs3ue26wh3uRrh1DbvO9b5RJz3+aS/qW7Qe2v1
	u4tt9vbipVf0gEZ80mdwRHpkLB1t/e+VInEssUYn2jKv3z8plX6pFA6qYRa06trwdAts=
X-Gm-Gg: ASbGnctzx9w3y38nPN029/DQCDFx8pjp3jQKdY0zkR6RZFRFIwRrZMLCf66mpPMvWK9
	Vk8E5KAtQGBBgY28RwPs7+/Nd2A1PeKgoP8C62VW69luhXzcHgF9DQoCajZkiG+nhpa6CAmyb1A
	lZHkzMcBCK2ekS4BiZ4dnH13Sb7JiHeyKreyq1Pdi2kmXrVzCj6llmPys6E15ggRk2lzt92TjSQ
	p9f8Senv5cKhY4zJgytHr2KQH2YUP4CVhb2dFhKBQrykNXFDA0qkH1HarVDt7mbhRZYcrka/hIH
	WZ6SLE6Q2wAJYBDbD65t2lg26IwZNLSiFVfi+Hh5FK9kEF8+3jtI7ezocTuOslpEdQ0y09RcWdh
	2xT9gvK4bAjU9aZiP4bDnuw==
X-Received: by 2002:ac8:5e06:0:b0:4b2:f5a8:21da with SMTP id d75a77b69052e-4b313e1a3c7mr117777971cf.5.1756817894969;
        Tue, 02 Sep 2025 05:58:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1r9Mg5tkUeoabmgdiEQYNKoD9WnuOlezMqzB73RvDFLxn/HEh6CHqvJYTSGP7PrdZTdhTMg==
X-Received: by 2002:ac8:5e06:0:b0:4b2:f5a8:21da with SMTP id d75a77b69052e-4b313e1a3c7mr117777571cf.5.1756817894336;
        Tue, 02 Sep 2025 05:58:14 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b044703f412sm245602866b.56.2025.09.02.05.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:58:13 -0700 (PDT)
Message-ID: <708dc6e4-1566-4c72-9f3a-a34f935ac247@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 14:58:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: codecs: lpass-macro: Add support for channel map
 mixer control
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com
References: <20250902062300.212021-1-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250902062300.212021-1-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX6I/AHC/C6nmP
 CDmX23o6YKbd1eMH87BkcCKbseiq3/9aZkegql2SNX+qHnpVG9nqqmd2jblpDwj0bm3ozpngqsu
 NPnh6p6VxGNuNZrF467ZWUaoF3uMizTHEwWwXaluJ0KrCzr1crywYsTGdKqfTVuNVNlvf0TvzsU
 eK2quI6GqYt2PwRzaitmQT5CAnHCeAw6/uoxp7tQ298JBt9z1g5Xai0NDzjdP3anI2mrDWoAsIa
 D12hyyE6AYAmjoDSl87hdY7qsmZHZ90rG+GhG9RbF9mzl+/xtJP3PE35gdsske69tOpQqduL/4i
 j0Fawz5LYdTHY2R+5f3xpFr/OmvZLNdm4D38wbgrx/YhHmoL/KoFhl/Fi25VKma5yHzG/dSii25
 xIQX0anp
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b6e9e7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=XdHql1rsSa6mdbwAZY4A:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: -iuNHT6d357bZQ3oVfbHo3vrHq_UTo3t
X-Proofpoint-GUID: -iuNHT6d357bZQ3oVfbHo3vrHq_UTo3t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

On 9/2/25 8:23 AM, Mohammad Rafi Shaik wrote:
> Introduce the channel map mixer control support for LPASS macro
> codec Digital Audio Interfaces (DAIs). The channel map mixer controls
> are required by APPS to configure usecase-specific audio routing and
> channel mapping.
> 
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---

[...]

> +int lpass_macro_add_chmap_ctls(struct snd_soc_pcm_runtime *rtd,
> +			       struct snd_soc_dai *dai, int dir)
> +{
> +	struct snd_pcm_chmap *info;
> +	int ret;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	ret =  snd_pcm_add_chmap_ctls(rtd->pcm, dir, NULL,

double space after '='

Konrad

