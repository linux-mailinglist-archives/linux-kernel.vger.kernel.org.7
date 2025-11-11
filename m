Return-Path: <linux-kernel+bounces-895828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95A4C4F0A9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6533AF17F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A80F273D77;
	Tue, 11 Nov 2025 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HJqm5J0U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SwQTtceA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124D626A0C7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878668; cv=none; b=KoEvzj0mXrBqlvhc9ceDKl85TV6ia8alS8hEmWVbI+tr8BYMkQ2nBN9rDqU8yE2GLzrXQVAozbEfqowVc7aBddoJuUFXrot0Uf1EBT/rc4pkOzsHhT4Y1bn5ekXs7Qw3qJtrZkGSVmvfJ63b3Y7VZyhUmL/TomjIjDg23t3l2RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878668; c=relaxed/simple;
	bh=OJVRQOjbGEHZBlcMjkrNzy8hq9YQqSg/EQiWaoSvWZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLI/7ITtZ3WYlYJeYTaaU5E9ECXMgXBNIXfQ47VItzqaZ/sLJ852e9Nq7L1rn82tpvG8F5PUMd8T5FTxph/EYQIanlPUfFAaJgspIdCkvGif1wSX5GK7VjJJCcg/V/3EB4UwXF8QbxmF8LOavgWlPpjIfNrKE0nJXZ7CHhrljAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HJqm5J0U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SwQTtceA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBH4WE2302379
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bybkeY6YUl5SRT8XBgV3JMBrtdGGNVKGQ7cbU/fM7qs=; b=HJqm5J0UEi5a5w6c
	2h2wjqqxl9Bb6xdP7WBZHOENjyQg6NAS8ZraEiQfplfJPowcHFtqCp0Wre2NBBoT
	cqV0GSGULoLkhibkRsrET6yst7N2pYt7ak4tT8qeaBYN1tJRPMKJvO3rswprUSNk
	oJW+ldLEo26WFG+tl+7dDHNkChqJMWVreWbj8PYjXnUZjNrYJuFFy6LBHSka8qF2
	GdSzT/ZHRE7aGSCZYdCTS2lXRBcC4wrLY4vjsosnF6IxBCBTCzT5lvplt2IDM78/
	qQU8t14bNB3+S19tMUWIaTKJ9D4O5mUcikbxYrpAgaLRk8zATxQHRjXKIIk2Myn/
	lPQsSQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abjxqkxc3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:31:05 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b630753cc38so9706502a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762878665; x=1763483465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bybkeY6YUl5SRT8XBgV3JMBrtdGGNVKGQ7cbU/fM7qs=;
        b=SwQTtceA68YbH4Ptn5o3yFDPaKptnahdVEdosDKaxRPHNlZxCh+dYa5gedbYwCpDXq
         t38KfxhkHabqxQiul5dIJpv0qxQTYM0x1dHNVuy9AjXLZDNED/bPeE3JB1hgTDmC4cTZ
         xyK1hmSInSHx+qdRUJCku6tHSaNo5lv48XjVA09p4qfFe6c4PbEoW6jaEvqpklDfPCLc
         CFMcz9aRHWtObXKbBhw1i8WYzo62MV4Io9M4REl2/GcOV0TVlk/nIt8ZSazs7aMKg9VP
         pzCupoKWsxbYxcwmSdjXQQgctqZso+wrIgK4cGIcA6eVMh25pNuLKmU3oZgAo18oH98F
         5scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762878665; x=1763483465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bybkeY6YUl5SRT8XBgV3JMBrtdGGNVKGQ7cbU/fM7qs=;
        b=VsiTyF68oV07B8y5XZLKhstC4VJapUItpYcahOyYYkVf9VevjsV3+NL98ACPPPMH64
         uuEhqNDwicB958qRjQGQhFMGdhWfyGO1TIBziTKuo+kGaH7DZGttq03spy1POjTqtetG
         KCmqsXiiHP0ZtVUF129pWgNv1WumcN+zGI4C7gSc40h5gNB9x/12COtz9+p5ehKbsWIy
         /HVl3obC3YTCvj7+zsZ98Tn661LgSzszxVUrGex7c/UJQWjw/X2zNEoYwes74vRpN1JH
         BfJ4Lx8sdw5a82kYRPO7HVWReYK78XgKTFFKaOA1Y62sPCjsIKapVy9Vu6oynjLW1JXL
         egvw==
X-Forwarded-Encrypted: i=1; AJvYcCXCgDYXkX0y0oaaCPgQ3PCq36j5FiFQSEhNVgHYrbrGixGfw26fhbb6MZm89LpiEAqsoW6j7qy6r0f/9fs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ZR0LslAVIpxk6iVtYfmBSxsS1aEOZX8c6w/y4DiM6RQTIuVh
	cbJzWD242mzKFBUAfdYh25717av6w2fY7sZK3KA40uMgUq0gkcmXCtkSlJz78V41apy1mEXcV65
	zN6qaUtZcW5xcg5q44gLvCy2EjB3ruZCwixN9MZOpvMJIHoa4nTNlsKWneScOZ0w8I9k=
