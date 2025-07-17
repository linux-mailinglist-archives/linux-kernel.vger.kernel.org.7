Return-Path: <linux-kernel+bounces-735610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEED9B0918A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383A9188A304
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AB02FBFE4;
	Thu, 17 Jul 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PSgMAeAA"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C1C2C9
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769069; cv=none; b=PgRF8Rb424azmWqWr4ovzvtfURO0htrcLFkp25iCKlZPTTYGE38CgW+jkCohhNKwRxk5J+jmMtIotdnIQUO8o4R4I1chr8zxdUoAtUSuPkwvf1JEMrAIB6E+Wi09lEacGwtyih2v/tm5MGb0RZpfcSg+8Gk/ksY1fwQJ9zvQkRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769069; c=relaxed/simple;
	bh=4Y/RjTkTJBG1lcOSM/R+PpjsJ58T7Ydi95mMf2enko8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwXaUtksZAi+2QO6tu3sP+T5gLwQz31boCROVcmn8IQ6b2SsRknICa/0MbsdP8U4RO4qbOPw3VkN56J3BrKDlbdZgUllL1w8V/Y2hu/7R1O3Dhj1DOu1xoL3VVRFQGCiHgT+pCsy2a2Q33LtqUcX6yUWHTdmHasnXaGxf2JFPmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PSgMAeAA; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553b5165cf5so1390878e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752769066; x=1753373866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Y/RjTkTJBG1lcOSM/R+PpjsJ58T7Ydi95mMf2enko8=;
        b=PSgMAeAAPc/Jl5L/MBOijdfKvVN+tZfTwfp/3VWA+7jBRL6t16zbHUK0bnoIKic4o7
         PDfdfrfWYz1RPznBcg+ueghDLZpq9RyMrV4oqQDHG4uj79XiYBN9kprUKE0v/jpzSMfw
         GK5F6JVAmLaumy9iqEYwMrwrsQ5UfmuWPJtVs3HGf7WwygGYu5DGzC3ygrVf2TEnP994
         D42FhbTXKm5J1WIEaIIKP7MezWOiAwgjO3OHWV+J6FvUQyGD8L5Yqcz83JTCOFCdgyiN
         pl00AL805j6bfwdmMhwrMmeJa/DILxHrtVPHOsWZZJasMXRGMoSc+HMR1BLnPARGLryR
         5e9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752769066; x=1753373866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Y/RjTkTJBG1lcOSM/R+PpjsJ58T7Ydi95mMf2enko8=;
        b=WM/uqpTIZv/5rJJunyfxzpP6HXv6iWp3oaPtIEOH54LJW4mG3jSDufc6jpJ5AGH+oY
         EBS9NySMl/eV6jeogtJ0t4hxAK4NcwycoORGcLvz7BBbPitA8J4FbQtf+5484KlJM6fn
         KGahnmqrWkTvJjjFKxE+ck3tTGgbZgLB9MNgmi64QU9SiW9L9/rIWq8b09ob2J5Pvuc9
         Elz2bt6t48WcFoNYWoyXzHRAFTdO1e/6RJOa5SzPPkRkk/eKtohCRZ0Obxz/UrjWNMo9
         xrSKmK+zlGtwea5WmuCj12qOCmT1+E2vJfI+qc01l+6PgVNeSTRfbQR23NChP3uXeVrO
         mmAA==
X-Forwarded-Encrypted: i=1; AJvYcCWMfHtcz5AjE8mtA7Sw/RLqk+YVdvhZNypYpczEVkHuEARptk4rKm0zPLDagwVSuJfvz4HdtOaeXgZ5Clk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOMBphzCDZnrSrOak84AI9Yhn8r+l6SqV1OWEHlZutwRGeM76B
	aKlgnBkZgTp4GWEGujB1YtB72LSg2RU695T/cv6xZlkoCwyjF4dFLwpVmCPked+gmrP1BqVznTs
	5FMj2A8dfSyVGnVz+hf6HnGRxdGcScES3MxDK1FWw
X-Gm-Gg: ASbGncvf43Ka9qNinyAFEzsnUPiYP8O9OheGtwzpcrYQK/f9d2OT/ydgQCIa/n+Q5Sm
	Kah8sFSoySBZ/p7UsJQ1ro/nToFhcdXYG6Ly8lJLaxKlEGp8KB15lmdr7eHF1Ow8I2sU7eqGya4
	GgxbWFCVncchBYtX5lyeDoAULfe09ODZ7eT2UBWu82TOkx7sRbK8e7rYXdvmzIvRzTGwAI9plBO
	1Jz1OU=
