Return-Path: <linux-kernel+bounces-788796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCDBB38A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D132B7B91A7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630832F3C29;
	Wed, 27 Aug 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sY4w8gJu"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323532F0C56
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323680; cv=none; b=STYr1fwum1l5xwnS9O1VeO766vki3frDMv/OrbxGhvUED5VOSuoX4TIVx/laoGB8jxcurfTigWKxWU9CPcP2a+I3gZPmGyp+IJaWYPjPiaN54Uc7YjukVhanVvZzRRy4cQWFpbwIU7MRbhWAI+EiRhnPex2Fyg9AwOLCJyboIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323680; c=relaxed/simple;
	bh=lOFYn5tzMu+BIyj/3iv2zb29eZrNyF3mgyqQKezrkec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rKDS0b8BbAyzuaS+4ID7DeNTpMZeXX0EhWAngVPhBfiN4/n0O/q8EHO5TGCQJRrrkDyMQI2QGWRzhge7tqg7Pk0RG0SCybr3CPh7vn4c6sFSJOsA79jM+yLcO135zmnzo64gGeOyrpWimGQycchx/8cNueJRN1mwgYJqRhB9Pf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sY4w8gJu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-327704c12c2so207570a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756323677; x=1756928477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BKdkhp8v27Li0GOsmRqKq40Y7Pxs7HR00OYnU2c0jjU=;
        b=sY4w8gJuo5Y59YmV/4QW4Ysfi/2U5cRw/Tp47qbJ363iDCQL+0V9+M0nQ8bsoFFUs3
         iV/ZZDLPT+gh1gwQ2aX2WG2J+Fij2Wc92+fBNfjRlc9KiwEM5RiZLk1YKXfmyE26hAHs
         3hGACwOWDPuUqX2VlNsVorZkl2xEd4sFKDd0H8mSdeLWBdj/E00IrpjKnWorxdHAXlUZ
         +oarvHpOTBwrL9iqg+AiHwNyvXBM8L/tPyFJbJvnxzpUZU+6HoTW4z9wIUBX873TrejZ
         1A1yceiJtm3SY7pfM8caoX2FxEn86WjHGnOwsYOAO590cQuDqXWLarDH0x0+jHiiGTmk
         l+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756323677; x=1756928477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKdkhp8v27Li0GOsmRqKq40Y7Pxs7HR00OYnU2c0jjU=;
        b=APppXwZBrvQtW0V2pL0wMLwl1/CbTku5lWj4fF9pmg+w8r2OIeMA24uxD0FVd08flp
         jf3HUAKONXKLMSIQU3+xfrTqJ6OYqYzfP4Ni230KApox/qZRbWhDEB/b2K3CrwQtk5Z3
         2+7mQxj6Mzau7SxJXyMRHUqMlUs0V2FULuCaZLqAzRT/4IJq9do1NcXAtMIsQjcFWlO4
         KqrZp2BRSEUccuFWF0da9tCzn668ZHyUY9G9uNoSa/J39NyNtKeeM0NLitBzknQO8Tj+
         FwzR4BsBtr1q7C6tYQn2/miP85ZYnxpRRMrU2Mtt6JltD1812ZtfY1Q9qZjo9ChxPphN
         Pwlw==
X-Forwarded-Encrypted: i=1; AJvYcCUNzY90Uo1lGouu8taCYEqWGSQyR4ywDZDGoCofEJk4WCroABekOecUYFP/thKVuDPVqEKaPrasn1pSLjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YziYafER4i2eh0/VLotGFcEaQheOoLx1B49mQWMaJ8CYtIXtPp3
	pihksIirdsdRlLws9ErLjbFFMi/HvWO+KzViBJmOB8UTpJWReoHdFO7/I5MooKaZw1ivfhLvPzC
	Ix4aPhg==
X-Google-Smtp-Source: AGHT+IFkp3cSkHK/LCzu7rsgKn502PeqGnc81s3u1mjxkvPKl0aSkQfYxtfmuXztKttrbNAZ69OCb7JCKaU=
X-Received: from pjbqd16.prod.google.com ([2002:a17:90b:3cd0:b0:31c:160d:e3be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d4f:b0:324:eb2d:7537
 with SMTP id 98e67ed59e1d1-32515ea1b2dmr27081009a91.20.1756323677599; Wed, 27
 Aug 2025 12:41:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Aug 2025 12:41:06 -0700
In-Reply-To: <20250827194107.4142164-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250827194107.4142164-3-seanjc@google.com>
Subject: [PATCH v2 2/3] vhost_task: Allow caller to omit handle_sigkill() callback
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Now that vhost_task provides an API to safely wake a task without relying
on the caller to react to signals, make handle_sigkill() optional and
WARN if the "unsafe" __vhost_task_wake() is used without hooking sigkill.
Requiring the user to react to sigkill adds no meaningful value, e.g. it
didn't help KVM do the right thing with respect to signals, and adding a
sanity check in __vhost_task_wake() gives developers a hint as to what
needs to be done in response to sigkill.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/vhost_task.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index bd213d0b6da3..01bf7b0e2c5b 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -59,7 +59,8 @@ static int vhost_task_fn(void *data)
 	 */
 	if (!test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
 		set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
-		vtsk->handle_sigkill(vtsk->data);
+		if (vtsk->handle_sigkill)
+			vtsk->handle_sigkill(vtsk->data);
 	}
 	mutex_unlock(&vtsk->exit_mutex);
 	complete(&vtsk->exited);
@@ -81,6 +82,13 @@ static void vhost_task_wake_up_process(struct vhost_task *vtsk)
  */
 void __vhost_task_wake(struct vhost_task *vtsk)
 {
+	/*
+	 * Waking the task without taking exit_mutex is safe if and only if the
+	 * implementation hooks sigkill, as that's the only way the caller can
+	 * know if the task has exited prematurely due to a signal.
+	 */
+	WARN_ON_ONCE(!vtsk->handle_sigkill);
+
 	/*
 	 * Checking VHOST_TASK_FLAGS_KILLED can race with signal delivery, but
 	 * a race can only result in false negatives and this is just a sanity
-- 
2.51.0.268.g9569e192d0-goog


