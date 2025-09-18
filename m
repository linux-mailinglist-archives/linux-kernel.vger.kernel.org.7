Return-Path: <linux-kernel+bounces-821812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14083B8258D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C96188BAD9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE8223741;
	Thu, 18 Sep 2025 00:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oFvFjUMO"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45A11187
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758154199; cv=none; b=FSKKfnHdpmvtGfyRQlnGFy8l+M/qeuDw7g3Abicpz4wZQ8Px+q4M2UTHrCKlbdRJLCExxGzfPxPFSY9Fho//nTEBn5Y0ixADNJVs4hcqUtDdL0yrnygy7Gq49O0plkUOsLlGsz+T2RL6K7JGEJ8k7ue14e/iSi0XwFpEvWo+FbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758154199; c=relaxed/simple;
	bh=wXmVEes7R+HZhzrPevZN6QhmJWKaa1NAEkUnITk2JiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=htTMQa6HR26FvQf+7C/LGp36Jxv8uCkOrypBnJXzbP3zP4DyfvyOniQOlVGE0oKqOaWFS/sb9toi71CBTJ1gI/F8QPEgeEaObZtBDyjLOTsWuk7DuIEOSQu0a+qz0QAN0+CjdEfltDiRDWzDoiGkkk+pdkjNuDhq7R3HAEITFkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oFvFjUMO; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d60504bf8so4458667b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758154196; x=1758758996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugUY8fDSYAyjEj+60o61XHTDZs04gL4Ne5h3N5cFY+U=;
        b=oFvFjUMOJt7NtRS/h4z7j9mPP16BLq+idOOwi/q/la5jGtW1OHYJbkC4yh7G7ScbZ8
         XRGoaPpHPD/JEfsgD8t58QIyUe2ztJCRLp4vaKVohNZexeb8/DjXOWp6moE9CGAc4KCo
         zGpCqu8K/hOzwW9m07RHdS5/HqC9mM1I0ZyoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758154196; x=1758758996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugUY8fDSYAyjEj+60o61XHTDZs04gL4Ne5h3N5cFY+U=;
        b=U5LAT3roROyjLBHLaKl+HKTPtzAxCqH7QOSICoSERHSGTjXpLnJ7VvNViJVHktDjlP
         bAGHNjcgb354BJpNT0WD5Bl9CjtbFUXMkqrZnSGOhJ/XI25hQ7Ems7IGjY/LHF7PJOYq
         wE2CGfh39aGPmuUSSczR0Qc1IKt92+ZUSrfCA7HS4wGCexBWBZc3iVK63KmBuYm2Pp6t
         BGbGT8F0DO15vTSGg4uGydoP92Ygbrm96HDc2xSPgTeIi4tjYNHMnP44vZGSzNtIWzwT
         rdNcxWPjqQON9EpI09c2qJgnI9v6GKPl+nmHn08eqBzNuVefCzXCZXAN/4lIlbw1b9h8
         0SSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjq0ZeKRInoF+kcbab2TJ5/p6PXCzdXql8qoCTc0PRxFnBag5uxLlfFNyYbnosaUeYkr+a2yuSwEYuHiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCJTPTCD4OQKkJXloXZmHH6sQwqMExBrvIX4ZfwIyJoTQRCgvW
	5j/q0Z5ueVvtT5GAUYvEi66mJdMvlyBmIjBmg76G7J7O712o+dHPzHFaXpnEK3Sql8Fwp13JgQP
	mA+mrdYRYQ6GMr5TtX0Uv821yDryT+n5IKizAOylC
X-Gm-Gg: ASbGncuo6PsUf2FY+glmoDdYsE1cG/L4i98byG34KEeDTTaQcclJ5kAJVCfyUC/k2Zq
	wOZkymQQQgjCvmdPF/9R4gmtc2q9d2jfOD2Zr8ja1JfDfe1LMJGU/OV9kgjACGb6LD8ZQlJBcG3
	kwYfN1209VoPgldhzyYDy55vm8cRtNDJqZeIOeeR9E6d0TpOy86LC9KzmkfOlkWqE0q14I4u0Sa
	nHg+lJXdbPvJ/T7MtX7Rtz01Q==
X-Google-Smtp-Source: AGHT+IF1frXLALk7WSuqMqYwezb5DgqWLAUYnU3Oeq3dZu2d6eJcwsvSihmi/zwq6RojmrVWrWrazn/idl/1oNGv5Fc=
X-Received: by 2002:a05:690c:6002:b0:72e:a82a:ab84 with SMTP id
 00721157ae682-7389265e5a8mr33044617b3.51.1758154196107; Wed, 17 Sep 2025
 17:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909123028.2127449-1-akuchynski@chromium.org>
 <aMliLCWFKy5Esl0-@kuha.fi.intel.com> <CANFp7mXvpNXr=01nQR54d+Z+vSiiwiDLB+3B+1eR6Ks7b37gtg@mail.gmail.com>
 <aMqpe68m3rhDYsCt@kuha.fi.intel.com> <CANFp7mWk_TuA6Gxbtc8OmB7eq_vT8wUg=xkPJsxLCBTrQwOd6A@mail.gmail.com>
