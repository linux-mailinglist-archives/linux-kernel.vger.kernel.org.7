Return-Path: <linux-kernel+bounces-872405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09267C10D21
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2157C1A6219F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAC92C3745;
	Mon, 27 Oct 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTiTG9Fh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF472222AA;
	Mon, 27 Oct 2025 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592467; cv=none; b=Xbqdu9U+u2B2vCrxWdxJYPTWcFfHp+baN2jkJE6z0G+p+Uo8K0cmyBkLUtU3NXljjD3uzh939XQm5QQGzoNIHDuPs7xR6arhI3D4ViTN8Kw3BHccTpfSGI8a/R+Qg494TmpQqcJuPJRCjYYmRgs7uX7tKSrnWv4aMKH9+mFCt/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592467; c=relaxed/simple;
	bh=+mFuXCj6hoQC6YKCQOaY4omuj6mxwalKrIiJMI6Qj3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mStJvJSp2q+LbqjjkkHcPYg1jzgBBIWmt8ZT2PjVCHOe9UfdPhAqCDi+nRRyvcNS4YaP6ZXv5HJq6SShP7o528s3tu6Zz7QPQ+jJOO79iIgWNZl5SVKHD89aZ00/okB6uwj2LIjeJitW/zCVXZJ4GEOOMRraeNR68jiY1cKyGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTiTG9Fh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EF3C4CEF1;
	Mon, 27 Oct 2025 19:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761592467;
	bh=+mFuXCj6hoQC6YKCQOaY4omuj6mxwalKrIiJMI6Qj3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PTiTG9Fhyi3L5YSY/ADc8MNw+9LqZhDqUp9Ip5W8h2u2J3kbEXrpLCpplNkRZKFzT
	 kB3I0iqZDqb4IFbqyPcB9Y/AhtrjU4+MGUGqtPv9cV7UNePIexiPn0xwRnSdRORGLx
	 6Tcqn58ANHquf1ovMzWQCuVFw8FF2ut1OuMfGs0KTEYqrwPpIIRU0uvk92IpIe+bia
	 uCuR8wUy445syP7xicFsL99k7p44Gc8Lm+hb60nn+meC6n5Efixml9sOr/e8sIRN75
	 FbVseMcOB6Yw4trRv7TlmbQR6BtjI7vtq3AqnNrhfFREKkOvGARiOqv6sJEIjIdPLm
	 DxHNlrazY/08Q==
Date: Mon, 27 Oct 2025 14:14:25 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Igor Reznichenko <igor@reznichenko.net>, conor+dt@kernel.org,
	corbet@lwn.net, david.hunter.linux@gmail.com,
	devicetree@vger.kernel.org, krzk+dt@kernel.org,
	linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add support for ST TSC1641
 power monitor
Message-ID: <20251027191425.GA1403533-robh@kernel.org>
References: <408c1698-a8ad-4e16-8def-352c2c265f5a@kernel.org>
 <20251026184641.631641-1-igor@reznichenko.net>
 <a45ad6b8-b4d5-4e0c-8f1a-3641dddb240d@kernel.org>
 <e51c3dfa-406b-4dfa-bbb5-c31d1a2e0007@roeck-us.net>
 <112db7fd-3c0e-4c56-a553-5aca12965bdf@kernel.org>
 <0dfcfcde-d207-44af-ae7f-d90d623bac02@roeck-us.net>
 <ea00a07b-d0d6-49a2-a9d6-ef6c1ecf57dd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea00a07b-d0d6-49a2-a9d6-ef6c1ecf57dd@kernel.org>

On Mon, Oct 27, 2025 at 07:01:47PM +0100, Krzysztof Kozlowski wrote:
> On 27/10/2025 17:53, Guenter Roeck wrote:
> > On 10/27/25 01:40, Krzysztof Kozlowski wrote:
> >> On 26/10/2025 20:58, Guenter Roeck wrote:
> >>>>>>> +  reg:
> >>>>>>> +    maxItems: 1
> >>>>>>> +
> >>>>>>> +  shunt-resistor-micro-ohms:
> >>>>>>> +    description: Shunt resistor value in micro-ohms. Since device has internal
> >>>>>>> +      16-bit RSHUNT register with 10 uOhm LSB, the maximum value is capped at
> >>>>>>> +      655.35 mOhm.
> >>>>>>> +    minimum: 100
> >>>>>>> +    default: 1000
> >>>>>>> +    maximum: 655350
> >>>>>>> +
> >>>>>>> +  st,alert-polarity-active-high:
> >>>>>>
> >>>>>> Isn't this just interrupt? You need proper interrupts property and then
> >>>>>> its flag define the type of interrupt.
> >>>>>
> >>>>> This controls a bit written into device register.
> >>>>> I omitted interrupt property after looking at existing power monitor bindings,
> >>>>> especially hwmon/ti,ina2xx.yaml. INA226 has very similar bit controlling alert
> >>>>> pin polarity and binding doesn't define alert pin as interrupt. Overall, I didn't
> >>>>> find many power monitor bindings defining alert pins as interrupts.
> >>>>
> >>>>
> >>>> On INA2xx that's SMBUS Alert. Is this the case here as well?
> >>>>
> >>>
> >>> It could be wired to SMBus alert, or it could be wired to a CPU interrupt pin.
> >>
> >> So please explain me why CPU interrupt pin, which in every really every
> >> device called "interrupts", would not be "interrupts" here? How CPU can
> >> even guess the number of the interrupt in such case, without
> >> "interrupts" property?
> >>
> > 
> > I thought we were discussing the need for the st,alert-polarity-active-high
> > property, sorry.
> 
> 
> Yes, we kind of do, I am just trying to understand what is expressed
> here. If this is a CPU interrupt, its flags should mark the proper
> signal level, including inverter.
> 
> If this is something else (or both), then this property might make
> sense, I just don't know what is this.

If the device's polarity is programmable and there's possibly an 
inverter, you can't express both with just flags. In that case, flags 
should be the polarity after the inverter since flags are defined by the 
interrupt provider. So we'd need something to define the device side. 
Perhaps wait until someone actually has h/w with an inverter needing 
this.

Rob

