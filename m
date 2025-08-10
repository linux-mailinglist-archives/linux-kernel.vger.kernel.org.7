Return-Path: <linux-kernel+bounces-761519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B680DB1FB56
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 19:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD04B1883F51
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC2026CE0F;
	Sun, 10 Aug 2025 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mup/xahv"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995C1BDCF;
	Sun, 10 Aug 2025 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754846674; cv=none; b=l6x9oCwVjpIUBVRd/A8e8VFyBXubRWiusvVzFghP41wkUhCgmbDQ8OjuwtDjdsVsB1kSlMT/+R4k4LNw7OZGifsCdrZsIENjVOgo73ZKEUE+/Zm2Lt7ySYOSjE2zP9cgcVdIFqIWgLFKFKB/qI7YCrUJkdva3kGF3KUd4lbRrY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754846674; c=relaxed/simple;
	bh=wlZ2vvANBOBNoXnQFZS9/zrkZfupPRS4k+iwoWlqWUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=umR6pe2BRhDXrDM050kqY9FPNghV18ZaXvrplrHPzK7nK6qSTm98QXDcXKNkHY3YAHt/+nvgNmut52EadxQjka5i+gkUEi0bz183uw7A1PH3Fu6A34Uy9ZcQZugo5LEI5eZPZsyXcwRXmi5DSp95Cii0d4dk4NaaTeL+i2JlC8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mup/xahv; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-320dfa8cfa3so3456708a91.3;
        Sun, 10 Aug 2025 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754846672; x=1755451472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vYPf+w1WeOZKmEb4rqwBDVjQYiVUVPfTd8uq28qABWQ=;
        b=Mup/xahvZuji2DqbG6Wkgvv1N8x1YHQw6zQYU7Zl7uhrHRt+Tqgck1RLxB3aTi3FS+
         r24mA79U7d9FgbPm0nLV8UQa5+fnRAUkhx+UeD8dIUUSB+PWy6tMjNx66k0i9piDOc0n
         NOcEUqMuIYAxZafkoUVLB7gnaHIzsCxZrCTiacv1/fDHg5M3GdMtx68n+ooxEQmhYDWK
         lIH9qQsQ6iG95sQKdjundfYt/ZFWXPYTXVSods/9zpp+Ldh/SizyFmqLvt2EeQ5NSm6j
         u60xlX2vVAkAxrshdq215A9L6mWhFxzkqV86vy3Uea6Qhe6prdT5DJo2yth7wrJTlFie
         ptJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754846672; x=1755451472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYPf+w1WeOZKmEb4rqwBDVjQYiVUVPfTd8uq28qABWQ=;
        b=gOP0Ua25REXCoiW0m68rkVaGAxz07MueW6DlSjeqZ5VVaFWF7Z36GqrHNxw5bKYUKr
         fMjzzVBoOyiB15qmKrxWlO/mLfd45g37RSTmeAheGTmQYd/tBeYmbHy0d/qLzMLk6uC+
         fwScX7GcjS8+EyH69CsBLGVM/WcqhdTVnraEWYbcKyNa+m0GIiXi+tFhihKoMo88lwhb
         ckZVlJ9spoR8paWqN2cCl+2mHyW3ENLfvDlcPVKyT3+I+eg+7imU53MuQEMxt18kt9Mv
         0srnvFkiugCDeBHfbRDGvDOqWzngNl6715h/UIPbcjJjsthmNt7MJaBcrjf5wtgMoTJy
         Kh/A==
X-Forwarded-Encrypted: i=1; AJvYcCUg3XV0JIlWEnL7wvIY524q54IxCS6FeJy/8PL4MwMH/aRvtqLvFTUgpjNWRDIsA++xezYRSMsXaRY=@vger.kernel.org, AJvYcCXJOUtLK5sgrcnEKoYr/d6k2sBuskdRCQau8rqZOSzW4RlOhEgerCTN4iLoEPZ7iPCCmLMLrQDCadt1TW9j@vger.kernel.org
X-Gm-Message-State: AOJu0YzXBaynHlXe6EnrmkKW4YsqZKo0JNasan6R6Wt7ildswj4+AGdd
	f70B7BknhNRxUPLIwbWcUm6r8rRz5QNQZRrBROTdDHhbJGRXighDySl0
X-Gm-Gg: ASbGncuCYcFyB18g27BPaswpYR4vhhPIrxrMli+t0JlQ3poEu6Kdw70cxbXIfuRcX7G
	xkUZ9Ikbaaeb+2E5xOV9WgyqbpBpNkF3hoQ0dbR1drfJv3yX214+VJRmSDuER2m6QPwL7u1/FNn
	l8sY74SlLv2s3VjZWJDpDU2ZjlqQ2Eq3XdI5XDnIqcvv7Ay+hHdGz9RnN+k9YwZtkrktCaT/guI
	6a3/rCIfnEELap8/CSHFgV+fJRyj66bsFP22oaOyMxXICktTAxt9mjCvzKd76zU3OVNQfjNWOQR
	fK3Zs26LTe8C8ZWIHJPlcBchGpsoZQF53nI+05KaIo97pxt2EIYkel2B28dUCF39GJ8fdlA8740
	8nP34ogRHdJC0LrlSef7SYYPXc30jnw7ogzq98brr0O4xbCrRotxuMQ==
X-Google-Smtp-Source: AGHT+IFPwzf3lb0Ao4zrfqweIQpn5tKSMkvkW8b+XoGtFSrjdWRdmpvQFTv9O1tZud7cre1Pddk5Ag==
X-Received: by 2002:a17:902:e741:b0:242:c66f:9f87 with SMTP id d9443c01a7336-242c66fa6c7mr144288355ad.51.1754846672062;
        Sun, 10 Aug 2025 10:24:32 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d003:7033:bde6:1560:bbd5:3563])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161227032sm12781264a91.12.2025.08.10.10.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 10:24:31 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH] kernel-parameters: fix kernel-doc warning
Date: Sun, 10 Aug 2025 10:24:25 -0700
Message-Id: <20250810172425.21990-1-vivekyadav1207731111@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vivek Yadav <vivekyadav1207731111@gmail.com>

Fix kernel-doc warning in kernel-parameters.txt

Signed-off-by: Vivek Yadav <vivekyadav1207731111@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf..302145870 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7506,7 +7506,7 @@
 			Set a trigger on top of a specific event, with an optional
 			filter.
 
-			The format is is "trace_trigger=<event>.<trigger>[ if <filter>],..."
+			The format is "trace_trigger=<event>.<trigger>[ if <filter>],..."
 			Where more than one trigger may be specified that are comma deliminated.
 
 			For example:
-- 
2.25.1


