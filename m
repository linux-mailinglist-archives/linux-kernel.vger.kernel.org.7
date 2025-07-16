Return-Path: <linux-kernel+bounces-733068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1716CB06FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB10B18892FD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01BB29C338;
	Wed, 16 Jul 2025 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iB1Vv3du"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607321B394F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652464; cv=none; b=C4ijwiO0R2TEpd5nCaGiaUaFlb8+ADGoqtQnggV7L45KV1MNMKjuSq3iOa/yxXNomyDOsubx8bWJ/5hVnxFCPkJNg9/hYKMo1qvuL/IsSDo9u8PyHLzMMNid6GqLyfW8Ces9VXrjOfZLSAuh5SkZRH0QfKMMjlSZ8zF7hLtJWpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652464; c=relaxed/simple;
	bh=WZPrGCih4QhFqUjqncLKZbwNIORABzOIKJgzxiGn7dE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ls/bMN5pHX5YVwrcWHWa500Ixvj46ghyg3cT3G0567n6G9+Kvb9uVWfeDV5ZHXfl7b/XebjA6Kux5AJ/xq4LDsm/9qUSlMSiphPjBcoXR+wfcZRioErsO/gKiHY3Gaoqa8rGRnjXDJCUCivr949E9ZFl8kkfxa1j8dqhbnayukM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iB1Vv3du; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G5PQDf029739
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RBrfWQZ+1CwS128iKb2ACQE+uP5XIkInTUzV1zP5bIU=; b=iB1Vv3dur8IyBWtF
	tj4RLsJko0Ti9cVWrW4gC6aiptVr1lx73ghDqRGvDDSxXd0dmnEb+gg5hM9SraGI
	uenYrwNSGZBRMzRIyeMx37rJ+Q+6pjeKHRR72IAD1XKhu01GWBuuEHTcrt7TtVEx
	/1vDb1ku70vCF1ZvEHNkvI6eGKBq3EUXkMva4ENauN/I8P37oQJKaoblHXTSK5iF
	JK8fhatakKwLFLky6sDn+d+35clwBqIBO9HREQ/4aq/9/Ty7Gc9Ade1U/u3opeEk
	Qmyy2TDT+ASYX5JSym1EM01gvAQChRN+BwNXpn5jp28HYPt+mF2pMviKYdeANoXu
	XtXcdQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxb32y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:54:21 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7491814d6f2so6294160b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752652460; x=1753257260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBrfWQZ+1CwS128iKb2ACQE+uP5XIkInTUzV1zP5bIU=;
        b=D71MO1ComWeC9cRlQYV3XDxgtq2BD1hRbSozoEfF5deBB0uZfc0jy+zy+Q5f8dZ1vg
         g0loyf0ehTFmZatc23/jc9tuG3Ek8uXHRpYpJoYa8kgU5XD5mCXv7cyzuq5d8V8ZT25n
         LSHgPFpQuCOydVBu32yfvouvbvEPQKWTWMAwRZ3meMioWTAeaYlISmhsvAr976TwyxZ/
         nmMsZbY4PVem/ZJjixHmiKSc5TN9wAUa+EB/4w3+0JSV0zkuIgvilPOeil6IPz9LQcG4
         tEUSeJtRdK5ziXGw2w5zw2CGfO3XjDHuK3HHujzC0usBVAKLd8D8eh3DHySqAsQOJgvh
         /Uzw==
X-Forwarded-Encrypted: i=1; AJvYcCXy2kwZyXw0bk08ZB/dp6Rh13vsa0iGTTwlQOVJNrUX/1m4l9R4UGMWLw0cJR508BapaJkgGJdOwzrLdFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YweEfq8RRWz1oR50z7u5YxSszIfTHq8z9rSRqupyUy38FP8Xyj8
	GKMlaHup5KfhAJLCtKuIOmO5CbrIQR6xvCThsoVvUWqmd4EIr6IUFAJr4vNT9lGc+S4Ve28pVNO
	E/s9Kvsrr5OHNJ7Cdxs5poKAlPvJftGWsb64WOdRlogGzPqKBnvbEd0CwuI4sS88l/Hg=
X-Gm-Gg: ASbGncsG11kyvRHjcktAPBh7Azt9XC0VHrMN69ccFcGQ55yKK16FlCu2f3qcgM1Ufkj
	ZS5AaS/s8Os6IUWevgcIYpuKcCD197X+tJe88jejobBHVBKJNvdopK9wgJfMmh8Fuyp65GbcraU
	4AXYZqiVMt8QQG+ilTWaQgAIhnHQ/S8v7LGHz+XWGjSdYnD8Qx3Q2KVWU7ccs+3e3zjiG+PV6Up
	1P4Y7l4RswTzB1sAZ8ktluJW4GerVyiuRaevm8ON3e/xB+8EJxh4Z6ZED6zVIyR7MFLrphWQ35X
	u/MhLRNU0WIrMaAiKMTKFA3sM8QobgOkHCdqdkV+8b9gHAFv781MxKYh3Q1jjQHHUtEQ+tM=
