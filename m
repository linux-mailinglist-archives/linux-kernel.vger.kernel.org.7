Return-Path: <linux-kernel+bounces-886551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295ADC35EAA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB2618C6FA5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E0D321F2A;
	Wed,  5 Nov 2025 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b886+smX"
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685B9311971
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350498; cv=none; b=FvyHlXROr0mE8Iz3O9k2XPv3324dN1rpCYUefaHTNKCIj+ZjJIm09euhZtDrZU5upysZ7hZDweAdOtrQ9lko7WIkRS43Cs4sIB/ZiJmC9mpAmZr0nFVhME0GYcwCkQ90qsUy41o8G4zL/f6fMFsm3271qVGgwwtP6DOLsDi4204=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350498; c=relaxed/simple;
	bh=rpF/oLwwz7O841ew+syC7sbdElbrIiTt86A497EpAOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CNYeRXYx5qYSEk4Oc4Zpl5g2BdAtf7SaxORoNY4jljWFOjPK69kqHMdc8ZGDEGKpq7QW5CFbmxZHkKXxswI4ARN/c/zpysgzmTb8bRMmLlDnKpTNduYywi4ingksO7lxa/zH8TIuwdkD4a6tVSBdaJYJ783S0izu19y9oJw8XBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b886+smX; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63fbbad0ac3so2912374d50.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762350495; x=1762955295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jJssk0gxGn0iFLrk19VXEsDISUnqvEbeNwuR40SWB4Y=;
        b=b886+smX3j5oZckN2lHZoPGF9ghRxRr9luDRFgUAsE8cx77wsfwW075PwOcn23ixPj
         BBYS0XT/ReW8RfX+LZLvq9hW3ZCZ/bTVWIvdl5Yw/guZ7A+G5oJfSvJ8rtKHQid3O9rt
         6VAWBQKuOkJoszLBXzOncEwYfgkhF0i3Pr6rAhDVh2jkSIf2wGAgqeD5dfJocGJHIoRk
         nVoDvVT+/1qCzS349lZsVWwT5eBNSKY+bBbpRlSvzqTLGQoRPvgoTG9JYcDy9R4GJlV2
         NYEPX7FqBrBoH2TIYF0YfM7Qz0zUqzKPD9r0MvLWsqw4a9C8/k0+7JTpCbOUHZGcWbhL
         vE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762350495; x=1762955295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJssk0gxGn0iFLrk19VXEsDISUnqvEbeNwuR40SWB4Y=;
        b=jgubdaLsEkte/bcwyj2ut52JnSLnz1PROEy7d3HT+MaYvqFxQkZyRSXcoLkJNSFndI
         XKt313thdlbo6R4trhHVUUXl68eYrruLkiFvqFpqpTxfwnIBdtZ6SnHUjH8dgEC8Eqn5
         7QG3uXhqDVqXObD2SMiZd1Djf+wVfmGCgYzWV1SPQ8kR+IVb2JTb2oW/sMmhPn1Nz8Wd
         Mp0YxF2+3+x0LkOYExS0Ej0FUoI/QF1R7MEPLT4RjXwQdG1ZrukoijeActkV9ztuYiB8
         iOHfb48sYMOzYtmtw+eAXvR+HSnuQp7KLhhyUfhQxLbTtUf9odTiAPldk4fS0pbDStDA
         +J5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRQ6yeXLL+d+jM8OItc1fcfmP8n0C1e+UmZ0AFro+KgBSgkTFblkN3AWxwQwLDEP9ebKjAo/SPuazlGVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0FRoFjju2PD4y14BxctSZvtV8D1FTY0tpjXy9J7V107eNAJWB
	vQeq4U6W5gb8lWk/3G5TAM98Dhg/bpaXkDLMeZuP5khO/X4lI6MNnBAN
