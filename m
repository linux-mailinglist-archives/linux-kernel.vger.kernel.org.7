Return-Path: <linux-kernel+bounces-742760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9827CB0F6C2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F66C17C40F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCE313EFF3;
	Wed, 23 Jul 2025 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+q8v1FB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42D72F432E;
	Wed, 23 Jul 2025 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282298; cv=none; b=QXHjG4yYyplfZk0IqI9QVuiq1gX8DAg58TaPkTdSw35oRJcUKcgsZRH3ouAmdY9kgeDlaTvhGEXmH565sa9PvSFENs1p/EAtJcD4p0yn4ctkexG9oO5JUDlP9WWCZ3GSrI2PskRNQKSpPscFLNCoGHJ/J7itvOdTijxMRYlBXnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282298; c=relaxed/simple;
	bh=wVnQRMG6JWHpYbsRA/rELCHaPGGpezCM9mPDQYF1C14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T45Cgwit56BCKKPB2vqdTlnkpBlOdmnorkL1IUl+OgnVlFImpA1vMKS0OgWOucwshD7+RNEuEksJ668QUt2rk3X+sMPHRMgZjPjUF8JuwuD8pVwUhIAogKPPmZxIw65Gb8AxCOcYMtP3xJznWw2VAOGWal28ljgXZw23fOkPJ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+q8v1FB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B474C4CEFA;
	Wed, 23 Jul 2025 14:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753282296;
	bh=wVnQRMG6JWHpYbsRA/rELCHaPGGpezCM9mPDQYF1C14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=d+q8v1FBgcxnd+Ik2rBSCWZH06NbbJGLl7cIHPMqFNbMvMUGu42r2+kOXuk1c4mKd
	 HOPd5PYTlzlUpjlw+7YAGxaJgxHExR7S+znJCf/bJhsTXGAmee0pyILoPDgKh9QAbe
	 m9OJ47WxhrHGFdNoBQ1VoBG5zv7QuTRxMy6Kb29Bv0g6yBajiE2EFMT+rY2IAJ3i+T
	 +vA+kxBAM0i02TaHS7vNlMMWFgBI0uEkuDXiO1wfgArKa8rsjS/oWQXIeIgMR2Z5nZ
	 BXdJz7u9bcB1C6uTiOp6o2eHXoM/RpOgqQc6sTQWzFJmtdkbtKivp519DSR/KCFwls
	 W8g2vZI8GJ/iQ==
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
In-Reply-To: <CALzav=cUQGF_DnmyDOORssoThmfQwnPgUxQiLmXyAKY1-hyT4g@mail.gmail.com>
References: <20250515182322.117840-1-pasha.tatashin@soleen.com>
	<20250515182322.117840-11-pasha.tatashin@soleen.com>
	<20250624-akzeptabel-angreifbar-9095f4717ca4@brauner>
	<CA+CK2bBu4ex9O5kPcR7++DVg3RM8ZWg3BCpcc6CboJ=aG8mVmQ@mail.gmail.com>
	<20250625-akrobatisch-libellen-352997eb08ef@brauner>
	<CALzav=d+XgS1bUs-v7+ws5nYU9y=4uc1c8oVLHrJ16qLpnUi9Q@mail.gmail.com>
	<mafs0sejmse57.fsf@kernel.org>
	<CALzav=dhuoaS73ikufCf2D11Vq=jfMceYv0abdMxOdaHzmVR0g@mail.gmail.com>
	<mafs04iveu8gs.fsf@kernel.org>
	<CALzav=cUQGF_DnmyDOORssoThmfQwnPgUxQiLmXyAKY1-hyT4g@mail.gmail.com>
Date: Wed, 23 Jul 2025 16:51:26 +0200
Message-ID: <mafs0zfcvrmdt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17 2025, David Matlack wrote:

> On Mon, Jul 14, 2025 at 7:56=E2=80=AFAM Pratyush Yadav <pratyush@kernel.o=
rg> wrote:
>> On Thu, Jun 26 2025, David Matlack wrote:
>> > On Thu, Jun 26, 2025 at 8:42=E2=80=AFAM Pratyush Yadav <pratyush@kerne=
l.org> wrote:
>> >> On Wed, Jun 25 2025, David Matlack wrote:
>> >> > On Wed, Jun 25, 2025 at 2:36=E2=80=AFAM Christian Brauner <brauner@=
kernel.org> wrote:
[...]
>>
>> Isn't giving back the right kexecfs instance to the right VMM the main
>> problem? After a kexec, you need a way to make that policy decision. You
>> would need a userspace agent to do that.
>>
>> I think what you are suggesting does make a lot of sense -- the agent
>> should be handing out sessions instead of FDs, which would make FD
>> save/restore simpler for applications. But that can be done using the
>> ioctl interface as well. Each time you open() the /dev/liveupdate, you
>> get a new session. Instead of file FDs like memfd or iommufs, we can
>> have the agent hand out these session FDs and anything that was saved
>> using this session would be ready for restoring.
>>
>> My main point is that this can be done with the current interface as
>> well as kexecfs. I think there is very much a reason for considering
>> kexecfs (like not being dependent on devtmpfs), but I don't think this
>> is necessarily the main one.
>
> The main problem I'd like solved is requiring all FDs to preserved and
> restored in the context of a central daemon, since I think this will
> inevitably cause problems for KVM. I agree with you that this problem
> can also be solved in other ways, such as session FDs (good idea!).

Another benefit of session FDs: the central daemon can decide whether it
wants to check each FD it gives over to a process, or just give over a
session and let the process do whatever it wants. With the current
patches, only the former operation model can be implemented.

>> >
>> > Policy can be enforced by controlling access to kexecfs mounts. This
>> > naturally fits into the standard architecture of running untrusted VMs
>> > (e.g. using chroots and containers to enforce security and isolation).
>>
>> How? After a kexec, how do you tell which process can get which kexecfs
>> mount/instance? If any of them can get any, then we lose all sort of
>> policy enforcement.
>
> I was imagining it's up to whatever process/daemon creates the kexecfs
> instances before kexec is also responsible for reassociating them with
> the right processes after kexec.
>
> If you are asking how that association would be done mechanically, I
> was imagining it would be through a combination of filesystem
> permissions, mounts, and chroots. For example, the kexecfs instance
> for VM A would be mounted in VM A's chroot. VM A would then only have
> access to its own kexecfs instance.

Hmm, good point. This would be quite a clean way of doing it I think.

[...]

--=20
Regards,
Pratyush Yadav

