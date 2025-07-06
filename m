Return-Path: <linux-kernel+bounces-715127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2B0AF715A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 13:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F421C21745
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 11:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACCE2E49AC;
	Thu,  3 Jul 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdIHqay0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587342E498A;
	Thu,  3 Jul 2025 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751540430; cv=none; b=aJ5bAgbGt8Oo/gl/9UtLK7AWr8oyQGLzVfRhXfHd66JILKEvJ7sWVXiRgzl2nuOsPR8ydCD9jj0HUr42pRmSzYkyaY2cHes9CmPuBnIFoDrVYfdSxX3+W91ByB82CrlC1BgWFf2IA3fyci3ILG7cQFYJNeYnv2F2lTsHCFqtV3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751540430; c=relaxed/simple;
	bh=Ib82rjmxVB/4uHkaCH4KJLsoHomS5YRNyB+GNi2QfO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqVPT11dsSXV5ThquC3MJ+QVFQistgmWwwAd+LQoKjIDHXCtbweFq8QCe8G0BJhFi97ghbl5uQDyAXIUOsKudVhRZH/KsNXIicCxzx+x3hSviMEQ9K/HP5PjfkwHyZULXYEUun7aFJhxfCYbpT6HMXoUBdp0IrojgTa26ZxFJcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdIHqay0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2BEC4CEEB;
	Thu,  3 Jul 2025 11:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751540429;
	bh=Ib82rjmxVB/4uHkaCH4KJLsoHomS5YRNyB+GNi2QfO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gdIHqay0D6RqD9E/DQq+r0h+l/A7PC1D9lULY2M+h+zn71qtTLI+NsAS+V7t856U4
	 QCfbq4NpUT9jKY0SdIzRrSoJQfVKIM8X7jB5CntWzWsGXCIVXGTmJSZcGiVk+z9QcY
	 QbbMROjFaxo/m1xQD8ROIkFwGqXmaX1RnmW+NM6/4RRknryC0MK2sGTR1EiW4Sfykt
	 DPukSpomYBUixqGY2v6b10q1ul26GRnF95/S7hWB2rX9KZKttgJjjab0CprwN/kmbz
	 LVxIFINc1kPTmQMOCU3azp1mg9WCCH8ywsVuTtIhYiCULj3xC1QLKAo7SZiyes4e2J
	 N/Nv5Xj8vLpig==
Date: Thu, 3 Jul 2025 13:00:23 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthew Maurer <mmaurer@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH v8 4/6] rust: debugfs: Support arbitrary owned backing
 for File
Message-ID: <aGZixxMG-IJ39lEn@pollux>
References: <5c3a2289-01c5-413e-9d7c-88a41c3f54e2@kernel.org>
 <CAGSQo038u_so+_pMRYj0K546zNfO5-eqoXFivXsEF6ACK=Y5cw@mail.gmail.com>
 <ce8f428b-fcb0-48dc-b13e-6717c9a851b4@kernel.org>
 <CAGSQo02hyJncD1oTpUMgiSZeX5UYYY2p-WZTyroQJJ6fMnOrCQ@mail.gmail.com>
 <aGLUl7ZtuQBPoCuv@pollux>
 <2025070131-icon-quarters-0c16@gregkh>
 <aGPtCBB6nWTNJuwK@pollux>
 <2025070137-tartar-juncture-fcd2@gregkh>
 <aGP6d2-jJy5rtjMK@pollux>
 <aGZVUqangIR-c4aW@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGZVUqangIR-c4aW@google.com>

