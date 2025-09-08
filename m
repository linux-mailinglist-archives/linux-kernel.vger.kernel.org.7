Return-Path: <linux-kernel+bounces-805689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E656CB48C54
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22973B68FE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE8A2EC55F;
	Mon,  8 Sep 2025 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVLuMqej"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE759281375
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331447; cv=none; b=E+pwc7uIwOMC/HXwmAuAkX7+0OIHcjaNWHfdM0Us6wtsqZXzp+xotupOMwlKdrhFbk6IXhwJ5aWJOG1HyGw6fv/SHh5jXsTiyIw9oR7jKYyWY6L11gbBL+IpfCrhKAwZ0crgzxnH9QCzZPRmURbxo3QywvyuDmnyJjhnosaf0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331447; c=relaxed/simple;
	bh=Z0lQ6NnUvMGncmPaQWFx/tsnc+zIIpvP5hzKvREAakk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R6Qd35Xch/wh117CGUQUhR/gmeePV3d6AkW4FjSdJrqavV7Y8/9J/bkaG7bE1iPsikZeA4OyZCo0KWUzx+Ir89wFWkoV80Hno8VNvCX8k8um0tVijNvabpvyFIzSuK5vbU6QIFCQJ3kQi07veoW7ep8R9EVrRWfVFnBPPVk/gU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fVLuMqej; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4c72281674so3269789a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 04:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757331445; x=1757936245; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qTe8Cug9ZkN6A0v6ou02v4J9C6gYARogp0/zKK1tnj8=;
        b=fVLuMqejlJUAynd/SIjV3KV4LGQct8xTUUs9lpB4Q5QPX4vFzLJ2tN9/7F9PbyHa2l
         rBDDD1q0ZzMaE2/KrQomxEw/81se7WdfeZP8zC6KjHQZmj3gtnnyP2EQVfTfcxoL3sSr
         cJK1Z5QYG2mnZS25nnPXqNcoQYr6jFbkVQ/ck0/5wDdeR92c3/xo0P48K8t/Gbuibz+7
         GYZFXtNZeNdNCbODVmhqi7eKEezV34geffAmdipJ5S6LCI0eFj/dtVILhqBtEjS1pOk4
         fLgr5hdwZYvo15Uuu+HgtP2cPry94U1xaHddwrH0AGnfN6vVw2TWFz2G/MjxlTHlWSwe
         jOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757331445; x=1757936245;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qTe8Cug9ZkN6A0v6ou02v4J9C6gYARogp0/zKK1tnj8=;
        b=YIjMG3rcFTI1p2CR5fjcq+Zz1Lk3O39br/NNcMdldMNDC4sgx6N5w+ziwTFx/NH0mh
         KZmFYoSB3OAQQjNm3WHA+kuDHLYShFzugZ7FNyGR0pnRkk+pFqPwakxCv0XSUmOig6c5
         Q8lvWDbWRfYVGnHpEQhHebR1QfDHySJEI9XRb8063djepBpfo2d0ZD0VlYJrT+riYIoj
         SXXbG9pLEUaIqosnMxMbe70O4n/LPGalLsPjmN/YMzmB3LF5mXxPqcUJZG+2hTXBBOEa
         DtCoSoXwM3/8pTy/nIh0kzXaXpYfSjyXhujBzjrwi/uRtQvYab1ovVGYLJFlnIgTy3an
         W3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVBfU/Oz8K0JLsBM2UEXWenpBF9548/2YdQN1qQ8PlU0fRnrXvWu8P8roCR/Jmbs1Y4Q2kaEkPUuCO7tRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwptHuTq9NlfJJpYvqgE9me0tfc/fCTKFQTgjWAitEYkVy0cqJx
	5GnFiKfBq0l9SrTe+6uq/EGmdDzflEX3fe80zTZ57ECaqWMt0jYWDJwTuUf0CVpKPa5ouPem3q+
	9PA==
X-Google-Smtp-Source: AGHT+IGBKCGzB6MxHOjzvaLePBq6tlh3PsUacYIKdu3RehAtLyoXe31cr6aD+Kx7YqouHT+NJ8dqf/a6sA==
X-Received: from pjbsi6.prod.google.com ([2002:a17:90b:5286:b0:327:e172:e96])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:68e:b0:252:9bf:ad7f
 with SMTP id adf61e73a8af0-25344130937mr10349305637.53.1757331445092; Mon, 08
 Sep 2025 04:37:25 -0700 (PDT)
Date: Mon,  8 Sep 2025 19:37:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250908113721.4031242-1-wakel@google.com>
Subject: [PATCH] selftests/futex: Conditionally run futex_numa_mpol test
From: Wake Liu <wakel@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Wake Liu <wakel@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The futex_numa_mpol test requires libnuma, which is not available on
all platforms. When the test is not built, the run.sh script fails
because it unconditionally tries to execute the test binary.

Check for the futex_numa_mpol executable before running it. If the
binary is not present, print a skip message and continue.

This allows the test suite to run successfully on platforms that do
not have libnuma and therefore do not build the futex_numa_mpol
test.

Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/futex/functional/run.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index 81739849f299..f3e43eb806bf 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -88,4 +88,8 @@ echo
 ./futex_priv_hash -g $COLOR
 
 echo
-./futex_numa_mpol $COLOR
+if [ -x ./futex_numa_mpol ]; then
+    ./futex_numa_mpol $COLOR
+else
+    echo "SKIP: futex_numa_mpol (not built)"
+fi
-- 
2.51.0.355.g5224444f11-goog


