Return-Path: <linux-kernel+bounces-824997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD59B8AAA9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86921CC4148
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD616321446;
	Fri, 19 Sep 2025 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FZISoM7u"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC42E22A4F1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301102; cv=none; b=ll6eWAxpEvtUVXVQXwX5hBfJ/xuvfGW446mxv1PyJtQNbV5pjIWzOVw643ayQgWbNY/slFJHUtuwgt+a9Xs7HLKDVsrSqaWMQn0E9W+SJ5p3GZseiHBjfwjvFpZmqKqPZ2ek+lnSybvlCl1TKkV4is3XVhtJ7K6lq78KLQe2e18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301102; c=relaxed/simple;
	bh=vwPs42kf8g2pCVsnD1ZDpG2I0ww3zMPGMcvtxc0/JDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEZJN64Whkd00IFEJI95AzP6BATc54rmUpl31ZlmZ5Vj4kJcmZX55vqyrUgeDmT7yNAdiofJLjBBTkr7qFzW/1gnBkyB0KSl8O9bNavphIkQpgd5+kMtCw0ubWYNkWPzT1PzvoZ+mynmeyt2dL3YzotHxwOSDdyav2GMJmpLRwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FZISoM7u; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d60501806so18800317b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758301100; x=1758905900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwPs42kf8g2pCVsnD1ZDpG2I0ww3zMPGMcvtxc0/JDE=;
        b=FZISoM7uNS56FpzgPX+IBw86nFSix2CVfF07XGXYq0QuLhIloRCQ3f4OTroV1Z1n4W
         pv6uSI/zsxVx3w5TKc/s59ATzGEeYw0noM4Tj/885uYHY4sikQmkNdi/KAnZUw/XVB0A
         nwrJhUQkvoE+eMR5Hy0markDpX3+O807EV77o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758301100; x=1758905900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwPs42kf8g2pCVsnD1ZDpG2I0ww3zMPGMcvtxc0/JDE=;
        b=pMmy8ndc6z7+0RomQzYg8e2RLk1yFTzrQVS18hFrNu+JAhwpLF0prxxAebb4vdNbMx
         PhVcRIx7/tDb3UPEKqracWLZKCBQ8C7LWst2oAnb6oz9W34gsctqXYQCFXFZkSXzIroN
         atBaPwozRAtNyvw/WkH5S0UwRE9NltyU0aYkfb38O2h5aNMlIsIbnmakTkW5BL5Z6CCT
         5RLOFQyFCpuSliSF8ykRLPxTaRM+2Ru2+7xYaP4Jh8AjjFEiN5ReBbqdToxSNO0p66wj
         hm0wTQIITqzxxMjOsUY2Bu4Mlusp7xiDDSf3rSxd3BWLN4Dg7SPG8ylExYAt1+1Z6TVr
         JoTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi8aGsAIT2Ah6lorm95f5/85CXwFfLoVfxDSi4QCRumGhF6eAdTc+QF7yomWtt+VOqJAnMA3Ap9bEdZ84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7K/1TTXzi2ORouJaNPU7YWucE4d4fFMuyBzsMFXpFyhPpr5t
	Diae7NQ1xLFR5Bgu2JqgGJapK+STgTke/jlwMtbkxtTHUK8a/4WajfmVdUlZzxFEL+OoamaCbsy
	bUjvgHxs/9sCmV975YZsWX+SXoykcB867paeVWTQU
X-Gm-Gg: ASbGnctWMHGaLgVlPsiS670PtgW53TVkEpnF4DrB3kQO17qP7IKaMJOH0HfBMvzWHPO
	eSwPzTcNsyLrT1s+V/2Q8A1ND3y4IpRHumPIQdS86PH0nqkPUDFvzt14vMvyJ+xYNKVmhD8hS1Q
	PYJCiYpz6VMU3rFiwMjoaqjYoOfKq6GQc1UguHdYArAUt0yykfC+2p9bOPQzzoPDg8aDT792lWN
	2/HsBE=
X-Google-Smtp-Source: AGHT+IH5CLNTqdnY5u1hL0wkGAKr07Ad6aD0TIQLESSabxq0lt3rrTBbtShCtrtTQ6VSqbE220X6ZJw2JK0cT7g70lY=
X-Received: by 2002:a05:690c:4b0e:b0:733:8609:d9e6 with SMTP id
 00721157ae682-73d3237f3d8mr38788377b3.11.1758301099806; Fri, 19 Sep 2025
 09:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909123028.2127449-1-akuchynski@chromium.org>
 <aMliLCWFKy5Esl0-@kuha.fi.intel.com> <CANFp7mXvpNXr=01nQR54d+Z+vSiiwiDLB+3B+1eR6Ks7b37gtg@mail.gmail.com>
 <aMqpe68m3rhDYsCt@kuha.fi.intel.com> <CANFp7mWk_TuA6Gxbtc8OmB7eq_vT8wUg=xkPJsxLCBTrQwOd6A@mail.gmail.com>
 <aM1DmJQz2PnEA6G_@kuha.fi.intel.com>
