Return-Path: <linux-kernel+bounces-810200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16709B5172D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3676171FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75AA31C570;
	Wed, 10 Sep 2025 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lvXHCLx6"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627D831B10A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508239; cv=none; b=JwpNQwqsBg0FtLA70jxsyUxCKDQhGkWjdri58Gm6mOXS/2whU5S6qlX+jKlGcfJ19v4H8H7qmoOLwzh92bBgFI6s4HXcpgpCUaY1pUEj2rwuHfbdy2k3mwK9d47cTUFn0CtmnruJ3zrOQbI+1iUlaA7zSOCd0PyOUwYKvmDnb6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508239; c=relaxed/simple;
	bh=6hyxMssO6UptV5ndyXXdOtME72JdJ4MYovUh70TTqVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BT+J2iaA3awJss+F4CXlupJq0ysFMUQ+QNvBhKiy+Xgt3gZMhngrSp45Te2zP0J7spniTwOA9PkI9q5vqwEJeQOTKroB5CIX1xiy5RPpIHW2ZthHLOgYk7NrJbg2GpgRnGyxgOT917DkoVT5YXkkW02FxFYCHH/TZp10DjIDRMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lvXHCLx6; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7459de59821so5842663a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 05:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757508236; x=1758113036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQhOG91bArp9vZkb5DwKkVqTLjRBlvwnVCISw9YNxrs=;
        b=lvXHCLx6U2wmIq79iRabgINYDjQJ4QPVu5vF/wVxi1qjxfkLeJj1Or8X7NP2J7T+SJ
         50prWJfeuxtfACirtp3UBZGda/0P3eccUJIlTxztWKx1QYKd5zsJ4bSnh8NBe6CACML9
         XuC7erT2+LLUoY72K4f/tulK0wLRZ/GPlYV9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757508236; x=1758113036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQhOG91bArp9vZkb5DwKkVqTLjRBlvwnVCISw9YNxrs=;
        b=ZmMp21ZnS/GN/ytTuxGSiGTFdjAhJjcE6ULDYK8Qty53VrvbhtcOISdEVOM7LOjvRq
         A4FzFtfh75a005LA+z8ymagT3dP+jyRjcJKQkw9gKHWLGZVO+3XGl71WP+wfOqx9uYOO
         yOKDOYZtjfGO8fpOs8PoYpEEabGjxrtEP8KykpLVik0fsqar7UXj7wKE/sJZ0FnwMvzP
         kcSFUV7VRibBlwFz06etoOkztU7ho+OODOucj6TlrQB4F41nebrCL3MXxMK+4wUVbDyk
         2GDAsY2gHDebXgjT2GlSlDFH2Z3mFKN9BIlFhYCW/Sni/JuGIfgJF7MaMi+v3rnxaQaZ
         b/jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw4eE2skJDQ02ya9D+c0UpQ9DBAX3wujQvopV5r6AvFTg+ayjxNMDxxWOIKfuxdaK9t9AdxaE7i+V5zgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpxHxtlEK7qt8YecTl1s9aj3PtnI1ElIjh/LhsSwQBtKJ+zDXO
	ffDmrHWtXiyTuCG0g9e95CEWBUmdFAUIWiFtw9H9/Z1TWu73BJIHPL/pmAH51pNANvIR4ZBI2sA
	zZvsuLAfykE8vG4NXPktbjDjixkzo2BoP06fJSFk+
X-Gm-Gg: ASbGnctlxL/6G3rAmLMRBftttfi6WWjxDvI6BZy5Fpr/h6hmuhrffZ4mtnAtTUYZtP7
	Fk12wPwhqtYqkgk8bl2twcpH060QYHGbRIZUaNj6yYnPVZW5HEZENEUTGUs/pRwC6y1bYCg2xBF
	hIQa0yw9ziWRArL3BR/1MZmfvIhPbWy/yPFw7Rovs/WWSOvobu32GHklJRTfJy3Cn6TRRd+nS0w
	gAN/h1pe7JHU6oxsTmMFlcf0iiHtz/b8c8k1o9lKW3g2Xls
