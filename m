Return-Path: <linux-kernel+bounces-837823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A1BBAD425
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4296C481B76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82523043C4;
	Tue, 30 Sep 2025 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OLW+vJ3P"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915AA199939
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243726; cv=none; b=q7RccVkVrDjVMTraJ6Y5fbnYzf6R8tlkFGPr8aHvpWkDWqc0p8LJYwGPyt1M9StJj8QSd57qPDZgGPiU99Gdl8Ys6NaWk0FslcOMurs1YeGzfT6UtxxbEB6e4FijAv1iWUmS36ko1GF8Flt6VHxpauWtLzo89F/UzlcwRSg6LTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243726; c=relaxed/simple;
	bh=xlIfLA1oaA6T5jp4n/5OOoy3fmAnxSFOgoE7Hix8V4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PszGHsjtZGqSPM2KTfoRHt2lw+9yaToiL6i4hTcRoHxhSDM5/uSHD1ArxfD39i9Pnodbk+jEXXaLXgreXiVhRizBO9StMLNL2qBG2OLOOIF3xMA8WEoxKuvUX1gMCGAA1qLP2K4Q3WSCs9oXe0OPySJwjVSSKiki/YBIOW/qX7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OLW+vJ3P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBqCGG025066
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zTrFqo2G5X3RRcNV8uDspTf6uHtkQQZrnEeBFh6o8ZE=; b=OLW+vJ3PkP4DFo2X
	v3s4vRj46NR77kV5BkVY5NYB/yumFOYsGDoIurHo95tDEWs4y/10eGrVc5av8ti7
	XgA+ZOf3cvccnPAAT5g5UA5TCakjihfzbnVzDZB3sj4+GPZ/iCZJEGFSj2tOOQYv
	2FEAoh2QtXuwmFCrxfybGuYx9OkBkXZFNUrbeLWDLuHIDrIIUdh46UP/GlHcDHJQ
	TbK3nFUGnaoVNN89N6vkqIs1FsWXClu4lVCgP5EjgKJw86YPn6ujQYUBvGur3luP
	jCqnxxZrctR1giUMs9D4+E+NxZ6ESVwj+jxbyRqhCEM9ndPH88d3sj86YW58fPPc
	XlEEHA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59n1ngr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:48:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b550fab38e9so4189783a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759243722; x=1759848522;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTrFqo2G5X3RRcNV8uDspTf6uHtkQQZrnEeBFh6o8ZE=;
        b=EXEiCWzJmBNTRoNQMGIdY6PwNZNtDTuza/Rak+pFmIvM5Ni/3B2Xa6EpmZrbO6uL4s
         m7Us6bPWSXM75MEb6CQc4bc/+eeGZQE0xQRtWhdhFUTnORpCzKYql3ZB4XsiqI3RA3EM
         72WOZX3DIeE+c9vpAn6F84RD6c5RoepKHbevrTFopoOP7sU2klgwJEkYV2ZI0Y1Okum3
         ysSV60RezZ45VKvcBpjh/e1110FSr5/haAEDQnEzYDCnCQ0JAXdeb3ucxA/7A4RvMAqC
         3wisCEUG93UeEGM5+tyP4vasRhHj67OuPaNS2L5B/6Jp5mSLBrjXaFgyi9o7u3Wh4Qw8
         N/DA==
X-Forwarded-Encrypted: i=1; AJvYcCVL3f4wOrJRRf2pIWtDnI0uMLhS1T5Br4EhigtHC8aPJuN3QVX2FhiGg5d2M4MaT5pPu1Y8JR0lpPXydiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcul8vDuMee+yBrXWKmDvxmqoC/GOE8b1/4+kXh0BhS6w4WnWr
	MG5ABdZgfU1kY6qUfjA/R8IpkUw4YDuxMlz3L1YjGE09EkLTNv0tV6ahrN1P1KvCbUJjJJWl2By
	dum6TnzoSWoK3SOGSMzG8Jf00BJPz9tqjN4zSGcuV3DCsiMAaqNCY9e0JyYVbwR37fns=
