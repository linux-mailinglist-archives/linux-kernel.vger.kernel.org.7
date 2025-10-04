Return-Path: <linux-kernel+bounces-841913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF912BB883C
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 04:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B7919C3963
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 02:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2BC27E04F;
	Sat,  4 Oct 2025 02:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ERaRtHRm"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C1527E07A
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759543689; cv=none; b=B+mOGJm/RX1XH4rXyhbKNnHtO6giCBDgw1bbb/XfGyuKMSpScceRqSQeOm18izUpTx70Mgko5nO+MGTIeusMWj7SubbY1PVMyxEGD/98z2TlCu+ZVkNsOW3YEm0Yv6ajAyN8T/UvpjACIfdHUMpQY1kdJOfYLzfT0XUiUTdTglQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759543689; c=relaxed/simple;
	bh=9GkZ2ovBhlrelu07cpIypphZYtifcDUvN/jmG88PUQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkCxy+WpV5Vvfle22f74bve20fDdnAFZBl9SjmaW9EPR9rDAkc6z8zWe9d88maww8BI012mZvRBE08Npm87Ri+pdsOq30GNJqc6LIUgC7aNmzP9opL/5RsfVfPM6i3y6JGeLNrXLH9nNrRnghvX7UbmrpvnfJVPn1pBRzlhXxZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ERaRtHRm; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ddabf2ada5so42998831cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 19:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759543684; x=1760148484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUzxeZbPvk/JfjYehvQ9soJfDbesrcMGvdBByvWxU1A=;
        b=ERaRtHRmELC6MLzov4Q5lUCizzsGcbNoDiUj6nu3VrTw4cunvIvR7UlAgFaHBn9tYP
         sdx1gvDlic91ZNXnpfLgLN6ZH5y6k9WZOZgRLD/2W28h61VH9LfU54oKMGBI43Cu3ttw
         asAnetsAWcmmDibxQyDRArTsZmB9HPs1r9F7/ZLM1cfvKueLkbi2StD2u1tVqc7RSVX8
         x8zOhDuxZxHVCVJFH5HrwjY/7HdxJ9EVT0ywY8ul7q9Hg1j4rzeCj6MmalmINsBT06NL
         fVAIGx46FcceLSywRonlH4guKs0HDinYNDcWzh1uEE9qXBUjImUHXLn7M/fFQqD9so1S
         rhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759543684; x=1760148484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUzxeZbPvk/JfjYehvQ9soJfDbesrcMGvdBByvWxU1A=;
        b=iLqqUkMNJAdX0rzuRQhGfQAABNJbu9MoTAuUfDyBwy0FyT+XVx34KNvuf+1NzFRLFB
         CxoZ2+hiEikJX3Pi4J6V6NZsTzbTlpLHONVd4ZAzWzsm45UchIp5VRiDK/apKYpK/BdS
         IlyJ8uSrWyup2+5jsC1UkWU3uOxHkhv5X89TJpMAdwhWtmQrSUkEDh2rS5GPf+QQ6hiV
         xH3s+vaYHsps3Zzm9iIPHrqlpJqT+7nCUeed6t98x2YkbkOtocpF1iIUrZxXDmew1GpQ
         Xz2bY+Ts7hbDvVWPuers+SS1u7F/R+LbU6yJs8dNmsunhaeBCeVJaL73ga0m9mhax7oD
         lX4g==
X-Forwarded-Encrypted: i=1; AJvYcCVcY1QyViJGJnA7++N7YZcxzH5QQUY2m0JrgI2sZYpVIB4ll4naOelb6Hkw6yKIPXWX6kr8T8tyupLwBzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8sxw5QNOnxVBydQx3oOJjK1HsF6ZV6u004ilhkyg7om/WOdp1
	m4zHLGigS1/8QmphdJWenoQ1WX6KLk6y6Q54FDq+Cu/tMHi5K5zf9WxHVKtEmMdnfF81isjACnh
	Ab/+y6zvX6S57GGCEA8KP5euXN+dBoUszkngdnbjKiA==
X-Gm-Gg: ASbGncsPRdOf4cwMnEjTHWdnQ+C/FXePakedFTXdpfDuJ5qjtveGz71gW1gU+9BMh1T
	WfjL8A+K5OxbMuRdwAB+wBUSxwxGjBm+A3Du5ww56RdRFF2AOF+vwFsl2zCJozLYmoxlwe7gFwZ
	ouVAL9N1Yp56bpJjJ4yR9kv2f1qWK9WqVHTKhHTl/o7MmK6ADH136dpHzOhme8fljqya8wgENPV
	AMAvodon44n1ss5dAtWHPXZi4ph
