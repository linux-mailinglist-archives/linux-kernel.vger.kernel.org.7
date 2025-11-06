Return-Path: <linux-kernel+bounces-888095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D27C39D46
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A3334F8C0D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347132DAFD7;
	Thu,  6 Nov 2025 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT33OTu+"
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A1286D55
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421595; cv=none; b=X3v4WG53YzagF5Me0/uvHQ0bSGoCDnROj/DljrrTGcfhAI0uENY2McwTM5kGv3VD9mggjuV22Wk8q4GQA3U95Z3ijmKTk4Zs7Nszh3MvvHK+6UlFrwQMWB8qaKzU4SEIF7DHIMu0a3L8Ec+9fMg3s2DyQfheUllKVs8Ps1/hEe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421595; c=relaxed/simple;
	bh=64q5jybt4KaXmXe1xH+19KsbeJcZF0429vrAv+KpQ4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhnlMf9vx4wXjM6R6D9xXfKC6dFU3//RJAPhIg2jR+A8CUncPxGkRhx0ulbAu1860RpRypXZkV7KT4VM/OhK1xPmC0t17xIxXOWBYV66rSV6LNlHQr+lui5b09Ti7FMWTssze7N5XcCn3tDN1l3qQN/r6pnxnGo/2OJYgon3wc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XT33OTu+; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63f97ab5cfcso752456d50.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 01:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762421593; x=1763026393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64q5jybt4KaXmXe1xH+19KsbeJcZF0429vrAv+KpQ4w=;
        b=XT33OTu+onFlGRz9FS5f6lJ5LMZ18M2EHe0iAKcg8UiOlnHEJ6JmdzbNo1dw4RmwL9
         sqohXK503ER+ISgeRyjLrL974tqCGpnWRyFCFtZkcBfe3hBt89yatfpSy3fCNJQJiYK+
         IwAbrBTs4koevD0xNGakbG6EZk87WZBZSG07JB5GpqPRfpJc30XM3v09J+tTjcn0Y+JA
         vTrjV91ol98qwKw/myLQw9gJ2MW0/UbbVzsixh1yyDs4N0ZnFAIihOpvjeEmbV/8zFiN
         G4JZEh9TDtywyv93SkhTrvq4jN9ssu0bKvsu8FIkbyD9XR0hZP+fn+pxFiLpmP6RfAxF
         Cfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762421593; x=1763026393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64q5jybt4KaXmXe1xH+19KsbeJcZF0429vrAv+KpQ4w=;
        b=LQOhDy22YlxdahSV/eUEaNIlISmtgTSAEmm8NChf84xHFCGQtnonYPnIR5qJy6HF7E
         s+/IBd3zxbjceddGXnluf/3SEYemSlfPeh1oZx03J5bzXwWhQaAnMKHgWkj32HSJbvEh
         zPmPNh4CoyewsVzYCCtEAXttPDsXZEWg3tPohR5bzwqBYrUaelhjTz7VD2fxVdLNZvOi
         +xt6JvYm+W6y2tD020p9tZWxF/bRztcKA6wQeEhN1v6zILB2tN920v6tKN67Z7ogIDm+
         5gR1ZyGX/rEndeyi2HKQFaW35zxtkenqdfq1J/z9ePG+tX+W26xiJ9XhFkpwXCcD1HQ9
         bz4A==
X-Forwarded-Encrypted: i=1; AJvYcCVR2yq4om+m08r21pZe6KvV3LxNGn52hEOI9YDm6LwDL00IIVj+vd3+j2mwa4CwkLsR+dKWT0Bg/h2nQck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Cpl7Tpe/0dmnT5aJENZHgwfLCpU6KhexWTAj4nUT5gm2gzC5
	KqZ66SEsuWJjbYpo9J8TS9u75ujFPCx+a7kESJMrVn1lyz+XfCaDuQLeRdrbP2A/UBP9+qWgZFz
	9EsCprRTMlgDlUQdXR44IIyUO5fuN4AE=
X-Gm-Gg: ASbGncvMjRTPK0HdcxmrhCPw+k/dJE2OZxCZRBabR7V00NTpIXQCovdp5TTcZi20cJT
	g2y434U1+2hrpPBtn36fW09IdfcuZrIzjy9iQXKsP2Qbp0LbUIIgP56flD+y8ngwNZbnD2mb0Xb
	JBmel9WQbEtNl6kVL+uQpOfr2rbdJrCrJMzRN48KhqeCXsq7JWus37LLylTgptgBKywSrcNEDPW
	yJRj0NpfgEcoTp6xLryicx34sytkPxUtmYeWz9TWBOOm5AJVUnzSGC0il00ckxEbYgsiUCs
X-Google-Smtp-Source: AGHT+IGjU/pSnzoRMIIWmPeTYTTkmJVZ18mO7dt3ps4vnqeCihQbTzl65FZVOe1Vtn3ir+mMCEBH8JGu/Q58C+AERwA=
X-Received: by 2002:a05:690e:2542:b0:63f:b9b3:9cb with SMTP id
 956f58d0204a3-63fd35745b5mr4818399d50.39.1762421592752; Thu, 06 Nov 2025
 01:33:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926014552.1625950-1-jefflin994697@gmail.com> <f35193de-a106-42ec-b318-1501793fcfb9@roeck-us.net>
