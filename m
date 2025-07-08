Return-Path: <linux-kernel+bounces-721306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFD3AFC769
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA6D16AB90
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95E426656F;
	Tue,  8 Jul 2025 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FTm54VJu"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFFB26657D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968236; cv=none; b=Ylm/Y2Ck1+Tf9KVrEhrugIn+WDedBV3cGbzgxPnjDN71inW08ub2YckWo5/osCaLMvBQlOfTg1xn4B6S6ZvQJI5QyXuBsOIoi/VCk78QW6EgVDWm9tiZCm7iRjswPTjoALQuGZTRrdKVhq82gEE9t2tveaCppfJBiiVw9t1R704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968236; c=relaxed/simple;
	bh=t89Yf7+DerPlaKJU1hIyceP0lU68DrU0bFoPmD6e0bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjWIYVF6mnp2ZqF8AQueOpEGFdKhJoXujF5D2BdzaIdOMprGxH4WyeoezFX7QViOdWzfnc3x16Gl6YkKj9hOxBGfLqkDh/IYERndl/jmVHRVCQ1LqqewzBiGHS3KcObX8iprPrU83BMrnbam0x3Ew5QfEOIeb+r1T92ASf2PKG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FTm54VJu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so2633769f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 02:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751968232; x=1752573032; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pSJ4xbdE5FzpQMbGAihlry1r8QLUQSOrBPNupb4bNqM=;
        b=FTm54VJuSiQiNbzwd3kzxy8AOLOtSCDQbWAHHrBtaIiUche2GQIjGBHsb+ABIaZcnN
         eAdqxtgY5t/q+QAY4OrrvjR7kneuAg7l89nNg+T1iIWMaWd3XTa48oMFj4UUQIyg8bKT
         wWAVsMJSWtQhNDhdxI/EBIQXLTHQpsNMuuf+FpaBBNwxQd53uun18DvuMG035eLi0ws1
         8WClX1vWWqrXkv2kYNSg7GqNcznB/DSxnzRrJWcWB4/ivqfv3rsfYhMFNYnK6oToJdpe
         VEb9+STRqOWvkaDhIVOD0npOo81PrsonMphPc0KQPkHlNlnZTRPSyZvSL0iGpBBTg2E2
         SfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751968232; x=1752573032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSJ4xbdE5FzpQMbGAihlry1r8QLUQSOrBPNupb4bNqM=;
        b=rM6+HTeJDeY2ble90N00tOvMUPHgsDiMFLOUGQU0w3YZjL43Ou+dWkDIjXO2rd8cVf
         gfid9LEk2GJ3D3L6XDPG8MFsccYzh2NDfajrOH8E3x+a+FCyCPxIx+Gk2E0/FMjgCpLJ
         Zwz7Bp1en+DQ+isqxto/lI7K9ow0OcpQ9MI2Dgv7M8/DKRHcBmu8qTu7oM3oicezu6Ew
         kDPSybPBXH/USabAISTdZfus7VO8mXM9XxIofR0hmMuB5XpTq/+NQfTT81SGUXHwxKzU
         9SwLeXYt91ctdCNrYMAvbqqJUlft7US4vRqifsFdltftOyrNf0/JoT2Eg+uKqP/HCxvL
         c++w==
X-Forwarded-Encrypted: i=1; AJvYcCUvD6QTmGgyn3KR/K208M8a70C8/zumrhgL2aO3dgdcvJt6PRO2CRmLqpqE3WjqDTwmnxdB4qkLwQs9o9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6VFO9XyD1amZcUsXreO2bmwjw+xXoSHq6iOmZqQOXI/AVZwxD
	V/Q2M/YK5g2Uo/937pVLxbnizRCsr+MaFANQatcPzj1bCdBzIo0Dmknpnckg2QhB8HE=
X-Gm-Gg: ASbGncvNTCbGjOlv+F2EKWsd27sG75YMj2zHZzhRQRIa5bAbBmBA6M9bLApagAcr8ql
	U2imKvVLPTnTorH4QPktw+oqByIw66hakpMjeyQzpCfyMn33KICd0ZqC3glC+mR9a1SjkEkzLUe
	gCabKqE8xohprIv5DAMbmr51pQaKrEn0Dql+qfircWZqt/T/J7fXPYFpXRcxLiMnQxFT4ZYBhp9
	MRkqnUPwcqo+WiMIjp9jOmk/j+XORa9m7zE3akMExExAOLAD/XbXAmtSmnJ1htHsgOfv29de1sJ
	d115M6jA0A5MRV6PwPiy9nsJHJTIwrEjtoKPdMZJ+xkB4LFtiMt31KBgmPEsJfLdG8P/OhUABu5
	O5TR6z5SgbafyKrz5hJC/9ybLLL0+nGHD3ho=