X-Google-Smtp-Source: AGHT+IE9DWaA8FRK4xUpNKqB8FmzMQNZFjlXe/JlqckiMUc8pQOkJKRNMXU1R+kPwSGJz+qYdQKKmPj7Fqf+yBV+I3I=
X-Received: by 2002:a05:6512:31ca:b0:553:65bc:4250 with SMTP id
 2adb3069b0e04-55a2338ab11mr2382217e87.27.1752769065572; Thu, 17 Jul 2025
 09:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515182322.117840-1-pasha.tatashin@soleen.com>
 <20250515182322.117840-11-pasha.tatashin@soleen.com> <20250624-akzeptabel-angreifbar-9095f4717ca4@brauner>
 <CA+CK2bBu4ex9O5kPcR7++DVg3RM8ZWg3BCpcc6CboJ=aG8mVmQ@mail.gmail.com>
 <20250625-akrobatisch-libellen-352997eb08ef@brauner> <CALzav=d+XgS1bUs-v7+ws5nYU9y=4uc1c8oVLHrJ16qLpnUi9Q@mail.gmail.com>
 <mafs0sejmse57.fsf@kernel.org> <CALzav=dhuoaS73ikufCf2D11Vq=jfMceYv0abdMxOdaHzmVR0g@mail.gmail.com>
 <mafs04iveu8gs.fsf@kernel.org>
In-Reply-To: <mafs04iveu8gs.fsf@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Thu, 17 Jul 2025 09:17:17 -0700
X-Gm-Features: Ac12FXw3JFpwS5UWAzvXtdE2XcBaOGxi7uu6xW5eZbBjwaUzxU-r0d7vc1g83dU
Message-ID: <CALzav=cUQGF_DnmyDOORssoThmfQwnPgUxQiLmXyAKY1-hyT4g@mail.gmail.com>
Subject: Re: [RFC v2 10/16] luo: luo_ioctl: add ioctl interface
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org, rientjes@google.com, 
	corbet@lwn.net, rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, 
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com, 
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org, 
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev, 
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com, 
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org, 
	dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 7:56=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
> On Thu, Jun 26 2025, David Matlack wrote:
> > On Thu, Jun 26, 2025 at 8:42=E2=80=AFAM Pratyush Yadav <pratyush@kernel=
.org> wrote:
> >> On Wed, Jun 25 2025, David Matlack wrote:
> >> > On Wed, Jun 25, 2025 at 2:36=E2=80=AFAM Christian Brauner <brauner@k=
ernel.org> wrote:
> >> >> >
> >> >> > While I agree that a filesystem offers superior introspection and
> >> >> > integration with standard tools, building this complex, stateful
> >> >> > orchestration logic on top of VFS seemed to be forcing a square p=
eg
> >> >> > into a round hole. The ioctl interface, while more opaque, provid=
es a
> >> >> > direct and explicit way to command the state machine and manage t=
hese
> >> >> > complex lifecycle and dependency rules.
> >> >>
> >> >> I'm not going to argue that you have to switch to this kexecfs idea
> >> >> but...
> >> >>
> >> >> You're using a character device that's tied to devmptfs. In other w=
ords,
> >> >> you're already using a filesystem interface. Literally the whole co=
de
> >> >> here is built on top of filesystem APIs. So this argument is just v=
ery
> >> >> wrong imho. If you can built it on top of a character device using =
VFS
> >> >> interfaces you can do it as a minimal filesystem.
> >> >>
> >> >> You're free to define the filesystem interface any way you like it.=
 We
> >> >> have a ton of examples there. All your ioctls would just be tied to=
 the
