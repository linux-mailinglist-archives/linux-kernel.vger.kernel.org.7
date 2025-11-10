Return-Path: <linux-kernel+bounces-893530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B90BC47B42
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D234259D1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4FB313E34;
	Mon, 10 Nov 2025 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtMJ9ZVm"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59AB257859
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789314; cv=none; b=aIj5fgdKm5GAdfbUS6XXVFPTZmGe5GCrNvy+QjeL6boM4uRpFueK8fJS89C+71tKPMWsoTVE39/eQjq0q1f4QCa7HCuYvjAz6RbSYSG0aujTmt6F0Pn35LU4IxtzuLwVaYMeTp+cxlUr2p/TcAXNzdB4eKOD3deWrSkOVPbZruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789314; c=relaxed/simple;
	bh=IBEHosaYIw4Uy2q8CYzcuC+/MKjcxH+HXLEgyNLHiEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBvonMsJXBkoQc4kbu2xXFFFfGgtilMXObzZdY/6R9EuKZDn29XA4cv2RcjWDqk+orcUJJaqJH+3VJOTFIphocbWym+69EiHnnpk78uiNNLkRjBoM9agvvmlI9DmCNrtY73EOhWp0gHGPci80Q7k3KHrudWcNL7/xfIaRsWW7fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtMJ9ZVm; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7af603c06easo2908828b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762789312; x=1763394112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ylq5ip16KIlNEm4q5Drc6EevlzHi/eE660ukaOSOxw=;
        b=VtMJ9ZVmyhkYlREYDhuIP/MGHIeqIrH8d9SKCs4YNq6LqjSPiaIAjiKoPLnmDhvbTX
         OknozvPCaRJOSApwEiqdz0D3Swz6niOUIKUDq85P6q8R1PVTfK2YIe4N/RIhH3JnMkeO
         ck/BBOYNtHsxdb5j3YkqFgL9odOF3fOFYxHujKxXXJ5vcKRzFpSmW3qf8zEgNEpes3qr
         03FpkWFAgbfgiojS14yLcN5QgRcZuIEcdgOqRaIG2WWuPQbYS6h0o/OEikWMfgzDv1ep
         Zi4XwmUJUw/Y6v8TAtEYjPN5OP67B9FvgKnzNhwq6QZBKOyJu1I+aXRob/AYt0QB+zpD
         OYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762789312; x=1763394112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ylq5ip16KIlNEm4q5Drc6EevlzHi/eE660ukaOSOxw=;
        b=BkfmBGhUq4Ie7jf3bd9LI1bhxHAKVsddAfDaslZomCMh6RwSgPuvsS0s/pkYpcXLq7
         MAb3n4Dp2psE/chKDADfVzsSt8gaP+ULHDmdHc04tdI7/OJKBwMv+gkshicyYF/5XZP3
         4XLnBL0vwEjLYUZhWTM7Hfx5FTYHgHZxSIpe4EIRFyhwY0HBj7PKsKPdBDbw0+a5U4gc
         sGU1C9XJ91ArRH9DjAw5p1FY6g33OsMF4CPkVFlWlMaDO6W7OXdy9aV36VAUQ3cydBR1
         npiU2N70hrFASfESBQzJNu314PdZ4tNZuFcArdenwTVQIzmSUrAu/KoOd+POP5tzjAIn
         blmA==
X-Forwarded-Encrypted: i=1; AJvYcCX6MQjzfNfV0vr9iR9yxpRCZ0eucfZ0x165ihgA2Ro5xvg56l+A7TW+nsQmGKnFWF7gR2TpCVaFgud/Phk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyanvQSDPdTSqq1dICy3ReMBJPQCP+j6m0YcL15miVgvZbWNBEL
	niJJTGR7KaPGu75yDcTS2em/2YkgaB4/Wl73reVeLv6bfBPbrLXH22SH
