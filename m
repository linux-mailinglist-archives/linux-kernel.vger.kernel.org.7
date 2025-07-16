Return-Path: <linux-kernel+bounces-733746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5713DB078A3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC3D7BB67E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95922EE98E;
	Wed, 16 Jul 2025 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfFfR1XM"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE6C2494FF;
	Wed, 16 Jul 2025 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677307; cv=none; b=iWy/fvGBE0M+/FiBTQoGTWTBm1xQuHyGos9WU7jXEJTZi801LB6H+FnaxMovAAOLArDj/I7FsCFsqGbSQcc82uMRPuMNmLCT64t4XzfiHOTTt8JxO1L9FAuJmy9NKsZrlF9flraURtfjBq4E6GIb0nxL0+/Z0g4Yt0tsi/oLjsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677307; c=relaxed/simple;
	bh=Oap3ye2/QsVi2kHzOFcy7QN0XicwHAomR7W+vibfT5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eZa3hoAyNQ9ztKmiBdN3ORBl9pe/1FqIoKe8Wo5ZL1yLFIJtntyCYYe8fHznzol0E5NJkHzxrok+TbUniHLAWtIklG+JKIRPweGQIY62j5juOpIBrlqC+aB96TdEuO+5A9U0IlIPTdbjLyA36EP4dhXbftWJbPca573rVOP5ry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfFfR1XM; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e34399cdb2so75844885a.3;
        Wed, 16 Jul 2025 07:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677304; x=1753282104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bJywyKnJu4vDCOY/rQGGbu99H2+F5JuxSSqe/I/ioxg=;
        b=CfFfR1XMy0SaKxCcRNfW2o0luwkOLUwGz45vB36oX2+F+ymrqOwGDYm9lV0AFtIrWi
         pXMchN1MXQEBilaPJ3twRDZrrWXyYJiUkRrLMlDVlKTR1hg/MfYk6bN3w8a8xmpqAGzr
         3640es4mQeShzmEqZ0gD6LhxOazR72OtZKBAUXCxML08k2+rIrS3GKDglvhh2W4VmVLC
         FNA0JSV8Rlh1WHS/0GFVAWM+pv7c2Hg02GaBB0ClyGs7lpJbQGcM2VDF8J0PiHowJMaj
         9/12Rfc4rREwKMunbaAFlS2RlEsYMCUPdbNZDEeP1YrqdxW4HVQiHOZ+KI4IU0AzknKn
         EP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677304; x=1753282104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJywyKnJu4vDCOY/rQGGbu99H2+F5JuxSSqe/I/ioxg=;
        b=AjAIHuX2UJYzwStir5rZu0Tsu68uUcsswFR43UjVQQsiNixLcpLUwP199L9zBcvoO9
         nPvvEYuECpFPb56qsFHRPc9P73olqY6WrkaGLFKOqrSsmVkrngStRfbQzdxan2mlSFAv
         5imNyJCr5rYdpxlsW9StK3EzrNzxMjrw36Xih/KZLbhnUViJCViRd5/ZRiNeZY+T7ZJf
         SuQLpq8FRHKpm5obZjRTFCZW6qqoik2IPe5xuET2xll+teWST3BfvNEueR0Z5+W7SHdz
         1baGSWgyp/DFYIPg7M0Q82Yyd5x+P29rwpS/Du1osgqOZGHVsTBwZpFENhQOs6j6n32v
         ZD7g==
X-Forwarded-Encrypted: i=1; AJvYcCW4vkkihste3BwLspbBqtWIvWSRfxcyLqwRROg1Whs0ov/ppWHXvTVo9y7PsvmpT8FQQmtFB7j8j5HrZDM=@vger.kernel.org, AJvYcCXc23+XKByy1i87miRYqPtODo86YUK0lyvNs8RBAnN27SRH/IKsJXOC19hsEw3MOeJSw9WkQPJoXMCe7ReO5mU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0JnJikBZ+3gmq8/Gl+5D9014G12AcpZy6SL4reeWx2Q3EeVu3
	BhP3yT4wrnXyELRDEHVaoyo/2TfxlFJ/1kDe8Ovzz3LL92EDj2Mk8mqi
X-Gm-Gg: ASbGncuRlisLdTIGCSpnE8sfr/RtZ8Xew1i/vwdHWwYP3+wpNkjQf8h3eOO0VsDBZLM
	w1m6WQTrZaQH/+BOVF/5phttD+skZhJArF07XHvCixXs4wTOIkN9qpSDF8hEcsRDIdMptbH4UKC
	qbFUV+IsO5P9L4L5a2EXqUDoLUE+w9H01Jx7Dd3IpDu+fkQZwaJaUU3RbUkxWCQmpzCePMe+2bM
	Lm76C/VmNXHWpXIC6c0ruOihKDh+d7rbM2NBlsoMJAH3gK3mQDJ4xE0Er5ma9aGxteyR/4vgxtJ
	Wp+RNJ65MrTKNY91EWY4J5gptYqnzg+uJoulPHTByGEluVSf8tUery5lXWrNcg1iHyJnPnpNk37
	692yndQjlpmHmtV4MEJwMv0QPIX787VbADxeYuNB4Rxxd72Vc/H+oEsi8eX2qbsdyPJsX0n8Wz/
	sXsyLyL54tiWVa