In-Reply-To: <CANFp7mWk_TuA6Gxbtc8OmB7eq_vT8wUg=xkPJsxLCBTrQwOd6A@mail.gmail.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Wed, 17 Sep 2025 17:09:44 -0700
X-Gm-Features: AS18NWAyWH1DZmpewk_fLYk2Psq6ex0rOS5pigS50Ll2bt7BydEol9bZzR6p01Q
Message-ID: <CANFp7mVwZksBYBOgPLDDYiynjFDh3jJqY1PFvvBWxtFd8MMYjw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] USB Type-C alternate mode selection
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andrei Kuchynski <akuchynski@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:51=E2=80=AFAM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> On Wed, Sep 17, 2025 at 5:28=E2=80=AFAM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Tue, Sep 16, 2025 at 09:47:44AM -0700, Abhishek Pandit-Subedi wrote:
> > > On Tue, Sep 16, 2025 at 6:12=E2=80=AFAM Heikki Krogerus
> > > <heikki.krogerus@linux.intel.com> wrote:
> > > >
> > > > On Tue, Sep 09, 2025 at 12:30:23PM +0000, Andrei Kuchynski wrote:
> > > > > This patch series introduces a flexible mechanism for USB Type-C =
mode
> > > > > selection, enabling into USB4 mode, Thunderbolt alternate mode, o=
r
> > > > > DisplayPort alternate mode.
> > > > >
> > > > > New sysfs `mode_selection` attribute is exposed to provide user c=
ontrol
> > > > > over mode selection. It triggers an alternate mode negotiation.
> > > > > The mode selection logic attempts to enter prioritized modes sequ=
entially.
> > > > > A mode is considered successfully negotiated only when its altern=
ate mode
> > > > > driver explicitly reports a positive status. Alternate mode drive=
rs are
> > > > > required to report their mode entry status (either successful or =
failed).
> > > > > If the driver does not report its status within a defined timeout=
 period,
> > > > > the system automatically proceeds to attempt entry into the next =
preferred
> > > > > mode.
> > > >
> > > > I'm still struggling to understand what is the benefit from this - =
why
> > > > would you want the user space to explicitly start the entry process
> > > > like this? Instead why would you not just take full control over th=
e
> > > > alt modes in user space by enabling the them one by one in what eve=
r
> > > > order you want?
> > >
> > > I think after the many patch iterations we went through upstreaming,
> > > we may have lost the point a little bit wrt/ the mode selection task.
> > > We talked about this on the very first iteration of this patchset
> > > here: https://lore.kernel.org/linux-usb/CANFp7mVWo4GhiYqfLcD_wFV34WMk=
mXncMTOnmMfnKH4vm2X8Hg@mail.gmail.com/
> > >
> > > The motivation behind it was to allow the kernel driver to own mode
> > > selection entirely and not need user space intervention. The current
> > > alt-mode drivers attempt to own the mode entry process and this fails
> > > when you have two or more altmode drivers loaded (i.e. displayport,
> > > thunderbolt). The original goal of the mode selection task was to mov=
e
> > > the mode entry decision away from the alt-mode driver and to the port
> > > driver instead.
> > >
> > > What's missing in the current patch series to show this is probably
> > > actually calling mode_selection once all partner modes are added :)
> > > Andrei should be adding that to this patch series in the next patch
> > > version.
> > >
> > > Adding the mode_selection sysfs trigger is for another reason: to
> > > re-run mode selection after priorities have been changed in userspace
> > > and there is no partner hotplug. We specifically have some security
> > > policies around PCI tunnels that result in the following need:
> > > * When we enable pci tunneling, we PREFER tbt over dp and would like
> > > to select the preferred mode. When we disable it, we PREFER dp over
> > > TBT and would like to select the preferred mode.
> > > * When users are logged out, we always prefer DP over TBT.
> > > * When the system is locked, we prefer DP over TBT for new connection=
s
> > > (but existing connections can be left as TBT). When we unlock, we wan=
t
> > > to enter the most preferred mode (TBT > DP).
> > >
> > > While this is do-able with the alt-mode active sysfs field, we would
> > > basically be re-creating the priority selection done in the kernel in
> > > user space again. Hence why we want to expose the mode selection
> > > trigger as done here.
> >
> > But this would be a step backwards. You want to keep the kernel in
> > control of the mode selection, which is fine, but then you have these
> > special cases where you have to give some of the control to the user
> > space. So instead of taking complete control of the mode selection in
> > user space, you want to create this partial control method of
> > supporting your special cases while still leaving "most" of the
> > control to kernel.
> >
> > I don't believe this will work in all cases. I'm fine with the
> > priority as a way to tell the kernel the preferred entry order, but if
> > the user space needs to take control of the actual mode selection, it
> > has to take full control of it instead of like this, partially. This
> > just looks incredibly fragile.
> >
> > So I'm still not convinced that there is any use for this. Either the
> > user space takes over the mode selection completely with the active
> > attribute files, or just leaves the selection completely to the kernel.
> >
>
> That's a fair stance to take. We CAN do our special cases via the
> "active" sysfs node. I've had a bit more time to think about the
> problem we are solving and I'd like to elaborate a little.
>
> When we designed this mode selection task, there were two motivating fact=
ors:
> * The existing typec_displayport and typec_thunderbolt modules will
> both automatically try to enter a mode when probing and that does not
> work well. You want a deterministic entry order.
> * There is no generic typec daemon for userspace on Linux and there
> isn't always a need for one (i.e. UCSI systems). The kernel has the
> most information about what any given system needs and should be able
> to handle mode entry timing better.
>
> For those motivating factors, I think an in-kernel mode selection as
> designed in this series still makes sense. Let the kernel do the mode
> selection, inform userspace when it is completed and userspace can
> simply set priorities + report success/failure/errors.
> One other change we will probably want to make is to turn the partner
> altmode Kconfig options to boolean and roll it into the typec module.
> Alt-mode module loading breaks mode selection ordering because you
> can't be guaranteed the partner altmodes are loaded on the system when
> you do partner altmode enumeration.

