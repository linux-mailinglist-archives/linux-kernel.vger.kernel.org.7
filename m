Return-Path: <linux-kernel+bounces-727561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AE3B01C16
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 477467B48CF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201D32BD589;
	Fri, 11 Jul 2025 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E/pjBBTo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286B28F50F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752237153; cv=none; b=C3u2RRqMCrxB7dqBPPzDOD1LMbyNKy5Dbs+6D0GoQ/HTa/U9hGWMyP2NoQwAsJguuu87cjm2KjUEDfzuEwrz+3C4btASO7Ghw1KyAZvPktyTRfm/DrnZ2g82Lge+96VlSvnwsr8UnQZHH35jnRFlMoxxvOzK604aJcqWpvIfEV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752237153; c=relaxed/simple;
	bh=jskRVxDVP/S7EV7/YxIs2gggxobMl3QXDo9NH63okro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoydRcN6WPl3A/As9KMwP6GcVDPQxtPIYpe+icbbGufxX4unZTqIaaB0+hS86ij4VQM8WHdABbXl5vBEWr6AkuuhAE311a+6W+ZXTHn4Mw3vuITqshOP43Z4hetSin0fE0AxfHSswuYuxGFPpSd1EHKnTCrRzsBK1j/ZSwIj0K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E/pjBBTo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BB3B4S012862
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I+uJUa0zDVqqPkW/P6ZNncfaiD0Ik/YbmbIwujNrzqc=; b=E/pjBBToKGzsD7Nd
	aP/K0oulwHPlxsH9QDB5UjkokGaSTwp+ppzV3nPC+zT0BAr1G2IsxtUchb0/O1r6
	IXdkA7CV8TuW/2M6R1CGUEA9OTppGialSdxTjdC5tlulcQFhsGbFUpxIAY5Wdejn
	A3ym7h3zKXy/RBGl6G/H77MKPrI7+QLrsSlDnCZJN7KV9rsIRPzDY02eapz7lveF
	aZ7oKzOgavVo3GAdhfV6WxApnbgw0XnrD2vuizxgp7T753m8zZZmrSlR6jxDNbDC
	4rgx/9s1/zjlN4vrW6g+s0VCJ+K5kIBA7byNQu6EUv95pcKztrKQZlEfD0AxWhx4
	apS7jQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47sm9e0h8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:32:29 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-748f13ef248so1984342b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752237148; x=1752841948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+uJUa0zDVqqPkW/P6ZNncfaiD0Ik/YbmbIwujNrzqc=;
        b=gw7xGlxyaJtJKNqmCjtyAUgxqqZhRfEn4vUiv6Wf+6fj6R1yZnH2f1lnynR6sntXKI
         TthSsEKEavIDsn1NmRqJELUmvYwGps6oC9rHwYTVMUTiansppQLzv+NW3uPMdi7zGOFv
         OGG2DA0ndWOgzK6bXPNJ4hrGE/a3buk2E9FLy6sCUbz9CMCbqPuNVWmYvtPCvwNGXKrv
         hdEnr7yyHN14BKy/jtfpFBC8KBhxjBZXoqbIWPrSSafNvyQWwY1ebdhbDphEOmkuoiy/
         Tvy6r8K54ksC7RtGK6HyHVujx4cs/jw7VIQn7MPxH4mgABhNdI2PRsVYKWbevqT5vYCo
         OyGA==
X-Forwarded-Encrypted: i=1; AJvYcCW/XNQHL+4hhphib/AAEv2dF7BaBcvSHYD0WguoEyusYV9gGgd9n1LIFQUxPJVkJWP0u5nCkIFJZRS2ZXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUnBwo1+lgVLD8wEzF6sEc5V54bl9Ry0kzUVapfNjbF/ds2lwm
	YdbTCtNrX9MixqvlPogZjKvbDm+rxAcgDydflMvdnW4n5UYMWigEhJ0dIlU7dWL/Wwed4lW6jpO
	4Gj6tIPaEN0jc2XtPtlKctGrAU0dUgHeK2nCd82CmzUqhOeparhs9IcByiaZtCu24m08=
X-Gm-Gg: ASbGncu5r7rElEx9YVhyD49PfDMMtt77Hdlm7iMh7n4JEGOyn1pdAhlN4vGzkOWqpU6
	L8zFz+mQTNMP9I5xGIG2EqIluNz+bFadcgU64gP2+8HZ5DB73SKT2PYFDFQNQagdfuCRZWVPgDt
	A78SI6XsOOk/ylGZiCCtME17Qu7P/Loze9CwMmHYOWH4Ozblcei87EFiRma9LVW2enZVVM7l3mj
	aI51xLMUGbXRd15De/+gA5VJ8rgxg/cFSTyLrGJ0cFoByPwxIXBKtNipIwiRdQPi7r93uN9BWQG
	W1bPRkxBbdzYJ/hJJDloPVKU1Hsc07487tZtvr5TPDosFC7ie7lch+dB31096oyby8HQQvo=
X-Received: by 2002:a05:6a00:1151:b0:74c:f1d8:c402 with SMTP id d2e1a72fcca58-74ee07bb96dmr4845191b3a.8.1752237148308;
        Fri, 11 Jul 2025 05:32:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9gsUsqbiWSyynICyXIvV85uCk9/J6nn3GoQC+GKfjb1N1fCIuGevD1MSbYwD9kXnui8JeEw==
