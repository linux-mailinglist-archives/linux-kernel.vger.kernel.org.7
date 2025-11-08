Return-Path: <linux-kernel+bounces-891737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CBEC435A6
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 23:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67323B01E9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 22:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D2C19F137;
	Sat,  8 Nov 2025 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T90R/NFy"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B01DFD9A
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762641813; cv=none; b=golI9oNUDBIDUaL46+XKyFs86NPUudyfpBu58ami5xYq8r9PAw/B14lqi5eH6+7ed6wnW5zmHTZpv3HHp5xdyO5fcc56S8ZF3U2dhE2sedJp17nFo8IrLtky40SOQRTTsAXqMjkuLgDniPki69N4pf7ZLHd6ZqdzCYmzM7qitVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762641813; c=relaxed/simple;
	bh=Y+uY9AkG8jnbUsyHDtuyh+LKJdD/DJna8xyrHuGV5WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPTod/ciulTjGnDgbhBvm5tdoSpQHqUnHaYs6Rrf+IKks4IEpyRO576ngZkUEDjvo3WgQEhKIBVcBD3T4W6TO7M6Qom7hcsv/nFic9/3pbX4I0p0GlKXXT6/rSvZEijL3RDLLuUDdt1gHy+AQh2EiaIJOnx9KcYEcP+lbg8Kvzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T90R/NFy; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5dbcc814b80so717209137.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 14:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762641811; x=1763246611; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AVoITpMtYi5Kgaxbk7LevCo8Kqli+/vM/Zg8iA9IuYM=;
        b=T90R/NFyWpdcrtXz/cn0pUaOs9WcyswQh0cUDEO3HdWbtw48a5YBMt/Kv1udcoovCi
         MA1gpXkT9LU7k4Yc9iQzf0IplFluzh6FmUSYEX7V+NXTFUUORyOrPiIiVKEi1OLFQJRQ
         0n/WbjrnehjtcJfboTGPwSzHDGFK8kgj561JKGBTGw1rl5LFsgsmjHgQ3VUdrNy/4PvO
         bSFgBDEEAmQz7zpfaOz0zQEtUjJ6ZJwa576y9L/36Lp9T4DBLNhxRpUpku4I+wh4rimB
         TFRbdEE/DledGXQAt6fiZES6JUwmpa8aNNZiiCajLaP3yEPgNysqyVhCHnWJJHvQeWht
         0nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762641811; x=1763246611;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVoITpMtYi5Kgaxbk7LevCo8Kqli+/vM/Zg8iA9IuYM=;
        b=H62wW6J5NutVeyI5jsE9x0JaNypVS3sUqzkfA9s2BJpBpPSZ4tuN+NyjQsukGOsGyz
         gtVxmgGDoZJ/RGqep2wL6SxbYkzXA2NEU5QHdMFfJ/LqME6Y7wcXkvXBCqjtEWdbvsEc
         6s7We8DBL1yA9tv6b37TRkAiBGqKLdwjKbYWCHF40YJKsXXLsG/ZqRhzpXGKJ/v2r72A
         X7ePkz5aO6leuY8Cu0lU+R4WHtZo4H5trOmacNCJLscD+aUk3flmtA/R28fWrqnWaqS8
         QilI7JuBWCFXDpDeSSK0aCeqaa5ZJ53kYhx8vUfLOkOFH9gjsQSJaX2VM4cHdKtBkaDg
         9Pag==
X-Forwarded-Encrypted: i=1; AJvYcCWro73cycY6f9CyuYCIYWP31G/8E3OGhOoGM1IIgltu3fYDO/EfyaKcRxcgRfH0raGGRkGRhs0eXhhCnPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1crwwj6CT0i6VxH+0Xm/dNYxLfImUdwELB7P32N9d97cVbzjF
	/hz9EJNb1qXCHLAuy4EijUF9Gcf600f6iVdE24SXGHd9yrMg2Ufx10Xr
X-Gm-Gg: ASbGnctiEueJbqe0RzhIH90qAFlaJYZ0T0r9MXG0JAVfgVbGIqSkJr1i0uCIVoL6FIk
	jUYAmRH8OlidM25bUwFJKmwxVA0JS1pWYVICk318blho8v916JjtRsq4RlIHdKohFi7JEhPTAWg
	8An80h9R4MrVDge9M9Pk7PtxRMIxJ5Nbq+txVf1M+GxGMe8zgimpBYCTWXD06rSUPRWG4SxIn0C
	u20GsszOEARm0lrHMbeZa3/N+dJtfwNp+jT/INN2o2SUHMUnkePTQ0j3RpzdACFyL4sgLKrUoNP
	2n3P4vSRoC2KxiK0hO/3lutjjyn4OKASY3S6vAZmZP41Q2gGv2zUM0YD87P9FsL2bMJlTicaMy2
	raVLTNFQ5ZMxGLIrqwMeblS+xtq71dfaTr+XzxUJtcOXum3GSeFLFhfgl4i+80YP77qbhcRzfYw
	==
