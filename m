Return-Path: <linux-kernel+bounces-861948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD418BF41B1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1B18C34DBA9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 00:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083A13BBF2;
	Tue, 21 Oct 2025 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="MSs0/fur"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF717736
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761005339; cv=none; b=SXD9Zzw/UiGGoHESG85fQ4YBcCjmJlfcemwaU9+51WYxU9PiUv1v3i2G2zVaDbrJICxVB7aGqjgQnuVKPEF0mQRsjjF6GvOqg5yq4GMA8ZOPlZBl/QaOBsDvJpTwqUOYmfdjV1ubwvUb/XPY53TZ6AEcb3U9xPRZfTuZPFzxUkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761005339; c=relaxed/simple;
	bh=KJ1pfIvIDBKjZ6RN36ZBWQUth/hUxLDHaY5YAYkH5lk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=C98ttNHuzwLuSSSE95asCveOV27HWIyckoop0Vsr+io70+fct5ilVhBezArwoE6+x4T1gHYgerVb9RfaFQF9z5VUSqKmc7z8NsLqK+om4UT1HCJWCaWAmKrRwj/E4i0pEwtyB3W0PWRY6Lq0x2fLCf82iX2zeXMHpcJCsymbeuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=MSs0/fur; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-932bcc0bcf3so2476135241.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761005336; x=1761610136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fMeUvazcqYNdgA2hGT8nnzdOzY6TaJPwIdfsW5qe5JI=;
        b=MSs0/furUK7577VR2osMbpvrmfRWgTLR+4PDkAVAY9V1N7nBTljS5ZQwZ6LBCm7kVP
         N6M59PlTyr4BuuzcdxxkDMzxe/cXuIYOSY+tEThuBeIIPW8c2tvo8Sar1/I6EPaGIB/t
         oXbkOe3Uz+qYl5kPPmUPrTokbu/kVxVgbMbNoRtyBLv3FdSXDodhCK4RHuI0367TZIha
         Uywo0ruMjCH7/7ptMvFVXuE49D9ERTg2dtGk0+iQ6rV27u/0fJWNiFGdBFXGMY4t0lWa
         FrSoIxhBHY4wLzmyJ17Gr+29tBjWXUwD8dTCfkxOF1ALehOMdfdqTcCaEBMl+vC+eYeC
         ScrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761005336; x=1761610136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMeUvazcqYNdgA2hGT8nnzdOzY6TaJPwIdfsW5qe5JI=;
        b=GaBRPmUcBSf75VRj4GNktx+JDVf4BHv2ADd4FzKON+o5+TvQ4ir99bXboZOBThFsob
         9omdeTWnA1OXRhqxGc9o74Q6b1dqjAt6uxbNd8HUYgwE4wTkXA8+Yyvfp5zbgLTI5zxU
         fOcaDzYskZphXawu3q4wpfZF0af6xvYppPXFBlodhWFLnBUR47ViU3bgD21JWGR8tmsr
         PwmF37OKOIuANfOMMUHlX8Xllv41pMEP0gLmMsxsJLAUabbGjmS45ASXiExl4oD43p6e
         MMFKNLsrc0V+CkNhOlJiiQRsjnf4meS58I4dgtWlMURtCMxxVXG+rJD0IzFeY9NcJVZL
         uFtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD7gE3UNYesJZVMOCBNhk2wbk+sy356wUgJb+5O7gg6kGxGnj6dM+Bu+CHBSp9XgNHdaZQkdVshKm9R5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdSY0TKq3V/3wRF1OkHf/citikzIPMG0Py8swSXekRZex4dLAX
	+SpEnu79HuLCiRT/r3ea6V+RWVUN1u1BF9VMjYKl6HZqI2Qdb3s4Bpcf1mdoUINzDrc=
