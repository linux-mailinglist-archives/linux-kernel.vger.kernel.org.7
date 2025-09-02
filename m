Return-Path: <linux-kernel+bounces-796063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AB1B3FB78
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3E02C318F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C07B2F5303;
	Tue,  2 Sep 2025 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gVCdi+Ji"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684B2F49FC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806973; cv=none; b=Z+xkt+JOhC98Put7dwmuwkRK74DSIfgWkFcbqLC/tjP2y0Eb1APz4D4VQ1oob5KfaQayVzilFAFUsGEn8p8gmYPuZo6rMz/XhO8Nrp+nyen4PCoQqO2yUY0F5l7CertoNtEF6Onsnm9O5NW0wZf9Mk9N4jicM7kteYjJZHFcoRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806973; c=relaxed/simple;
	bh=6cCV1wRKzNabvk8/xfdlhZ5ZHgh6aqqij8ou4VgthzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDn4v/zPeXYS6SoMha8XkqwkBcSEWlWUZ0ST/vBE6pb2pT/uuFGOp/lD7HsLv05MLSkFH6KLOER5e0ZiHOs9qHwXmt4zMzLnqRF4AZZV+dhyXWxv2iAmcIsurSfyL+cGMaC/Pe3klXVju9FdJRufzMzh0YNzeXdtYO7dgppDd1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gVCdi+Ji; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Wg5G030916
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 09:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B9a6GtTXtoxuJyBbnHBz6l0K5hhQ+6jxe0VIlfDfGZE=; b=gVCdi+Ji3DJ8iHKV
	QG6JRyvKFk1L0LPiESnNzyGxqNsHRsCK4IejX12uMXtSj3lu03F0A9ANdayl64Jm
	lmoxXQjakMJxP+7y0NLF0lhlZrbNsFAgI3xmcjyriVQa3iWy8xYEjCEzzkYStMIf
	OrPex6+kiRE+/0jXsLBxY3sMFMSWhmbJ62u1Tqy8luhu9RDwokgL8Khial7uAdA+
	fronRDR3wXdJk6OFbf6xNv1po96n3ASzhTPYlYkWpsWyxPJR5m+JaFmF2uuvOirR
	pctSQFuWsVoWOoHVPpMMJDU4mAq+k+g19Wv7lj630S5qonqBwjo5sOeDveey99aY
	RzXE8g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48wqvw93qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:56:11 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-329ee88fb47so352061a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756806970; x=1757411770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9a6GtTXtoxuJyBbnHBz6l0K5hhQ+6jxe0VIlfDfGZE=;
        b=kYi7d4H0edKcPrfcEVe5+YFq82dN2wyvIQgsGx7su8lNUGSPKUmkqS/+k/MXMM7a9L
         qIwnXSiXk/OvSxafmPtX/92+uzT9pLj68I9qv60kJzjGpKHnc+GeOFmAOKSRrmci4sIs
         aLl4LNzq0FMVMAsEKvcA6pjQ0IrKk5glSw+qE9MMKKVnW+pgAlaCuqrgyTZ2q4CFxuVg
         kH1S0JylG+3IGZ8c/eLupk721ksYDYgHx8n3B8fC8l8k4v0EQwd1JadzkFUJQHdzKoFQ
         I8JlWXJc1MwX1KSy5qDWOYK/GydTjh82aElalvAVMXhXcUcbSGg1w0Bvi5mDjeP8Yxj5
         KJyw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Wpmk11Q4SsYrSxdtRtzxW73cvmDkaK/PJBwyI56UgM7ebThJik84FqAEEJAnp96/vrCI73dOWCQmCf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxghDaxSqQ1iKupvkkoNqGUrksUbb1yCngGJ5Zi0AIFMpHjjHc/
	Mlu/V5ZhCdB7qhnICyz38zjzkeHcjjfQAepdxBwme88QkPgDPX+RBIMg2qdNKjRJ02cIyrrijOT
	r8mL4Uv0j87bfGHWUgAevchiC03n+PgC3BbliD8bSEiQIbwqRkosQRDLkgsnWCJbg1Mg=