X-Google-Smtp-Source: AGHT+IGxcqc4D5gEQ+X5NRlavlcxPq6T9FzervsoDixpqR3jg4vwtYGtcuqLh1US1dqr6ottFh5JAcVWbB+ygwZExC4=
X-Received: by 2002:a05:6830:2a16:b0:73e:8c8b:749 with SMTP id
 46e09a7af769-74c667ebe6dmr9355332a34.0.1757508236391; Wed, 10 Sep 2025
 05:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909094335.1097103-1-treapking@chromium.org> <CAJZ5v0jNytfP8W2XSyBNLe8OsD=O9M7WWvhtxdwXA-5KxwKfbg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jNytfP8W2XSyBNLe8OsD=O9M7WWvhtxdwXA-5KxwKfbg@mail.gmail.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Wed, 10 Sep 2025 20:43:45 +0800
X-Gm-Features: Ac12FXxR5wted0eOqkHInYwIU_oThynHjmKnNyVK-3wz-J14_ellHNLoRtJtMTE
Message-ID: <CAEXTbpd6k=_yF4vG-zU4C0ymriLYXcT4AusCFJ03wZWJecOS5w@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: Don't wait for SYNC_STATE_ONLY device links
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Hsin-Te Yuan <yuanhsinte@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

Thanks for the review.

On Wed, Sep 10, 2025 at 7:56=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Sep 9, 2025 at 11:44=E2=80=AFAM Pin-yen Lin <treapking@chromium.o=
rg> wrote:
> >
> > Device links with DL_FLAG_SYNC_STATE_ONLY should not affect suspend
> > and resume, and functions like device_reorder_to_tail() and
> > device_link_add() doesn't try to reorder the consumers with such flag.
> >
> > However, dpm_wait_for_consumers() and dpm_wait_for_suppliers() doesn't
> > check this flag before triggering dpm_wait, leading to potential hang
> > during suspend/resume.
>
> Have you seen this happen or is it just a theory?

We initially see this with a downstream kernel, but I can reproduce
this with the upstream kernel when I connect the usb host controller
to a "usb-a-connector" node on MT8186 Corsola Chromebook. The
devicetree looks like:

usb-a-connector {
        compatible =3D "usb-a-connector";
        port {
                usb_a_con: endpoint {
                        remote-endpoint =3D <&usb_hs>;
                };
        };
};

usb_host {
        compatible =3D "mediatek,mt8186-xhci", "mediatek,mtk-xhci";
        port {
                usb_hs: endpoint {
                        remote-endpoint =3D <&usb_a_con>;
                };
        };
};

In this case, the two nodes form a cycle and I ended up seeing a
SYNC_STATE_ONLY devlink from usb_host (supplier) to the
usb-a-connector (consumer).

I'm not very sure why we didn't see this issue before. Maybe it's
related to the fact that the usb-a-connector has a compatible string
(so a platform device is created) but no driver binds into it.
>
> > Add DL_FLAG_SYNC_STATE_ONLY in dpm_wait_for_consumers() and
> > dpm_wait_for_suppliers() to fix this.
>
> The above sentence is incomplete AFAICS.

Sorry, I meant "Add a check for DL_FLAG_SYNC_STATE_ONLY in ...". I'll
update this in the next version.
>
> > Fixes: 05ef983e0d65a ("driver core: Add device link support for SYNC_ST=
ATE_ONLY flag")
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > ---
> >
> >  drivers/base/power/main.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 2ea6e05e6ec90..3271f4af2cb65 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -282,7 +282,8 @@ static void dpm_wait_for_suppliers(struct device *d=
ev, bool async)
> >          * walking.
> >          */
> >         list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_n=
ode)
> > -               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
> > +               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT &&
> > +                   !device_link_test(link, DL_FLAG_SYNC_STATE_ONLY))
>
> This should use a check like device_link_flag_is_sync_state_only(),
> which is different from the above one, for consistency with
> device_reorder_to_tail().

Thanks. I'll fix this in the next version.
>
> >                         dpm_wait(link->supplier, async);
> >
> >         device_links_read_unlock(idx);
> > @@ -339,7 +340,8 @@ static void dpm_wait_for_consumers(struct device *d=
ev, bool async)
> >          * unregistration).
> >          */
> >         list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_n=
ode)
> > -               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
> > +               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT &&
> > +                   !device_link_test(link, DL_FLAG_SYNC_STATE_ONLY))
>
> And same here.
>
> >                         dpm_wait(link->consumer, async);
> >
> >         device_links_read_unlock(idx);
> > --

Regards,
Pin-yen