X-Gm-Gg: ASbGncutwEElD7PYkVagPVtAy0jW4812KaY3URtgMf8/oC5VK8fPFAvnfRtfxvPuQJe
	77lU4llHXneKBQ13XLcLBW7DUe1DCJW9TTcKFUZt+WgGpgw7ZO5Q8DkuyiHpUYX7bV6fi0OwMzp
	xPwH0avmHlJmqQJLSfBA9AFA5V6rpEtafeQPFUR2pb4CGfjymNTr1NHrvyRbnMkQ9OCR/2ZTjf+
	cMDL+Yeg5etuGp4eCEdUq13BqkatpOSiPjqRmvT/4jx2W0YGcRLafBMzRao1CEZ/TN1rOxtr7j2
	3KTVHnjzRq4jLZd+4hw11OLpLd+gZedqMuuAvhL3sPj7N5V1umpHzzqvakKkrRnT0d0yUijO4Of
	w9ez6OQAfNDjrctnnwRftCGqVIllap/xh
X-Received: by 2002:a17:90b:3a91:b0:33e:2d0f:479b with SMTP id 98e67ed59e1d1-3436cb7bcfcmr16607169a91.6.1762878664796;
        Tue, 11 Nov 2025 08:31:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEK0C7zoIdCCrbSGtOR2lA7hiOGv0VrSOdA1mvOcJK1ts7OjzqJ7ukZDrIrLaxwld0WkX5Shw==
X-Received: by 2002:a17:90b:3a91:b0:33e:2d0f:479b with SMTP id 98e67ed59e1d1-3436cb7bcfcmr16607120a91.6.1762878664213;
        Tue, 11 Nov 2025 08:31:04 -0800 (PST)
Received: from [10.216.22.22] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343685301f8sm11854378a91.5.2025.11.11.08.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 08:31:03 -0800 (PST)
Message-ID: <bdbe4328-aead-f59e-2ee8-7fe12fc83506@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 22:00:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v17 03/12] power: reset: reboot-mode: Add support for 64
 bit magic
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
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
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-3-46e085bca4cc@oss.qualcomm.com>
 <20251110134529.uljjqzb3vhda3vya@hu-mojha-hyd.qualcomm.com>
 <gzj4r4elqewjt2gjzhuamslvobz5fgyvt672brwknoozlsplaq@wsebzmi2l6pc>
 <681a72ba-d8fb-bfc2-d2bb-d80ac667bc5c@oss.qualcomm.com>
 <zejaqakbtufwzlzs7xc7xzxezcylqjkmu4nne2mro4riuhgbkc@hlgu3u2w36bb>
 <5c83c9a1-e123-95bb-1434-588ee8c52b25@oss.qualcomm.com>
 <axle2c3i3vfyxpql43dqb4zwzjj65xhsjuhojyf5x26wqo352v@z3nwctubwanx>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <axle2c3i3vfyxpql43dqb4zwzjj65xhsjuhojyf5x26wqo352v@z3nwctubwanx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEzMiBTYWx0ZWRfX8CGD09RZHOhL
 RqodXReeL6NliLNiAVxdvdL1FhSvtTlRBFlXNqzg086k40JoNwT+a00Zy4eNnIs9bQ1ezko2rgr
 PellbOb7rmc1qYps+s8Of8phb7oQvBOREQSrINfyf+nUlZFos38Cn52a6kuqv74+ekA1hRktAlw
 mLFlya8U+w3LhQ6Hqbbu8Mq6e8ZUOL5mwAY3SAJzmDyYdyaiJ6DGiS0ao3zBkReUBjemZ8pN2cU
 Dy4sZtWtkP5AjZltagyb+61HjhR50HZzjaU/P4BgTNh2r4hELW9Se+qVKckdypXl+ckhFmLGM25
 l1iJh70szWsCEMSwiJ3fn3FMJp/7S6d1nfY+w/ktLtZA/eXy+LIGR3A+OicmlRceH4Gqonvj0jW
 yHFShKTV5vhba20gP0XHYGNVMSKN3g==
X-Authority-Analysis: v=2.4 cv=CsKys34D c=1 sm=1 tr=0 ts=691364c9 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=5lduEm2px6IFDn4QHGYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 1c18IEFQkaLlH6ukBARy0iJPfdT9nwkx
X-Proofpoint-GUID: 1c18IEFQkaLlH6ukBARy0iJPfdT9nwkx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110132



