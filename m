Return-Path: <linux-kernel+bounces-809778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7C6B511F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA9A4E728A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF20311955;
	Wed, 10 Sep 2025 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afQaowMl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDBC30FF1E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494749; cv=none; b=cSfDA21zsdIYfsDoKDIb4AJ3E3+wJ2ZraI5FlX1FjV3TNOqYg51gBdN8kkz6+9EgsOU/W0pyIYXSASCAkdvPHb1sLlQVUCyYKmIVV1+aYAJrzYyomOhexLef2NF7Tb9scBvZvXsPq7zraa15abhNf04V1vvOVqmtYaKgYFepX1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494749; c=relaxed/simple;
	bh=qVUqCiNWKhbm4OJQ/h1GXQ4Ue76QXxYJE1ZLypTGFuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dOYVynL8dHKImAnjqHRmPH4iGQMwiPWiihYLPan3ies/sO27veN12HTM00at7pc5CtYjhG4UGw6XLroegRQ5pzqUxNoCAgP9npGe784zSJSmKpE18M9t29NlwAlEjyHGVvlQqdyN2MuhUz4vEX9Ls8qd+Rtd44cmpLGzapjCg/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=afQaowMl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757494746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YbNpi+kDNBgUr3iCBEGx1sOECaER/m1rAGG176HSF7M=;
	b=afQaowMlmDKa+8hwsvCxbW/l1CayX5e6O5132b7I/WR+jHjgW3+2+IzN2xnbtF1PQ1PbRW
	Xgn19CmJzbLxA/f25PjnLerBNtOYprKDrlabQxIbqzWG7a93BBz6lFeQ1hdIuBE/Im6ubq
	LC3ewXyYqU4mpJSih8mK3LEs+GS+iOs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-EeJIAGGPOXem8qRsnBYdWQ-1; Wed, 10 Sep 2025 04:59:05 -0400
X-MC-Unique: EeJIAGGPOXem8qRsnBYdWQ-1
X-Mimecast-MFC-AGG-ID: EeJIAGGPOXem8qRsnBYdWQ_1757494742
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-62caf055c95so1374866a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757494742; x=1758099542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YbNpi+kDNBgUr3iCBEGx1sOECaER/m1rAGG176HSF7M=;
        b=OiPs3RmM3wzvwlebBVjn29f19ifJqCpuRcV5t9IjLdrmRep0Boj8waZTRrXxMUiGiZ
         vTwJ8YEpAqM0TKnL1c0egnXNqDqZiorbL0TaMEHQvLzGa40ZhmJ5vAM0ZJZxrI5O+lCB
         wVs6m6gemq+krO8X+JfQ9tQNSoUyiLY0MjWs3bEY9QYh1ftaYOywk8iYhTiJ5TZZq7S2
         KIRO9RETRtD6JSRpmkGf0Jfe8G3B2sFhibvojmelkqduTPaxH2ykR/9gZfaDbLOBverK
         TpYejJWvxh673JaBynSENaUv2rdTl/aPbcNprQFLcmkBxgsjrrcy1LXgFNEuYd9iFkCK
         Ej/w==
X-Forwarded-Encrypted: i=1; AJvYcCU/V9J2d+qQ/Q5wzT7OVpMW9sLH8qQ3yqcy+bvP3k3dQg/ZkhCtl+I5/R/b+nyyaPUQCepuUi/qk0gxAcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9g8RCibuAWi0EQvlD5Ro3oEHJcQCNBpo1ewYOMpJBtcAELDr5
	IA8YenPYlvZilpx0p9Ivz6RIR9a7ipXP6xk6wKYeZQlnCQVB+C8O8Mzr+MzkbfKkvjhh1E+sx1X
	v+LqDyHLHAd8/R/LgJBWBZ/pAqmYgao1ltVIcd6GSGydSoWcMzuGkoE+z1IhcrVanyw==
X-Gm-Gg: ASbGnctcrryElDUjcKZbfwCovjEVhL8vxIz6SY61ZC5gYPUJvwL9mZDik5e4JZ3bSZd
	KyGo+p6jhchUd3FC6LaZJiZNk0uwQtiFU5rQ37rIXq1Y9g4xt5GNmL91fLo+T9PUErZy7zHzkqp
	GnVkdxrDQft6TNvRL8ysxhoKNs5tFuWxbdav1UksL/n2299pzHXbmcHpS7JyVR1hIk6Z3UDVjky
	7r3JSedWGOa7PWDUmRHtDehn1lXKHNjpeot3PyXqE/kI+VSeDmn4av9FRq7qfxhlZ/dSw0vR0Ld
	tCgZMVPHraG2vDwrYOF2GQ+8QcMaGxfFNAwl43j8Ksy8JBrFD7Q7pzAuWe9aoNOMRRCQ5mj10Xr
	ERk4er2Ko7of2lQ==
X-Received: by 2002:a05:6402:1d4c:b0:62c:710d:5600 with SMTP id 4fb4d7f45d1cf-62c710d58b3mr3918125a12.5.1757494742444;
        Wed, 10 Sep 2025 01:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIhjF/hQzrKDBiBG++LNsoFWIGNfnxMPAxlcabo5++O/vC/iz8XosvW+jycdz3EyQro8e4TQ==
X-Received: by 2002:a05:6402:1d4c:b0:62c:710d:5600 with SMTP id 4fb4d7f45d1cf-62c710d58b3mr3918105a12.5.1757494741975;
        Wed, 10 Sep 2025 01:59:01 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c0123f35esm2792862a12.32.2025.09.10.01.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:59:01 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] Documentation: update config name in real-time architecture support
Date: Wed, 10 Sep 2025 10:58:59 +0200
Message-ID: <20250910085859.47818-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 14ec35ff5786 ("entry: Rename "kvm" entry code assets to "virt" to
genericize APIs") renames the config KVM_XFER_TO_GUEST_WORK to
VIRT_XFER_TO_GUEST_WORK. In a concurrent development work with commit
f51fe3b7e48c ("Documentation: Add real-time to core-api"), the
documentation on making an architecture support PREEMPT_RT has been
included referring to this config with its previous name.

Adjust the documentation to the current situation, and specifically
refer to the new name of the config.

Fixes: f51fe3b7e48c ("Documentation: Add real-time to core-api")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 Documentation/core-api/real-time/architecture-porting.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/real-time/architecture-porting.rst b/Documentation/core-api/real-time/architecture-porting.rst
index d822fac29922..3062cff0e5a3 100644
--- a/Documentation/core-api/real-time/architecture-porting.rst
+++ b/Documentation/core-api/real-time/architecture-porting.rst
@@ -35,9 +35,10 @@ POSIX CPU timers and KVM
   POSIX CPU timers must expire from thread context rather than directly within
   the timer interrupt. This behavior is enabled by setting the configuration
   option CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK.
-  When KVM is enabled, CONFIG_KVM_XFER_TO_GUEST_WORK must also be set to ensure
-  that any pending work, such as POSIX timer expiration, is handled before
-  transitioning into guest mode.
+  When virtualization support, such as KVM, is enabled,
+  CONFIG_VIRT_XFER_TO_GUEST_WORK must also be set to ensure that any pending
+  work, such as POSIX timer expiration, is handled before transitioning into
+  guest mode.
 
 Hard-IRQ and Soft-IRQ stacks
   Soft interrupts are handled in the thread context in which they are raised. If
-- 
2.51.0