On Thu, Jul 03, 2025 at 10:02:58AM +0000, Alice Ryhl wrote:
> On Tue, Jul 01, 2025 at 05:10:47PM +0200, Danilo Krummrich wrote:
> > On Tue, Jul 01, 2025 at 04:21:56PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Jul 01, 2025 at 04:13:28PM +0200, Danilo Krummrich wrote:
> > > > Instead this should just be:
> > > > 
> > > > 	struct GPU {
> > > > 	   fw: debugfs::File<Firmware>,
> > > > 	}
> > > > 
> > > > and then I would initialize it the following way:
> > > > 
> > > > 	let fw = KBox::new(Firmware::new(), GFP_KERNEL)?;
> > > > 	let file = dir.create_file("firmware", fw);
> > > > 
> > > > 	// debugfs::File<Firmware> dereferences to Firmware
> > > > 	file.do_something();
> > > > 
> > > > 	// Access to fw is prevented by the compiler, since it has been moved
> > > > 	// into file.
> > > > 
> > > > This is much better, since now I have the guarantee that my Firmare instance
> > > > can't out-live the GPU instance.
> > > 
> > > That's better, yes, but how would multiple files for the same
> > > "structure" work here?  Like a debugfs-file-per-field of a structure
> > > that we often have?
> > 
> > That is a very good question and I thought about this as well, because with only
> > the current API this would require us to have more and more dynamic allocations
> > if we want to have a more fine grained filesystem representations of structures.
> > 
> > The idea I have for this is to use pin-init, which we do in quite some other
> > places as well.
> > 
> > I think we can add an additional API like this:
> > 
> > 	impl Dir {
> > 	   pub fn create_file<T>(&self, data: impl PinInit<T>) -> impl PinInit<Self> {
> > 	      pin_init!(Self {
> > 	         data <- data,
> > 	         ...
> > 	      })
> > 	   }
> > 	}
> > 
> > This allows us to do things like:
> > 
> > 	#[pin_data]
> > 	struct Firmware {
> > 	   #[pin]
> > 	   minor: debugfs::File<u32>,
> > 	   #[pin]
> > 	   major: debugfs::File<u32>,
> > 	   #[pin]
> > 	   buffer: debugfs::File<[u8]>,
> > 	}
> > 
> > 	impl Firmware {
> > 	   pub fn new(&dir: debugfs::Dir, buffer: [u8]) -> impl PinInit<Self> {
> > 	      pin_init!(Self {
> > 	         minor <- dir.create_file("minor", 1),
> > 	         major <- dir.create_file("major", 2),
> > 	         buffer <- dir.create_file("buffer", buffer),
> > 	      })
> > 	   }
> > 	}
> > 
> > 	// This is the only allocation we need.
> > 	let fw = KBox::pin_init(Firmware::new(...), GFP_KERNEL)?;
> > 
> > With this everything is now in a single allocation and since we're using
> > pin-init, Dir::create_file() can safely store pointers of the corresponding data
> > in debugfs_create_file(), since this structure is guaranteed to be pinned in
> > memory.
> > 
> > Actually, we can also implement *only this*, since with this my previous example
> > would just become this:
> > 
> > 	struct GPU {
> > 	   fw: debugfs::File<Firmware>,
> > 	}
> > 
> > 	let file = dir.create_file("firmware", Firmware::new());
> > 	let file = KBox::pin_init(file, GFP_KERNEL)?;
> > 
> > 	// debugfs::File<Firmware> dereferences to Firmware
> > 	file.do_something();
> > 
> > Given that, I think we should change things to use pin-init right away for the
> > debugfs::File API.
> 
> Does this actually work in practice for anything except immutable data?
> I mean, let's take Rust Binder as an example and lets say that I want to
> expose a directory for each Process object with some of the fields
> exposed. Let's just simplify Rust Binder a bit and only include some of
> the fields:
> 
> #[pin_data]
> struct Process {
>     task: ARef<Task>,
>     #[pin]
>     inner: SpinLock<ProcessInner>,
> }
> 
> pub(crate) struct ProcessInner {
>     threads: RBTree<i32, Arc<Thread>>,
>     nodes: RBTree<u64, DArc<Node>>,
>     requested_thread_count: u32,
>     max_threads: u32,
>     started_thread_count: u32,
> }
> 
> Rust Binder already does expose some debugging data through a file
> system, though it doesn't do so using debugfs. It exposes a lot of data,
> but among them are the pid, the number of threads and nodes, as well as
> the values of requested_thread_count, started_thread_count, and
> max_threads.
> 
> Now, we run into problem number one: pinning is not supported inside
> mutexes. But let's say we solved that and we could do this:
> 
> #[pin_data]
> struct Process {
>     task: File<ARef<Task>>, // prints the pid
>     #[pin]
>     inner: SpinLock<ProcessInner>,
> }
> 
> pub(crate) struct ProcessInner {
>     threads: File<RBTree<i32, Arc<Thread>>>, // prints the count
>     nodes: File<RBTree<u64, DArc<Node>>>, // prints the count
>     requested_thread_count: File<u32>,
>     max_threads: File<u32>,
>     started_thread_count: File<u32>,
> }
> 
> However, this still doesn't work! Debugfs may get triggered at any time
> and need to read these fields, and there's no way for it to take the
> spinlock with the above design - it doesn't know where the spinlock is.
> For the integers I guess we could make them atomic to allow reading them
> in parallel with mutation, but that option is not available for the
> red/black trees.
> 
> What is the intended solution in this case? If the argument is that this
> is a rare case, then keep in mind that this is a real-world example of
> debugging information that we actually expose today in a real driver.

I'd like to question the decision of having a separate File for each member of
ProcessInner in this case a bit:

Given the decision to protect all members of ProcessInner with the same lock, I
assume that they are in a certain relationship to each other, such that it is
either necessary or (at least) makes the most sense to keep them synchronized
with each other.

In other words, you probably don't want that, for instance, changes on
requested_thread_count can race with threads, or max_threads, etc.

So the question I want to raise is, given that, does it make sense to expose
those values to userspace unsychronized to each other, i.e. through separate
files?

For instance:

	$ cat max_threads && cat threads
	$ 5
	$ 10

This way you may read 5 max_threads, but 10 actual threads, because things have
changed in between the two cat commands.

Or is it more that you want to expose them all at once, such that reading
those values from debugfs you can be sure that they were *all* captured under
the same lock at the same time and are in a valid relationship to each other?

For instance:

	$ cat process_info
	$ threads: 2
	$ nodes: 2
	$ requested_thread_count: 5
	$ max_threads: 10
	$ started_thread_count: 1

(I don't know if the numbers make sense semantically, but you get the idea.)

So, what I'm trying to say is, I think that usually we want to expose data
protected with the same lock as a whole and otherwise protect data that is
independant from other data with separate locks.

- Danilo