On 11/11/2025 9:55 PM, Bjorn Andersson wrote:
> On Tue, Nov 11, 2025 at 08:20:43PM +0530, Shivendra Pratap wrote:
>>
>>
>> On 11/11/2025 12:03 AM, Bjorn Andersson wrote:
>>> On Mon, Nov 10, 2025 at 11:22:40PM +0530, Shivendra Pratap wrote:
>>>>
>>>>
>>>> On 11/10/2025 10:00 PM, Bjorn Andersson wrote:
>>>>> On Mon, Nov 10, 2025 at 07:15:29PM +0530, Mukesh Ojha wrote:
>>>>>> On Sun, Nov 09, 2025 at 08:07:16PM +0530, Shivendra Pratap wrote:
>>>>>>> Current reboot-mode supports a single 32-bit argument for any
>>>>>>> supported mode. Some reboot-mode based drivers may require
>>>>>>> passing two independent 32-bit arguments during a reboot
>>>>>>> sequence, for uses-cases, where a mode requires an additional
>>>>>>> argument. Such drivers may not be able to use the reboot-mode
>>>>>>> driver. For example, ARM PSCI vendor-specific resets, need two
>>>>>>> arguments for its operation – reset_type and cookie, to complete
>>>>>>> the reset operation. If a driver wants to implement this
>>>>>>> firmware-based reset, it cannot use reboot-mode framework.
>>>>>>>
>>>>>>> Introduce 64-bit magic values in reboot-mode driver to
>>>>>>> accommodate dual 32-bit arguments when specified via device tree.
>>>>>>> In cases, where no second argument is passed from device tree,
>>>>>>> keep the upper 32-bit of magic un-changed(0) to maintain backward
>>>>>>> compatibility.
>>>>>>>
>>>>>>> Update the current drivers using reboot-mode for a 64-bit magic
>>>>>>> value.
>>>>
>>>> [SNIP..]
>>>>
>>>>>>> +	if (magic > U32_MAX)
>>>>>>> +		return -EINVAL;
>>>>>>> +
>>>>>>> +	magic_32 = magic;
>>>>>>> +
>>>>>>>  	syscon_rbm = container_of(reboot, struct syscon_reboot_mode, reboot);
>>>>>>>  
>>>>>>>  	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
>>>>>>> -				 syscon_rbm->mask, magic);
>>>>>>> +				 syscon_rbm->mask, magic_32);
>>>>>
>>>>> As above, if we're no longer silently discarding bits, I think we should
>>>>> compare the magic against syscon_rbm->mask.
>>>>>
>>>>> No need for a local variable, just type cast after checking the validity.
>>>>
>>>> Trying to summarize below why we added these check-
>>>>
>>>> the patch in v11 used typecasting and did not have any of these checks(link below):
>>>> https://lore.kernel.org/all/20250717-arm-psci-system_reset2-vendor-reboots-v11-2-df3e2b2183c3@oss.qualcomm.com/
>>>>
>>>> As per below upstream review, type cast was removed and bound checks were added all-over patchset:
>>>> "As a general rule of thumb, code with casts is poor quality code. Try
>>>> to write the code without casts." - 
>>>> https://lore.kernel.org/all/8d4a42b6-657f-4c30-8e25-4213d8d53a89@lunn.ch/
>>>>
>>>> We can revert to the typecast way. Please suggest.
>>>>
>>>
>>> Okay, I'm okay with Andrew's original request, stick to that for the
>>> nvmem case. Although I don't fancy the name "magic_32", and would prefer
>>> that you just call it "value" or something.
>>
>> sure will make it proper wherever applicable. 
>>
>>>
>>>
>>> For pon and syscon however, I'm wondering why you have ignored Andrew's
>>> other request from that same email:
>>>
>>> """
>>> You might be able to go further, and validate that magic actually fits
>>> into the field when you consider the << pon->reason_shift.
>>> """
>>>
>>> Writing "if (magic > U32_MAX)" in a snippet of code where magic isn't
>>> allowed to be more than either 32 or 64 is misleading.
>>>
>>> For syscon, it's true that the parameter is an unsigned long, but the
>>> actual limit better be based on syscon_rbm->mask.
>>
>> May be i was not able to interpret it correctly. Basically tried to
>> make sure that magic that now coming in a "u64 magic" should be passed
>> ahead only it its a 32 bit value.
>>
> 
> That is the correct interpretation of the original ask. But what I'm
> saying is that if you write:
> 
> if (magic > U32_MAX)
> 
> then that means "check that magic isn't larger than 32 bits". So the
> reader will see that and understand that magic can only be 32 bits.
> 
> But the actual PON magic value is 5 or 6 bits, not 32 - so you should
> check that the value fits in 5 or 6 bits.

sure. thanks.

> 
>> So should i get rid of the checks done here for syscon and pon?
>>
> 
> Continuing to silently ignoring other bits would be one option, but
> you've been asked to sanity check the values, so please do that. You
> have the code, just compare with the correct value.

ok. got it. thanks.

thanks,
Shivendra

