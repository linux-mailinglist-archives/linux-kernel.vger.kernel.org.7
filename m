Return-Path: <linux-kernel+bounces-852120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D5BBD8380
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE006425770
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3940330FC2B;
	Tue, 14 Oct 2025 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bakM4bGw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DB2236454
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431160; cv=none; b=DWF/1PonSDzujwbobwvD5cusOYlBT4pj8+9PBRE2TA7rdpjbQTqoTKJhSuc62n0x9ODvufzG1MpEcxs2vZTklmpi1jksrFv+tBjPnBzvFMrCo5g8IRwmlP9G8bvT5RyLWhPgTyknOkpitbUnt8NjITDEt1j8kyrTxH8aw2pbTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431160; c=relaxed/simple;
	bh=XCLyhDQZH9fCvO15f/wprIbY+hAgLM+n2p+mk0luutE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReZgEdaiFFts2UGU6ODVzJvzf/48oXolQ5tYBdl1zRmHwXW/vEtCsXyTP9/NDfjetVmX2f0+WVH+BUdYcCSXH4h1llKDk783e7Z4Nm4Ox93Cc6ONwxRQFuTrzlQfDmhr/oe90aL1sGHp9qhtMEIOkd9j7KrTs/fuavLwoLv2zOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bakM4bGw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87WgK009288
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XCLyhDQZH9fCvO15f/wprIbY+hAgLM+n2p+mk0luutE=; b=bakM4bGwnhqE56ni
	FeuOlkgxdcpvxOGbaFe63Y5/ik2ItK/rsC/iZ9asTZGV2WxDhaG7a7b2VfrA5091
	bagqKQRFOLGW3+IOFPsaL+OTO+rE50qtGFjCcB6cgsv+EMyOWhvuczuWZtjO15lM
	l+3sy6oZm/TdpcOrKqn+XQlS3iZ17VK2jb21pGb1L8SJgAdDLzYsCfYwwKYFAL1S
	ur14r8oGo5y+S+8j4r2W3myl0h3YHM/bj65Sx7d9Phj8vhRoQVrIfyJ0eRUh//5p
	L0b+7NkRbjCkLvrpsxOBnt3v7pM7TXti6TdvfM1gIL+6jop+15On8LVheq9W5USh
	PWI9PA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt4k73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:39:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-860fe46b4easo287433585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760431157; x=1761035957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCLyhDQZH9fCvO15f/wprIbY+hAgLM+n2p+mk0luutE=;
        b=urNfts7Pi4h8k6CUuJ4+eJAEwTYQ2eUx5B9dHJEj1FQGSOv9wCMRDD0k6ji2MQFhlp
         YDRW1B3TmfcXXkXPqX4xF6qM/QoL3X552LDEs6fttnl64/RJwmRF39pF9UTthFcAcrPD
         7Dgp6Xlhnw+/HTIgfqb+B1p2fKBmO2srq7c7BzpEUknUdFsGeitEJMQ5Pysun42Yzka0
         4mkW9zdRPqytZb0jei5z/9UzkUIXeFBJKGKdr0rpqeTtr6mYF49h9AXxvD5Vj+VXTTAB
         MEdDFEpxiH1AvJt98OrTbSabatOz4NCiIOQIU4c4v6rQgzvd65eIf7uRyfIFVx8hH279
         IHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5JsURcXi0qPkxn9h0TaWTKmHiQIYZO34TrSLXjT0ehkQC/mR1rSEoPGBDcEjup4IHfL0vsaY7xBgDqNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpVoQGzttfDc/PdGLZS7KnXmbBSWAds3dSp/j6A3mvx8YUaP1v
	oEzcGqE2xrhiy3aR2WGSEqQuRssNIkNuCVF/Ji0yAQLw90vWWE8fQ9lHKMgqAOZenVTOIHnL6TH
	fh2vkRtcktRresSBQ8y+FAV9fr86XymGKbeVvChqSonQeuYaariigYugVgfzZryDLtis=