X-Google-Smtp-Source: AGHT+IFsj6aNYCy4VSY/pT65HzYuwBfF3Efce20HU3WXVuf6OpeZkuBOsC9gHRfJcS97JADvXgP2xg==
X-Received: by 2002:a05:6102:6cb:b0:5db:ebb4:fde3 with SMTP id ada2fe7eead31-5ddc46eef21mr1212345137.16.1762641811172;
        Sat, 08 Nov 2025 14:43:31 -0800 (PST)
Received: from geday ([2804:7f2:800b:4eac::dead:c001])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93725285d26sm1269736241.7.2025.11.08.14.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 14:43:29 -0800 (PST)
Date: Sat, 8 Nov 2025 19:43:17 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Ye Zhang <ye.zhang@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
Message-ID: <aQ_HhfK0pbOE1m1R@geday>
References: <4b5ffcccfef2a61838aa563521672a171acb27b2.1762321976.git.geraldogabriel@gmail.com>
 <ba120577-42da-424d-8102-9d085c1494c8@rock-chips.com>
 <aQsIXcQzeYop6a0B@geday>
 <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>
 <aQ1c7ZDycxiOIy8Y@geday>
 <d9e257bd-806c-48b4-bb22-f1342e9fc15a@rock-chips.com>
 <sbulnlwz3vxyk3yw2c2tcsdvyu57cdvyixkpeq2okh4vn6yyod@4o4kltfb5u6n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sbulnlwz3vxyk3yw2c2tcsdvyu57cdvyixkpeq2okh4vn6yyod@4o4kltfb5u6n>

On Sat, Nov 08, 2025 at 11:12:54PM +0100, Sebastian Reichel wrote:
> Hi,

Hi Sebastian,

> 
> On Fri, Nov 07, 2025 at 11:01:04AM +0800, Shawn Lin wrote:
> > + Ye Zhang
> > 
> > 在 2025/11/07 星期五 10:43, Geraldo Nascimento 写道:
> > > On Wed, Nov 05, 2025 at 04:56:36PM +0800, Shawn Lin wrote:
> > > > 在 2025/11/05 星期三 16:18, Geraldo Nascimento 写道:
> > > > > Hi Shawn, glad to hear from you.
> > > > > 
> > > > > Perhaps the following change is better? It resolves the issue
> > > > > without the added complication of open drain. After you questioned
> > > > > if open drain is actually part of the spec, I remembered that
> > > > > GPIO_OPEN_DRAIN is actually (GPIO_SINGLE_ENDED | GPIO_LINE_OPEN_DRAIN)
> > > > > so I decided to test with just GPIO_SINGLE_ENDED and it works.
> > > 
> > > Shawn,
> > > 
> > > I quote from the PCIe Mini Card Electromechanical Specification Rev 1.2
> > > 
> > > "3.4.1. Logic Signal Requirements
> > > 
> > > The 3.3V card logic levels for single-ended digital signals (WAKE#,
> > > CLKREQ#, PERST#, and W_DISABLE#) are given in Table 3-7. [...]"
> > > 
> > > So while you are correct that PERST# is most definitely not Open Drain,
> > > there's evidence on the spec that defines this signal as Single-Ended.
> > > 
> > 
> > This's true. But I couldn't find any user in dts using either
> > GPIO_SINGLE_ENDED or GPIO_OPEN_DRAIN for PCIe PERST#. I'm curious
> > how these two flags affect actual behavior of chips. Ye, could you
> > please help check it?
> 
> FWIW I assume single-ended in the spec means it's not differential
> like all the highspeed signals on the PCIe connection. This says
> nothing about open-drain, open-source or push-pull being used. The

yes, I agree. It was an oversight on my part to assume open-drain on
PERST# was part of the spec just because many cores implement it that
way. Kudos to Shawn for correcting me.

> kernel on the other hand has a very specific understanding of
> GPIO_SINGLE_ENDED:
> 
> 	if (flags & OF_GPIO_SINGLE_ENDED) {
> 		if (flags & OF_GPIO_OPEN_DRAIN)
> 			lflags |= GPIO_OPEN_DRAIN;
> 		else
> 			lflags |= GPIO_OPEN_SOURCE;
> 	}
> 
> I.e. it is the same as configuring open-source ;)

Yup, I had noticed that. This works because the reset value of PMU GRF
register PMUGRF_GPIO0B_P sets the relevant PERST# GPIO (GPIO0-12) on my
board to pull-down, which can work with Open Source/Emitter. If we set
the GPIO to Open Drain/Collector we must on the other hand set that pin
to pull-up. Either way it works.

I've been investigating why that GPIO isn't properly working as
Push-Pull for my board (Rock PI N10) but so far I'm clueless.

Thank you,
Geraldo Nascimento

> 
> Greetings,
> 
> -- Sebastian



