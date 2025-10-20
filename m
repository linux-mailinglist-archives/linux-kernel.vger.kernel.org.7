Return-Path: <linux-kernel+bounces-861841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD89BF3C80
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A8218A6EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5432EE262;
	Mon, 20 Oct 2025 21:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF7KdDVf"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E791DE4F1
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760996740; cv=none; b=R6qeXZDD84plndSHeSunDylUz3xGfWelijtwng6gEI8NLIF7kKJRu8unGgVCRc5QwWWF6NxQUczjIKtcHthqcbXCwHgmcFTJd6DAJhHXwzld+5KfoG40O7i0TyU3sOXKWgkGmTJ44qe1pnA0UUYFTQeULCUBRRB8qLHUzm1NA3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760996740; c=relaxed/simple;
	bh=G54UBFISBWTDHX0TIE9etDJVaHduShicBItI1j7PkVw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=s7DJCB1wQUEr2ls2GFpmuZEfrs5nI4r3tmwlNnV23n7z1czD79q35AqQRr+l0ZCE4s1qozI5tBd/6QggaWzWG0wof2LGngNcZfkYexdkpB36sLUZg221/5zNQJvvne0a3kbSOP0aBXOguCsP2apzW8YsynegR03bvpGEkJJJas4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YF7KdDVf; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6a0a7f3a47so4502548a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760996738; x=1761601538; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=z2/4gND7Mx7r/qp2wrFqSXY+KceudyeUTazz1//alO0=;
        b=YF7KdDVfxJxkM25NtcSGi9Qub3VgRa6jz3uvQVLNJiU1/Y96mqmzNurujNl85NKz95
         GxjWnQ9Es6pHO67+r11HxHKI8+NkmN5AoZR8QbDWixKajd/LqEx2qSjwPXEbxRWoEeMw
         bhhyGHWDYk6el8EYuPDboKlAdrvZnHUU5CIqpLiIb/1urS6DMWgJGOoHu72O5aNLBttv
         zs85hzp90HBvpE/GkFQinwozrT9sVvcxE4G56zJoGWNbhTpC++63h5b7mDp8KvXgGb7S
         NdQHEkhJ8H8bQE0NwGE6SsZdvjjCMjdcNpBc8OeUuAjoAauFwTan4gAbvSLUwM9PFdtQ
         F4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760996738; x=1761601538;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2/4gND7Mx7r/qp2wrFqSXY+KceudyeUTazz1//alO0=;
        b=YsmW2XNEN3Y1v2Bo3T8WZhAt9OjrNJi6Kls6an6u0pg6+s/3hsB8X0sRmiPJHdXcs4
         VpB6ZotuOpYjD8mA5YPTsS3W5n/T7bHWppmbqoOLwJ2DVWlSOBUDp/mPeKiafe4CERtM
         vDlPrjDgsC716rkw7Noev4gTQiimfpn6WgZJf+K/PbFVI1cG8PykzXFaewb5UQ9JPnHY
         IIaxKunsEZUSQUVob+niIBmYjEJDSA2HpwZlUXzxXtgOMxpTM35ZZ2nukFODwF8aNpU6
         +GEuWsD3nIxBgNxBIpA8PSGwq/sy5oIoz3n4RPfiU5KPFnKL7QnkWAkqLR0mUWlrUdbh
         8f3w==
X-Forwarded-Encrypted: i=1; AJvYcCU4hEwkyBx6Pl83dz+PUOcg89mb2kOSBFHBqNmiKQJbMCVnuYKEONDamTRy2EyAPJw3beMNudldzwCWa+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRUf99XnyLO9jNIdnEkriAz+bblfIclJZuXNmWaHcJ1cvIR/pc
	TPT3zevx5w1JI1ZoEJVdN9OYLhDLlUommmwvbVcTq8ABNDbjiz4L+Xr7
X-Gm-Gg: ASbGncv0QoC26Y7LF1pbLR9JiWAeQ7SlvGv5n/SIHe/IYIj4sV3JQZ7Wrl0X/3evzLo
	/zR3OMjWl/6TCjZrzb7mAvIcJ2/wLnCo23o9TvmcmozDILbNF/kFpNtjO1lWOKTwYI3GjwmGkSL
	3HQr7rzY9sXwC8R1jR5AXT/Oq585atbugzipEWgc1Sx8StrSRVKrFMhz9QCTr3jaGsMk5lqTbS1
	IP3qjuyf0EM0SI/h1TclDWIHPysVNqr+DF7fuy+Tgw70nnZWiD3vMew6VCV1KwTupdhyvdMzrnL
	x20pdrybNUDMUE7yDBjByO+CBGWmZtJIDr1UCRTQl8OL/ngA/HnovAs/0ValLfLdsW7mp8Mt1Os
	hZs3fZwlNy7pl7MMQenR0anRjdSfyMR31cR0jTOUOy8NtpoTZ4dAPV6l2h2Vl02+CHCEaAs+5Dr
	HbRMIAy2k5d5M=
X-Google-Smtp-Source: AGHT+IEj4671OtILVKuHlsngYufu3DllwA9wgr0FhJ8jpb+MGiFZKLK2XCDCINjoEZzm79n5pF8KXw==
X-Received: by 2002:a17:902:ec87:b0:258:f033:3ff9 with SMTP id d9443c01a7336-290cb65c9f1mr191393215ad.48.1760996738137;
        Mon, 20 Oct 2025 14:45:38 -0700 (PDT)