X-Gm-Gg: ASbGncvX4vUFFPVhr5hERV2zWAbx1PQMIN6qnvTqkkAGsmYCX6E68fRhED5XYM2Gpk9
	Qb4klOzHe9EasULZhrO4mmeH538/0K8irB447DC3ctggDTy8GrOj636KeQu5Bf7lFzRuAaxHtIH
	07BS+idO5jH2jnt0Mn48dhzhaMLqsASafwAce4gPQT5w6+AsCeip2B1YGom+C8GVC6ZETjHDBDi
	1Q+CVVE/RRF7wfk902uRTtTnW8Wmaw6dGvlX2BpJA7/cPbd7myjAhFkuZGljiiNIB6edhC/ip+u
	itzIcvPNZKUts4MmsiN83h3Fv5JYg/uFxH21BSW4bdILPFnc7Z+ZV2/5VyOrUT9WJRDoHabUYQ=
	=
X-Received: by 2002:a17:90b:2692:b0:328:725:970c with SMTP id 98e67ed59e1d1-32815452f62mr16043519a91.16.1756806970122;
        Tue, 02 Sep 2025 02:56:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZVuzFiwlfBsSZxogTgJWw5dQ7gwHZiQ9EvvRoG0AY6Zu/sUmSXNmDrdeZxxVTBwQDQosRIg==
X-Received: by 2002:a17:90b:2692:b0:328:725:970c with SMTP id 98e67ed59e1d1-32815452f62mr16043495a91.16.1756806969618;
        Tue, 02 Sep 2025 02:56:09 -0700 (PDT)
Received: from [10.216.28.67] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329d8c939e6sm2349177a91.29.2025.09.02.02.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 02:56:09 -0700 (PDT)
Message-ID: <b4e26633-b892-fda1-4738-5c8aa85d71d1@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 15:25:53 +0530
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
To: Casey Connolly <casey.connolly@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
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
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <88ee0a26-8d64-4060-b703-40156cd011a7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDAyNCBTYWx0ZWRfX3Z6jOSfD7qHo
 iPpPo5OBGG+4kPIlAoch34Use8UvQQJEiOQtsC9+dyS8tHggcxqDLSM63R0xA48pbemvwWN17vN
 UydD1jwDWxMfnE3juVRv3BJSzvZLJdM8s6UPQwWUhXm9j8vdvBIfvKwdcCUfPH3tejtHzZFACqQ
 uiKpTEjYlMURrxC/NoPTNQcVbNC2TXaU34MLH9z06wbKU+lMFtzZwZveR0vK9q5cywPkLggHGWb
 JJW7F7ohfvezVE7jqZuAYMSLr6iyu6ZgVqXsRgpYdeHaBqcSGBGscLdXdVmpBWsMMmQBO02OCll
 vn9nbuoY1Rp62PI9/pkbnLB83A/JzRwqOX23YLypC+2DiJVOChNe5Dhcqvu2ra5CNhtwDm/JUe+
 0KiTZVjh
X-Authority-Analysis: v=2.4 cv=WKh/XmsR c=1 sm=1 tr=0 ts=68b6bf3b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=FBzynz1gJkPyhc2EhIcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: Rnch_67wWRffmLRe5MwefepqsemP4KZc
X-Proofpoint-ORIG-GUID: Rnch_67wWRffmLRe5MwefepqsemP4KZc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020024



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
> 
> Parsing the DT values then gets simpler (u32_array) and the magic value
> can be passed into the ->write() cb as a pointer since all the
> reboot_mode drivers already know how big the array is. Unpopulated DT
> values would just be 0.


sure. Will convert it to u32 magic[2] and ->write can now pass
"u32*" and can be de-referenced by the using driver.

Could not understand that how we want to use n_magic_args and who shall
set it? Do we statically define it to two for now? or should we skip
n_magic_args for now?

thanks,
Shivendra