X-Gm-Gg: ASbGnct++tC+QIF9HkByR6LHW0JIJZLPPPExK8XH8JqdWU7U3LBP4UDT7+Gwe9twBNC
	JulTiNigxgaAriB3M/OQ8whLEjOJmg2Fq+mP+bewQ1Df+E6wbX6MpKT9Qmid2ZagmsjjGNg9i/P
	mEX/jD+nBQTNg+LNN4Jft2wwIZwPTqKKySsg3nWs5MpIaSUwc9Rk7kTOG5/qQU777k+DDpQYwHl
	w6KjSSTBbmlt+GzQyHHShGvWd34KCfdK2EvmxykK3zLNceRqtQJRZo/1kIvnOr20OneCX4xfR8F
	0EJTKpTanUgRe69dtUTaa/aDBoxTOfbM3X3/jE4dYLvkJnVFQcZ/t3pCw2IS3Nrf2Ti+9y0hUfI
	YlfVlFBMCLGI+3fWcCn1XZb5gvIF4ZIp0KenkXzQkg/Wd8Uu+YeR0PQcTZByKRHWts0+JjOAVkv
	l8/6P1PGFzTQ==
X-Google-Smtp-Source: AGHT+IH7BpjfVcinvMxz5MYpjHf8TptJnxAcGDEuyJEkuZoQaRvdaP9XoNNgT8DevmloqzJa5lj/qQ==
X-Received: by 2002:a05:690e:4259:b0:63f:a63f:19d5 with SMTP id 956f58d0204a3-63fd35a3b1bmr2137748d50.65.1762350495322;
        Wed, 05 Nov 2025 05:48:15 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78694a26cc2sm17143427b3.48.2025.11.05.05.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 05:48:14 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	hannes@cmpxchg.org,
	baohua@kernel.org,
	shakeel.butt@linux.dev,
	ziy@nvidia.com,
	laoar.shao@gmail.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v2] PR_*ET_THP_DISABLE.2const: document addition of PR_THP_DISABLE_EXCEPT_ADVISED
Date: Wed,  5 Nov 2025 13:48:11 +0000
Message-ID: <20251105134811.3170745-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PR_THP_DISABLE_EXCEPT_ADVISED extended PR_SET_THP_DISABLE to only provide
THPs when advised. IOW, it allows individual processes to opt-out of THP =
"always" into THP = "madvise", without affecting other workloads on the
system. The series has been merged in [1]. Before [1], the following 2
calls were allowed with PR_SET_THP_DISABLE:

prctl(PR_SET_THP_DISABLE, 0, 0, 0, 0); // to reset THP setting.
prctl(PR_SET_THP_DISABLE, 1, 0, 0, 0); // to disable THPs completely.

Now in addition to the 2 calls above, you can do:

prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, 0, 0); // to
disable THPs except madvise.

This patch documents the changes introduced due to the addition of
PR_THP_DISABLE_EXCEPT_ADVISED flag:
- PR_GET_THP_DISABLE returns a value whose bits indicate how THP-disable
  is configured for the calling thread (with or without
  PR_THP_DISABLE_EXCEPT_ADVISED).
- PR_SET_THP_DISABLE now uses arg3 to specify whether to disable THP
  completely for the process, or disable except madvise
  (PR_THP_DISABLE_EXCEPT_ADVISED).

[1] https://github.com/torvalds/linux/commit/9dc21bbd62edeae6f63e6f25e1edb7167452457b

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
v1 -> v2 (Alejandro Colomar):
- Fixed double negation on when MADV_HUGEPAGE will succeed
- Turn return values of PR_GET_THP_DISABLE into a table
- Turn madvise calls into full italics
- Use semantic newlines
---
 man/man2/madvise.2                      |  6 ++-
 man/man2const/PR_GET_THP_DISABLE.2const | 20 +++++++---
 man/man2const/PR_SET_THP_DISABLE.2const | 52 +++++++++++++++++++++----
 3 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/man/man2/madvise.2 b/man/man2/madvise.2
index 7a4310c40..55c6f4a6c 100644
--- a/man/man2/madvise.2
+++ b/man/man2/madvise.2
@@ -372,9 +372,11 @@ or
 .BR VM_PFNMAP ,
 nor can it be stack memory or backed by a DAX-enabled device
 (unless the DAX device is hot-plugged as System RAM).
-The process must also not have
+The process can have
 .B PR_SET_THP_DISABLE
