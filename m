Return-Path: <linux-kernel+bounces-763643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6A5B2181F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674281A225E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E921B1D61B7;
	Mon, 11 Aug 2025 22:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DuyyTdrN"
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7859F1D6195
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950666; cv=none; b=WyUbrMS9CohZimRLQw+oOLxm/nhz0XmP5+uWo/01ISbkRIA7yv+5qRi+l3/ZGD2quYIbR615xxNSJeZUHXXmAZypmzb55YpGqtS4jHIGZL7ddG3X6naZ/qmozbPY9+r4gG8HOaYzzEA6EOrA2i7qND7qkjazw+KaRpfs5wv+HFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950666; c=relaxed/simple;
	bh=Ht/UHT3sLBhR0Zk80MTwgw23vViXOFXrlKz0LswUhvU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ERSOZ63f/cwIZSevZBkviIF1Gqh5WzThHRRsi2kpS2ed7mn89pgEHTnFi4cIuswa6nXZrSPOepy359f646010KDzQdIdLNfj1nl8TDj6TKU1HIcMjnUbqNsXZVa9OXDYRml4WDvry/ONSo0km+3JaP8Kf1IED6TTAIMwF4SttXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DuyyTdrN; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7e7ffe84278so991673185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754950663; x=1755555463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tsTpiVRLtnpCIisNiGgEETpcDrFcJWiGEHWB60H2Tzc=;
        b=DuyyTdrNTQYHJr436vX2RDg+2npu+D7a+NLR8SlHifGB+Y5QpAFVB1sX0AjzW7e6sL
         f22PTmJHIFjUzGYCUkraa//noQ9IFqlHaZeRnlxlbLyXlkSDfO0U2loMJ8Xhr9aBiCA7
         lvXZjLorHcOPPUZtWHnaDTSx7Rgy3a2LvFpg0TusfJAtfbJ3vqpIM3azq9A9H/tTr7Nd
         HJjltlP9zs3snfrbiNU8rDL2bMOyLOh4v1tQ0349aYTYzatdbkWSwIo/QVQ79fkyY9K9
         MUTLscNqNu42lf+AkQWXLJlZoWYC5mi5qdfTprQTl/ghpgJ7P3p7E++P1lpO3ubxr7FF
         jIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950663; x=1755555463;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tsTpiVRLtnpCIisNiGgEETpcDrFcJWiGEHWB60H2Tzc=;
        b=FVi3Xrn+TE4gXpIBvOByWVLvnE5f/z/SCnw2nYnt8YOWc3YPqn0UPMC06Nm7zRYRem
         9BrvnoKKOrf5d8Y1M2fJRcUWfoWCJOTtFRffnAieEH1PzmcfJU3joYHPKowyR+B9GAU6
         bXBEQpKEarnR4wwe+be6SgvNv3JkUskxlJ8XKILm4Jg/Ao8fqCGmI9MjhNBo/F7+40w6
         51hRk2HZJr0njHMOi955EerCLacIVyPyyftDidrt26mXyMgB5teMQY5GxlGyiMpS7BVe
         MG8iUNnYGJQuGwLQj79K9QUYW8rk640PcIa8L/zCViULyuFvenPQB0L7fc76JYNOZKu5
         7diw==
X-Forwarded-Encrypted: i=1; AJvYcCVUctnd1F6dRxQdSKYg/19lG05y51on9eHGUXtFjm3j+NXtmK1Hz+R+lvUwc40pU8VMkrXhy8NX+JxkTXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz91S4pKZr97yLmO3YJEVILkac26sInWEGd2O1BFBL2Z0/M+AnK
	f/egnjRZ40Hsm8ePgGevS/mWpWkXzo+knm8TzfBXrTH/LWhTNxyXUV9JPWbo6ddRTT/qhQf/gi0
	zuH427jDJ5nfNvg==
X-Google-Smtp-Source: AGHT+IGLY1363SKVs1UR+Wi4x98jSfDfthClu1+vmuO4PXrMkif+fZojShhrhTTkXKzMJXFQxdtGp6zu02KtrQ==
X-Received: from qknwd46.prod.google.com ([2002:a05:620a:72ae:b0:7e6:36d3:ccf2])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:612a:b0:7e3:35e3:3412 with SMTP id af79cd13be357-7e858897035mr146693485a.34.1754950663342;
 Mon, 11 Aug 2025 15:17:43 -0700 (PDT)
Date: Mon, 11 Aug 2025 22:17:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250811221739.2694336-1-marievic@google.com>
Subject: [PATCH v2 0/7] kunit: Refactor and extend KUnit's parameterized
 testing framework
From: Marie Zhussupova <marievic@google.com>
To: rmoar@google.com, davidgow@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev
Cc: mark.rutland@arm.com, elver@google.com, dvyukov@google.com, 
	lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com, 
	rodrigo.vivi@intel.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, kasan-dev@googlegroups.com, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Marie Zhussupova <marievic@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello!

