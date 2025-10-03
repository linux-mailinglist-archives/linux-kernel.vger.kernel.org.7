Return-Path: <linux-kernel+bounces-841581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5BFBB7BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B5C14E20D9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510292DA77E;
	Fri,  3 Oct 2025 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu7KTEEJ"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5F823AB8B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512574; cv=none; b=iwxIPNpcZ/xsj/B7dC9ZOfDZVyBf3FJru54mnlmbo/camnBfGmPiOmM0sM0vF+H0bU05CBmcarK6z1SxlKqe3OC0cUR7dKM62Y+OgfKbpYdw3VwWtKIaOiNxTFgTYTGfig6fQgplR7kN83WtlowdyNMKNzDUo0bVP+9U8OLHN7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512574; c=relaxed/simple;
	bh=RhQt3A0QZViGN2CSqHdumq6jNfjv4pKYcChZLqTW3r8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQC+Q1pFBK2iM7jf7OQ1Wt5WE0EXQcMlom+MaHzIQjX2IdGEwMqzYrPoCr2ISoa27EkmhszbzlZo8KHdSBT5kR8Hf2XwPD3oEhYO4hfYAOVBHnNGC3D1oMcgEYMaq+9fwfRbXLvsCrBJTcziHYWWN/ev9gtsvT4O29fAscC9Gz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu7KTEEJ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso2168681a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759512571; x=1760117371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rOkph1D+DZvjutjfQEMOzwydkjaUX0rRXkOVVOEXEU=;
        b=hu7KTEEJPCXAh/DZ3zexB8KeEmoC0FT9dcWpDqpJk5/5QoIFi5ZQY0+xYLj4oyTQm4
         j9ymynrr2Ooahj2PUHMwevox0Ui8lWEIQoIPum1pZoh2VBKmac6UxREvSLRp8yrUFB0D
         C49alKIiQn9DJ3vD48spKU91zEhjUHKt1gkjG6wC0POUxWt4l+g44B1v8cDKBhqLBkya
         S9no3YhMQiL72Fka1BDvuQgVv/jKOJE5SNfMKe4o0nbCFM2CKK1bSrkKFZwBMwkMMujq
         OxKoQc/zVA6P7Fw7wecEGDnO6yYPtEIWiQQyPeouuLCHBO9bCxWStndzpMRq7n1BRdTm
         PNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759512571; x=1760117371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rOkph1D+DZvjutjfQEMOzwydkjaUX0rRXkOVVOEXEU=;
        b=Q+jHETK5GPhLZgvfdD5dfJe0LReNAo5dSggNO6IMW5uloBo9X3IwQ7ZhVQwn6uIKZX
         8jV5ned+IoGdaZyvBCC6ujCmAenzdzl4YVGCUMhWZeRkJ2n/CbpKMW81nLj/g8vflOYB
         bRzvH/I0/sB1sY7ThhNi/fupW0r+NNyMUElK00sDsWY/V8pa8EWqi5D8hhRjmaoyRLBA
         K8GwvY0mIvMKcIwi0n88Q4oQCHbdzaF0h86qGwSLKxSoPm8xNv6WGMcdv4GZr/vUXedH
         blYW3l7VzxOEiBUcHsVDErBFQ+92fnw0I3rRTPw/dGLfPawO75rWZgEcSkgFaIznKtd7
         QtoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRoxc1YA2pxY8meCfp5qfV5djb55wux46+grJ2px5BSMxi+vmxp7j9VZJ7NUiC11ZK8AR2od5MV4dETj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOOp2UhXwRIocSoyHskqk272HNGPPLp/1hl0s10TYto4tSO2fB
	0h3UArLh//oA5NbdnTp41UAqZMMl5pF8IYfB9jOCj1gz54HJB/FOd5reRnWbqitZNtioBNGzzay
	CQRhwv6MxhXREtLbwMOtS/ctJtJZcuSY=
X-Gm-Gg: ASbGncvXmbROZclE1SgBXv6DXuQzoCzTfhW9hB3kbxLSemeXH3Yz3riNaO9EVsAFudq
	H9Tsud+5cGdPWrMJlOOSEoPMpD7NtU2eHjXadXSKFFfZleF8QfoEiaxXaO+e72hMviOOvksXapY
	ggEhNz4kElbq63LYOtiyOcTn3sJZu4blVCCW7aOUoFqWJ2DxQsz07b08C1t248eNHerApdb88ir
	klVKZZ4OCPJnFE6IItA2B1Pyro3qMabALvR2icoGhT+ylgj61qOih8D/XfeVk4+fV6iGBp0PSW8
	8fJIg9H4wyJFhExtJusT69cnLkI=
