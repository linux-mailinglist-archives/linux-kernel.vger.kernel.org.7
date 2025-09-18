Return-Path: <linux-kernel+bounces-795037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1698AB3EC22
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB011A86127
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF483064A1;
	Mon,  1 Sep 2025 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjCJaNXq"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9F2EC0B0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756743826; cv=none; b=BdSCVV3sQ7DjvGl+pdA6+Da2aYnyyuwBkXNEWC8VH0NF1Iip2kEHrqnwoNUOLP3CixuDoVMhAYASowpPPU1l2zO8tmxa+CX9WimRYV1sc7ACNufNCaGWxkFHKvEOl9QXlD8VZ3k5uAAfrGjbzwlFlSOQ2VStp1PwNHW83iIAyB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756743826; c=relaxed/simple;
	bh=iq/TFsGHrI2sNHKrO9iqbNsl1yT5Gg67zRmEG5x38pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqw48r03lGxOg2M4z4ilQuz2bY6xde6wbX6HwFZkOeJEUSNLGFfHZyomN2MhHk8y1cQFKzmYfQfsNjxBRjZbM1OMjsct+gupJqgCsKLqPhtcFyf/oNv7wXXT0UgBHRvT2a03zbZ7cbqiGGzpqGOnU0IY3tyR/IIyQCFloCEog60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AjCJaNXq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b8b25296fso10225295e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756743823; x=1757348623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GzUXHSEp7eJvbjtj7nsj+hJJCBJtb1k9nwnWapBwc0=;
        b=AjCJaNXq1UhrHlynKsWU72cAl1v8Hl6BfY3MKo/LsH3YTrZtAU0bXeL6qS0ikPn6t0
         EONnSwVPlBcRSi+uE0NuxxPtuyjDLyVK75uPnpNfl+QxbpyzdZMlFRFEy1gXaCmUN5FU
         78hoIF/2SmGguQ9V61rYV3JdD0KMGMGhYHgfhJ3/D/Oq++CjbKL4vJwy9AJDmvIZOG8+
         BpNBQ2on4p9865ewvLNHv2l4ugV6CgrtTVpkFe+eMUfqRv73484rFFk1esItVHiXnXFE
         A86DUr1y9HQrpA6VCmaxuai6Smy+yii4ux19wgTsjA4Pi2XLjLkirgMnmtoMLqGL+2P4
         Qj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756743823; x=1757348623;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4GzUXHSEp7eJvbjtj7nsj+hJJCBJtb1k9nwnWapBwc0=;
        b=niYXbofMjIAv3QGs+mDuSdA3LwnZ3HXi52eaK+HwComudUs0N2LeqL+InD1xyAqvDg
         vHIxJlvFNXNyv8p56fn78zxdsxrrU+e7XpqFhmaf55pgvm8F9hRZJYCgfHNJGYAK6evO
         StUuCXHl/YCKYUU+InhoeeY3BPIZ8mpp5YKtSnBgV7OXf04oKAM91WmhRQCP7GoIaqLb
         gvhWhA4Iu6daPygBnDPWEZrNvCnYEVe8X+eD3nKlogFtYvCSTMZuQJWsUT2tOpUnspjR
         lJ99Kl2La/fU3c0D7y+1Tie27jfhrOL8SJQjxtgWje5S7mBu77VoN1o+lHNsQIwtnMNt
         ivdw==
X-Forwarded-Encrypted: i=1; AJvYcCXjRZ7WXnJxkKFjfKrMlotNXoytrw/UJkp4FgTlH4nbYyxecUc0Gwlo8v1HFvgrOyP+CmqkTAgSnZQDepw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw201X5SU1i3ND+KTGLfsUrH14lAW3kkbf+jKKsEeuZEPedzgSS
	lNmq1cjpIS6ypS58suMYDyiMFXz0gy0iVaSLh+feoB2DJ85Smy+Qj1z7xoq7uX9nvSI=
X-Gm-Gg: ASbGncsacyD9tyhzCVCGZ7oZbPLOKAMi06VCb04NOnjZ2LdwMCTK1owHtDgXXozWIwB
	7M/be6MW860Hg0/tSN+ffezRKkr8r2H0mU5HCq+3jSrBKyqJcVdnl58063Ff+A6yKd5UQ6Bwz5n
	Bs/yw6DqGH8pj9DeRDZotPLHy3uvqRClpF3qYnY+sktbzbITcu/TWB03WwF56kmsMK51rkHHsOb
	xLz01lB1MvxVZdL4T0dQCHwx2Ek7uCfuQc1UpLVjSlUqzeNzjRpCuj1NthkeY2v/D/cq8iqdMZy
	6LDfRoV6X62xDK0Zr2bIO28EPK/1dGy4ps9RNXOjWGg/uJYxxaqqv4qmbgcprDPPFW5yYEFuhPl
	Dmx8dumLt+Ln2r0WRYIHQU+2oKqm7Beu1AVqxOw4sMjFuN0OeNmAxYFxFYpWqLTNzzv5R9hE7
