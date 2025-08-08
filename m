Return-Path: <linux-kernel+bounces-759814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759B9B1E32A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36F216B7E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B10224AF9;
	Fri,  8 Aug 2025 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oqxOMYz3"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFB9221558
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637348; cv=none; b=Bgk/XkQ1PIGa/4U9/jLXZB7RMl5WqiI2TqioDx0rUNSQTz+6KFaOQ0I7OdvB9EXmfwAvE5mVtKrS3W5qoxa5pmUP88TnOfmX4YdA9JR7wWSbB1PeXFyQTVjbJZ1sHT7rsgs7mOPlqY5pW+2l4FQlhkUBrGS3yM2FzslArQGN3Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637348; c=relaxed/simple;
	bh=ASmrmMaSkJvkmKNln9No2+QIjBIVmTkBBgLR/juMZCw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V4BJpUgq1fnPJ4RArHq3/3/mIXypRWpSt4GxPvjqqTM35pkDM7McLY77R9VT1ZxLev2PvPFxMWZX0h5EckBQsCj5iM2VMtQIYAGZj8r7HmWbxA4ZxfrBt1UEa1R28iwbk06ZikTl638fTbZgCGXeyJwJ9oTcQu1ShMVOjgZHhBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oqxOMYz3; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b42aeac2d75so362352a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 00:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754637346; x=1755242146; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3F9gUOy2pnJ9oY/QGBIv1m9C3L0DkpYmKEr0a26plgw=;
        b=oqxOMYz3iCnVNOjpCKZPDKpRc/eflJKnoYELihe36uyVQ+mDBVgfCU6vKaZ/+ZYr3T
         rYHqJBsWPCblhY70fLrLyowiPPh59wBptOIFbaqEECbzKo0HrHfItc5e1BvIWqgpKhbz
         LNe5Pj9AoK0hV88iBaUPOyDhQIzE3GkuvLNMO8i3fZzU9IeHWJY6mrGbwdTsR1CmnDL3
         ZR2TuM8Yw6VAp6q/qK9yiujmRGqz11wFpC5VR9wxjB0jD+zQ1actAMKbbHq9YkHNBkx0
         ckO+rV70ll6yQFAPryqChDO8bvSK6XHVReY5z/oZrndwACJmEdlXEbjvlLimtxeP3X8i
         AsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754637346; x=1755242146;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3F9gUOy2pnJ9oY/QGBIv1m9C3L0DkpYmKEr0a26plgw=;
        b=CbwWFCNXXonC0WAfwbA7h+Px0zGHgDn8EXsax0Fos04HQ1BVjMqFeb27KIp0xDa5B9
         MFSkNzhDTHHwbWhz3fAR90jlKADQyWHHre42EU4mg8unvIUIC3WdCf4phDwshEtJEO5+
         Ti0byurUF2xEtxq0dsNYUd7Zg2PiTfG6izCbA13AKKUjrWbiuVOoqV0FSdq1IBG6EGjD
         NQkQogmmCrcoVXUfJ1M8nLuQOuVDM0nDTUYVm1v9s6M5JXiSB/1KvXqGxwEjM4ZzAStn
         TBjldr8MoZcZS8RcwMF71ooAx2cWVNrVpN24H5uKBTP3HmEbjQvTGW3aBFDsQozkx789
         uDZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9hnwrdMAw2tKFbx1IEcIi3vjqVg/pPsTCpGCm8Er7mzKjuEXLr277WBipiYmlsqKFHuDJ97zZvXU+gTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+fsPRV47Q1VScLF4h+ZSZc93aRw04jEPwM3DwFNpRr6o2Hm7Q
	6nCKOptft857vMfMvcP9hx4nIyBikpeVQKG0orz8QidXMXSfm71HXgdCxmZCij934gST3Gyhpz3
	mEA==
X-Google-Smtp-Source: AGHT+IHQJ0qyd4BoPgvRMKVVHm80mILibnDe0FalsXDK6EDDsdXNkbWMCbSLvKpkWdgLewvq69rS+H25aQ==
X-Received: from pgbfq1.prod.google.com ([2002:a05:6a02:2981:b0:b42:87c7:df5b])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:258e:b0:240:1d4f:720b
 with SMTP id adf61e73a8af0-240551ad061mr2990006637.23.1754637345935; Fri, 08
 Aug 2025 00:15:45 -0700 (PDT)
Date: Fri,  8 Aug 2025 15:15:40 +0800
In-Reply-To: <20250807145550.1837846-1-wakel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807145550.1837846-1-wakel@google.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250808071540.2122553-1-wakel@google.com>
Subject: [PATCH v2] selftests/futex: Skip futex_waitv tests if ENOSYS
From: Wake Liu <wakel@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Wake Liu <wakel@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The futex_waitv() syscall was introduced in Linux 5.16. The existing
test in futex_wait_timeout.c will fail on kernels older than 5.16
due to the syscall not being implemented.

Modify the test_timeout() function to check if the error returned
is ENOSYS. If it is, skip the test and report it as such, rather than
failing. This ensures the selftests can be run on a wider range of
kernel versions without false negatives.

Signed-off-by: Wake Liu <wakel@google.com>
---
 .../selftests/futex/functional/futex_wait_timeout.c    | 10 +++++++---
 tools/testing/selftests/futex/functional/futex_waitv.c |  8 ++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index d183f878360b..8a48cf5d235f 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -64,9 +64,13 @@ void *get_pi_lock(void *arg)
 static void test_timeout(int res, int *ret, char *test_name, int err)
 {
 	if (!res || errno != err) {
-		ksft_test_result_fail("%s returned %d\n", test_name,
-				      res < 0 ? errno : res);
-		*ret = RET_FAIL;
+		if (errno == ENOSYS) {
+			ksft_test_result_skip("%s: %m\n", test_name);
+		} else {
+			ksft_test_result_fail("%s returned %d\n", test_name,
+					      res < 0 ? errno : res);
+			*ret = RET_FAIL;
+		}
 	} else {
 		ksft_test_result_pass("%s succeeds\n", test_name);
 	}
diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools/testing/selftests/futex/functional/futex_waitv.c
index 034dbfef40cb..2a86fd3ea657 100644
--- a/tools/testing/selftests/futex/functional/futex_waitv.c
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -59,6 +59,14 @@ void *waiterfn(void *arg)
 
 int main(int argc, char *argv[])
 {
+	if (!ksft_min_kernel_version(5, 16)) {
+		ksft_print_header();
+		ksft_set_plan(0);
+		ksft_print_msg("%s: FUTEX_WAITV not implemented until 5.16\n",
+			       basename(argv[0]));
+		ksft_print_cnts();
+		return KSFT_SKIP;
+	}
 	pthread_t waiter;
 	int res, ret = RET_PASS;
 	struct timespec to;
-- 
2.50.1.703.g449372360f-goog