In-Reply-To: <aM1DmJQz2PnEA6G_@kuha.fi.intel.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Fri, 19 Sep 2025 09:58:05 -0700
X-Gm-Features: AS18NWC-1pC_IRBqdpH5kjLCyCle93KXt_Xal4jsqNO_s2Q50R8iEAsW5sMteJU
Message-ID: <CANFp7mUDVPLja2QANYhJ2t6W9yPE7-qV8E2HTPHcJEYgOb8s2Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] USB Type-C alternate mode selection
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andrei Kuchynski <akuchynski@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 4:50=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Wed, Sep 17, 2025 at 10:51:11AM -0700, Abhishek Pandit-Subedi wrote:
> > On Wed, Sep 17, 2025 at 5:28=E2=80=AFAM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 09:47:44AM -0700, Abhishek Pandit-Subedi wrot=
e:
> > > > On Tue, Sep 16, 2025 at 6:12=E2=80=AFAM Heikki Krogerus
> > > > <heikki.krogerus@linux.intel.com> wrote:
> > > > >
> > > > > On Tue, Sep 09, 2025 at 12:30:23PM +0000, Andrei Kuchynski wrote:
> > > > > > This patch series introduces a flexible mechanism for USB Type-=
C mode
> > > > > > selection, enabling into USB4 mode, Thunderbolt alternate mode,=
 or
> > > > > > DisplayPort alternate mode.
> > > > > >
> > > > > > New sysfs `mode_selection` attribute is exposed to provide user=
 control
