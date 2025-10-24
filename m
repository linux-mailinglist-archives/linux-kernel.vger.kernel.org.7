Return-Path: <linux-kernel+bounces-869290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FE7C078A8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E182C4F3293
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD4E3446BF;
	Fri, 24 Oct 2025 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5wVANKv"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C6834405E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326985; cv=none; b=FL1GeKd7oIXwr89E591zKUh6t0MCOzSH5oQSNSd4LGD/Xh8fk2lAxRqwXHYxwFg2S56Xc/j00MZh2wjOT1LQhfi8+0khtOkZoeZAqNAxCWwnHHkJwiOr7LIZQfHZHTi41jt1zy1N9LqPkJxtA6LLNlv0MAtYCeniGZWvy159vAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326985; c=relaxed/simple;
	bh=UZ2BE5GPybLE7CmLT7dIgGDbZyKLOU9ISpTX4FoMbcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ernsF6fJMyqTkunwtuYvqywy3Yt5dfvavKoGD9zJT22LBUqrB6fuySMguH1q/g2ezguXGNf1MGGrzt5Gj6KS7s3C8UwaaLnk5wPoybJr3fRJQKDzXWU5l/dnjuBrSCQ4NgjRa+2V8+H85BPuGGpro/8+HUesAPFAK1xo2llXEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5wVANKv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290aaff555eso23236425ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761326984; x=1761931784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2E6IemruVg75xkrWi4SiWqjFMrX39+ybWZzL7YhtdU=;
        b=d5wVANKvbeOk9Va36U4mi+S/z+7eP1GrR92RhjxVXgPwlXt6+oHQhQDv89upqNGkgN
         OVgYBQbZ6q506UrsrYG6XmqMDoyl05y8MAW0ZM1/u7ZZ7ZSPuDsUnfR4wjyINKa/FoiV
         EuFglLtvo8N80EvziDoLA1MYPgZCorLOWPBdZVqru2DgnW5M5P0W8OuWBPXL4sRn3ZcW
         5+om1IFNuW/CG5dGQpBWkgKg8RYxpt/zG8ql27YHWP2pgnAWt3ZBgjaMDT/3zL4qZ4I9
         rxDcda5UkkHzOwgeXCHwyUlXTAfKoQ+6CtTxOowdPyyNoBesBoaXNpmtkYzDa3t0YhOT
         My4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761326984; x=1761931784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2E6IemruVg75xkrWi4SiWqjFMrX39+ybWZzL7YhtdU=;
        b=lB2Munkls638+0zkH5rHl3UNdlqAWC+ran6v9aPwgTvfb9hbI6L4I5WJ3KdtzPd/RL
         2zpHPX9zB1Gl7dNrjBKo/tA6KUQqV1mx+x7eQs5WPejQf+SUFi4mWOE1OUK4Md0WQT4x
         f5K0VIPRv0epsS1Pk+DjDj9pSyOoEO7rrrgMHeO6SO55nEZhcvP9BUvJTFK0mJLm6y62
         q8PvSHS2elKYW82k40dr+6K0nP20P8TKR3ZIQq4ncyRBrNPDLq+yl0koTDmjpPIm33I/
         q++l4vC+RRcvtXOb2EFiG5kAQyLE5ax2b7vlrIt/DlA+J9ndhQoiWlWX8L4NwGGM76r0
         cyVw==
X-Forwarded-Encrypted: i=1; AJvYcCWd+f6H09p+nhal3bxFcTMP1Zvj2cbjldfAz4thNwu6CCEpcK98TRdZni72D1eg63qrxh7H+codDaYCT+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD8MugYyH1Ei6922clcpdVEhacwqhCKzHPsX73AY4n+lJ0AgN2
	n/TnYFmGDZQ/3NHWSPJhQiH+MGkcrakAnZlxSj6aJGv2o1SPqgi1Q+8r
X-Gm-Gg: ASbGncsA9lLRFYuPmPih9Vw1obNBNlMJnkxp0T37qev2TwRiCeRIZi1lug461ZRQ9kx
	XKN6gCFmUR/UFHCyHvQx3jXIvV85zmE+HAnixJSTPy4dsDLKqTyGt6ohSLwXChJe9+f9WUzjFLk
	O9+Y61Y/RPYw8SOivVehsn2zDxtTZOcfpQJedGoRWLPjeEP1+Yb74QNtf+kQFGxnNumxiZB9IMt
	3FwfdztvYoXe8JClmNvK75n/hDzqpMTbrPOlJp5dsHiCpO4rL130lJ4Y3Ufy7w/lWxLacSAgGZn
	B42/pVgNXJBRSC7k6E7e5FlWZXVq674p0iunX7T2MNXqvjIgIVoiv9NuX0wTNr04ezovsc83Ahi
	0BFvSQeUPxLArXw0H5Ghl/WJ4OKMS9k/8SPxhbXzLWM5VaSNKmpnLXfq8GGCgRhqEm/BUU93xsN
	ypQKiPfuZZOg==
