Return-Path: <linux-kernel+bounces-833420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9069FBA1E95
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D9962346A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBB938DDB;
	Thu, 25 Sep 2025 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aGbwZ7eQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F28E2EBBB0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758841409; cv=none; b=XdGSWiuroOFGCj4tGez10hAITGjvKFAkbwrJMGxgl8mtUXnpgWlxE0iOZPc7lUAGLg/JpjfEoP0OPDJBMVWnyIu5tM1Tw6SZFNqhHeLfWAmkA6p2uwpgC6FSPO6TYpbRJqyh81AGZ2dyu3xSICD3X4CzU2LbzO+CMPPqhXhxBnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758841409; c=relaxed/simple;
	bh=Re6vJcgbqIa0a2Z8s/dyJr+80qdfjB5ADuATqHo7/iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmOBAgbyxqMC4zbvE1W5kVHc1wzYnLmsasr5jt4I1vsFZgY4PqvLnQ+L+iF4dlEEbVmCb9TTvlQBYD9hfJJxPQniaQfc+OU1OaTV5L+529Gnch1JTRjtnrgPPw98/hdaRu+K1jqBNi5d56mV010GxQz0o7KxajCbDecTWmMTuK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aGbwZ7eQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIQL5D022790
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WfzKhTLo4L9EzNBCoQA/Ic/EtRob2BTZ1wUdjds434Q=; b=aGbwZ7eQaktzZUWg
	TtevFKgN97y9vQBzP88J7XVt/wMNzOmew8z97fNrK1c5Kh2V3DhUBDjDi1g2VtPR
	8S1/M8Mz4j/Aubuz5cnHf7znpl2VPnxpIto7IyLMvnz8L+zZKHFm3Bf552x1nkme
	QE5/wnQACNH4COg6qdHBk1bv+A2TT7IilVu+WTNsIxRaoJiatdxhwx+iRP/ynafO
	XY3VlPlhJNPTTILXWRujMJOaTM9uiv7PoSzfa/69EeO8IxIazJwE+bIxOj9jvcWE
	10mhHmmmvp47afkRDWXwUtV7QjOQNxbQXd0/4P6XN+0bE+hciNoUtr7n1ovtHVt/
	EVSN3g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0qrmyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:03:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-26985173d8eso28607935ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758841405; x=1759446205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfzKhTLo4L9EzNBCoQA/Ic/EtRob2BTZ1wUdjds434Q=;
        b=kVAOpFsnV6A8FFLpr6Nf8vWeHMbcSLPh+Wz4kALp9N7gVkCxBVOpnt/NqVXkFb6IXc
         Ipf1VwyBgc8anN26L2xvxCd8ViUblyzTQPQV9FWwFbrPRCGCwlxeUDAdY3kRtGQJU9C6
         5tDMi25pV6MOX9g4Zifn+8n5NDTM9onSJX5lBhrqpRRv8dYDOfY4djnyQ5bPkx1acYzj
         Jvc5NQINY0ISpIy67kRmZDcR6BOEk39ACSntRWkOnG/8hmMuaHRWE1bKh8TWqPis2/7q
         4K1sGDojP3RbPppNIh6R1eO9qKDJCcpOKnVs/cLU8am2PauScbnBbPo3QkGpBQcim06j
         g37Q==
X-Forwarded-Encrypted: i=1; AJvYcCWv9M3FBGy1lPQtsfpgwMB+ZwJHBX9sPsWWHwAUUGhFvUQBDRcziBK5ahiLic6272P2XtO0F2XE45qpED8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUDROihjlWmXYmEKc8l/bR05JXYU/ZKt9jof1rJO1Bj0F/2ovG
	9PyMJtEZ8xA3WYKhp2ZoxIuj3EGuqV1x4eX5EJ4dUWhHFcEpHu0NcdmHZwu+is2sCmwQbf0Gj3o
	f30buMdYVLtT57k7tgSREzD1/+ywfOaWQ4dGaf/WXip4qldO2NH8InYwy6JNQwFm7W4Y=
X-Gm-Gg: ASbGncs028WM5KRgXkpRyxdYzfxLYZYCtQXVK3o77av+xkcbpkufR5sRJ/ZRSNuKaiQ
	5IaMcRfMLQMRhGqonLbn8kROxwW7tjk/Onw1Ing12/xGBF7ryN3MkSFPrvl9T3aDM+0I6YTRBum
	I3uQjnk3Tay3vk/pX34f6pAPN8DrJk6X6JutIVqH/FVrwmEL0iV+G1yQzIjA3Fw57ySr17EB6Y/
	YL9bFzhnDzIEkCJJHqhPDzeDxRh9JiN1fQAP9HACPc3nf/6ukpyBcRpOEL6cdxDkb5BoTC/dONY
	geOtw1U0409a+2u412J2fUFrzIqjOV/M64wqoXQB2Uoglqh6aQeHKfagUg1PAcZPJVdkzJTCOXr
	bEBqXVv8=
