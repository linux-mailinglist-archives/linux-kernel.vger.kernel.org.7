Return-Path: <linux-kernel+bounces-881452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDA2C283C0
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 18:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D180D3B004F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F64A27E04C;
	Sat,  1 Nov 2025 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHo98+zq"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33012773D9
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762016855; cv=none; b=rYQ979YvULPl7Jz0vR5LPZYzGlUxKrCCSFnVUisFiDyhE276+269J7f9fQNI+YtpnvmJ5w334bRM1CuQkx+fxBmR1Q+fSrnKzGRz0d+FdO3HyKirjxRr/oIk+iBuuZ23JQcZh8B5fUQU92leKvl1mcT6aHuddwSevdzAnIB/w8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762016855; c=relaxed/simple;
	bh=9PKLqVSpqbJZCM4LUPMSSnMa4TBcwj8ckL4x2FdwcsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDNfBrnYSI/G/eu1bF59WnYrnpp5R37hHPntc+e/eitsTbs6YneJRGQYwC6ZMC6OlQHB2FpMBwjiBkVTPU6eRNbcjW2Xs2TU2U9QwrzADGClLwxNpzy2Ux5c+inW5rnGcpTzaSqP692oZByiB/fi2ieS8iJdeSK1PfB8O5f3bDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHo98+zq; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so2055378a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762016852; x=1762621652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwqU3yflKRW5oNlu8dwjZBgSW+w2OUOQ9FQXOEjEFOk=;
        b=MHo98+zqOSOa81bA4guxEBQ1cbvJn/YNc+pJWnhgzMbvThST2OAS+wex2X0Ueks21q
         rkjQBx5vXEx9TqSdyAmM5GYrk/aaGvmW828nYHX4e8gb64FPH3D5k66kXZBqgOCtzSAn
         JjYsu1+xjhJlZ0WpRnGDwdQuU6oIGXceFizXGsg2LuE8ATaOBAAv0CM+CHT4kPBhAI28
         DXRDk7dZ4AkP+XE2SfEPib8E/W0QKzS3GE4DddKqzzP1WlUXxLLiUkmz0FNkTVtsD45T
         EdBVE/3bC3asc8BZhM2oz8bTM8jcVouBofeUiUQmJKQga/1uS08vAGRt7RSBuHCaNGKD
         rd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762016852; x=1762621652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwqU3yflKRW5oNlu8dwjZBgSW+w2OUOQ9FQXOEjEFOk=;
        b=THqV8Ejo7o0dWWQzt9L6/r8+YxfkH3jEq2RIjj0SSSxKAKvaBXxh7Tr2HkM2hW758i
         wzMYkG3RlY1yHraRkOvXO0snPiFIbL6nOPRwzpzcldEj7CuTHJrAsgANkwtmX9YnGmbH
         +kKRfU1c/wJ97WxMxD33+4+2wR5NblS7asoIN5tCmxwOezS50a5RXb0plTYHU4TB0SLR
         E6fDjPoMbSn7M+ACuVQYjn5XhvFjFy/y5mVXE2NXp7gzn4ZvvxD8qUEE/4sTKCsjBze9
         SJqU7QngLbyg8RniAKLSXdrlOPk8xoF79Yfu1DkRQBC4mKCdGvxyQBTlmS3Ka5qJ6+Aq
         LWhg==
X-Forwarded-Encrypted: i=1; AJvYcCWl+O/6bO+USOzaWzZ14IcjOIqNLqUHK4HtnYCu9zNpXSp3CPruoJ61U2vIxAtPwIx+Qwff8/SQpm9oJAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynGd54aCd9a88c2yu48t0V0Mwdcy057f8+hqesG3R3OQy7y0OV
	BryLkToDoOLrbSBsORgyHx81aNOqXYf7K3qKdrA5Hm1mpvtj9bq5HaAW37l+5R0hLvAZLLu8h/H
	knYVMM3u8VC2NQSxYGvhYKMmuTINz6Z4=
