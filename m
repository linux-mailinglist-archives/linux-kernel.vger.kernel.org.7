Return-Path: <linux-kernel+bounces-815178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBABB560E0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 14:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7201C80F9F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 12:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B8026F29B;
	Sat, 13 Sep 2025 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="ffeKwQDH"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4556F2C0F67
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757767331; cv=none; b=l1oa7vJ3tHUpG+ZVHFj33rIowX6meN+kbuA+qhYbf9X+0ieqEWQPAMFsCkSvkyVS7eLrBPfMLF9KZy9rHmRuDVEJhv6rhA3VPFYXllHtxFFErbCvZnRgilYBEJTYzUYLqkOAYs1KQZRIyXli8ngWdXrRIQDB8puzijWyX+2roZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757767331; c=relaxed/simple;
	bh=kIhxFXQIQTNc+Iy/xvLDG6uUq5A0jNQrqhGjefi8q94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+8RfmquF6wGdkrNsG5QU3j0M2ZlumWiASO7TSFxVxlHpPOIWHiw0rRbPypNzA83p97XX2cdsDVAT9MfkdwyiRckG/jXjokgPgUBdy4JWsWbNFdITQWX9WXV5EEPBoRNgJQ0236v78c7XSfD2EIV1PwTy226meU+DuMvnXPrT58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=ffeKwQDH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2570bf605b1so25878815ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 05:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1757767329; x=1758372129; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/9duoDwLODdQr2eNa1OtOkxFDQUPt6wjgx1Athkl2o0=;
        b=ffeKwQDHukvgU7T9sFTLQx5IBJdmrcYRYVaM9TWpuHu0HOrWgJOimG094wIPTBsg7y
         VEtxlZvRjAmw+2xdQRe6LoBacxOfmnUcN+UCEqsLcvqhaMfzz3G223DsHqPZf/8hZY+Q
         FZw3KFZ0hwQVJ1XQp3sL9VBumq/ABmBxHHnLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757767329; x=1758372129;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9duoDwLODdQr2eNa1OtOkxFDQUPt6wjgx1Athkl2o0=;
        b=FVMNTRVmqMfpbSZw9BRtZOwG15+qNshPutc7mVvzcOSZHSVogQjInArX7wLh+KxHXc
         pYLi0mi7u/V4HiPWZMmn1SbSk2fhLTn7M/qbXG+9mFSF0pINV0h61NWu7/j8R+w19/rl
         2tmKhzz/qVrOUrD+7ev4sDjzku6GWyQHrRQ4B4o8sRUdMoI9SXZLtANMfYPG0O2IC1tS
         O7A+Eak9aolzWqElSrUnXxhtUbhG6/Qts55yVQ7FRak+1C5hph6oz5oZ3aMPjb4p3pvm
         lNCSvfBzh5y1kF4JGqyBCtk/vtXvewqD0Lmdtf4IMC/E65Nlf5BWDfVTOwwFCIjfm6yQ
         j20Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJ40KrK8HzENiQ5ENy/Zj6MHYtmAF2s2Nt9SvqdkrWkuu75+3q9NuJoaj0XwMPlogA4FMCyekgg2lvqH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyttdA+At8H0kA6MoyCJmCAlKCTUSD8EwxuK/bqQFUq2bmsH5vf
	HEN+JxYpjLwn8ls8Y+kC0m4THrvzOemXO+/lDFR2ukO51LXMuBBLbqW6/2zpTAZE75Dn8jeYPaY
	0UwntZQc=