X-Received: by 2002:a17:903:2ac7:b0:24b:270e:56c7 with SMTP id d9443c01a7336-27ed49c771emr61707295ad.7.1758841405505;
        Thu, 25 Sep 2025 16:03:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHOJqmjzO+AnKfT1eW43G4SzpCox+5vXEEMV2sxZr+rbaIyUa/gbfX30AzcLSCvAvNAzb4yA==
X-Received: by 2002:a17:903:2ac7:b0:24b:270e:56c7 with SMTP id d9443c01a7336-27ed49c771emr61706895ad.7.1758841405047;
        Thu, 25 Sep 2025 16:03:25 -0700 (PDT)
Received: from [10.73.53.199] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ad1d45sm35260175ad.141.2025.09.25.16.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 16:03:24 -0700 (PDT)
Message-ID: <297ee4ab-73f3-60d5-8e16-8830135603f1@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 16:03:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 07/10] phy: qualcomm: qmp-combo: Update QMP PHY with
 Glymur settings
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, krzk+dt@kernel.org,
        conor+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
 <20250925022850.4133013-8-wesley.cheng@oss.qualcomm.com>
 <bc866f21-9b41-43dc-b450-59a25d547b88@oss.qualcomm.com>
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
In-Reply-To: <bc866f21-9b41-43dc-b450-59a25d547b88@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _Am8i6022O-E5T9EAuTfW49ntaAzEIsB
X-Proofpoint-ORIG-GUID: _Am8i6022O-E5T9EAuTfW49ntaAzEIsB
X-Authority-Analysis: v=2.4 cv=api/yCZV c=1 sm=1 tr=0 ts=68d5ca3e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=R8zOBIxM2Q8kPqU31PkA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX1nHaeT8f4Gxy
 9Sy2Ff49j0ysg4gQ28SDRjxzRNqNYwyUiizQ0DMMV2lTHAGKArJ0TQpGuRu3KWPwiy/apy9/goJ
 5e41kVNL7cHMWj86xwDoCm1++LfL55ulccFgr+aK0MNnT1ewVEwZ8AdbX7aBOArzjtnfuLjLcuk
 fnZzU4Gc1ckIBO85Xtiv7nqVJ7aGlNGnhUvH6K4pg/oBesPfK6IYhP2+ckAiyY3futsUbN/dUlZ
 5mQ2ViWn6Wu/EonbHC0h35oaDM1DCsZLVBckwgd/ajFFPz5S+LTDNuV7g9Q+gJ32r+ceeMqqEXg
 InEwm8l35npUbpfnPmbny230n6a53dD6ZokAvvg5fY9WuNbf0wroSSepNu6W9dnU5H1yFRV+zBD
 H3zN9Vv480MVQ4mRYZ5Saw2MJKOKfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171



On 9/25/2025 3:43 AM, Konrad Dybcio wrote:
> On 9/25/25 4:28 AM, Wesley Cheng wrote:
>> For SuperSpeed USB to work properly, there is a set of HW settings that
>> need to be programmed into the USB blocks within the QMP PHY.  Ensure that
>> these settings follow the latest settings mentioned in the HW programming
>> guide.  The QMP USB PHY on Glymur is a USB43 based PHY that will have some
>> new ways to define certain registers, such as the replacement of TXA/RXA
>> and TXB/RXB register sets.  This was replaced with the LALB register set.
> 
> [...]
> 
>> +	/* override hardware control for reset of qmp phy */
>> +	if (pcs_aon && cfg->regs[QPHY_AON_TOGGLE_ENABLE])
>> +		qphy_clrbits(pcs_aon, cfg->regs[QPHY_AON_TOGGLE_ENABLE], 0x1);
> 
> Clearing this field is going to prevent the PHY from ever going offline
> 
> The HPG says this should only be necessary for keeping the phy active
> during MX retention (and the listed usecases are USB4 wakeup clock
> generation via a respective _USB4 register and/or USB3 autonomous mode
> operation), both of which are currently unsupported.
> 
> Are you sure it's necessary / desired?
> 

Hi Konrad,

At least on the PHY HSR, its mentioned as required, and if I remember 
correctly, if this wasn't done, I'd see QMP PHY init timeout.

Thanks
Wesley Cheng