X-Google-Smtp-Source: AGHT+IGOiAaP7qHZISQMW/8CIihks4EKOOBLIZhO0W40c2pGhFYTuXr7Dc/THjMvr7cxrtgMTC0jlQ==
X-Received: by 2002:a05:600c:35ca:b0:45b:87a6:cf8 with SMTP id 5b1f17b1804b1-45b87a61003mr52789485e9.27.1756743823059;
        Mon, 01 Sep 2025 09:23:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:881c:7d0e:ad0a:d9a? ([2a01:e0a:3d9:2080:881c:7d0e:ad0a:d9a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7df3ff72sm101954645e9.1.2025.09.01.09.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 09:23:42 -0700 (PDT)
Message-ID: <2e5fc8dd-4dc2-4fea-9321-80daa5177163@linaro.org>
Date: Mon, 1 Sep 2025 18:23:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] platform: arm64: thinkpad-t14s-ec: new driver
To: Sebastian Reichel <sre@kernel.org>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-arm-msm@vger.kernel.org
References: <20250831-thinkpad-t14s-ec-v1-0-6e06a07afe0f@collabora.com>
 <20250831-thinkpad-t14s-ec-v1-2-6e06a07afe0f@collabora.com>
 <ea0b329e-ab3e-4655-8f27-e7a74784302a@app.fastmail.com>
 <pslvca6j5fpr5dgvciwlaz3fubnkjq5olfontaaytt56xs4bvk@5typdoosbreo>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
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
In-Reply-To: <pslvca6j5fpr5dgvciwlaz3fubnkjq5olfontaaytt56xs4bvk@5typdoosbreo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/09/2025 18:10, Sebastian Reichel wrote:
> Hello Mark,
> 
> On Mon, Sep 01, 2025 at 09:48:39AM -0400, Mark Pearson wrote:
>> On Sun, Aug 31, 2025, at 5:28 PM, Sebastian Reichel wrote:
>>> Introduce EC driver for the ThinkPad T14s Gen6 Snapdragon, which
>>> is in theory compatible with ThinkPad ACPI. On Linux the system
>>> is booted with device tree, which is not supported by the ThinkPad
>>> ACPI driver. Also most of the hardware compatibility is handled
>>> via ACPI tables, which are obviously not used when booting via
>>> device tree. Thus adding DT compatibility to the existing driver
>>> is not worth it (almost no code sharing).
>>>
>>> The driver currently exposes features, which are not available
>>> via other means:
>>>
>>>   * Extra Keys
>>>   * System LEDs
>>>   * Keyboard Backlight Control
>>>
>>> The driver has been developed by reading the ACPI DSDT. There
>>> are some more features around thermal control, which are not
>>> yet supported by the driver.
>>>
>>
>> Thanks for working on this - it's great.
> 
> It's a personal scratch your own itch project, as I daily drive the
> machine.
> 
>> I'll see if I can get the EC spec so I can do some checking on the
>> values (I thought I had it already, but I can't find it). If this
>> file can be used for other platforms then it might be good to
>> rename the file to not be specific to the t14s? I'm curious if it
>> can be used on the X13s or the Yoga platform.
> 
> Maybe. I only have the T14s (apart of my older Intel/AMD ThinkPads,
> which use the ACPI driver). The ACPI DSDT functions completley
> abstract the lowlevel I2C interface, so in theory every ThinkPad
> could have a completley different EC and still use the same ACPI
> driver. So this needs to be checked per-device. Hopefully the low
> level interface is similar in those, so that we don't need to spam
> the kernel tree with multiple different EC drivers :)
> 
>> Couple of notes
>>   - I do agree it doesn't make sense to add this to thinkpad_acpi.
>>     That file is too big anyway.
>>   - If there are other pieces like this where some detail of the
>>     platform is needed, please do let me know. I never got enough
>>     time to work on this platform directly, and it wasn't in our
>>     Linux program, but I do have access and support from the
>>     platform team for getting details on it. If I can help, so not
>>     too much reverse engineering is needed, I'm happy to.
> 
> Thanks for the offer.
> 
> I would be interested in bits around system suspend. Right now
> support on X1E is limited to sending the CPU into suspend. Much of
> the machine seems to be still powered. Right now the keyboard
> backlight and all the status LEDs stay on and the LID + power led
> does not go into the typical breathing pattern. Additionally I had
> to disable wakeup capabilities for the EC interrupt, as closing the
> LID generates an event and thus an interrupt, which wakes the
> system. Obviousy that is undesired from user's perspective. My guess
> is, that there might be some register to mask events, but I haven't
> found it so far. Alternatively the EC might mask them automatically
> when the system is send into suspend, which I also have not yet
> figured out :) The only bit I know is, that EC register 0xE0 is
> involved in modern standby.

I was wondering if there's a command to poweroff the system when still plugged in ?
The actual behavior does a PSCI poweroff using the PMICs but since the EC
keeps the power on and is not aware we want to poweroff, if just reboots.

Neil

> 
> Apart from that and (probably) unrelated to the EC: I noticed that
> accessing the built-in webcam (with the X1E camera patches from
> Bryan O'Donoghue) does not enable the status LED. It would be
> nice if you can check how that is wired, so that it can be enabled
> when a camera stream is started.
> 
> Greetings,
> 
> -- Sebastian


