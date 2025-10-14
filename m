Return-Path: <linux-kernel+bounces-852877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 99184BDA237
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1B65B355C85
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2012F7AAC;
	Tue, 14 Oct 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCgY16Kp"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F582F99AD
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453358; cv=none; b=oQPsUeU1mhjySLlKKCyHmkkiWGc6pWX891vi94wszMoUl6DaKiYQyP2W2CVc15yKh2sElDrc9gXMpBwgC3xIjnGZO/+RsPf+ANx58115vHHswbCAv05CvKo0qk5+Kur27b4su8E2oo56nrYnYWDT88PZUBO4ygNoX3SLdNfa7Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453358; c=relaxed/simple;
	bh=+gU8GuyUmK9srOrfgZp7XDgFPCvUcB/bgGi+ten8cpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FB1OQR1Kd8FKFWHjv1LmACJ0OItC+o9rC2KK+RADiKOD0wDMcmHr+kovV865Fagb3oOLviL5mSkTcSRD53TPFIKHb8f6w517ywR295ztAD5S7OdRvLnveXH1TAbGoDPpT2O/tRYAY3N60BG/+bPwHtz9XhThxSpaInRGkwfVZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCgY16Kp; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b593def09e3so3678023a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760453356; x=1761058156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WSEdxW8vhqoLFw4XnO2RSQdydgt5roCSWClRMQwsv5Y=;
        b=XCgY16KpHBY2dKQlVbArQbqV2AihMEUAKHNiZI+ul4xIhro+XPKhsjSujrA7s2aWZP
         Rm7DoSu95Fc1tH7PTHx5yuh378ESSSQEHXFdAr3x/ooPg7q1p8Xdnt6hgtI8TBNz5I4c
         ms/h05DoFU9vuJXp0mlP08N4iyTB5JUKOxdAhygdivg6JDnE5VUwdFsp10zjZpfZZZEK
         /EmlmqNqdnh+HqfJGC1OufU87ndsLvu+F/KNH3eEGj6JGTutgg+oQwUiHDyS+nx2G3a7
         mtTAoi3q5JR7ph4Rb1ac2ARylBSjl+VZ9unpDGFcDttkf5btkhJy9Xm9bnE2bV9pSkdF
         vo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760453356; x=1761058156;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSEdxW8vhqoLFw4XnO2RSQdydgt5roCSWClRMQwsv5Y=;
        b=wur/aO36mMFdZqNVESZSNHTyGBYHJIWEG8vSyoxGhYJKvbGd77RMdSkznGDEenQ/3E
         eM16LY0bbw1GdE/GX1B5Fiapxt+kcqqkeaGwKS+NKEaXqA6GTbzp6kInzeAsnYh90ltN
         nrLdYIIDNGUI+5FkgxsGx12hB93tLeWJ/K+JhdoDmYNXYrOMuNeL7+kGBZtcrW/7psJG
         37fCZXjzl8ulIuulW4VupJehk2AUdBg8pvYmnx4gQm3gGKtOcYSma/h9q0mzSkGWLtWG
         iPHZ8wSEAFBVrvdU7Q6/t0Y1Sz2wSwtZcWMe269+hCcqNLeumP7rCbmwm/qgUevkGZIn
         U+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4zbfwfoJJzzxHOzMxEhEAQ3K86mWtSqq1KdjakBYRkwdWIqHeg2njD3YNJ9VzCMvlCbLmMZuZKOORa2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW7MD3clP4yKLpNg3sQahxLSVVKjPGDa/WiOL4TuLzPS+Fn/B2
	xQRwGStND27QG6wU3SVPI0lEh+VYC3YW2b4vDn7se0BQoBoocut6PXEK
