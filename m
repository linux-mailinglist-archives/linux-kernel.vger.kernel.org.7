Return-Path: <linux-kernel+bounces-858353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B73FBEAD97
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463E3961123
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5918F2F12B5;
	Fri, 17 Oct 2025 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GtAt1Kef"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04D4330B0F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716666; cv=none; b=Hkd7dWs4jvkOZmE0bLoNBiCmFSNX1xRpGXJGb/R2yRaPOWC9Iu16t461n5BmwQFOlPBvozJLUnp2buHfpvZQGPSBoC0y6tGXB7yOmvV04oeA9NoCd6JXwPgu1oyixZOTkrITjwUmjyWW2AWUrt5SGD3Uq2eFIDgX5LBFN58/u1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716666; c=relaxed/simple;
	bh=1z8mFPc+g7yAQ/45ZUryZ9zAoZA5Kq2Um1llUPtHebc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIlW7uc5wSdGo6QcZxVvFaKFX0YeFWhklkSLW68B1RZ7n5liQsgcNKAx59r3bI0KUAbGQmHI24cw71uvMVFAqCgZ0jGoTM6e2xHb7AH5kVdV/7olS03H9ck5o855qSREqqqP6x7KKslnVXisrDZLrQQWhBUYWcRyOrCQCSDMFiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GtAt1Kef; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8DU3B022287
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GA/XjYdGjZ7tzpUjYOV5X8f91ozwneXQxXQ9c7C3ybg=; b=GtAt1Kefag9lGI6W
	Y7+UMD4gK2sEnhYr4bxvc50x/7GdpfhBWJqZjlL7CfGPoBbYAwm7RSpgwFnMjIYl
	Ab4kHiP0EsQ64P0MhXtRlMruwvJtIWGwdhjd/i0PIyDfsAVjT6v7BUuF44cadJbF
	MRIVfkZPqc7bM85sydhJQYSHkzFoukZNkV3pnuycXnI2nUPrgGLM9Zjikwxl0rY+
	BuWr/dB1u5c9XJaoMAArJbhcFbn+g4MznrbP2GYckqiRmpEvzzxZWl8tlUfckHTd
	c2HOMxquKS7xKDaJOpRwS0whJ51DGiEo+JUpoY6Fdtx+v4yySGJxQHXjBzwfOBAr
	pe0dTA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrthtdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:57:43 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso2080442b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760716662; x=1761321462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GA/XjYdGjZ7tzpUjYOV5X8f91ozwneXQxXQ9c7C3ybg=;
        b=IIhYPI5l/ifeNYkSAdnVSs6TVCPNl16TjKGkOC3eMjHtBxELSn5RVGQurlE290+dKj
         I2FC/cOkXSOpsWHCO45cgRlXzrYrPMZTmty3pebQ+Utw/ycT0NSwsRtIj76yNRo9Y5Gv
         +PMzuK2qJOz8jogOh/APBRLwYymAOPzztobTIsmRW1aQzx8WrxxbtV+udyxVbOtdX/W7
         bgd9U5L0lmNFBHrCSzg6GXGNEA3VwGy5JEwsAT7pwjjCJUi86KV2F7j2CFw0gvsVg+6W
         0+qQCciHesdGI5mE6NWzoTJMYdto5QGM0giOU7ivrCK2bpxyhRqHxx+ZKjgUVGlibWeW
         MeRA==
X-Forwarded-Encrypted: i=1; AJvYcCX3EJpeCDxN9J5480PT6erHaacRCVxXxVYboxVDI6nZiBi5vni6gf0+3RzvHpb2hwdc/2bSZfaVm/yQz5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk5cnnr1O7/ay25hE/ejjt4Ef7rAaBTGbQZDi6hQ33XHsP+HUm
	HgEs27OAwHFzW3Ma6CiItdzD4jki1k+aKSutP0eKiCYxF5XOPsAnzbRV9W7gThreb6V6CeofCPL
	3S8mu5YTNojf5L4rOSvWM/nOjKJcxwsWnTlxxP+z84QTOfRquKoQASADmJ9zpY560Oq57IWgI4m
	0=
