Return-Path: <linux-kernel+bounces-839461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35842BB1A89
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 22:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CD23AE46E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 20:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54B5269CE5;
	Wed,  1 Oct 2025 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jws/HdOs"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403162441A0
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759349062; cv=none; b=Q5g2qxY6+m8QOFXn8+hds1hnTfG9nvxgqIpfBzKomB/nOMVgNID86gZF4pNaq1IJV4xfMX0EaEmo/DuxE3eWU4ZyCb6YsmTs7xj5crWXm2ULn62zcbvhE69D7oe1xU2NvlzorUmtJP9DX08F7ssvxVcadQ2p81Fmp1s+ZxJmQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759349062; c=relaxed/simple;
	bh=0xNfbGwDn5Ujb3q5eFmFRpZ8gasQPLgAedHj4TU8p4s=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gjtuhs9zB4GjrVt237MYKIIGuKAnwyvX2UheI+oS5kl/4iYvmP80oJOcnGcvkyff87Akc8InvzcmheDpS9hWjV5XKhuFk746IriNIU0J/B7IvtnVWLajJbq4lRusH21vBdEquLQVi8542tjSGvlb5FY6XA7buOLW+hlmTPqp0+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jws/HdOs; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57e36125e8aso230028e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 13:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759349056; x=1759953856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cX8lwrl28t/i7tJRQde5rNLA3zKT+cbiNT15udmeOKY=;
        b=jws/HdOscQf9aL0ORolca48UzXl9CBE3BGSFvveDyjc6EjcTSJQSTPli6A5c4VWBlo
         yzanjMLJCHzjsekr6eWiY0nRxG3hkdcCR49yxNZ7WzzhUmXDvxLT09vcX4sVoydWpf13
         mYH0GG7iFBgmsHOCCKiXcGRt7nkxbD59WOSIobFPWukqGDMsW5ZZ/pfdcr8lGASMllZe
         KS2syr4OERA+wxpEctdUzi0e0t2ktY5v/EBPkMWlGDtbdSe4mNYpGEYUrPD4RXWZwh9/
         39xtIJjO9oF/w3e5ECUatOnWcSr9iRWEk6QvvE66Q4yJTu0dyxfmfL0HByvgk7dX8tBX
         vy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759349056; x=1759953856;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cX8lwrl28t/i7tJRQde5rNLA3zKT+cbiNT15udmeOKY=;
        b=mntIVln9ulJdBUR4Vvy0tpFfgI3/LzS3ouOiKCp2HsmGCVcGtnHLr2cnk9V+73Krrc
         D0ohMPsmem1//iF1iu3vxOudPLVPfOPYCWorv3K2RDnJD9Ppj21hlxskw8DPRyLd6HsC
         u0OS/nRiUn/3ggpNXR19DKEJ/HaZkbSvFdTOJ0/0QwIMGzp9uG69S8AY3b2b/UsAwPZ1
         PilmdsQ9UWUbZtrJwR/ou4hBj8pghadCefqh/BYvcOJBGFuEpcsyby4xMDyXAPQOf+6H
         Oo7CB9mOXkD2jfYeoFLxhE2dgxKBF5dOAEQ7Cp/kl/3Mq4nFyhu/9klRZorM06TD8zcp
         MnyQ==
X-Gm-Message-State: AOJu0YxWmn4HHYPszjvSSuMJfCznJjqOuCNBrDr0vjXucDjl2p8o0xrK
	TNUMjKA4elKveYEzg3Lyak4dAfsHlvQpRQBmvvLpoY4nZNHypu5Y1Ily
X-Gm-Gg: ASbGncsbRdokTLH0dXTPhWQIXdxtaAEnxYCYSO33DLIXJOCbgV2WjFVviCC0PP9lsvS
	EKQU9v5AWyvX9ppvrgUdRU/7h17XmxQBMpTKi1GeLZeORO4oL0VUWqFuRcLlEEuR1tDusQNTTWY
	RvdYagF/cmuXPpq8bJPz5zljuP+UBtyskY7AQnzu+PA7wFKqIlG6eLIcahvlt18yZucWGAvAaIY
	PGB7ylwQdacdFood0VvhBgUmibpdi90GFY/RZ0u5c/xB2YYbASJ/HxClcCApQbm+gv3M3DzTnmW
	W+iBbXfVmhoUIhzBDOGhXxd/KSY7RIqgUIv3VXeKXvVw2mOwn6V0UbywpM58lDq6H+ekMi/rhkM
	KSN+28EVi+ibyf1xD8XP+scSP729o5T0GuP8gbERbLfMl4FGFCQ==
