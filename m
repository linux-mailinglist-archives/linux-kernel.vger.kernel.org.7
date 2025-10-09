Return-Path: <linux-kernel+bounces-847547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F74BCB2A1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 904B04F1065
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E997287512;
	Thu,  9 Oct 2025 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ZynmHy1"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45107286D5D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050682; cv=none; b=Qsm6GgPnLf5JpiqnMvQsS4oaBE+QZDKBsNE5rveV06Kmw85S5Kgtj7xteB0aMzXYhZryKzxGWRO6n7gl3aqQaczbF/+prmyTCubaJfK2BUjpMlY70hUl8TfeKtWC9y/+LL48E+Rdx06iWm6rTh8cBha+8SRn+dC6rQaJnwWa4zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050682; c=relaxed/simple;
	bh=9fvxDpiBJ75A3YF7/Lpzvf3cCPTSGdgJtsV2MXaYEU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se4AzkN4nkpcRuHv56KyHW5oLYIKPPlTcQlkvBA78WymDwYZLwZnXhK/kmFrMzTXujXrsGfqEL+vTE6DCSDgQChE0D3gzjXfuiINE4iZaD9Yz8eeMx4r7TsQ4R1QA0H+DWatevK8twU/dsW3wuPlRYuhC6TDyYW60kf2zJcZvNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ZynmHy1; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-27d67abd215so101475ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760050679; x=1760655479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TS3X0oB2KcD5loH5VjDML1tNfmcYzwsUaHGn/yfIcO4=;
        b=3ZynmHy1R3DD5qvtPZYvnLQWsL+kS8FmqhUinXGx0bmID+s1eE+SLhyIkGF8/fKPnx
         LO2XA5HLfvrBUaScn//ZVPktFlYcxQaxHPBl3geE4VgxJlRZYpI5BEl3Y02M591U7qPd
         dNsph5d0dLlsLqQQHzFISWfMtyALhWjzhNht6RNeD/ahm4UWhksV6vz84I/OYZVPHXNh
         E4lzcILzBzOFiwwDdTPzQ+giR4REbVY6PUb8+0DFK0Qb8pkw6arBWR2V2cCHSQTt1qzg
         4GMzOgXW5oiByMKaoYt471jfxHrpTR50LI1HU6mz+blRe0Cz4jKodDcZXIW0WO5fZUmA
         TWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760050679; x=1760655479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TS3X0oB2KcD5loH5VjDML1tNfmcYzwsUaHGn/yfIcO4=;
        b=XOgyNAR3gnwi27iVYkAXTv6s/1zdu+ALR1zWfSFzH6HDFlXpIsJaQ9mQWlVdGtQtjo
         wqdP1Oo4HCxENTjGaQuNGaCANiTjs6aMYcTsH7fujS7NrCyCPnFVbvrRx/XnLOCMNBq7
         xe+1gh/w4N5OxXIKCXVLXtOBbvkmSKVs4My07W9yp1zTSYt5xsEUiWA2sQraJGclpkOd
         UlOhEByty7u2Rz/rj6ijUoO5uLuVPPOo1CJ5CegVQhNfbdqOZEXspK0g7aaDfIidMmSz
         Aoys5vrQkzg7tbxWBMPP1Htnl2x9NkYfqeTxZW9TDbp4Q/OVEQ6QKAjT/omXiMex67i/
         e4yA==
X-Forwarded-Encrypted: i=1; AJvYcCUWSrwa10QQQK+5vUn/bMEWR1ZkMNOpya3MVryyeRvqQQzlfOaQ4Oi0i0SQ/xuK7NgHWqgTjVqN0smhHYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDklEyGYxyNwxaF2QuV+kX6JDr+nHBn+DaZiyE1UNcOmt2eLtv
	1Z5ZMu8gD501tWku1OZU7bPivXK1w59cQm8F4UiScQwi62G08MJxIcKfo5z+OXcaTA==
X-Gm-Gg: ASbGncsi6gC0sSreWrEwTuhAVV1zmcSbH87FCAmO3eJfS3RCKiSPen0ARLyXj6Mbfv/
	YqAnrg8ty/Bxj8NWH6Uemap9jhlkXSId8ZhonfJUUd+mdCXC/kXTAug0tOwDnoSXsWFiDcoVwaY
	8oM76Hn7omkwfyoPWpq7uAkdo/07iv812zTKBJFr7o3xo3FpfJL2u+3zf3MiNSDqMHPhSrVpvV4
	WGwW5ivJX7LHGiuMzgfYSslTSdcv+RMeWYlCD0sAiKBqOydT6xH4ZHDpT2ukb9q9OQ00YLss5+7
	8s3hsoVkIebgAAMhojd/YMwOdrujF18CVrV9jBmxCRpLKmlRht0Akx6ltx5mBHTnh9kKspM3yoW
	83d0N7J7dmngjLIK/XPJsp5QuxlR8pD7OI8J1cwcsxgeiiRapVBTWtj+s7q6pQp7/rbKbi4Q1Lv
	XCzo4hj6+3No4=
X-Google-Smtp-Source: AGHT+IEUelxecU4Ltxm3QGl/GGQDXbTCrG57RujR1Y9rUZidwWpY6H+v0tk5x12Foy4wJMi0lrd0zA==
X-Received: by 2002:a17:902:ce06:b0:269:63ea:6d3f with SMTP id d9443c01a7336-29027613a04mr13422595ad.8.1760050679106;
        Thu, 09 Oct 2025 15:57:59 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b252f23sm847400b3a.6.2025.10.09.15.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:57:58 -0700 (PDT)
Date: Thu, 9 Oct 2025 15:57:48 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org, steven.sistare@oracle.com
Subject: Re: [PATCH v4 26/30] selftests/liveupdate: Add multi-kexec session
 lifecycle test
