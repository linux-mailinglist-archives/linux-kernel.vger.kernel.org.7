Return-Path: <linux-kernel+bounces-853677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 909E1BDC4D0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC9BB4F0E72
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EE01514DC;
	Wed, 15 Oct 2025 03:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xlf2kAIC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33FB1A275
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760498244; cv=none; b=QP2B5bFKchq92YQB9dYVasNLW1Omvg1gDCHyASoR+a09F2LDcFhU+M98calYGUOGNnsQttDHmG7a323yboR1WSO98RBnfgHgtl+Yx84MlpGbFx2DPnvpUDeir2uaXnLys6FbjaJQjxwS1ntMGhYvud7mtaYZai6cVYj3Tf9idnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760498244; c=relaxed/simple;
	bh=L8eRhqEBY6VPKEe+NuDuAvsDC5E/DLGuikVuC496Dlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwrKcmEGgXeDdNAB78Qa/vCANgknQ53lsT8kiSYFOIB92thdGCWC9rEutR+F5kWdKIOJg/ljdlqik+AqwVSlCreR6uDNyGiCLy5dfIQCRLywv0uTFuGonWO96KyO5k69Fe4pnycWbC4HP3qzgq/f08EM2hJgB3baFy7EsHeq66w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xlf2kAIC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sVSv005331
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6UAYC8XZOapAdIGslkNfv0MnBEhGl58g6zptcvxFMsY=; b=Xlf2kAICwu1xDiM/
	mdhGqKZpxbowqFBG5SOuYG4quvVBRV1zWjPIhcmIPDxcgTpfhtKzdDETHleBWYp/
	g8BxLHz2klBzp14CkQ7C/wVTc10gMCBwcdJgLl08SmZ9N+nZPXdNGFdpyrbpKlqt
	1PrG616v9EXQeM/73X0hQgJgYuuGkLnzO3Y+Usyo8CVSufTHUFItsQwSCDTPlLuf
	MtkCrocT1DmPLcRuBHgOARP6ak3AUMeb1800PKE5aadme2UtC1CedD522kEKoJEM
	Dgk0k4ZMQrQAsn6PX/bT+laBYRORFgLt6F5DuLX6gFuZ7m54+VOEWMkuqQ3oRC5G
	VuVaFQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1af5ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:17:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-27c62320f16so119271935ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760498241; x=1761103041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UAYC8XZOapAdIGslkNfv0MnBEhGl58g6zptcvxFMsY=;
        b=pgNOyH4eKbuWZO/eKZh0lKXulplwR+RgEuzaXMWjZBSKfevWbtCoIHWWsYJDEZsVqN
         UbF0/8goP6yxtO2+9wQo/C1mB7/O7rS0PwNrWlrGiLb4RGSWydW+Wngm/VXD+B+NSd37
         UuE+1otQ2y7vVr//HctqdvPfwYPd3DsRBFwj3rLMFnSFteB/oX3/I+DLTijcvVFOPB9v
         p41gVjiKhQrjjSjOMRBHSNX7qYCpmiBKqtZxz+fNJJ4np/Wve1llynsX6lAYUIFPhGNi
         nvNzwU8TD/pijtRVPMQ7DHiy1VAXMSvjJa+GNc5y/3Km661/8XxGpmnNe/rHcAh4YJwr
         NGaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5wlFqp0cijX3IFKmeXZtwGSpQB0dQLG51hcR/oLmRaCw62Zne0zckteQMO2A8TY/OXri/5IhrWmWuAvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwPxxIpUiH3aUO1ik1SLXPlcejxhN0Mn8wCJvb5LVLY7c9jArT
	/RWc8jK5AL6nAbU4RtffBZBmAlRS9eXDLnDR2pd1rcAqLfh2GGKrQQuBG5COMhS2Az6aTGnXU94
	bbZbZj9xcAmENvz7hLyuwt2892RRHYa0PAAgtekrD/7fHbuIKakXzXwTTeECQvL9ziJA=