X-Received: by 2002:a05:6a00:4b03:b0:748:34a4:ab13 with SMTP id d2e1a72fcca58-756e91399a9mr3454895b3a.6.1752652459704;
        Wed, 16 Jul 2025 00:54:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMaHAZay6FJjbVSrmvnJq5rdjl0VOhjN2ocwn2/dA4ha4qKow12hndyWKDDFwGGN4xY3Wx4Q==
X-Received: by 2002:a05:6a00:4b03:b0:748:34a4:ab13 with SMTP id d2e1a72fcca58-756e91399a9mr3454862b3a.6.1752652459177;
        Wed, 16 Jul 2025 00:54:19 -0700 (PDT)
Received: from [10.92.166.183] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06bd7sm13590795b3a.70.2025.07.16.00.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 00:54:18 -0700 (PDT)
Message-ID: <c13af350-3036-4b80-bfa9-0c3f02886fc5@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 13:24:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: dwc3: qcom: Remove extcon functionality from glue
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250714044703.2091075-1-krishna.kurapati@oss.qualcomm.com>
 <2025071518-aware-tipping-4e27@gregkh>
 <arp6ujd3463lzrpi77e6sb5mwie3uzsyzildct3hkgkni7ozfb@zxomg4beii2b>
Content-Language: en-US
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <arp6ujd3463lzrpi77e6sb5mwie3uzsyzildct3hkgkni7ozfb@zxomg4beii2b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CPhLrvtbGXnlciO5hCtMamxyyls50bVi
X-Proofpoint-ORIG-GUID: CPhLrvtbGXnlciO5hCtMamxyyls50bVi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA3MCBTYWx0ZWRfX2B6pC01TzIhK
 rgk2VcAEGlO7nd7xXdZ89GWdfwaA+0/jRTi2gIfJ7zARqmjusshPOFwwI2+CmFNHwD9F0+SkeTz
 CyRVs8b2pE6seBVfpJMg400HC27R/gQDTpnfs7gkOpf423wWVHBkNvZH05YstHtWHVw8GQDCfh6
 ae9iEv6k03sGM/0yhWVygxgMszOn2HSa8Noxe75nbGhTxZ9NZfkJNrQMVw2LZCXJRWWMSFf61BZ
 s/5OYAIxOj6MBfQVHJZQdVaqrCTncZxmUSh7vgmWKxKcQwAa36+RGPbNA94lEes9+fsD1bTeVRb
 jfgPDvxd+ttoBRuf521fePVGLW1rDfcYMuO02hHAJmcHrdbISJYGXL/dy8DrBfbTLwyqy41YF0Z
 41OoGTECokrIN+8YoPrrpqJO8kRdpa8pB0gqBF4uuWidmOcSeN0tPCpvw5y1Bu92sa2iklFF
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=68775aad cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=oVqxdD7jYjwwTgy-nFwA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160070



On 7/15/2025 11:31 PM, Dmitry Baryshkov wrote:
> On Tue, Jul 15, 2025 at 07:47:20PM +0200, Greg Kroah-Hartman wrote:
>> On Mon, Jul 14, 2025 at 10:17:02AM +0530, Krishna Kurapati wrote:
>>> Deprecate usage of extcon functionality from the glue driver. Now
>>> that the glue driver is a flattened implementation, all existing
>>> DTs would eventually move to new bindings. While doing so let them
>>> make use of role-switch/ typec frameworks to provide role data
>>> rather than using extcon.
>>

Hi Greg,

  Thanks for the comments. We wanted the users of these new bindings to 
start using role switch instead of extcon.

>> "Deprecate"?  Looks like you are just deleting all of this code, what is
>> going to break when this is removed?  Are there any in-kernel users of
>> it?

Currently, there are no in-kernel users of this new bindings using extcon.

>>
>>> On upstream, summary of targets/platforms using extcon is as follows:
>>>
>>> 1. MSM8916 and MSM8939 use Chipidea controller, hence the changes have no
>>> effect on them.
>>
>> Ok, so those are fine, but:
>>
>>> 2. Of the other extcon users, most of them use "linux,extcon-usb-gpio"
>>> driver which relies on id/vbus gpios to inform role changes. This can be
>>> transitioned to role switch based driver (usb-conn-gpio) while flattening
>>> those platforms to move away from extcon and rely on role
>>> switching.
>>
>> When is that going to happen?  Where are those patches?
> 
> This should be better explained in the commit message, I agree here.
> 
> Krishna, please point out that existing extcon platforms use legacy glue
> driver (due to using legacy DT bindings), while this patch touches only
> the new ("flattened") DWC3 driver.
> 

Sure, will add it to commit message saying that there are no in-kernel 
extcon users of new bindings.

>>
>>> 3. The one target that uses dwc3 controller and extcon and is not based
>>> on reading gpios is "arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi".
>>> This platform uses TI chip to provide extcon. If usb on this platform is
>>> being flattneed, then effort should be put in to define a usb-c-connector
>>> device in DT and make use of role switch functionality in TUSB320L driver.
>>
>> Again, when is that going to be changed?  We can't break in-kernel users
>> :(
>>

I think if someone is updating the bindings to flattened implementation, 
they need to use Type-C and role switching framework instead of extcon 
since this chip is a Typec port controller one.

Regards,
Krishna,