Received: from AIOJono ([43.243.60.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de7c0b7sm8938355a91.16.2025.10.20.14.45.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2025 14:45:37 -0700 (PDT)
From: <professorjonny98@gmail.com>
To: "'Jacek Anaszewski'" <jacek.anaszewski@gmail.com>,
	"'Jonathan Brophy'" <Professor_jonny@hotmail.com>,
	"'lee Jones'" <lee@kernel.org>,
	"'Pavel Machek'" <pavel@kernel.org>,
	"'Rob Herring'" <robh@kernel.org>,
	"'Krzysztof Kozlowski'" <krzk+dt@kernel.org>,
	"'Conor Dooley'" <conor+dt@kernel.org>,
	"'Radoslav Tsvetkov'" <rtsvetkov@gradotech.eu>
Cc: <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-leds@vger.kernel.org>
References: <20251019092331.49531-1-professorjonny98@gmail.com> <3df51774-9774-40e6-ae65-7621bdce0f91@gmail.com> <DS0PR84MB37465DFAA8E8994B503A69829FF4A@DS0PR84MB3746.NAMPRD84.PROD.OUTLOOK.COM> <f76b9004-46ba-4cf6-993b-004242005d07@gmail.com>
In-Reply-To: <f76b9004-46ba-4cf6-993b-004242005d07@gmail.com>
Subject: RE: [PATCH v3 0/4] leds: Add a virtual LED driver for groups of
Date: Tue, 21 Oct 2025 10:45:32 +1300
Message-ID: <003e01dc420a$df26a430$9d73ec90$@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-nz
Thread-Index: AQDAA4bHOIcbizYcgYktuxAF83niAAHm7xLBAL6hVhYBfb39Vbbi7GZg

Hi Jacek

>From: Jacek Anaszewski <jacek.anaszewski@gmail.com>=20
>Sent: Tuesday, 21 October 2025 7:57 AM
>To: Jonathan Brophy <Professor_jonny@hotmail.com>; Jonathan Brophy
<professorjonny98@gmail.com>; lee Jones <lee@kernel.org>; Pavel Machek
<pavel@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
<krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Radoslav =
Tsvetkov
><rtsvetkov@gradotech.eu>
>Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
linux-leds@vger.kernel.org
>Subject: Re: [PATCH v3 0/4] leds: Add a virtual LED driver for groups =
of
>
>On 10/19/25 23:17, Jonathan Brophy wrote:
>> on 10/20/25 3:25am Jacek Anaszewski wrote:
>>> On 10/19/25 11:23, Jonathan Brophy wrote:
>>=20
>>>> From: Jonathan Brophy <professor_jonny@hotmail.com>
>>>>
>>>> Introduce a new driver that implements virtual LED groups,=20
>>>> aggregating multiple monochromatic LEDs into virtual groups and=20
>>>> providing priority-based control for concurrent state management.
>>>
>>>Aren't you trying to reinvent LED trigger mechanism?
>>>
>>>--
>>>Best regards,
>>>Jacek Anaszewski
>>=20
>> It is much simpler than that, I'm just trying to group LEDs into a =
new=20
>> virtual (fake) leds with some priority rules and define all this in=20
>> the DTS.
>>=20
>> Consider below is a dts of my router as an example.
>>=20
>> The leds node is the actual status LED I have in my router three=20
>> elements red, green and blue:
>>=20
>> Then I have my virtualcolor_leds node defining my groups that consist =

>> of these elements.
>>=20
>> I have two leds defined in each color I wish to display one that=20
>> blinks and one that does not.
>>=20
>>  From here I can define all my led colors and logic pattern in the=20
>> device tree.
>>=20
>> These virtual LEDs just appear as regular LEDs in sysfs.
>>=20
>> After a factory reset of my device I would expect the status led to =
be=20
>> solid yellow when it starts up then when ready to setup blink blue=20
>> ready for setup.
>>=20
>> It I connected these ot standard triggers I would end up with a mess=20
>> not knowing the status if multiple triggers operated at the same =
time.
>>=20
>> Without the logic I would likely after boot have a yellow led that=20
>> flashes white as the solid yellow would mix with the flashing blue by =

>> mixing of the power =A0and setting up triggers.
>>=20
>> I can define aliases to the virtual leds for access within user space =

>> and have all the features of a normal led with out the logic =
headache.
>>=20
>> My alternative is to create a driver defining logic in userspace with =

>> a cronjob or as such or with a custom binary.
>
>Userspace "driver" or rather a service would be for sure an approach
quicker to implement, that would not need lengthy discussion here to =
achieve
a consensus on the design.
>
>Otherwise, I would see this solution rather as a new LED trigger, that
would allow to define the LEDs to be grouped under it. The trigger =
interface
would need also to allow defining patterns according to which the LEDs =
would
be lit.
>
>Still, the trigger would be a task for months, and would need much =
analysis
to come up with a reasonable user interface.
>
>--
>Best regards,
>Jacek Anaszewski


The initial reason for this driver was to define aliases to point to
standard triggers in OpenWrt I'm happy that this driver will fit my =
purpose
and will solve a long-standing issue of control of status LEDs without =
other
complicated means.

If there is a better Idea to do this awesome but I am not very skilled =
and I
don=92t know if I will be able to implement this myself.
Having these things bound in the DTS enable status LEDs to be able to
connect directly to hardware triggers on things like Ethernet ports.

I also have security concerns with being able to alter triggers for
important things like warning lights from userspace for the things I =
wish to
attach them too.

What I come up with is secure and easy to work out what is going on and =
does
not alter major parts of the framework.

With drivers everyone creates their own driver to effectively manage LED =
in
their device, and it becomes a problem where the OpenWrt community has =
to
reverse engineer their efforts this makes it a little bit more unified =
if
 manufactures adopt a standard approach to led control of grouped LEDs =
to
format color-based status indication.

My TPlink x80-5g modem router had the basis of a similar grouping =
function
with a similar structure in the DTS from the manufacturer but it was =
very
basic compared to what I have created.

Best regards
Jonathan Brophy


