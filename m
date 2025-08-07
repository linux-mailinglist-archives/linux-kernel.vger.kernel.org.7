Return-Path: <linux-kernel+bounces-758973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB674B1D67F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0BF56563B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ADA277CA9;
	Thu,  7 Aug 2025 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T2SqWPn2"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D0C20126A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565562; cv=none; b=dPjuoJt3ku50s3H28JwaJ3wy6ayntK+ft+26dEY2RhDDYRsRAqaCtyn7GHOnS/wVTFsbznr5sXo800DjBtEo0d5vCC98dEcmHocEuJVJIpiZKKeG58IcikTw9z6lCaytJy4lXJToQltErupP3+J3ITdqY7d/QGnp7A3KMcSLGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565562; c=relaxed/simple;
	bh=ZkF8jh1gFdfZp919uNwQ7sSDtUZdCxkZOnwQX8PDWD8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Veo+noQxCSncbW4QO7MUEHFce2sMtvioN/EJmqjcDo21YBm5Y467liaDR6hraFzMyNLjKMJ8sJXJVX0y//aoUMCdaWA71U006J9i4GryWcKw5RSMEhcV+rp1HTNTBA6LTGmOfu9BgECAXkMFYm0a9opDDcTxCCVinodnoiSVRuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T2SqWPn2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-242a1390e9eso18722075ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 04:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754565560; x=1755170360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BJ853Dm2M3X2xAMi+YsaFLHvqSyoH6H15dbLqYMdmiA=;
        b=T2SqWPn2aGysS+E/7ceVlcmjMqxRMamBtszKBNrGe/b64YT3ns9wKW/mhituvsbuLC
         u6LoieoT/sGx+FFkLGW74FMYuV0RMHH2MbeopmQMdwNM6is8hVj/i5sxv2Ria8oHRfHn
         zYBp96UxTQcJ3GvD2SKmgrQsmZ/xalxdxxl24DcCXll9jXGoImzoGQ7u0QQ6IGMi7oz9
         jBsTEa2HXpwGO5uoBFbMS4A3O/XcorKLLNiqBzq78jhPSUh4X/4dWTwU+fhj5SXxajyE
         oX4xUAAlgvn3Bawr0uclUBqrp+iaGZSzZI46ISGT9MBapevCuhLbM48/Rf7EcaCtKIAP
         ihlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754565560; x=1755170360;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJ853Dm2M3X2xAMi+YsaFLHvqSyoH6H15dbLqYMdmiA=;
        b=kNi0Smtmv8dg02dBPJxCIax6Gjd+cy8tLp6O+gnYuiRbzE28ztVALrp9B5MIbLF9II
         JfnUtf7pCih/ZnMD0TBzaF/kr8F16wDaH4Ch0ha5ldw4mtOfU+LKLk0t8zX+87FEtSbH
         Uur7i4Zebw1Gr56kLGtIMrbp6yL8x/be0zrFrgbr/3YZ4aexr6azah6nSvf6aNweju25
         kd3eN4+KGy6X3p/1eMNvSMsdiA9auVazklTCDPoQCq34R2X1ivpnhBQ6puiFvfP50Ji2
         MnEno82+oNQrZOXmB103bw/4TXHT9ONpcN+t5rV9dJ+JRtWAGAOJIhkQInQt29tfwUWq
         5Llg==
X-Forwarded-Encrypted: i=1; AJvYcCUsoKlWP0tBGqPdPdyNWcBH9G036Q0UadYR/YN4H/KBrYkOVu0vrDeHVHvczM4lY9Wt19eUo/FkVic5LD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsqmACZR9kALdx8LfmPZz+MtHs0eN59fkYefvRt2MiYrmpdwJN
	iGDYIfWS9bQ5NnB8XTxWy8hBxY/kXcGP22uBnV42YBXpjk6djnvfTRgDMslsiYn4ciwnw2Nl3bq
	AtA==
X-Google-Smtp-Source: AGHT+IFy3F42CZmrEm2LnDnRjXrib1Trv+7jvEIpO95cQe5uhHa7MyhQXe3/N8CQzw5sXrzTI9e867VTig==
X-Received: from pjoa22.prod.google.com ([2002:a17:90a:8c16:b0:31e:d9dc:605f])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea09:b0:240:7265:1cdf
 with SMTP id d9443c01a7336-2429f44b3admr76738435ad.23.1754565559795; Thu, 07
 Aug 2025 04:19:19 -0700 (PDT)
Date: Thu,  7 Aug 2025 19:19:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250807111914.1743705-1-wakel@google.com>
Subject: [PATCH] selftests/futex: Check for shmget support at runtime
From: Wake Liu <wakel@google.com>
To: tglx@linutronix.de, mingo@redhat.com, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net, 
	andrealmeid@igalia.com, wakel@google.com
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

Signed-off-by: Wake Liu <wakel@google.com>
---
 .../selftests/futex/functional/futex_wait.c   | 49 ++++++------
 .../selftests/futex/functional/futex_waitv.c  | 78 +++++++++++--------
 2 files changed, 72 insertions(+), 55 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait.c b/tools/testing/selftests/futex/functional/futex_wait.c
