Return-Path: <linux-kernel+bounces-741015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF43B0DEEB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3AB3A7A21
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A177E2EA752;
	Tue, 22 Jul 2025 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="BEtMaDSW"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B892EA177
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194810; cv=none; b=tL1v6/tZZzRPwscqhGHSnrWh5K0uiw+H73Fd570x8aUiPvoBvxCRwCkzF+FiyRYAL12Mmdo+cQ14vxdiOL2js2+abLhENU+P48Q7ljID24gy2+BuVfOvAd69hoBB7Jg8ZbsgNkOmTT4/x67KOP3V9oymIMH5QULqghVrln1l9D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194810; c=relaxed/simple;
	bh=fv7AJ047lftjYrvdeOh9awJwbVijUB3ZG9yyk9jPZz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TflFn/cxHe8AVKmqa0VhMG8I6RHKP4Ug5278yX0PewZGEgSkUWm4T/oG56kio0abYwX+0gkdKEycQ5wjNmd8TnG4rqWRPEXqxAhyEYF4atcjAvVp9U/5MQ2Oeife7YeMN26dQMNTDANztPR6wApbEOrhAykX1RMI+CWfGXuh9Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=BEtMaDSW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748d982e97cso4986169b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1753194808; x=1753799608; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M7fGZKT3ggFMUdBYkzEIRO465LQFB1F7egGN40OaEMk=;
        b=BEtMaDSWRnEErqlT7JMROzTBNDaniQfYpuvkkaLWdVuc8S/uZcH9ZMvOvWoCBql8j5
         O0VLmGKvWpCx70qaln764Y2bXuHS7ZlA8U1kNnT421YQ7RFZojot5ittvwVjW5NsUMsr
         ZKoy93gkMtr+TpKupcYAdB8wQtVIAcY/VnVWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194808; x=1753799608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7fGZKT3ggFMUdBYkzEIRO465LQFB1F7egGN40OaEMk=;
        b=EH38+I4FZCKfhHePN0nGWiyoA4HvGjwppSyYfFjxwsuu766AvkL2FraBBaQtE/nVt0
         fcwkz1tmOzoLlhf47LxF8mwasO8g9pPnVxjtbcglObX7o0ODflXK0FtjOpbEA9y1l+zv
         KzEmCqgzx/A89rI5aLePCWmPOOua2KwfkoncjKuPOj/KdGRTnCel48LhLzsIH3MWNJ+/
         AfD24/YhpagocV2UyLI0E03lnhuV5YtuP51ft5YWUkS+3KKZdyFLPDHknadw4nZyRRHb
         hG7bmZH8TnaPESwTiQ+ukQsuMdCer8A6nxzWyR4/hzIz+gIovT83Ab4w0b6dZ9v57hMp
         jw4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeSzvd6HeARwKnpXZeyNt3aS9ReT8qXaOz1WY+ZFLYrah/N0bvhsaJOpqf6y3hUn7WPwPdKFL7Pjc5pgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvHI9jzR3FIwCBdjhsqkmy581wuRZy4WIik8o6IY3zeFPF3Wnb
	EM7i25uRDmWp++Q6NuG/LMK31fisxPC5tbvlK2ScWIe2heH5txKCLMoXn2HMVKKx0xQHSTeMw8P
	38AcC
X-Gm-Gg: ASbGnctGsCh2uOvZ4sDTJOoUH1Y7lWD3nCOvXe33hKk3DK3ao52demLPrJKaJ/mST5r
	TLBhTI6srp9tSvaoq/HNHuNu3mkjQxP//vUua8GhS1zGwHW0VotjhPXlNEcIy+N3McQ+/mTg9VF
	pfuL6GRCF95p5b+pgNDj+TqbFMYZtr7BCCJXKaloOovOGOE4ZulZbTIOqsmhtTXv8S7Uu5OgKtc
	tsGT2KMWVAlVTsBMlGl0qIB47v3j4/N6FnLSZ3mS9MMV38YuUmfoOgzqkomiOtBDNErH1ukUphO
	y9wujBBFoOtTeKA/hWEmOQ610TzOVVyL0TszKdOhEPuCZA6bBxsM8AIxiqvp+u1cjOBCh0BWsOW
	ATN4bJ4POOxNQSqriwWDAWWSl7QojFy+aMbhTe6Nk9TGQbC4mOMExKEJKpUg1qlrQozRu7w==