X-Gm-Gg: ASbGncuFU6VCoNI45V/YsqHc/X/Shn8euPxXOggLSXnlb728vPPHldMjc9Jx/GOMx71
	PTRX4qp5Jr2JQ1+09lcBMKPNAlumEOQF0brTewK7DiueJwZ+2qSXDTB/zpUz8yDVGDRhP7hWBuN
	UTs7x9N7gIaqVgiVwGsCVwE1YoUdtn3IUSnEgl1BP3QSXzTT1YCtnSKCRZGrBtd/lKyADzyOxzK
	220TmYXCzS/VrZD4J+PzB27ziCNU+IZi8MI54lnNqEUk4zgGf68WzVml39a8S31sjgLOa0jqsaI
	s41253qv5DJKMld2rClyWzKU31WSj8jXhF05YVisvBfEjtYCzq0eS7uyUo6OEZd5UVSfKjxBBZf
	fckqzYtHHYIa5RcOL11WxU5IFeNcKGN18tX9DJx2QtL2+Hq3SoJPrYne7Ibf2dZjMQPE=
X-Google-Smtp-Source: AGHT+IEfGVve+qOntlhQUD55T5Er2IYX9b3WcF5xwrm+kFXlXuC2bwamQsqYr8LU2tYzB+cRguk2Iw==
X-Received: by 2002:a17:902:db04:b0:262:d081:96c with SMTP id d9443c01a7336-262d0810e05mr11980195ad.17.1757767329394;
        Sat, 13 Sep 2025 05:42:09 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ad2fa37sm74210085ad.111.2025.09.13.05.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 05:42:08 -0700 (PDT)
Date: Sat, 13 Sep 2025 21:42:03 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/5] io_uring/cmd: zero-init pdu in
 io_uring_cmd_prep() to avoid UB
Message-ID: <aMVmm1Ydt4iOfxu5@sidongui-MacBookPro.local>
References: <20250822125555.8620-3-sidong.yang@furiosa.ai>
 <CADUfDZpsePAbEON_90frzrPCPBt-a=1sW2Q=i8BGS=+tZhudFA@mail.gmail.com>
 <aLbFiChBnTNLBAyV@sidongui-MacBookPro.local>
 <CADUfDZpPvj3R7kzWC9bQVV0iuCBOnKsNUFn=B3ivf7De5wCB8g@mail.gmail.com>
 <aLxFAamglufhUvq0@sidongui-MacBookPro.local>
 <CADUfDZruwQyOcAeOXkXMLX+_HgOBeYdHUmgnJdT5pGQEmXt9+g@mail.gmail.com>
 <aMA8_MuU0V-_ja5O@sidongui-MacBookPro.local>
 <CADUfDZppdnM2QAeX37OmZsXqd7sO7KvyLnNPUYOgLpWMb+FpoQ@mail.gmail.com>
 <aMRNSBHDM4nkewHO@sidongui-MacBookPro.local>
 <CADUfDZrHse9nDxfd0UDkxOEmVRg-b=KDEUZ9Hz08eojXJvgtng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrHse9nDxfd0UDkxOEmVRg-b=KDEUZ9Hz08eojXJvgtng@mail.gmail.com>

