Return-Path: <linux-kernel+bounces-785746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F151B35060
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F334F2426ED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FFB28A705;
	Tue, 26 Aug 2025 00:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="37DUwTTI"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8915B26AA93
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168820; cv=none; b=HQL2/O0yAQeL3cbKcbQzCrbpOxEOk3oN/stvKDZelUhqWMZVBJinKml355t9gaKl5OSS+mdTcBpmqIq3EGh0Lz7xqU1zxVQ65EOiZd0WDsckcCgT6yM/V/TGMb8p3HhXA3l/l32eD6ny3vIo6xtu6TJcEyEYxKamsfqJnk0vN7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168820; c=relaxed/simple;
	bh=GVb0pAXSPXdxX83+/OPqswXLmkkoza3EcxtQURZXTX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KKRQ1kG0OfvfIcIPPrD8OWlDigSZ5Vg/Dnolw5kVQ9aUC6iDyBnM7Xqeyivi1uj1CyFpJ/34vLqiB0v+r1DIHY4P9sOXVefyQtQMcaj9A2dWle5je13t0RPWYFun8IYQAiuVkLXlCkz+FggqJu/ZyhnzBV/djoh/td6nX/mMquY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=37DUwTTI; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47174c65b0so8634790a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756168818; x=1756773618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5V06R2YwV4P7mb6bnA7O8amlLNlaQTPU7YQZptgAyaw=;
        b=37DUwTTIplSHyjXb5oD9D5j+/h/odBr8rm+d0svmhcWkBZu/Mxvy3mSTNMuganlGrX
         +vwpRrwReIFOv1jSXAywZTNFgfSe1vwtnr7bChqI8e2en3jLvsDjn26gi/UBLwC+Ykw8
         NTIfnoXN+HRIswB89Fzehs+zFGpb+8q+QH+WqQ7VDjgTWJIFOlo5BpHzJCAmtb21ZnvV
         HZXRbmYpDq5xsM/BEszskuX18Jtn5hP7XNtVpFSQ2WrvtqYWOdccvV6IAIcsFLwo7zq6
         4w6DOsuHOh4+qrpBTqWHjJN3POWDNrSy0+1yhK7e5UPrhM+eaZgIdxQ0WohVOV7+ihva
         7wLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756168818; x=1756773618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5V06R2YwV4P7mb6bnA7O8amlLNlaQTPU7YQZptgAyaw=;
        b=J01Tv1aCmGd75KgZYoG30eq3noQh0HaGxB6uYweOMq7TyK7C8WmWBtRfR0rhznsGj7
         GJN6aIDP3ict6W+FQ1w/Ex8eFpvPfOBO+oesWvP6j4viskODux3p0hgtQb0uhqdHigty
         uCs/EAingMtO8r8yK8HDjRjgyElzXBHTHgZ2OqO8LOQ2PGe6I1p2Nf61tG0jii9yqxSX
         5izIxV/O0KubTxIbYRXezXsmJclv+iyLtS85UMNxN1oQjxjiz5MXrluA9TjEXf0mPwf/
         b8oPMl5F4L4M5GBkphKVcBSBGt/CIm22g4UY7tXUEjLz7nP639bKu9es/pdiv5GWOEiG
         IWxw==
X-Forwarded-Encrypted: i=1; AJvYcCXLeUGBgLMYuNLfTttKNeHhkXmRM0GHPRZ/31zbdxhFpPCEM1TavZNvAvD12jeZeDtbpgkWzYzwk67FNsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVEELvP8jBB6iXMXkgoCP+mLrHWC7bPgMqLr+0Zuhg39l/R4Sw
	Tw4NqpOnBQL5oIHqRpeoSW937OQOlg2ge6LW/ugI8q0SN9eLnObe350BNYOijYmyP6AwZ39n4yg
	G2FjGZw==
X-Google-Smtp-Source: AGHT+IGvMwOaGiGqZx7k3m6cvaP4kpjaZdVQ4IKIUIbPn0jyCNEVmHY+8BVB6L/MWU98cgfspsjTfnfKiu8=
X-Received: from pfoo6.prod.google.com ([2002:a05:6a00:1a06:b0:770:5229:752e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3282:b0:235:6e1:7017
 with SMTP id adf61e73a8af0-24340ab113bmr16959785637.4.1756168817903; Mon, 25
 Aug 2025 17:40:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 25 Aug 2025 17:40:10 -0700
In-Reply-To: <20250826004012.3835150-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826004012.3835150-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826004012.3835150-3-seanjc@google.com>
Subject: [PATCH 2/3] vhost_task: Allow caller to omit handle_sigkill() callback
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Now that vhost_task provides an API to safely wake a task without relying
on the caller to react to signalas, make handle_sigkill() optional and
WARN if the "unsafe" vhost_task_wake() is used without hooking sigkill.
Requiring the user to react to sigkill adds no meaningful value, e.g. it
didn't help KVM do anything useful, and adding a sanity check in
vhost_task_wake() gives developers a hint as to what needs to be done in
response to sigkill.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/vhost_task.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 5aa8ddf88d01..e0ec6bfe61e6 100644
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
@@ -81,6 +82,13 @@ static void __vhost_task_wake(struct vhost_task *vtsk)
  */
 void vhost_task_wake(struct vhost_task *vtsk)
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
2.51.0.261.g7ce5a0a67e-goog


