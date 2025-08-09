Return-Path: <linux-kernel+bounces-761082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A7BB1F427
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 12:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B6A581FE1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 10:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7624F262FE6;
	Sat,  9 Aug 2025 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3nW+YOk"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E925392D
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754735300; cv=none; b=IxlxvjiAWk65C0M29EDxS9jvD526ieKeN/Ss+AWjDhYzUsQFEcOsJrQE3ZIgO3HA7yA6GwCh2igNQRThzNoDxwmfpu98va4V9W1NDEtVdWaI0L+TTJ4FCVGe2S0FRisWPsrjO3XFABsvIHfsWPK2nZNC1EOwdH5w9ZlzkO3ipoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754735300; c=relaxed/simple;
	bh=m6nTgomGxXImj/StHZ03gz/I8UjVJR5n3oWFcAjYE/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XNUNZJLn0e4N/QwNRTvj0zzhB/Tlqp/T2cPH5lEXraXIb9hF6mDrtB94I39ocbOH+Aa5fZcrI3flz2W+0ZiSZvUP9uc1tuBY7SSMSRdj3Z3UwW+gRMwoQN0pPrQe0GtGX47GbB7I7y/4JGTpA8QER8b1sczCqze/4/Sw2KC/5b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3nW+YOk; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76be0be9ee1so3110486b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 03:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754735298; x=1755340098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9mWScs8BUkt3rAk7MTYnao70mSIUIP2Js8CYQGZzX/I=;
        b=E3nW+YOkJtHucJjY64Vppk+o+kjf79+JZsXuKEcMLgafeaIIw/ujENCgWR2NZf/u4s
         klJtRu0mhL1xvwN/TlLcixT+ahQoh/a+mA9Osl9QJzopHnUW+wcQaETCqEyC46rP91WE
         hqaDJlvcR0EopRgarTBFtliaiFDACooXER6dcj8iG5qf9t4YoYGYNmFg3wsrJsfhfPrb
         bI3G8ebm5VeI6URJBa633B/tfFz35tsRcsR4M3eDC+npc4m3uiZjrP6DuL/m9gZdhuyo
         1AJQPN6veqRthk3ydd2niHoe5gv8Q12/W3UEjk5ZccfaIO6ecff2MJZUwGOTvrP7F9KT
         YglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754735298; x=1755340098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mWScs8BUkt3rAk7MTYnao70mSIUIP2Js8CYQGZzX/I=;
        b=w0R1y2kuRH8qHlTYaotda2OxLtut2UDVSw9gX184HiL2p1/srXZKj/3pzLMLdtee3b
         1+uynaIZ1b+nrzfV9gBLhuXmkjq4oVTPhnH4Stzq362RKnZtZ1x99/qxv5UgFmhSWPvG
         mQ0Q/7pz3YsfSTwoC1k3Uviz7eHISEPKEVrP5VB4NakD62mEJ8DAxh+DYkaTORMdXGta
         Tp/QgWzBoKor1pbOH+6LO1/Jgz5JibrC3UkvBF6YPQxswNwdHMjimmVOepp1f8dtUnBV
         B7/ycRbUc+a48B+eaGJeJct0RilTl56FUPd4DXyJ98hr0kSzPZbb5kxUgyp7C+OESQZg
         Q6Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVGH5GtVQ++OmDKf8m9mq1BVRuInuZiJW/ouMyn6S6JZE4oCpd9BPhpqNdJ3cL5llRkuWuT7naIL4Z61yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YziYnfoPA/4KX6Z4VS7iL1Bs38sFyQV4zc80GOTjcG1IFpiTgdF
	7xSngKO0mgkc5u89B3UhpmE/KmhOdckCsDfbwMsv7PsbYK99o+jgWCmLgI6bB5n/fjTcKNu9qym
	qqw==
X-Google-Smtp-Source: AGHT+IF3NNTcr+DurXnMcnqThubf8NPrNqtglb3gdC6Me0IRYuZp3yVfxre8HaWWeyI3PwnHbJtCyDagtw==
X-Received: from pgja18.prod.google.com ([2002:a63:cd52:0:b0:b42:27a9:f7e4])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2449:b0:240:167:9c3f
 with SMTP id adf61e73a8af0-24055036e07mr10850632637.14.1754735298422; Sat, 09
 Aug 2025 03:28:18 -0700 (PDT)
