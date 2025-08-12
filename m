Return-Path: <linux-kernel+bounces-764999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4600AB229DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C503BB746
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F65C2C3259;
	Tue, 12 Aug 2025 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hW5HGkRo"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133C52C3245
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007336; cv=none; b=Xh3YBzI6eEEx7uF5BvdEk9sOVwLqxW2hvi6H+ucIWqRuFPgp2FGYGDMh7DRb5PDisvei/cgScuU9YCL5klDji/whVY2lp2IWt7Q/pkU+3YcPDD4JaNujAp0sZoJ9ksNdXkAdgjdOThBuAWC2OSkqjRwahfD0oKVaTP62YWKfYeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007336; c=relaxed/simple;
	bh=Kl1b0sFoz+9dVQKB7BUgzfkrJNKQKX5dUQR+RFgbl3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UL6+ydj/FcPORYL4CMWFbe0JwPpzFGm5+2qasbSTKzGtHXjWFy+tOz/FNCRRh/5pI+NR3dC2SyrGi9SAyiR15r/Xzjf1gZRISr2YVlXKEc7FQFRv2gousurguTn9/nTy+SDGckxYj4tbutZfTKPaOT28CgCaXeO6lUGlwoi0E+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hW5HGkRo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-618660b684fso865a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755007333; x=1755612133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgHrp6O0mzVGMq4/kwlF2j6V91Xq20REHoK3R4NBnWY=;
        b=hW5HGkRoQkTRWv+c2ICs1qRqgmPea/0jGH8IckKyfhCScTLPg3pMN8nL1IrggkbpHq
         r7xRZjNuFdRrHXr0dDTjKFae+WV644zdLVmWTwz/AS55CSigsEgTbs6w6C33TLCssxU7
         jsYj7YzqKLHSe+2gdEFLpBnb6fTgmxubmgUrMoja1cMe38wUE9n6FPo+yPZAAXxFZb3o
         XmmajYJSmtBwVLfwCPkoLQQ0ZHAAdrXic0JePDj/+ZmSL9u+vfGlIoeoJkcF2/kXE/AX
         K4kr8Bh8PzNr5EJUbVVF+PuHJ/C1aQkqX39ghpXd9s/DVliZjPsDoTJYGxuAFVQ6wSim
         Rcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755007333; x=1755612133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgHrp6O0mzVGMq4/kwlF2j6V91Xq20REHoK3R4NBnWY=;
        b=QbMJcMTN9PWh5w/v6fylDdZl5gXj+jSqvXMeWXLhOxjMtFwBRf++xsPcyY5JnCRphb
         +RWKwNbesiMEae8xSC00KKjX3IeDOGFmPQwZV69yXHlCoyQ38yLtCf+/yul/kCuMdlc2
         I5BtPkWFaAnMgA2lM0Nez3mkXrsRLlCJ97Kpy8tVAKKDyVBfY/4sz3fFbW3bSeS4Z4ax
         ZgS5xVrO9/Jc+JEjym4Hl1smdYW6OHpGIqknKHhZ5oLa0Lek5qZvBt0F9WCXtb/k6lIT
         WLzh9xinVVJy2hnchUE782YcmmKcJ4NMxh7hGwl+LouSJIbJJnb/tvgotTYTxESTZEPe
         U9Qg==
X-Forwarded-Encrypted: i=1; AJvYcCU4JcEmciW/RdbhqIL2K/gUINmMn0kHjX1cDB0BmCRG1ztqmaogwhRx4cDRjT/KUh3i0R6mSNe3i3LTmSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzcbcjWprRanHDpWdPp8syxzx1cmvq/uw0YCbUL3SY4taLwjkJ
	WckciWbIROtVAwcbLHaDhm8qoU+TcoIuKfKigFdqWQ/8IesvBA1T9i2eoaD/X2AyY9SQZyDPZ5o
	4XPRuSfNKWycNrufUDKE3y8iqjUhu+uoRZeWpS6nv