In-Reply-To: <f35193de-a106-42ec-b318-1501793fcfb9@roeck-us.net>
From: Jeff Lin <jefflin994697@gmail.com>
Date: Thu, 6 Nov 2025 17:33:01 +0800
X-Gm-Features: AWmQ_bkdydm5NQpF_MozFF5PAHQ1T8g5CqTKGa1LNT2Z7L7uaN-Ub_DMGQb54cE
Message-ID: <CAMdV+4f93oZ3jhxo+oZDCiK4tHO=gYqfiLAMoxuzMn9Wn24B3A@mail.gmail.com>
Subject: Re: [PATCH] drivers/hwmon/pmbus: Add support for raa229141 in isl68137
To: Guenter Roeck <linux@roeck-us.net>
Cc: jdelvare@suse.com, cedricjustine.encarnacion@analog.com, 
	ninad@linux.ibm.com, andriy.shevchenko@linux.intel.com, 
	johnerasmusmari.geronimo@analog.com, Mariel.Tinaco@analog.com, 
	jbrunet@baylibre.com, kimseer.paller@analog.com, leo.yang.sy0@gmail.com, 
	nuno.sa@analog.com, chiang.brian@inventec.com, gregkh@linuxfoundation.org, 
	grantpeltier93@gmail.com, peterz@infradead.org, william@wkennington.com, 
	krzysztof.kozlowski@linaro.org, tzungbi@kernel.org, thorsten.blum@linux.dev, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the late reply.
On Fri, Sep 26, 2025 at 4:27=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 9/25/25 18:45, Jeff Lin wrote:
> > In chip RAA229141 there exist ISYS pin which can report the current dat=
a
> > for the device connected to this chip through this pin by routed by Dir=
ect
> > Memory Access(DMA) command. To read the data in ISYS pin, we have to se=
t
> > the DMA address to 0xC5 and then read the DMA data from 0xC7. And then =
use
> > the Direct read format with 10mA per LSB to transfer the data in 0xC7.
> > And for ISYS input pin, the DMA address is 0xE0D3 and for ISYS output p=
in,
> > the DMA address is 0xEE42.
> >
> > Signed-off-by: Jeff Lin <jefflin994697@gmail.com>
>
> As submitted this is a no-go, for several reasons.
>
> The description should describe what is done and why (i.e., here, describ=
e
> the added chip), not implementation details. Those are useful as comments
> in the code, not as patch description.
>
> Introducing a new sensor class is unacceptable. This is a current (I thin=
k),
> treat it as such.
>
> Changes in the core together with other changes are unacceptable.
>
> A new virtual command (or commands) would have to be discussed and be gen=
eric.
>
> A new Kconfig symbol when adding support for a new chip to an existing dr=
iver
> is unacceptable. Besides, the new Kconfig symbol would have no effect if
> the driver supporting the chip is not enabled, so this is not only unacce=
ptable
> but wrong.
>
> Regarding the code itself: Stick with existing coding style. Do not use C=
++ comments,
> declare variables at the beginning of code blocks.
Thank you for your advice. I will keep it in mind.
> I would suggest to add support for RAA229141 in one patch, then we can di=
scuss
> what ISYS_{IN,OUT} actually measures, how it differs from IIN/IOUT, if it=
 indeed
> requires new virtual commands and how those command might look like, or i=
f it
> can be handled by mapping a existing commands.
>
> The datasheet for RAA229141 is not public, so be prepared to provide a de=
tailed
> description.
For RAA229141, the controller can provide the fast input power monitor
SVID device
specified by the VR14 PSYS requirements. When using the VR14 PSYS
capability, connect
the ISYS signal to pin 44 or 45 and the VSYS signal to pin 45 or 46
(depending on
configuration).

Base on the standard version of the specification for this chip from
Renesas, we use
the config of taking pin44 as ISYS for input current sensing and pin45
as VSYS for
input voltage sensing.
For pin 44, ISYS is multifunction pin which sense the system input current.
For pin 45, VSYS is multifunction pin which sense either the voltage
near PSU or the
system input current.

However, in my machine the pin45 is customized as output current
sensing for near PSU
device.

To read these multifuction pin data, it need to use Dicrect Memory Access(D=
MA)
command codes.
DMA Address(Command code 0xc7): Used to set the register address to
use with other
DMA commands.
DMA Data(Command code 0xc5): Used to read from or write to the
register selected by
the DMA Address command.

And to read pin45, it needs to be routed by DMA and should be the 0xEE42, i=
t's
direct read with 10mA/LSB; pin44 is located at 0xE0D3 and it's direct read =
with
10mA/LSB.

That is, write 0xEE42 to 0xc7 and then read the data from 0xc5 with
direct read with
10mA/LSB for pin45(VSYS) and it is the near PSU device's output current.

Since the address 0xc5 is different from IIN(0x89), IOUT(0x8C), I
think it might need
new command to do it.

Thank you for your review. I=E2=80=99ve submitted a v2 of the patch incorpo=
rating your
suggestions. I appreciate your time and feedback.
> Guenter
>
Thank you
Jeff