> >> >> fileystem instance instead of the /dev/somethingsomething character
> >> >> device. The state machine could just be implemented the same way.
> >> >>
> >> >> One of my points is that with an fs interface you can have easy sta=
te
> >> >> seralization on a per-service level. IOW, you have a bunch of virtu=
al
> >> >> machines running as services or some networking services or whateve=
r.
> >> >> You could just bind-mount an instance of kexecfs into the service a=
nd
> >> >> the service can persist state into the instance and easily recover =
it
> >> >> after kexec.
> >> >
> >> > This approach sounds worth exploring more. It would avoid the need f=
or
> >> > a centralized daemon to mediate the preservation and restoration of
> >> > all file descriptors.
> >>
> >> One of the jobs of the centralized daemon is to decide the _policy_ of
> >> who gets to preserve things and more importantly, make sure the right
> >> party unpreserves the right FDs after a kexec. I don't see how this
> >> interface fixes this problem. You would still need a way to identify
> >> which kexecfs instance belongs to who and enforce that. The kernel
> >> probably shouldn't be the one doing this kind of policy so you still
> >> need some userspace component to make those decisions.
> >
> > The main benefits I see of kexecfs is that it avoids needing to send
> > all FDs over UDS to/from liveupdated and therefore the need for
> > dynamic cross-process communication (e.g. RPCs).
> >
> > Instead, something just needs to set up a kexecfs for each VM when it
> > is created, and give the same kexecfs back to each VM after kexec.
> > Then VMs are free to save/restore any FDs in that kexecfs without
> > cross-process communication or transferring file descriptors.
>
> Isn't giving back the right kexecfs instance to the right VMM the main
> problem? After a kexec, you need a way to make that policy decision. You
> would need a userspace agent to do that.
>
> I think what you are suggesting does make a lot of sense -- the agent
> should be handing out sessions instead of FDs, which would make FD
> save/restore simpler for applications. But that can be done using the
> ioctl interface as well. Each time you open() the /dev/liveupdate, you
> get a new session. Instead of file FDs like memfd or iommufs, we can
> have the agent hand out these session FDs and anything that was saved
> using this session would be ready for restoring.
>
> My main point is that this can be done with the current interface as
> well as kexecfs. I think there is very much a reason for considering
> kexecfs (like not being dependent on devtmpfs), but I don't think this
> is necessarily the main one.

The main problem I'd like solved is requiring all FDs to preserved and
restored in the context of a central daemon, since I think this will
inevitably cause problems for KVM. I agree with you that this problem
can also be solved in other ways, such as session FDs (good idea!).

>
> >
> > Policy can be enforced by controlling access to kexecfs mounts. This
> > naturally fits into the standard architecture of running untrusted VMs
> > (e.g. using chroots and containers to enforce security and isolation).
>
> How? After a kexec, how do you tell which process can get which kexecfs
> mount/instance? If any of them can get any, then we lose all sort of
> policy enforcement.

I was imagining it's up to whatever process/daemon creates the kexecfs
instances before kexec is also responsible for reassociating them with
the right processes after kexec.

If you are asking how that association would be done mechanically, I
was imagining it would be through a combination of filesystem
permissions, mounts, and chroots. For example, the kexecfs instance
for VM A would be mounted in VM A's chroot. VM A would then only have
access to its own kexecfs instance.

> >> > I'm not sure that we can get rid of the machine-wide state machine
> >> > though, as there is some kernel state that will necessarily cross
> >> > these kexecfs domains (e.g. IOMMU driver state). So we still might
> >> > need /dev/liveupdate for that.
> >>
> >> Generally speaking, I think both VFS-based and IOCTL-based interfaces
> >> are more or less equally expressive/powerful. Most of the ioctl
> >> operations can be translated to a VFS operation and vice versa.
> >>
> >> For example, the fsopen() call is similar to open("/dev/liveupdate") -=
-
> >> both would create a live update session which auto closes when the FD =
is
> >> closed or FS unmounted. Similarly, each ioctl can be replaced with a
> >> file in the FS. For example, LIVEUPDATE_IOCTL_FD_PRESERVE can be
> >> replaced with a fd_preserve file where you write() the FD number.
> >> LIVEUPDATE_IOCTL_GET_STATE or LIVEUPDATE_IOCTL_PREPARE, etc. can be
> >> replaced by a "state" file where you can read() or write() the state.
> >>
> >> I think the main benefit of the VFS-based interface is ease of use.
> >> There already exist a bunch of utilites and libraries that we can use =
to
> >> interact with files. When we have ioctls, we would need to write
> >> everything ourselves. For example, instead of
> >> LIVEUPDATE_IOCTL_GET_STATE, you can do "cat state", which is a bit
> >> easier to do.
> >>
> >> As for downsides, I think we might end up with a bit more boilerplate
> >> code, but beyond that I am not sure.
> >
> > I agree we can more or less get to the same end state with either
> > approach. And also, I don't think we have to do one or the other. I
> > think kexecfs is something that we can build on top of this series.
> > For example, kexecfs would be a new kernel subsystem that registers
> > with LUO.
>
> Yeah, fair point. Though I'd rather we agree on one and go with that.
> Having two interfaces for the same thing isn't the best.

Agreed, tt would be better to have a single way to preserve FDs rather
than 2 (LUO ioctl and kexecfs).