X-Google-Smtp-Source: AGHT+IHPfYmwGCSHmb3Cy/+/cM9te31qXHChNhTNZP2Hq3+uYCwZHD7k9osyQZW4yMdu+4TO4w43Zw==
X-Received: by 2002:a05:6512:3c9d:b0:57b:8675:e361 with SMTP id 2adb3069b0e04-58af9f1f482mr1612957e87.14.1759349055893;
        Wed, 01 Oct 2025 13:04:15 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113f1b4sm159443e87.47.2025.10.01.13.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 13:04:15 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Ulf Hansson <ulf.hansson@linaro.org>,
  Shawn Guo <shawnguo@kernel.org>,  "Rob Herring (Arm)" <robh@kernel.org>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
References: <87v7l03pqe.fsf@osv.gnss.ru>
	<CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
Date: Wed, 01 Oct 2025 23:04:14 +0300
In-Reply-To: <CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
	(Fabio Estevam's message of "Tue, 30 Sep 2025 16:09:13 -0300")
Message-ID: <87a52afkxt.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Fabio,

Fabio Estevam <festevam@gmail.com> writes:

> Hi Sergey,
>
> On Tue, Sep 30, 2025 at 12:49 PM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Hello,
>>
>> I'm looking for help with the following issue.
>>
>> I'm trying to upgrade kernel on my custom iMX6sx board from very old
>> 4.9.146 to resent 6.17. The board has eMMC connected to usdhc4, and
>> u-boot happily starts kernel from eMMC. The kernel boot sequence,
>> however, hangs waiting for root file-system as it doesn't see eMMC.
>
> I tried booting 6.17 on an imx6sx-sdb board and it booted
> successfully:

Thank you so much for checking! I think I'll try to compare my build to
this one, as I still have no other idea how to debug my problem. Could
you please send me resulting DTB file as well so that I can check my
build system against yours?

That said,

> Starting kernel ...

[...]

> [    0.032394] /soc/bus@2000000/clock-controller@20c4000: Fixed
> dependency cycle(s) with /soc/bus@2000000/gpc@20dc000
> [    0.032536] /soc/bus@2000000/gpc@20dc000: Fixed dependency cycle(s)
> with /soc/bus@2000000/clock-controller@20c4000
> [    0.034758] /soc/bus@2000000/clock-controller@20c4000: Fixed
> dependency cycle(s) with /soc/bus@2000000/gpc@20dc000
> [    0.034894] /soc/bus@2000000/gpc@20dc000: Fixed dependency cycle(s)
> with /soc/bus@2000000/clock-controller@20c4000
> [    0.045375] /soc/bus@2000000/gpc@20dc000: Fixed dependency cycle(s)
> with /soc/bus@2000000/clock-controller@20c4000
> [    0.057574] /soc/bus@2200000/spba-bus@2240000/lcdif@2220000: Fixed
> dependency cycle(s) with /panel
> [    0.057688] /panel: Fixed dependency cycle(s) with
> /soc/bus@2200000/spba-bus@2240000/lcdif@2220000

You have these cycles as well. Is it expected? I fail to see why gpc and
clock-controller end-up being mutually dependent. Besides, they are not
mutually dependent in the hardware, or are they?

I also have a few more doubts about imx6sx.dtsi:

1. Documentation/usage-model.rst suggests "interrupt-parent = <&intc>;"
to be root node property, not of /soc as in imx6sx.dtsi. Is this
essential?

2. intc: in imx6sx.dtsi is interrupt-parent of itself? If it needs to
be, this asks for an explanation in a comment?

                intc: interrupt-controller@a01000 {                                                          
                        compatible = "arm,cortex-a9-gic";                                                    
                        #interrupt-cells = <3>;                                                              
                        interrupt-controller;                                                                
                        reg = <0x00a01000 0x1000>,                                                           
                              <0x00a00100 0x100>;                                                            
                        interrupt-parent = <&intc>;                                                          
                };                                                                                           

3. Some nodes have <&intc>, and some <&gpc> as interrupt-parent. Could
somebody please re-check if it makes sense? Besides, "gpc" is not true
interrupt controller, right?

Thanks,
-- Sergey Organov

