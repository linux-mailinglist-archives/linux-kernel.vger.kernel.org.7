Return-Path: <linux-kernel+bounces-730281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C45B0424B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26E8A7AA0B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5BF259C83;
	Mon, 14 Jul 2025 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxlVJYU9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B224E4AD;
	Mon, 14 Jul 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505005; cv=none; b=FnkVT2wX7rA300kkoGnqL90iyVlm7kR8HTDy3L9W8a3qVCLevjl9I+fk9gSDlO0qeD015poOyrKWtnSikq/mn25jZ9zvswkuT4fAf1mtRp99vHmShUGIl6yFvtgtoZsVQcaIWQbEhTRButpZ3FUCUx9JBgJ8z7B0fE8nLkA7xAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505005; c=relaxed/simple;
	bh=603QU5t2EV5T1tw1hCkBQXZ4TlGTcXH3cQEDUeEh1P4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bH/A2kw0iwXdN6BwaE2+uDHOsic/pROYWDfON7a+pyeq4NKhqUx9gqdlnT+jbl5cU0yK4hW/PE0HMDaPOMUE3Fv1vy01tLqE6WwNqu3z2wdNxS5VNYkUEtV1W6P4sqfI/LwQnJqGTauBPnLMYjDVpxOtngAgXFwCrI9LLmDRBR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxlVJYU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D28C4CEED;
	Mon, 14 Jul 2025 14:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752505005;
	bh=603QU5t2EV5T1tw1hCkBQXZ4TlGTcXH3cQEDUeEh1P4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OxlVJYU9dFpuJT5A7474EhhBynMHnCS1VzDTP7agtlH6C7+5du+Wy48NktA8GISCK
	 9lCcE8XO99SvvMcCqb9CvXol3Ev5sBC18mCbb3bijyaxM8fLd4c+1uJoOGYhcnpNzq
	 Z7PPhsAOITr+dR2NXmgR0ROZaDGD9w8e7en6334b6/eP3YU63VrtjvITsMT9jgmfae
	 4CdBlDfCt3jvwbffeYgJrquh595/AeC07U3rqjrxf2G6IOU8sn6hXedDDDDySRokUZ
	 EqHGd0Mmwl+kloVP4Anui9N7GeSQvQxzmCPXwzO1jbw4MoVwUHolomYcZAa7UZBsDS
	 P1U3S7K8FAFsQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Christian Brauner
 <brauner@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  jasonmiu@google.com,  graf@amazon.com,  changyuanl@google.com,
  rppt@kernel.org,  rientjes@google.com,  corbet@lwn.net,
  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  zhangguopeng@kylinos.cn,  linux@weissschuh.net,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  gregkh@linuxfoundation.org,  tglx@linutronix.de,
  mingo@redhat.com,  bp@alien8.de,  dave.hansen@linux.intel.com,
  x86@kernel.org,  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com
Subject: Re: [RFC v2 10/16] luo: luo_ioctl: add ioctl interface
In-Reply-To: <CALzav=dhuoaS73ikufCf2D11Vq=jfMceYv0abdMxOdaHzmVR0g@mail.gmail.com>
References: <20250515182322.117840-1-pasha.tatashin@soleen.com>
	<20250515182322.117840-11-pasha.tatashin@soleen.com>
	<20250624-akzeptabel-angreifbar-9095f4717ca4@brauner>
	<CA+CK2bBu4ex9O5kPcR7++DVg3RM8ZWg3BCpcc6CboJ=aG8mVmQ@mail.gmail.com>
	<20250625-akrobatisch-libellen-352997eb08ef@brauner>
	<CALzav=d+XgS1bUs-v7+ws5nYU9y=4uc1c8oVLHrJ16qLpnUi9Q@mail.gmail.com>
	<mafs0sejmse57.fsf@kernel.org>
	<CALzav=dhuoaS73ikufCf2D11Vq=jfMceYv0abdMxOdaHzmVR0g@mail.gmail.com>
Date: Mon, 14 Jul 2025 16:56:35 +0200
Message-ID: <mafs04iveu8gs.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi David,

On Thu, Jun 26 2025, David Matlack wrote:

> On Thu, Jun 26, 2025 at 8:42=E2=80=AFAM Pratyush Yadav <pratyush@kernel.o=
rg> wrote:
>>
>> On Wed, Jun 25 2025, David Matlack wrote:
>>
>> > On Wed, Jun 25, 2025 at 2:36=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
>> >> >
>> >> > While I agree that a filesystem offers superior introspection and
>> >> > integration with standard tools, building this complex, stateful
>> >> > orchestration logic on top of VFS seemed to be forcing a square peg
>> >> > into a round hole. The ioctl interface, while more opaque, provides=
 a
