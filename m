Return-Path: <linux-kernel+bounces-794373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB48B3E0C0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F174517F5FB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBE130C629;
	Mon,  1 Sep 2025 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="WlxZXtP5"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5AA78F5D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724380; cv=none; b=i3yGKNOcKEsZLNaeu5HI/9G99t22PDXWE86B9rEN6Kv5yN59Xy8TXNqGgy5umEufoGWjNS/me3Pi9PZhe9qYPQjErOCU3bZFotmpegRmKwVllUFQSfoYVBtLREnGhe13OpKoX8syHN7qTfq1lE8lH7YMyywxRL00Aten2OkaHVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724380; c=relaxed/simple;
	bh=CL4PHcoykLMbZZNjSNvXFDOWdnWPySZb6ACVQlOfyvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0fNw7iYOEUyaq3Mg5k5vxkrne+Kg0vgB3w4JhvwzfpStbOVMTc+yLJev6XelquAvDKTi8DBrK0hSepfWTVM9/YSMmiZXwnvGktcuwmX3Y2rdrBNwRg9FgDvyzou9Wm3hrnwsXbu/7ytLJALp5671hc0fHAjSlFBHwHH/jJkrOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=WlxZXtP5; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d5fe46572so39523677b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 03:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1756724377; x=1757329177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EJinoXYbXnzNjHDgh/TK+DIXPD7XvP744ic5UKGRCZE=;
        b=WlxZXtP5uY2qZ806R+akPoWNFWQ6WJJoI4dqgdN1jmjgdmQXoyr73+RgZC7DsJxtvb
         o/MvTjZV3ryD99JkNc7Sw1pgUNdaS1HkMU5PqQdDVJ4G0WX+yKCLwg7j1NTmAYEOBm/k
         VnYgLUCOBUoNpj5//ysYOSifPWBv5r/npywM/sDPTDFsjucUgPtlPy04N9UkPSPE2Z3S
         Eh/trc5japlI3S2f7xyriAPQ+iCsO4sAJYdZhr8N3yZffIF1BzUv6bi0t2fZ1808tuhl
         IFJ9XvhSqWOPVFeJqLsXdBLMSHnZjGNYmayT9C7YqbG+GFjEtIVz0PS3jRUp0BYbLczV
         AXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756724377; x=1757329177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJinoXYbXnzNjHDgh/TK+DIXPD7XvP744ic5UKGRCZE=;
        b=RNbnS+mmVYejU8rv+y8xplwJH2sMOF8H2VHuxYD4blAZre7C3Cs5cpgkSU4nvyeWjU
         TAj8ihJ8iD00dVm9Lltq1AGHGsaks81mjX4JAph8BFl1zZ3ARVtrp2mlwhK0zY0qHo+L
         sSl08rVv1TdOLjBfPQgieegrT89eUuFdkYtr6jhA95fTXk4282RnOt/h5S0fxfPjDTF8
         yCkJ8xG3qmR9YkMQ/TKTV9U7VQE9T5Y9qg5TEVs+KoGth7zgcffAr9He0Xzhn9yg+2Qn
         C02fAFsjnRnbnxoRPpXd4QQjauswZAmvySXJ32Nwn7tVGgXSFEiP9cpa+WCt1BJhLQm0
         egtg==
X-Forwarded-Encrypted: i=1; AJvYcCXQKhdroZtckYq8zqg+dYQzpa1Afwwvo7o+CmGEa4+mkZYiHaKzSecEoWnxSpzZojFnmlIMLqCge7+W6tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVOITeusvno4I01vRCBVBSMbEnSaZTNS32gPlsDtXErKZihPfG
	QUlH2P+3GuuNSl8F2tVKT8Qc/yHLuPs56DtADmW/H6RrP00ZcmBsgvR7lyZFZCpR521R+isawMH
	iEipx/To2znrew7yYttZ8+rrjj8Zrn9Pf8488vrhBKw==
X-Gm-Gg: ASbGncssiCi0Nb6wffpVdJExr/+qQqxiGqMkoyHXoaUi84Z7+4tinqJc15J34E/gZFu
	EEDYMJDk8VMS3XhynD1bqXY443eCu8Y1mnEww41hINv0G+5FtcbfJgFchI8/0gshB4iZ7NsT/wL
	ea02y2qEw1Q6ipBTPxOtKsfVngFfyMViBCEduDNUDk13Y9u7pifpbn4Vbuv3BxHspdQz7VJt6rc
	Sg6UEvhlL2fh+MmA609vBUwSrCeEZE/LThm0QY8qkP+FJ9zBA==
X-Google-Smtp-Source: AGHT+IG3E5X8rSS4MCzpFL4c7/+B+nTiuZn7QkYnuaa8FdJ3F1U3keZEV+jrL6NCLwW8aPKh0SfR0DXjN6ikye0mpJc=
X-Received: by 2002:a05:690c:338f:b0:71c:3e81:cca2 with SMTP id
 00721157ae682-72276337a67mr91487627b3.1.1756724376904; Mon, 01 Sep 2025
 03:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com>
 <20250827-vchiq-destage-v1-4-5052a0d81c42@ideasonboard.com> <731ead88-8dc9-4032-86f5-7a2dd5044b22@gmx.net>
In-Reply-To: <731ead88-8dc9-4032-86f5-7a2dd5044b22@gmx.net>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 1 Sep 2025 11:59:22 +0100
X-Gm-Features: Ac12FXx_JRISJwP0UMdGitDY4fzYmnwpQn6tyyu_Q6GUhjhAClChc8Uz64aD8Lo
Message-ID: <CAPY8ntDz9duSU_TcqE5CPYYCmSTnvm=RgwG56qQ0xe07uzWFLA@mail.gmail.com>
Subject: Re: [PATCH 4/5] media: staging: Drop bcm2835-camera driver
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Jai Luthra <jai.luthra@ideasonboard.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"

Hi Stefan

On Wed, 27 Aug 2025 at 20:18, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Hi Jai,
>
> Am 27.08.25 um 08:24 schrieb Jai Luthra:
> > The bcm2835-camera driver is replaced by the V4L2 bcm2835-unicam driver
> > that is already upstream. So drop it from staging.
> AFAIK the old Raspberry Pi Camera V1 isn't supported by V4L2
> bcm2835-unicam.

The Pi v1 camera is Omnivision's OV5647.
There is a driver in drivers/media/i2c/ov5647.c, and that is supported
on the Pi via libcamera.

It does look like we have a number of downstream patches to that
driver that I ought to upstream - always something to do.

  Dave

> Personally i'm fine with this, but this must be clear in
> the commit message.Did you already talked to distributions like Redhat &
> OpenSuSE about this step?
> > This also simplifies destaging of VCHIQ MMAL, by reducing the users of
> > the MMAL API (this driver is one of them).
> AFAIU this drops the only one user of VCHIQ MMAL. So please explain, why
> we still need this API and how this should be tested?
>
> Best regards

