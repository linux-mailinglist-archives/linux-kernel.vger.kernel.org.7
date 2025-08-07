Return-Path: <linux-kernel+bounces-758817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7850EB1D42E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FEC3A44D8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F76F255F57;
	Thu,  7 Aug 2025 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+mYe0eb"
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9ED22AE7A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554609; cv=none; b=u8cwF2ryx4vGuRPLxH2HsHZiVQ7EuVxRbK2u3292tZh6AeP6ZYrH+pgmtnyRZVDeYsnrpKgPgQ4VJE83lxm61IIjVS3Mdgd5ndO8iJRTK2fr92IUI7DKMIvxOk1f3V5k1+5A8T6byosElF3anmBs7W0Ps/z1Xx9BynVz3fnT0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554609; c=relaxed/simple;
	bh=nvSsWiWlahEL/YIHHQEs+kyFmfgMPh33og87qelaI0g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ln7M64H7HxMepd5Tq+C9bxYZC3JxihDD5lf5mviEhDeaFc/Q32CpEp/LqTC1hrZaycL10ALCCqJ+d4XJkh5l9vwD2XklMPBmANyJRHoPzR/cEK0vdFnlrF1gkP58aCnKuZm5jtH87moXRNL85Hr20iIz0hTR23oFA0Hn99JxV50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J+mYe0eb; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-459e39ee7ccso6962335e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 01:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754554606; x=1755159406; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:autocrypt:in-reply-to
         :content-language:references:cc:to:reply-to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5IyuxQqHejRxrIntChIgL7/V1gkWqVgKsSi/w4O9eY=;
        b=J+mYe0ebcAcOnuOXQzbq4FAVnQFtnkRvoULu6csrPVbyxfjCwiBgKxKo3GI/MYhdFA
         +9j87UbBoTAyHHgURt5A/UGMltcZ0dLsv+TUfx9HlgHm5KKg+sBzcKfnOIF+OavDVUWo
         BwFdJTOTadHQILIQG9vOnHFfr8WunsTiTqjea6RthEpEO0MPjmfSQgpqzV0wtjBnNmXw
         mKp9UrSkpugdefLrpeN3s9hGpVJeDBqsGslkJ9RziHK71Tiz1GVFJO2US6vNJGzAV/Hh
         0KizfqpgeqJfJc6v0b5Z0iqYgmgpvV2NR2TBB97uLfZJpqDWYN2oLa74PiDCRzZuTwmO
         MZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754554606; x=1755159406;
        h=content-transfer-encoding:organization:autocrypt:in-reply-to
         :content-language:references:cc:to:reply-to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H5IyuxQqHejRxrIntChIgL7/V1gkWqVgKsSi/w4O9eY=;
        b=BAgTutYJMMvgfL1olH6KhW4Rb5ZNpMD5efuVfI4YIzV/72PW3dmJaFoYopJYEYrPEQ
         60odt5cp1sU5mJ3Sy/3KKXPpwcZSPi/ub1dYoVKfHvSBjeUPx7+r/jVoso7aFkbONp1M
         sOe050lxF3yF/rtdsYoVPJtYTqMiwvAI/X5RbJOEiOs4Jx91YFJvG9HTGHAhsHHQc7oY
         NI5jmJx/p14RZNzWOFb7aQRzNxCoJ9YWXBtZBV/eyTLfOYIpGc/D5WH+++Lloyu4Cu4D
         ofjop6x38XotMAK4jj7VD/JXpMVVf53ntGjUxiBkZL/QIhqE6Y8VZdF8lx1QgV22w0Gv
         EANA==
X-Forwarded-Encrypted: i=1; AJvYcCVN5GVyV+TRvJAkhc+0uQ6SaWH5JZw9rbzicHMEanq+xsQjPjYUYJQUHxgOz/5ELTSdGkB+m8TW7nNmhmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhXhObf22d3rmVD2HjEjlGL+rSpFyMxDC/Q8Uha8CiyudLT66E
	REIRpN7rLzAuwbSMgUd5+QASctHJTcr5gWmWc8VTyEujGtPy7dVPddNvzy8eLKFWSuw=
X-Gm-Gg: ASbGncvxXcTeDwk7or0kpsFl55F/LjqtM9iAt3ug/cNpPWrfgQVeYi1oLCt+BMB5Vc8
	iKLRgWMKANzCYr3sCaHYQHf3EpwoA6IL5GtPjRl3WdP8k+WrlUldDcuEjlmYEzfiefWhqosg2O4
	O5jKbMcf/wqBpasGe4C2H5XuZv3N6lSlphfZgkb+zcuF0ecWAPY69orAYqxt+wEe6sRAQsyroDm
	v75RaiRjQTLypOFa2/9N1Hlt2WN27DRHGZRrHdKxbqZP7+YQKPkY/7ucCsoX41xTLBEUTtatn4N
	gX7XBCAOoR9aFRcLB7Fq9mJaA4SbS5gQ4GW2joJaIYYBf8J/klnnFSe3LcgoyMM3HWxZEhHXLrB
	2NPSK4EFhWUw1kLZB4DVpjoY3cmvJl73uvlaRrogjyx9z9h4MD80CYqX/pbzIJHkoxQ15N8QWXg
	E=
