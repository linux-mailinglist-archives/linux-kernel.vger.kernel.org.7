Return-Path: <linux-kernel+bounces-808441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F64FB4FFC2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B9E1C60134
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94740350844;
	Tue,  9 Sep 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="VnTco8KB"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CA434F49E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428996; cv=none; b=CP8RigB94gp/aa9ORFJFOZJg+P0aK/0E8DzrldQkDPqvRQI0jgAta+4Y5eLEdU4M74mYTgqfHCOILwokwQgaKd0gqL3qBaB/cxYrG8rTp5zPKEUm4b0sa6Kncs7TCDpjaEXgqN0XIIcYGUdN3AYymb1RPBIFRgAzH+Mzw9QaZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428996; c=relaxed/simple;
	bh=kZsPvc1qbpj/gMZ9DpWcp5bZPO/uvzGdQpRMrhizyWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NceEH27A9U1luUB9onctG5cOu3E/R6RvsBGx+webkBRR8Hzer2YElO5+NKOn9zvSfBjQZS3tKLABBjP6c4RG5EXSltlaY3N8bQJ7xs5Lm37gbrWVa+T1f1NLHDkfrYERbTrrhffle46asCwUf84iEea+tAU0RH4kxFpx1E7wWxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=VnTco8KB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-25669596921so20926625ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1757428994; x=1758033794; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ddrCOGQrTk4YnXFxSW8TsT6ATPKz9oABWw9Dn9DJNeo=;
        b=VnTco8KBuR+foyDbPPs2k5BaCq3hw7833lztpl+dYU9WOW+WxH18sfdJnOIW9PhnRj
         vodWHS72+E04YHPbrwkyROO1BQgbbgGHvb3VNbiOeSyVrWrktMWNmAy24mNwTCb1eKzk
         AWxagRq8es04G0qRnkBfJX5Q7Q9McDMON6QcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757428994; x=1758033794;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddrCOGQrTk4YnXFxSW8TsT6ATPKz9oABWw9Dn9DJNeo=;
        b=YEy0t63WvPlVA14pvgqCfdRHXb+AZ3UNCX3iKcnvqIoAdcmSKWtXC+hVBpeDghojsH
         0CWD/e7oXBIQg25iA3kCQ5wH/d4zDT/7F003XNM4LGr3DVFNIMLo3RmLpXlRaHsbNI+/
         H/OdzLT9038ErseFvdmBqNI0J2Gmf1NoTEDmG2aWmu0SkJBHM+ItqWAzNZb0MnEeNC3i
         7mplgq4GhHrC8j+u539MaZ6baBzV2DUPs/78PzHuAzjO9S+BvuQeL6r6+ON+/QGm8WOk
         aOECG8YSTz59NoNWy3cpqJd7sh4cqH0XaQlxKZDfFQhoXbmfZ1CRkJc84K+w0jqQWAmX
         ORlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUriYSN8aWoLV3w/eEyQTghzN33FPaTzKB+Vrk0+tooRyRknuLAWccnu4nV0kUVybWV9LJjc/yCwCkKZ50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3S58KbXH6BUVLfju3hLiZcBIymwgomCl4+TcONJFjYiNma7xC
	ghfCY+dMLJObt6LkhCgLGUaJtteWus84MOl3uiSE+3vEHhftHfk25ec2dyszTs19Wcs=
X-Gm-Gg: ASbGncvOSgAS3NUAfk/LE8hFTw2Otxs64qyV9+gSGxHQf3C1XoKOdeDvpzYpBcNv8IF
	Ss5jVb/OswuI7mMszy+UYKKZ5s2YIFTOVmpx3VRiYECfHi3v+IlXe3psIxqKxQ/tmu8TOrYNp48
	M2wTsBAkk/XEWAy2akQA6+FikCrXpPR9CaZDsCV3oZFBAbIcUDT8ds3JxD8ATZFcrDUQBz20k/j
	EylQYEH0mVYArsP0k+fvKaF5TT8lWzNjkpCcF6YMUsLNlUs/21lRMtZ1VTYpeScllv5Pm8SNqMc
	eYARxYie65DASbLEMVvu/EDCqOJvXBflG6KTLI8CpXb6ZkQuPYhebwhIHwgO6i1qC1j6SzeuQEA
	exeTIMiHUb33S2xZcfvGRm4nTzz/i+866wIp2QmClY68rqUhbKVv2nw==
X-Google-Smtp-Source: AGHT+IF0maZnaaLQLAz9HyDOMDlcVgeagw7Fn/NEgjbTn/SufuWhh4SmMvMtEn5ZIob4ZX3rKUzR3A==
X-Received: by 2002:a17:903:b48:b0:258:dc72:9d76 with SMTP id d9443c01a7336-258dc729f05mr38100225ad.10.1757428994417;
        Tue, 09 Sep 2025 07:43:14 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a281e5620sm313525ad.63.2025.09.09.07.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:43:13 -0700 (PDT)
Date: Tue, 9 Sep 2025 23:43:08 +0900
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
Message-ID: <aMA8_MuU0V-_ja5O@sidongui-MacBookPro.local>
References: <20250822125555.8620-1-sidong.yang@furiosa.ai>
 <20250822125555.8620-3-sidong.yang@furiosa.ai>
 <CADUfDZpsePAbEON_90frzrPCPBt-a=1sW2Q=i8BGS=+tZhudFA@mail.gmail.com>
 <aLbFiChBnTNLBAyV@sidongui-MacBookPro.local>
 <CADUfDZpPvj3R7kzWC9bQVV0iuCBOnKsNUFn=B3ivf7De5wCB8g@mail.gmail.com>
 <aLxFAamglufhUvq0@sidongui-MacBookPro.local>
 <CADUfDZruwQyOcAeOXkXMLX+_HgOBeYdHUmgnJdT5pGQEmXt9+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZruwQyOcAeOXkXMLX+_HgOBeYdHUmgnJdT5pGQEmXt9+g@mail.gmail.com>

