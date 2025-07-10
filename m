Return-Path: <linux-kernel+bounces-725101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 972EAAFFACF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD721C82174
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9877C288C2A;
	Thu, 10 Jul 2025 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sv22hU7e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E961A8F5E;
	Thu, 10 Jul 2025 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132428; cv=none; b=AuWQlqTwaVrfJe/tqN7QQjVlua7fOSmaFHLZ9yYPZ7EdJQnse0mw87fQ8IE4+w0fY6TVpNGGJTOFQQ3dU8aMseGolZhKUtAA1i74bWbnguAB04nYBpEKu2dLBlqJeq7Q5KVh0EFbRGI2YjbawtiCmTzgfmUkJQWxyDdm7LULZnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132428; c=relaxed/simple;
	bh=q8eQa8h3G+1BUbeKwUG/+c6FzsMMOTsEwlY/U/VRJq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbNHm5ZJRXKKau8z+t/KZiPS0EOCq0R8+4PhUNbfysTCVtkdMnIh0J0bdDtGe1W0FWiDvex/gNUuIcOFr43+wXccyNz2Eq0jROFa3MSGbq8oUOw+viYQjJMb9qQXfIAyXRD5rI3gSM+nu7qJbsymMyQLsqWWejBFZkIqHam4pMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sv22hU7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A35C4CEE3;
	Thu, 10 Jul 2025 07:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752132427;
	bh=q8eQa8h3G+1BUbeKwUG/+c6FzsMMOTsEwlY/U/VRJq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sv22hU7eDntyWDea+W8G3nJxqHVDscPWMcXGvQKTcjjDvycY9Iaf68KLjGlBWxIGQ
	 U6ijuHlmSsfE6qNOLSBDpOojSUWJwJR81oMSU2OfqhKEQalv2rvOI7klGpoL48gs37
	 owl8tKt1gY5jqUaFfYfMiFpNcSeAeNgTixi18OeLlfRCHGU2hmoixdpCjtPKve6VAZ
	 9XikS4R7HWWG236SnW9XShLGB1tP1667qhMKBlwiKBubK4DkgHVAfZBc3iDeOwmeJ+
	 AMUUNt4tENX6pAtuXdWSD2E91l74cj/o7pg97QLRsHZLBICdBqNj3XIPOP+r6KT/pJ
	 ND44JKhgqtDsQ==
Date: Thu, 10 Jul 2025 10:26:45 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, jasonmiu@google.com,
	graf@amazon.com, changyuanl@google.com, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com
Subject: Re: [RFC v2 10/16] luo: luo_ioctl: add ioctl interface
Message-ID: <aG9rNQ277weSR_dl@kernel.org>
References: <20250515182322.117840-1-pasha.tatashin@soleen.com>
 <20250515182322.117840-11-pasha.tatashin@soleen.com>
 <20250624-akzeptabel-angreifbar-9095f4717ca4@brauner>
 <aGqHFkPWOrD6whv6@kernel.org>
 <mafs0qzypys0j.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0qzypys0j.fsf@kernel.org>

