Return-Path: <linux-kernel+bounces-812528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D079B53947
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE7CAC137E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1B435A2B9;
	Thu, 11 Sep 2025 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jry+YZnD"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EC8356919
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607965; cv=none; b=cRMMrtl016rHuWeWT+N0yk/z6HvzrzPkJb8ZglcWH2K//8NmrZCzUaaxSB/eQ6Cxfgn37MJoC112AA+Ey+5vjwQCDBcFwvHO80ih722MfNtD2rGt7Lf4F87K+jpUvkidXxuMFBp+AjCzXX/GQyHbCx4aqvHxCXq6dl6vaJGSYRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607965; c=relaxed/simple;
	bh=xEu6d8AtFvjOtKDch5SoL6gLndpC5XUwr+/2i0wUO2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtWldCDyfGlgt/7qIvduHtHRbBIx/3pTGLKwX8hwAL1cDkArVa4H43+n+7IcBRIX+kIGoh45rG5LybOLTdRH5E/RavZWBns0Xo+6rY69JkAtKnKZ5yN5GwU/CzeVcAVaAjH3/e/Gd+KaBvet0yKlxDebes7MCgKOKKr0fVdFeX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jry+YZnD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so855658b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757607963; x=1758212763; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UqP0yh780QZSEn09Gu4Ub7K64FPut2woI/zF5kWSvDk=;
        b=Jry+YZnD7JhqOsaDnYKuOXA/WycJ3UPoEkNmzmbgPVbB5BNrhFqGKNxiOJqeTboM7q
         i4K1mhmTATZT8Xvh4s5dtA5AhEjcKRbhTN/8zImPc69RcrZfs4MuP6mI1ToRq5W65X+w
         XKPtoOGc56vcUDxQDWBeZCu2q4h04RCVPi+hIrYF/gNqshpUzBVrWq0MFrlW1OzhVF0H
         iRYcI1VZLQ7eB0G2hxOyaLcyq2/nTgfbgyjdLJl64TPQhJgSU2HCvd0YRyySaQcU4ToS
         pTvIj4BDYhotgqykivlaNgs/SoFN2qGAReUJABANkxYNBEBf6DIKl+zKo0n7ADSYpdUK
         uE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757607963; x=1758212763;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqP0yh780QZSEn09Gu4Ub7K64FPut2woI/zF5kWSvDk=;
        b=WEDaV7b8xnydNN48IVSCClbuzUUoWwNypls1mL6/fMv25U3rfCCM5O+F76TBWmCkzG
         TtvxHw8Ge2D4WAdm4RPvyjb8rmdckPLeRHouOzOITAiKd61cP4L7m5SLjMxiaaUDMdrb
         cJI3kc9kVEWeoaNccCVQEO9uWuiwpAzeE61fK3uhof3N+PP9GFXi8bwMQVQeH/7/KwqC
         btsPzK4ht4+6PVwA9VwX7Swy9/JhPTtwq4P6jDAEtCZ090faiStvBKMW/7V69rs9wVWw
         NAMgJDMUELFj0xrWqhPVsDeqOwTuMdnLn4zbEvn+tfH78RyrVJzoDKHZ00DfjDWg/gua
         tZEg==
X-Forwarded-Encrypted: i=1; AJvYcCWsz9+JP6GvjCZjwBxLQA6jH9T5Q7wYCXR0utCBJ+BUQGXdTrl9gcmJxAwKJmv1A71+k8yW3nhjYSH4G0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zjk0efvRajPNL0IF2FQTwOO7h7PwJph491u9jxrhhRMYxAKr
	y64nEh5O5rd7R/VaKIZxX6qKwHgwBT/GSTK0CtgfeTGyM7GED2q4dV9MR7v+Tg==
X-Gm-Gg: ASbGncvyodYcLbavrlaznZin5BCApJJuzRJePC9BJuxMa0qia12Vtt51BBC6NCHQdA9
	pY4z8UVgH5YHt+GBcAnfWXdHixeVaKwXQEAftP86sH0Sw1PO0yZ0F5PD4BbfAUaKJJ1EWkxKoa5
	NPBA/d9k68hoKm2yScpAZ4tqm8MhzMjffAF78x7WYFWGqDfS55hQH8rvtlrsyfAcCBc6oQEqaPP
	elwVKx79Dgut6YUqxz/JaiYp091o2kLz355ROtssQ4Hex9Gb6sXw3/pz+01SuTe8g7wkGeU1imp
	MhTBPlGxCwBlGMUjSnXuKWru7pqwvn89O/KAh7t1z1Oi4tcS4flKGQMxhOuuZjPV/itzsfhuEKJ
	KiVGLmFnpYeGFMY0fHigOiPmfgo7vLhv94VLvQ6Rg0RBwqKRIdjKU1Za5Ek3mL0WaQU3RlU+KTZ
	pFKRAJXA==