Date: Sat,  9 Aug 2025 18:28:12 +0800
In-Reply-To: <20250807140508-d3df8cab-249a-47ed-b92a-d33e43de0aee@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807140508-d3df8cab-249a-47ed-b92a-d33e43de0aee@linutronix.de>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250809102812.2472581-1-wakel@google.com>
Subject: [PATCH v4] selftests/futex: Check for shmget support at runtime
From: Wake Liu <wakel@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Wake Liu <wakel@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The futex tests `futex_wait.c` and `futex_waitv.c` rely on the `shmget()`
syscall, which may not be available if the kernel is built without
System V IPC support (CONFIG_SYSVIPC=n). This can lead to test
failures on such systems.

This patch modifies the tests to check for `shmget()` support at
runtime by calling it and checking for an `ENOSYS` error. If `shmget()`
is not supported, the tests are skipped with a clear message,
improving the user experience and preventing false negatives.

This approach is more robust than relying on compile-time checks and
ensures that the tests run only when the required kernel features are
present.

---
+V3 -> V4:
- Use ksft_finished() to simplify test exit.
- Replace perror()/exit() with ksft_exit_fail_perror().

Signed-off-by: Wake Liu <wakel@google.com>
---
 .../selftests/futex/functional/futex_wait.c   | 51 +++++++------
 .../selftests/futex/functional/futex_waitv.c  | 74 +++++++++++--------
 2 files changed, 72 insertions(+), 53 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait.c b/tools/testing/selftests/futex/functional/futex_wait.c
index 685140d9b93d..ffe9a94c1267 100644
--- a/tools/testing/selftests/futex/functional/futex_wait.c
+++ b/tools/testing/selftests/futex/functional/futex_wait.c
@@ -48,7 +48,7 @@ static void *waiterfn(void *arg)
 int main(int argc, char *argv[])
 {
 	int res, ret = RET_PASS, fd, c, shm_id;
-	u_int32_t f_private = 0, *shared_data;
+	u_int32_t f_private = 0, *shared_data = NULL;
 	unsigned int flags = FUTEX_PRIVATE_FLAG;
 	pthread_t waiter;
 	void *shm;
@@ -96,32 +96,34 @@ int main(int argc, char *argv[])
 	/* Testing an anon page shared memory */
 	shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
 	if (shm_id < 0) {
-		perror("shmget");
-		exit(1);
-	}
+		if (errno == ENOSYS) {
+			ksft_test_result_skip("Kernel does not support System V shared memory\n");
+		} else {
+            ksft_test_result_fail("shmget() failed with error: %s\n", strerror(errno));
+        }
+	} else {
+		shared_data = shmat(shm_id, NULL, 0);
 
-	shared_data = shmat(shm_id, NULL, 0);
+		*shared_data = 0;
+		futex = shared_data;
 
-	*shared_data = 0;
-	futex = shared_data;
+		info("Calling shared (page anon) futex_wait on futex: %p\n", futex);
+		if (pthread_create(&waiter, NULL, waiterfn, NULL))
+			error("pthread_create failed\n", errno);
 
-	info("Calling shared (page anon) futex_wait on futex: %p\n", futex);
-	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
-
-	usleep(WAKE_WAIT_US);
+		usleep(WAKE_WAIT_US);
 
-	info("Calling shared (page anon) futex_wake on futex: %p\n", futex);
-	res = futex_wake(futex, 1, 0);
-	if (res != 1) {
-		ksft_test_result_fail("futex_wake shared (page anon) returned: %d %s\n",
-				      errno, strerror(errno));
-		ret = RET_FAIL;
-	} else {
-		ksft_test_result_pass("futex_wake shared (page anon) succeeds\n");
+		info("Calling shared (page anon) futex_wake on futex: %p\n", futex);
+		res = futex_wake(futex, 1, 0);
+		if (res != 1) {
+			ksft_test_result_fail("futex_wake shared (page anon) returned: %d %s\n",
+					      errno, strerror(errno));
+			ret = RET_FAIL;
+		} else {
+			ksft_test_result_pass("futex_wake shared (page anon) succeeds\n");
+		}
 	}
 
-
 	/* Testing a file backed shared memory */
 	fd = open(SHM_PATH, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
 	if (fd < 0) {
@@ -161,11 +163,12 @@ int main(int argc, char *argv[])
 	}
 
 	/* Freeing resources */
-	shmdt(shared_data);
+	if (shared_data)
+		shmdt(shared_data);
 	munmap(shm, sizeof(f_private));
 	remove(SHM_PATH);
 	close(fd);
 
-	ksft_print_cnts();
-	return ret;
+	ksft_finished();
 }
+
diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools/testing/selftests/futex/functional/futex_waitv.c
index a94337f677e1..681d78ee869f 100644
--- a/tools/testing/selftests/futex/functional/futex_waitv.c
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -110,40 +110,56 @@ int main(int argc, char *argv[])
 	}
 
 	/* Shared waitv */
