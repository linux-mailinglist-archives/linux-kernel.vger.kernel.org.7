Return-Path: <linux-kernel+bounces-838227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1786EBAEBC1
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 01:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6681B1940585
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F040B2D0C99;
	Tue, 30 Sep 2025 23:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YiozpR+M"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF762D0634
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759273706; cv=none; b=KmzfboIxDBgoiowUEgBqTyw+Ie2tHxIQXikZleOqP3WcFwFZOqsVw8NbBiYOivPyehDojj1EtjR3BL1Gt5tsrOTodBO7gz6/7GNhqVfHtjauOyFetZA65TmodQ5kgDAIEXRnO98dpCg8ll4ctnvhBtnJLJsVjfjyYwdzoFDk6sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759273706; c=relaxed/simple;
	bh=xQ9ascDA7HHkZafxlNLWnd7gwlj790RZILnV2UbZ+FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZg0K4FqOkA2uoVCiA3bna42bqiBbc8B0lSnX2577shN20HGJ0IQ31XCQi7OAIE3ONDdPxKvM8zceR6jdVZ2uvYzHdYZL257FOz5DW3pLmx2UzuK/lolJPXXL3YRPVrCifLZRQ6jz7/SLqwlb+wURogLBOexzmQ4Q8P8gfi8rqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YiozpR+M; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-79d36a6298dso2721723a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759273703; x=1759878503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiBaoGgaM2C3I3iKN33UN2nyaLpcr1G/mtPkZ6OT3tM=;
        b=YiozpR+MxYHU3jSEB3HPQ1XbfNGmMntZLX97QJhJbLVGiegTueuXwmasyPknkRf02G
         7FBO48x4Pkpq1eEaR7x+SVAC/9p1nYi17tgJtnXCxKHo0A2jMsaZz/vNySsVcX4qSHNP
         5bIxzAfDE5jBSVvyh3UvPKfF2q+1p03s9q9U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759273703; x=1759878503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiBaoGgaM2C3I3iKN33UN2nyaLpcr1G/mtPkZ6OT3tM=;
        b=LE5RjP4nrKSU3r+J28Jyw33VaBXhkRHdHzv9nvtbOgysShWrMQuwYCh15NyQ4+utga
         XxZU4p9j+DvR3IuQbibYAgDIdd+05/afOuVg7syGEb9D0e2vHpXYVtn9/9s+mPMAhVaJ
         WIZe+E3W0nupA0tkbVM3tKyPW9XKDpmGQ4A7tfiZBFZWvcPkoo0h29tk2SrwoXnnWc73
         Vh8V8+aT7PvIhowM9fbwDDcXuB5WC/KSblndMiZO5GhBXssJTAhodl2D7imhcLY30TK8
         vX21QY5xuj+nf/NZoNZ8ILV872SR4RCW9WBY+Pd+2QwuwbzSigCU51wAm7Ek14xSVoRl
         NLHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5K/MSFyx+bvzcwDoA1gbn9NO7TiDNs+cM8GyeyezmdVmpIZMkUZDdCXio2ZyJ83MfW1LIKlhPMEoEf50=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvvP8PJI9p4zPrp++RmYrqOUuGuOCgf925QnNMI5HO4EI2QaI5
	TCJSsSE26S8BvzhLaEwroTFVNUjtKI+muBD2PdJ1s66ErN6t5tYIrdGgcEzSK3Jsm3ZTNxuGd0t
	9/NFkxJ0l/vCj6OWHN/pu8tnbxSNNqEr3ZobzDG4v
X-Gm-Gg: ASbGncvjnv33kxFmPwodbJYfw6ouY9bLC1+JIXCRDT4nBPKLKQnGfX9k3XGSVtaiXRr
	IBJcaM0VOrMXOvX3N6UzqWA9XoJbWjsu1dszrHKwjiD//U/06+ku2pJHtkIdXX1BQ2kjocsqXUT
	vEDWnRCkSnV5yt0j3VBBxk88Ase6lqn41TufZ8vFdmJqfIjIK6+NnmXziys2TyVo/xNgjunuAXX
	RQF+JEsRKkvagTRtTrWdbXblgCp/F3VKjicvmken7Qdn3KxiH1Wh0B4kuyE
X-Google-Smtp-Source: AGHT+IHMEqNH78iPNiGGP3bb7Kx8uDn/T1LzaPL/CpPUoH7hqsowKpT+GgRGF3J9BiV9iQL5QcSwcug4NCAhGjFiogA=
X-Received: by 2002:a05:6830:3c09:b0:7af:a0ac:d56 with SMTP id
 46e09a7af769-7bddae3c229mr992705a34.22.1759273703460; Tue, 30 Sep 2025
 16:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926102320.4053167-1-treapking@chromium.org> <CAJZ5v0i-iT-3nEjX7Nm2s91GSm0OTXQ3yZSf2Q3VRNTOseREHw@mail.gmail.com>