X-Google-Smtp-Source: AGHT+IHxZjUwhr7/XtNanwJKqQGkEPOWNVunJNfj6Cx7RTxPaIJicvhyp1mjjFMNb1tJ1wQb1OvA/Q==
X-Received: by 2002:a05:6000:2b03:b0:3b3:e3f6:4a9b with SMTP id ffacd0b85a97d-3b5ddedc46emr1157400f8f.41.1751968232398;
        Tue, 08 Jul 2025 02:50:32 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd38f092sm17559575e9.1.2025.07.08.02.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 02:50:31 -0700 (PDT)
Date: Tue, 8 Jul 2025 11:50:29 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: William McVicker <willmcvicker@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC] timer: of: Create a platform_device before the
 framework is initialized
Message-ID: <aGzp5esx1SpR9aL5@mai.linaro.org>
References: <20250625085715.889837-1-daniel.lezcano@linaro.org>
 <aGMjfxIvbCkyR5rw@google.com>
 <27644998-b089-44ae-ae5f-95f4d7cbe756@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27644998-b089-44ae-ae5f-95f4d7cbe756@app.fastmail.com>

On Tue, Jul 01, 2025 at 09:52:45AM +0200, Arnd Bergmann wrote:
> On Tue, Jul 1, 2025, at 01:53, William McVicker wrote:
> >> @@ -1550,6 +1553,8 @@ typedef void (*of_init_fn_1)(struct device_node *);
> >>  		_OF_DECLARE(table, name, compat, fn, of_init_fn_1_ret)
> >>  #define OF_DECLARE_2(table, name, compat, fn) \
> >>  		_OF_DECLARE(table, name, compat, fn, of_init_fn_2)
> >> +#define OF_DECLARE_PDEV(table, name, compat, fn) \
> >> +		_OF_DECLARE(table, name, compat, fn, of_init_fn_pdev)
> >
> > To support auto-module loading you'll need to also define the
> > MODULE_DEVICE_TABLE() as part of TIMER_OF_DECLARE_PDEV().
> >
> > I haven't tested the patch yet, but aside from my comment above it LGTM.
> 
> The patch doesn't actually have a module_platform_driver_probe()
> yet either, so loading the module wouldn't actually do anything.
> 
> I feel that this RFC by itself a good step in the direction we want, 
> so Daniel should go ahead with prototyping the next two steps:
> adding the platform_driver registration into OF_DECLARE_PDEV,
> and converting a driver so it can be used either with the _OF_DECLARE()
> or the platform_driver case.

I'm questioning the relevance of adding the macro when the driver is
not compiled as a module.

The first step of this macro is to allow the existing init functions
to be converted to the same signature as the module probe functions in
order to share the same code and take benefit of the devm_ variants
function which will considerably reduce the code size of the drivers.

Then we have the following situations:

 1. The driver has to be loaded very early TIMER_OF_DECLARE_PDEV
 (MODULE=no) the function timer-probe() is used

 2. The driver is a module_platform_driver() and MODULE=no, then it is
 built as a builtin_platform_driver(), we do not care about having it
 loaded by timer-probe()

 3. The driver is a module_platform_driver() and MODULE=yes

If we do the change to have the TIMER_OF_DECLARE_PDEV() adding the
platform_driver registration when MODULE=yes but using timer-probe
when MODULE=no, we change the initialization and we will have issues
with timers needing resources like SCMI clocks and where the
mechanisms rely on EPROBE_DEFER.

IMO, module_platform_driver and timer_probe must be separated.

Let's assume the one possible future use case with the VF PIT. This
timer is only used on ARM but now it is also supported for the ARM64
s32g2. For the first platform we need it very early and in the second
case, we need it later because the architected timers are there.

We should endup with:

static const struct of_device_id pit_timer_of_match[] = {
	{ .compatible = "nxp,s32g2-pit", .data = &s32g2_data },
	{ .compatible = "nxp,s32g3-pit", .data = &s32g3_data },
	{ }
};
MODULE_DEVICE_TABLE(of, pit_timer_of_match);

static struct platform_driver nxp_pit_driver = {
	.driver = {
		.name = "nxp-pit",
		.of_match_table = pit_timer_of_match,
	},
	.probe = pit_timer_probe,
};
module_platform_driver(nxp_pit_driver);

TIMER_OF_DECLARE_PDEV(vf610, "fsl,vf610-pit", pit_timer_probe);

If we change the TIMER_OF_DECLARE_PDEV to a macro which relies on
timer_probe when MODULE=no, then the "nxp-pit" on the s32gX will fail
to initialize because of the SCMI clocks not ready and the routine
won't reprobe the function. This issue won't happen with
builtin_platform_driver

What about something like:

TIMER_OF_DECLARE_PLATFORM_DRIVER(__name, __driver) \
  TIMER_OF_DECLARE_PDEV(__name, __driver->probe); \
#ifdef MODULE
  module_platform_driver(__driver);
#endif

Then in the timer_probe() we browse the of_match_table compatibles and
if the probe function succeed then we do of_node_set_flag(np,
OF_POPULATED) which is supposed to prevent calling the probe function
later.

Thoughts ?

--

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

