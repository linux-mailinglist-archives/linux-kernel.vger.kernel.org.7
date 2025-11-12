Return-Path: <linux-kernel+bounces-898275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4CDC54BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408CA3A69F7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6BB262FD1;
	Wed, 12 Nov 2025 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIR7J83W"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90BD207A20
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762987607; cv=none; b=soOov3OST8+xtJvqOigjuh4wBDBVLL/CvD7fYTMyzLAXKJT0+bKoiz07VkU2cpJZeAAmX2au3ivOtTa6j6x4qXOP9DrSXnQyX7JpeS4zhmTFKRwVNaWur0CVEGZYTyZL3IPv0gzlLuZkVbFc71nIcSa/4Rhr5vvTDhLK1o3QksE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762987607; c=relaxed/simple;
	bh=BhI42m5/V/YPwRzNwHA5N3q5IkiYtrcBIaW/cRAyGnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbSGTyiFjWH0rAS8KAGy+Jv2UzzZj3ecROR0ERQRJ4wLa4OIZZKYWPleEmgpx8SRuZAXLU3TbIFBLccBE5TiFZXSM7a9p5S3fSx4lWD5kVG6vzwFf/0Lz7Y9rMdpuCFBQerAj9hBnm3ksLfKaCTCJGTF09BMmFvvxYz1JntmTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIR7J83W; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6431b0a1948so290751a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762987604; x=1763592404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GUuBbxCl6I1CdWQKU2N/XRDL+CV1L2620AB2tNocDyk=;
        b=NIR7J83WMo/S9HC3JWrx+YXrBgO52E+8AkjUuX/FwYrYZyr4r6DkvKgqBVG+YQYSAL
         rjhcPbmYI26Ho+Iiw0tYNqdBGzifNBcBS/Va/DDdw9mR0ZV+JYdLU9ur/B2aBftQqlPq
         ZewiR+epQ1+UC6C4eFpR1g8c+U4BBKTEUR6NrcNuzE7u5CM5HhYkViqvVpUBCm8wkm6s
         hoO9jOBRMr4R9xWp/1XscAgA+fa5hSvnLw9/m3ujRLxVRETT3enkUzzZlZK88LY6R5XS
         c1EL4Qqka9OKZ36z8C3ezpz40zIDxo472Z/IL0XYTYDSF4BlAwRfCruZzdDOGiifpJmG
         OuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762987604; x=1763592404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUuBbxCl6I1CdWQKU2N/XRDL+CV1L2620AB2tNocDyk=;
        b=adCz5JFkaXIvyer0QsR6KSk/c2X1KvurZ6jx/wL3mLoo6bQXK3a+U028FUkjyRWLcS
         og/KqIhtLtKI4MK76dGrJIKDdjT5LLDgQamp3sU275hLFHnm9O32F77K5pJJUkMcDU2N
         RYTTYGt3H8I9OzkPzZ92+XQwOu3ubMXjtgeke3amgIpdTCA8dCF/5t2ctvWTP5VMd9NX
         K+L/gRqzSKaQy+fjwOVGk59lNskz1Bv8t0QlppId0MKb3w9W3cwmCL5e4wRqFWVP80bK
         Zfg5uW+S+tGn/rvqUn/MM/9wm3iLPY2W+IxAjzWjyxyvao1143Z7tb84pQoRGAYe6d9r
         8sNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUstFIOs+eK1LeEREgRi0o5Azq40NXF3v98+qVQ5P8By0mRqpwyBP+R3H6EehVJUXtKEGtgBOV2eGD81A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYd229xPDl9V12Yv5s8dmzSkaeyCATmH+snYRazqdDeOi93LE5
	FG2WCEpUyQ2dBPJHz4Nvu2b2wfU82nz2yMkL9+PN39tByrsmRD5Qtug=
