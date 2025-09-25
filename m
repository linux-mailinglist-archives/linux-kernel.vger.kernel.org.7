Return-Path: <linux-kernel+bounces-832456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7654B9F5CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1B816731B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1841E285A;
	Thu, 25 Sep 2025 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EmkGRZ2k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B10E1A0728;
	Thu, 25 Sep 2025 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804768; cv=none; b=CBKq06sixaLFliaje6agmyGUCOm6OMDZE/IokI5hBxY5H5Sw1VGxaRwLzkbzR9qEXa+NOAY5E8Z8DbAdm54UUPFdojpwUxLMZEDWkXDOhvJdaBXrM17eOINqejmsfO5HnOrsKQHEKw27v2t7uHlVrckHY8I+r2Zn5cbW/hF3vRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804768; c=relaxed/simple;
	bh=IWvjH/2hxWZ4IGGoOvrciyFGdQxIWa5UlPDx6lJac2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g40UzsfiNBbhl8FMT64qoqpV0VgoSqhjTTNDA5mCXrNmQXYROexkZSciEBF+Gv58+wqN6x9raATOhBHc1ch8MPGOFCBWBVxQh/7fF0TTS9Qot8rHuq4MT1i/oVN80OoJznt5CjUs/GW9hJND4BhzNXiuZ2ker0wiMQMuSMzt5MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EmkGRZ2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319F0C4CEF0;
	Thu, 25 Sep 2025 12:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758804767;
	bh=IWvjH/2hxWZ4IGGoOvrciyFGdQxIWa5UlPDx6lJac2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EmkGRZ2kQytjqgPTdAFBbhOXZGdaqexBWnvDkyj/P6lu/u4UefCw9Ql52Aya25zej
	 Q296+vH2Oj4msA8HwcpkMm0C+zkATX1TVPzBYFfG8mJ3vU6+OtVZncL8TL6Xc3R+jh
	 KvEjDj9VmkoSNShgI2v00PDWxaMeYJpcszQx9rGM=
Date: Thu, 25 Sep 2025 14:52:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/2] rust: usb: add initial USB abstractions
Message-ID: <2025092520-sharply-everyone-4a5d@gregkh>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>

On Mon, Aug 25, 2025 at 03:18:04PM -0300, Daniel Almeida wrote:
> This adds initial support for USB Rust drivers, not only because I see a
> widespread use of module_usb_driver() in media (which is a subsystem I
> aim to support) but also because I want to learn about USB in general
> and this is a nice opportunity to start doing so.
> 
> I tried to keep things as consistent with pci.rs and platform.rs as
> possible and tested it by manually binding a device (i.e.: my Logitech
> mouse) to the sample driver via:
> 
> /sys/bus/usb/drivers/rust_driver_usb/new_id
> 
> This initial patch is therefore comprised of the same patterns that are
> known to work for pci and platform already.
> 
> Physically disconnecting the device also worked, i.e.: nothing bad
> showed up in dmesg.
> 
> Note that I did not touch MAINTAINERS at all. The objective is to
> kickstart the discussion of what to do there here in v1.

Ok, as this seems to now be at least building properly for me, I have
taken it into my char-misc branch for the next -rc1 merge window.

BUT it has shown that it still needs some work to get "correct" and it
really doesn't do much quite yet, so I have applied the patch below to
pretty much just "disable" it entirely from the build at this point in
time.

I'll go and revert this commit after -rc1 is out, in my usb-next branch,
so that we can start to build on top of it and ensure that it doesn't
break, but for 6.18, I don't think it's quite ready to be there.

Yes, this is not a normal way that bindings will probably be merged into
the tree, but as I consulted deeply with the USB maintainer about this
topic while eating some good Paris pizza and French wine this week while
at the Kernel Recipes conference, I think that this deserves an
exception as they agree this can be merged now and they will be
responsible for any fallout.[1]

thanks,

greg k-h

From c1785be6395031f92b62badb27665f80f0a7794c Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 25 Sep 2025 14:42:40 +0200
Subject: USB: disable rust bindings from the build for now

The rust USB bindings as submitted are a good start, but they don't
really seem to be correct in a number of minor places, so just disable
them from the build entirely at this point in time.  When they are ready
to be re-enabled, this commit can be reverted.

Cc: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/bindings/bindings_helper.h | 1 -
 rust/helpers/helpers.c          | 1 -
 rust/kernel/lib.rs              | 2 --
 samples/rust/Kconfig            | 2 +-
 4 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 41cd42cd286f..9b3a4ab95818 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -74,7 +74,6 @@
 #include <linux/slab.h>
 #include <linux/task_work.h>
 #include <linux/tracepoint.h>
-#include <linux/usb.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 04103ab1a349..8e8277bdddca 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -48,7 +48,6 @@
 #include "task.c"
 #include "time.c"
 #include "uaccess.c"
-#include "usb.c"
 #include "vmalloc.c"
 #include "wait.c"
 #include "workqueue.c"
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 004ca70b816d..99dbb7b2812e 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -127,8 +127,6 @@
 pub mod tracepoint;
 pub mod transmute;
 pub mod types;
-#[cfg(CONFIG_USB = "y")]
-pub mod usb;
 pub mod uaccess;
 pub mod workqueue;
 pub mod xarray;
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 6d6e4d8c88cb..865a62a93ddc 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -85,7 +85,7 @@ config SAMPLE_RUST_DRIVER_PLATFORM
 
 config SAMPLE_RUST_DRIVER_USB
 	tristate "USB Driver"
-	depends on USB = y
+	depends on USB = y && BROKEN
 	help
 	  This option builds the Rust USB driver sample.
 
-- 
2.51.0


[1] For those not getting the sarcasm here, I'm that maintainer, and
    yes, Paris has some very good pizza :)

