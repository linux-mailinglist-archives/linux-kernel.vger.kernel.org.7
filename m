Return-Path: <linux-kernel+bounces-875821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4586FC19E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3035919C0286
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612562DC76B;
	Wed, 29 Oct 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="A7uXjzai"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E078724293C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734993; cv=none; b=T6YrZBMOPU0wQTkmH+2LAP+7ZRYm8d7pX9rjdg3ml9F+UDRHPouGwaYvfFRlsj3cV94RDXjvXI+v7CKFPkj3OTDRVMUNgk1xTReEQKIuEpAd28Y2HNb/tPZ8IG5WiPew124P1Bqo3qA+4C16wreCImG5vQDAiBHoGhHHnEhlgoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734993; c=relaxed/simple;
	bh=IIq44rl+mr1Wp82ZrLo2CH1EDvG0+UdDllQ256vRX90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kuSC92yxjJoO+VUZMPprU4cX62POdZKBvQY73vohfNVc9lLhLV1HWVzm6H7fx+9IvLMt7mNn3LmblWv4LrGM0NIHqY8yqrs6FTMFIHK5dTPwmsq1o9eOrGIeCxFTG7swLib/RsCfQFIrT6+FPXNZKruuliJwA3OCbdEoLrbLFqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=A7uXjzai; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 2522E425FD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:49:49 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 09BF542609
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:49:48 +0200 (EET)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 2B738200B37
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:49:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761734987;
	bh=YzboKqHz4MGEBiI9ZGSTeK6nDzkE1Vet4xctU+oGO+4=;
	h=Received:From:Subject:To;
	b=A7uXjzai5S7jnzmuF4L0XuuBD3YTjfXWv/4vvmOaNlOFhk0Uy/HDwPR37KEcbZNJX
	 /HzqKDVNq96o/9jQicVz4OEky4yrlMxXPPmoWmIsTaT/f22F3bDDKJ4WPIrfynXbCs
	 AIo6Y1HHX9htAUs1C4JTfaOg64FgfctT1AVjwKUcOwBmBtAfzq3WMSg0BysMzno6q8
	 xkjpTPt8FenzmqgEPKnnKgdIvRVYdzSJdL09rKz+Pr2F6Wd6+b0+s2ypxUqgnyHQpp
	 eZ4mDgu0tz/5Eponi7BzAN5Xv/RetEcxGbRQB3ertwzf2YFnfSgCs5n5uGAHSn4dcI
	 UX0yvOkNkVw4g==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.174) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f174.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-378cfbf83f2so75656421fa.1
        for <linux-kernel@vger.kernel.org>;
 Wed, 29 Oct 2025 03:49:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWHe0jD+gk1JJGjM57MSVr8aMHAF2IPiP0W4OxSSJ51o76u0BH8kRZj5EpEGypbRVPpATtp2AXDef0cF8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfPNf82sTPMJf8psa9KcyOLuHAsbgSzz5u6jQKeU+XT6wmpjtL
	C3jCxqvRSSdrRv7kNKcKGU8NkJv5FYiWPI7nHg1fLctbB+vC/hlzsDefuzmiN5PN9cQUQc9v1vD
	Ih2Vha8XSZPYgmnF4U/jMJZcXBmRShaY=
X-Google-Smtp-Source: 
 AGHT+IGLkcBo2YE6+nk2WVHAihUx5ZgzY8UsQ5edI3i6F2uozYbRe/gYLNU+toxWgQnXlgZRb69N90edzuvtETqFAmY=
