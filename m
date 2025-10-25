Return-Path: <linux-kernel+bounces-870099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF397C09EA1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 20:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEF04009D8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2B9303A19;
	Sat, 25 Oct 2025 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eATwI546"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0230E2F6176
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761418185; cv=none; b=ZrUD6xoiCWopCKxIRa82to/xyHuFbh+2sdGs95owj7PZpgUiuKH7CpBBZ/FxbjtvaSHxz9BF6qVAonNgGBpqB80mVaSa8u0Sc+Xp9ZcZQyP3lZ7mKORjWAvOziozolLP0zYHR6JuedQtOqr3KejMdVcDT3q5NdmV9lfnpvLFf5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761418185; c=relaxed/simple;
	bh=3jV0KfbqyUjr6nh2vaI4XUsvRoHBlT0uhCZEnBsgLUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L5YhWIe3x4yUMfXYgOwoXAe2jfsqWjWYreWMBXTv02VX+ig8WE80g4fM1T3qV/VCvrm8ZuYl5R80oURZ2/YLBXpjdByh0JxNvyYNSwo6RBI2LXj8tToL1DxIaZGpNzUWuwx46pvuhS7KndrlwA9RNXbtkQvONyjAvdoqLURwIAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eATwI546; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33ba2f134f1so3115197a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 11:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761418183; x=1762022983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MIRvzi8j6zwlZeQRUUP2B9p5LHiwZA8VZKiF7rQQGE4=;
        b=eATwI546hyMk4GmPjV99wT5Khcsf31Shup7XZmZ80FgNskJgBeltLj+C4Scngud0Kb
         eDD8L9N4+Tbxh/DaEFxWsqJtt+HYit+4spTTAkkxXJEpf5PoZpWi8CBpDVrtGHDO2z9l
         j+pKDe4fxM9tZHr476u6zbT93c6Aeh6XwpxLgdysfrA2btUH03LcwI6Ucd1Yu3nlIiiZ
         /gySeCShrSneBdT7PI/+zd5fDoONqFaV/MvMmooV+2oIhBSMFSglLRAlSWVLf588+Y8z
         Yft4jCs/ei/cc0TFYUCxvad5/EPhZDdCyWoDm5hR2+HuNhYPIJ+LaGQdHJuare79M8v0
         v2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761418183; x=1762022983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIRvzi8j6zwlZeQRUUP2B9p5LHiwZA8VZKiF7rQQGE4=;
        b=NXbdTSCukf9QbE+xpAeB9+fi0Akue2SEj8LWi/60Jz9tVm6jQPc1bmsknXJ3AlWl6s
         Jd34gBdX7yr4IICPEPRERzpZ6hH5Wmj5J7RYmwe74LzBrwlEfJD2F+7gvISiRKzl32u4
         54TZva0CkzZixH5mOw1sVbopvqC6JJUbKi8Ce2B6dxkkT6GaL4xv25hyjjWmlz6zNPfD
         zmeE/FhMhcjxb1VZK8IQoTRvNIAU0BSXsP+JdgYFBM2mZ+pWTtgQR0Cfk5JHuudMHNvy
         eIs9ZvDstU2cnzeePxWKNOgADVnDItWgSEmJYRPKBNHorPxq0AiHLJ5q0VOXuuX8WNRJ
         TtKg==
X-Forwarded-Encrypted: i=1; AJvYcCVdzrV1Sq8iJCnDCkMvVXJM/ltzYBJ5xFTn3i5sm+FbRzhplNQYaGEfalWJ6llM0Q7f2FQtTy5dWN2Zww8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeXr65NY3ZuqRmkmidvH0lX/QXrs5uDFQVzbsjqhR2lrxt3XAk
	2F+mRY3cPCRejIpfRfOHAbkwFNAyQ6I915rOLLl8Rhic9qpCC2vTr+bO
X-Gm-Gg: ASbGncsPlv73liU2SyKCNZR26lz26MMY9H1s5gxHFxTXFC/gyS6dxjM5sBtYRkom8Ky
	7PIiOhqNT4xUsY2xTOyw2RQk46tEmnZ8ujuau/MxP42w+1s01c8ozjunx2hH2Tpr3Ar9hXewG1w
	4QBSZgwM39OBaeVXoIHzDjc1oBeUrk81rms+dWZ76Q20M4JUqBFRq10nEIanKDdWqInCF7+iy1E
	LSXrGmGnufPf6e0E3ZJosON0WgvPkOc4IWDlYnCHjaRoo1FzcXgpXJDrf2jutBL1mATRmSvJHJ8
	IXi4okN8f4u0HaZD/4+1ksTjnkbDbxZ7Hw7/LyGITeEPoyxMV3kRl293T7SYftod7lQlRiRzAMO
	DZAzEU+jlQYY+DzEsSrNXOoLkYYbi9TfVk/64ip2K9ZX6lhO18m4SF2mPYdCHE0jtY8CXfODB60
	L+5N7x39w6Pt0VSD6a6xHoeQqdImUzkVbl5fOogPvba/1JXTzaTcbcHYU=
X-Google-Smtp-Source: AGHT+IHAiMH9JhYQraNgPguxjgZGjEFmFQTsB3vEnaOVZ8IpIk6BfW2plHMfNLdpmtJSevEWDj22Og==
X-Received: by 2002:a17:902:ccc8:b0:292:64ec:8f4b with SMTP id d9443c01a7336-29264ec9336mr315255035ad.43.1761418183223;
        Sat, 25 Oct 2025 11:49:43 -0700 (PDT)
Received: from prakrititz-UB.. ([2a09:bac5:3c3f:a82::10c:1a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0996esm29589375ad.28.2025.10.25.11.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 11:49:42 -0700 (PDT)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Nirbhay Sharma <nirbhay.lkd@gmail.com>
Subject: [PATCH] selftests/seccomp: fix pointer type mismatch in UPROBE test
Date: Sun, 26 Oct 2025 00:19:04 +0530
Message-ID: <20251025184903.154755-2-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix compilation error in UPROBE_setup caused by pointer type mismatch
in ternary expression. The probed_uretprobe and probed_uprobe function
pointers have different type attributes (__attribute__((nocf_check))),
which causes the conditional operator to fail with:

  seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional
  expression [-Wincompatible-pointer-types]

Cast both function pointers to 'const void *' to match the expected
parameter type of get_uprobe_offset(), resolving the type mismatch
while preserving the function selection logic.

Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..e13ffe18ef95 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -5172,7 +5172,8 @@ FIXTURE_SETUP(UPROBE)
 		ASSERT_GE(bit, 0);
 	}
 
-	offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
+	offset = get_uprobe_offset(variant->uretprobe ?
+		(const void *)probed_uretprobe : (const void *)probed_uprobe);
 	ASSERT_GE(offset, 0);
 
 	if (variant->uretprobe)
-- 
2.48.1