X-Gm-Gg: ASbGncvflKLnNQAISGsURdc8WA5gKIbZxH9px+u/VhBgQhwngisZY6IFZcnJGpImU5U
	Hlw/uQWxuUvE8n2Js3aoLt2UgeTnYBvMKq4Hg2N9LmFzKJRRn9+8IDOEFgtVziX6Y8gCMwATIkg
	YCoDPuC5vPwzVGxkFzNW8D9X5MoV2WauSj20Wp17c+msR2GTGaBtQ6ug/xdItlMyKRCIEd73y/0
	pfRX8vORBdEhh7wG/ECQ+a0YYo8dO2eumIhLfQfwkbI/HfyAb5abp8vvgVIaTHGzPSj/qrC0ySp
	FNqygp/CE8TG/PgDHtFrFdI33XR3cowKbURrx3OL6cxz/g/zld4xo1ECnV5a3qlENUzqxUTtk7g
	r7n51dS1JTNchKNS1NBD47AUJUTtvf9GnBGw=
X-Received: by 2002:a17:902:f64d:b0:27d:6777:2833 with SMTP id d9443c01a7336-290272e1cb3mr334523665ad.47.1760498241023;
        Tue, 14 Oct 2025 20:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxCCtupf0AwQhQZ0njtfPCJ2MZQQSKAfVp9ujpBXzGdvRclHdjEwejxG1jW4b94TQOYMHR3Q==
X-Received: by 2002:a17:902:f64d:b0:27d:6777:2833 with SMTP id d9443c01a7336-290272e1cb3mr334523375ad.47.1760498240576;
        Tue, 14 Oct 2025 20:17:20 -0700 (PDT)
Received: from [10.133.33.56] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6de2sm180043285ad.18.2025.10.14.20.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 20:17:20 -0700 (PDT)
Message-ID: <ba63c3e9-df0c-4309-9de0-253a41569925@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 11:17:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] media: qcom: camss: Add Kaanapali support
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20250924-knp-cam-v1-0-b72d6deea054@oss.qualcomm.com>
 <30f9292e-e6d3-4fd0-8d1c-f10317ca7751@linaro.org>
Content-Language: en-US
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
In-Reply-To: <30f9292e-e6d3-4fd0-8d1c-f10317ca7751@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68ef1241 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=v1UKZosia19T5iwvbEQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 3RDk31dANd347DXY33YgXGJsSs65hSha
X-Proofpoint-ORIG-GUID: 3RDk31dANd347DXY33YgXGJsSs65hSha
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX/4LRjcGfQ7oZ
 5PcOXAgQlwOt/Lv+w2g3ctoWcoiZrcxPjAtjU0C7+x8dVHUIj5Lvj5NtxYp31Mj96LqknusJfA6
 415baBQNTwmTQ+WY4M9ZHqcT3ndVJFd18pTdC021WkPePHVbRFF/rZJN7mSlETzRWgCZO1tLa41
 FAH7tZOwbWsLjpxPSL5HweYqCxIAVvIXOZ7XE9xp5S2HRVTji9YSajRTCqq2cw6i2E5UkCNXz0v
 RtB4fe3AsUmFTRZ2WRczFFtsWF8kL8U14SuMVZ6LIBQwBjaksy/Cz1YTWsypwYJiYrYQTo4fqDx
 T+6kpGT013dt2/Vl6/d3nOsK1H6sZOvsokOeqWn2C/zqT9S5NWRuCEuB89o0wM5zv/0MSYW5Nn4
 3L8/xZ2ObUgaX8HYoUu5hYiqs2hOQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

On 9/26/2025 6:48 AM, Bryan O'Donoghue wrote:

> On 25/09/2025 01:02, Jingyi Wang wrote:
>> Add support for the RDI only CAMSS camera driver on Kaanapali. Enabling
>> RDI path involves adding the support for a set of CSIPHY, CSID and TFE
>> modules, with each TFE having multiple RDI ports.
>>
>> Kaanapali camera sub system provides
>>
>> - 3 x VFE, 5 RDI per VFE
>> - 2 x VFE Lite, 4 RDI per VFE Lite
>> - 3 x CSID
>> - 2 x CSID Lite
>> - 6 x CSI PHY
>>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> How has this series been tested ?
>
> ---
> bod 
Will update in next revision