X-Gm-Gg: ASbGncsz+oIHRYSKOOrP5gQH6/whWVV6LmFz8vmAv9820eiARe+qRHJWlEBlMgGSrd8
	/FtyDHgZUq0UBO/8RxeooZ1B0VOyk4GtHTp6RpkNG9jg11v8c84YFmoVvAsn5vAQPiJg3rmwclV
	HBbEM724emc1eDjGv76YyQnMzWAL9NXGAOPZsqcMhP7a6W9JmojlFfofTx/lO3qDtME14G+UhXN
	E9N9CQGOI0juzvFNtJxOC2Y/h9MacE3XEfp5M+x9dpWRxyxnXuSZxLdwNVw4P8Vy3507vD4eucT
	e0Ma/1Z56oCgl36UYTppjEFojBBBJxGzwZvS1r4W84q71SWB3OxeK9ADWIekKnsMLpXBNCw+DoU
	rcBQb4j78b8txGApMJ2OiS5c+LATuwJHE14OfaZY1Rw==
X-Received: by 2002:a17:903:32c5:b0:269:7c21:f3f8 with SMTP id d9443c01a7336-27ed4a31641mr244257375ad.39.1759243722144;
        Tue, 30 Sep 2025 07:48:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4IzyIN9n4Q/kQArD8ugLcGVgKxYLLIRgU/ERTMY0enbO+NarkvMw4yNz1KuniTn2rlcIqqQ==
X-Received: by 2002:a17:903:32c5:b0:269:7c21:f3f8 with SMTP id d9443c01a7336-27ed4a31641mr244256915ad.39.1759243721637;
        Tue, 30 Sep 2025 07:48:41 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed670b315sm163012895ad.40.2025.09.30.07.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 07:48:41 -0700 (PDT)
Message-ID: <13eeceff-9f2f-4673-8d23-eb439a687531@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 07:48:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: Add missing platform IDs for quirk table
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: jjohnson@kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20250929192146.1789648-1-mpearson-lenovo@squebb.ca>
 <83de6105-ef4c-48dc-8960-430893ae253e@oss.qualcomm.com>
 <eddb5c03-e919-485b-a6d4-06485cd87db9@app.fastmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <eddb5c03-e919-485b-a6d4-06485cd87db9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jCzuHkS49XC1dG0_P6mA1UPNpfxj1aQ7
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68dbedcb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=wRxfcatdMthqClwbIL4A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: jCzuHkS49XC1dG0_P6mA1UPNpfxj1aQ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfX9V+q84gYV8PV
 jDZMDF6N+OpfKNdvU7RJN4TVuJ5BIsNN9r6+JOX7BE3XMwqJSN0m3vkpWzolaUQ9jvUrwUWFamJ
 OYK3oFlTsVxhmVxKta33lhn381LVWFXeR+a5flUlti3vWVUbs+YM33a8WUeMf6rwrRGvfkUaOcT
 WNlsi0k1lhUievkRpi3/GcVmXt53OLS8UP93d3gZtyi0Gp0bNju/rMY6/iNsNBe181UHxzpO/B4
 rmu4LTy6faUSeAHNSvXNkVVD9u/TcKlRMA7JG7W6bJX2Lg9Iln7TQ+IHayuVmvMw2URDVjRYq7K
 Z3uJ0lmQPjiXYI76JyFJo/18k7Q822pcdSjN/YxnB+ZAZugBmD0WCmMk72aKQ8kP9ZxhkM5xEBq
 mcVywODffrmWkheoHw5YZLT45UAsWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001

On 9/30/2025 5:05 AM, Mark Pearson wrote:
> On Mon, Sep 29, 2025, at 10:17 PM, Baochen Qiang wrote:
>> On 9/30/2025 3:21 AM, Mark Pearson wrote:
...>> assuming Jeff can resolve above nits ...
>>
>> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> 
> Thanks for the review.
> Jeff, let me know if you need a v3 with the small changes.

I can address those in 'pending'

/jeff