X-Google-Smtp-Source: AGHT+IFghpez3Lwe9Aj+WKAHO/LgrB8Sub1BS7nbPw/ayWcpQToYz0ZcZ+oN8nObjURkMr5IHqe8+w==
X-Received: by 2002:a05:620a:192a:b0:7d5:e432:2d91 with SMTP id af79cd13be357-7e342b8a269mr452227985a.49.1752677303625;
        Wed, 16 Jul 2025 07:48:23 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdc0f7d06sm759488885a.40.2025.07.16.07.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:48:23 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id CFCB0F40068;
	Wed, 16 Jul 2025 10:48:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 16 Jul 2025 10:48:22 -0400
X-ME-Sender: <xms:trt3aMGb6_TspvIA62WvdbEmX0_UmadvqgsmuOowV2QbBzPayXCemw>
    <xme:trt3aBOKEeF2ivRMN7UgpYyT5679Prp8-18WQyT2SNgP5KDYHY0-Dcv6lcQ7Gn2om
    AU02RpLEGKdj-UNoA>
X-ME-Received: <xmr:trt3aDL30ykJhsz37IePY2WlEId6K4wiC3inYYx7eLL_E_trwA-oeJIKfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeekgffgveeutdeuhfegteevudduffejjedvjefftedtkefgueejgedvtdeutdefkeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedu
    uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhinhhgoheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghp
    thhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnse
    hrvgguhhgrthdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlvghithgrohesuggvsghirghnrdhorhhg
X-ME-Proxy: <xmx:trt3aC-XoDp1xhCxauyk2NySqRTkV2dQDWr3jhdUouspB-AN-22P1w>
    <xmx:trt3aHHS2SeHH50lYGFNbSFBaP9bT0RPZX8ZhIYWDIa4XzYVYj58_A>
    <xmx:trt3aF5dqtsoUJFzJeYwdAeHop0Uy4MWrOwLHT6kgfyxrjh9h7IPNg>
    <xmx:trt3aIbLnnQeksUwexwRRgN3JFdK3pEvuH4uGbthzjzBN5LJWrMtwg>
    <xmx:trt3aLjd_VDAwuB7f-8RETnQDR8pYmftfLGXzZxvd4P5G47eGhp2GhOn>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 10:48:22 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: "Will Deacon" <will@kernel.org>,
	"Waiman Long" <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Breno Leitao <leitao@debian.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [GIT PULL] [PATCH 0/9] Locking changes for v6.17
Date: Wed, 16 Jul 2025 07:48:09 -0700
Message-Id: <20250716144818.47650-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ingo & Peter,

Please pull the lockdep changes for v6.17 into tip. One thing to notice
is that I would like to add Breno Leitao's workaround in
lockdep_unregister_key(), since the alternative requires hazptr and I'm
not near to get it done. I added comments explaining this and left a
TODO there, and I will replace it once the shazptr patch is in a good
shape. Peter, if you have any concern about it, either we can drop the
patch #9 or I can create another tag. Thanks!

The following changes since commit 7ff495e26a39f3e7a3d4058df59b5b6d6f943cab:

  local_lock: Move this_cpu_ptr() notation from internal to main header (2025-06-30 17:45:35 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git tags/lockdep-for-tip.2025.07.16

for you to fetch changes up to 7a3cedafccf8e7d038ad4cfec5b38052647ceac5:

  lockdep: Speed up lockdep_unregister_key() with expedited RCU synchronization (2025-07-14 21:57:29 -0700)

----------------------------------------------------------------
Locking changes for v6.17:

- General
  - Mark devm_mutex_init() as __must_check
  - Add #[must_use] to Lock::try_lock()
  - Remove OWNER_SPINNABLE in rwsem
  - Remove redundant #ifdefs in mutex
- Lockdep
  - Avoid returning struct in lock_stats()
  - Change `static const` into enum for LOCKF_*_IRQ_*
  - Temporarily use synchronize_rcu_expedited() in
    lockdep_unregister_key() to speed things up.

----------------------------------------------------------------

Regards,
Boqun

Arnd Bergmann (2):
      locking/lockdep: Avoid struct return in lock_stats()
      locking/lockdep: Change 'static const' variables to enum values

Breno Leitao (1):
      lockdep: Speed up lockdep_unregister_key() with expedited RCU synchronization

Jason Devers (1):
      rust: sync: Add #[must_use] to Lock::try_lock()

Jinliang Zheng (1):
      locking/rwsem: Use OWNER_NONSPINNABLE directly instead of OWNER_SPINNABLE

Ran Xiaokai (1):
      locking/mutex: Remove redundant #ifdefs

Thomas Weißschuh (3):
      spi: spi-nxp-fspi: Check return value of devm_mutex_init()
      leds: lp8860: Check return value of devm_mutex_init()
      locking/mutex: Mark devm_mutex_init() as __must_check

 drivers/leds/leds-lp8860.c         |  4 +++-
 drivers/spi/spi-nxp-fspi.c         |  4 +++-
 include/linux/lockdep_types.h      |  2 +-
 include/linux/mutex.h              | 11 +++++++----
 kernel/locking/lockdep.c           | 39 +++++++++++++++++++++-----------------
 kernel/locking/lockdep_internals.h | 18 ++++++++++--------
 kernel/locking/lockdep_proc.c      |  2 +-
 kernel/locking/mutex.c             |  4 ----
 kernel/locking/rwsem.c             |  4 +---
 rust/kernel/sync/lock.rs           |  2 ++
 10 files changed, 50 insertions(+), 40 deletions(-)
-- 
2.39.5 (Apple Git-154)