X-Gm-Gg: ASbGncvkPVvEbSd6+Ar0ZChVyVZbDTTpl8hp+B7FQPdIv+WTc5N5u/dZo5DjgntALFT
	aHAa/kTntHtozvO0SjsF4xTKeMEVZYx+f6jkmbciUab/AT4yNSP9v3KNednFtbUYRbNSy3rsSbA
	vjdPppyoZPKEE37392OV7d79iekRnwdqhTh9/PiuYL4tOcxHSdz+1tZ2KZ22hk3pRrTCCCKZhmx
	+jeB2Lk1M1i3enpRqvgR44NNIUD9Adsvu28LggJBsH8yubZ3XPjHjSIIAXd8z6IHzpLanQ6vS8O
	6fzRpIHT+pecJZQWI7D0AWTEN9S9U4YdzgnrECnPS4B5caW+m3Hg8xaRPs+JomscJ4vy6d6kVFJ
	Q3sa9zgipyVKlOgkw8XBwEU1h5j7ZwoG4cviwEZ+m10lP5nTWUAth82Tt55NeUQ4o0IFBQKFL0/
	YppSdjUQncHA==
X-Google-Smtp-Source: AGHT+IH2AanJ/xvo0tNEHTz1Ql1SAqJGcv6JRo7rtSuZftddi6C1S80+uwRJGFeK0pubFMUbdbyzbA==
X-Received: by 2002:a05:6a00:3213:b0:7ae:b13f:37c2 with SMTP id d2e1a72fcca58-7b14a1206aemr10855026b3a.10.1762789312083;
        Mon, 10 Nov 2025 07:41:52 -0800 (PST)
Received: from localhost ([2804:30c:1661:8a00:578a:911c:ac25:24a6])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7b0cc76c0dbsm12121713b3a.51.2025.11.10.07.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:41:51 -0800 (PST)
Date: Mon, 10 Nov 2025 12:43:09 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, cosmin.tanislav@analog.com
Subject: Re: [PATCH v1 0/3] iio: adc: Add AD4134 minimum I/O support
Message-ID: <aRIIDTUR5Pyz1Rxi@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1762777931.git.marcelo.schmitt@analog.com>
 <aRHgaXxxnD5YsIQQ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRHgaXxxnD5YsIQQ@smile.fi.intel.com>

Hi Andy,

On 11/10, Andy Shevchenko wrote:
> On Mon, Nov 10, 2025 at 09:44:56AM -0300, Marcelo Schmitt wrote:
> > This patch series adds basic support for ad4134. AD4134 is a very flexible
> > device that can be configured in many different ways. This series aims to
> > support the simplest way of interfacing with AD4134 which is called minimum I/O
> > mode in data sheet. This is essentially usual SPI with the addition of an ODR
> > (Output Data Rate) GPIO which functions as conversion start signal in minimum
> > I/O mode. The CS pin may be connected to a host controller CS pin or grounded.
> > 
> > This set provides just one feature:
> > - Single-shot ADC sample read.
> > 
> > [PATCH 1] Device tree documentation for AD4134.
> > [PATCH 2] IIO Linux driver for AD4134.
> > [PATCH 3] Initial IIO documentation.
> > 
> > There is a driver by Cosmin on ADI Linux tree that supports AD4134 in wiring
> > configurations suited for high speed data transfers. Even though the minimum I/O
> > support was initialy based on that high speed transfer driver, the result ended
> > up becoming entirely different. Also, because the different wiring
> > configurations are likely going to use different resources and software
> > interfaces, the code for AD4134 support was split into ad4134-spi.c,
> > ad4134-common.h, and ad4134-common.c.
> 
> The cover letter misses the answer to: "Why do we need a brand new driver?
> Don't we have anything similar already in IIO that can be expanded to cover
> this one?"

Ah sorry about that, let me provide more context.