X-Gm-Gg: ASbGncuAj/xsnCGOZwsIdLDgJyLpQ5ZyRDJ7Mk42QnVEY850X7ykH+cJTtu7nMZbX06
	+H0JDo0msFmlPSMQw1RF4+7/LWOR0dsdeitmZlG4fo/i1ggA4WV+8ZrWNlRt999YrwR6fZ25trc
	KhufnxoJTr0UzE2YwWKXBudX1CR7fzvpt9WxI2f++TYXMhz9pCRVUjRSbkUBhZpWfnJTQFBhu3+
	717JJAf6N54tnuubjOpUbMYhc85g//bhL/BbGGeSjye28bH+JH/fDJXzYXfIZQfbrsspCWTtOz7
	DX5MPocvjfsq1Bp985F8eVj4ehChTfrtRtpyk/LFnDpZ9EoBwqoGTKdlg/7coDivaLEBgGQ51Fy
	jEwy8leaSWDCR8grKOAIl4FCQC+e5RcDjcED3VL3Mvb5zVug6+ejehBhDjYjK66bW4DNaXte19Z
	utAuuZ2QG1DRpucQ==
X-Google-Smtp-Source: AGHT+IHRMZjidw1IlMPsFc5xiHiThksQokSbYFWWjCCXkhTX53XdUxvSbAMrz6e0Awv6re5tpQfvqA==
X-Received: by 2002:a17:903:17cb:b0:290:7803:9e8 with SMTP id d9443c01a7336-29078030e8cmr41790895ad.48.1760453356132;
        Tue, 14 Oct 2025 07:49:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f35382sm167317035ad.85.2025.10.14.07.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 07:49:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4e099ead-e6df-4489-a775-1730bc852dcf@roeck-us.net>
Date: Tue, 14 Oct 2025 07:49:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
To: Andrew Lunn <andrew@lunn.ch>, Tao Ren <rentao.bupt@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Tao Ren <taoren@meta.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net> <aO2kLyxGlGt12sKD@fedora>
 <ea64d3c1-e517-4bd8-9a2e-56432f286347@lunn.ch>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <ea64d3c1-e517-4bd8-9a2e-56432f286347@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/25 05:08, Andrew Lunn wrote:
> On Mon, Oct 13, 2025 at 06:15:27PM -0700, Tao Ren wrote:
>> Hi Guenter,
>>
>> On Mon, Oct 13, 2025 at 05:20:57PM -0700, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Sun, Jul 27, 2025 at 10:56:13PM -0700, rentao.bupt@gmail.com wrote:
>>>> From: Tao Ren <rentao.bupt@gmail.com>
>>>>
>>>> Include "facebook-fuji-data64.dts" in facebook-fuji dts to avoid
>>>> duplicated code.
>>>>
>>>> Fuji-data64 and Fuji are identical except the BMC flash layout.
>>>>
>>>> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
>>>
>>> With this patch in the mainline kernel, the Ethernet interface I use for
>>> testing does not come online when loading fuji-bmc in qemu.
>>>
>>> Reverting this patch fixes the problem.
>>>
>>> Looking into this patch,
>>>
>>>> -
>>>> -#include <dt-bindings/leds/common.h>
>>>> -#include "ast2600-facebook-netbmc-common.dtsi"
>>>> +#include "aspeed-bmc-facebook-fuji-data64.dts"
>>>>   
>>> ...
>>>> -&mac3 {
>>>> -	status = "okay";
>>>> -	phy-mode = "rgmii";
>>>> -	phy-handle = <&ethphy3>;
>>>> -	pinctrl-names = "default";
>>>> -	pinctrl-0 = <&pinctrl_rgmii4_default>;
>>>> -};
>>>
>>> I don't see this in aspeed-bmc-facebook-fuji-data64.dts, meaning that
>>> interface is now disabled. Adding it back in fixes the problem.
>>> Also, MAC3 is explicitly enabled for fuji-bmc in qemu.
>>>
>>> Was the interface disabled on purpose ?
>>>
>>> Thanks,
>>> Guenter
>>
>> The mac3 interface was removed in the latest patch (v4) per Andrew Lunn's
>> feedback, because the rgmii setting is incorrect.
>>
>> I was planning to add mac3 back as soon as rgmii support is properly
>> handled in aspeed mac driver, but kindly let me know if you have other
>> suggestions.
> 
> If it is already in mainline, i don't care too much if it is wrong. We
> don't want to cause regressions.
> 
> I only object when adding new nodes which are wrong. If we keep adding
> broken nodes, there is no incentive to fix the broken driver to do the

This wasn't adding an allegedly (sorry, it worked for me) broken node,
it was removing one that worked for me all along. Obviously I do not know
if it worked (or if it is even used) on real hardware, but it worked for
the fuji-bmc qemu emulation.

Guenter


