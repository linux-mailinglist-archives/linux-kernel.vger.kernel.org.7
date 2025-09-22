Return-Path: <linux-kernel+bounces-827345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3C3B917F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86102A56AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D1A30E0D4;
	Mon, 22 Sep 2025 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5ZdUQEa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A97430E0C6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548709; cv=none; b=DzApxwxq3Xpi0EOKpWDUPNg75Gk6eFhLf9tE/PnznxIvvPjcf9+tsXWQ0QEwOPGKDGFVOuKRnjXFJWpJHSy7zvdy/RzjuDjGuuG7tzpDT9VB8C3ucQjXj/AjlPTar/vFJtP843NCcFzAd8EHGY3Mcf+FqowRFLNNPqAsH6n0mMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548709; c=relaxed/simple;
	bh=yo+GwMmo6IqHg5jSwlrmlB+4Ql115C3OcUJbrFU0ui4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7zhi2kbeWw+2UruA0ROY0s9jxNpx/cPey93cCu8aExe/rsDNRZR1WmG+bP1ZIbYZXFHkGUXhSYm5JlkYrLIOYO0FVIE9rjWuBm64p5bjcBE+VpxhD6EDtW8bRcpbxr/Cu+e6nY0sYdJws1rIYQxS5PPXjh5TX9yUYXvc3/xdGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5ZdUQEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB85C4AF09
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758548709;
	bh=yo+GwMmo6IqHg5jSwlrmlB+4Ql115C3OcUJbrFU0ui4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D5ZdUQEazNRHt4zlCXFkdS8b+eLsfD8zSIsZqIdM05oHpe3fPubctfwEVc4u44UIr
	 yyBIpAElTiJrxVRi8q0IffjelJoVCd8QU5HIwJxxKt9yF8vGcbWNCTJ6RAMkQqiylk
	 y8R86pHNwJ5BZPXrDKjMq2ZsdqRONnUYMrjmI9HFRxYODKn+tUUYJsbcuyJTm2D02W
	 Wme1FeIpGNX5eWxdpIPZS7ieDoyqsl27djoUiQgF/eO6mLA5TcFaTF7A9flRqujqMJ
	 usEPw1c74uJJaS1VDk2Uc8bIHxid7127DdLjDClE3XH+piaktccKe31eWsWmYBp06q
	 +9wgs+RZrVf3g==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74572fb94b3so3152922a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:45:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLzUqdWKmb/YEZYfqV/q9fYDFQHZykys9zp1L6ZV+J0cVQO3rCNoSN2mvtZW31UEj7rGEktwnKhpGtJK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFbiF2WZCENEAfdOoiNc4wdYhyATz0VBKombQ7l9NR8bH7ZNpk
	MjIGIrorUX5aK98LW8t1zWulpUTq79qkJ94rcRE7lu+hBwbtE22be4beFrIF/9pESfee/ZkYF78
	mdH+H/pL4ekkaLrcFTeN4jwrpn59U5Mo=
X-Google-Smtp-Source: AGHT+IE3v9i1z6PMKQVA+qzzJogaf/1oZSw9uCFQPf1C2IPbpzQiamNkuy+/XF5qgJGAVHXGDr6FzelDdqgBbUigq18=
X-Received: by 2002:a05:6808:1822:b0:43f:21bb:32ad with SMTP id
 5614622812f47-43f21bb48acmr605468b6e.17.1758548708575; Mon, 22 Sep 2025
 06:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6204724.lOV4Wx5bFT@rafael.j.wysocki> <3388279.44csPzL39Z@rafael.j.wysocki>
 <875xdaevab.wl-tiwai@suse.de> <CAJZ5v0hSBDg4fD7Gy6yEX31xO-3USJG_jFps71BRJJ2f0Oh90A@mail.gmail.com>
 <87348eobnv.wl-tiwai@suse.de>
In-Reply-To: <87348eobnv.wl-tiwai@suse.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Sep 2025 15:44:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iwNuFxiu3x3-fWO9dkLUq_=c3H=G2OgFmPfVguw0U4Sw@mail.gmail.com>
X-Gm-Features: AS18NWDJpWOsRKJj3jEkl0KecqFPw7RUo_dkS-UdqiA38Sun7bqU2195a6GsOlc
Message-ID: <CAJZ5v0iwNuFxiu3x3-fWO9dkLUq_=c3H=G2OgFmPfVguw0U4Sw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM: runtime: Add auto-cleanup macros for "resume
 and get" operations
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 3:32=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 22 Sep 2025 14:50:32 +0200,
> Rafael J. Wysocki wrote:
> >
> > On Mon, Sep 22, 2025 at 10:38=E2=80=AFAM Takashi Iwai <tiwai@suse.de> w=
rote:
> > >
> > > On Sat, 20 Sep 2025 12:54:58 +0200,
> > > Rafael J. Wysocki wrote:
> > > >
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > It is generally useful to be able to automatically drop a device's
> > > > runtime PM usage counter incremented by runtime PM operations that
> > > > resume a device and bump up its usage counter [1].
> > > >
> > > > To that end, add DEFINE_CLASS() macros allowing pm_runtime_put()
> > > > and pm_runtime_put_autosuspend() to be used for the auto-cleanup in
> > > > those cases.
> > > >
> > > > Simply put, a piece of code like below:
> > > >
> > > >       pm_runtime_get_sync(dev);
> > > >       .....
> > > >       pm_runtime_put(dev);
> > > >       return 0;
> > > >
> > > > can be transformed with CLASS() like:
> > > >
> > > >       CLASS(pm_runtime_get_active, pm)(dev);
> > > >       if (IS_ERR(pm))
> > > >               return PTR_ERR(pm);
> > > >       .....
> > > >       return 0;
> > > >
> > > > (note the new resume error handling).
> > >
> > > Do we still allow the code without the error check even using CLASS()=
?
> > > Although the error check should be handled, it's not mandatory for
> > > now.  That said, the above example could be still in a form like:
> > >
> > >         CLASS(pm_runtime_get_active, pm)(dev);
> > >         .....
> > >         return 0;
> > >
> > > while adding the proper error check is recommended?
> >
> > I'd rather not encourage doing this.
> >
> > While it may still produce working code in some cases, one needs to
> > remember that in case of a runtime resume error it will be running
> > without a runtime PM reference it has attempted to acquire.
>
> Fair enough.  Then it'd be also good to mention that in the
> description, too.

I can also add classes for the cases in which resume errors can be
neglected, like these:

DEFINE_CLASS(pm_runtime_get_sync, struct device *,
         if (_T) pm_runtime_put(_T),
         ({ pm_runtime_get_sync(dev); dev; }), struct device *dev)

DEFINE_CLASS(pm_runtime_get_sync_auto, struct device *,
         if (_T) pm_runtime_put_autosuspend(_T),
         ({ pm_runtime_get_sync(dev); dev; }), struct device *dev)

with a comment explaining what they are for.

