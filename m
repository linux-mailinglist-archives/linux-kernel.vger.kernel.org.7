Return-Path: <linux-kernel+bounces-742886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46260B0F7E0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2EA7161FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950F41DEFE6;
	Wed, 23 Jul 2025 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+fMsh7z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037B1EA7CE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287187; cv=none; b=FVmCW3x3LN51z2HI2W6z5FOLDtGQwWeyEfsI0I/Hqz3Zai7PZY9wMnXPyFLVd3dhdE5WQzCo+vlUUgDWOhhCyytYDwfU8oGprLtLqXqNz/hX1PI4ni2mf61mNt29B2A8YxsfOm+1YanNqmDMJMyHwh4mFoGWjdatFxHUvoGdDI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287187; c=relaxed/simple;
	bh=JSsX/bPADyns/ee35USI4lxKFOWp4V1IMj9DJEUZ9+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W34fEwjXZwCWqVloa6427ITaVgZmL8Hb45wrEvlCDbPNaZc59WAvx+e1hxjP7s1AyKiSzQWO2qF0Lj3v98cCTUFwjgxTv0KHH5YNpZQevyq9wtIEtv3dxib/bK9iB/pIvg/DDrDu3M9Lqs41c0NNRzOeju1EaIsyDwTlHRROFZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g+fMsh7z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753287184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K+oLnUkud2e/nXL96cPo5783kvC+G1k6dOgTZxPhWmg=;
	b=g+fMsh7zliLuRq4GYNb7Dbu1DwoKt+KBn22UCZ52Y4wj555iawbDh/oI3HyqOgXvekKBkU
	F0S/m1nFuN5MARVXdtJM0qxjoKjvWj/yZBix2MIl1ALqhj8HE3bG+18gkd4Zc/lsLsySTE
	OcpvceZyrni5on/KAtuOV+HlHkNXJVw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-hzoZhXW6MSu0edWTrLOI8Q-1; Wed,
 23 Jul 2025 12:13:02 -0400
X-MC-Unique: hzoZhXW6MSu0edWTrLOI8Q-1
X-Mimecast-MFC-AGG-ID: hzoZhXW6MSu0edWTrLOI8Q_1753287181
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 170A81800C31;
	Wed, 23 Jul 2025 16:13:01 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.162])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E3B3180A302;
	Wed, 23 Jul 2025 16:12:56 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/5] tools/rv: Do not skip idle in trace
Date: Wed, 23 Jul 2025 18:12:36 +0200
Message-ID: <20250723161240.194860-2-gmonaco@redhat.com>
In-Reply-To: <20250723161240.194860-1-gmonaco@redhat.com>
References: <20250723161240.194860-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently, the userspace RV tool skips trace events triggered by the RV
tool itself, this can be changed by passing the parameter -s, which sets
the variable config_my_pid to 0 (instead of the tool's PID).
This has the side effect of skipping events generated by idle (PID 0).

Set config_my_pid to -1 (an invalid pid) to avoid skipping idle.

Fixes: 6d60f89691fc ("tools/rv: Add in-kernel monitor interface")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/src/in_kernel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index c0dcee795c0d..4bb746ea6e17 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -431,7 +431,7 @@ ikm_event_handler(struct trace_seq *s, struct tep_record *record,
 
 	if (config_has_id && (config_my_pid == id))
 		return 0;
-	else if (config_my_pid && (config_my_pid == pid))
+	else if (config_my_pid == pid)
 		return 0;
 
 	tep_print_event(trace_event->tep, s, record, "%16s-%-8d [%.3d] ",
@@ -734,7 +734,7 @@ static int parse_arguments(char *monitor_name, int argc, char **argv)
 			config_reactor = optarg;
 			break;
 		case 's':
-			config_my_pid = 0;
+			config_my_pid = -1;
 			break;
 		case 't':
 			config_trace = 1;
-- 
2.50.1


