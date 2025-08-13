Return-Path: <linux-kernel+bounces-766756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C9BB24AC3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3193B41E2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311302EA49D;
	Wed, 13 Aug 2025 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkVw6gkD"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E857261D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092322; cv=none; b=Iloj0kHQbescNwYwaKqwIHBMbyNkEH3CR1YrBtNu+enbvTHegYoL/FpuMBhfeIbSLfkHE2yZCA9d8su8qLXNF/Z8dKavC4gHdMKBW67TSQwJhyvJQq7KNHP+7QCuWsdE/K8Ld4GT8MBO5sqtQnKLDccZYpSm/VkAleMayXyTYpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092322; c=relaxed/simple;
	bh=QR44wgP/fzKcseoCKBHhJjHA/+nFZp3KlRlFhM0S/zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XykMM6xzzA1+8OvdwWoxhb0g6F8HCoj4i92wBBxheB5hAH8C1zpuRxzFQQGH7fRSojOf9Ace7hj1ur+8tEN6gDZO5ayTeuhLeU7/DYEDKxruJEpdkfrwhpEIrQmn/fAd6fTZL4nvvGrtI79+mSD1tXzgGneVLrzKfd4b4lRyGS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkVw6gkD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b78d13bf10so6777228f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755092319; x=1755697119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Nw3bTX6xGGMKWExTDEEfa2WPWmKzMn7BL7inlmF4mY=;
        b=mkVw6gkDc5RnNBHczZaKEjjHdGiWgxZzG1Hz5+f4RaTgx0MS1Zw8SGyh/Y94NQ2Gsv
         gtdNRornXbeGubXqkTf6PKrtOu7ESq8+j34jTbgwXRHQ1RhM4yCz5UgWkMFpP+cTMgwU
         +9/+4MrVvhwXMoyBhnWLn8y6KlBZgdiRN7FJUNXk6/zyBKogG4X3cGHlIg8UQkUBhx7i
         JssM/ER7lsBLE6zWxFn+f2nLkLQWG2Zu0cD92gTbnvkhKGtYibEuGxSbFO7+m3ijQ//v
         vlA7MTkRFhkpsjA3Gbkrby7VX1O2+QJ7AmG2l3kCe2XRO09w2NahDIPEGmX0Tfm9A1Tg
         tXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092319; x=1755697119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Nw3bTX6xGGMKWExTDEEfa2WPWmKzMn7BL7inlmF4mY=;
        b=KzqeJrf7rZJbEJdxo6E+L1JK1dTCJXzdaF2sF+QHS8Gu9kb372rdQAEkm2uTuaKEhY
         TZFkyA8Q5Tet1ws0bJPMdkjoZLMRfw7KtLKiWOa561AUfD43NhbMhDhYxMO3pF1M6fFl
         yyOIH3J0cla+uheYH0K5DZuSyAsqTP1XzofvRMwGB6USBN4MotgXULfP9iOBTpPdS/jL
         XZ0MD9BhF9k1cBgp+c4kf2uLtPGO6r4ki1dbFG4t6hPiitLooyIHtuKBEGLVdcRehxZJ
         RfZowE/xkKsS+PNPFkzIk8srU1KP5jRBBoHh6Us4uSYAvRIw+ecEnol95vxSfs7hqU6N
         JT+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAAm0/VoalVxerO4G8qwqFNMI5iSMhoFALPb0YA7J/HsGK7THo8jO0xjEzJE9WmBQwT426AmJBwgPitu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeveA0Ec43mTaidgq6L5yoXCHfdbq43fwKd+jeHmZrmk+n4htQ
	vQN/9Jw9UhnfzC2XDDALKT313eyRv7wDA28Nr9GO6JIga7t+wY/4awjJ
X-Gm-Gg: ASbGnctj/0wbB0eAxP0r0U/Ez6efY6eSlWy2X1fIv4NCbr+1C9xOJKI901xCMieYKW+
	nOXXTSRGWxznsikNB0cNHqPNMWyiszOCtf1dfG+l0OTAYhsfhMlvVHnObj0ruLcxm7LsiQZFYJ2
	ClaKGlyQaEeypw/ZL4RD8yi4jsp/smJFpb1XAETWusJpVRaTRdoLOZKnmSA7HN24N0qJQ/lQ0Uc
	mSXKfMQ6nO+oHbCjgV8F4NQ1r6KmrJ2HrrlCf8BCWp7ut9p84oExVDBp45CjiMsL5j8OdqLWhAY
	9+IMkt33T4VD+GtjrH8unIsRRDCozY4ey29nx1dHaxiiosQ92riRe55dfXtjgm9ncHMbHuqJasq
	DLU57eZLtwDfeNvfkpqOFLvN/DR6yObQuoQ2sUZ7653sUR71YWYlItH/elahviTZEk91uUNr1BW
	5qKaLMKUu2swOGkHfCTs2qLlN02A==
X-Google-Smtp-Source: AGHT+IE6zoV9XOpaBmQyCC834tm7Md5Dm0cgWxqTRi9Ac7HS3234LXrNY+vyp2Hs43MmMgcvyJI53w==
X-Received: by 2002:a05:6000:188e:b0:3a3:6e85:a529 with SMTP id ffacd0b85a97d-3b917edcf84mr2417374f8f.51.1755092318802;
        Wed, 13 Aug 2025 06:38:38 -0700 (PDT)
