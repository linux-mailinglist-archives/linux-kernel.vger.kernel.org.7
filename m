Return-Path: <linux-kernel+bounces-880131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC10CC24F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BB13AC97E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111BF347BCC;
	Fri, 31 Oct 2025 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="XMxT3c6c"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A1921420B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912845; cv=none; b=bdS+X5tB4ZgR2SbnYEK0vLEOiZHPd8ZE7fltNuqnlPFxMqDiKT6XzlTP33U7AEuZglsmoiSn1pqTjzSORxNZgbEO0Jd6GmJPciLPKo3OXRUZg2UxsMFoBs48Ro0JOzGqzAF+jPtxVzdn4mdedB7NeAAmeME16Wnm4PC8P9igkAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912845; c=relaxed/simple;
	bh=KAsRDWgv2NXfZ3B+X8i2YPvusK0gxuSGNIOhrjdxmG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAvZKj/pgFVfIkkgLwZ1tVsBmLQ20I87lPkzJEBw5lKjRBqDODKQQ3l5d3TVcPp3cpk1/vJXrcrQFha4Nh40GCm5yLV0heqfi+G2YZe4CShDP03Xm3T6XEaAOVmSlZR+MAJx/wG3f8qqE+sfqHap9Fb3Yi6PozeRotNXTFtRb6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=XMxT3c6c; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id E89024603F
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:13:55 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 1FBCE45F8E
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:13:55 +0200 (EET)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 3628D200A8C
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:13:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761912834;
	bh=XDLMqD7nEFshp2WG4Ildq72xmi2MAqdYc3+r4s9+n3I=;
	h=Received:From:Subject:To;
	b=XMxT3c6cYq/np081G8OluK7vC3c31RmDeMsO8A1vL033VcbVf7l5vjlKPsi/wULMP
	 o0ucaRJYs/IEAcDSbjg0PjzskF9A5WpUB8yzmajFukZltcCYfJdfdCqKCd6roVOFLd
	 mwvKhLVjL16CIaSgfBrbmsouGl+jw3wK8Yg9Ji0Uii5Qjh1hdjzYk80KpDdMaNZ/Du
	 UbIfT5oxyrgzZavajfdT365RHWPfHh0PMsZ0TqxjCXtSN9I3FlkxpLCzx0GgBOzduM
	 jQNGhoPowdyazIjbvmvP8eUyp4mKnwlKZU9VA+wHAdf46h/TQT2lNs2YIHqekzt0c6
	 zTHkkqkjEbZoQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.169) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f169.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-36d77de259bso15165951fa.3
        for <linux-kernel@vger.kernel.org>;
 Fri, 31 Oct 2025 05:13:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWzhUK68xiaHLD7Fg9YLn8mbNAOh/cRyb5PoUmirBsYc9WbrT5xDFFRvFZilxc+/y6ihY/4oxc8vC4+OtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJs94FkpQFX5NMryArrBcIun9HQg1cE/jPF5FUpb9MU9UiNUIY
	Rr/cnKcgKumfpNdSGZp4GPDrr6zM249wHwLJ8lCO7ELIkCsCi2ZY9ABEoFrFddz0bf1LNVBCHcq
	nzOC9L5JssI1tvXGKh1Ll4aabWGsA69M=
X-Google-Smtp-Source: 
 AGHT+IHLvg+QVKJLRgPQGaJgLJOka5UXPrAEhFAvF8BSPVZ7o3I8EUXF/J/4/XYlnPpyRCbSAkYX/I4BHhW+qLfd2Gs=
X-Received: by 2002:a05:651c:19a1:b0:360:e364:bb3d with SMTP id
 38308e7fff4ca-37a18cf70a1mr12519561fa.0.1761912833609; Fri, 31 Oct 2025
 05:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018101759.4089-6-lkml@antheas.dev>
 <202510222013.EBLC609m-lkp@intel.com>
 <CAGwozwGDBj2e83JBW71G_z6hMD5PsOXTQLqFVdPKZ6sU54tsGw@mail.gmail.com>
 <39n24387-0o0n-50p8-s2rn-9qoqs6sq8336@xreary.bet>
In-Reply-To: <39n24387-0o0n-50p8-s2rn-9qoqs6sq8336@xreary.bet>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 31 Oct 2025 13:13:42 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFgd91n2HnHn0VEL3BTGkj8QCRnp2jfCsMB38JqK8znNg@mail.gmail.com>
X-Gm-Features: AWmQ_blJS4pzpONNbJGbKFFyV7UhrXL_Gbz5apymTl2RdEt79wy1YgZX4ddGWr4
Message-ID: 
 <CAGwozwFgd91n2HnHn0VEL3BTGkj8QCRnp2jfCsMB38JqK8znNg@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] platform/x86: asus-wmi: Add support for multiple
 kbd led handlers
To: Jiri Kosina <jikos@kernel.org>
Cc: kernel test robot <lkp@intel.com>, platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>,
	Corentin Chary <corentin.chary@gmail.com>,
 "Luke D . Jones" <luke@ljones.dev>,
	Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Denis Benato <benato.denis96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176191283453.2961612.7360718649353961438@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 31 Oct 2025 at 09:27, Jiri Kosina <jikos@kernel.org> wrote:
>
> On Thu, 23 Oct 2025, Antheas Kapenekakis wrote:
>
> > >   1589
> > >   1590  static void kbd_led_update_all(struct work_struct *work)
> > >   1591  {
> > >   1592          enum led_brightness value;
> > >   1593          struct asus_wmi *asus;
> > >   1594          bool registered, notify;
> > >   1595          int ret;
> >                               /\ value should have been an int and
> > placed here. It can take the value -1 hence the check
>
> Thanks, that needs to be fixed before the final merge.
>
> > Are there any other comments on the series?
> >
> > The only issue I am aware of is that Denis identified a bug in asusd
> > (asusctl userspace program daemon) in certain Asus G14/G16 laptops
> > that cause laptop keys to become sticky, I have had users also report
> > that bug in previous versions of the series. WIthout asusd running,
> > keyboards work fine incl. with brightness control (did not work
> > before). Given it will take two months for this to reach mainline, I
> > think it is a fair amount of time to address the bug.
>
> One thing that is not clear to me about this -- is this causing a visible
> user-space behavior regression before vs. after the patchset with asusctl?
>
> If so, I am afraid this needs to be root-caused and fixed before the set
> can be considered for inclusion.

Commit 591ba2074337 ("HID: asus: prevent binding to all HID devices on
ROG") adds HID_QUIRK_INPUT_PER_APP and the extra devices seem to
confuse asusd. Since the devices are the same as with hid-asus not
loaded, it is specific to that program.

We can delay that patch until Denis who took over maintenance of the
program can have a deeper look. I will still keep the last part of
that patch that skips the input check, because that causes errors in
devices that do not create an input device (e.g., lightbar).

Antheas

> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
>


