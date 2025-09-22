Return-Path: <linux-kernel+bounces-826476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62335B8EA12
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3DF188EABD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF6C126BF1;
	Mon, 22 Sep 2025 00:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMvV4n2d"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8CC78F51
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758501906; cv=none; b=W/bSCuBKGfKXarLT1mjEpaWFzJqETxT6CDeHttzTx71JNSZcofbi0OU/CaQT32vzVrL+wnO9nCDX/Orzvopql61Tvws2m3yreQS3//9p/3F0sSy54DBH57wjX0qDXvdTcfrrm1sbr2uXb2cLc2jSC6H891bo/yn+7CtVvJN4yYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758501906; c=relaxed/simple;
	bh=CMzTLzSuPzZSKmPCVID34LoXc6n8pN+Vcm6j0KSBe3M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VFvlGJyXFJGpjKV7Ybxd7ENb6+OX0TcPCJNrTyypJKD6EaYTZzNw2FA0AWOwgHssmOybzyzetOLKKOhjCohPUTI6wCknp63FtIGl4Jal9mB3x/Z2ikN68I69+VyzA45dO6s+ItpcTmUUVhuskdBjrWnxrnM25Qks2nA8j+yaUQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMvV4n2d; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-25669596921so39115875ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758501904; x=1759106704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4TpF34W3PHvsBrekGwm1rvuPQAafzFCgW5mxOcoS+s=;
        b=kMvV4n2d1G53xqdBgS9QkMa68yAuMWJRbnFWpMwK6DXBR7Kd6+vt6eqkIjUuUVhn4b
         VPpDZpboqARJfMX1oY44IsuuhjRpEQ+NwiVgGBi0bDwEuuYXU+rMHQlT3X/S3uJRK/PY
         Yigqbv31Djv5hZdVzS/iHhnoGdFfkvfaIcPeqsK5sA1cVMm8sRomHx4syaU9Ke3iXg53
         +mtMUT3GHZxftB7Yyg3Frc3GmS5glMezPmGKH82OJEBLJXuFnnbs/4nqzIpcdlSO8sGo
         6rP9qSjIFstNZE/vO5U7SIPr/6It3eS0g/KGrTBmaLt8x0raZH1ntemei5z0KfoVNJ0u
         fNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758501904; x=1759106704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4TpF34W3PHvsBrekGwm1rvuPQAafzFCgW5mxOcoS+s=;
        b=imZNhYthfCyZCAyrlivhX9FmM+deEC5uLNzdeH3VhlJgV3Bry8Te4sDg/42EX8hpnq
         LjFYVazX1wiwKocHPI4oBBAZeCbr+/0SyHWxC8rn9zANEp95AZOjGThZq/0jOPMilV8z
         Do2A8AYfFh1TIBXfPS0P/fHHBxG45hrCweyk9xGWGOuOdhYYxrTYbccVyt9iYQWiu/xC
         GYetSU6s8s1NbLoFxleeIDWOo/FLahgm5Ewy7A7ds3OItGkUdcqbcxgq+VraTyey2Tdk
         nq3o6sS2AE8FRjndg9CPaC2kj5u7Tzi726s4lH2cfKOHv97PHsQGJ2DRC+4DdnnsR0xc
         zkeA==
X-Forwarded-Encrypted: i=1; AJvYcCX1T2Zlc/wsyB0ngTHl3YCL3XeqtgYCBd26rslMRsChkjdQgWVx0dl3Wp4EnvDU3QTX8rLrN3Q0YeI47ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjjKHmVWY893TwJGJ4TjLJ+TQoxn4IyxeszH7pZclAcuRrM3bt
	F1QjAUTXSQ3mzkGBVqAiz+DhnImE48X4UxCSgxNUDMrQvWxWWz/IlHpA
X-Gm-Gg: ASbGncv8QovpxUfCZ1U+NT+HFZGjV+Y67wbriKnVpe69gfpygW6D4CeLC7lMghEUxUu
	CK/ym5yayrOX+GQ7gW7ozR8q6Y+4DNABmJ82nwSwjKnbNDE0HGVi4sAN6SvHPVb0/FOmG0S/UQp
	/ruqXvuIZSv4sofrgcif0SyfqNfZL45zSqZxCckE9kY7rrKBP4rNQwRzLz80AXAwN33hcA3rS97
	xl/Av0+vRWF1mBgJ0xmqcxAlhV9VP0WpQtvt2HYrgHcGsWu14kNtfdmoy1Z87lgkEL3fPCsIpLu
	HLP4kUGxzCPOuI0CTfAVnXVKRny1AX3mKsjSC6h2S5MdPkwhK/1lsi4j/cA20Z2ZhJJpjUxB+xe
	W89mBvo4fQTNIfVozNSgBzqXTvlsM8aBoNfJpWnX+s98TjcN2uyH0
X-Google-Smtp-Source: AGHT+IGeGCeJGDQO792G7blZZbjio2dz2UzvLzPbvR3uVFdQj+v9IaRb+EMqbWNhfxxc4quvxfrw7A==
X-Received: by 2002:a17:902:cf4c:b0:267:776b:a315 with SMTP id d9443c01a7336-269ba508205mr140392845ad.32.1758501903638;
        Sun, 21 Sep 2025 17:45:03 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f0da42fdesm6769810b3a.66.2025.09.21.17.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 17:45:03 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	shuah@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	krishnagopi487@gmail.com
Subject: [PATCH RESEND] selftests/powerpc/pmu/: Add check_extended_reg_test to .gitignore
Date: Mon, 22 Sep 2025 06:11:23 +0530
Message-ID: <20250922004439.2395-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the check_extended_reg_test binary to .gitignore to avoid accidentally
staging the build artifact.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 tools/testing/selftests/powerpc/pmu/sampling_tests/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/powerpc/pmu/sampling_tests/.gitignore b/tools/testing/selftests/powerpc/pmu/sampling_tests/.gitignore
index f93b4c7c3a8a..ea29228334e8 100644
--- a/tools/testing/selftests/powerpc/pmu/sampling_tests/.gitignore
+++ b/tools/testing/selftests/powerpc/pmu/sampling_tests/.gitignore
@@ -1,5 +1,6 @@
 bhrb_filter_map_test
 bhrb_no_crash_wo_pmu_test
+check_extended_reg_test
 intr_regs_no_crash_wo_pmu_test
 mmcr0_cc56run_test
 mmcr0_exceptionbits_test
-- 
2.43.0