Received: from xl-nested.c.googlers.com.com (87.220.76.34.bc.googleusercontent.com. [34.76.220.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f8b1bc81sm25677444f8f.69.2025.08.13.06.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:38:38 -0700 (PDT)
From: Ethan Graham <ethan.w.s.graham@gmail.com>
To: ethangraham@google.com,
	glider@google.com
Cc: andreyknvl@gmail.com,
	brendan.higgins@linux.dev,
	davidgow@google.com,
	dvyukov@google.com,
	jannh@google.com,
	elver@google.com,
	rmoar@google.com,
	shuah@kernel.org,
	tarasmadan@google.com,
	kasan-dev@googlegroups.com,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1 RFC 0/6] kfuzztest: a new kernel fuzzing framework
Date: Wed, 13 Aug 2025 13:38:06 +0000
Message-ID: <20250813133812.926145-1-ethan.w.s.graham@gmail.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ethan Graham <ethangraham@google.com>

This patch series introduces KFuzzTest, a lightweight framework for
creating in-kernel fuzz targets for internal kernel functions.

The primary motivation for KFuzzTest is to simplify the fuzzing of
low-level, relatively stateless functions (e.g., data parsers, format
converters) that are difficult to exercise effectively from the syscall
boundary. It is intended for in-situ fuzzing of kernel code without
requiring that it be built as a separate userspace library or that its
dependencies be stubbed out. Using a simple macro-based API, developers
can add a new fuzz target with minimal boilerplate code.

The core design consists of three main parts:
1. A `FUZZ_TEST(name, struct_type)` macro that allows developers to
   easily define a fuzz test.
2. A binary input format that allows a userspace fuzzer to serialize
   complex, pointer-rich C structures into a single buffer.
3. Metadata for test targets, constraints, and annotations, which is
   emitted into dedicated ELF sections to allow for discovery and
   inspection by userspace tools. These are found in
   ".kfuzztest_{targets, constraints, annotations}".

To demonstrate this framework's viability, support for KFuzzTest has been
prototyped in a development fork of syzkaller, enabling coverage-guided
fuzzing. To validate its end-to-end effectiveness, we performed an
experiment by manually introducing an off-by-one buffer over-read into
pkcs7_parse_message, like so:

-ret = asn1_ber_decoder(&pkcs7_decoder, ctx, data, datalen);
+ret = asn1_ber_decoder(&pkcs7_decoder, ctx, data, datalen + 1);

A syzkaller instance fuzzing the new test_pkcs7_parse_message target
introduced in patch 6 successfully triggered the bug inside of
asn1_ber_decoder in under a 30 seconds from a cold start.

This series is an RFC to gather early feedback on the overall design and
approach. We are particularly interested in feedback on:
- The general utility of such a framework.
- The design of the binary serialization format.
- The use of ELF sections for metadata and discovery.

The patch series is structured as follows:
- Patch 1 adds and exposes a new KASAN function needed by KFuzzTest.
- Patch 2 introduces the core KFuzzTest API and data structures.
- Patch 3 adds the runtime implementation for the framework.
- Patch 4 adds documentation.
- Patch 5 provides example fuzz targets.
- Patch 6 defines fuzz targets for real kernel functions.

Ethan Graham (6):
  mm/kasan: implement kasan_poison_range
  kfuzztest: add user-facing API and data structures
  kfuzztest: implement core module and input processing
  kfuzztest: add ReST documentation
  kfuzztest: add KFuzzTest sample fuzz targets
  crypto: implement KFuzzTest targets for PKCS7 and RSA parsing

 Documentation/dev-tools/index.rst             |   1 +
 Documentation/dev-tools/kfuzztest.rst         | 279 ++++++++++
 arch/x86/kernel/vmlinux.lds.S                 |  22 +
 crypto/asymmetric_keys/pkcs7_parser.c         |  15 +
 crypto/rsa_helper.c                           |  29 +
 include/linux/kasan.h                         |  16 +
 include/linux/kfuzztest.h                     | 508 ++++++++++++++++++
 lib/Kconfig.debug                             |   1 +
 lib/Makefile                                  |   2 +
 lib/kfuzztest/Kconfig                         |  20 +
 lib/kfuzztest/Makefile                        |   4 +
 lib/kfuzztest/main.c                          | 161 ++++++
 lib/kfuzztest/parse.c                         | 208 +++++++
 mm/kasan/shadow.c                             |  31 ++
 samples/Kconfig                               |   7 +
 samples/Makefile                              |   1 +
 samples/kfuzztest/Makefile                    |   3 +
 samples/kfuzztest/overflow_on_nested_buffer.c |  52 ++
 samples/kfuzztest/underflow_on_buffer.c       |  41 ++
 19 files changed, 1401 insertions(+)
 create mode 100644 Documentation/dev-tools/kfuzztest.rst
 create mode 100644 include/linux/kfuzztest.h
 create mode 100644 lib/kfuzztest/Kconfig
 create mode 100644 lib/kfuzztest/Makefile
 create mode 100644 lib/kfuzztest/main.c
 create mode 100644 lib/kfuzztest/parse.c
 create mode 100644 samples/kfuzztest/Makefile
 create mode 100644 samples/kfuzztest/overflow_on_nested_buffer.c
 create mode 100644 samples/kfuzztest/underflow_on_buffer.c

-- 
2.51.0.rc0.205.g4a044479a3-goog