On Fri, Sep 12, 2025 at 10:56:31AM -0700, Caleb Sander Mateos wrote:
> On Fri, Sep 12, 2025 at 9:42 AM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> >
> > On Tue, Sep 09, 2025 at 09:32:37AM -0700, Caleb Sander Mateos wrote:
> > > On Tue, Sep 9, 2025 at 7:43 AM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> > > >
> > > > On Mon, Sep 08, 2025 at 12:45:58PM -0700, Caleb Sander Mateos wrote:
> > > > > On Sat, Sep 6, 2025 at 7:28 AM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> > > > > >
> > > > > > On Tue, Sep 02, 2025 at 08:31:00AM -0700, Caleb Sander Mateos wrote:
> > > > > > > On Tue, Sep 2, 2025 at 3:23 AM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> > > > > > > >
> > > > > > > > On Mon, Sep 01, 2025 at 05:34:28PM -0700, Caleb Sander Mateos wrote:
> > > > > > > > > On Fri, Aug 22, 2025 at 5:56 AM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> > > > > > > > > >
> > > > > > > > > > The pdu field in io_uring_cmd may contain stale data when a request
> > > > > > > > > > object is recycled from the slab cache. Accessing uninitialized or
> > > > > > > > > > garbage memory can lead to undefined behavior in users of the pdu.
> > > > > > > > > >
> > > > > > > > > > Ensure the pdu buffer is cleared during io_uring_cmd_prep() so that
> > > > > > > > > > each command starts from a well-defined state. This avoids exposing
> > > > > > > > > > uninitialized memory and prevents potential misinterpretation of data
> > > > > > > > > > from previous requests.
> > > > > > > > > >
> > > > > > > > > > No functional change is intended other than guaranteeing that pdu is
> > > > > > > > > > always zero-initialized before use.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > > > > > > > > > ---
> > > > > > > > > >  io_uring/uring_cmd.c | 1 +
> > > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> > > > > > > > > > index 053bac89b6c0..2492525d4e43 100644
> > > > > > > > > > --- a/io_uring/uring_cmd.c
> > > > > > > > > > +++ b/io_uring/uring_cmd.c
> > > > > > > > > > @@ -203,6 +203,7 @@ int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
> > > > > > > > > >         if (!ac)
> > > > > > > > > >                 return -ENOMEM;
> > > > > > > > > >         ioucmd->sqe = sqe;
> > > > > > > > > > +       memset(&ioucmd->pdu, 0, sizeof(ioucmd->pdu));
> > > > > > > > >
> > > > > > > > > Adding this overhead to every existing uring_cmd() implementation is
> > > > > > > > > unfortunate. Could we instead track the initialized/uninitialized
> > > > > > > > > state by using different types on the Rust side? The io_uring_cmd
> > > > > > > > > could start as an IoUringCmd, where the PDU field is MaybeUninit,
> > > > > > > > > write_pdu<T>() could return a new IoUringCmdPdu<T> that guarantees the
> > > > > > > > > PDU has been initialized.
> > > > > > > >
> > > > > > > > I've found a flag IORING_URING_CMD_REISSUE that we could initialize
> > > > > > > > the pdu. In uring_cmd callback, we can fill zero when it's not reissued.
> > > > > > > > But I don't know that we could call T::default() in miscdevice. If we
> > > > > > > > make IoUringCmdPdu<T>, MiscDevice also should be MiscDevice<T>.
> > > > > > > >
> > > > > > > > How about assign a byte in pdu for checking initialized? In uring_cmd(),
> > > > > > > > We could set a byte flag that it's not initialized. And we could return
> > > > > > > > error that it's not initialized in read_pdu().
> > > > > > >
> > > > > > > Could we do the zero-initialization (or T::default()) in
> > > > > > > MiscdeviceVTable::uring_cmd() if the IORING_URING_CMD_REISSUE flag
> > > > > > > isn't set (i.e. on the initial issue)? That way, we avoid any
> > > > > > > performance penalty for the existing C uring_cmd() implementations.
> > > > > > > I'm not quite sure what you mean by "assign a byte in pdu for checking
> > > > > > > initialized".
> > > > > >
> > > > > > Sure, we could fill zero when it's the first time uring_cmd called with
> > > > > > checking the flag. I would remove this commit for next version. I also
> > > > > > suggests that we would provide the method that read_pdu() and write_pdu().
> > > > > > In read_pdu() I want to check write_pdu() is called before. So along the
> > > > > > 20 bytes for pdu, maybe we could use a bytes for the flag that pdu is
> > > > > > initialized?
> > > > >
> > > > > Not sure what you mean about "20 bytes for pdu".
> > > > > It seems like it would be preferable to enforce that write_pdu() has
> > > > > been called before read_pdu() using the Rust type system instead of a
> > > > > runtime check. I was thinking a signature like fn write_pdu(cmd:
> > > > > IoUringCmd, value: T) -> IoUringCmdPdu<T>. Do you feel there's a
> > > > > reason that wouldn't work and a runtime check would be necessary?
> > > >
> > > > I didn't think about make write_pdu() to return IoUringCmdPdu<T> before.
> > > > I think it's good way to pdu is safe without adding a new generic param for
> > > > MiscDevice. write_pdu() would return IoUringCmdPdu<T> and it could call
> > > > IoUringCmdPdu<T>::pdu(&mut self) -> &mut T safely maybe.
> > >
> > > Yes, that's what I was thinking.
> >
> > Good, I'll change api in this way. Thanks!
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > But maybe I would introduce a new struct that has Pin<&mut IoUringCmd> and
> > > > > > issue_flags. How about some additional field for pdu is initialized like below?
> > > > > >
> > > > > > struct IoUringCmdArgs {
> > > > > >   ioucmd: Pin<&mut IoUringCmd>,
> > > > > >   issue_flags: u32,
> > > > > >   pdu_initialized: bool,
> > > > > > }
> > > > >
> > > > > One other thing I realized is that issue_flags should come from the
> > > > > *current* context rather than the context the uring_cmd() callback was
> > > > > called in. For example, if io_uring_cmd_done() is called from task
> > > > > work context, issue_flags should match the issue_flags passed to the
> > > > > io_uring_cmd_tw_t callback, not the issue_flags originally passed to
> > > > > the uring_cmd() callback. So it probably makes more sense to decouple
> > > > > issue_flags from the (owned) IoUringCmd. I think you could pass it by
> > > > > reference (&IssueFlags) or with a phantom reference lifetime
> > > > > (IssueFlags<'_>) to the Rust uring_cmd() and task work callbacks to
> > > > > ensure it can't be used after those callbacks have returned.
> > > >
> > > > I have had no idea about task work context. I agree with you that
> > > > it would be better to separate issue_flags from IoUringCmd. So,
> > > > IoUringCmdArgs would have a only field Pin<&mut IoUringCmd>?
> > >
> > > "Task work" is a mechanism io_uring uses to queue work to run on the
> > > thread that submitted an io_uring operation. It's basically a
> > > per-thread atomic queue of callbacks that the thread will process
> > > whenever it returns from the kernel to userspace (after a syscall or
> > > an interrupt). This is the context where asynchronous uring_cmd
> > > completions are generally processed (see
> > > io_uring_cmd_complete_in_task() and io_uring_cmd_do_in_task_lazy()). I
> > > can't speak to the history of why io_uring uses task work, but my
> > > guess would be that it provides a safe context to acquire the
> > > io_ring_ctx uring_lock mutex (e.g. nvme_uring_cmd_end_io() can be
> > > called from an interrupt handler, so it's not allowed to take a
> > > mutex). Processing all the task work at once also provides natural
> > > opportunities for batching.
> >
> > Thanks, I've checked io_uring_cmd_complete_in_task() that it receives
> > callback that has issue_flags different with io_uring_cmd(). I'll try to add
> > a api that wrapping io_uring_cmd_complete_in_task() for next version.
> >
> > >
> > > Yes, we probably don't need to bundle anything else with the
> > > IoUringCmd after all. As I mentioned earlier, I don't think Pin<&mut
> > > IoUringCmd> will work for uring_cmds that complete asynchronously, as
> > > they will need to outlive the uring_cmd() call. So uring_cmd() needs
> > > to transfer ownership of the struct io_uring_cmd.
> >
> > I can't think that how to take ownership of struct io_uring_cmd. The
> > struct allocated with io_alloc_req() and should be freed with io_free_req().
> > If taking ownership means having pointer of struct io_uring_cmd, I think
> > it's no difference with current version. Also could it be called with
> > mem::forget() if it has ownership?
> 
> I don't mean ownership of the io_uring_cmd allocation; that's the
> responsibility of the io_uring layer. But once the io_uring_cmd is
> handed to the uring_cmd() implementation, it belongs to that layer
> until it completes the command back to io_uring. Maybe a better way to
> describe it would be as ownership of the "executing io_uring_cmd". The
> problem with Pin<&mut IoUringCmd> is that it is a borrowed reference
> to the io_uring_cmd, so it can't outlive the uring_cmd() callback.
> Yes, it's possible to leak the io_uring_cmd by never calling
> io_uring_cmd_done() to return it to the io_uring layer.

Thanks, I understood that IoUringCmd could be outlive uring_cmd callback.
But it's sad that it could be leaked without any unsafe code.

> 
> I would imagine something like this:
> 
> #[derive(Clone, Copy)]
> struct IssueFlags<'a>(c_uint, PhantomData<&'a ()>);
> 
> // Indicates ownership of the io_uring_cmd between uring_cmd() and
> io_uring_cmd_done()
> struct IoUringCmd(NonNull<bindings::io_uring_cmd>);
> 
> impl IoUringCmd {
>         // ...
> 
>         fn done(self, ret: i32, res2: u64, issue_flags: IssueFlags<'_>) {
>                 let cmd = self.0.as_ptr();
>                 let issue_flags = issue_flags.0;
>                 unsafe {
>                         bindings::io_uring_cmd_done(cmd, ret, res2, issue_flags)
>                 }
>         }
> }
> 
> // Can choose whether to complete the command synchronously or asynchronously.
> // If take_async() is called, IoUringCmd::done() needs to be called to
> complete the command.
> // If take_async() isn't called, the command is completed synchronously
> // with the return value from MiscDevice::uring_cmd().
> struct UringCmdInput<'a>(&mut Option<NonNull<bindings::io_uring_cmd>>);

