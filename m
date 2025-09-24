Return-Path: <linux-kernel+bounces-830948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2C1B9AFA1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591EF16C856
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EC5314A97;
	Wed, 24 Sep 2025 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULS2GW3y"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182E9182B4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733658; cv=none; b=rpuT2DKEe/aYujw4pOsUiQO9y22v7GyU4Edq0k2f6qm87MwAwVnKVIrkmeQGOkfjnwXStA5i5W0lxQD0SSJoPq7sCmGtKEdnWC0WJH3ibope2b4V2jSIeOQjkHukrTCzXBQBmHgCzfhAe1ISBfsVTPozyFYsXDyG7MZ6BbKtLh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733658; c=relaxed/simple;
	bh=YRqMp6ISqqJIV6UOnkn8eYwsVLH1TS5Pu0GLem32nEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4DYEoZ52kbN2ArN5uX6p9nqWJm3o5FWuv9PdKVIxkjQKWgTZVJTKtk39z5qf4Rpv/l9YyUKKtjF8EbIqVNI3bOezanLgE1KYHIpbryK6puAB7a0SDKIr2Fo8o+J4jXWO8kySoRj7xrNX4byJyQf8EbCNfAK0pvzMAgLIE+jX/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULS2GW3y; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee1317b1f7so54079f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758733655; x=1759338455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6NbfoLkhV4bTIvaUN0MOx6IHZBFCN15l7e9hsA+QAk=;
        b=ULS2GW3y9AuCFvtqep5b07Q9VowYRzoLSmjklDCoFNp2kzrzZ4+GDWb1zHUoM/8TCI
         3NJjM7IWhUW6x2t+sD+ujEJ19oB//U9h7lNzZUXSj0DDVndcjzB8lFyhl49uN0F6DbiV
         HDknavUsDGSAjvEDRLT65dPFSqV3dE+tGNb3ziVip3YQkIlmbb0Mr5N8VcfA3F2GlQ/3
         NPG1sIdnv0zXBV1nxPPsmnbMM6ISjFrVvmQD54Q8CUmoGttEjoYXkNEFZ+91RsBfiDaP
         W/isVbuXbx26d2K4LJfeeRecg8wxyxDaDfyAod6C5AgK5In1xE/I1rSnWVlsVre54x6+
         agfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758733655; x=1759338455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6NbfoLkhV4bTIvaUN0MOx6IHZBFCN15l7e9hsA+QAk=;
        b=iHSD9Bn+v5Xcn1t2/Lf4t4dgbPAo9Yqj2jRVdInxJVdrMg4i8U4Cimw3HJZxTpuT9r
         0cG4g1orFk3+1Lg/TtAbXe7YACc6nQBB9tMrG+jWvkXV1kirVXQmC61T9R2kA6CPep3L
         jUpwt9V8tAn6BGtDTgbzIlBU4mg+n3jmC2RfHm22NwcsJazNQtTou/eGhPpqUsPU5Fsq
         5Vsb+DsZmkVs3GXGrH25UJBmeBrdddOm4PKyhESJtx980RjqhJxwOEW921Ac2j1PTj6V
         4x3uMi9o+w2WHD7IggasWVjv27j6EnWhziaLVszX+2wVooXZ5NduHdkQml7UAibqDIKQ
         1y0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfVOuPA/nMgUdwJTawIdrOTkjxtvYffJbrDAPaMHYMA5yyiYmjdDZyXZ9MT7AV35eOlz9iNJJw/2Rf+hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXpx2GZ6NEzm0gVyH0K9Qc5iQEYps4k5RR7TInZ2E5Hu7DH646
	VTfyWQP3QqPXn0nf1VK6bOFtcU90a2UJw5LsCE5DWxInTtlBB76RJAF5o0fF2zUn6vPkmgVWdwe
	75g38MqnyVxy71/Qav7pGaWEzHt51YOs=
