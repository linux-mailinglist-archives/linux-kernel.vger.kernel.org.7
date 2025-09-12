Return-Path: <linux-kernel+bounces-813054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4CAB54025
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F9516B15D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9170D1BD01D;
	Fri, 12 Sep 2025 02:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ealCE4Zp"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E9919E81F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757642885; cv=none; b=D8ge3Z1X3TQimbxZpSv0tJlq8OMmV+T1gn2RLxVjGyvAMmIPbt2STulA6vhrpLSbIPlYIq8V9QuxDCsVby5CQqJC5M0/RDnoVEer6BBGxfnM32uYKcPVsVB6lsLvcy2+wnGMB0Wgr0DWclB/pAZnrWeKgmF2+gJoi+9ytguw2Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757642885; c=relaxed/simple;
	bh=zbmepUv5MhWdm0b+QCOGN6KW75Q1eP0IAhJLHBVpxMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBH0gpfXTHNFAyj9YvQPSHHHmjhklMdjTDIxEiy3Djyx+nBIvAveeaLj2S10ARm8U2yDbpZeeYDjXBYUNJhM/iBVB6+76Vym7/W5w91YbUIJN0UFq3q8I0btgHDFRNTG82I/gB/5tGy9xz1pKj/xrgcn9TkaTNdo9hq+PSMXuJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ealCE4Zp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77616dce48cso19728b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757642884; x=1758247684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E07gf3+EHiFZ+TUqDdqlrvhEU6rgl4o/YSp2RBqLkNw=;
        b=ealCE4ZpWKcninDw14cxMXGy+iL11HpIJzaTJ4Fm9tDg2talkeM0j/6sByL/ArzkwY
         /41+M9SW8kOci+u644fiNjwyIh6iG7NyTC8Pyp/OI0omhAdE1/PGdcHpcjvCZkEALkWF
         Zclmy7Y9vhlk7AJdTMvrH0H7Cp3k8VPS8kVr/y0MVyd6WBHZWr0100CLloek3O84OPuM
         aXt3AO2pz811OrN+IBXijOTnK8gn9nsBuTauVWDd6jstZZGKGB5K9jaW1L+ZhnokDTva
         7WHVkyCLH0wHeZTTiwPRSaF7hIhm+f1D0FVH41XXQso7viHjQSIt/WBouelNSTTY094i
         1HSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757642884; x=1758247684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E07gf3+EHiFZ+TUqDdqlrvhEU6rgl4o/YSp2RBqLkNw=;
        b=SbdX9Y1f1Gynk5pspp9Ab+s1jZVgxzh/dXYPyJMpA/AxMif1/nigcyqH2LoWPkCfOk
         AsTZRWnKUAkNmHKxGUsIactHdaKWgHSn8BAUigLud9clOP06+9o0aPynCH8D5irncGEJ
         4jaILTWMoTW43vO/mhJ2T2qp4ShF8zoCAWzO84xdSAn35nMYB5nUg+Tuaab5Cs7ox/Ui
         LPhgkWeB/WI+U8krM+jEpmz3mOtyC0OuQfY26+owH6YGumWz/E03RT4LVx4g6tVMYcqi
         SO4EoEC5VNfMHsIJhQMrDpFolQrGkfbEutnNhA3qWA0aP9ORh9GQs7CSUoUETbeB+9+S
         eZnw==
X-Gm-Message-State: AOJu0YymL6PpA+lDuFtKZuAsHWgYfJDvgFFu/PZuGR0nBudHRHoq5BaP
	QxJ0RNEme3R7jOqVpkmpoq8iE/5aSz8aXYKkZxNzexY8rTXfH108VVux
X-Gm-Gg: ASbGncuFUksEKz/N5dLuXvgQboyVxGyYkkzgOFBIHOOuzknOhS9Es0DUON1VnxLJ9XS
	/wsUiBafoRFtCxreEXrguX70hTHs70UJ5XpRclJ37KvbR1wFTir7V97sBLudyh2qTUOcwBkgqu+
	jOfJK2/BtXy44BecCsYnbi66+2kPTOmc5OGZ7a3ZA0BCFh7AHwgmgUnivcOJylYlvh+JB7ug4LJ
	t3cA2OkKiwOoP+5hs5azxKTzrAH+JP/facH7XTMXCAYjfw7LxsPDQC+0GHgswJZhgly03xhmmiU
	Xyc17nryQ3bNRB5G673ldteh1Mq6ImjUmKUXS2B4D+k96PVfMvgzXMuCdt+vhMfL9ltjHtJ6K4z
	qDgyqHPmO46Z1Bkyri1w5GtRPZfmH/2pBHkp4LVEaQA==
X-Google-Smtp-Source: AGHT+IFEcRkPzakxU0kaxf9jjdDkTtUd8qF2iNgkp1rPpI99OOUe05rVuWh4zU9jEAvZxs6wqmzhBw==
X-Received: by 2002:a05:6a20:5491:b0:249:c440:9b36 with SMTP id adf61e73a8af0-2602cd2793emr1748011637.58.1757642883745;
        Thu, 11 Sep 2025 19:08:03 -0700 (PDT)
Received: from localhost ([103.121.208.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b43a7sm3767364a91.13.2025.09.11.19.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:08:03 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v2 2/2] x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint
Date: Fri, 12 Sep 2025 10:07:27 +0800
Message-ID: <20250912020742.193292-2-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912020742.193292-1-wangjinchao600@gmail.com>
References: <20250912020742.193292-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new arch_reinstall_hw_breakpoint() function can be used in an
atomic context, unlike the more expensive free and re-allocation path.
This allows callers to efficiently re-establish an existing breakpoint.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 arch/x86/include/asm/hw_breakpoint.h | 2 ++
 arch/x86/kernel/hw_breakpoint.c      | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index aa6adac6c3a2..c22cc4e87fc5 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -21,6 +21,7 @@ struct arch_hw_breakpoint {
 
 enum bp_slot_action {
 	BP_SLOT_ACTION_INSTALL,
+	BP_SLOT_ACTION_REINSTALL,
 	BP_SLOT_ACTION_UNINSTALL,
 };
 
@@ -65,6 +66,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 
 
 int arch_install_hw_breakpoint(struct perf_event *bp);
+int arch_reinstall_hw_breakpoint(struct perf_event *bp);
 void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 3658ace4bd8d..29c9369264d4 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -99,6 +99,10 @@ static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
 		old_bp = NULL;
 		new_bp = bp;
 		break;
+	case BP_SLOT_ACTION_REINSTALL:
+		old_bp = bp;
+		new_bp = bp;
+		break;
 	case BP_SLOT_ACTION_UNINSTALL:
 		old_bp = bp;
 		new_bp = NULL;
@@ -187,6 +191,11 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
 }
 
+int arch_reinstall_hw_breakpoint(struct perf_event *bp)
+{
+	return arch_manage_bp(bp, BP_SLOT_ACTION_REINSTALL);
+}
+
 void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 {
 	arch_manage_bp(bp, BP_SLOT_ACTION_UNINSTALL);
-- 
2.43.0


