Return-Path: <linux-kernel+bounces-897102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CA4C520C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F41F4FA373
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482930DD05;
	Wed, 12 Nov 2025 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P8kTtd9d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VjL0XZWk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6D42FE06F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946787; cv=none; b=QgC3py+Ogxemxbd8jk02jsziyCKhFS3dlJc/yYZXGxRzdq/mA2HtdxedXQA0CWlrAacD0/stweCnH/WCswMmg6G+1fdLJY9VjXvoL5AG3QlQw8oHvFwKbg+3L+xWckK+iUT+hjClzPF7QG5XNOfuGBTNcIdSy6j6qoN2/NXvLHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946787; c=relaxed/simple;
	bh=mftZh7qwz9j2JQ5d9XIfRBpLELuuTQFswKjyfXKekUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lrUuKTaFe0KZFdHAohrKjiYhVkNLMdfBvL0ildqL6aTqRWFeuRX1YWc/lItTarF0UBf/S/YHcErZW1F6K4n9cnX3ePKRJR6j3P9f2BLVjw1JveKwN05YXFVum+x6WodeZt4OQ6jk2VgmtrIKK3+I/MxsDUIJNVDwFFMj5D5FFjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P8kTtd9d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VjL0XZWk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC6Skw1350167
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0tfV8D0lWm/tA70jlBURKawrIKg8H5x3ti8eAvQylV8=; b=P8kTtd9dEanFeLCi
	OQbeiWOKN8zuKe32E5StXmyDqYszS6QUsNNRGGlw022Do4S0VFkPMr+qF+QwsAsJ
	OrCjGdL7Ta34RjlVlP9+krnc3rvuYFfTSt4A0lXhV0Wm/SP6rE9IK4J26lZKBTsg
	tcQzgZzqNaJ/pxpvlGWEsQjw7SZdOFFv36Ew5NGJlr9STANCKvdO6dMFr3qPEZuy
	FcsusV4gLacuACgWyc4ls6Z/C6OtOK+YO4NkLheE+608mIQJ+5LsTvF8HMJ6Mmk/
	I1CCYNEIl5bgmXLoy6cPdZkaV/qbMDdEkNFJt5Vc8JSNsQTnraD4VLKAFNfccNZZ
	yWCa1Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acn0ns0s4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:26:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b21f4ce5a6so20209685a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762946784; x=1763551584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0tfV8D0lWm/tA70jlBURKawrIKg8H5x3ti8eAvQylV8=;
        b=VjL0XZWkb6heh/JOOOsiJAvb5HDtq5be92sIVyKyZmmxHxYhFMEzXJuXOTFxPFTgIN
         waML0d7L2jbkI7h7EgySlhL9OSZ34z88PIPCvW2MvYpk7W5zLcuX31oNSur7TI8AEapR
         KPYPr/MaXxiNfxjvxVCeCJ2/uIpNjutjNDQx2Og4TVtiOJ9HDEz2peC7F6KAjAipHAZv
         mQOunkL0aWsRB1Oc+QrY94bh7qpOSYXSscTCOnvi8rFhD3vym+G3p4Blznz1YS/7xrOX
         q3ZjFEB3FsX3hChFVRj5qZRr/GK45pH8yCHrSJHZcb54d4x+Bu88OF6RSiZ+J1/F0gPs
         YE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946784; x=1763551584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tfV8D0lWm/tA70jlBURKawrIKg8H5x3ti8eAvQylV8=;
        b=PMXPkEIttGL5CWBF7DNsXCxFGl3twqnJSMgNuCXX+iCObUo0yNefVYeKqBvXb7m92W
         dgnLQZUdLkylv5Q5cdMY/Nml+mbx85GeTlbX1NkCB+AC/OdRo385owlLTtculnKSyfuf
         rbePaaZtcdOno6dnsm+1BwbKL3kYQp3MZFLEM+iLiUvWBWcqjLRec7Os1i6QI4IMnQPP
         bOIGhRBB5IR12oBqu0DcI3mpUamU8TV8LjVvCUtpQM+t4byDlIDpWwEjw0+WBf3eGQNI
         bGSp8FvDDx6CeboO3ee+FNsFZfY3cbd3fVvg+VYdTYvrGdqYLuXoil+PtDzmS6mGrdK+
         FxOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhAJ+WvOyigJ2qHZeQ0NHEBopJbgkIeEm5v95uYi1gm4X1eL2AiiUpMhW+6ijQe/t8JaDz33FYTZtlYU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkU8+XF01a/rfyX5iiSR0NoRGTBBi8h0jeNA1WRWEvCy2SHgaq
	CC4WLYkMmVM9M8OZwtRqM99AEagZsPT9zD8tkHP2vUMl+Xc0Jo2JGbhRO79URKuL+bJSN1Zz1y/
	f640+6uteJaNX2lneLCkOiBloZXk0TefRxVNt4JRfvEJWOut2I+NOdaVw2xjCS/t9Q9Y=