X-Google-Smtp-Source: AGHT+IEAlrhwJ6J4219dJbcSthOxyufaJhPx4SqaXlVUBk+MFOifd2vG6y0efRRgy5bhHizk3MDd3IYrgH99gFXvydM=
X-Received: by 2002:a17:902:fc87:b0:26e:49e3:55f1 with SMTP id
 d9443c01a7336-28e9a5ec5d3mr46365295ad.18.1759512571263; Fri, 03 Oct 2025
 10:29:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925025517.815391-1-kriish.sharma2006@gmail.com> <aOAAWZ5DsnbqPxIA@google.com>
In-Reply-To: <aOAAWZ5DsnbqPxIA@google.com>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Fri, 3 Oct 2025 22:59:19 +0530
X-Gm-Features: AS18NWBRo5YkNeJ9RdrCx1X8TiiALnzON9LpGEj22HRHO0Hv05MU0aVlcZjlY1s
Message-ID: <CAL4kbRMhqy1AHZC78kSZ7owi4qqAZXqMzredacLLjYdMGdVDRA@mail.gmail.com>
Subject: Re: [PATCH] docs: android: Fix missing kernel-doc entries in binder.c
To: Carlos Llamas <cmllamas@google.com>
Cc: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com, 
	maco@android.com, joelagnelf@nvidia.com, brauner@kernel.org, 
	surenb@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Carlos,

Thanks for the feedback. I=E2=80=99ll update the patch with the correct
subject, align @thread, and reorder it after @proc. Will post v2 soon.

Best,
Kriish

On Fri, Oct 3, 2025 at 10:27=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> On Thu, Sep 25, 2025 at 02:55:17AM +0000, Kriish Sharma wrote:
> > Fix several kernel-doc warnings in `drivers/android/binder.c` caused by
> > undocumented struct members and function parameters.
> >
> > In particular, add missing documentation for the `@thread` parameter in
> > binder_free_buf_locked().
> >
> > Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> > ---
> >  drivers/android/binder.c | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index 312b462e349d..d30d27bfc634 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -2417,10 +2417,10 @@ static int binder_translate_fd(u32 fd, binder_s=
ize_t fd_offset,
> >
> >  /**
> >   * struct binder_ptr_fixup - data to be fixed-up in target buffer
> > - * @offset   offset in target buffer to fixup
> > - * @skip_size        bytes to skip in copy (fixup will be written late=
r)
> > - * @fixup_data       data to write at fixup offset
> > - * @node     list node
> > + * @offset:  offset in target buffer to fixup
> > + * @skip_size:       bytes to skip in copy (fixup will be written late=
r)
> > + * @fixup_data:      data to write at fixup offset
> > + * @node:    list node
> >   *
> >   * This is used for the pointer fixup list (pf) which is created and c=
onsumed
> >   * during binder_transaction() and is only accessed locally. No
> > @@ -2437,10 +2437,10 @@ struct binder_ptr_fixup {
> >
> >  /**
> >   * struct binder_sg_copy - scatter-gather data to be copied
> > - * @offset           offset in target buffer
> > - * @sender_uaddr     user address in source buffer
> > - * @length           bytes to copy
> > - * @node             list node
> > + * @offset:          offset in target buffer
> > + * @sender_uaddr:    user address in source buffer
> > + * @length:          bytes to copy
> > + * @node:            list node
> >   *
> >   * This is used for the sg copy list (sgc) which is created and consum=
ed
> >   * during binder_transaction() and is only accessed locally. No
> > @@ -3997,6 +3997,7 @@ binder_freeze_notification_done(struct binder_pro=
c *proc,
> >   * @proc:    binder proc that owns buffer
> >   * @buffer:  buffer to be freed
> >   * @is_failure:      failed to send transaction
> > + * @thread: binder thread performing the buffer release
>
> This is missing the alignment that other members have. Also, please keep
> the same order of the arguments, so @thread should go after @proc.
>
> >   *
> >   * If buffer for an async transaction, enqueue the next async
> >   * transaction from the node.
> > --
> > 2.34.1
> >
>
> BTW, your subject is "docs: android:" which makes me think this is part
> of Documentation/. Please just use "binder:" instead.
>
> Thanks,
> Carlos Llamas