X-Gm-Gg: ASbGnctOvv5pn3xm5y42LnyZdC86fpMelsqXBKYDKQN5su6Il7qb+ZyIIK6+4rlwX6r
	gaLwXirwf8p0iFwb/q2A7PGuEiRkzpMlOdAGqs6v1tRXxVTyFv7MP/P2F1ew16Ppa8vzT17HvVM
	r1KKpMgGeUwGr+T4JSfw4F0zxHEm1FzcuurCzLu1iTQYI4P4fTvkVislx975pGOYcab1i+Xa5qp
	IP+HCW6AFZFdPqeDTUl90dBLNkPIwWIccTk2QtDpUuBul98foI3osCzNkM=
X-Google-Smtp-Source: AGHT+IGIlqSDf+EXTXyrGJ57kthTyg/wYcJhKTwOBBUkRF0PYtYHzhxvKOPRUBbMMuqTOOiN++zzRQYKu4gUy0r7nQs=
X-Received: by 2002:a17:907:7f2a:b0:b57:2ffa:f17e with SMTP id
 a640c23a62f3a-b7070132a9dmr778193366b.19.1762016851893; Sat, 01 Nov 2025
 10:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926141913.25919-1-jefflessard3@gmail.com>
 <20250926141913.25919-5-jefflessard3@gmail.com> <aQSEWGg50VHIECoM@smile.fi.intel.com>
 <B4CFA18F-CE12-4257-AAD0-FA9B744A1E29@gmail.com>
In-Reply-To: <B4CFA18F-CE12-4257-AAD0-FA9B744A1E29@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 1 Nov 2025 19:06:55 +0200
X-Gm-Features: AWmQ_bnnewjUkrk43oqtm7eYsVsIg2AkzJTKhqnM9WyLndyacL6QFEAoC2l5gV8
Message-ID: <CAHp75VdaPVcKhLSCOiUw+0cqNq6pkxZqVpd2Bk-q-9dNV=+kqA@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] auxdisplay: Add TM16xx 7-segment LED matrix
 display controllers driver
To: =?UTF-8?Q?Jean=2DFran=C3=A7ois_Lessard?= <jefflessard3@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	Paolo Sabatino <paolo.sabatino@gmail.com>, Christian Hewitt <christianshewitt@gmail.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 7:17=E2=80=AFPM Jean-Fran=C3=A7ois Lessard
<jefflessard3@gmail.com> wrote:
> Le 31 octobre 2025 05 h 41 min 44 s HAE, Andy Shevchenko <andriy.shevchen=
ko@intel.com> a =C3=A9crit :
> >On Fri, Sep 26, 2025 at 10:19:05AM -0400, Jean-Fran=C3=A7ois Lessard wro=
te:

...

> >> +static inline void tm16xx_set_seg(const struct tm16xx_display *displa=
y,
> >> +                              const u8 hwgrid, const u8 hwseg, const =
bool on)
> >> +{
> >> +    assign_bit(hwgrid * display->num_hwseg + hwseg, display->state, o=
n);
> >
> >Do you need an atomic call here? Perhaps __assign_bit() would suffice,
>
> Keeping assign_bit(), it's required here. Two distinct concurrency scenar=
ios
> exist:
> - Bitmap: Multiple LED triggers (network, timer) + userspace write to
>   display->state concurrently -> need atomic ops
> - Hardware: Mutex serializes different hardware operations (flush_init,
>   flush_display, keypad polling) that can race
> The mutex doesn't eliminate bitmap concurrency needs, they're orthogonal
> concerns.

Okay, but the below bitmap_read() is non-atomic. And in general the
bitmap API is not atomic.

> >> +}

...

> >> +                            ret =3D fwnode_property_read_u32_array(ch=
ild,
> >> +                                                                 "seg=
ments", segments,
> >> +                                                                 TM16=
XX_DIGIT_SEGMENTS * 2);
> >
> >> +                            if (ret < 0)
> >> +                                    return ret;
> >
> >Why '< 0'? Here it's definitely not a counting call, so it should never =
return
> >positive in this case.
>
> Keeping if (ret < 0). While usage with non-NULL buffer won't return posit=
ive
> values, fwnode_property_read_u32_array() documentation explicitly states =
it can
> return count when buffer is NULL. Using < 0 is the defensive, API-complia=
nt
> pattern that matches the function signature.