Thanks for a detailed example!

But rather than this, We could introduce new return type that has a callback that
user could take IoUringCmd instead of returning -EIOCBQUEUED. 

But I prefer that we provide just one type IoUringCmd without UringCmdInput.
Although UringCmdInput, user could call done() in uring_cmd callback and 
it makes confusion that whether task_async() called and returning -EIOCBQUEUED
is mismatched that returns -EINVAL. We don't need to make it complex.

Thanks,
Sidong
> 
> impl UringCmdInput<'_> {
>         fn take_async(self) -> IoUringCmd {
>                 IoUringCmd(self.0.take().unwrap())
>         }
> }
> 
> trait MiscDevice {
>         // ...
> 
>         fn uring_cmd(
>                 _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
>                 _cmd: UringCmdInput<'_>,
>                 _ issue_flags: IssueFlags <'_>,
>         ) -> Result<i32> {
>                 build_error!(VTABLE_DEFAULT_ERROR)
>         }
> }
> 
> impl<T: MiscDevice> MiscdeviceVTable<T> {
>         // ...
> 
>         unsafe extern "C" fn uring_cmd(
>                 ioucmd: *mut bindings::io_uring_cmd,
>                 issue_flags: c_uint,
>         ) -> c_int {
>                 let raw_file = unsafe { (*ioucmd).file };
>                 let private = unsafe { (*raw_file).private_data }.cast();
>                 let device = unsafe { <T::Ptr as
> ForeignOwnable>::borrow(private) };
>                 let mut ioucmd = Some(NonNull::new(ioucmd).unwrap());
>                 let issue_flags = IssueFlags(issue_flags, PhantomData);
>                 let ret = T::uring_cmd(device, UringCmdInput(&mut
> ioucmd), issue_flags);
>                 // -EIOCBQUEUED indicates ownership of io_uring_cmd
> has been taken
>                 if iou_cmd.is_none() {
>                         return -bindings::EIOCBQUEUED;
>                 }
> 
>                 let ret = from_result(|| ret);
>                 if ret == -bindings::EIOCBQUEUED {
>                         -bindings::EINVAL
>                 } else {
>                         ret
>                 }
>         }
> }
> 
> Best,
> Caleb