X-Gm-Gg: ASbGncvgPhxgeIFONEwawSN1cWot/+p9d8aNRfRhDANLKtX1nxRGBcP17/8QzZ8+rVk
	5PMGxeSwKOoNLvI0IjHPSXVSoR8+/qKP+AJMUDJNrv+9qwsx4klC1fCpI6VBB8c8TsiHRk+6DCj
	22jWbhiFScljPq8vmcmOhSvg4F5bF6JPoBRd/jzmaEffPHcpAPiMvQtR0AFB8aAiCZyUt3xmN2g
	TcTnQ40iJsT4Wwb2uQ5S7FI+0n05wNIFewtNxqCZ76FfsFQEd+2qalzkrXRzwdQZ3wO+AjY0oo+
	sCkg9hTLaYIO3oPZTTM/VE0HRiT1YUZjCBowIQGOcd8uy6IX0eA4vmq9ZuN34er1T/a5Ioadpr2
	zUydSOzjYnOIRG6U2NwlmB1NJJAfMnjCi7QFaGAbiaF6TJ9k1jFa6gSJchFXiyzjt3nU370ViO8
	FIya668qdThbQStBvkCGa/Uh6oFEs9GR8nv250MJ14p0cPoQkIkU1p8QlUrmUeu6H0q/0GazGo3
	S/RAil/7+Au9w2v3T66+dHfPw7lupxf
X-Google-Smtp-Source: AGHT+IHQnFwZNsQY3u2ASdTone7Vpn+Mv12WF26BhqGJWj8KVskl7uPN3iDlEwuykCnl85OEi5PdLw==
X-Received: by 2002:a05:6102:94f:b0:5a4:69bc:a9e with SMTP id ada2fe7eead31-5d7dd5b8b89mr5352453137.22.1761005336583;
        Mon, 20 Oct 2025 17:08:56 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55661f6e351sm2822882e0c.4.2025.10.20.17.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 17:08:55 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org,
	jasonmiu@google.com,
	dmatlack@google.com,
	skhawaja@google.com
Subject: [PATCH v3 0/3] KHO: kfence + KHO memory corruption fix
Date: Mon, 20 Oct 2025 20:08:49 -0400
Message-ID: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a memory corruption bug in KHO that occurs when KFENCE
is enabled.

The root cause is that KHO metadata, allocated via kzalloc(), can be
randomly serviced by kfence_alloc(). When a kernel boots via KHO, the
early memblock allocator is restricted to a "scratch area". This forces
the KFENCE pool to be allocated within this scratch area, creating a
conflict. If KHO metadata is subsequently placed in this pool, it gets
corrupted during the next kexec operation.

Patch 1/3 introduces a debug-only feature (CONFIG_KEXEC_HANDOVER_DEBUG)
that adds checks to detect and fail any operation that attempts to place
KHO metadata or preserved memory within the scratch area. This serves as
a validation and diagnostic tool to confirm the problem without
affecting production builds.

Patch 2/3 Increases bitmap to PAGE_SIZE, so buddy allocator can be used.

Patch 3/3 Provides the fix by modifying KHO to allocate its metadata
directly from the buddy allocator instead of slab. This bypasses the
KFENCE interception entirely.

Pasha Tatashin (3):
  liveupdate: kho: warn and fail on metadata or preserved memory in
    scratch area
  liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
  liveupdate: kho: allocate metadata directly from the buddy allocator

 include/linux/gfp.h              |  3 ++
 kernel/Kconfig.kexec             |  9 ++++
 kernel/Makefile                  |  1 +
 kernel/kexec_handover.c          | 72 ++++++++++++++++++++------------
 kernel/kexec_handover_debug.c    | 25 +++++++++++
 kernel/kexec_handover_internal.h | 16 +++++++
 6 files changed, 100 insertions(+), 26 deletions(-)
 create mode 100644 kernel/kexec_handover_debug.c
 create mode 100644 kernel/kexec_handover_internal.h


base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
-- 
2.51.0.869.ge66316f041-goog