After actually trying to do this today, I think a better approach
might be to just add a MODULE_SOFTDEP for all the typec altmodes. That
way, all the modules get loaded together and there's less of a chance
of waiting for the altmode driver to load when enumerating partners on
boot.

>
> Heikki, can you confirm we are on the same page up till this point at
> least? The net effect here is we are moving partner altmodes
> individually entering modes to centralizing mode entry in the typec
> class itself.
>
> Also, with respect to dropping the mode_selection sysfs node and
> simply using the `active` fields to override:
> * How can we ensure that user space does not race with the kernel mode en=
try?
> * Should we delay exposing "number_of_alternate_modes" until after
> mode selection is done? Should we keep the mode_selection sysfs (or a
> similarly named file) as a read-only indicator of current status?
>
> Thanks,
> Abhishek
>
> > Br,
> >
> > > > I don't believe you can make this approach scale much if and when i=
n
> > > > the future the use cases change. Right now I don't feel comfortable
> > > > with this at all.
> > > >
> > > > thanks,
> > > >
> > > > > This series was tested on an Android OS device with kernel 6.16.
> > > > > This series depends on the 'USB Type-C alternate mode priorities'=
 series:
> > > > > https://lore.kernel.org/all/20250905142206.4105351-1-akuchynski@c=
hromium.org/
> > > > >
> > > > > Andrei Kuchynski (5):
> > > > >   usb: typec: Implement mode selection
> > > > >   usb: typec: Expose mode_selection attribute via sysfs
> > > > >   usb: typec: Report altmode entry status via callback
> > > > >   usb: typec: ucsi: displayport: Propagate DP altmode entry resul=
t
> > > > >   platform/chrome: cros_ec_typec: Propagate altmode entry result
> > > > >
> > > > >  Documentation/ABI/testing/sysfs-class-typec  |  11 +
> > > > >  drivers/platform/chrome/cros_ec_typec.c      |   9 +
> > > > >  drivers/platform/chrome/cros_typec_altmode.c |  32 +-
> > > > >  drivers/platform/chrome/cros_typec_altmode.h |   6 +
> > > > >  drivers/usb/typec/altmodes/displayport.c     |  19 +-
> > > > >  drivers/usb/typec/altmodes/thunderbolt.c     |  10 +
> > > > >  drivers/usb/typec/class.c                    |  37 ++
> > > > >  drivers/usb/typec/class.h                    |   4 +
> > > > >  drivers/usb/typec/mode_selection.c           | 345 +++++++++++++=
++++++
> > > > >  drivers/usb/typec/mode_selection.h           |  25 ++
> > > > >  drivers/usb/typec/ucsi/displayport.c         |  10 +-
> > > > >  include/linux/usb/typec_altmode.h            |  11 +
> > > > >  include/linux/usb/typec_dp.h                 |   2 +
> > > > >  include/linux/usb/typec_tbt.h                |   3 +
> > > > >  14 files changed, 516 insertions(+), 8 deletions(-)
> > > > >
> > > > > --
> > > > > 2.51.0.384.g4c02a37b29-goog
> >
> > --
> > heikki

