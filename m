Return-Path: <linux-kernel+bounces-724520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 539E9AFF3EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249641C85005
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CEF24336D;
	Wed,  9 Jul 2025 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldzQw00U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C2B231826;
	Wed,  9 Jul 2025 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752096438; cv=none; b=LRcm0YoUCtgIVnkiYcRNsnGvQtrqK1QETna7ZAkiGzAZfg7OlSQ2/tRf4aCzgiH+D7A2TCKYfpOduVYZdV1fzB+ZjZaNfO87akCd2Y7TmTySwcPZgxpTmKEST3S9LPHxaw38icqq95WzRRa1VdfZo6T/NhvtrDPA4Xhqz/sK09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752096438; c=relaxed/simple;
	bh=di0qI7GEmczq14zBNaBk8AWjgNHZtoR0rPpsB6FrrvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cim249bpC8A1gH0HPnZJwGgRZxF7etS9henaecWzsdP23Rp826bFmSoAbYoj1bVfuD1WyxfgopKcNYthdZzAZpJmhVardwao5oBtKb2w5z1Fj/tkfEkQahUfjZuh/MjfGibIV49TUhhrjGwIBnAqfGBjv2nqGO+mP5EQLPlWcSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldzQw00U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F162EC4CEF4;
	Wed,  9 Jul 2025 21:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752096437;
	bh=di0qI7GEmczq14zBNaBk8AWjgNHZtoR0rPpsB6FrrvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ldzQw00U+OetIKA481nc0vtmKNZA1RskLqjb7X1NOEN1OeisHWun1QCwnCjI5ottS
	 vx4NKF7Pf8e0EPpxQC9AFg2qPBCYZ3d6DbJ21t2lwKjYlgSAvwQRR1yt4EJkrndA1f
	 trzz9UmGeEgappXz0em9JwDLdjx01xkdVQbI3rVE3SIia4ICLQG8cbVWFxlnpTAUKc
	 WQFupUDU4w3ADhfQa1mGwDVdFb//Oc88+StcqBA4tOTf5V4klAd2DKIQiX+U54taBE
	 cwWDg3qNLgwXVZYFjvCKSq8cfutNsrmXNizt1CYW6H3QEfQT+dYgCuQqr6GqUb4mQt
	 RtrsejD0cEWWg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  pratyush@kernel.org,  jasonmiu@google.com,
  graf@amazon.com,  changyuanl@google.com,  dmatlack@google.com,
  rientjes@google.com,  corbet@lwn.net,  rdunlap@infradead.org,
  ilpo.jarvinen@linux.intel.com,  kanie@linux.alibaba.com,
  ojeda@kernel.org,  aliceryhl@google.com,  masahiroy@kernel.org,
  akpm@linux-foundation.org,  tj@kernel.org,  yoann.congal@smile.fr,
  mmaurer@google.com,  roman.gushchin@linux.dev,  chenridong@huawei.com,
  axboe@kernel.dk,  mark.rutland@arm.com,  jannh@google.com,
  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
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
In-Reply-To: <aGqHFkPWOrD6whv6@kernel.org>
References: <20250515182322.117840-1-pasha.tatashin@soleen.com>
	<20250515182322.117840-11-pasha.tatashin@soleen.com>
	<20250624-akzeptabel-angreifbar-9095f4717ca4@brauner>
	<aGqHFkPWOrD6whv6@kernel.org>
Date: Wed, 09 Jul 2025 23:27:08 +0200
Message-ID: <mafs0qzypys0j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jul 06 2025, Mike Rapoport wrote:

> On Tue, Jun 24, 2025 at 11:50:49AM +0200, Christian Brauner wrote:
>> On Thu, May 15, 2025 at 06:23:14PM +0000, Pasha Tatashin wrote:
>> > Introduce the user-space interface for the Live Update Orchestrator
>> > via ioctl commands, enabling external control over the live update
>> > process and management of preserved resources.
>> > 
>> > Create a misc character device at /dev/liveupdate. Access
>> > to this device requires the CAP_SYS_ADMIN capability.
>> > 
>> > A new UAPI header, <uapi/linux/liveupdate.h>, defines the necessary
>> > structures. The magic number is registered in
>> > Documentation/userspace-api/ioctl/ioctl-number.rst.
>> > 
>> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> > ---
>> >  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>> >  drivers/misc/liveupdate/Makefile              |   1 +
>> >  drivers/misc/liveupdate/luo_ioctl.c           | 199 ++++++++++++
>> >  include/linux/liveupdate.h                    |  34 +-
>> >  include/uapi/linux/liveupdate.h               | 300 ++++++++++++++++++
>> >  5 files changed, 502 insertions(+), 33 deletions(-)
>> >  create mode 100644 drivers/misc/liveupdate/luo_ioctl.c
>> >  create mode 100644 include/uapi/linux/liveupdate.h
>
> ...
>
>> > +static const struct file_operations fops = {
>> > +	.owner          = THIS_MODULE,
>> > +	.open           = luo_open,
>> > +	.unlocked_ioctl = luo_ioctl,
>> > +};
>> > +
>> > +static struct miscdevice liveupdate_miscdev = {
>> > +	.minor = MISC_DYNAMIC_MINOR,
>> > +	.name  = "liveupdate",
>> > +	.fops  = &fops,
>> > +};
>> 
>> I'm not sure why people are so in love with character device based apis.
>> It's terrible. It glues everything to devtmpfs which isn't namespacable
>> in any way. It's terrible to delegate and extremely restrictive in terms
>> of extensiblity if you need additional device entries (aka the loop
>> driver folly).
>> 
>> One stupid question: I probably have asked this before and just swapped
>> out that I a) asked this already and b) received an explanation. But why
>> isn't this a singleton simple in-memory filesystem with a flat
>> hierarchy?
>> 
>> mount -t kexecfs kexecfs /kexecfs
>> 
>> So userspace mounts kexecfs (or the kernel does it automagically) and
>> then to add fds into that thing you do the following:
>> 
>> linkat(fd_my_anon_inode_memfd, "", -EBADF, "kexecfs/my_serialized_memfd", AT_EMPTY_PATH)
>
> Having an ability to link a file descriptor to kexecfs would have been
> nice. We could even create a dependency hierarchy there, e.g.
>
> mkdir -p kexecfs/vm1/kvm/{iommu,memfd}
>
> linkat(kvmfd, "", -EBADF, "kexecfs/vm1/kvm/kvmfd", AT_EMPTY_PATH)
> linkat(iommufd, "", -EBADF, "kexecfs/vm1/kvm/iommu/iommufd", AT_EMPTY_PATH)
> linkat(memfd, "", -EBADF, "kexecfs/vm1/kvm/memfd/memfd", AT_EMPTY_PATH)
>
> But unfortunately this won't work because VFS checks that new and old paths
> are on the same mount. And even if cross-mount links were allowed, VFS does
> not pass the file objects to link* APIs, so preserving a file backed by
> anon_inode is another issue.

Yep, I was poking around the VFS code last week and saw the same
problem.

>
>> which will serialize the fd_my_anon_inode_memfd. You can also do this
>> with ioctls on the kexecfs filesystem of course.
>
> ioctls seem to be the only option, but I agree they don't have to be bound
> to a miscdev.

I suppose you can have a special file, say "preserve_fd", where you can
write() the FD number.

This is in some ways similar to how you would write it to the ioctl()
via the arg buffer/struct. And I suppose you can have other special
files to do the things that other ioctls would do.

That is one way to do it, although I dunno if it classifies as a
"proper" use of the VFS APIs...

-- 
Regards,
Pratyush Yadav