>> >> > direct and explicit way to command the state machine and manage the=
se
>> >> > complex lifecycle and dependency rules.
>> >>
>> >> I'm not going to argue that you have to switch to this kexecfs idea
>> >> but...
>> >>
>> >> You're using a character device that's tied to devmptfs. In other wor=
ds,
>> >> you're already using a filesystem interface. Literally the whole code
>> >> here is built on top of filesystem APIs. So this argument is just very
>> >> wrong imho. If you can built it on top of a character device using VFS
>> >> interfaces you can do it as a minimal filesystem.
>> >>
>> >> You're free to define the filesystem interface any way you like it. We
>> >> have a ton of examples there. All your ioctls would just be tied to t=
he
>> >> fileystem instance instead of the /dev/somethingsomething character
>> >> device. The state machine could just be implemented the same way.
>> >>
>> >> One of my points is that with an fs interface you can have easy state
>> >> seralization on a per-service level. IOW, you have a bunch of virtual
>> >> machines running as services or some networking services or whatever.
>> >> You could just bind-mount an instance of kexecfs into the service and
>> >> the service can persist state into the instance and easily recover it
>> >> after kexec.
>> >
>> > This approach sounds worth exploring more. It would avoid the need for
>> > a centralized daemon to mediate the preservation and restoration of
>> > all file descriptors.
>>
>> One of the jobs of the centralized daemon is to decide the _policy_ of
>> who gets to preserve things and more importantly, make sure the right
>> party unpreserves the right FDs after a kexec. I don't see how this
>> interface fixes this problem. You would still need a way to identify
>> which kexecfs instance belongs to who and enforce that. The kernel
>> probably shouldn't be the one doing this kind of policy so you still
>> need some userspace component to make those decisions.
>
> The main benefits I see of kexecfs is that it avoids needing to send
> all FDs over UDS to/from liveupdated and therefore the need for
> dynamic cross-process communication (e.g. RPCs).
>
> Instead, something just needs to set up a kexecfs for each VM when it
> is created, and give the same kexecfs back to each VM after kexec.
> Then VMs are free to save/restore any FDs in that kexecfs without
> cross-process communication or transferring file descriptors.

Isn't giving back the right kexecfs instance to the right VMM the main
problem? After a kexec, you need a way to make that policy decision. You
would need a userspace agent to do that.

I think what you are suggesting does make a lot of sense -- the agent
should be handing out sessions instead of FDs, which would make FD
save/restore simpler for applications. But that can be done using the
ioctl interface as well. Each time you open() the /dev/liveupdate, you
get a new session. Instead of file FDs like memfd or iommufs, we can
have the agent hand out these session FDs and anything that was saved
using this session would be ready for restoring.

My main point is that this can be done with the current interface as
well as kexecfs. I think there is very much a reason for considering
kexecfs (like not being dependent on devtmpfs), but I don't think this
is necessarily the main one.

>
> Policy can be enforced by controlling access to kexecfs mounts. This
> naturally fits into the standard architecture of running untrusted VMs
> (e.g. using chroots and containers to enforce security and isolation).

How? After a kexec, how do you tell which process can get which kexecfs
mount/instance? If any of them can get any, then we lose all sort of
policy enforcement.

>
>>
>> >
>> > I'm not sure that we can get rid of the machine-wide state machine
>> > though, as there is some kernel state that will necessarily cross
>> > these kexecfs domains (e.g. IOMMU driver state). So we still might
>> > need /dev/liveupdate for that.
>>
>> Generally speaking, I think both VFS-based and IOCTL-based interfaces
>> are more or less equally expressive/powerful. Most of the ioctl
>> operations can be translated to a VFS operation and vice versa.
>>
>> For example, the fsopen() call is similar to open("/dev/liveupdate") --
>> both would create a live update session which auto closes when the FD is
>> closed or FS unmounted. Similarly, each ioctl can be replaced with a
>> file in the FS. For example, LIVEUPDATE_IOCTL_FD_PRESERVE can be
>> replaced with a fd_preserve file where you write() the FD number.
>> LIVEUPDATE_IOCTL_GET_STATE or LIVEUPDATE_IOCTL_PREPARE, etc. can be
>> replaced by a "state" file where you can read() or write() the state.
>>
>> I think the main benefit of the VFS-based interface is ease of use.
>> There already exist a bunch of utilites and libraries that we can use to
>> interact with files. When we have ioctls, we would need to write
>> everything ourselves. For example, instead of
>> LIVEUPDATE_IOCTL_GET_STATE, you can do "cat state", which is a bit
>> easier to do.
>>
>> As for downsides, I think we might end up with a bit more boilerplate
>> code, but beyond that I am not sure.
>
> I agree we can more or less get to the same end state with either
> approach. And also, I don't think we have to do one or the other. I
> think kexecfs is something that we can build on top of this series.
> For example, kexecfs would be a new kernel subsystem that registers
> with LUO.

Yeah, fair point. Though I'd rather we agree on one and go with that.
Having two interfaces for the same thing isn't the best.

--=20
Regards,
Pratyush Yadav

