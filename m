Return-Path: <linux-kernel+bounces-837950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16541BAE1E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08C14C2974
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FB230C0F1;
	Tue, 30 Sep 2025 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOch6udt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4671F30AABF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251686; cv=none; b=a3ttz2RcRd1FruFqLHA+5C/EsVQKIVx92+mziwlYzsfXVbliUO6o2rg30/XENsi49ClviPDk/+5YzTELX1y8m3IjaNoBXW77IOViPOUmDQlxAY3dG6xc7MHYOgQfuXBhxtTG19ffKzjL62BKuwJq/VfinhKYEqCT4ti5Qlzwgr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251686; c=relaxed/simple;
	bh=ewfavwPiUlXpVnI+x4ifVIAw/sPC3d8q8xGF3eGqVOw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=n5zj6U/QAWweWyfOBxyI8zX0DiBEQTgtzAmTfbbU+50pJFvfr/dOS4kcbcmXGSZnbH6tWFHkxtEiB2M1zRZQqVTmhNRWXmGK6aIEhX4ZhrBlRqWSlONH0rqJMCxISnxpGPhcjJunhYucCNmtpesjrIDq12K5akhqwsptrUvjLvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOch6udt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1F9C16AAE;
	Tue, 30 Sep 2025 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759251685;
	bh=ewfavwPiUlXpVnI+x4ifVIAw/sPC3d8q8xGF3eGqVOw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=QOch6udtKicHTXecfI7Ho1xQ7KnygRBKSNhRJh3owV77Gv2AVpYmYKTfpDQn1Mlqt
	 0Szz4O8J2ZFMPZxwLvyS4QNTyCyixlnMrtKhaJ4lbYKQz52CRSNAh0LIQiuVAI4Fuv
	 9XVL/Gi/y8GwYDvSOf9y6UjGu2XRczJSzT0tet99PDBF/Cz5DtaExwqLnN1urVEYSp
	 AjZuK/Ry9V8sXeaQRrFACYUNsrj+tZM9a6eIiisTwTW/QD9JOCORdhBnAL8YQoa5Ly
	 UL7CvkQPzyhWaJH3y4DNbmJU7IAxtdJmcsazI3Yy6LdRjpMQB0kbQr7+i/5GOeb2f9
	 Qtu45WBUzEc5Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3dkk-0000000DIHK-04YX;
	Tue, 30 Sep 2025 13:03:02 -0400
Message-ID: <20250930170301.869001194@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 30 Sep 2025 13:01:39 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Fushuai Wang <wangfushuai@baidu.com>
Subject: [for-next][PATCH 04/11] tracing/osnoise: Use for_each_online_cpu() instead of for_each_cpu()
References: <20250930170135.285740909@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Fushuai Wang <wangfushuai@baidu.com>

Replace the opencoded for_each_cpu(cpu, cpu_online_mask) loop with the
more readable and equivalent for_each_online_cpu(cpu) macro.

Link: https://lore.kernel.org/20250811064158.2456-1-wangfushuai@baidu.com
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index fd259da0aa64..4cb464894faf 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -271,7 +271,7 @@ static inline void tlat_var_reset(void)
 	 * So far, all the values are initialized as 0, so
 	 * zeroing the structure is perfect.
 	 */
-	for_each_cpu(cpu, cpu_online_mask) {
+	for_each_online_cpu(cpu) {
 		tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
 		if (tlat_var->kthread)
 			hrtimer_cancel(&tlat_var->timer);
@@ -295,7 +295,7 @@ static inline void osn_var_reset(void)
 	 * So far, all the values are initialized as 0, so
 	 * zeroing the structure is perfect.
 	 */
-	for_each_cpu(cpu, cpu_online_mask) {
+	for_each_online_cpu(cpu) {
 		osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
 		memset(osn_var, 0, sizeof(*osn_var));
 	}
-- 
2.50.1