X-Gm-Gg: ASbGnctIRDfILj1JXXzmBHP32rY1+3WsbyT01lwxROWqnxjzWw86Asx6jgIpMRPQxjT
	y6CEXyeDqYeEItB+s65j1OJZ4p4ATI0mnR41ugZt82p0RzHaz+adybPkbFCdpyiHFgO0+kLIeh/
	8s+J3fQdBCrvU0UxUaPMmX2pNm9I8CYBk9BTMiaoGoO2NaDVT9dcx0Cn6gsIJQ5zgs4PNYKp2k2
	Uq5mFpmXUwVvKZ7wwiuZzXxKPUe7/AOqpOvD5MbrLYMxcJpX1tRg1b9P8WQMAiY36nxPLb9zhlr
	mpaSdoLjoAtaR+qMTW3OdPf4re4y6HGHsyAfR6JrPzAJW4FkET1VbqaPRryGagQabqs9W+br9/c
	Y6Ur5Z4GJSWDTyt2td/YIJJFATGeEm3F4n2uZXX8yCVkwttwZRgy1ABXC
X-Received: by 2002:a05:622a:1209:b0:4ec:ed46:ab6d with SMTP id d75a77b69052e-4eddbdad3damr24246981cf.9.1762946783720;
        Wed, 12 Nov 2025 03:26:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/QcRp8U8DMZP/7J7w6/mt8ZpGCzHDr59+4/KQ+rPDXlRdzlSZSWUMxtW/o1KzSZ8uetQB5Q==
X-Received: by 2002:a05:622a:1209:b0:4ec:ed46:ab6d with SMTP id d75a77b69052e-4eddbdad3damr24246791cf.9.1762946783268;
        Wed, 12 Nov 2025 03:26:23 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bc214sm1630778866b.52.2025.11.12.03.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 03:26:22 -0800 (PST)
Message-ID: <9e8b47d8-9a20-40da-a6eb-cdd167c108dd@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 12:26:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] soc: qcom: rpmh: Add support to read back resource
 settings
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-2-5c7a8e4df601@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251022-add-rpmh-read-support-v2-2-5c7a8e4df601@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fP3kjKSMRnALrcBynErj9Y9nv4S8PUaP
X-Proofpoint-ORIG-GUID: fP3kjKSMRnALrcBynErj9Y9nv4S8PUaP
X-Authority-Analysis: v=2.4 cv=acRsXBot c=1 sm=1 tr=0 ts=69146ee1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=l5wVe-rlrMsD3pqKN94A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA5MiBTYWx0ZWRfX8efaQSMz+z2Z
 7wmYKX74ZDymmRDEuHCFZeFdhReoWm7AmR0fsYogLwQSQMpVoaNNDnVMtTXNIMigUtrhR4x/W9u
 qjeWKhAiRl0hXcPBOS+1kPQuaMcx72izN98ZhlgbKvcf4R/ffoxMUMQDAu/wYfBNRyH21idbOAQ
 BpPx/4cZh/sUB93nwYGwRZa6DaFEb5yKD70GJTSws/OWcTt1MiBApmg8Bk5/jITMgZIGvRlYb0F
 bDqvssFesHmw2KDJJwC62gdr5A/U+M5qKPZJEx0gX3BHab6oTXvT0A8Xige/atxuNH7JkZ2lWKQ
 Zz9gaLGS4ArJ8ZGmuFCg4IIyTGxbHfT/etN/FSO2lee1HPTBF3H3+DcEkFvE9jFUVwb4erOHCO3
 r9ibUiKitnqRTb8Kl/YnkA/1oKzUCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120092

On 10/21/25 11:08 PM, Kamal Wadhwa wrote:
> From: Maulik Shah <maulik.shah@oss.qualcomm.com>
> 
> All rpmh_*() APIs so far have supported placing votes for various
> resource settings but the H/W also have option to read resource
> settings.
> 
> This change adds a new rpmh_read() API to allow clients
> to read back resource setting from H/W. This will be useful for
> clients like regulators, which currently don't have a way to know
> the settings applied during bootloader stage.
> 
> Link: https://lore.kernel.org/r/20250623-add-rpmh-read-support-v1-1-ae583d260195@oss.qualcomm.com
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> ---

[...]

> +int rpmh_read(const struct device *dev, struct tcs_cmd *cmd)
> +{
> +	DECLARE_COMPLETION_ONSTACK(compl);
> +	DEFINE_RPMH_MSG_ONSTACK(dev, RPMH_ACTIVE_ONLY_STATE, &compl, rpm_msg);
> +	int ret;
> +
> +	ret = __fill_rpmh_msg(&rpm_msg, RPMH_ACTIVE_ONLY_STATE, cmd, 1, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = __rpmh_write(dev, RPMH_ACTIVE_ONLY_STATE, &rpm_msg);

Is there a reason for making this ACTIVE_ONLY?

Konrad