X-Gm-Gg: ASbGnct/C/7tCLKqiQ6GRGGz4etCxry2bcvEUyqwBWJliyKwzlIoyNv3R2yiM0ZoD3C
	oeg/ZUelm1vVcQwYEDniU48jZi0RDCzsYPq5PlF20COxAMfpLEKrWTIuHrDvkn/7cChxFWzcCx/
	118aIUmEcRcs6W8U/qteOiZzvLWKf2uvJv1QbE+SymP4jwYZZ3C8movSfDykRoeoVGFrNseo5bV
	UVtrraGNDvND9sH3iTg37VnisrPaiKd0oM480aPBgFovIRAK/fPP2qfm9INtvPL2Nx0qdptXoib
	wo7yeOi2HHhI7nur0peMQFq5K+zS1JHAJdsFrMZZ1iXhUTQMwvlqrZDHiGXPrlAHyy8w85MD5HY
	2S03W3bL/rTqWvdo/q5L3TYbPy5UATal/ocmB0D/3xSjuMFIPG/zKjkjwPfO7ZimlftUGacWyuG
	UNrQal4vk8DSgqPy4QSIwDpjahGQ2K6mk2pCAqhRkR0N6498PaCIvC
X-Google-Smtp-Source: AGHT+IHcrF95A8IttbQd220KZ+XN8Onx1zyj/j88oCP/XalZVeCxgeiqMBCbWsP6NPGRO0Eqy0luzg==
X-Received: by 2002:a05:6402:50d4:b0:639:f7b5:9c2d with SMTP id 4fb4d7f45d1cf-6431a4dc7e5mr4148506a12.9.1762987603798;
        Wed, 12 Nov 2025 14:46:43 -0800 (PST)
Received: from lithos ([2a02:810d:4a94:b300:ec52:7cf5:e31:cdb7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3f96e2sm71050a12.16.2025.11.12.14.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:46:43 -0800 (PST)
Date: Wed, 12 Nov 2025 23:46:37 +0100
From: Florian Fuchs <fuchsfl@gmail.com>
To: Artur Rojek <contact@artur-rojek.eu>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: maple: fix empty port handling
Message-ID: <aRUOTfCJtqnNBjU3@lithos>
References: <20251112190444.3631533-1-fuchsfl@gmail.com>
 <4f70a38490b12d13858f45f3e7a531bf5dc2162d.camel@physik.fu-berlin.de>
 <999e3970e1580def5ddbf1921a9ef4a4@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <999e3970e1580def5ddbf1921a9ef4a4@artur-rojek.eu>

Hi Artur,
thank you so much for fixing the DC boot on linux again!
Adrian, thank you for looking at it!

On 12 Nov 22:46, Artur Rojek wrote:
> thanks for the patch! Can this be tested with just regular controllers?

Yes, indeed you can test it with the controller, when you compile with
joystick support, like:

	CONFIG_MAPLE=y
	CONFIG_INPUT=y
	CONFIG_INPUT_JOYDEV=y
	CONFIG_INPUT_EVDEV=y
	CONFIG_INPUT_JOYSTICK=y
	CONFIG_JOYSTICK_MAPLE=y

You should not put a VMU in though, as thats currently broken (I have a
patch ready).

Then you can directly read from the evdev and listen for the button
presses:
	bash-5.3# cat /dev/input/event2 | xxd

You need to press a button for 20-30 times, as it seems to buffer the
events and outputs it in batches.

Then, you should see the following outputs for the buttons:

Button A:
	00000000: 7800 0000 94c3 0d00 0100 3001 0000 0000  x.........0.....
Button B:
	000001e0: 7800 0000 94c3 0d00 0100 3101 0100 0000  x.........1....
Button X:
	000003b0: 7800 0000 94c3 0d00 0100 3301 0100 0000  x.........3.....
Button Y:
	00000900: 7800 0000 94c3 0d00 0100 3401 0100 0000  x.........4.....

The Joystick should be detected like this:
	/ # dmesg|grep maple
	maple: bus core now registered
	maple (null): detected Dreamcast Controller: function 0x1: at (2, 0)
	maple (null): no driver found
	input: Dreamcast Controller as /devices/maple/2:00.1/input/input2

Another indicator is the dmesg log for empty ports:
	maple (null): no devices to port 3

These messages were previously not there, as the empty ports were never
detected.

btw, I have also a cdi file, that boots for me, although I heard there
were issues on the NTSC-U devices, if helpful:
https://github.com/foxdrodd/dreamcast-linux/releases/download/6.17.7/linux6177-joystick.cdi

Thank you for your efforts,
Florian

