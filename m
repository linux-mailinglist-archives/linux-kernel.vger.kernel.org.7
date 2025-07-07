Return-Path: <linux-kernel+bounces-720305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB00AFBA0A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CF807A8B5E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE72A289E0F;
	Mon,  7 Jul 2025 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLmxcglj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6132253BC
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751910128; cv=none; b=Fk3ggWgE8nS9mqDj+IxxjIEZY5ZqisRiVGf9WnRJ8TU62naOFbA4vzbOtNonxi82eWxxUbf/pfmDUGVy2RuU9RF9P+D7BKegRh/oN3DK8M1Z9lWcwjxwAbv5MPNRE7dBLRYb/nskAeNEdjyfKIQymfdEn2vgne6OTRGA9KO2Byw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751910128; c=relaxed/simple;
	bh=JjcFyRrahTR3lql/P+Aw5X6u9lYKjBOawoYq6NWUrgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUsaDE+jWI+2QdtGN51ze6WuY/GaptX6T/Mk737fgUkxcEt+fCZUxzJ6xNQsIg0bxXtHvL9Z38b9zH54Gsxr+pnVeaBo87OVW396vMKqAM6O+qJeJqLyUcJjTJAfQAsJnSAiksn3la+IwxjLLxGkedLzOkQd2A797np8dGp7DEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLmxcglj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD75CC4CEF1
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 17:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751910127;
	bh=JjcFyRrahTR3lql/P+Aw5X6u9lYKjBOawoYq6NWUrgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KLmxcgljqZJJuWHIQdNWYp32nG1VdWTucoUweH91V/3vZ8ibazhQjvbh3hPwzM9HS
	 wgWdaOd1x0PPUpbxdOgvqeNz9ZF3wuJ0WU4Kh5OU+e5uzNO5LtIRURfLqInHpO5JAy
	 uV1hcUcTRY+L4N2WcoEOQ3Jz+zBfIsLSY1ZuSjKBEgGsyVnzzYq48/Ev7E3ghqdfcr
	 P8Eai1maaSwnei4/fKdyeGDm3Zg+sbII7WHHogV/G5bRmrkTsEBrYy+mV9GF0hpfpN
	 /Iksiv3rdwxF8US0urxy7dlIGDx4nRTGp+Ar4btEphEtEnSOL5sJlVranTWVXRrYPa
	 z2lUayafJ4r5Q==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso6064368a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 10:42:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YxJ0KSV0w11AwshK5iXcCsrH5uCXOmVxzSrbQKtoatEuZrBxpUp
	3h3AkIpWWjJ4OcpQA5XQwXSHZKyyYDXwiVkLX1kili3qbCRv8XxZDLD3zn7I+CDS7h03j/5LAXB
	XMVe18xHxI2QHHTZxJ8EMzQ3QsuuYDg==
X-Google-Smtp-Source: AGHT+IHTcM0JnByHeq4MedyhnFwe4AFxPnH7yKd9fTihgH8Pzvw2kSQALvXe0x4/H1xWzMllpvEn2C30/rLvA9N9Py4=
X-Received: by 2002:a17:907:d7cc:b0:ad5:4806:4f07 with SMTP id
 a640c23a62f3a-ae6b0049633mr12678366b.2.1751910126238; Mon, 07 Jul 2025
 10:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613130356.8080-1-james.morse@arm.com> <20250613130356.8080-3-james.morse@arm.com>
 <CAL_Jsq+rsBq1Dsw4+hfkMhopN9Pdwyp9JJbqeT6yB+d++s4v7g@mail.gmail.com>
 <ee08ba7e-2669-447f-ae04-5a6b00a16e77@arm.com> <CAL_Jsq+mXkQTM-zbozPGkCQ40CusOUudWgtaxx_ufqL+0t96mQ@mail.gmail.com>
 <642f2fa8-cd61-47ed-9d63-a15de263d36d@arm.com>
In-Reply-To: <642f2fa8-cd61-47ed-9d63-a15de263d36d@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 7 Jul 2025 12:41:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJXPCZ+2SpFHemGw_AbOVRncN=jxp9ewCDm=XeJeTWegw@mail.gmail.com>
X-Gm-Features: Ac12FXzxO3KqSyYuZVqJZt4aWPXxn7EfT1o9rzq3q7UL-u1Cceph7Eobu-DlXQw
Message-ID: <CAL_JsqJXPCZ+2SpFHemGw_AbOVRncN=jxp9ewCDm=XeJeTWegw@mail.gmail.com>
Subject: Re: [PATCH 2/5] cacheinfo: Add arch hook to compress CPU h/w id into
 32 bits for cache-id
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, sudeep.holla@arm.com, 
	Ben Horgan <ben.horgan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 12:39=E2=80=AFPM James Morse <james.morse@arm.com> w=