X-Google-Smtp-Source: AGHT+IFDckuW4U3/23hRsjFB0HpKtIlUoNugINuYueWTdcIWu6YG/tXUlw0Eque8u+bVzB/zHd6Frw==
X-Received: by 2002:a17:903:244b:b0:290:9a31:26da with SMTP id d9443c01a7336-290c9d31109mr366942675ad.16.1761326983580;
        Fri, 24 Oct 2025 10:29:43 -0700 (PDT)
Received: from aheev.home ([2401:4900:88f6:d7b0:8f5e:ff90:677:7d74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda85e7sm61719615ad.11.2025.10.24.10.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:29:43 -0700 (PDT)
From: Ally Heev <allyheev@gmail.com>
Date: Fri, 24 Oct 2025 22:59:15 +0530
Subject: [PATCH v2 1/2] checkpatch: add uninitialized pointer with __free
 attribute check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-aheev-checkpatch-uninitialized-free-v2-1-16c0900e8130@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2471; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=UZ2BE5GPybLE7CmLT7dIgGDbZyKLOU9ISpTX4FoMbcA=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDJ+b6/Z//XcY448pxeb7gaJ6YeWXdy1T9L89Lvdhv++f
 xdrU3/U11HKwiDGxSArpsjCKCrlp7dJakLc4aRvMHNYmUCGMHBxCsBEoj4z/K/z/XZvSmxsi9RN
 nymf96asu+Dsf7nugcdxGbtfGgWMDVaMDJP/HWi4da9gv5pijnz9n5XSwt5PDmnsdTn6JGm+cH6
 ELzcA
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

uninitialized pointers with __free attribute can cause undefined
behaviour as the memory allocated to the pointer is freed
automatically when the pointer goes out of scope.
add check in checkpatch to detect such issues

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@suswa.mountain/
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
 Documentation/dev-tools/checkpatch.rst | 5 +++++
 scripts/checkpatch.pl                  | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index d5c47e560324fb2399a5b1bc99c891ed1de10535..1a304bf38bcd27e50bbb7cd4383b07ac54d20b0a 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -1009,6 +1009,11 @@ Functions and Variables
 
       return bar;
 
+  **UNINITIALIZED_PTR_WITH_FREE**
+    Pointers with __free attribute should be initialized. Not doing so
+    may lead to undefined behavior as the memory allocated (garbage,
+    in case not initialized) to the pointer is freed automatically
+    when the pointer goes out of scope.
 
 Permissions
 -----------
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 92669904eecc7a8d2afd3f2625528e02b6d17cd6..1009a4a065e910143dabeee6640b3b3a4bd3fe06 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -509,6 +509,7 @@ our $InitAttributeData = qr{$InitAttributePrefix(?:initdata\b)};
 our $InitAttributeConst = qr{$InitAttributePrefix(?:initconst\b)};
 our $InitAttributeInit = qr{$InitAttributePrefix(?:init\b)};
 our $InitAttribute = qr{$InitAttributeData|$InitAttributeConst|$InitAttributeInit};
+our $FreeAttribute = qr{__free\s*\(\s*$Ident\s*\)};
 
 # Notes to $Attribute:
 # We need \b after 'init' otherwise 'initconst' will cause a false positive in a check
@@ -7721,6 +7722,12 @@ sub process {
 				ERROR("MISSING_SENTINEL", "missing sentinel in ID array\n" . "$here\n$stat\n");
 			}
 		}
+
+# check for uninitialized pointers with __free attribute
+		while ($line =~ /\*\s*($Ident)\s+$FreeAttribute\s*[,;]/g) {
+			ERROR("UNINITIALIZED_PTR_WITH_FREE",
+			      "pointer '$1' with __free attribute should be initialized\n" . $herecurr);
+		}
 	}
 
 	# If we have no input at all, then there is nothing to report on

-- 
2.47.3


