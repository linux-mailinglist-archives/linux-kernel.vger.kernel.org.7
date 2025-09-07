Return-Path: <linux-kernel+bounces-804873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6321AB48131
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3EAE1895EF1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 23:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22C923182D;
	Sun,  7 Sep 2025 23:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDwwRIIe"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63392248BD
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757286893; cv=none; b=Um6Y5jcY3NA3ttZ68fAt3xV6mmuZ7pyvOxJ8XYxrQPQwrrbfJZuR5e+bQaiQLBdH2oQaMU+QHlJBNkxacPEM07S9kdn+yQGaCz0KqZrwIe2jE15S14ozLUJgS3dgh4bH/QfigVd/Q3PW+MleCB4KCZiR+abiJK97fiR0rwEJhYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757286893; c=relaxed/simple;
	bh=wo3tK6bHFA7DqiNO7PYI330tCwygBeTXt4YoEOQtnvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCiyvFkMHkLqOyPb/460KZ8UMbVgVuMJNL60OnrK/rS0NQX4lVeq6+Ea2wKVCaDuUw7c4ec34BVBYXBxtKenmBTKRN/4HsWYOeG2OJfV2DUmANv/d1tzHlphjP+l47Tk5EJ1tkvmURzF8f6z06hMChpVWKCnicWAVPkxm/xYHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDwwRIIe; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24b2d018f92so241535ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 16:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757286891; x=1757891691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wo3tK6bHFA7DqiNO7PYI330tCwygBeTXt4YoEOQtnvM=;
        b=LDwwRIIed8+jP9h5vzReLPyBOvV4QVvkv2nv62uP2j4ZavIsnFKK0y6NiK/T4HycbI
         BlD0FUPTWyMUkhjgYX2d/z85TcdxwFOcXb7x0DblyBXm4zwVFslIvZ3NSwbmj4Q7b2xv
         1HghuV6otkpg1DFHuZmxgVrWKerd1A36uSH9UWiT2BQeY0gW0juoeAz9rYiLISQa/jHa
         n2OIKskNhax+/4dZSO1OOyZfRewasfNx5A7gpdqT9wsmQKb4tfzSwPzMtoMkS0yWQLuR
         bvWCfUiJA6NdWD8KGcJFsMuXDWfHMBOgsM6qgbbSJBi67Wx4CpMapaGshFGfICCT1ChD
         ht0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757286891; x=1757891691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wo3tK6bHFA7DqiNO7PYI330tCwygBeTXt4YoEOQtnvM=;
        b=RpJOvDNgtY6wsLjUWrPOCZvQlvFqZo+yyLOrKk4pnrJ8Yj9Ch1gB8T5XTRNfkp7hU6
         8nGlTAfyjostRoRaPtW0vztWLJtkgy8XRnDrnDCZQgybHHhS/LoXI+RDirlMucGG2UhJ
         Hd35ub2O7hY8IeQc982TAsrDcK54q0jaS4DVYHJDdOxMZrRCtPHOhKdTKUxTyJdJUqfa
         yMy/w3TAVkDNuhdz8Odv6U+RzFXr+sHPWxFcpIhw3u/7+qC25i+YZTl4to5fP6BCaCh9
         E1NgZsBt55EEvUUMc4wYsuyB71bgXOsl2dZ0RYo3DX5cpXp6cVAy64b790ECUq/7rf4C
         WTSA==
X-Forwarded-Encrypted: i=1; AJvYcCW2Y4nRuCllKWRVewXj1XmSuqPI7zvlycufrKjm9VQxbD/QMhpmHQdCDU1KqclfLMIxk5PGRalQygWDy+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK29tR6uTPtQDJUaR463v1mYlBqVyaWI1y51R+wC0X0/enm5ak
	ZdLkIQJqnyO5PZFw7rpFktvkQo04CXohLjMC0Py6AhFlXmzd/dLncSHRs8enGhcv363ZoAUR6QO
	Sbzbi8KLoJDZz1Npjy1jdkaye2QVmgQoRrWoryMea