In-Reply-To: <CAJZ5v0i-iT-3nEjX7Nm2s91GSm0OTXQ3yZSf2Q3VRNTOseREHw@mail.gmail.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Wed, 1 Oct 2025 07:08:12 +0800
X-Gm-Features: AS18NWBTNmMaOUfYxFxTvE7zS5oWKcOj0SYvHdkUx6TzVPgyImUlvVKEMGKXEwk
Message-ID: <CAEXTbpfUEDf_L3wVJEwD=Wjhx05X6Z2F-rbZT5L7vUR8GUAWTQ@mail.gmail.com>
Subject: Re: [PATCH v4] PM: sleep: Don't wait for SYNC_STATE_ONLY device links
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kernel@vger.kernel.org, 
	Hsin-Te Yuan <yuanhsinte@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

On Sat, Sep 27, 2025 at 8:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Sep 26, 2025 at 12:23=E2=80=AFPM Pin-yen Lin <treapking@chromium.=
org> wrote:
> >
> > Device links with DL_FLAG_SYNC_STATE_ONLY should not affect suspend
> > and resume, and functions like device_reorder_to_tail() and
> > device_link_add() doesn't try to reorder the consumers with such flag.
> >
> > However, dpm_wait_for_consumers() and dpm_wait_for_suppliers() doesn't
> > check this flag before triggering dpm_wait, leading to potential hang
> > during suspend/resume.
> >
> > This can be reproduced on MT8186 Corsola Chromebook with devicetree lik=
e:
> >
> > usb-a-connector {
> >         compatible =3D "usb-a-connector";
> >         port {
> >                 usb_a_con: endpoint {
> >                         remote-endpoint =3D <&usb_hs>;
> >                 };
> >         };
> > };
> >
> > usb_host {
> >         compatible =3D "mediatek,mt8186-xhci", "mediatek,mtk-xhci";
> >         port {
> >                 usb_hs: endpoint {
> >                         remote-endpoint =3D <&usb_a_con>;
> >                 };
> >         };
> > };
> >
> > In this case, the two nodes form a cycle and a SYNC_STATE_ONLY devlink
> > between usb_host (supplier) and usb-a-connector (consumer) is created.
> >
> > Export device_link_flag_is_sync_state_only() and use it to check this i=
n
> > dpm_wait_for_consumers() and dpm_wait_for_suppliers() to fix this.
> >
> > Fixes: 05ef983e0d65a ("driver core: Add device link support for SYNC_ST=
ATE_ONLY flag")
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > ---
> >
> > Changes in v4:
> > - Remove inline for device_link_flag_is_sync_state_only()
> >
> > Changes in v3:
> > - Squash to one patch and fix the export approach
> >
> > Changes in v2:
> > - Update commit message
> > - Use device_link_flag_is_sync_state_only()
> >
> >  drivers/base/base.h       | 1 +
> >  drivers/base/core.c       | 2 +-
> >  drivers/base/power/main.c | 6 ++++--
> >  3 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > index 123031a757d9..80415b140ce7 100644
> > --- a/drivers/base/base.h
> > +++ b/drivers/base/base.h
> > @@ -248,6 +248,7 @@ void device_links_driver_cleanup(struct device *dev=
);
> >  void device_links_no_driver(struct device *dev);
> >  bool device_links_busy(struct device *dev);
> >  void device_links_unbind_consumers(struct device *dev);
> > +bool device_link_flag_is_sync_state_only(u32 flags);
> >  void fw_devlink_drivers_done(void);
> >  void fw_devlink_probing_done(void);
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index d22d6b23e758..a54ec6df1058 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -287,7 +287,7 @@ static bool device_is_ancestor(struct device *dev, =
struct device *target)
> >  #define DL_MARKER_FLAGS                (DL_FLAG_INFERRED | \
> >                                  DL_FLAG_CYCLE | \
> >                                  DL_FLAG_MANAGED)
> > -static inline bool device_link_flag_is_sync_state_only(u32 flags)
> > +bool device_link_flag_is_sync_state_only(u32 flags)
> >  {
> >         return (flags & ~DL_MARKER_FLAGS) =3D=3D DL_FLAG_SYNC_STATE_ONL=
Y;
> >  }
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 2ea6e05e6ec9..73a1916170ae 100644
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
> > +                   !device_link_flag_is_sync_state_only(link->flags))
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
> > +                   !device_link_flag_is_sync_state_only(link->flags))
> >                         dpm_wait(link->consumer, async);
> >
> >         device_links_read_unlock(idx);
> > --
>
> Rebased on top of linux-pm.git/linux-next and applied as 6.18 material
> with some minor edits in the subject and changelog.
>
> Thanks!

Thanks for updating the commit message and applying the patch.

However, I can't find this patch at
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=
=3Dlinux-next

Did I check the wrong place for this?

Regards,
Pin-yen