On Wed, Jul 09, 2025 at 11:27:08PM +0200, Pratyush Yadav wrote:
> On Sun, Jul 06 2025, Mike Rapoport wrote:
> 
> > On Tue, Jun 24, 2025 at 11:50:49AM +0200, Christian Brauner wrote:
> >> On Thu, May 15, 2025 at 06:23:14PM +0000, Pasha Tatashin wrote:
> >> > Introduce the user-space interface for the Live Update Orchestrator
> >> > via ioctl commands, enabling external control over the live update
> >> > process and management of preserved resources.
> >> > 
> >> > Create a misc character device at /dev/liveupdate. Access
> >> > to this device requires the CAP_SYS_ADMIN capability.
> >> > 
> >> > A new UAPI header, <uapi/linux/liveupdate.h>, defines the necessary
> >> > structures. The magic number is registered in
> >> > Documentation/userspace-api/ioctl/ioctl-number.rst.
> >> > 
> >> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> >> > ---
> >> >  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
> >> >  drivers/misc/liveupdate/Makefile              |   1 +
> >> >  drivers/misc/liveupdate/luo_ioctl.c           | 199 ++++++++++++
> >> >  include/linux/liveupdate.h                    |  34 +-
> >> >  include/uapi/linux/liveupdate.h               | 300 ++++++++++++++++++
> >> >  5 files changed, 502 insertions(+), 33 deletions(-)
> >> >  create mode 100644 drivers/misc/liveupdate/luo_ioctl.c
> >> >  create mode 100644 include/uapi/linux/liveupdate.h
> >
> > ...
> >
> >> > +static const struct file_operations fops = {
> >> > +	.owner          = THIS_MODULE,
> >> > +	.open           = luo_open,
> >> > +	.unlocked_ioctl = luo_ioctl,
> >> > +};
> >> > +
> >> > +static struct miscdevice liveupdate_miscdev = {
> >> > +	.minor = MISC_DYNAMIC_MINOR,
> >> > +	.name  = "liveupdate",
> >> > +	.fops  = &fops,
> >> > +};
> >> 
> >> I'm not sure why people are so in love with character device based apis.
> >> It's terrible. It glues everything to devtmpfs which isn't namespacable
> >> in any way. It's terrible to delegate and extremely restrictive in terms
> >> of extensiblity if you need additional device entries (aka the loop
> >> driver folly).
> >> 
> >> One stupid question: I probably have asked this before and just swapped
> >> out that I a) asked this already and b) received an explanation. But why
> >> isn't this a singleton simple in-memory filesystem with a flat
> >> hierarchy?
> >> 
> >> mount -t kexecfs kexecfs /kexecfs
> >> 
> >> So userspace mounts kexecfs (or the kernel does it automagically) and
> >> then to add fds into that thing you do the following:
> >> 
> >> linkat(fd_my_anon_inode_memfd, "", -EBADF, "kexecfs/my_serialized_memfd", AT_EMPTY_PATH)
> >
> > Having an ability to link a file descriptor to kexecfs would have been
> > nice. We could even create a dependency hierarchy there, e.g.
> >
> > mkdir -p kexecfs/vm1/kvm/{iommu,memfd}
> >
> > linkat(kvmfd, "", -EBADF, "kexecfs/vm1/kvm/kvmfd", AT_EMPTY_PATH)
> > linkat(iommufd, "", -EBADF, "kexecfs/vm1/kvm/iommu/iommufd", AT_EMPTY_PATH)
> > linkat(memfd, "", -EBADF, "kexecfs/vm1/kvm/memfd/memfd", AT_EMPTY_PATH)
> >
> > But unfortunately this won't work because VFS checks that new and old paths
> > are on the same mount. And even if cross-mount links were allowed, VFS does
> > not pass the file objects to link* APIs, so preserving a file backed by
> > anon_inode is another issue.
> 
> Yep, I was poking around the VFS code last week and saw the same
> problem.
> 
> >
> >> which will serialize the fd_my_anon_inode_memfd. You can also do this
> >> with ioctls on the kexecfs filesystem of course.
> >
> > ioctls seem to be the only option, but I agree they don't have to be bound
> > to a miscdev.
> 
> I suppose you can have a special file, say "preserve_fd", where you can
> write() the FD number.
> 
> This is in some ways similar to how you would write it to the ioctl()
> via the arg buffer/struct. And I suppose you can have other special
> files to do the things that other ioctls would do.
> 
> That is one way to do it, although I dunno if it classifies as a
> "proper" use of the VFS APIs...

IIUC Christian's point was mostly not about using VFS APIs (i.e.
read/write) but about using a special pseudo fs rather than devtmpfs to
drive ioctls.
 
So instead of 

	fd = open("/dev/liveupdate", ...);
	ioctl(fd, ...);

we'd use

	fd = open("/sys/fs/kexec/control", ...);
	ioctl(fd, ...);

> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