-set (see
+set only if
+.B PR_THP_DISABLE_EXCEPT_ADVISED
+flag is set (see
 .BR prctl (2)).
 .IP
 The
diff --git a/man/man2const/PR_GET_THP_DISABLE.2const b/man/man2const/PR_GET_THP_DISABLE.2const
index 38ff3b370..d63cff21c 100644
--- a/man/man2const/PR_GET_THP_DISABLE.2const
+++ b/man/man2const/PR_GET_THP_DISABLE.2const
@@ -6,7 +6,7 @@
 .SH NAME
 PR_GET_THP_DISABLE
 \-
-get the state of the "THP disable" flag for the calling thread
+get the state of the "THP disable" flags for the calling thread
 .SH LIBRARY
 Standard C library
 .RI ( libc ,\~ \-lc )
@@ -18,13 +18,23 @@ Standard C library
 .B int prctl(PR_GET_THP_DISABLE, 0L, 0L, 0L, 0L);
 .fi
 .SH DESCRIPTION
-Return the current setting of
-the "THP disable" flag for the calling thread:
-either 1, if the flag is set, or 0, if it is not.
+Return a value whose bits indicate how THP-disable is configured
+for the calling thread.
+The returned value is interpreted as follows:
+.P
+.TS
+allbox;
+cb cb cb l
+c c c l.
+Bit 1	Bit 0	Value	Description
+0	0	0	No THP-disable behaviour specified.
+0	1	1	THP is entirely disabled for this process.
+1	1	3	THP-except-advised mode is set for this process.
+.TE
 .SH RETURN VALUE
 On success,
 .BR PR_GET_THP_DISABLE ,
-returns the boolean value described above.
+returns the value described above.
 On error, \-1 is returned, and
 .I errno
 is set to indicate the error.
diff --git a/man/man2const/PR_SET_THP_DISABLE.2const b/man/man2const/PR_SET_THP_DISABLE.2const
index 532beac66..75e17fa6a 100644
--- a/man/man2const/PR_SET_THP_DISABLE.2const
+++ b/man/man2const/PR_SET_THP_DISABLE.2const
@@ -6,7 +6,7 @@
 .SH NAME
 PR_SET_THP_DISABLE
 \-
-set the state of the "THP disable" flag for the calling thread
+set the state of the "THP disable" flags for the calling thread
 .SH LIBRARY
 Standard C library
 .RI ( libc ,\~ \-lc )
@@ -15,15 +15,20 @@ Standard C library
 .BR "#include <linux/prctl.h>" "  /* Definition of " PR_* " constants */"
 .B #include <sys/prctl.h>
 .P
-.BI "int prctl(PR_SET_THP_DISABLE, long " flag ", 0L, 0L, 0L);"
+.BI "int prctl(PR_SET_THP_DISABLE, long " thp_disable ", unsigned long " flags ", 0L, 0L);"
 .fi
 .SH DESCRIPTION
-Set the state of the "THP disable" flag for the calling thread.
+Set the state of the "THP disable" flags for the calling thread.
 If
-.I flag
-has a nonzero value, the flag is set, otherwise it is cleared.
+.I thp_disable
+has a nonzero value,
+the THP disable flag is set according to the value of
+.I flags,
+otherwise it is cleared.
 .P
-Setting this flag provides a method
+This
+.BR prctl (2)
+provides a method
 for disabling transparent huge pages
 for jobs where the code cannot be modified,
 and using a
@@ -31,10 +36,43 @@ and using a
 hook with
 .BR madvise (2)
 is not an option (i.e., statically allocated data).
-The setting of the "THP disable" flag is inherited by a child created via
+The setting of the "THP disable" flags is inherited by a child created via
 .BR fork (2)
 and is preserved across
 .BR execve (2).
+.P
+The behavior depends on the value of
+.IR flags:
+.TP
+.B 0
+The
+.BR prctl (2)
+call will disable THPs completely for the process,
+irrespective of global THP controls or
+.BR MADV_COLLAPSE .
+.TP
+.B PR_THP_DISABLE_EXCEPT_ADVISED
+The
+.BR prctl (2)
+call will disable THPs for the process
+except when the usage of THPs is
+advised.
+Consequently, THPs will only be used when:
+.RS
+.IP \[bu] 3
+Global THP controls are set to "always" or "madvise" and
+.I \%madvise(...,\~MADV_HUGEPAGE)
+or
+.I \%madvise(...,\~MADV_COLLAPSE)
+is used.
+.IP \[bu]
+Global THP controls are set to "never" and
+.I \%madvise(...,\~MADV_COLLAPSE)
+is used.
+This is the same behavior
+as if THPs would not be disabled on
+a process level.
+.RE
 .SH RETURN VALUE
 On success,
 0 is returned.
-- 
2.47.3