Message-ID: <20251009225748.GA2098969.vipinsh@google.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-27-pasha.tatashin@soleen.com>
 <20251003225120.GA2035091.vipinsh@google.com>
 <CA+CK2bBuO5YaL8MNqb5Xo_us600vTe2SF_yMNU-O9D2_RBoMag@mail.gmail.com>
 <CA+CK2bBSObHG=9Rj623mahyhE81DhhKbN09aHS96p==8y_mCGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBSObHG=9Rj623mahyhE81DhhKbN09aHS96p==8y_mCGw@mail.gmail.com>

On 2025-10-03 22:37:10, Pasha Tatashin wrote:
> > > > --- a/tools/testing/selftests/liveupdate/Makefile
> > > > +++ b/tools/testing/selftests/liveupdate/Makefile
> > > > @@ -1,7 +1,38 @@
> > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > > +
> > > > +KHDR_INCLUDES ?= -I../../../usr/include
> > >
> > > If make is run from the tools/testing/selftests/liveupdate directory, this
> > > will not work because it needs one more "..".

This causes a build issue, see my response at the bottom.

> > >
> > > If this is built using selftest Makefile from root directory
> > >
> > >   make -C tools/testing/selftests TARGETS=liveupdate
> > >
> > > there will not be build errors because tools/testing/selftests/Makefile
> > > defines KHDR_INCLUDES, so above definition will never happen.
> > >

If one is just building test using the above make command (without
install) we don't see other liveupdate test binaries.

> > > > +# --- Test Configuration (Edit this section when adding new tests) ---
> > > > +LUO_SHARED_SRCS := luo_test_utils.c
> > > > +LUO_SHARED_HDRS += luo_test_utils.h
> > > > +
> > > > +LUO_MANUAL_TESTS += luo_multi_kexec
> > > > +
> > > > +TEST_FILES += do_kexec.sh
> > > >
> > > >  TEST_GEN_PROGS += liveupdate
> > > >
> > > > +# --- Automatic Rule Generation (Do not edit below) ---
> > > > +
> > > > +TEST_GEN_PROGS_EXTENDED += $(LUO_MANUAL_TESTS)
> > > > +
> > > > +# Define the full list of sources for each manual test.
> > > > +$(foreach test,$(LUO_MANUAL_TESTS), \
> > > > +     $(eval $(test)_SOURCES := $(test).c $(LUO_SHARED_SRCS)))
> > > > +
> > > > +# This loop automatically generates an explicit build rule for each manual test.
> > > > +# It includes dependencies on the shared headers and makes the output
> > > > +# executable.
> > > > +# Note the use of '$$' to escape automatic variables for the 'eval' command.
> > > > +$(foreach test,$(LUO_MANUAL_TESTS), \
> > > > +     $(eval $(OUTPUT)/$(test): $($(test)_SOURCES) $(LUO_SHARED_HDRS) \
> > > > +             $(call msg,LINK,,$$@) ; \
> > > > +             $(Q)$(LINK.c) $$^ $(LDLIBS) -o $$@ ; \
> > > > +             $(Q)chmod +x $$@ \
> > > > +     ) \
> > > > +)
> > > > +
> > > >  include ../lib.mk
> > >
> > > make is not building LUO_MANUAL_TESTS, it is only building liveupdate.
> > > How to build them?
> >
> > I am building them out of tree:
> > make O=x86_64 -s -C tools/testing/selftests TARGETS=liveupdate install
> > make O=x86_64 -s -C tools/testing/selftests TARGETS=kho install
> 
> Actually, I just tested in-tree and everything works for me, could you
> please verify:
> 
> make mrproper  # Clean the tree
> cat tools/testing/selftests/liveupdate/config > .config # Copy LUO depends.
> make olddefconfig  # make a def config with LUO
> make kvm_guest.config # Build minimal KVM guest with LUO
> make headers # Make uAPI headers
> make -C tools/testing/selftests TARGETS=liveupdate install # make and
> install liveupdate selftests

Yes, this one builds the tests.

However, if instead of using the above make command, we do

  cd tools/testing/selftests/liveupdate
  make

This will error out

    LINK     liveupdate
  liveupdate.c:19:10: fatal error: linux/liveupdate.h: No such file or directory
     19 | #include <linux/liveupdate.h>
        |          ^~~~~~~~~~~~~~~~~~~~
  compilation terminated.
  In file included from luo_test_utils.c:21:
  luo_test_utils.h:13:10: fatal error: linux/liveupdate.h: No such file or directory
     13 | #include <linux/liveupdate.h>
        |          ^~~~~~~~~~~~~~~~~~~~
  compilation terminated.
  In file included from <command-line>:
  /usr/include/stdc-predef.h:1: fatal error: cannot create precompiled header /liveupdate: Permission denied
      1 | /* Copyright (C) 1991-2025 Free Software Foundation, Inc.
  compilation terminated.
  make: *** [Makefile:30: /liveupdate] Error 1

Reason for this build error is KHDR_INCLUDES in the selftest/liveupdate/Makefile

Following fix resolves this above two "No such file or directory" error.

diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index 25a6dec790bb..6507682addac 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only

-KHDR_INCLUDES ?= -I../../../usr/include
+KHDR_INCLUDES ?= -I../../../../usr/include
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += $(KHDR_INCLUDES)
 LDFLAGS += -static

My git diff in the first response fixes build issue and generate tests.
https://lore.kernel.org/linux-mm/20251003225120.GA2035091.vipinsh@google.com/

I am used to kvm and vfio selftests. They both build all their binaries
by running 'make' from their directories. That's why I found it odd that
liveupdate is behaving differently.