X-Gm-Gg: ASbGncuhu2L7WiDIKxpBjuaXTmBJE05A32nriYJG/d/3EQlpqTU3j/kMO+zpgVZVOie
	sPJdgHVa7S431Pn6UrG0X2I+IceiLqYl+ui/ba/tV1pZcWRYF5P0sKYEmc/sfx+QQum0B1it+ng
	Lu3Ewvs9lCEEf0E8pWB43G0WQnzhOggfJbChAEe0S5y7M1Y0Z7L28zjJ7dG1jrkczGqF3Pjir4J
	vGN7QzVFdgOPIB37O6B1V+TLhzOlju2i8fCojByf6Imt7G1y0w7FoF/Ejv52O+bSHdT2xXX9hrO
	fE0wVelllbN70T/VzS1Nubl4wLw7pEQuxV6Ub3Pkb+7eCSH58GunVdnVR/74kss4xu7T14RVwUb
	+ThKGN3zhklh5YEY/5YE2U/RKotkwAAZ97iOsHfCaaheY4qoMOczjHKa8Vq7dmmaoLxBQ1xc=
X-Received: by 2002:a05:6a00:3a05:b0:781:1e91:fd8c with SMTP id d2e1a72fcca58-7a220a83474mr4870549b3a.11.1760716662326;
        Fri, 17 Oct 2025 08:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEG0kQQyBJokWPqPUpBDr+VClTQlOa2zZV29zqtuleUAhDclL+l5xJ+z+cpPiams7RTcEdAg==
X-Received: by 2002:a05:6a00:3a05:b0:781:1e91:fd8c with SMTP id d2e1a72fcca58-7a220a83474mr4870521b3a.11.1760716661866;
        Fri, 17 Oct 2025 08:57:41 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b065ac2sm26007964b3a.16.2025.10.17.08.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 08:57:41 -0700 (PDT)
Message-ID: <76d4235d-db4e-40f4-9ede-8cb536b82fbd@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 08:57:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] ath10k fails initialization, bisected to "wifi:
 ath10k: avoid unnecessary wait for service ready message"
To: Klaus Kudielka <klaus.kudielka@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        regressions@lists.linux.dev
References: <20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
 <175823924851.3217488.17742065327824732992.b4-ty@oss.qualcomm.com>
 <6d41bc00602c33ffbf68781f563ff2e6c6915a3e.camel@gmail.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <6d41bc00602c33ffbf68781f563ff2e6c6915a3e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LVTjZ8SJP4Gsw1h5WFB0Ux5AKHDVPMu2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX4YK11dkFK5dO
 murU3dsmHD8mP0V4JJOxzdUc33q6WRKam7eoDpCqnaZJOaw55IpqgbLE0MoBxrR6jDBuXw7CUJM
 PZucqbiPb0DjGXORSxuIN7OhswCYx0zGdXi27cNXLqi6B4Ncrc2+HxFimGpoRvfZB/RK1jS48Pc
 YUDdxfT5XoGxSv5fQq8Eo53yMPgNt9hCcHjNtm8qFOCtP94asnI3BadRVo7C9jqjf2LpseI+8H+
 djUhegmmGc61kz6DbuOm3pSSM+VStOVapLnCcC75AJ4qosgByUOxuDVrShuRyZ7FSqWHn7cyxRt
 90vkVTtDRK7eOMfteVH7LmpLnhWsWGgjrqrafUTbqLS1h/Q/oTHoL5BzSdpzGk5MXqsGgMbbNUJ
 3IDgzGV12H23ZKtBAnY7/Rbfjd64UA==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68f26777 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=CbrLfc9WufdjtirxkE8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: LVTjZ8SJP4Gsw1h5WFB0Ux5AKHDVPMu2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

On 10/17/2025 8:37 AM, Klaus Kudielka wrote:
> On Thu, 2025-09-18 at 16:47 -0700, Jeff Johnson wrote:
>>
>> On Mon, 11 Aug 2025 17:26:45 +0800, Baochen Qiang wrote:
>>> Commit e57b7d62a1b2 ("wifi: ath10k: poll service ready message before
>>> failing") works around the failure in waiting for the service ready
>>> message by active polling. Note the polling is triggered after initial
>>> wait timeout, which means that the wait-till-timeout can not be avoided
>>> even the message is ready.
>>>
>>> A possible fix is to do polling once before wait as well, however this
>>> can not handle the race that the message arrives right after polling.
>>> So the solution is to do periodic polling until timeout.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] wifi: ath10k: avoid unnecessary wait for service ready message
>>       commit: 51a73f1b2e56b0324b4a3bb8cebc4221b5be4c7a
>>
>> Best regards,
> 
> 
> Unfortunately, this particular commit completely breaks the ath10k driver in my setup.
> 
> 
> Hardware:
> - Turris Omnia (arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts)
> - Wifi card (output from lspci): Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter

This issue was previously reported with that particular chipset.
This is currently being tracked at:
https://bugzilla.kernel.org/show_bug.cgi?id=220671

It may be useful to supply your information as a separate record to that bug.

/jeff


