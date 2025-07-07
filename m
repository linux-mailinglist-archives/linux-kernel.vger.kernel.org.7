Return-Path: <linux-kernel+bounces-720429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAD0AFBB92
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B624A42D0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0823266595;
	Mon,  7 Jul 2025 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ramItIm"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BE3265CDF
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915348; cv=none; b=ViT2O1sG0uUggQxPAuCyY8j+4gtftmKa3mqTsvRmz2UeGzNsb/W7+OaFPFSijJnSN9Y/Q9o9bj+nW53/V8asFGh7MW9piWMNJTFB6WbFyA2OGGBwfT1ZpaVK5gm+W0bOKJCsmbF5HHmVwzdjl87SATuP1AX/G80BjxAJbltSg8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915348; c=relaxed/simple;
	bh=OLa1uSOXhPwcJdb3Gjqq6wR6o4Np2VtHVABQrS2bwyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKR4dLHtTLTnBhv+z54qLpu4gkXTjsTdJTK/K93klQN3EsYAY8Vo80u/YqSQ25Noo4iE3vTGO2QN8VGw23nV/3ENJm5W4M5Ws+j0UymifN10YanQ4DrYwiWaavm3TGYocIdINWVpCnz+4mRrOUgeUSzr+895ntEP8BD8q2NSzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ramItIm; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b31c978688dso1817428a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 12:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751915346; x=1752520146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SCwp2HDrQpkP/bLom9Qnn8CJJY2djxK53T9Kul+hqH4=;
        b=3ramItIm0xWyjFOceLmdZSMTwwBA09Ho56+LFc7ghzplXT7W8BAuifB3sMo0b6nO6l
         yfEPjPlrD5EG9Bz91VuSckwmjQItAlcYcP5KhnsEKsRlrIv/44J32LT3aQQJpBqrXhaQ
         PLrfFiu0CDvw2KovNTwPAsM4rgw+vDIxe1/HYcy3mXG/DbeQMoa+Mnik1ao/KIKU0Ni2
         amq7YRLqdIjIY9dpVovW7ALJnWmXjCh0jzapZlS4Dkv1k2zzJWkmcNsxRlW7efMoXCHs
         0IvTH6OUBQkwAS04d2iCkml/4wsTpDcNlxt619Ue1uG75eNHhygC5kha1mpQdZyQ0a2o
         hmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751915346; x=1752520146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCwp2HDrQpkP/bLom9Qnn8CJJY2djxK53T9Kul+hqH4=;
        b=ZxEcXRGMTb3lEIup0e97vpTaCo/UTfuW0udu8qnXJV4hTbROG+jdmJLVaY8sEHtfGt
         cYvhUxhQNsOdbNUZkoW+MgI5+3PHyP3+EJ3ozPaPnFJfLeYFkVrsRJ9pj1xHxuLibaCr
         D/uXs6Ja88j2DL5Izafqx5uRC5M7p+b8uvq8n3f5c+9M0//EsOAEW4EzrHZXGdq5e6tA
         QcuGvaVpA/DMSiiZXSSsNBm8sxtPlBvqhCh9xGK0D/Q/wgIqWVWjaOtb4W4B7Ymcds/u
         PzwJ+2uWUrq6ThURdzIXCu6xLDnH1+q9II9EYorFwoSQbz8B8S0F82UZxwGni/Ad09Eb
         lYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqFZIKmIxKQYvwd1hm5klzrCQiot8JMkfzWrq4yoMkd2ubElzo4QLW4xlgH1fMVVFlQaI1LYDQW8TYwkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI0i0Ao6rPVABohskdHrahFRUG0Wi4wIcVnGq2SxNgQvABTc8a
	08O/F6b9AqL9cy5NOpnbpiXlAtLWwbIUA4BW539CkURU5jjNPhTC0f0KJr6Db/yl815lQjQewEG
	SBAjHUgYkYY0wHIJ9fXqUfOWPWbLgm0EOMhfXqvps
