Return-Path: <linux-kernel+bounces-785744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF778B35059
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6A73B9C70
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ADB264A8D;
	Tue, 26 Aug 2025 00:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnA9yR0o"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D23D2566E2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168816; cv=none; b=PUzCXNrdDGUPzasUuO7QQYnGcUTMkItbjg3gXCdzCvGOhiyKk3p95fSOmzvo5GgxRRBatJk8XZW5WMNXvdCvOiTLmkJLAkYXAt0RLfkTLLlKfMrGryfD7OZ2DHuRzQmV/iKfUa7sfr9BNOMDukHhqTTYyaqgXVJWSjolCo2uomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168816; c=relaxed/simple;
	bh=OGApnXhecwv65yclankWf5l5OEJW6iLLstfxLiQxT78=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hkdr+JdWlRN513fc4mf7N/188AL9qO0lEtzqAHnznksaHN+ciKbViEhlj52Te7jFYbxOUtYgzfB9qOXhmLt8lXN0hF360vqh4Zxm3GDSoOGYKjgYgGRzgK0KwC6dIy86jRpjHu70k3GgPhBBJIyZTRKFB7t27XFJMObpDC3cJ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnA9yR0o; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323766e64d5so5234799a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756168814; x=1756773614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGFfEAOpmCnYuTpD1Fkefs/dVeGZ0wTmpw3Bli3LbeI=;
        b=wnA9yR0o3Zao4cmij5KpH31jEUNmW3Z3vb6s1D/e57RQBf6J7qhRVeiYZtgRhrmBJX
         ptg07/T3KbOGlTbbSZttzE6qmKX6BRZGjwwV+my+bWtdSAnQQv8SofFczHW+u3MgYNEZ
         bul7mDBV1lkjM4wSTHFlJUjzFIGvoqDcjc38v6cnoH319TrzIAfeZ8oN7XmwpNwFcqZO
         Z5/Oa8S9cbAFJSMR9ByE+yjtBjUqnBBOVisGUzDbG0zgZLxXHu4HwfGxiWfUwQMEUyhF
         LOOXmrNH9/RK1eOGY8y5xBSbwl2RS8wypLV2EEj+EZvwslg0oIVNGQfv58zGR8JHPGTR
         FZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756168814; x=1756773614;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGFfEAOpmCnYuTpD1Fkefs/dVeGZ0wTmpw3Bli3LbeI=;
        b=Q7097fXS/SkPT/ohFwVNqq1HKuxkA7dEKVq5g3ywyzAJnJPxv/HSmsOD/FCYJ8Cfrt
         ZPKcziWwI0utnJM+ypbQ/Jam0fk5fWbDpwLM9drO0nh1Fmn9zdkQh5/gDYhjSdTUe3FP
         p+q7Jf6oP28HN4cTI5CoaUux6txH9JQMQdt0EEQ2v8fheWjsengsrEJA8qUW3WZJvMbj
         umwjCDDZ8pSJd6QTsIeKWQmhTELlw0Mlp8giN9wzFJTNSRQuBtW+xlpI7Enxit9tjsNJ
         b7gBT9DOnhYXH5njYhnR/2gMiskAxdHfeRAwsI1MOH6r2rls9+ozNgERp+0/a1VUKhfF
         0OnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmCzMKWPaGD6GpH8YpCT8YzBeLo3eX3F/FkePR8OinqVBl0JWjAheg+BMCo5iTIWjmnbThK4bj1nx4b+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp6/vUWIdYMe+Z32Jm2LpIwDMEcOa2t4IrEGzKG8euup/Od0Y3
	EBk+cLwiUZDiISbrpxZL7CXhY6qODS75DqzBYhAMeezhcmQopr6Kl3t+AsNSn+lpd9NcQxjd8wp
	lO6mDiw==
X-Google-Smtp-Source: AGHT+IHK1NCtVV/uARgx2pzXRzDVXR83QkBAFqL6vl11EOqC5SFFLlVBCFYJmnq5S7TIzbHzRbowBd1bBwU=
X-Received: from pjbqc3.prod.google.com ([2002:a17:90b:2883:b0:312:dbc:f731])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2811:b0:323:7df8:6eec
 with SMTP id 98e67ed59e1d1-3274620a008mr515983a91.18.1756168814547; Mon, 25
 Aug 2025 17:40:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 25 Aug 2025 17:40:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826004012.3835150-1-seanjc@google.com>
Subject: [PATCH 0/3] vhost_task: KVM: Fix a race where KVM wakes an exited task
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Fix a bug where KVM attempts to wake a vhost task that has already exited in
response to a fatal signal, and tack on a few cleanups to harden against
introducing similar bugs in the future.

Somehow, this only started causing problems when commit 56180dd20c19 ("futex:
Use RCU-based per-CPU reference counting instead of rcuref_t") landed.  I have
no idea why the futex changes exposed the bug, and I don't care all that much,
as this is firmly a KVM bug.

Sean Christopherson (3):
  vhost_task: KVM: Don't wake KVM x86's recovery thread if vhost task
    was killed
  vhost_task: Allow caller to omit handle_sigkill() callback
  KVM: x86/mmu: Don't register a sigkill callback for NX hugepage
    recovery tasks

 arch/x86/kvm/mmu/mmu.c           |  9 ++----
 include/linux/sched/vhost_task.h |  1 +
 kernel/vhost_task.c              | 52 +++++++++++++++++++++++++++++---
 3 files changed, 51 insertions(+), 11 deletions(-)


base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
-- 
2.51.0.261.g7ce5a0a67e-goog