ADI has a design called AD4134 which people would like to use with Linux.
This is another fast sample rate ADC that would need SPI offload support to
reach maximum sample rate. The driver I mentioned above provides support for the
SPI offload use case but, it has not been reviewed nor merged to mainline Linux
(at least as far as I'm aware of). I also searched the lore and found no
previous matches for ad4134. So, we currently have no driver supporting AD4134
on mainline Linux.

Why not just upstreaming the SPI offload support driver for AD4134? To achieve
the highest sample rates, the AD4134 provides a dedicated set of lines (DOUT0 to
DOUT3) to output ADC sample data. We would need to describe and manage an
additional bus this part (an SPI bus for configuration, and a data bus to read
ADC conversions). In ADI tree + HDL, the data bus is read through SPI-Engine
as usual SPI data and a second SPI controller interface is used for normal SPI
commands. The setup actually uses two AD4134 devices and is more or less like
the diagram below.

::

                                                              +-------------+
  +----------------------+                                    |  DATA HOST  |
  |       AD4134         |                                    | (SPI-ENGINE)|
  |                      |                                    |             |
  |Data interface  DOUT0 |----------------------------------->| GPI0        |
  |for ADC data    DOUT1 |----------------------------------->| GPI1        |
  |read back       DOUT2 |----------------------------------->| GPI2        |
  |                DOUT3 |----------------------------------->| GPI3        |
  |                DCLK  |<--------------+        +---------->| GPI4        |
  |                ODR   |<------------+ |        | +-------->| GPI5        |
  |                      |             | |        | | +------>| GPI6        |
  |                      |             | |        | | | +---->| GPI7        |
  | SPI interface   CS   |<-------+    | +--------|-|-|-|-+---| DCLK        |
  | for register    SCLK |<-----+ |    |          | | | | |   |             |
  | access          SDI  |<---+ | |    |          | | | | |   | TRIGGER     |
  |                 SDO  |--+ | | |    |          | | | | |   +-------------+
  +----------------------+  | | | |    +----------|-|-|-|-|-+     ^
                            | | | |               | | | | | |     |
  +----------------------+  | | | | +-----------+ | | | | | | +---+
  |       AD4134         |  | | | | |   HOST    | | | | | | | |
  |                      |  | | | | |(ZED PS SPI) | | | | | | |  +------------+
  | SPI interface   CS   |<-|-|-|-+-| CS        | | | | | | | |  | PULSE      |
  | for register    SCLK |<-|-|-+---| SCLK      | | | | | | | |  | GENERATOR  |
  | access          SDI  |<-|-+-----| MOSI      | | | | | | | |  |(AXI PWM GEN)
  |                 SDO  |--+------>| MISO      | | | | | | | |  |            |
  |                      |          +-----------+ | | | | | | +--| OUT0       |
  |                      |                        | | | | | +----| OUT1       |
  |Data interface  DOUT0 |------------------------+ | | | | |    +------------+
  |for ADC data    DOUT1 |--------------------------+ | | | |
  |read back       DOUT2 |----------------------------+ | | |
  |                DOUT3 |------------------------------+ | |
  |                DCLK  |<-------------------------------+ |
  |                ODR   |<---------------------------------+
  +----------------------+


Luckily, for handling the dedicated data bus, we might benefit from the multi-bus
support [1] in the future. Though, the high speed setup has other implied
intricacies such as an additional periodic signal (ODR) being required to sample
data in addition to DCLK.

[1]: https://lore.kernel.org/linux-iio/20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com/

Although we got that working on ADI tree, there are some aspects of the high
speed driver that could be improved before upstreaming, IMHO.
So, to start with something less overwhelming, I thought of trying the minimum
I/O mode first (a.k.a. usual SPI interface). Note that the -common parts of the
driver are intended to be reusable by the high speed driver when we get to
upstreaming that. Also, by the way, that high speed driver doesn't support
minimum I/O mode and the intent is that the drivers will provide complementary
ways of interfacing with AD4134.

With best regards,
Marcelo

