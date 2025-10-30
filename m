Return-Path: <linux-kernel+bounces-878384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C40C2072A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 221C84ED22F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC620243968;
	Thu, 30 Oct 2025 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LN66ibqT"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3201DEFF5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832795; cv=none; b=LYAjqVdOI4wVRYEqpwcV+b22GSiPlzQ91JsAc18T/bqUUEdP4HuctijMqg/guBo+Z5QQzETxvvXxNnhqOQCNfS8aKHQyCx/0zGw4gZZ5hrUbKhNEyYKp9iaUOfEkjO4vn3Fax6FfO55KJKyfdwZgE7WK5Dk26GJyxtdlUVeT/RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832795; c=relaxed/simple;
	bh=4yzhcm+IAIwlcKoFFaOdCRvdrmdbBqLmFatW4EsrfrE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=DHc4kzaJpIXs1XOhncaR3tc9H3ppIr/TtuhxRosdutMG5jXTMjkiE1NmFS/jxCSAHp0Hr+9l7Ya3MKBXUNhLouMqFTFCp4ZbV1z7ceTbGbHgvfNiW3i0nNUBsUbaHicLKUVq3AjNscrXr5YhxXVhFbFoexuGAQZZ6DHIx3ds7kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LN66ibqT; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-63c0edb0593so1335830a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761832792; x=1762437592; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vz3yCdXQoYeYgS1SXe/5GkRB+re/qkPaYZwzwgz2P7s=;
        b=LN66ibqT2hZzW6Ah8++lWUNkii5ou4Nz19+uit01xWKKbBuVbylw1qln/Ra3gaY3G0
         Tpk7LI38jMn5lDi5/MkO5Z0JfHUDthzEVsL99i3SjS4Gja+w1t3YH/iURB385u7XUX4v
         9xMXg81CuNOY86FvSxeK/35V0EjQBP6LN3rsOalBNXhq/hP7RH/rqhHs0OWF0p9zIs/L
         JGz+L3Fk4u+uvvT8e1NI49FZIBJ5DzFeGCgEPn2M+N00+ILKctVNzrum/WJC0jpq/EFS
         lrRcmCPlNcERgFCa4mYKLG840KqeZAhXXm4lNF5x1EKg6UXItxw+pEs6WdXNZMJeeTNm
         1u3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761832792; x=1762437592;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vz3yCdXQoYeYgS1SXe/5GkRB+re/qkPaYZwzwgz2P7s=;
        b=fzd3NFUCff6nPqAPyGDymqrKasQUr6pqjuMAylxD2h9NMcFnGbvzY+pnob41KT2dKD
         4uW62Q3CR5MJnsjj3jcYZXcXWI4ZlerUyNyBGb1wVevDuTvnXZE4IZ1jY+Zw5lsui2VW
         xp60KFTvOYcEMsumB5mJ26QeWsr0RfCPYaaMnIM55GrNr5Mw/t+PBK0OephP2ocGjhnu
         03e55VRHyBDREGAFj5+0ZvnnWMFnhhbB7GT2eTseOcrXPZcYSlFTJP74EEMDgaEWRaGv
         q9kLf8uH2CQYeViyuXyhe3Ee8J0vfzWrnYHfREduFMmqYW/kZb74HxUrNXEh0juT66QX
         mDzA==
X-Forwarded-Encrypted: i=1; AJvYcCVKZrduKJa2z8sT0ffs2eWB1QsnHsPxGqKecvJwjokSfUVUW/yPjgGgA6JhPpeU4ovjeUmEvnxJuPLbdXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YybXs3OAJrTMNyDxnW3QGj6v8CK+dm7Ji941qrFlGAN2msRA6t1
	UFk52YTSXksYqBdXnnmPWgfWt1eUKgeclm73AIfR0jgOnF8HxkaW6W66o01Yw4Pc54UYJpzVot9
	1jT+y8Gy0x4b3Rg==
X-Google-Smtp-Source: AGHT+IEHuuSkwZ8G4MedpjIlCXqYY2Av44ejdEgEEyzMrXgoO7Q6T81cPDTnhFGMs5h6ppfFyECQNWTd338NCA==
X-Received: from edt18.prod.google.com ([2002:a05:6402:4552:b0:640:68b4:68ff])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:430b:b0:63c:45fc:7dda with SMTP id 4fb4d7f45d1cf-64061a3f677mr2812913a12.20.1761832791722;
 Thu, 30 Oct 2025 06:59:51 -0700 (PDT)
Date: Thu, 30 Oct 2025 13:59:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFRvA2kC/x3MQQqAIBBA0avErBswS4quEi3SmWogNDQiCO+et
 HyL/19IHIUTjNULkW9JEnxBU1fg9sVvjELFoJU2jWoV2g7P6K4DKbiEGsmw7sja3gwEpTojr/L 8x2nO+QN+5xpUYQAAAA==
X-Change-Id: 20251030-b4-prctl-docs-2-d5e24dbb758d
X-Mailer: b4 0.14.2
Message-ID: <20251030-b4-prctl-docs-2-v1-1-396645cb8d61@google.com>
Subject: [PATCH] Documentation/x86: Fix PR_SET_SPECULATION_CTRL error codes
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
 Documentation/userspace-api/spec_ctrl.rst | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/userspace-api/spec_ctrl.rst
index ca89151fc0a8e7205e0a0062134d63b213b9ef11..806947a093e5e71cd23a6a1644db8654b870844a 100644
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
+EPERM   For PR_SPEC_STORE_BYPASS and PR_SPEC_INDIRECT_BRANCH: control of the
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