KUnit offers a parameterized testing framework, where tests can be
run multiple times with different inputs. However, the current
implementation uses the same `struct kunit` for each parameter run.
After each run, the test context gets cleaned up, which creates
the following limitations:

a. There is no way to store resources that are accessible across
   the individual parameter runs.
b. It's not possible to pass additional context, besides the previous
   parameter (and potentially anything else that is stored in the current
   test context), to the parameter generator function.
c. Test users are restricted to using pre-defined static arrays
   of parameter objects or generate_params() to define their
   parameters. There is no flexibility to make a custom dynamic
   array without using generate_params(), which can be complex if
   generating the next parameter depends on more than just the single
   previous parameter.

This patch series resolves these limitations by:

1. [P 1] Giving each parameterized run its own `struct kunit`. It will
   remove the need to manage state, such as resetting the `test->priv`
   field or the `test->status_comment` after every parameter run.

2. [P 1] Introducing parameterized test context available to all
   parameter runs through the parent pointer of type `struct kunit`.
   This context won't be used to execute any test logic, but will
   instead be used for storing shared resources. Each parameter run
   context will have a reference to that parent instance and thus,
   have access to those resources.

3. [P 2] Introducing param_init() and param_exit() functions that can
   initialize and exit the parameterized test context. They will run once
   before and after the parameterized test. param_init() can be used to add
   resources to share between parameter runs, pass parameter arrays, and
   any other setup logic. While param_exit() can be used to clean up
   resources that were not managed by the parameterized test, and
   any other teardown logic.

4. [P 3] Passing the parameterized test context as an additional argument
   to generate_params(). This provides generate_params() with more context,
   making parameter generation much more flexible. The generate_params()
   implementations in the KCSAN and drm/xe tests have been adapted to match
   the new function pointer signature.

5. [P 4] Introducing a `params_array` field in `struct kunit`.
   This will allow the parameterized test context to have direct
   storage of the parameter array, enabling features like using
   dynamic parameter arrays or using context beyond just the
   previous parameter. This will also enable outputting the KTAP
   test plan for a parameterized test when the parameter count is
   available.

Patches 5 and 6 add examples tests to lib/kunit/kunit-example-test.c to
showcase the new features and patch 7 updates the KUnit documentation
to reflect all the framework changes.

Thank you!
-Marie

---

Changes in v2:

Link to v1 of this patch series:
https://lore.kernel.org/all/20250729193647.3410634-1-marievic@google.com/

- Establish parameterized testing terminology:
   - "parameterized test" will refer to the group of all runs of a single test
     function with different parameters.
   - "parameter run" will refer to the execution of the test case function with
     a single parameter.
   - "parameterized test context" is the `struct kunit` that holds the context
     for the entire parameterized test.
   - "parameter run context" is the `struct kunit` that holds the context of the
     individual parameter run.
   - A test is defined to be a parameterized tests if it was registered with a
     generator function.
- Make comment edits to reflect the established terminology.
- Require users to manually pass kunit_array_gen_params() to
  KUNIT_CASE_PARAM_WITH_INIT() as the generator function, unless they want to
  provide their own generator function, if the parameter array was registered
  in param_init(). This is to be consistent with the definition of a
  parameterized test, i.e. generate_params() is never NULL if it's
  a parameterized test.
- Change name of kunit_get_next_param_and_desc() to
  kunit_array_gen_params().
- Other minor function name changes such as removing the "__" prefix in front
  of internal functions.
- Change signature of get_description() in `struct params_array` to accept
  the parameterized test context, as well.
- Output the KTAP test plan for a parameterized test when the parameter count
  is available.
- Cover letter was made more concise.
- Edits to the example tests.
- Fix bug of parameterized test init/exit logic being done outside of the
  parameterized test check.
- Fix bugs identified by the kernel test robot.

---

Marie Zhussupova (7):
  kunit: Add parent kunit for parameterized test context
  kunit: Introduce param_init/exit for parameterized test context
    management
  kunit: Pass parameterized test context to generate_params()
  kunit: Enable direct registration of parameter arrays to a KUnit test
  kunit: Add example parameterized test with shared resource management
    using the Resource API
  kunit: Add example parameterized test with direct dynamic parameter
    array setup
  Documentation: kunit: Document new parameterized test features

 Documentation/dev-tools/kunit/usage.rst | 342 +++++++++++++++++++++++-
 drivers/gpu/drm/xe/tests/xe_pci.c       |   2 +-
 include/kunit/test.h                    |  95 ++++++-
 kernel/kcsan/kcsan_test.c               |   2 +-
 lib/kunit/kunit-example-test.c          | 222 +++++++++++++++
 lib/kunit/test.c                        |  87 ++++--
 rust/kernel/kunit.rs                    |   4 +
 7 files changed, 726 insertions(+), 28 deletions(-)

-- 
2.51.0.rc0.205.g4a044479a3-goog