X-Google-Smtp-Source: AGHT+IFWFM/ezEnw+gUjX3lXlEi7sZO9lCCQrwj/IgdE0HPpAyeUUj5d+7M3EkDn2sTRy7/yVS+0Jg==
X-Received: by 2002:a05:6300:6199:b0:232:9550:128f with SMTP id adf61e73a8af0-23813237521mr37395363637.36.1753194807942;
        Tue, 22 Jul 2025 07:33:27 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e2008sm7230211b3a.30.2025.07.22.07.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 07:33:27 -0700 (PDT)
Date: Tue, 22 Jul 2025 23:33:21 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Benno Lossin <lossin@kernel.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH 2/4] rust: io_uring: introduce rust abstraction for
 io-uring cmd
Message-ID: <aH-hMYr4u95x03H0@sidongui-MacBookPro.local>
References: <20250719143358.22363-1-sidong.yang@furiosa.ai>
 <20250719143358.22363-3-sidong.yang@furiosa.ai>
 <CADUfDZoBrnDpnTOxiDq6pBkctJ3NDJq7Wcqm2pUu_ooqMy8yyw@mail.gmail.com>
 <aH3OsKD6l18pLG92@sidongui-MacBookPro.local>
 <CADUfDZrLKrf6evTXQ03cJ1W4kj0gxsF9Bopu+i2SjkBObXKnMA@mail.gmail.com>
 <DBHUR00PDVO2.16BCDQ94SF29J@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DBHUR00PDVO2.16BCDQ94SF29J@kernel.org>

On Mon, Jul 21, 2025 at 05:52:41PM +0200, Benno Lossin wrote:
> On Mon Jul 21, 2025 at 5:04 PM CEST, Caleb Sander Mateos wrote:
> > On Mon, Jul 21, 2025 at 1:23 AM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> >> On Sun, Jul 20, 2025 at 03:10:28PM -0400, Caleb Sander Mateos wrote:
> >> > On Sat, Jul 19, 2025 at 10:34 AM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> >> > > +    }
> >> > > +
> >> > > +    // Called by consumers of io_uring_cmd, if they originally returned -EIOCBQUEUED upon receiving the command
> >> > > +    #[inline]
> >> > > +    pub fn done(self, ret: isize, res2: u64, issue_flags: u32) {
> >> >
> >> > I don't think it's safe to move io_uring_cmd. io_uring_cmd_done(), for
> >> > example, calls cmd_to_io_kiocb() to turn struct io_uring_cmd *ioucmd
> >> > into struct io_kiocb *req via a pointer cast. And struct io_kiocb's
> >> > definitely need to be pinned in memory. For example,
> >> > io_req_normal_work_add() inserts the struct io_kiocb into a linked
> >> > list. Probably some sort of pinning is necessary for IoUringCmd.
> >>
> >> Understood, Normally the users wouldn't create IoUringCmd than use borrowed cmd
> >> in uring_cmd() callback. How about change to &mut self and also uring_cmd provides
> >> &mut IoUringCmd for arg.
> >
> > I'm still a little worried about exposing &mut IoUringCmd without
> > pinning. It would allow swapping the fields of two IoUringCmd's (and
> > therefore struct io_uring_cmd's), for example. If a struct
> > io_uring_cmd belongs to a struct io_kiocb linked into task_list,
> > swapping it with another struct io_uring_cmd would result in
> > io_uring_cmd_work() being invoked on the wrong struct io_uring_cmd.
> > Maybe it would be okay if IoUringCmd had an invariant that the struct
> > io_uring_cmd is not on the task work list. But I would feel safer with
> > using Pin<&mut IoUringCmd>. I don't have much experience with Rust in
> > the kernel, though, so I would welcome other opinions.
> 
> Pinning in the kernel isn't much different from userspace. From your
> description of what normally happens with `struct io_uring_cmd`, it
> definitely must be pinned.
> 
> From a quick glance at the patch series, I don't see a way to create a
> `IoUringCmd` by-value, which also means that the `done` function won't
> be callable (also the `fn pdu(&mut self)` function won't be callable,
> since you only ever create a `&IoUringCmd`). I'm not sure if I'm missing
> something, do you plan on further patches in the future?

Sure, this version is full of nonsence. v2 will be better than this.

> 
> How (aside from `from_raw`) are `IoUringCmd` values going to be created
> or exposed to the user?

Nomrally user would gets Pin<&mut IoUringCmd> from MiscDevice::uring_cmd().

Thanks,
Sidong

> 
> ---
> Cheers,
> Benno

