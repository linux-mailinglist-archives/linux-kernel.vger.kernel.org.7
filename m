Return-Path: <linux-kernel+bounces-796740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436FAB40698
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D59320551C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CE0308F07;
	Tue,  2 Sep 2025 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SWE+h9ba"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274893064BC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822873; cv=none; b=cg0PYzo1oMlto2U3dTIxa1ByVwqEpMRBVBSxWpvjjoSFXVSz6ojLLBa9WSdgC0LO/CSDTA/7wXLXrJhtu+ZWwLgs/pzhx2TrzgRSJq9q9g+JX/VL5bkuFJZU1lS0LrCqMpb2595vYJQMxVBcxOoqvfvbbg6Qdi/9/MlLqFRALEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822873; c=relaxed/simple;
	bh=Mo3fvh+zcipnakizUINPMwCYdgGPfGwVYd3T2yXE6PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nC7AYjiJeS7up83PtSljdUKsDSDTN1Mg1QEO4id8X2F3oMwgauQKtmGLrWb+fEq2JzYOTX+S+6XwyxPgA539tUAe2uK5es8Z+gatKZAua9N2fwen3QDtAZ9KAagdl7xEzNBINtiRiRK+XL3khEdUoLSah8bC48Sy0NLs3CdJ5cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SWE+h9ba; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582AeGaZ024999
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 14:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cFH5cDNds5B5T/pje3FPEuPlO2hxs24Eot+U2AM5tl8=; b=SWE+h9baJZPg0zr+
	h1VZBwnEPUP82cZ9ImIy24Jh4zgzo/2qILVaNrT21iAph2NMju2XB3jE5iQxS7uG
	Iwl1soq01wpYlpscMNpjn3haYm3gzIyvm6XWOYT7tfCemR+a7OkbNsCEwJBsCYVj
	gOdLUGnVpCtqtLB/Q4Z5j9NgLmA3R8J/wshkDR2wcPJ2EEMN+7WDwr6ta/UvVMJa
	+4z1oo9rg4lSxeIwSBHqFAk5fJMlsDGwRd5BuNxcy77ZMn4TxnhUw22EDCyS3UvR
	hTdD+MpQOgivxSlhDw6JFyTADU0xanIEsPOSM5PBMWUz02c0xzvKuM3oT7InLn3Z
	1fs5Ng==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv04mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 14:21:10 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7724688833bso2917442b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756822869; x=1757427669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFH5cDNds5B5T/pje3FPEuPlO2hxs24Eot+U2AM5tl8=;
        b=FKLb/KQzMHjTO5d6q8yRfZLj3zl5r+62bxeL/PTcHCE4xdcyssRhk4CMsvNyTEDFYu
         aCj8Tuin/PXFOpM3Xx3zKmQALfl4Wj7CstzLP5qOkw4+JjF1hvlWwviNS1qY5QOu+SL0
         G02bYpoxkV60K7rKBpvKVeN/Cw3vaGlRYgz1ekwFcjvaEk+cKFW//jSz9sfB4VA4ARYA
         F85Ln/E6AyLXWvGQQFAXAY1uSLEC+QNfJWlyg2qO+btW4GmYihUZb+CKRWd3qNHiQqHj
         5AajuScGYRwjdY55rNe86Q67hJX6COak1XqA+BYvIRXj3YUaHUvrBuOQxzJWIXKlZDCr
         xv4g==
X-Forwarded-Encrypted: i=1; AJvYcCVEHwhXv8vgcyOgkI93T0+bqv8h2HitwoBrGYy+umtiMXh16VlmQPPDgm3GOzQLdynz2+ksdfwcdeWBKdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw46DrDKV0DyzKoNWXc40FBRHdB0N/goze2TtG6Gfe7pze9QdG7
	nJS9w8cEJjCsZYW9frt6qIidPgzspv+0SNzMrM1QVPC2r7GpEhDz0VJMZAT1lanqTGvqlvp9xSi
	tyIn7IyCUWYyGJ2zfGVYiy49vzWgImC/pSHF7DawgdZu/qwBhAkVxKBYBsa9Tv6pXiD4=
