Return-Path: <linux-kernel+bounces-847956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFCABCC273
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86E71A62A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CAC26D4FB;
	Fri, 10 Oct 2025 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqNrol9/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C2C26D4C1
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085289; cv=none; b=GeT3v7AAGaxt6SZjuQXhb8Ou70afO0updTpzvdQzt0gkBNOQ6K5onEmP9lFzw405kz2/dupoH9nhtlbu1KiIipbe7dmyiND43lRlXUjSXZVWFEWjZ/uOD44dhpD9sGRc+nLBOG6ckwVbJ29OdSw8urDEptzT0v21MaxM3D6vE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085289; c=relaxed/simple;
	bh=x3ZAIwU3EySXOjOfbCRjkR7NcX5xAst2DMDxwnlM/gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pa5NUDkArt2s1ED20K6aiPsrkTbdZptbQaqnr7NqSRVVks3+nfXTEK2qJnN2YuKcYDNsX7lgbWck30mXW7ivbv9MNZTOn30opKtPjKboc1QkTZYkGmudNUbD//1GHxdmcTJjI7QiajUF5b1KsA2inPRBOQ14AkHn6SNbjwNoENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqNrol9/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760085287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMS00EfNi3tjOPOk//dUn2mDkbD2GiWaIk33bzl+TJc=;
	b=VqNrol9/o9fcnZM4JSQm0jsHHkD6wmNE0qJb4cLC/PybbJx+oPW8X/NrPqIF3Q9zvXekRf
	s8ZpxAwfNtQsLVxnsg3NreJdo60IubtXUvKslP+tzDMOmxBE9bOHqAp/1YpWmNox07SjwJ
	1SATmg3kISxFcFIHkE7Qvhi8l3RSKyI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-nIu6KRYxO9aTQMka6MOPkw-1; Fri,
 10 Oct 2025 04:34:43 -0400
X-MC-Unique: nIu6KRYxO9aTQMka6MOPkw-1
X-Mimecast-MFC-AGG-ID: nIu6KRYxO9aTQMka6MOPkw_1760085281
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA77E19560AE;
	Fri, 10 Oct 2025 08:34:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.197])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 41D8619560BB;
	Fri, 10 Oct 2025 08:34:37 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Attila Fazekas <afazekas@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 6/9] Documentation/rtla: Mention default priority
Date: Fri, 10 Oct 2025 10:33:35 +0200
Message-ID: <20251010083338.478961-7-tglozar@redhat.com>
In-Reply-To: <20251010083338.478961-1-tglozar@redhat.com>
References: <20251010083338.478961-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

RTLA allows the priority of workload threads to be set using the -P
option. This is covered in docs, but the default state for RTLA's own
user workload (implemented in timerlat_u.c) is not mentioned.

Add mention of the default user workload priority as well as a reference
to osnoise and timerlat tracers for kernel workload priority.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/common_options.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/tools/rtla/common_options.txt b/Documentation/tools/rtla/common_options.txt
index a2f9c03810b9..b842f065c8f6 100644
--- a/Documentation/tools/rtla/common_options.txt
+++ b/Documentation/tools/rtla/common_options.txt
@@ -42,6 +42,8 @@
         - *f:prio* - use SCHED_FIFO with *prio*;
         - *d:runtime[us|ms|s]:period[us|ms|s]* - use SCHED_DEADLINE with *runtime* and *period* in nanoseconds.
 
+        If not set, tracer threads keep their default priority. For rtla user threads, it is set to SCHED_FIFO with priority 95. For kernel threads, see *osnoise* and *timerlat* tracer documentation for the running kernel version.
+
 **-C**, **--cgroup**\[*=cgroup*]
 
         Set a *cgroup* to the tracer's threads. If the **-C** option is passed without arguments, the tracer's thread will inherit **rtla**'s *cgroup*. Otherwise, the threads will be placed on the *cgroup* passed to the option.
-- 
2.51.0