X-Google-Smtp-Source: AGHT+IFAx1beBR5GfbaocbXfkSDXQDNMN60sJRbMybIKRDn++zqfipiOogFVh7nBoj/mLbN0/PW9BivaXIC2sgg2LhQ=
X-Received: by 2002:a05:622a:728d:b0:4dd:7572:216f with SMTP id
 d75a77b69052e-4e57e29e758mr31789071cf.32.1759543684209; Fri, 03 Oct 2025
 19:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-27-pasha.tatashin@soleen.com> <20251003225120.GA2035091.vipinsh@google.com>
In-Reply-To: <20251003225120.GA2035091.vipinsh@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 3 Oct 2025 22:07:27 -0400
X-Gm-Features: AS18NWBWoPm9Z7b0vbgm_XuBKnUybemYL0aTisq9eF8wk73w7jPTSRsrgP_RACE
Message-ID: <CA+CK2bBuO5YaL8MNqb5Xo_us600vTe2SF_yMNU-O9D2_RBoMag@mail.gmail.com>
Subject: Re: [PATCH v4 26/30] selftests/liveupdate: Add multi-kexec session
 lifecycle test
To: Vipin Sharma <vipinsh@google.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org, steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 6:51=E2=80=AFPM Vipin Sharma <vipinsh@google.com> wr=
ote:
>
> On 2025-09-29 01:03:17, Pasha Tatashin wrote:
> > diff --git a/tools/testing/selftests/liveupdate/.gitignore b/tools/test=
ing/selftests/liveupdate/.gitignore
> > index af6e773cf98f..de7ca45d3892 100644
> > --- a/tools/testing/selftests/liveupdate/.gitignore
> > +++ b/tools/testing/selftests/liveupdate/.gitignore
> > @@ -1 +1,2 @@
> >  /liveupdate
> > +/luo_multi_kexec
>
> In next patches new tests are not added to gitignore.

Will fix it, thanks.

>
> > diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testin=
g/selftests/liveupdate/Makefile
> > index 2a573c36016e..1cbc816ed5c5 100644
> > --- a/tools/testing/selftests/liveupdate/Makefile
> > +++ b/tools/testing/selftests/liveupdate/Makefile
> > @@ -1,7 +1,38 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +
> > +KHDR_INCLUDES ?=3D -I../../../usr/include
>
> If make is run from the tools/testing/selftests/liveupdate directory, thi=
s
> will not work because it needs one more "..".
>
> If this is built using selftest Makefile from root directory
>
>   make -C tools/testing/selftests TARGETS=3Dliveupdate
>
> there will not be build errors because tools/testing/selftests/Makefile
> defines KHDR_INCLUDES, so above definition will never happen.
>
> >  CFLAGS +=3D -Wall -O2 -Wno-unused-function
> >  CFLAGS +=3D $(KHDR_INCLUDES)
> > +LDFLAGS +=3D -static
>
> Why static? Can't we let user pass extra flags if they prefer static

Because these tests are executed in a VM and not on the host, static
makes sense to be able to run in a different environment.

> > +
> > +# --- Test Configuration (Edit this section when adding new tests) ---
> > +LUO_SHARED_SRCS :=3D luo_test_utils.c
> > +LUO_SHARED_HDRS +=3D luo_test_utils.h
> > +
> > +LUO_MANUAL_TESTS +=3D luo_multi_kexec
> > +
> > +TEST_FILES +=3D do_kexec.sh
> >
> >  TEST_GEN_PROGS +=3D liveupdate
> >
> > +# --- Automatic Rule Generation (Do not edit below) ---
> > +
> > +TEST_GEN_PROGS_EXTENDED +=3D $(LUO_MANUAL_TESTS)
> > +
> > +# Define the full list of sources for each manual test.
> > +$(foreach test,$(LUO_MANUAL_TESTS), \
> > +     $(eval $(test)_SOURCES :=3D $(test).c $(LUO_SHARED_SRCS)))
> > +
> > +# This loop automatically generates an explicit build rule for each ma=
nual test.
> > +# It includes dependencies on the shared headers and makes the output
> > +# executable.
> > +# Note the use of '$$' to escape automatic variables for the 'eval' co=
mmand.
> > +$(foreach test,$(LUO_MANUAL_TESTS), \
> > +     $(eval $(OUTPUT)/$(test): $($(test)_SOURCES) $(LUO_SHARED_HDRS) \
> > +             $(call msg,LINK,,$$@) ; \
> > +             $(Q)$(LINK.c) $$^ $(LDLIBS) -o $$@ ; \
> > +             $(Q)chmod +x $$@ \
> > +     ) \
> > +)
> > +
> >  include ../lib.mk
>
> make is not building LUO_MANUAL_TESTS, it is only building liveupdate.
> How to build them?

I am building them out of tree:
make O=3Dx86_64 -s -C tools/testing/selftests TARGETS=3Dliveupdate install
make O=3Dx86_64 -s -C tools/testing/selftests TARGETS=3Dkho install

And for me it worked, but I forgot to test with the normal make
options,  thank you for reporting, and providing your fixes, I will
address them.

Pasha

