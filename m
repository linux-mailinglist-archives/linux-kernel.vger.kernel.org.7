Return-Path: <linux-kernel+bounces-869291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAD4C078B1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DA18500A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7278934402A;
	Fri, 24 Oct 2025 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlHMHNTK"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5152C3451A3
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326990; cv=none; b=ZHc/rA86cOpQDPRkgkyeYWUEno7iK7Dih4QFeoxQkyL6/W0/Y+9feuO7fMehWHVEH4iyp+YBHX4NHV/gm58IX4eJUIsHbKoZ1iUSdfdsHzasiv1S5XMGm9iONoJmx/shTcKd98nCDyeK6Ews6zSuHHiKrttRL4wLEeID6cnePhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326990; c=relaxed/simple;
	bh=Xl1ZEjB6ltsTv+GdIk8hnYCDz0VvFiu1/vVtb+GptPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PfrsZW+KImXqHXmi3RhDEQ5Tn7x/lxSgZUwFR6ySAsFJUBeKGphZurdfOhig/ZJZ4qN4WGI8wmMpK6A95ZecMB1GACDUqp12uwnRawuazfKiG+Ibjv49ln78Ox/afzbSCGYrNSnVfs2YLVWXMBWXlsgpItfLM4i7Wh+GJMe/dCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlHMHNTK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a28226dd13so1380530b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761326989; x=1761931789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YGZjhDld3XGVawWdcLieeak1oetbhYlwZ5IHuvKrKU=;
        b=LlHMHNTKrafpfHNElhVjClNEHSP38WSmXhrhAgbgAHolzTQC3ECaiQ5XaULeBzTuk2
         A8lLOLyc9en+3hEZsgkuKjYx3h7RKUZ7Fc73NCCWPptBcR6t+JaSBzibFAWVbWEvlF3p
         Cy0He5rjOgmj3ZT+358EJtLsgD/2dMQauESSyaPSLEJf74HDAm2PJzbMnAVPl92tyy6z
         zkrx/ZehYjhkokc+XngOyzj3Mc8uAjfe/WYNBCZWfnRdw3VUcTuTj9oqNhvsgUJs2/+9
         2qGjfpxDymto/9lCzcOmmkJEWYmWxIyY2dyJPzWIyfxzaE4xRI6eeQ/6s25tQQ4B+/7C
         lFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761326989; x=1761931789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YGZjhDld3XGVawWdcLieeak1oetbhYlwZ5IHuvKrKU=;
        b=GNg+Evh2c2otU43LkcLzoJJogv8MFqKGO46BG/IAkiPDi7jrs+UhVC1FRpHnMrEmJJ
         0RkaSinHJycwfCKWFq0Ew9gI0N9Yj7LLwjBhGEgfhfwY8cV/rWp1KVxWf3wEwxK/ZsWb
         y/m//dl7+xU4SvK/C8Ot9M0AeWkY3ilD7LsRoAx/EuROgcUFhGJ0X32iiI+HkvkiD6OA
         XqrrfnFfvh/1fgtZ3sJl3NXdoRZO9a+cEuqhDM8f9gBu0VG8tIXdkIHkhS5I08NudKJ2
         ALaPJO+wfJSHdI4ld8eXJZuFb9vOQpT8WuWhPsbp+CGhdTQXNH7EtVbjcii8M0sHdLur
         KsDA==
X-Forwarded-Encrypted: i=1; AJvYcCVk6rSQibsIt/FJPvq2NCCu715s9UbXHO6ctOQWeu4QJ3/kv0WjS8eT4toE/PT4wtD0Fvs+fYFp3PUOX2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZUnF7lMhZlyARHdQoLnlFcxO3A7oiQiABTv4whtlamp9fF+C
	IHyA8uu7FBG/NuBAYFqvMBkP2/fyUyfBo2m1mL8Xz9hovaB3dHXZErvr
