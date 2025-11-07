Return-Path: <linux-kernel+bounces-890590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 506FFC406B4
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C02094EE6BA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D0D2E1C7A;
	Fri,  7 Nov 2025 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="yABQUk8U"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641F02C11CD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526964; cv=none; b=PzWuHfLkIc757aLxWjumM0nSnEUzXEplKfj6WV5h/mf4CtxZnntPxyVnqv+iqRH89lHa52qX60nhyj3WykH3f5geEysFSEmDUSKnTxpfFBxa7mMvaMZoZh13Yiwnlk46P4SU430uOSxHe3/9cUC5KgIIsAev39MuSx9mc5Lp0Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526964; c=relaxed/simple;
	bh=RUD1Jd43ZASIpcsxuX1N2ssGIFWOzPtdxIFtmeCDnJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMdIQX/3nPA4IiF1KMZk+KKUr0IU1pjuUIZirtmfcdiiMrM83+3jPbJ6kfgnTtqrD+QUY+He3T7z2hLnxdOuNpWGoffVdssZgpUuGR99MwJ2ZfXxNz/g9TXU/RFeE7svDKs0PC5w20uUz9cLLgt3Qazz3qu8tluDRLDkfZoMlDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=yABQUk8U; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-426fc536b5dso529002f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1762526961; x=1763131761; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUD1Jd43ZASIpcsxuX1N2ssGIFWOzPtdxIFtmeCDnJw=;
        b=yABQUk8Uc1TtA2DtluqrZ5DqW1jAnyQmQp6Q4nOI6qjXTbZOiifQc6yL0Oq6cnE7dD
         rseThXB9Y76pqLcOgm2hyqUOtu1hbX5/7ju1g+Q5K67iG6XmaMW476rQ4fgDYC7rPntT
         mKs10oTo/H9McJb++b9bL0BHpLjaun7V/+/sMVW364dlCfN2o7w3W8S3rBBThT2M49Fh
         uxxYMR3ce1WCbBPNpdGdjOXtgIWW1fsqXugwD3rNP9uhzxKLPj3I8NI+2XnWw7Pn2jF3
         F01kwc9IqLpXdqDJe+izWd9aKsrHV1B6uapjCLyi3EVwit/59n0vlBivEXljB8SdkO6e
         mRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762526961; x=1763131761;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUD1Jd43ZASIpcsxuX1N2ssGIFWOzPtdxIFtmeCDnJw=;
        b=j32wiucJ8m+1NsqiBZKTTRHw1p45ulfsGcaIrbpeXgRsjltIKMgiMlxrKhdTI3Y5Ra
         RIpgF12rc78ZL+rDDlydyPpBGZnVp2cp3OeP7J43bbAaqpNMGVheGrxxT27dDBfAz/7H
         asBIxSs/z/0E4aWoqZvf205KLP9HHb79hbBT/eiRs9gDrbjoOwYEQuseLSqRDxeCAafP
         1ZkdvPPEM8BmeotgBScxS8b1CaPPF5Vj7zirX8JKewkeCSuaK0SLDu3GOtuCU77xtW2F
         7gYzYpgY0p6K3qhHTbsSm1er33I9thj0mGb9mgFxah8y7iHrlNDe16zgrzHaPLfDO5/J
         4MQA==
X-Forwarded-Encrypted: i=1; AJvYcCU0axF+UCZhsf5gvzFEkb++9434Yy+fdbcC8BglqBQWUu9ABsyyusOq91rKKLlnp+i5y1YGVYKJoc9HM4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA5uXnX2NGa/NvRd8Q5Qq/ejDRbf1ABGtsNEgg6aOYQdPZdSjW
	wLStq7IqLedg2mrbLf4O18K0GI1z+nFJcEDhtOx4L+pthTN6DezZ2yvb/4Y4xsVy61k=
