Return-Path: <linux-kernel+bounces-728000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF15B02244
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04E11CA191D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6332EF9B4;
	Fri, 11 Jul 2025 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G7HpH6dt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB5427A91D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253267; cv=none; b=eSHyhEZz6q0spaHYLm4ku56cADeT+tNdJIvgpfTDXLZ7P/1nhEiUzE1dWEIRC+tR+D5m2WcIKS1blKL7u25j/8vqeAvk45ACGh1pXF3hi/qyFAyUgK55Fj3HybM0M9DurzA5L7AKDE6aHl1SP92EvtPwzQq9UB5eDZlR3/SW1Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253267; c=relaxed/simple;
	bh=/AhhGaV0drOsrUBPl4v8Rx7iU83u0J2d52gX7sMFBi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAVdDQAtvghvlre9FpUOlAgOCf4axJMl3UU9Dlz8U+m8kN+nYWfDAqwS3PZkp+/uwcMPuiMxYvAfD8May9OtDWpOYU6g9Y8MwObSz2Xp8OyjJv70lIAh6Bb7edyCDu/XuQn/wf17kWfZr9CXn5vG5H8EA/oA00HEGh78zXTabBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G7HpH6dt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBB5pE018272
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RzjVxq958kyT2ib7EgyZgWvE1bSgJsNxIfxcrwNYgEk=; b=G7HpH6dtRix5QARR
	N0sJfs+iAlL1+sDH2A5DGwKhR6g3jFKa6ZbZM1tN9yM8ZKVmvQLS8IdJ5x6jBGsy
	lRk0OLyROD/qLgNNrKgCcDKjSlga+5Be8CHj6MOpl0gUZ4V0b9CYpErLyofsmXAS
	Sx7+EVHPLbosP8XnGT/MeYK6N00S4jHKaqzuPB3SxQakfbdf/9r9VvAH5VHC0J4R
	UQvpbI1nrWt7KOSZt6QdB9/1hP1G9G5sNUERtdSe4+pHQ9eCwHDHn4rmlf0gdpJU
	6N/dnt8cmZW9vbZtmxsZmVmp8p+szvPN91sEdkTO4DqIcO5qhA8ATnbjGncXQEcj
	XsHYzQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap9b66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:01:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235196dfc50so23373925ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752253263; x=1752858063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RzjVxq958kyT2ib7EgyZgWvE1bSgJsNxIfxcrwNYgEk=;
        b=rvEXMACkmWGNAUhAt+fJZq8HtlJ0s2+lt1g7sn7Xi5h+QltHsyQyk2GiDkHanOou9d
         z6LMTPLEJUDR/8lRg0wld2FEHBy5HNGQSRXfT/1YvQt/OA8xYS3sG9wOERgUjVIKIS5t
         M9P8Flx/5Y8RHLOHBM0rH7GzqUGzgAGFrelFNGzSfTKlARbwybTMhW29OdiT40Sp+MXD
         E1h/nmVT7nt96GWYeedFHkhJ3JqJ8GgbagZq97NhJrHQgpVyU2BoiDM80h6xljW4YVSO
         uthvPsUxvaFZvHIFlozDXN2tOP56TTNkKjLf5fRVYTux2Xx1FQZaLYX+13liXs28Vdxi
         lLAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8sNCJ1tb8qIn7LGDg8dLlRqUxwQkYCxIhBfDY/8vh7vjYEn0KT5T5N4YJsCehdOnjFwsDRXcCCs143TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTTi0UaUPKpGMGJJJ1uBUZYDe0Uo116mFtN+5bKgZeO1OMcuOQ
	KxOJjpazkKwAHA4FD7JES5cOPUhdDFQ19+83wwNl7arRNYiYhubXtA1bkka9CEVtfqWyIIE1Uv3
	KAQ1Llq0DjYhMYBcxE3RE79R/V9P7hA4zjxQY6JLfPZJmi7BaL9Za0u9KvdNTwmfOsmc=
X-Gm-Gg: ASbGnctJM+RMEqXWWk4qngKuyx7TkpxFacHk+OB8zVc7ZheuVkh9ZUW6hUUKt/PilDg
	c1zBZ1ISrTl5jZSFbKZ2rkl6vKwjd7RNZ1389vbp5HBFBjOKUDOJnTg6/B4WM/aR7JU3ud558kv
	3Q5x0pzDShF+Pqw0TBiJIJj0sRA+oghIzpQH5L5ibBXiXYEskKKP4RKkL5dMwyeMvmKUYDNDToZ
	hBGk2GUNwCD72ajyxjHdVqjNnpftP9zONGWifMos02cDRRwqkSw5fUNyhKhcgTGOX25livbSUs4
	2R+m9jfC/UibzthzV0oPnk1Rw46I/VvMXbZPIYBGlG4bV1cKmF8fyljHZLJwNNgxbpYwCQFm7g=
	=