X-Google-Smtp-Source: AGHT+IE0JSDUhtZYJf+1hlq6gbKvK3R+qgk4DROtTWG7rlJ5CNJyG/EJ5m/YoUjrHW3xfQaY3SXBaA==
X-Received: by 2002:a05:600c:4586:b0:459:dfa8:b881 with SMTP id 5b1f17b1804b1-459e7078e62mr51416305e9.7.1754554605785;
        Thu, 07 Aug 2025 01:16:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:5bf9:b40c:d741:ea95? ([2a01:e0a:3d9:2080:5bf9:b40c:d741:ea95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459db13fc9fsm154959135e9.7.2025.08.07.01.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 01:16:45 -0700 (PDT)
Message-ID: <c2f2ba36-1a25-450e-99b9-79aa4fd4913d@linaro.org>
Date: Thu, 7 Aug 2025 10:16:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 0/6] arm64: qcom: allow up to 4 lanes for the Type-C
 DisplayPort Altmode
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20250527-topic-4ln_dp_respin-v3-0-f9a0763ec289@oss.qualcomm.com>
 <styd5gjksbsqt7efylpfn6bgwgyvt6zexxiooihjsnmp25yigp@unq7dor6gso2>
 <447c3b13-8d6d-4bcb-83c1-9456b915a77e@oss.qualcomm.com>
 <inpfuxskvmrebxitqtqwzvpnpicibo6zakgk4ujpcrqrpef2vw@nhclj5rg7axr>
 <9037fefe-aa40-4884-97ee-b81ff8346944@oss.qualcomm.com>
 <htufwjvfgdtav2gtgrytc356py6xqhrffbwjg42sgo7k4zzxof@z4xaf35qz7kq>
 <aa17d7d4-b77d-4a0a-88c3-86255dfbc29d@oss.qualcomm.com>
 <75dde9a2-3c0d-481b-bc73-089ba89a77e0@linaro.org>
 <71196aad-6d80-4356-bbe5-3070f6b74bfe@oss.qualcomm.com>
 <fhzdhzxdwcoiuhx2eogpshwt5cxagjkrygrefqikmfbx3cfcov@awmhgrvurnfi>
 <f21b7d52-4c3f-4e5b-bee7-f8b2945b5b02@oss.qualcomm.com>
Content-Language: en-US, fr
In-Reply-To: <f21b7d52-4c3f-4e5b-bee7-f8b2945b5b02@oss.qualcomm.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2025 17:48, Konrad Dybcio wrote:
> On 6/3/25 3:17 PM, Dmitry Baryshkov wrote:
>> On Tue, Jun 03, 2025 at 01:03:11PM +0200, Konrad Dybcio wrote:
>>> On 6/2/25 10:55 AM, Neil Armstrong wrote:
>>>> On 28/05/2025 18:56, Konrad Dybcio wrote:
>>>>> On 5/28/25 1:22 PM, Dmitry Baryshkov wrote:
>>>>>> On Wed, May 28, 2025 at 01:13:26PM +0200, Konrad Dybcio wrote:
>>>>>>> On 5/28/25 11:00 AM, Dmitry Baryshkov wrote:
>>>>>>>> On Wed, May 28, 2025 at 12:24:02AM +0200, Konrad Dybcio wrote:
>>>>>>>>> On 5/27/25 11:10 PM, Dmitry Baryshkov wrote:
>>>>>>>>>> On Tue, May 27, 2025 at 10:40:02PM +0200, Konrad Dybcio wrote:
>>>>>>>>>>> Register a typec mux in order to change the PHY mode on the Type-C
>>>>>>>>>>> mux events depending on the mode and the svid when in Altmode setup.
>>>>>>>>>>>
>>>>>>>>>>> The DisplayPort phy should be left enabled if is still powered on
>>>>>>>>>>> by the DRM DisplayPort controller, so bail out until the DisplayPort
>>>>>>>>>>> PHY is not powered off.
>>>>>>>>>>
>>>>>>>>>> This series doesn't seem to solve the USB side of a problem. When the
>>>>>>>>>> PHY is being switch to the 4-lane mode, USB controller looses PIPE
>>>>>>>>>> clock, so it needs to be switched to the USB-2 mode.
>>>>>>>>>
>>>>>>>>> I didn't find issues with that on X13s.. Not sure if it's related, but
>>>>>>>>> on the SL7, after plugging in a 4ln DP connection, I need to plug in
>>>>>>>>> the USB thumb drive twice for the first time (only in that sequence)
>>>>>>>>
>>>>>>>> Might be.
>>>>>>>>
>>>>>>>>> But there's nothing interesting in dmesg and the phy seems to be
>>>>>>>>> programmed with the same values on both the initial and the subsequent
>>>>>>>>> working plug-in
>>>>>>>>
>>>>>>>> Please try using a DP dongle with USB 2 passthrough (there are some).
>>>>>>>> Or just emulate this by enabling DP PHY / DP chain for plugged in USB3
>>>>>>>> devices. Would you be able to see the USB device on a bus?
>>>>>>>
>>>>>>> I only have a dongle with both display and usb that does 2ln dp
>>>>>>> (I tested 4ln dp on a type-c display that I don't think has a hub)
>>>>>>>
>>>>>>> USB3 - yes, USB2 - no (but it works after a replug)
>>>>>>>
>>>>>>> Are you talking about essentially doing qcom,select-utmi-as-pipe-clk
>>>>>>> at runtime?
>>>>>>
>>>>>> I think so.
>>>>>
>>>>> So after quite some time playing with that, I noticed that the USB2
>>>>> device was never actually kicked off the bus.. and works totally fine
>>>>> after connecting the display output (2ln DP)
>>>>>
>>>>> I was looking at dmesg, checking for discovery/disconnect messages,
>>>>> but the device was simply never disconnected (which makes sense given
>>>>> repurposing USB3 TX/RX lanes doesn't affect the D+/D- of USB2)
>>>>>
>>>>> I also read some docs and learnt that what we call
>>>>> qcom,select-utmi-as-pipe-clk is suppossed to be a debug feature
>>>>> and is unnecessary to set on USB2.0-only controllers
>>>>>
>>>>> The USB controller programming guide though doesn't talk about DP,
>>>>> but I'd expect that we may need to set that override for 4lnDP+USB2
>>>>> use cases (which I don't have a dongle for)
>>>>
>>>> Yeah basically we need to:
>>>> 1) power-off the USB3 PHY
>>>> 2) switch to UTMI clock
>>>>
>>>> In the following states:
>>>> - USB safe mode (USB2 lanes may still be connected)
>>>> - 4lanes DP mode
>>>> - DP-only mode
>>>>
>>>> But for this, the dwc3 should also get USB-C events with an addition mode-switch property.
>>>> The flatten DWC3 node now allows that !
>>>
>>> Yeah, I got even more confirmation this is intended..
>>>
>>> I hacked up something that boils down to:
>>>
>>> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
>>> index 7977860932b1..e5a0a8ec624d 100644
>>> --- a/drivers/usb/dwc3/drd.c
>>> +++ b/drivers/usb/dwc3/drd.c
>>> @@ -464,6 +464,11 @@ static int dwc3_usb_role_switch_set(struct usb_role_switch *sw,
>>>   		break;
>>>   	}
>>>   
>>> +	if (dwc->mode_fn)
>>> +		dwc->mode_fn(dwc, mode);
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>>> index 7334de85ad10..ea56f5087ecb 100644
>>> --- a/drivers/usb/dwc3/dwc3-qcom.c
>>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>>> +static void mode_fn(struct dwc3 *dwc, enum usb_role role)
>>> +{
>>> +	struct dwc3_qcom *qcom = to_dwc3_qcom(dwc);
>>> +
>>> +	if (dwc->usb3_generic_phy[0])
>>> +		dwc3_qcom_select_utmi_clk(qcom, role == USB_ROLE_NONE);
>>
>> This part is a hack for devices with no USB-2 passthrough, isn't it?
>>
>>>   }
>>>
>>>
>>> It was easy to tap into because there's already mode switch handling..
>>> But obviously it's a hack - should I register a typec_mux in there?
>>
>> I think so, we should listen to mode changes, instead of host/device
>> changes.
>>
>>> Should it go to dwc3-common or dwc3-qcom?
>>
>> I'd say, dwc3-qcom. Not all dwc3 controllers are USB 3 capable, not
>> talking about the USB-C.
> 
> I did some coding and we can't switch clock sources at runtime (not a
> huge shocker), but the bigger issue is that, paraphrasing the HPG, the
> DWC3 controller must be programmed as if it was not SS-capable (probably
> skipping starting some subcores), which is not trivial
> 
> I also came up with a sneaky workaround of simply keeping the USB PLL
> always-on, but the hardware disagrees to do so if the PHY is configured
> in the DP_ONLY mode (which I suppose makes sense)
> 
> All in all, I was not able to find people with a device that actually
> does 4ln DP + USB2 and IIUC the only drawback would be that USB2 would
> not work (and not stall the system). Not sure if/how it recovers after
> you'd plug something else into that port later on, but again, I don't
> have anyone that could test it.
> 
> With that in mind, would you be okay with me resubmitting this series
> with just a rebase & taking care of the comment to patch 5 (pertaining
> to the default mode setting if svid != DP)?

Sure please do so, and I'll retest on the SM8550 & SM8650 platforms.

Thanks for looking !
Neil

> 
> Konrad