On Mon, Sep 08, 2025 at 12:45:58PM -0700, Caleb Sander Mateos wrote:
> On Sat, Sep 6, 2025 at 7:28 AM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> >
> > On Tue, Sep 02, 2025 at 08:31:00AM -0700, Caleb Sander Mateos wrote:
> > > On Tue, Sep 2, 2025 at 3:23 AM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> > > >
> > > > On Mon, Sep 01, 2025 at 05:34:28PM -0700, Caleb Sander Mateos wrote:
> > > > > On Fri, Aug 22, 2025 at 5:56 AM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> > > > > >
> > > > > > The pdu field in io_uring_cmd may contain stale data when a request
> > > > > > object is recycled from the slab cache. Accessing uninitialized or
> > > > > > garbage memory can lead to undefined behavior in users of the pdu.
> > > > > >
> > > > > > Ensure the pdu buffer is cleared during io_uring_cmd_prep() so that
> > > > > > each command starts from a well-defined state. This avoids exposing
> > > > > > uninitialized memory and prevents potential misinterpretation of data
> > > > > > from previous requests.
> > > > > >
> > > > > > No functional change is intended other than guaranteeing that pdu is
> > > > > > always zero-initialized before use.
> > > > > >
> > > > > > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > > > > > ---
> > > > > >  io_uring/uring_cmd.c | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> > > > > > index 053bac89b6c0..2492525d4e43 100644
> > > > > > --- a/io_uring/uring_cmd.c
> > > > > > +++ b/io_uring/uring_cmd.c
> > > > > > @@ -203,6 +203,7 @@ int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
> > > > > >         if (!ac)
> > > > > >                 return -ENOMEM;
> > > > > >         ioucmd->sqe = sqe;
> > > > > > +       memset(&ioucmd->pdu, 0, sizeof(ioucmd->pdu));
> > > > >
> > > > > Adding this overhead to every existing uring_cmd() implementation is
> > > > > unfortunate. Could we instead track the initialized/uninitialized
> > > > > state by using different types on the Rust side? The io_uring_cmd
> > > > > could start as an IoUringCmd, where the PDU field is MaybeUninit,
> > > > > write_pdu<T>() could return a new IoUringCmdPdu<T> that guarantees the
> > > > > PDU has been initialized.
> > > >
> > > > I've found a flag IORING_URING_CMD_REISSUE that we could initialize
> > > > the pdu. In uring_cmd callback, we can fill zero when it's not reissued.
> > > > But I don't know that we could call T::default() in miscdevice. If we
> > > > make IoUringCmdPdu<T>, MiscDevice also should be MiscDevice<T>.
> > > >
> > > > How about assign a byte in pdu for checking initialized? In uring_cmd(),
> > > > We could set a byte flag that it's not initialized. And we could return
> > > > error that it's not initialized in read_pdu().
> > >
> > > Could we do the zero-initialization (or T::default()) in
> > > MiscdeviceVTable::uring_cmd() if the IORING_URING_CMD_REISSUE flag
> > > isn't set (i.e. on the initial issue)? That way, we avoid any
> > > performance penalty for the existing C uring_cmd() implementations.
> > > I'm not quite sure what you mean by "assign a byte in pdu for checking
> > > initialized".
> >
> > Sure, we could fill zero when it's the first time uring_cmd called with
> > checking the flag. I would remove this commit for next version. I also
> > suggests that we would provide the method that read_pdu() and write_pdu().
> > In read_pdu() I want to check write_pdu() is called before. So along the
> > 20 bytes for pdu, maybe we could use a bytes for the flag that pdu is
> > initialized?
> 
> Not sure what you mean about "20 bytes for pdu".
> It seems like it would be preferable to enforce that write_pdu() has
> been called before read_pdu() using the Rust type system instead of a
> runtime check. I was thinking a signature like fn write_pdu(cmd:
> IoUringCmd, value: T) -> IoUringCmdPdu<T>. Do you feel there's a
> reason that wouldn't work and a runtime check would be necessary?

I didn't think about make write_pdu() to return IoUringCmdPdu<T> before.
I think it's good way to pdu is safe without adding a new generic param for
MiscDevice. write_pdu() would return IoUringCmdPdu<T> and it could call
IoUringCmdPdu<T>::pdu(&mut self) -> &mut T safely maybe.

> 
> >
> > But maybe I would introduce a new struct that has Pin<&mut IoUringCmd> and
> > issue_flags. How about some additional field for pdu is initialized like below?
> >
> > struct IoUringCmdArgs {
> >   ioucmd: Pin<&mut IoUringCmd>,
> >   issue_flags: u32,
> >   pdu_initialized: bool,
> > }
> 
> One other thing I realized is that issue_flags should come from the
> *current* context rather than the context the uring_cmd() callback was
> called in. For example, if io_uring_cmd_done() is called from task
> work context, issue_flags should match the issue_flags passed to the
> io_uring_cmd_tw_t callback, not the issue_flags originally passed to
> the uring_cmd() callback. So it probably makes more sense to decouple
> issue_flags from the (owned) IoUringCmd. I think you could pass it by
> reference (&IssueFlags) or with a phantom reference lifetime
> (IssueFlags<'_>) to the Rust uring_cmd() and task work callbacks to
> ensure it can't be used after those callbacks have returned.

I have had no idea about task work context. I agree with you that
it would be better to separate issue_flags from IoUringCmd. So, 
IoUringCmdArgs would have a only field Pin<&mut IoUringCmd>?

> 
> Best,
> Caleb