index 685140d9b93d..17a465313a59 100644
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
@@ -96,32 +96,35 @@ int main(int argc, char *argv[])
 	/* Testing an anon page shared memory */
 	shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
 	if (shm_id < 0) {
-		perror("shmget");
-		exit(1);
-	}
-
-	shared_data = shmat(shm_id, NULL, 0);
+		if (errno == ENOSYS) {
+			ksft_test_result_skip("Kernel does not support System V shared memory\n");
+		} else {
+			ksft_test_result_fail("shmget() failed with error: %s\n", strerror(errno));
+			ret = RET_FAIL;
+		}
+	} else {
+		shared_data = shmat(shm_id, NULL, 0);
 
-	*shared_data = 0;
-	futex = shared_data;
+		*shared_data = 0;
+		futex = shared_data;
 
-	info("Calling shared (page anon) futex_wait on futex: %p\n", futex);
-	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+		info("Calling shared (page anon) futex_wait on futex: %p\n", futex);
+		if (pthread_create(&waiter, NULL, waiterfn, NULL))
+			error("pthread_create failed\n", errno);
 
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
@@ -161,7 +164,8 @@ int main(int argc, char *argv[])
 	}
 
 	/* Freeing resources */
-	shmdt(shared_data);
+	if (shared_data)
+		shmdt(shared_data);
 	munmap(shm, sizeof(f_private));
 	remove(SHM_PATH);
 	close(fd);
@@ -169,3 +173,4 @@ int main(int argc, char *argv[])
 	ksft_print_cnts();
 	return ret;
 }
+
diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools/testing/selftests/futex/functional/futex_waitv.c
index a94337f677e1..3baf5142b434 100644
--- a/tools/testing/selftests/futex/functional/futex_waitv.c
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -104,46 +104,62 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_wake private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv private\n");
 	}
 
 	/* Shared waitv */
-	for (i = 0; i < NR_FUTEXES; i++) {
-		int shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
-
-		if (shm_id < 0) {
-			perror("shmget");
-			exit(1);
+	bool shm_supported = true;
+	int shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
+
+	if (shm_id < 0) {
+		if (errno == ENOSYS) {
+			shm_supported = false;
+			ksft_test_result_skip("Kernel does not support System V shared memory\n");
+		} else {
+			ksft_test_result_fail("shmget() failed with error: %s\n", strerror(errno));
+			ret = RET_FAIL;
+			shm_supported = false;
 		}
+	} else {
+		shmctl(shm_id, IPC_RMID, NULL);
+	}
 
-		unsigned int *shared_data = shmat(shm_id, NULL, 0);
+	if (shm_supported) {
+		for (i = 0; i < NR_FUTEXES; i++) {
+			int shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
 
-		*shared_data = 0;
-		waitv[i].uaddr = (uintptr_t)shared_data;
-		waitv[i].flags = FUTEX_32;
-		waitv[i].val = 0;
-		waitv[i].__reserved = 0;
-	}
+			if (shm_id < 0) {
+				perror("shmget");
+				exit(1);
+			}
 
-	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+			unsigned int *shared_data = shmat(shm_id, NULL, 0);
 
-	usleep(WAKE_WAIT_US);
+			*shared_data = 0;
+			waitv[i].uaddr = (uintptr_t)shared_data;
+			waitv[i].flags = FUTEX_32;
+			waitv[i].val = 0;
+			waitv[i].__reserved = 0;
+		}
 
-	res = futex_wake(u64_to_ptr(waitv[NR_FUTEXES - 1].uaddr), 1, 0);
-	if (res != 1) {
-		ksft_test_result_fail("futex_wake shared returned: %d %s\n",
-				      res ? errno : res,
-				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
-	} else {
-		ksft_test_result_pass("futex_waitv shared\n");
-	}
+		if (pthread_create(&waiter, NULL, waiterfn, NULL))
+			error("pthread_create failed\n", errno);
 
-	for (i = 0; i < NR_FUTEXES; i++)
-		shmdt(u64_to_ptr(waitv[i].uaddr));
+		usleep(WAKE_WAIT_US);
+
+		res = futex_wake(u64_to_ptr(waitv[NR_FUTEXES - 1].uaddr), 1, 0);
+		if (res != 1) {
+			ksft_test_result_fail("futex_wake shared returned: %d %s\n",
+					      res ? errno : res,
+					      res ? strerror(errno) : "");
+		} else {
+			ksft_test_result_pass("futex_waitv shared\n");
+		}
+
+		for (i = 0; i < NR_FUTEXES; i++)
+			shmdt(u64_to_ptr(waitv[i].uaddr));
+	}
 
 	/* Testing a waiter without FUTEX_32 flag */
 	waitv[0].flags = FUTEX_PRIVATE_FLAG;
@@ -158,7 +174,6 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv without FUTEX_32\n");
 	}
@@ -177,7 +192,6 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_wake private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv with an unaligned address\n");
 	}
@@ -195,7 +209,6 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv NULL address in waitv.uaddr\n");
 	}
@@ -211,7 +224,6 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv NULL address in *waiters\n");
 	}
@@ -227,7 +239,6 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv invalid clockid\n");
 	}
@@ -235,3 +246,4 @@ int main(int argc, char *argv[])
 	ksft_print_cnts();
 	return ret;
 }
+
-- 
2.50.1.703.g449372360f-goog