X-Gm-Gg: ASbGnctoOGbpVhZ0qsi9/61MK/gF8zF2OT7YwFQBh+wnyXPgE6Lp0WTshiembz/HHBn
	x2TetLhG1dEEi6y5GFJUCj7kUFzRgBNwgmy412Y0tA/0EecJcNL16++Y5YM0gGrpZyammSw73A7
	oPJg1gie+tXtJrNCTWkhBvQEZFwr0EyDIvj0ejg2+j/ZPvsSAHda3bHQNGcGDS6IvEAoL6Tz19s
	sDpW+e9/iBFeLuw91R6IlIJus5XJnkbHujRPibQucNSB55y/Q/JauRJzYxO0UrXV1Z1WP5Qbuzo
	bbpcZOYkqZCarYCOCvZZDPab52zvGmxUvn1pFcUpJlBykOpZJ/cRca072vk9OAVdKxvIS5d0Hw9
	VxNCSE299PJ6z4Y1T2WMubQ==
X-Received: by 2002:a05:620a:4609:b0:86a:3188:bb40 with SMTP id af79cd13be357-88353e1de97mr2150252285a.8.1760431157067;
        Tue, 14 Oct 2025 01:39:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs03gxOTucfJD318MQusKqI0i9M8ELYP0sgEDzUnWm+A3z95z7XK1SLROs1Q3XvpkX0P8Z4g==
X-Received: by 2002:a05:620a:4609:b0:86a:3188:bb40 with SMTP id af79cd13be357-88353e1de97mr2150250785a.8.1760431156638;
        Tue, 14 Oct 2025 01:39:16 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cacbeesm1065879766b.15.2025.10.14.01.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:39:16 -0700 (PDT)
Message-ID: <78b438ca-93b0-4213-8e42-60d13fbb310f@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 10:39:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] media: iris: enable support for SC7280 platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251013-iris-sc7280-v3-0-f3bceb77a250@oss.qualcomm.com>
 <20251013-iris-sc7280-v3-8-f3bceb77a250@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251013-iris-sc7280-v3-8-f3bceb77a250@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EE1JGlWdKnMQAajfEhqZTg0CbazmTwxu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX1m21o4GMrtwu
 /5HBCyM2Fu3pMuxbpuno3iEzx9Aw4ckmw/1yyFDNInIgwPDtP/IuOEqWXh81LD/dAD/lBGsPOqq
 i3N7DJ8GPqzZhxVMazN7iWGmZxh3/GZpaXkcyxE7GV3OF0W+zOHqA91StD07JSF3N/CetcE2p0/
 WGprItod7A/Ylz235OsEXFWqqEuE53EkZ4YbJjex3aA0292VKddJMrF2WjYS9fwWeFnrldTXl2r
 dm1B3Stm66qIoli2kdEg72aEmsobsK2aS3BZVnc+fwEi3ri05Fe2iVQ0ftKLtqcbP20AdLfM5DQ
 WdmcHrtdKHh+BTZPiQlBjhtrLo19DP5nywlge+ZgEOBx42dt5b4XZG0H+7LL2KaHvW2K3BN19sO
 itUqxOz+BJ2jQ9GhZvbLcOVwDel8fA==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68ee0c35 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fr3eplbp6RILtt3BeFwA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: EE1JGlWdKnMQAajfEhqZTg0CbazmTwxu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

On 10/13/25 4:09 AM, Dmitry Baryshkov wrote:
> As a part of migrating code from the old Venus driver to the new Iris
> one, add support for the SC7280 platform. It is very similar to SM8250,
> but it (currently) uses no reset controls (there is an optional
> GCC-generated reset, it will be added later) and no AON registers
> region. Extend the VPU ops to support optional clocks and skip the AON
> shutdown for this platform.

The last part is a little sneaky.. But I think it looks good overall
now

Konrad