> > > > > > over mode selection. It triggers an alternate mode negotiation.
> > > > > > The mode selection logic attempts to enter prioritized modes se=
quentially.
> > > > > > A mode is considered successfully negotiated only when its alte=
rnate mode
> > > > > > driver explicitly reports a positive status. Alternate mode dri=
vers are
> > > > > > required to report their mode entry status (either successful o=
r failed).
> > > > > > If the driver does not report its status within a defined timeo=
ut period,
> > > > > > the system automatically proceeds to attempt entry into the nex=
t preferred
> > > > > > mode.
> > > > >
> > > > > I'm still struggling to understand what is the benefit from this =
- why
> > > > > would you want the user space to explicitly start the entry proce=
ss
> > > > > like this? Instead why would you not just take full control over =
the
> > > > > alt modes in user space by enabling the them one by one in what e=
ver
> > > > > order you want?
> > > >
> > > > I think after the many patch iterations we went through upstreaming=
,
> > > > we may have lost the point a little bit wrt/ the mode selection tas=
k.
> > > > We talked about this on the very first iteration of this patchset
> > > > here: https://lore.kernel.org/linux-usb/CANFp7mVWo4GhiYqfLcD_wFV34W=
MkmXncMTOnmMfnKH4vm2X8Hg@mail.gmail.com/
> > > >
> > > > The motivation behind it was to allow the kernel driver to own mode
> > > > selection entirely and not need user space intervention. The curren=
t
> > > > alt-mode drivers attempt to own the mode entry process and this fai=
ls
> > > > when you have two or more altmode drivers loaded (i.e. displayport,
> > > > thunderbolt). The original goal of the mode selection task was to m=
ove
> > > > the mode entry decision away from the alt-mode driver and to the po=
rt
> > > > driver instead.
> > > >
> > > > What's missing in the current patch series to show this is probably
> > > > actually calling mode_selection once all partner modes are added :)
> > > > Andrei should be adding that to this patch series in the next patch
> > > > version.
> > > >
> > > > Adding the mode_selection sysfs trigger is for another reason: to
> > > > re-run mode selection after priorities have been changed in userspa=
ce
> > > > and there is no partner hotplug. We specifically have some security
> > > > policies around PCI tunnels that result in the following need:
> > > > * When we enable pci tunneling, we PREFER tbt over dp and would lik=
e
> > > > to select the preferred mode. When we disable it, we PREFER dp over
> > > > TBT and would like to select the preferred mode.
> > > > * When users are logged out, we always prefer DP over TBT.
> > > > * When the system is locked, we prefer DP over TBT for new connecti=
ons
> > > > (but existing connections can be left as TBT). When we unlock, we w=
ant
> > > > to enter the most preferred mode (TBT > DP).
> > > >
> > > > While this is do-able with the alt-mode active sysfs field, we woul=
d
> > > > basically be re-creating the priority selection done in the kernel =
in
> > > > user space again. Hence why we want to expose the mode selection
> > > > trigger as done here.
> > >
> > > But this would be a step backwards. You want to keep the kernel in
> > > control of the mode selection, which is fine, but then you have these
> > > special cases where you have to give some of the control to the user
> > > space. So instead of taking complete control of the mode selection in
> > > user space, you want to create this partial control method of
> > > supporting your special cases while still leaving "most" of the
> > > control to kernel.
> > >
> > > I don't believe this will work in all cases. I'm fine with the
> > > priority as a way to tell the kernel the preferred entry order, but i=
f
> > > the user space needs to take control of the actual mode selection, it
> > > has to take full control of it instead of like this, partially. This
> > > just looks incredibly fragile.
> > >
> > > So I'm still not convinced that there is any use for this. Either the
> > > user space takes over the mode selection completely with the active
> > > attribute files, or just leaves the selection completely to the kerne=
l.
> > >
> >
> > That's a fair stance to take. We CAN do our special cases via the
> > "active" sysfs node. I've had a bit more time to think about the
> > problem we are solving and I'd like to elaborate a little.
> >
> > When we designed this mode selection task, there were two motivating fa=
ctors:
> > * The existing typec_displayport and typec_thunderbolt modules will
> > both automatically try to enter a mode when probing and that does not
> > work well. You want a deterministic entry order.
> > * There is no generic typec daemon for userspace on Linux and there
> > isn't always a need for one (i.e. UCSI systems). The kernel has the
> > most information about what any given system needs and should be able
> > to handle mode entry timing better.
> >
> > For those motivating factors, I think an in-kernel mode selection as
> > designed in this series still makes sense. Let the kernel do the mode
> > selection, inform userspace when it is completed and userspace can
> > simply set priorities + report success/failure/errors.
> > One other change we will probably want to make is to turn the partner
> > altmode Kconfig options to boolean and roll it into the typec module.
> > Alt-mode module loading breaks mode selection ordering because you
> > can't be guaranteed the partner altmodes are loaded on the system when
> > you do partner altmode enumeration.
> >
> > Heikki, can you confirm we are on the same page up till this point at
> > least? The net effect here is we are moving partner altmodes
> > individually entering modes to centralizing mode entry in the typec
> > class itself.
>
> I think we are on the same page, but I don't think you can incorporate
> the entry of the modes into the class itself (you should not do that).
> You can't even make it a problem for the altmodes - I don't believe we
> can make it work in the long term.

It probably needs to be a port driver decision. UCSI based systems
will mostly expect that a mode has already been entered after a
partner connects (and reports the SUPPORTED_CAM_CHANGED bit in
Connector Status Change) but with UCSI 3.0, some systems could
potentially make this decision in kernel (via sending SET_NEW_CAM
<connector> 0xff 0 which would prevent the PPM/LPM from entering any
modes automatically). Even with cros_ec_typec, only devices supporting
TBT/USB4 will need a mode selection decision in the port driver (since
others just auto-enter DP).

>
> Here multiple modes need to be handled as a set, so the set itself
> needs to have an object that represents it. The altmodes will be part
> of these "sets", but they remain independent of any particular set.
> So the "set" defines the order in which the modes are entered instead
> of the class, or any individual altmode.
>
> I don't think there is any other way to make sure that the altmodes
> continue to work as well independently as part of these "sets".
>
> If you guys think that this makes sense, let me know. There are a
> number of ways we could implement this.

The idea you've described here of sets sounds like what this patch
series hopes to implement. The set is just all the partner altmodes
which the port supports and the ordering is the port priority for
those altmodes.

>
> > Also, with respect to dropping the mode_selection sysfs node and
> > simply using the `active` fields to override:
> > * How can we ensure that user space does not race with the kernel mode =
entry?
> > * Should we delay exposing "number_of_alternate_modes" until after
> > mode selection is done? Should we keep the mode_selection sysfs (or a
> > similarly named file) as a read-only indicator of current status?
>
> Races are definitely a concern. But I don't think that is a problem if
> we go ahead with the above idea of separating the mode relationships
> and entry into those "mode sets".

Is the idea to give userspace the ability to create a set and try to
enter atomically? Who decides what constitutes a set?

>
> Br,
>
> --
> heikki