X-Google-Smtp-Source: AGHT+IH5XMd0HGbOFMyruweaNH1fol7mWk5Y5V4J67dhEP3/uGyRjyhKDuxNRCKL+82zJXTUnSBwfw==
X-Received: by 2002:a17:903:228f:b0:24c:be1f:c204 with SMTP id d9443c01a7336-25d24da3763mr450845ad.22.1757607962668;
        Thu, 11 Sep 2025 09:26:02 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98e7647sm2677426a91.21.2025.09.11.09.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 09:26:02 -0700 (PDT)
Date: Fri, 12 Sep 2025 00:25:56 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Guan-Chun Wu <409411716@gms.tku.edu.tw>, akpm@linux-foundation.org,
	axboe@kernel.dk, ceph-devel@vger.kernel.org, ebiggers@kernel.org,
	hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
	jaegeuk@kernel.org, kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, tytso@mit.edu,
	xiubli@redhat.com
Subject: Re: [PATCH v2 1/5] lib/base64: Replace strchr() for better
 performance
Message-ID: <aML4FLHPvjELZR4W@visitorckw-System-Product-Name>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911073204.574742-1-409411716@gms.tku.edu.tw>
 <CADUfDZqe2x+xaqs6M_BZm3nR=Ahu-quKbFNmKCv2QFb39qAYXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqe2x+xaqs6M_BZm3nR=Ahu-quKbFNmKCv2QFb39qAYXg@mail.gmail.com>

Hi Caleb,

On Thu, Sep 11, 2025 at 08:50:12AM -0700, Caleb Sander Mateos wrote:
> On Thu, Sep 11, 2025 at 12:33 AM Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> >
> > From: Kuan-Wei Chiu <visitorckw@gmail.com>
> >
> > The base64 decoder previously relied on strchr() to locate each
> > character in the base64 table. In the worst case, this requires
> > scanning all 64 entries, and even with bitwise tricks or word-sized
> > comparisons, still needs up to 8 checks.
> >
> > Introduce a small helper function that maps input characters directly
> > to their position in the base64 table. This reduces the maximum number
> > of comparisons to 5, improving decoding efficiency while keeping the
> > logic straightforward.
> >
> > Benchmarks on x86_64 (Intel Core i7-10700 @ 2.90GHz, averaged
> > over 1000 runs, tested with KUnit):
> >
> > Decode:
> >  - 64B input: avg ~1530ns -> ~126ns (~12x faster)
> >  - 1KB input: avg ~27726ns -> ~2003ns (~14x faster)
> >
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > ---
> >  lib/base64.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/base64.c b/lib/base64.c
> > index b736a7a43..9416bded2 100644
> > --- a/lib/base64.c
> > +++ b/lib/base64.c
> > @@ -18,6 +18,21 @@
> >  static const char base64_table[65] =
> >         "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> 
> Does base64_table still need to be NUL-terminated?
> 
Right, it doesn't need to be nul-terminated.

> >
> > +static inline const char *find_chr(const char *base64_table, char ch)
> 
> Don't see a need to pass in base64_table, the function could just
> access the global variable directly.
> 
> > +{
> > +       if ('A' <= ch && ch <= 'Z')
> > +               return base64_table + ch - 'A';
> > +       if ('a' <= ch && ch <= 'z')
> > +               return base64_table + 26 + ch - 'a';
> > +       if ('0' <= ch && ch <= '9')
> > +               return base64_table + 26 * 2 + ch - '0';
> > +       if (ch == base64_table[26 * 2 + 10])
> > +               return base64_table + 26 * 2 + 10;
> > +       if (ch == base64_table[26 * 2 + 10 + 1])
> > +               return base64_table + 26 * 2 + 10 + 1;
> > +       return NULL;
> 
> This is still pretty branchy. One way to avoid the branches would be
> to define a reverse lookup table mapping base64 chars to their values
> (or a sentinel value for invalid chars). Have you benchmarked that
> approach?
> 
We've considered that approach and agree it could very likely be faster.
However, since a later patch in this series will add support for users to
provide their own base64 table, adopting a reverse lookup table would also
require each user to supply a corresponding reverse table. We're not sure
whether the extra memory overhead in exchange for runtime speed would be
an acceptable tradeoff for everyone, and it might also cause confusion on
the API side as to why it's mandatory to pass in a reverse table.

By contrast, the simple inline function gives us a clear performance
improvement without additional memory cost or complicating the API. That
said, if there's consensus that a reverse lookup table is worthwhile, we
can certainly revisit the idea.

Regards,
Kuan-Wei

> 
> > +}
> > +
> >  /**
> >   * base64_encode() - base64-encode some binary data
> >   * @src: the binary data to encode
> > @@ -78,7 +93,7 @@ int base64_decode(const char *src, int srclen, u8 *dst)
> >         u8 *bp = dst;
> >
> >         for (i = 0; i < srclen; i++) {
> > -               const char *p = strchr(base64_table, src[i]);
> > +               const char *p = find_chr(base64_table, src[i]);
> >
> >                 if (src[i] == '=') {
> >                         ac = (ac << 6);
> > --
> > 2.34.1
> >
> >