X-Gm-Gg: ASbGncsi2d5mhUk5tgMBgs6TqNEauMULrabamG6XcZTVfzmTMs0UH+nrzGaYBNfAW+s
	xNwwpRh5dei9HRSqmRsJnmzvHGIQ5lsClVQTN/JhAkxFrCmR5qkholmLeNI7dSmI2ahoPp9h98Q
	ZA3TwGhOeJNhj5I0UN4tjOXk00aPFPP9fY0NF3KGuTVJ3aMYEJcp9T3mLUGMKaSaDulX5RuzI3x
	MPMe2cVQzZy
X-Google-Smtp-Source: AGHT+IGtbLzjbFII8CfsipXcXRzAf+mMSBoTSHBFrhwie5ZMIaY0bLxrZ5LbLgkTfPfvXK8yO+nppi9g0MYmCQSrBTc=
X-Received: by 2002:a17:90a:a409:b0:30a:4874:5397 with SMTP id
 98e67ed59e1d1-31c21cd7f0fmr159082a91.9.1751915345690; Mon, 07 Jul 2025
 12:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751862634.git.alx@kernel.org> <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CANpmjNMPWWdushTvUqYJzqQJz4SJLgPggH9cs4KPob_9=1T-nw@mail.gmail.com>
 <kicfhrecpahv5kkawnnazsuterxjoqscwf3rb4u6in5gig2bq6@jbt6dwnzs67r>
 <CANpmjNNXyyfmYFPYm2LCF_+vdPtWED3xj5gOJPQazpGhBizk5w@mail.gmail.com> <gvckzzomd7x3cxd7fxb37b6zn4uowjubpyrnvj7ptzz3mr3zq2@xovzgew63mxr>
In-Reply-To: <gvckzzomd7x3cxd7fxb37b6zn4uowjubpyrnvj7ptzz3mr3zq2@xovzgew63mxr>
From: Marco Elver <elver@google.com>
Date: Mon, 7 Jul 2025 21:08:29 +0200
X-Gm-Features: Ac12FXzEXTnw7qQ8nVMOKnW9TwW3dvF1frJO3Pa1PT5XcHth3lVbJtQONABfUf0
Message-ID: <CANpmjNO0_RAMgZJktaempOm-KdY6Q0iJYFz=YEibvBgh7hNPwg@mail.gmail.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Chao Yu <chao.yu@oppo.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 20:51, Alejandro Colomar <alx@kernel.org> wrote:
>
> Hi Marco,
>
> On Mon, Jul 07, 2025 at 04:58:53PM +0200, Marco Elver wrote:
> > Feel free to make it warning-free, I guess that's useful.
>
> Thanks!
>
> > > > Did you run the tests? Do they pass?
> > >
> > > I don't know how to run them.  I've only built the kernel.  If you point
> > > me to instructions on how to run them, I'll do so.  Thanks!
> >
> > Should just be CONFIG_KFENCE_KUNIT_TEST=y -- then boot kernel and
> > check that the test reports "ok".
>
> Hmmm, I can't see the results.  Did I miss anything?
>
>         alx@debian:~$ uname -a
>         Linux debian 6.15.0-seprintf-mm+ #5 SMP PREEMPT_DYNAMIC Mon Jul  7 19:16:40 CEST 2025 x86_64 GNU/Linux
>         alx@debian:~$ cat /boot/config-6.15.0-seprintf-mm+ | grep KFENCE
>         CONFIG_HAVE_ARCH_KFENCE=y
>         CONFIG_KFENCE=y
>         CONFIG_KFENCE_SAMPLE_INTERVAL=0

                     ^^ This means KFENCE is off.

Not sure why it's 0 (distro default config?), but if you switch it to
something like:

  CONFIG_KFENCE_SAMPLE_INTERVAL=10

The test should run. Alternatively set 'kfence.sample_interval=10' as
boot param.

>         CONFIG_KFENCE_NUM_OBJECTS=255
>         # CONFIG_KFENCE_DEFERRABLE is not set
>         # CONFIG_KFENCE_STATIC_KEYS is not set
>         CONFIG_KFENCE_STRESS_TEST_FAULTS=0
>         CONFIG_KFENCE_KUNIT_TEST=y
>         alx@debian:~$ sudo dmesg | grep -i kfence
>         alx@debian:~$
>
> I see a lot of new stuff in dmesg, but nothing with 'kfence' in it.
>
>
> Cheers,
> Alex
>
> --
> <https://www.alejandro-colomar.es/>