Okay, it's fine to keep this way.

...

> >> +                            ret =3D fwnode_property_read_u32_array(ch=
ild, "reg", reg, 2);
> >> +                            if (ret < 0)
> >
> >Ditto,.
> >
>
> As per above.
>
> >> +                                    return ret;

...

> >> +    INIT_WORK(&display->flush_init, tm16xx_display_flush_init);
> >> +    INIT_WORK(&display->flush_display, tm16xx_display_flush_data);
> >
> >devm-helpers.h have something for this case, I believe.
>
> Cannot use devm_work_autocancel(). The shutdown sequence requires specifi=
c
> ordering: (1) unregister LEDs to stop triggers, (2) clear display state, =
(3)
> flush pending work, (4) turn off display. This sequence prevents hardware
> access races when triggers attempt to update the display during removal. =
Manual
> INIT_WORK with explicit flush/cancel in remove() provides this control.

Do you mean that the removal order is not symmetrical to the probe one?
At bare minimum this needs a comment in the code (as summary above) to
explain why devm_*() are not being used.

...

> >> +    main->max_brightness =3D display->controller->max_brightness;
> >> +    device_property_read_u32(dev, "max-brightness", &main->max_bright=
ness);
> >> +    main->max_brightness =3D umin(main->max_brightness,
> >> +                                display->controller->max_brightness);
> >
> >Hmm... Why 'u' variant of macro?
> >
> >> +    main->brightness =3D main->max_brightness;
> >> +    device_property_read_u32(dev, "default-brightness", &main->bright=
ness);
> >> +    main->brightness =3D umin(main->brightness, main->max_brightness)=
;
> >
> >Ditto.
>
> Correct for unsigned brightness values. umin() is the appropriate macro f=
or
> unsigned types to avoid type conversion warnings.

But are you in control of all the variable types? If so, why not align
the types?

...

> >Given a comment about propagating fwnode, why do we need all this? Doesn=
't led
> >core take care of these properties as well?
>
> Manual handling is necessary because:
> 1. default-brightness: Not implemented in LED core

Oh, indeed, I mixed this with default-state. But the side question
here is what prevents us from implementing it? I suspect there were
discussions in the past, but I haven;t dug the lore archive to see if
any indeed happened.

> 2. max-brightness defaulting: If DT property is absent, default to
>    controller->max_brightness
> 3. Ceiling enforcement: When DT property IS present, clamp to not exceed
>    hardware limits (controller->max_brightness)
>
> LED core only reads max-brightness optionally, it doesn't handle defaulti=
ng or
> hardware ceiling enforcement.

Yep, thanks for elaborating.

...

> >> +            ret =3D led_classdev_register_ext(dev, &led->cdev, &led_i=
nit);
> >
> >Why not devm_led_*()?
>
> Intentional non-devm design documented in commit notes. Explicit unregist=
ration
> before removal immediately stops LED triggers, preventing them from acces=
sing
> hardware post-removal. devm_led_*() would require complex brightness call=
back
> state tracking to handle trigger activity during remove(). Explicit unreg=
ister
> is cleaner and eliminates this race.

Right, so I think the summary of this needs to be commented on in the
code (as well).

...

> >> +    ret =3D linedisp_attach(&display->linedisp, display->main_led.dev=
,
> >> +                          display->num_digits, &tm16xx_linedisp_ops);

> >If we haven't yet devm for this, it can be
> >1) introduced, OR
> >2) wrapped to become a such (see devm_add_action_or_reset() usage).
> >
>
> While devm_add_action_or_reset() could wrap linedisp_detach(), the overal=
l
> shutdown still requires explicit ordering across multiple subsystems (lin=
edisp,
> LEDs, workqueues, hardware). Using devm for just one component while manu=
ally
> managing others adds complexity without benefit. The current explicit app=
roach
> keeps all cleanup logic together in remove() for clarity.

Okay, I need to have a look at this again when you send a new version,
but I want to finish reviewing this one. Sorry it takes time.

--=20
With Best Regards,
Andy Shevchenko