X-Received: by 2002:a2e:b894:0:b0:375:d1e4:21e1 with SMTP id
 38308e7fff4ca-37a0537809bmr7537381fa.42.1761734986535; Wed, 29 Oct 2025
 03:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015084414.1391595-1-lkml@antheas.dev>
 <20251015084414.1391595-7-lkml@antheas.dev>
 <38a49942-58d3-49cf-90d7-1af570918ae5@kernel.org>
 <CAGwozwEmjms0H=GPbevuOjJfed6x69wmg8E9begBhUKbF8B2AQ@mail.gmail.com>
 <000cd38e-7052-4987-b5bc-b8de176363cf@kernel.org>
 <CAGwozwFDsn0xm_mG4ypEym=K8c81qqi=qtJL=06nP6SzdFaFoQ@mail.gmail.com>
 <b98a8486-e90a-4bd5-b3a7-3b2ba1b16398@kernel.org>
 <CAGwozwHa3GSNGyRRp4=bR+Wsy2VLgwAbSmcdWb2=5rEyi7jdQw@mail.gmail.com>
 <8f7c2544-2b9d-4997-942a-5bd3ea72e3a3@roeck-us.net>
In-Reply-To: <8f7c2544-2b9d-4997-942a-5bd3ea72e3a3@roeck-us.net>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Wed, 29 Oct 2025 11:49:35 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFNMC+g00LhR+tPsLWPLOiYh0NA0p9yawcunVaMKsNXXw@mail.gmail.com>
X-Gm-Features: AWmQ_bliZI2wVWuas-TjaUUj25C4sBY23d8b5zBjs37RXuHeg5KuBtzdh6q0BdQ
Message-ID: 
 <CAGwozwFNMC+g00LhR+tPsLWPLOiYh0NA0p9yawcunVaMKsNXXw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] platform/x86: ayaneo-ec: Add suspend hook
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
 platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176173498742.2957317.2546813290021562062@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Wed, 29 Oct 2025 at 11:22, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 10/29/25 01:48, Antheas Kapenekakis wrote:
> > On Wed, 29 Oct 2025 at 04:36, Mario Limonciello (AMD) (kernel.org)
> > <superm1@kernel.org> wrote:
> >>
> >>
> >>
> >> On 10/28/2025 4:39 PM, Antheas Kapenekakis wrote:
> >>> On Tue, 28 Oct 2025 at 22:21, Mario Limonciello <superm1@kernel.org> wrote:
> >>>>
> >>>> On 10/28/25 3:34 PM, Antheas Kapenekakis wrote:
> >>>>>>> The fan speed is also lost during hibernation, but since hibernation
> >>>>>>> failures are common with this class of devices
> >>>> Why are hibernation failures more common in this class of device than
> >>>> anything else?  The hibernation flow is nearly all done in Linux driver
> >>>> code (with the exception of ACPI calls that move devices into D3 and out
> >>>> of D0).
> >>>
> >>> I should correct myself here and say hibernation in general in Linux
> >>> leaves something to be desired.
> >>>
> >>> Until secure boot supports hibernation, that will be the case because
> >>> not enough people use it.
> >>
> >> The upstream kernel has no tie between UEFI secure boot and hibernation.
> >>    I think you're talking about some distro kernels that tie UEFI secure
> >> boot to lockdown.  Lockdown does currently prohibit hibernation.
> >>
> >>>
> >>> I have had it break for multiple reasons, not incl. the ones below and
> >>> the ones we discussed last year where games are loaded.
> >>>
> >>> For a few months I fixed some of the bugs but it is not sustainable.
> >>>
> >>>> Perhaps you're seeing a manifestation of a general issue that we're
> >>>> working on a solution for here:
> >>>>
> >>>> https://lore.kernel.org/linux-pm/20251025050812.421905-1-safinaskar@gmail.com/
> >>>>
> >>>> https://lore.kernel.org/linux-pm/20251026033115.436448-1-superm1@kernel.org/
> >>>>
> >>>> https://lore.kernel.org/linux-pm/5935682.DvuYhMxLoT@rafael.j.wysocki/T/#u
> >>>>
> >>>> Or if you're on an older kernel and using hybrid sleep we had a generic
> >>>> issue there as well which was fixed in 6.18-rc1.
> >>>>
> >>>> Nonetheless; don't make policy decisions based upon kernel bugs.  Fix
> >>>> the kernel bugs.
> >>>
> >>> My problem is I cannot in good conscience restore a fan speed before
> >>> the program responsible for it is guaranteed to thaw.
> >>>
> >>> The best solution I can come up with would be in freeze save if manual
> >>> control is enabled, disable it, and then on resume set a flag that
> >>> makes the first write to fan speed also set pwm to manual.
> >>>
> >>> This way suspend->hibernate flows, even if hibernation hangs when
> >>> creating the image, at least have proper fan control because they are
> >>> unattended, and resume hangs work similarly.
> >>>
> >>> Antheas
> >>>
> >>
> >> This sounds like a workable approach for what I understand to be your
> >> current design; but let me suggest some other ideas.
> >>
> >> What happens if you're running something big and the OOM comes and
> >> whacks the process?  Now you don't have fan control running anymore.
> >>
> >> So I see two options to improve things.
> >>
> >> 1) You can have userspace send a "heartbeat" to kernel space.  This can
> >> be as simple as a timestamp of reading a sysfs file.  If userspace
> >> doesn't read the file in X ms then you turn off manual control.
> >
> > The OOT scenario is something I have not handled yet specifically, or
> > have had happen.
> >
> > Systemd will restart the service in the case of OOT after 5 seconds
> > and in the case of a crash there are multiple fallbacks to ensure the
> > custom curve turns off.
> >
> > Most of the hibernation hangs that I have experienced happen before
> > journalctl turns on, so I assumed that it's before userspace
> > unfreezes. I am also not sure if restore() gets to run in those cases
> > or not.
> >
> > Re: heart beat, read below.
> >
> >> 2) You move everything to a kthread.  Userspace can read some input
> >> options or maybe pick a few curve settings, but leave all the important
> >> logic in that kthread.
> >
> > I think this is what Luke tried to do with the Zotac Zone. But in the
> > end, the kernel is limited to what calculations it can do, esp.
> > floating point and what it can access, so you end up with a worse
> > curve with limited extendability, and a driver specific ABI. And we
> > also risk duplicating all of this code on hwmon drivers and making it
> > harder to access.
> >
> > I think part of this reason is why the platform side of the Zotac
> > stuff has not been upstreamed, even though the driver itself other
> > than that is pretty straightforward with an established ABI by now.
> > And it is also the reason we have not been able to add the module to
> > Bazzite, because 1) we cannot validate the new fan curve calculations
> > without a device and 2) they are worse that what we provide through
> > userspace (a polynomial ramp-up which embeds hysteresis to avoid
> > jittering, plus choice for both Edge and Tctl sensors).
> >
> > In summary, I think there would great potential for a common set of
> > "hwmon" helpers that can use a temperature function and a speed set
> > function to handle a basic multi-point curve for basic, e.g., udev
> > use-cases. To that end, there could be a helper with a 5 second
> > timeout that turns off the custom speed. But it would be good for that
> > to be implemented globally, so it does not block device hw enablement.
> >
>
> Maybe I misunderstand. If so, apologies.
>
> Thermal _control_ is what the thermal subsystem is for. hwmon is for
> hardware monitoring, not control. You may do whatever you like
> in platform drivers, including the duplication of termal subsystem
> functionality, but please do not get hwmon involved. That includes
> any kind of helpers to compute any kind of temperature curves.

I have no preference for which subsystem these helpers are placed if
implemented. But if thermal handlers are implemented they need to be
global. This includes timeouts for manual control and basic fan curves
(for which the ABI belongs to hwmon).

I cannot make manufacturer specific workarounds for X platform 6 point
curve because it was determined XYZ this and that, when the
manufacturer provides direct control.

Speaking of which, what is the policy for hwmon when it comes to
settings after hibernation. I am being asked to add a restore hook for
hwmon settings here, but other relevant drivers do not have it
(asuswmi, gpdfan, oxpec), is a new requirement for hwmon?

Antheas

> Thanks,
> Guenter
>
>