rote:
>
> Hi Rob,
>
> On 30/06/2025 20:43, Rob Herring wrote:
> > On Fri, Jun 27, 2025 at 11:38=E2=80=AFAM James Morse <james.morse@arm.c=
om> wrote:
> >> On 23/06/2025 15:48, Rob Herring wrote:
> >>> On Fri, Jun 13, 2025 at 8:04=E2=80=AFAM James Morse <james.morse@arm.=
com> wrote:
> >>>> Filesystems like resctrl use the cache-id exposed via sysfs to ident=
ify
> >>>> groups of CPUs. The value is also used for PCIe cache steering tags.=
 On
> >>>> DT platforms cache-id is not something that is described in the
> >>>> device-tree, but instead generated from the smallest CPU h/w id of t=
he
> >>>> CPUs associated with that cache.
> >>>>
> >>>> CPU h/w ids may be larger than 32 bits.
> >>>>
> >>>> Add a hook to allow architectures to compress the value from the dev=
icetree
> >>>> into 32 bits. Returning the same value is always safe as cache_of_se=
t_id()
> >>>> will stop if a value larger than 32 bits is seen.
> >>>>
> >>>> For example, on arm64 the value is the MPIDR affinity register, whic=
h only
> >>>> has 32 bits of affinity data, but spread across the 64 bit field. An
> >>>> arch-specific bit swizzle gives a 32 bit value.
> >>
> >>> What's missing here is why do we need the cache id to be only 32-bits=
?
> >>> I suppose it is because the sysfs 'id' file has been implicitly that?
> >>
> >> Yup, and its too late to change.
> >>
> >>
> >>> Why can't we just allow 64-bit values there? Obviously, you can't hav=
e
> >>> a 64-bit value on x86 because that might break existing userspace.
> >>
> >> It's the same user-space. Users of resctrl should be portable between =
architectures.
> >> Resctrl isn't the only user, of the cache-id field.
> >>
> >>
> >>> But for Arm, there is no existing userspace to break.
> >>
> >> libvirt: https://github.com/libvirt/libvirt/blob/master/src/util/virre=
sctrl.c#L1588
> >
> > Looks to me like AMD wasn't even supported til v10.8.0 (2024-10-01)[1].
>
> 'when mounted with [a particular option]'
>
> AMDs bandwidth controls count in 1/8ths of 1GB/s - and you have to know y=
ou're running on
> an AMD machine. I'm aiming for the arm64 support to be portable between I=
ntel and RISC-V.
>
>
> >> DPDK: http://inbox.dpdk.org/dev/20241021015246.304431-2-wathsala.vitha=
nage@arm.com/
> >
> > Is that even applied yet?
>
> No idea, but its equally likely that I haven't found all the places this =
gets parsed by
> user-space. I don't think we have a way of telling people using stable-ke=
rnels that we
> might change the size of that field. It's pretty clear people don't antic=
ipate it changing!
>
> This is just the downside of exposing anything to user-space!
>
> [...]
>
> >>> It is obviously nice
> >>> if we can avoid modifying userspace, but I don't think that's a
> >>> requirement and I'd be surprised if there's not other things that nee=
d
> >>> to be adapted for MPAM support.
> >>
> >> The whole multi-year effort has been to make existing user-space work =
without any ABI
> >> changes. The effect is some platforms have features that can't be used=
 because resctrl
> >> expects things to be Xeon shaped.
> >> But if your platform looks a bit like a Xeon (cache portion controls o=
n the L3, memory
> >> bandwidth controls somewhere that is believably the L3), then resctrl =
works as it does on
> >> Intel. The only thing that has come a little unstuck is the 'num_rmid'=
 property where MPAM
> >> doesn't have an equivalent, so '1' is exposed as a safe value.
> >
> > Fair enough, but I'd be rather surprised if there doesn't end up being
> > changes to support Arm platforms.
> >
> >>> Also, what if an architecture can't swizzle their value into 32-bits?
> >>> They would be stuck with requiring userspace to deal with 64-bit
> >>> values.
> >>
> >> Remap them in a more complicated way. Chances are there aren't 2^32 CP=
Us.
>
> > What about using the logical CPU number instead? That's stable for a
> > given machine and firmware.
>
> Hmmm, if you offline CPU-0 then kexec, then CPU-1 becomes the new CPU-0 a=
nd the numbers
> get doled out differently.

Ah, I thought they were more stable than that, but indeed there's a
special case for the boot CPU.


> > And then instead of having 3 sets of
> > numbers (MPIDR, compressed MPIDR, and logical CPU), we'd still only
> > have 2. And logical CPU is what sysfs already exposes to userspace.
>
> I don't think the linux allocated CPU number is robust enough.
>
> We could use the CPU number as seen when walking through the DT to make i=
t stable, but
> that would still be a third type of number. It would save the arch hook t=
o swizzle the
> bits, but changing the DT would change the numbers which doesn't happen w=
ith this scheme.
>
> Let me know if that is what you prefer.
> (I'll summarise this on the cover-letter/patch-1 of the incoming series)

Let's leave it with what you have...

Rob