X-Gm-Gg: ASbGncvSH623Kv9So855nFE0RhFHWvKrijHlW5vJ6Faxnw7yG0S44hkr402ZzgtUvK3
	7U3SgfbuI43/olxRHqHRe8wXLjcJiRf5kDe0zF3wbH3a4Z7xyU9bNJaJu+OG/YBz2xqcUgWCrdW
	akTF+6PzYyGcPKW4mTN3XUyJeaRTmISS8aI6qf+Y1YAh51TVVwcQzM801ne7PhoUDJmyYk4RU9M
	xLi7N4FVTEa8xkwe2kKJ9vOAo7CT/2vmLT0MpG+9Sd+U9T2WF/tFcPOSNTymR+DeE+Sz2caAfTy
	jf1cMbQk4EOSO1b3gE3L7/ElM5ePogLjhQUXOouBl5UZUjxAUqfMc/XhaqgoPc0pkBHHnxyk
X-Received: by 2002:a05:6a20:3949:b0:243:25b0:2321 with SMTP id adf61e73a8af0-243d6f7e6d2mr17559812637.52.1756822869344;
        Tue, 02 Sep 2025 07:21:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqXouN6x5NC3Ff1ESu4awUlD3wgjdZZfk9g/KwRyDmJBn/xJVqTV3xHk+1W13vbBTuHhuaMw==
X-Received: by 2002:a05:6a20:3949:b0:243:25b0:2321 with SMTP id adf61e73a8af0-243d6f7e6d2mr17559757637.52.1756822868877;
        Tue, 02 Sep 2025 07:21:08 -0700 (PDT)
Received: from [10.216.7.97] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2dbcsm11499176b3a.50.2025.09.02.07.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 07:21:08 -0700 (PDT)
Message-ID: <f7394b06-d51a-cdbc-7990-13209b478398@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 19:50:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v14 03/10] power: reset: reboot-mode: Add support for 64
 bit magic
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
 <20250815-arm-psci-system_reset2-vendor-reboots-v14-3-37d29f59ac9a@oss.qualcomm.com>
 <88ee0a26-8d64-4060-b703-40156cd011a7@linaro.org>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <88ee0a26-8d64-4060-b703-40156cd011a7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfXxARdJs9b2/rR
 d0NAqkgD/9CpIgQ4yZ4K2J3U2WmZ+LiyYeKqge0UgAH6ztpVRnzHCr/BDH1FFc/J4sO1f3Qqnvz
 2qZh15YRj8co+7LaUMf6gGABfYPxbe4CbnX4fZ/vGrI+1JP71xMR1aYT+qY4KAA+KQaG9VYBq+u
 agl2PBc9xgjnlKADyXbz0kx/n6i+3IPyaJraEW08cSaUlfgKZWwEfLZKjV0IzaeiuOcKKe4+ekZ
 A/YJXr7gLgFrZOycHaL8D1MrGL1ViNppmlAMb4wPMrwYyGXc7Q1p7wr4gNIW2V5RQNN0ceNSc6A
 yC0ZMQHt3TeoGVUIkdNS44C66TZzwpIqVTC4L/71YgYMncBk7QJayjGElc7Nfdj+ZQ6xmCrKVF+
 GJln1uB8
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b6fd56 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=FBzynz1gJkPyhc2EhIcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 2HL1oKkM7BOsQmWsQYqXiL_asmfwzl75
X-Proofpoint-GUID: 2HL1oKkM7BOsQmWsQYqXiL_asmfwzl75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031



On 8/28/2025 6:52 PM, Casey Connolly wrote:
> Hi Shivendra,
> 
> On 15/08/2025 16:35, Shivendra Pratap wrote:
>> Current reboot-mode supports a single 32-bit argument for any
>> supported mode. Some reboot-mode based drivers may require
>> passing two independent 32-bit arguments during a reboot
>> sequence, for uses-cases, where a mode requires an additional
>> argument. Such drivers may not be able to use the reboot-mode
>> driver. For example, ARM PSCI vendor-specific resets, need two
>> arguments for its operation – reset_type and cookie, to complete
>> the reset operation. If a driver wants to implement this
>> firmware-based reset, it cannot use reboot-mode framework.
>>
>> Introduce 64-bit magic values in reboot-mode driver to
>> accommodate dual 32-bit arguments when specified via device tree.
>> In cases, where no second argument is passed from device tree,
>> keep the upper 32-bit of magic un-changed(0) to maintain backward
>> compatibility.
> 
> How about adding a n_magic_args property to struct reboot_mode_driver?
> Then in struct mode_info change magic to be a u32 array of a fixed
> length (currently two in-keeping with the DT bindings).

Arnd/Rob,

As per previous discussion on patch v10, magic and cookie were implemented
as a 64 bit number (64 bit magic).

Need you thoughts that if we should change the magic to 32bit array, as being
suggested in the above comments.

thanks,
Shivendra

