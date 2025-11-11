Return-Path: <linux-kernel+bounces-895930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 276EEC4F4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C3C04E8DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E313A1D11;
	Tue, 11 Nov 2025 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlWa82Zh"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA81D3A1D05
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882876; cv=none; b=HLSBOkE7LXvD9bIrUCuBAc1SZSW2tHwOmL/8GKZ71ONazZN6ZPLEBiAF/9ntTWJHISnESf8PuGF70bch6h0BkayhTu8Cv9sIf2tv1NLCDLlNxl7+cbMlSPehki2yTH3F9Drby2yTNP6hPRAFvDjacOB2UOq23Wdh5SHckMQnci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882876; c=relaxed/simple;
	bh=EGHnGYguqdVtqzE8OSgSk5NT8BRurVLNOwx4JFd9SIc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=kL+nlBKW+BLuQ9oo25KhK6E3T0oQUFb1hCvfqsjXnRbvYo0bjzYqMFf7N+Gphp3JHsMKoeWgz31QtegdpEo7sVtVdvFSWJoCDofZgzaAhw7jTKxMd+Z6Mw2uolBCT7yjGbdSurCpoxegfksuG+0YKeFQoSQANT0wJQ4yTHtKwy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UlWa82Zh; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b6d40007ea1so1556166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762882873; x=1763487673; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Pkn+9vIwNogTuxuW5MtMEzbQcXSFW7NMBZUwaPgd58=;
        b=UlWa82ZhMYnQnKsmmWLxnZCBfqx1zZnr+BIMcIIqWtbMj9KuAvFT5Q89+xm+pZswky
         cuFQOKwEmH9Eh9Crk0XyO0KUmaV+e3spyKsvBdzUXxws0PthZdAt4MgJ4t5UVOVv+ZpE
         hQ399H1vVyw2/NMMi3xn5iahXO8pmVC/7vJgNusnqUKcOxLM1zlYCz8+hTN9kWkbBV45
         0U7anPFUWbCIzY5+cyG4b+JDspQJNLQ5jXTQqA1ls52RCkorVcAzdZnF31sQrDbtwwZc
         hy9RB2sQCDkgqD5Aaymdv89AFHb8pOhPrtUSKDwYRuCuXDnMLFHP3qbm4wuLODWbfB6G
         5sIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882873; x=1763487673;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Pkn+9vIwNogTuxuW5MtMEzbQcXSFW7NMBZUwaPgd58=;
        b=n5E0Eza2HRTDbR4wLzfzqlI3raIIYQCA3kGLy8MZstNpfE4LvgNaPzR0b/l3MJFXO8
         04hN3vtBRXPTX2NsVXk0aTdRJziiVQBVjFlggKuCpPGXF/VfmQ/ou62RUnc4j+W+KyXT
         iQhcUVFKdJCa05pl5PfnEV6vbyrAEryQeA7qJ5GKNOynkppC2+l4QGvzgSHUGX8naEP0
         LzDc5qD+V7vbmWhCa/4oK/bgThinq+Byv+iXw0962cd1OFxaQeUAXsi/1GHvqlgfDplV
         A4CsBkzbgL35NvwtOJvjPY2u/bZtk+IAeISgzFP1DRxgFXzQPlRmzeDA5cf0Inbs6mM6
         YfsA==
X-Forwarded-Encrypted: i=1; AJvYcCULXtZyJqlBSBUDYcZs6moCHTefPsZg6BVvBHaEtGMVAV37/ZsTYq9m94rf9oYxg/5gEBBnAtD4jxJUpZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ0APoLgWG3/Glrqz2tHujU9ElJAoxQbBWXPjORYmyk4Aon6d3
	8ve1Q8fIdk0Kgh/cnQsiR/lO/X1uVUVmrjgvXvcy/6tLP6iUxMYnVkPQIS7ia4KQzz00Azd3RI8
	1b5eTFilmcnjzYA==