X-Gm-Gg: ASbGncs15QmI1C5JLadA8vtDdXxWuIJzT1QEjIyiehw0ZcgczvertGM35Sg2NJ1g4G1
	BAOTn117Me0hR6snvPxmW3Xwwb2NND42Gwa8yR5PSOSdJykmMGhA9mSYjMZ+ZOJlc5mTIoOuSne
	BZDB9vFs/uFNW7mqt6I7tzsyETCG91v2aLoqlHJlWvLDF4qNHswXadsq3KIP28OfdcQ3IAtf4+X
	8SZOnVenr9WRpg=
X-Google-Smtp-Source: AGHT+IEltd/sAul6Dn7ms8HB6NIeq1vgyjW8DOdKH+H9ryQVdD/7vpwWCRfh119NUS1vpsfKq75+rwJhHcfHD7PiJjg=
X-Received: by 2002:a17:902:db11:b0:24b:1741:1a4c with SMTP id
 d9443c01a7336-2510f458c5emr4290315ad.0.1757286890641; Sun, 07 Sep 2025
 16:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100959.83023-1-cuiyunhui@bytedance.com>
 <20250827100959.83023-2-cuiyunhui@bytedance.com> <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
 <CAEEQ3wmBvevbkP8XmwR0_q_1QWQsie5g0UUxTFm6ovS1m41pEQ@mail.gmail.com>
 <CAD=FV=UzUCPtwuQRFR0SkAkh63MbzMefxNYmiOBxCemL3P_+EQ@mail.gmail.com>
 <CAEEQ3wmLOjZxVh_vBhmctH-u_ZSxnyg0GiN-_e_4v8_pfxcbSw@mail.gmail.com> <CAD=FV=XaSP2A7Dufrxt1DUUznF9Yk-qdBY3wbE03x4_L8HJLSQ@mail.gmail.com>
In-Reply-To: <CAD=FV=XaSP2A7Dufrxt1DUUznF9Yk-qdBY3wbE03x4_L8HJLSQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 7 Sep 2025 16:14:39 -0700
X-Gm-Features: Ac12FXyVydF5cSsxyRKJ_un6fARDQ6-2DZTw3qkJGbuqWtoGH405LU6WKebU2PI
Message-ID: <CAP-5=fWkcxvZ0z9FJztbN4EhU+BNEJTNxe2a6_+11EcYhjZQaQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] watchdog: refactor watchdog_hld functionality
To: Doug Anderson <dianders@chromium.org>
Cc: yunhui cui <cuiyunhui@bytedance.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, atish.patra@linux.dev, 
	anup@brainfault.org, will@kernel.org, mark.rutland@arm.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	catalin.marinas@arm.com, masahiroy@kernel.org, suzuki.poulose@arm.com, 
	maz@kernel.org, zhanjie9@hisilicon.com, yangyicong@hisilicon.com, 
	mingo@kernel.org, lihuafei1@huawei.com, akpm@linux-foundation.org, 
	jpoimboe@kernel.org, rppt@kernel.org, kees@kernel.org, 
	thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 4:57=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Wed, Sep 3, 2025 at 4:56=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.co=
m> wrote:
> > I=E2=80=99ve read your linked content, which details the pros and cons =
of perf
> > watchdog and buddy watchdog.
> > I think everyone will agree on choosing one as the default.
> > It seems there=E2=80=99s no kernel/watchdog entry in MAINTAINERS=E2=80=
=94what=E2=80=99s next
> > for these two approaches?
>
> I guess to start, someone (you?) should send some patches to the list.
> Maybe one patch to make buddy the default and one to change the
> description of the "perf" lockup detector say that its usage is
> discouraged, that it might be removed, that people should use the
> "buddy" detector instead, and that if there's a reason someone needs
> the "perf" detector instead of the buddy one then they should make
> some loud noises.
>
> You'd want to CC folks who were involved in recent watchdog changes
> and make sure to CC Andrew (akpm). If folks react positive and Andrew
> agrees then he'll likely land the the patches and we'll have made
> forward progress. :-)

+1

There are also things like /proc/sys/kernel/nmi_watchdog being used to
enable/disable the hard lookup detector. If we could move that to a
unique file so that perf is less confused in places like:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/util/util.c#n70
ie. perf shouldn't warn about the NMI watchdog being enabled and
taking a perf event when it doesn't.

Thanks,
Ian