X-Gm-Gg: ASbGncv5uftyamyz6X4Eymz1k7Z9NCVZXbUnTRysWjN08/iurTTsoIXNU1iSrq2Lkbh
	uEhFEFVO63UHikDJ/Gc2kb07YaAGOaRHfKhDTxiCS5IlIBlyKc9hdn681jRZJHFnf0jAfy8vMi4
	Y/wG9f9OEtbtlU+MNhxNGa+GTu0bNVErUiUbDH9eBKZpFrV9C4pcxb1W5HYD6y7lj9Sb2zhoS0t
	LFfv7LgJPR3UYZCIfMK2Tn7mxJrFgpFAiN9wKzE92OPYqi2kmiPl0sAP4CCmNnqHVnhybp9cGSN
	DweACIWX3UoAjqylZW6V7Nt7oGWev2QnDdLBrwRwf64aEyxXdgXDgMftbxoSevHKuNUNoNpLARn
	73bAM+i3ICJWRUgP8ir/3W9BYrXCJW4FLDNmR/W8lWsn/2dKqy9Q6yl/VGNbubmGtGqT7GWpej+
	Kh5VyYGMkrA5pUiKLzYt1kD2cL8qRsoZKQCpoGDkzBnvXUfgvz7ELkxBIDUqY=
X-Google-Smtp-Source: AGHT+IGVSynVCb+VhjrR6Z2aEb6MRhX4htxmgyYFU/R10GQ6nAy3fDU1kADzW8iu4OBmJz15vaN2pw==
X-Received: by 2002:a05:6000:200d:b0:427:454:43b4 with SMTP id ffacd0b85a97d-42ae5ae8448mr2952999f8f.48.1762526960292;
        Fri, 07 Nov 2025 06:49:20 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm5596030f8f.9.2025.11.07.06.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:49:19 -0800 (PST)
Date: Fri, 7 Nov 2025 14:51:15 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, Lee Jones <lee@kernel.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Pengutronix <kernel@pengutronix.de>, linux-pwm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: apply the initial backlight state
 with sane defaults
Message-ID: <aQ4HY5Hncv1fvxVk@aspen.lan>
References: <20250731-blpwm-v1-1-0171fd31bff9@pengutronix.de>
 <aQNRK5ksNDMMve0x@aspen.lan>
 <t6wtfnmnclnzwdpbmdcalvyf3mulmpexnryolxkygqkpx7vdwz@dqwbwvlzawrr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <t6wtfnmnclnzwdpbmdcalvyf3mulmpexnryolxkygqkpx7vdwz@dqwbwvlzawrr>

On Fri, Nov 07, 2025 at 09:00:33AM +0100, Uwe Kleine-König wrote:
> On Thu, Oct 30, 2025 at 11:51:07AM +0000, Daniel Thompson wrote:
> > On Thu, Jul 31, 2025 at 10:47:18AM +0200, Michael Grzeschik wrote:
> > > Currently when calling pwm_apply_might_sleep in the probe routine
> > > the pwm will be configured with an not fully defined state.
> > >
> > > The duty_cycle is not yet set in that moment. There is a final
> > > backlight_update_status call that will have a properly setup state.
> > > However this change in the backlight can create a short flicker if the
> > > backlight was already preinitialised.
> > >
> > > We fix the flicker by moving the pwm_apply after the default duty_cycle
> > > can be calculated.
> > >
> > > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> >
> > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
>
> I guess this tag resulted in Lee picking up the change. I wonder if you
> share my concern and who's responsibility it is now to address it.

You mean the ordering the backlight registration versus setting the
properties in the probe method?

I definitely share the concern that there's a short window where
something could request a brightness via sysfs and then have it
overwritten by the remains of the probe method. Likewise I can't see
why there would be any problem moving the call to
pwm_backlight_initial_power_state() before the backlight is registered.
Thus I'd be happy to see the backlight registered later in the probe
method.

On the other hand I don't see any problem calling
backlight_update_status() from the probe method. This is a relatively
common approach in backlight drivers to impose the initial brightness
on the hardware without needing extra code paths.
backlight_update_status() is guarded with a mutex and should be
idempotent for most drivers. Therefore it is OK even if something gets
in via sysfs and provokes an update before the probe method has started
it's own update.

In terms of who should follow up I've got no strong opinions on that.
It's worth noting that I don't own any hardware that uses a PWM
backlight so I'm not in a position to test it!


Daniel.