X-Gm-Gg: ASbGncvZhf1TYV8vdXDOxkS576GYLujnsqYvZ2wJ4GBpr31Jkm/LKqDcmO0mf/NG4WO
	iz3yyYBXzWtFA3G1qmqg/q9+MNyyyy4u60r1BEV63goGP3dmEzrksPaNC78SKS4xUb1IcwGxbqw
	OZSYJInFfIx4exNdsJRO2AcG60OF+u+n+91Z8RPUuGeLt6smvUQpjXyjUz6ahDRei6GZQRuYURv
	4CHew==
X-Google-Smtp-Source: AGHT+IGFyiklRq02PW4vHdH74vwxnS++02d/GOkLHF4wm5gFcNuZkL59cR+2f4c3DDAA9zxiZ1Wld6PWNEY95CvQZhk=
X-Received: by 2002:a05:6000:1848:b0:3ea:e0fd:28e8 with SMTP id
 ffacd0b85a97d-40e4ba3a4demr645051f8f.32.1758733655112; Wed, 24 Sep 2025
 10:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923-local_lock_internal_fix_shadow-v1-1-14e313c88a46@kernel.org>
 <CAADnVQK_Dt7Ag9nLQm2LDFoiB_ymorC017YXJ9ZC06VizEHt2A@mail.gmail.com>
 <5d6641e3-3e89-465a-aaf5-558dc97a7581@kernel.org> <3b16de2f-9298-452a-95d8-df2b4b668714@kernel.org>
In-Reply-To: <3b16de2f-9298-452a-95d8-df2b4b668714@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Sep 2025 18:07:23 +0100
X-Gm-Features: AS18NWChg8mp5qIEM1LK50ssuRcLWSbbP4i_mais98rIDG0PL4F_WBgQHI72BB0
Message-ID: <CAADnVQ+xGQGdR85R6EnX7Rrv+RqkrTfLjfdZOYJ4bPb9+Govyg@mail.gmail.com>
Subject: Re: [PATCH] locking/local_lock: fix shadowing in __local_lock_acquire()
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 4:07=E2=80=AFPM Vincent Mailhol <mailhol@kernel.org=
> wrote:
>
> On 24/09/2025 at 19:26, Vincent Mailhol wrote:
> > On 24/09/2025 at 04:38, Alexei Starovoitov wrote:
> >> On Tue, Sep 23, 2025 at 7:02=E2=80=AFAM Vincent Mailhol <mailhol@kerne=
l.org> wrote:
> >>>
> >>> The __local_lock_acquire() macro uses a local variable named 'l'. Thi=
s
> >>> being a common name, there is a risk of shadowing other variables.
> >>>
> >>> For example, it is currently shadowing the parameter 'l' of the:
> >>>
> >>>   class_##_name##_t class_##_name##_constructor(_type *l)
> >>>
> >>> function factory from linux/cleanup.h.
> >>>
> >>> Both sparse (with default options) and GCC (with W=3D2 option) warn
> >>> about this shadowing.
> >>>
> >>> This is a bening warning, but because the issue appears in a header,
> >>> it is spamming whoever is using it. So better to fix to remove some
> >>> noise.
> >>>
> >>> Rename the variable from 'l' to '__lock' (with two underscore prefixe=
s
> >>> as suggested in the Linux kernel coding style [1]) in order to preven=
t
> >>> the name collision.
> >>
> >> lockdep has __lock as a local variable.
> >
> > OK. I didn't saw this one.
> >
> > But there is a major difference between a shadowing in lockdep.c versus=
 a
> > shadowing in an header: the shadowing warning is local to lockdep.c and=
 does not
> > pollute the other users.
> >
> > My worry is only about the spam created by warnings in headers.
> >
> > Regardless, would renaming to __locked or __l instead of __lock help to=
 address
> > your concern?
>
> __locked was a bad suggestion. It could be named __local_lock (there is a=
lready
> a __local_lock() function like macro, but function like macro does not co=
nflict
> with variable names).
>
> But now, my current preference goes to __ll (and also, to keep things
> consistent, __tl for the trylock).

I think s/l/__l/ and s/tl/__tl/ is fine,
but do it for all macros in that file,
since renaming one is fishy. It doesn't fix what
you're claiming to fix, hence the pushback.

Better yet, learn to ignore overly verbose tools.
sparse/checkpatch/gcc are not always correct.