X-Received: by 2002:a05:6a00:1151:b0:74c:f1d8:c402 with SMTP id d2e1a72fcca58-74ee07bb96dmr4845108b3a.8.1752237147622;
        Fri, 11 Jul 2025 05:32:27 -0700 (PDT)
Received: from [10.219.56.108] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f90d66sm5040981b3a.173.2025.07.11.05.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 05:32:27 -0700 (PDT)
Message-ID: <cdadd6cf-18c9-15c7-c58a-b5d56b53452a@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 18:02:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v10 02/10] dt-bindings: power: reset: Document reboot-mode
 cookie
To: Rob Herring <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
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
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Elliot Berman <elliotb317@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Andre Draszik <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        linux-rockchip@lists.infradead.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
 <20250710-arm-psci-system_reset2-vendor-reboots-v10-2-b2d3b882be85@oss.qualcomm.com>
 <20250710224740.GA15385-robh@kernel.org>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <20250710224740.GA15385-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KmVFvD9atl_oCsIxL8ZnGBEvi84ruadb
X-Authority-Analysis: v=2.4 cv=W7k4VQWk c=1 sm=1 tr=0 ts=6871045d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=s8YR1HE3AAAA:8
 a=PKmmUXB_vcMajKhYsGEA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: KmVFvD9atl_oCsIxL8ZnGBEvi84ruadb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4OCBTYWx0ZWRfX5mDnKh54UNw5
 nWixK3tRUpnMKV3gSdtBuCXPQiLEkj8tWB0xMBnV1jhwNCT0qefAUvYLIX46cluUkDMGXWba/0L
 zvPCfICJtBTU9aeuucF/XFb6ywWmGbfSd/5JvvwsLzfDfBrgPtPispvYNPY4ZZQZYkMuOM0MA6H
 88xh9TYjJY7oXmIA7AUEagZZ4GAtTBKUCzRYOUZQBjeSMIL8mQjI74PqDHuUI/ppj1dFPtqaExs
 1BiRRMxCmsRhkk0kNITkYUkEflBoDZJntYq5sdc6ubHXvhehbbrioYTmKobI7651uZx81x2kEcn
 HW8hWtEGqDeg4/Yh+U6mtjM99zeMrRAYZfCcNw9g1H2FPc5Y4b0OVXZluuexhilHKzpI64w6jfz
 Mip32wQw3dzt3VVBe/9JF3n0+hFmq0Z1IaeLXcAfsmWAXRInXvl9EE9+uB1G5/j1MMA9O+GT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110088



On 7/11/2025 4:17 AM, Rob Herring wrote:
> On Thu, Jul 10, 2025 at 02:45:44PM +0530, Shivendra Pratap wrote:
>> Update the reboot-mode binding to support an optional cookie
>> value in mode-<cmd> properties. The cookie is used to supply
>> additional data for reboot modes that accept two arguments.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>  .../devicetree/bindings/power/reset/reboot-mode.yaml         | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
>> index 3ddac06cec7277789b066d8426ea77d293298fac..a4d2fe1db51e0c1f34ebefddaad82b8cc0b1b34a 100644
>> --- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
>> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
>> @@ -10,14 +10,15 @@ maintainers:
>>    - Andy Yan <andy.yan@rock-chips.com>
>>  
>>  description: |
>> -  This driver get reboot mode arguments and call the write
>> -  interface to store the magic value in special register
>> -  or ram. Then the bootloader can read it and take different
>> -  action according to the argument stored.
>> +  This driver gets reboot mode arguments and calls the write
>> +  interface to store the magic and an optional cookie value
>> +  in special register or ram. Then the bootloader can read it
>> +  and take different action according to the argument stored.
>>  
>>    All mode properties are vendor specific, it is a indication to tell
>>    the bootloader what to do when the system reboots, and should be named
>> -  as mode-xxx = <magic> (xxx is mode name, magic should be a non-zero value).
>> +  as mode-xxx = <magic cookie> (xxx is mode name, magic should be a
>> +  non-zero value, cookie is optional).
> 
> I don't understand the distinction between magic and cookie... Isn't all 
> just magic values and some platform needs more than 32-bits of it?
Need two different arguments. Will try to clarify a bit below.
PSCI defines SYSTEM_RESET2 vendor-specific resets which takes two
parameters - reset_type and cookie. Both parameters are independent and
used by firmware to define different types of resets or shutdown.
As per spec:
reset_type: Values in the range 0x80000000-0xFFFFFFFF of the reset_type parameter
can be used to request vendor-specific resets or shutdowns.
cookie: the cookie parameter can be used to pass additional data to the 
implementation.

Now to implement SYSTEM_RESET2 vendor-specific resets using reboot-mode
driver, we will need two separate arguments. reboot-mode already defines a
magic, which will be used as reset_type. For the second parameter requirement of
SYSTEM_RESET2, we add support for additional argument cookie.
> 
>>  
>>    For example, modes common Android platform are:
>>      - normal: Normal reboot mode, system reboot with command "reboot".
>> @@ -45,5 +46,6 @@ examples:
>>        mode-recovery = <1>;
>>        mode-bootloader = <2>;
>>        mode-loader = <3>;
>> +      mode-edl = <1 2>;
>>      };
>>  ...
>>
>> -- 
>> 2.34.1
>>

