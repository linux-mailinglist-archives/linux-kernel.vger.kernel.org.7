Return-Path: <linux-kernel+bounces-721914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E90BAFCF65
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB5C1BC5640
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FFE2DFA3E;
	Tue,  8 Jul 2025 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t12jUVVg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317512E0B44;
	Tue,  8 Jul 2025 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989094; cv=none; b=X4BIEiLpJJByLgxhFSqcSPZeEMy1xwXkgq5cQoGO0f8yq/ZGb52gCdrW06547NvhCvDrPbhA4MqGd7Gb4iXWifUdGFDLbT2C/nOHM5ghQFI+s29jl5F1QotD1sRkkvDy2yyr3pOr11nuKPUwH4IVufQarK1PwIBLY8eLJpZ+lvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989094; c=relaxed/simple;
	bh=2liBN+VLDNQWZE3GanRUs3dvq5AOE9IpvbDoEMT9aUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YxCBwIOVCLavMnZQENOQvueUkYP2piCAHdHQEW4fzHRfac9fPBP+Lkl8wVg91GBxfFE+tj8MLrTcMITc4JsKGRDsAYQhM0KCfjovXGJK2AwDL7BVRuU+BHnCYJ9Q3UrrJJOZyIAMZ5V3ScXGQonMh0xU9dLsNNCGCwIX7xXg8fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t12jUVVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FC7C4CEED;
	Tue,  8 Jul 2025 15:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751989093;
	bh=2liBN+VLDNQWZE3GanRUs3dvq5AOE9IpvbDoEMT9aUs=;
	h=From:Date:Subject:To:Cc:From;
	b=t12jUVVg5pv4RM8J2TZbrIHSimTtmigL07c5a4zD3gBv6XfElOHL7c4GFetMw9lzn
	 PFKsoDUMD6E+kw+JA5UYczDBpJa2Slq6h2TKDZyeF2nvLYabaXzRs2UfSJUXvMb1+U
	 K5ZpC8MfjIxJVl4/4avThy8YA+JTTTGHgyrfBGg1SiA1DMEL2LDWVGfCs6fR2n3stn
	 2iLxZhnV8vmmt8LC+mU9+JEXBKuusSqnh/fXWRx08dVRvKt87dWJh8dF9e4ejXBd5G
	 ldg9kGRycV9EQxZyxdWHY1dqG6/AUGGAWHT3UHoA651QYbbXXyby58vn9cmLKErX3o
	 3GVd7w93FE/Hw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 08 Jul 2025 08:37:57 -0700
Subject: [PATCH] panic: Add __maybe_unused to sys_info_avail
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-fix-clang-sys_info_avail-warning-v1-1-60d239eacd64@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFU7bWgC/x2NUQqDMBBEryL73YVEkNheRYpsk027IFGyoBbx7
 i5+vhnezAHKVVjh1RxQeRWVuRj4RwPxR+XLKMkYWtd2Lrges+wYJ2tQ/zpKyfNIK8mEG9UiFmf
 yz5hSCJ/gwWaWyubcF8P7PC/GPnTBcgAAAA==
X-Change-ID: 20250708-fix-clang-sys_info_avail-warning-fa19cdd77b71
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Feng Tang <feng.tang@linux.alibaba.com>, 
 Lance Yang <lance.yang@linux.dev>, Petr Mladek <pmladek@suse.com>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1643; i=nathan@kernel.org;
 h=from:subject:message-id; bh=2liBN+VLDNQWZE3GanRUs3dvq5AOE9IpvbDoEMT9aUs=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBm51skTJLg8XS5v6GCwbUjc+tjzYl3f3bLWOaXR734t4
 pYwWdncUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACYSrMPwv2bjI8bY9HvPXtie
 4fXZzJ79fsG63c2LLu5PTdi+v9/zgSkjw5ySwvPa2QpyK5ScYr93/2RbeiT+hbup5I2cLvM3k4w
 0+AA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Clang warns (or errors with CONFIG_WERROR=y):

  lib/sys_info.c:52:19: error: variable 'sys_info_avail' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
     52 | static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
        |                   ^~~~~~~~~~~~~~

sys_info_avail is only used within sizeof(), meaning it is only used at
compile time, which clang warns about in case the developer intended to
use the variable elsewhere. This appears to be intentional in this case,
so mark sys_info_avail with __maybe_unused to silence the warning.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
This should be squashed into
panic-add-panic_sys_info-sysctl-to-take-human-readable-string-parameter.patch
so I did not bother with a fixes tag.
---
 lib/sys_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sys_info.c b/lib/sys_info.c
index 46d6f4f1ad2a..5bf503fd7ec1 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -49,7 +49,7 @@ unsigned long sys_info_parse_param(char *str)
 
 #ifdef CONFIG_SYSCTL
 
-static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
+static const char sys_info_avail[] __maybe_unused = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
 
 int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 					  void *buffer, size_t *lenp,

---
base-commit: 10f2351db2799f80af91da7aee4c60fd042bfcf3
change-id: 20250708-fix-clang-sys_info_avail-warning-fa19cdd77b71

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