X-Gm-Gg: ASbGncvV58Jns3n3ie0uUuPOQnL7DWHhV6zwwzi+y7BGiKIT1tm5IEfvMiFX+ilxWoU
	HPKf8HRxAkDX0lpMFUdgDTHhYLd1WpCtSdwF0kJKHAmxcPgtCaZ2kqfXIb4SacK/C0BpW4ZH4Pd
	ILIO6ANwV0T8/DF1VVI8nxwpDb/12JGq0JLWCKvwhRwnK7vbYqKL6MoAiUQd9KsR8Gh/H3ZdZsa
	b+uX66EfA8Xi2FJ8xS+U4n72rCApH2DpFPb85ii/bSgc4n5VW5qZ6VCw9WHEuDCuI/JHbvj/lRM
	0WoZQ/hDPCRB0GAey4EAdTtbYC4GH4adXT6RY/5GsAT+FBYwiYko6k+MSvzrfBFf2xUYNsyat8K
	5RjCWZ7OMqFhLN2NOELVa9fws8Qyl0RlZbnqvdPBm2FTaBtVzBCHiTkMOBZTp6X/wgFFDq1elFS
	WE/lRT2Dpgag==
X-Google-Smtp-Source: AGHT+IHE0gPsph7LiBH8wgoEMRerWEq6wtBoH2k0IpyoAj24E2cHMZ/NGysGmuXYuYid0ecv9CML6Q==
X-Received: by 2002:a17:902:d510:b0:25c:46cd:1dc1 with SMTP id d9443c01a7336-290ca216346mr354011385ad.33.1761326988612;
        Fri, 24 Oct 2025 10:29:48 -0700 (PDT)
Received: from aheev.home ([2401:4900:88f6:d7b0:8f5e:ff90:677:7d74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda85e7sm61719615ad.11.2025.10.24.10.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:29:48 -0700 (PDT)
From: Ally Heev <allyheev@gmail.com>
Date: Fri, 24 Oct 2025 22:59:16 +0530
Subject: [PATCH v2 2/2] add check for pointers with __free attribute
 initialized to NULL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>
References: <20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
In-Reply-To: <20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
To: Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, 
 Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 David Hunter <david.hunter.linux@gmail.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 linux-pm <linux-pm@vger.kernel.org>, dan.j.williams@intel.com, 
 Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2036; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=Xl1ZEjB6ltsTv+GdIk8hnYCDz0VvFiu1/vVtb+GptPU=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDJ+b68xNKwQFG997/XXQdTxPc8Zo5PSrfsznq83iYrYs
 CXz73/djlIWBjEuBlkxRRZGUSk/vU1SE+IOJ32DmcPKBDKEgYtTACaSE8Hwv56B58GrkLmy/z2N
 XucVS1sIWBZnWpz1PWVW67Naw79fgZFh3w0nwbMLJf8aukYsnrzMJDpWpFOVP2dlZsGhudLnbh/
 iBQA=
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

pointers with __free attribute initialized to NULL
pose potential cleanup issues [1] when a function uses
interdependent variables with cleanup attributes

Link: https://docs.kernel.org/core-api/cleanup.html [1]
Link: https://lore.kernel.org/all/68f7b830ec21a_10e910070@dwillia2-mobl4.notmuch/
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
 Documentation/dev-tools/checkpatch.rst | 6 ++++++
 scripts/checkpatch.pl                  | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index 1a304bf38bcd27e50bbb7cd4383b07ac54d20b0a..c39213b814f487290d2b0e5d320a4313ada9bbad 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -1015,6 +1015,12 @@ Functions and Variables
     in case not initialized) to the pointer is freed automatically
     when the pointer goes out of scope.
 
+  **NULL_INITIALIZED_PTR_WITH_FREE**
+    Pointers with __free attribute should not be initialized to NULL.
+    Always define and assign such pointers in one statement.
+
+    See: https://docs.kernel.org/core-api/cleanup.html
+
 Permissions
 -----------
 
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1009a4a065e910143dabeee6640b3b3a4bd3fe06..cf186dafc191f1c39d01b3660f19101f6cc61a82 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7728,6 +7728,12 @@ sub process {
 			ERROR("UNINITIALIZED_PTR_WITH_FREE",
 			      "pointer '$1' with __free attribute should be initialized\n" . $herecurr);
 		}
+
+# check for pointers with __free attribute initialized to NULL
+		while ($line =~ /\*\s*($Ident)\s+$FreeAttribute\s*=\s*NULL\b/g) {
+			WARN("NULL_INITIALIZED_PTR_WITH_FREE",
+			      "pointer '$1' with __free attribute should be initialized to a non-NULL address\n" . $herecurr);
+		}
 	}
 
 	# If we have no input at all, then there is nothing to report on

-- 
2.47.3