X-Gm-Gg: ASbGncuboIHpViM+02X85EcWhlj3+Lwr64rUbov9HvVHfyY52eDtH4fHfTHor0iLSzb
	M9esGlhi5P3CU4cMW5YEuG9mkl9TUXhGhgDB9kZM8lOY3HuFw1OhGCk7OWwGFJbtGvL1oCEDAsh
	xq2o6whtiwlZE8QGxDFEA2klLH4D4fTnNLQDNeX7xeP+Lrc4vL6fdVVKe3Z+of6XO5+ZRrGsB1J
	gh3Fq+lNoo/DeDYD9994f1x3AQfznaV5JBm2V9A
X-Google-Smtp-Source: AGHT+IGeVXfDi+GOeKEOGwGKfuGKlGjEf7ZPtGH8NAet/PE11DWKQCepuum1A6pr1DfJRUVQTFJrixrJo9wirRpXH3Y=
X-Received: by 2002:aa7:c68f:0:b0:617:e6b2:1fda with SMTP id
 4fb4d7f45d1cf-6184ef93123mr96944a12.0.1755007333014; Tue, 12 Aug 2025
 07:02:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807103902.2242717-1-lokeshgidra@google.com>
 <aJT7qQzEs_p36yfI@x1.local> <CA+EESO64MOZaJHyY_mTy6Gqvaz=CkPLHgc-UZ1rg8FXcPyh0aA@mail.gmail.com>
 <aJn3Z3q_kZl4Nob2@x1.local>
In-Reply-To: <aJn3Z3q_kZl4Nob2@x1.local>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 12 Aug 2025 07:01:59 -0700
X-Gm-Features: Ac12FXzRyXJqfak0AaNtuxx8F0LqwDc8XieRTyx4WZgakbpJYqJSaaF7hnoQRlc
Message-ID: <CA+EESO7vtVBUdppuUVTazaK0Aaxy6=FCWX-7YrWvg1Y93oqdOw@mail.gmail.com>
Subject: Re: [PATCH v3] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 21cnbao@gmail.com, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 7:00=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Aug 08, 2025 at 09:29:58AM -0700, Lokesh Gidra wrote:
> > On Thu, Aug 7, 2025 at 12:17=E2=80=AFPM Peter Xu <peterx@redhat.com> wr=
ote:
> > >
> > > Hi, Lokesh,
> > >
> > > On Thu, Aug 07, 2025 at 03:39:02AM -0700, Lokesh Gidra wrote:
> > > > MOVE ioctl's runtime is dominated by TLB-flush cost, which is requi=
red
> > > > for moving present pages. Mitigate this cost by opportunistically
> > > > batching present contiguous pages for TLB flushing.
> > > >
> > > > Without batching, in our testing on an arm64 Android device with UF=
FD GC,
> > > > which uses MOVE ioctl for compaction, we observed that out of the t=
otal
> > > > time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), =
and
> > > > ~20% in vm_normal_folio().
> > > >
> > > > With batching, the proportion of vm_normal_folio() increases to ove=
r
> > > > 70% of move_pages_pte() without any changes to vm_normal_folio().
> > >
> > > Do you know why vm_normal_folio() could be expensive? I still see qui=
te
> > > some other things this path needs to do.
> > >
> > Let's discuss this in Andrew's reply thread.
>
> Sorry to get back to this late.  Thanks for the link, Andrew!
>
> >
> > > > Furthermore, time spent within move_pages_pte() is only ~20%, which
> > > > includes TLB-flush overhead.
> > >
> > > Indeed this should already prove the optimization, I'm just curious w=
hether
> > > you've run some benchmark on the GC app to show the real world benefi=
t.
> > >
> > I did! The same benchmark through which I gathered these numbers, when
> > run on cuttlefish (qemu android instance on x86_64), the completion
> > time of the benchmark went down from ~45mins to ~20mins. The benchmark
> > is very GC intensive and the overhead of IPI on vCPUs seems to be
> > enormous leading to this drastic improvement.
> >
> > In another instance, system_server, one of the most critical system
> > processes on android, saw over 50% reduction in GC compaction time on
> > an arm64 android device.
>
> Would you mind add some of these numbers into the commit message when you
> repost?

I can certainly do that in v5. But I already sent v4 addressing all
your other feedback. I'll incorporate these numbers as well as any
additional changes suggested in v4 in v5.
>
> Thanks,
>
> --
> Peter Xu
>

