Return-Path: <linux-kernel+bounces-878538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B8BC20F28
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B141894690
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F40F363B98;
	Thu, 30 Oct 2025 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ykS5ibOb"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA46363BAA
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838090; cv=none; b=hMQvP7euiFDyuFKOBjEPG8t1SsredHfOjZOwVxzVs2ikyetKemuuiQ1Wek5EZO/r1j0zg2W573hcJb9bSHbWJWb3C68OVA7S9VmRTJlC7uLnvgAkN5MUdvAYof+Ere1Uy0VEAhbiowkfziQUw2sU/ip0dHcHsFwOKpDk+r0hqO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838090; c=relaxed/simple;
	bh=XB11xGL63R2dsjBDo1xzLACnAhYwocbX+tplDz8muzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVOsE01LCZJyKJhDK6+JzNUweoAdSCwJpOE83/qTm5YpOwx7ysSl5KmJYFde5At2POGpdH34skfGvLxeZCHts6h5eZetlfQWtiHh3VUQjG78CHyDS8TQaFx4RZdqWRwlQ1DGhamAX+DxRCLG4RZe01neI1axHC1LDi6ns5Ya/Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ykS5ibOb; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7849c889ac8so43449837b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761838086; x=1762442886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ycPp8pZgEFoeQMpyGYzVQ4IFRsCoJ2aRuKd6SDWpxA=;
        b=ykS5ibObCHGvrPxm47c2x4Tgtx5sQC4UoKIvNO7OMDUehzP4BnEMVQkpkKQMHyJfMu
         OJguViaGuEn09tgLRmkfhc+UopKSJnmrEQQI9hmX53/HR/IOrVjZAQhrC9L3EQSA86r8
         3hDhQqcV6BACvSEomev/mTYOydrmgFfwbIJ/rp9IUw9fqWUf+pxzl53H+UbcbZRhQhGh
         6dqkMnOW181DaQSjDzc29KuBoUrAYGRBC58kIZ/CvFaTokkA6qdm9qVJHGHRKapoAWif
         0hWj/hnjCn21GUuBPdm5CF6vPWO7QzbCoIxj+gUGzFyQAqTsKRBP8sqRUwvUHwehcVsP
         nCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761838086; x=1762442886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ycPp8pZgEFoeQMpyGYzVQ4IFRsCoJ2aRuKd6SDWpxA=;
        b=Z1P8ztQ6gJm8Hsg7kyBZ6/KG/GhXm5ZuMXUJpHcNf9ZMVP8l233veiMZJW7Hi+4AMB
         eKzveSw6Bh+f9u2nGW3MsB7/QRtfFgCmHRk9VjfcNY99CCzdTTCorCVN+v8ENxr5EHU5
         L3i9NflKWrCdYV2gJVZ17b2zmudQXy9xSPDWSKRZy5Ip94Yh6Xdx1ahFcQSvl29s8ryl
         RJxTJZofEv4JBTcncz8PjNJsZEO4fGhiih83fhX7aHW9Y1Nju57Kxc1s4I0KAnW1xltG
         yJnlYuU+YQqa2nODDoELQjT/HjkUJ72qFTw4XaxnOoZcydPmg9X2ueNNQ+/rESCKiKiQ
         3KoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6+2MoAiGg0frc2zpmlQdQuK8TMVe2u87ognfLeuNrm0ubw777cZ7lVFmS0WtnBfBoqanBSkJFhL+5uSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvnDhSfCzmu+4kQxvLNO8L/KwTmmSaZoaYl7ycaz4t+QNJJ4Xk
	dmsCMMG1lcVtPiCoJhrJb7aRIsaicB6HdiHwBHeiidSt2HkWhzLNe+C4/x52TZnwdAectRrZcl9
	PZnpeMGmhbEQJBS1oTsvjCgWedUdOZdYtxypecCcytQ==
X-Gm-Gg: ASbGnctojmEeRoQeTpq92mZeiHyd2EgwZ+yvHY906qPGwi78mT1wzDJJWWFMF1d2DR7
	8/YcQt0wMzFjTv/RFYZnpEdT1JGcQpdTTHnDeZqVlKscQn5F60XdI8/pahHVLPjWlFP/3ioU5g+
	0XFyVY3Dz2UBI8fAiOWkPOmsduUR2y0BRO3QWGjvKbxd4flVQl0PyUjDdy06Poz3ipatXK9JkCy
	9p5PjqCgihUr411YTlGhqlohl9R/hOWvhb2HJh9bHvyu+vJshEbHP/W8huVtA==
X-Google-Smtp-Source: AGHT+IE7cHjINSkLMQTgzs6w+5tGJD0Nm4hSDWwJhVubSFRkYHz6tUwfvq/JjfaEUpptZLodo7e/iRO8bn4zeLZcNk8=
X-Received: by 2002:a05:690c:c34a:b0:730:8858:827 with SMTP id
 00721157ae682-78638e15c6cmr28491297b3.19.1761838086224; Thu, 30 Oct 2025
 08:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917063233.1270-1-svarbanov@suse.de> <CAPDyKFpus05RAkYAoG7zjyvgAJiuXwRt3=z-JB5Kb7mo0AK4vw@mail.gmail.com>
 <c379087c-1702-44b7-a890-beb5b77d794b@broadcom.com>
In-Reply-To: <c379087c-1702-44b7-a890-beb5b77d794b@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 Oct 2025 16:27:30 +0100
X-Gm-Features: AWmQ_bnaXJddKoSJGHltKVC2FCgxq7fO5V7a69ZXCIkr6_3dvFmm3LKqD_YY314
Message-ID: <CAPDyKFowo7+-C4YLLw4XoWz4fU3ykEP1UVEEneCJXBuDjGTStw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add watchdog support for bcm2712
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-pm@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Lee Jones <lee@kernel.org>, 
	Willow Cunningham <willow.e.cunningham@gmail.com>, Stefan Wahren <wahrenst@gmx.net>, 
	Saenz Julienne <nsaenz@kernel.org>, Andrea della Porta <andrea.porta@suse.com>, 
	Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Oct 2025 at 21:23, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
>
>
> On 10/13/2025 4:08 AM, Ulf Hansson wrote:
> > On Wed, 17 Sept 2025 at 08:33, Stanimir Varbanov <svarbanov@suse.de> wrote:
> >>
> >> Hello,
> >>
> >> The following patch-set aims to:
> >>
> >>   * allow probe of bcm2835-wdt watchdog driver for bcm2712.
> >>   * prepare bcm2835-power driver for enabling of v3d for bcm2712.
> >>
> >>   - patch 1/4 is preparing bcm2835-power driver to be able to
> >> control GRAFX_V3D pm-domain. This is a prerequisite for the follow-up
> >> patch-set which will add a v3d DT node for bcm2712 (RPi5).
> >>
> >>   - patches 2/4 and 3/4 are adding bcm2712-pm compatible in MFD driver
> >> and update the dt-bindings accordingly.
> >>
> >>   - patch 4/4 is adding a watchdog DT node for bcm2712.
> >>
> >> Comments are welcome!
> >
> > This looks good to me!
>
> How do you want to proceed with merging those patches? I would assume
> you would take patches 1-3 and I would take patch 4.

Yep, that works for me. Awaiting a new version of the series to get
the comments on DT patch addressed.

Kind regards
Uffe