X-Google-Smtp-Source: AGHT+IGFy0ukWziLWlhSBOsirOsL+DYT2dzywPbi9FrmXHCzpCDVHG57JmnIvw6h4MX59871sbWi4EI0TM15Aw==
X-Received: from ejbo8.prod.google.com ([2002:a17:906:3588:b0:b70:b190:7f2f])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:a0c8:b0:b3f:9b9c:d49e with SMTP id a640c23a62f3a-b72e053f2b5mr1344154766b.57.1762882872997;
 Tue, 11 Nov 2025 09:41:12 -0800 (PST)
Date: Tue, 11 Nov 2025 17:41:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADN1E2kC/3WNwQ7CIBAFf6XZs2uAAtae/A/Tg8BKSWppoGk0D
 f8u9u5xJnnzdsiUAmXomx0SbSGHOFcQpwbs+Jg9YXCVQTChOGsZGolLsuuELtqMAp0iIZ0xF9U 5qKsl0TO8j+J9qDyGvMb0OQ42/rP/WxtHju1Va6ms6ZzmNx+jn+hs4wuGUsoX8rI/rK8AAAA=
X-Change-Id: 20251030-b4-prctl-docs-2-d5e24dbb758d
X-Mailer: b4 0.14.2
Message-ID: <20251111-b4-prctl-docs-2-v2-1-bc9d14ec9662@google.com>
Subject: [PATCH v2] Documentation/x86: Fix PR_SET_SPECULATION_CTRL error codes
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Jackman <jackmanb@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Balbir Singh <sblbir@amazon.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

If you force-disable mitigations on the kcmdline, for SPEC_STORE_BYPASS
this ends up with the prctl returning -ENXIO, but contrary to the
current docs for the other controls it returns -EPERM. Fix that.

Note that this return value should probably be considered a bug. But,
making the behaviour consistent with the current docs seems more likely
to break existing users than help anyone out in practice, so just "fix"
it by specifying it as correct.

Since this is getting more wordy and confusing, also be more explicit
about "control is not possible" be mentioning the boot configuration, to
better distinguish this case conceptually from the FORCE_DISABLE failure
mode.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Changes in v2:
- Fixed erroneous reference to PR_SPEC_STORE_BYPASS returning -EPERM.
- Link to v1: https://lore.kernel.org/r/20251030-b4-prctl-docs-2-v1-1-396645cb8d61@google.com
---
 Documentation/userspace-api/spec_ctrl.rst | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/userspace-api/spec_ctrl.rst
index ca89151fc0a8e7205e0a0062134d63b213b9ef11..61fe020b23a2ca632879597bd47a321bdedd9faf 100644
--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
@@ -81,11 +81,15 @@ Value   Meaning
 ERANGE  arg3 is incorrect, i.e. it's neither PR_SPEC_ENABLE nor
         PR_SPEC_DISABLE nor PR_SPEC_FORCE_DISABLE.
 
-ENXIO   Control of the selected speculation misfeature is not possible.
-        See PR_GET_SPECULATION_CTRL.
+ENXIO   For PR_SPEC_STORE_BYPASS: control of the selected speculation misfeature
+        is not possible via prctl, because of the system's boot configuration.
+
+EPERM   Speculation was disabled with PR_SPEC_FORCE_DISABLE and caller tried to
+        enable it again.
+
+EPERM   For PR_SPEC_L1D_FLUSH and PR_SPEC_INDIRECT_BRANCH: control of the
+        mitigation is not possible because of the system's boot configuration.
 
-EPERM   Speculation was disabled with PR_SPEC_FORCE_DISABLE and caller
-        tried to enable it again.
 ======= =================================================================
 
 Speculation misfeature controls

---
base-commit: 131f3d9446a6075192cdd91f197989d98302faa6
change-id: 20251030-b4-prctl-docs-2-d5e24dbb758d

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


