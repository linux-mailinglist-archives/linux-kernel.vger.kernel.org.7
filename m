Return-Path: <linux-kernel+bounces-724686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C44EFAFF5F5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40803B7217
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5277372636;
	Thu, 10 Jul 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLSoxCcZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC14EB672
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107551; cv=none; b=SURycitaluHW0273GmAxQ0lAqR4ZkltfaDxWvtSDi/2XphPaf9J3/FzusuZ3Osy9PqLiaJILfEXjFvilLy8Rn0O1Uk3j6IrmWLldM5/vEqDYGqWUhmdAD82pp0ObbDz3NoENj0NZJNH5lIA4OfDyGb3VIQ/JVPUqyHcaMgO6Duo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107551; c=relaxed/simple;
	bh=vQqrhoGSR+WKR28YzxztOGwiKAKirp5vAByB76774lw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ug8i/CE0KJSFyXB74zZEazA/bXF+dwzmETvS+nTvCNjeyw/P+UROUZmAOZqa5aq/CtJR7X/EX5n3oIYe4CD4b/H9DCKG+aJkNS33ZTzehEnQr4IoGpCQVpSwRjqUXVcwP3lmSIdWHpJZA0TarBErJf6NCbtqPehmz/1kMv5Dt1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLSoxCcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A0BC4CEF8;
	Thu, 10 Jul 2025 00:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107551;
	bh=vQqrhoGSR+WKR28YzxztOGwiKAKirp5vAByB76774lw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=fLSoxCcZnDkD4YrzFqT/fSdaI2kqxiJS46bjuANiKM8PsBvQ2RqQMkXlPl8xYdDzl
	 K/3AZpvD5Vyni/MJb6j257M9tQA2qa2x7Hh3X/bzMdMEd7xBLOvlODkVl725J02a6O
	 ZT6RsQVSiYKngB+PxTb3f67S6rL+aJnQgJhvZ+TWeRQwxGLqpYlCgPqiivABtBhLTD
	 v0TORBb/2xKWVur2hl/KMV1/AW+JKPDi4H9DRLCH6KzG6qloq7rlkHd4ZJT+raOveG
	 Da9Fvc4JZMWsLhWQRMwX6qzJHOtoJFkRtilaAnunIdJdF/3vShkkCIKoxJz2HdyviZ
	 YR39SdseVWztw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfDH-00000001WOI-3YLr;
	Wed, 09 Jul 2025 20:32:35 -0400
Message-ID: <20250710003235.703485893@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:31:58 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nam Cao <namcao@linutronix.de>,
 Petr Mladek <pmladek@suse.com>
Subject: [for-next][PATCH 02/12] printk: Make vprintk_deferred() public
References: <20250710003156.209859354@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

vprintk_deferred() is useful for implementing runtime verification
reactors. Make it public.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/printk.h   | 7 +++++++
 kernel/printk/internal.h | 1 -
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 5b462029d03c..5d22b803f51e 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -154,6 +154,8 @@ int vprintk_emit(int facility, int level,
 
 asmlinkage __printf(1, 0)
 int vprintk(const char *fmt, va_list args);
+__printf(1, 0)
+int vprintk_deferred(const char *fmt, va_list args);
 
 asmlinkage __printf(1, 2) __cold
 int _printk(const char *fmt, ...);
@@ -214,6 +216,11 @@ int vprintk(const char *s, va_list args)
 {
 	return 0;
 }
+static inline __printf(1, 0)
+int vprintk_deferred(const char *fmt, va_list args)
+{
+	return 0;
+}
 static inline __printf(1, 2) __cold
 int _printk(const char *s, ...)
 {
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 48a24e7b309d..bbed41ad29cf 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -72,7 +72,6 @@ int vprintk_store(int facility, int level,
 		  const char *fmt, va_list args);
 
 __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
-__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
 
 void __printk_safe_enter(void);
 void __printk_safe_exit(void);
-- 
2.47.2



