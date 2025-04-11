Return-Path: <linux-kernel+bounces-600945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7327BA866AB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 21:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51867175570
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 19:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D56B2836BB;
	Fri, 11 Apr 2025 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WChFlcTA"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2C0367
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744401085; cv=none; b=XYbc7XyD3sSBOunLq98zFSnuOxkc9AfANpXYfNfqK/hfBz4IV7TKSEBy1lBeborxHqGumkwALmIEpNYxQlKaOSeNy2iypym0vCbqMeYsl7iafnOqwY3kFhretzBzt5m3hCbnNehn1MYlbs7KX7krh3Wigp6pP64DJTEyAZqHClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744401085; c=relaxed/simple;
	bh=ZNbefensufV6PEA9RWDanN598P4aAIy9WLBjIH8wjHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cd7zO83XSYf/hRjdCzO+XOPKPoPiTVg0s3kh47M5heLCaNg+6imO5zxThxLrGyDadQi68/nXD+YlRz18Lb+b8MYeSh5p5qYqaG6u8dA7QuJejAzbLqUeQHQqp0ToD2OBydZQw8GR4bR7kbFhvZ4RH/mEsb1iwJot8JYPQIg1Jvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WChFlcTA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so382390a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 12:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744401083; x=1745005883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNbefensufV6PEA9RWDanN598P4aAIy9WLBjIH8wjHU=;
        b=WChFlcTA4O8sbwLK5KL2NGF3Vv4HFmMM0THyy4FjrjZshSFqHnMSd2o1oSWUFl0BFn
         AEeJVtXS7eirRcettmkBG5exhX1/Wuc/b6kSGMAgbvILUvuQESR2z+O77hx5tgwylbgi
         6YGmxy0iFltb+OccypBuzQr3OWY+DPT7UssuTMUdHSdbJHWcFgFmTTIFbvgfzm+3MRxp
         HlhbJCiohvrRcBFYyc4ByR1GTrjFVia036yA7jCJG+bB3MS9fHK+PBRmAC8gLFJ5ADHK
         wWDsHeQJSLsTkYfZ4cIfd9wASdcMxSCSO8lUrU9gnbQRJ5CkVGgF8+iqaa4UwdLxr36s
         hgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744401083; x=1745005883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNbefensufV6PEA9RWDanN598P4aAIy9WLBjIH8wjHU=;
        b=szGWMpLnvZfLnJVt0jw/WPlUF3pJaQuwuwCa/w6Ylnbg8jzF4gtvPw1LP5OMHixXJx
         zy6lOrGa3AxqyoOwigCsa84dTYRjcSgptSpUHaeNsxqHxJHdVBgZWL4OIsj+V/8Yyhp8
         8rVu1KoEcI8//wJ8E9DljprKZQcGxdNvqCM9z4ECzO8aLyOYHyn1qvi2GS8MtMhQZeh9
         0VQb0oCJAkoC6ysYUnZkTHdOLH9Tg+70Gkl4g5BxOYpFPGUbRteNRcI2vbrSDD0IgAp4
         Ucj3D+VQCekgkKYejAeXybYOhyRZO1daducWmJx5HYQuTt8wiglFzXLZ84A8T7d85kPY
         +6Lg==
X-Forwarded-Encrypted: i=1; AJvYcCW1NINh1nSLzW5to26ark0XgXUr/HkSyOiqDjXYIB2Inbv3wa+LuHGtBfPFEkgvFni+kBFdvmaRAKp9s0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Dqt4gPhgz4rZMN7zhMexDfpkIYjoWdyIZfdFuQ9SvzyS0Dno
	jqI9iW4Tr1nVs+LXYInAVjVAA93ybJGw4k5Qloku42jYfK3FyG5pc+IWcMF6iobhUjkEvfYrzNq
	qy11HzWrHoeOCTweDiRgLeFVHWVsB3gc95S9EpsZGb7X9Ml55LJc=
X-Gm-Gg: ASbGncvoVtSYHu4LeRmt9mWxbGKaoO5AEE9zmmcyxKQOBn1t8Hci6/6Z6SbKssbiNOE
	6KUVVOIgI87PUaJZblwoPLbYTOHZ3wZnM7R6XwsK2ZabQZrR8N/h1P1PEGH5QRNBCYRB3YJRJNF
	1wigZQMIJ0FP9nnA+qXmT3
X-Google-Smtp-Source: AGHT+IHfVGBOlQCdx1hvq2f3G+Q9xeD/L1BI5SF66ACmEbexLDrsnhLO5hkMo6X7kw90iJl5OBJJOl49yxpIK3V26r0=
X-Received: by 2002:a17:90b:390e:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-308273f3592mr1634358a91.5.1744401083122; Fri, 11 Apr 2025
 12:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409024955.3626275-1-csander@purestorage.com> <Z_jLNGzRJAQBN8Nx@fedora>
In-Reply-To: <Z_jLNGzRJAQBN8Nx@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 11 Apr 2025 12:51:10 -0700
X-Gm-Features: ATxdqUG_gUcty4tHPgf6uag1CJ_6lddPvCULsnuqPrU5I7O-7tHfq-XvNeIDgYY
Message-ID: <CADUfDZp=CDAh-2gNB9_LQ4cdhFm--apgRB94cuzqjV4O93hUeQ@mail.gmail.com>
Subject: Re: [PATCH] ublk: skip blk_mq_tag_to_rq() bounds check
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 12:56=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> On Tue, Apr 08, 2025 at 08:49:54PM -0600, Caleb Sander Mateos wrote:
> > The ublk driver calls blk_mq_tag_to_rq() in several places.
> > blk_mq_tag_to_rq() tolerates an invalid tag for the tagset, checking it
> > against the number of tags and returning NULL if it is out of bounds.
> > But all the calls from the ublk driver have already verified the tag
> > against the ublk queue's queue depth. In ublk_commit_completion(),
> > ublk_handle_need_get_data(), and case UBLK_IO_COMMIT_AND_FETCH_REQ, the
> > tag has already been checked in __ublk_ch_uring_cmd(). In
> > ublk_abort_queue(), the loop bounds the tag by the queue depth. In
> > __ublk_check_and_get_req(), the tag has already been checked in
> > __ublk_ch_uring_cmd(), in the case of ublk_register_io_buf(), or in
> > ublk_check_and_get_req().
> >
> > So just index the tagset's rqs array directly in the ublk driver.
> > Convert the tags to unsigned, as blk_mq_tag_to_rq() does.
>
> If blk_mq_tag_to_rq() turns out to be not efficient enough, we can kill i=
t
> in fast path by storing it in ublk_io and sharing space with 'struct io_u=
ring_cmd *',
> since the two's lifetime isn't overlapped basically.

I agree it would be nice to just store a pointer from in struct
ublk_io to its current struct request. I guess we would set it in
ubq_complete_io_cmd() and clear it in ublk_commit_completion()
(matching when UBLK_IO_FLAG_OWNED_BY_SRV is set), as well as in
ublk_timeout() for UBLK_F_UNPRIVILEGED_DEV?

I'm not sure it is possible to overlap the fields, though. When using
UBLK_U_IO_NEED_GET_DATA, the cmd field is overwritten with the a
pointer to the UBLK_U_IO_NEED_GET_DATA command, but the req would need
to be recorded earlier upon completion of the
UBLK_U_IO_(COMMIT_AND_)FETCH_REQ command. Would you be okay with 2
separate fields?

Best,
Caleb