X-Received: by 2002:a17:902:d489:b0:23d:dd63:2ce0 with SMTP id d9443c01a7336-23dedb4be9cmr53760895ad.0.1752253263046;
        Fri, 11 Jul 2025 10:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn+/OtXzq1bSnDAVVARE/xdrBPkqdNVrhiIvWMbL7OLRWzoRimQiO/kH3LymvsQd+s4/Mzng==
X-Received: by 2002:a17:902:d489:b0:23d:dd63:2ce0 with SMTP id d9443c01a7336-23dedb4be9cmr53759865ad.0.1752253262279;
        Fri, 11 Jul 2025 10:01:02 -0700 (PDT)
Received: from [192.168.29.115] ([49.43.229.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4286daesm50513005ad.20.2025.07.11.10.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 10:01:01 -0700 (PDT)
Message-ID: <28f277af-9882-2c70-5156-123c95adc2ee@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 22:30:47 +0530
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
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>
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
        Olof Johansson <olof@lixom.net>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Elliot Berman <elliotb317@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        =?UTF-8?Q?Andr=c3=a9_Draszik?=
 <andre.draszik@linaro.org>,
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
 <cdadd6cf-18c9-15c7-c58a-b5d56b53452a@oss.qualcomm.com>
 <454c8361-151e-42b3-adfc-d82d2af62299@app.fastmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <454c8361-151e-42b3-adfc-d82d2af62299@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=68714350 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=8g6h00HoWaIZ3EdQG8aEvw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=yN095whQe_6akajZz4sA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: OZu3BTayVAk4V_NoF9QVArR4J3QiOHlV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEyNCBTYWx0ZWRfXwSa0WVP9xgDJ
 27WKJrY2GCoAL4I6pZIFr1ErTviZxP7kioads0alPhWA8q/tRX+u00qP/AvkymPopwYy0H48CU6
 URFE70y+CnDChIM9oyX2dRqHASg5RSYqOUBqN0SpWb6mEcWFU1bkdYo997wTfGmKPCzf975tXjL
 SGb1hjZToCB4DjPxIlkh0YGzsVVnVOfw1q0P7OitXfNrOY0Fr1hW3lpkcjHoLiUgjK8bplyNRm6
 fDgWtWF0lsLsspn4T8WBXnfyc865kWySyTWFuA+8gD+9bQXa2PEoSK3cEK4Vc/qxMEyZrZ+wfS5
 6NALrDQKqC5OVfvdhvN+hZl0LomhkeDnJXX8HXlRzyCzXGOt641LGKVc+ZwcPzcPMRO8Kkdxt/U
 yVuEr1FsgTe+NP0C/bV6/qvcfXqwnZl2+RarJ4Zc2/VIDdmxunTA4Amuule6l/LMGN4zyQmV
X-Proofpoint-GUID: OZu3BTayVAk4V_NoF9QVArR4J3QiOHlV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110124



On 7/11/2025 8:14 PM, Arnd Bergmann wrote:
> On Fri, Jul 11, 2025, at 14:32, Shivendra Pratap wrote:
>> On 7/11/2025 4:17 AM, Rob Herring wrote:
>>> On Thu, Jul 10, 2025 at 02:45:44PM +0530, Shivendra Pratap wrote:
>>>>    All mode properties are vendor specific, it is a indication to tell
>>>>    the bootloader what to do when the system reboots, and should be named
>>>> -  as mode-xxx = <magic> (xxx is mode name, magic should be a non-zero value).
>>>> +  as mode-xxx = <magic cookie> (xxx is mode name, magic should be a
>>>> +  non-zero value, cookie is optional).
>>>
>>> I don't understand the distinction between magic and cookie... Isn't all 
>>> just magic values and some platform needs more than 32-bits of it?
>> Need two different arguments. Will try to clarify a bit below.
>> PSCI defines SYSTEM_RESET2 vendor-specific resets which takes two
>> parameters - reset_type and cookie. Both parameters are independent and
>> used by firmware to define different types of resets or shutdown.
>> As per spec:
>> reset_type: Values in the range 0x80000000-0xFFFFFFFF of the reset_type 
>> parameter
>> can be used to request vendor-specific resets or shutdowns.
>> cookie: the cookie parameter can be used to pass additional data to the 
>> implementation.
> 
> I don't see any distinction here either. As Rob says, you have to
> get both 32-bit numbers from DT in order to get the desired reboot-mode,
> and you have to pass them both to the firmware when rebooting.
> 
> The distinction between cookie and magic value may be relevant in the
> context of the psci specification, but for the Linux driver, this is
> really just a 64-bit magic number.
ok. then if i understand, this binding change for reboot-mode be dropped
and driver can internally handle the two 32 bit numbers?
> 
>      Arnd