-	for (i = 0; i < NR_FUTEXES; i++) {
-		int shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
+	bool shm_supported = true;
+	int shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
+
+	if (shm_id < 0) {
+		if (errno == ENOSYS) {
+			shm_supported = false;
+			ksft_test_result_skip("Kernel does not support System V shared memory\n");
+		} else {
+            ksft_test_result_fail("shmget() failed with error: %s\n", strerror(errno));
+            shm_supported = false;
+        }
+	} else {
+		shmctl(shm_id, IPC_RMID, NULL);
+	}
 
-		if (shm_id < 0) {
-			perror("shmget");
-			exit(1);
-		}
+	if (shm_supported) {
+		for (i = 0; i < NR_FUTEXES; i++) {
+			int shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
 
-		unsigned int *shared_data = shmat(shm_id, NULL, 0);
+			if (shm_id < 0) {
+				ksft_exit_fail_perror("shmget");
+			}
 
-		*shared_data = 0;
-		waitv[i].uaddr = (uintptr_t)shared_data;
-		waitv[i].flags = FUTEX_32;
-		waitv[i].val = 0;
-		waitv[i].__reserved = 0;
-	}
+			unsigned int *shared_data = shmat(shm_id, NULL, 0);
 
-	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+			*shared_data = 0;
+			waitv[i].uaddr = (uintptr_t)shared_data;
+			waitv[i].flags = FUTEX_32;
+			waitv[i].val = 0;
+			waitv[i].__reserved = 0;
+		}
 
-	usleep(WAKE_WAIT_US);
+		if (pthread_create(&waiter, NULL, waiterfn, NULL))
+			error("pthread_create failed\n", errno);
 
-	res = futex_wake(u64_to_ptr(waitv[NR_FUTEXES - 1].uaddr), 1, 0);
-	if (res != 1) {
-		ksft_test_result_fail("futex_wake shared returned: %d %s\n",
-				      res ? errno : res,
-				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
-	} else {
-		ksft_test_result_pass("futex_waitv shared\n");
-	}
+		usleep(WAKE_WAIT_US);
 
-	for (i = 0; i < NR_FUTEXES; i++)
-		shmdt(u64_to_ptr(waitv[i].uaddr));
+		res = futex_wake(u64_to_ptr(waitv[NR_FUTEXES - 1].uaddr), 1, 0);
+        if (res != 1) {
+            ksft_test_result_fail("futex_wake shared returned: %d %s\n",
+                                  res ? errno : res,
+                                  res ? strerror(errno) : "");
+            ret = RET_FAIL;
+        } else {
+			ksft_test_result_pass("futex_waitv shared\n");
+		}
+
+		for (i = 0; i < NR_FUTEXES; i++)
+			shmdt(u64_to_ptr(waitv[i].uaddr));
+	}
 
 	/* Testing a waiter without FUTEX_32 flag */
 	waitv[0].flags = FUTEX_PRIVATE_FLAG;
@@ -232,6 +248,6 @@ int main(int argc, char *argv[])
 		ksft_test_result_pass("futex_waitv invalid clockid\n");
 	}
 
-	ksft_print_cnts();
-	return ret;
+	ksft_finished();
 }
+
-- 
2.50.1.703.g449372360f-goog


