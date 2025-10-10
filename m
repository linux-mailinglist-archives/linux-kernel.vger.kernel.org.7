Return-Path: <linux-kernel+bounces-847951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB51BCC258
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049293B8A77
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8624264612;
	Fri, 10 Oct 2025 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fkCoFfEd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E826059D
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085265; cv=none; b=DMwdqEtjJdQSip/laoUsg/IpJ9gXci1tlLAOpfSBTuBOSgxhmkc6yBNxL1eqRNlqxEp4gpcYJw5zaeI0x6hmBOQh5bNnx4WAvjCqZklgtse34WxKKjbKPp//MUGmFWIMvcz06Opz6hmmkGbVPn/WQ4UDEDGcJWLWAwLhIVRBwGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085265; c=relaxed/simple;
	bh=bHdkT0SRpvckR//u62FZqAiNJWH7odfKGe/eJNBu7ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqUphgHoyTcDP4yT4NLorsYvb9zp0lWSaGV0UuFWM3eSMTr+u/cdhI55hQszHN8BkCvSXshNeOayszfPQgrJwNNujWMCuTLP9nBqAh/EANaikzer8djcKxBWhhnEKJ/zoEDlu3DKX16ynCarlyUez/FqQcLoBJ9Mldk/trYSVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fkCoFfEd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760085262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RW1e0jQ2GbtaetsTGdGfNR8Fk/nO8dWFHEsXFoHlOlM=;
	b=fkCoFfEdsdJuyavIJg8/yGemyFrkXWgca9h+yzev6ZmN1WU9NPnLf0iPnETuA5IY10yrKz
	yuD0Hb0VeVfu/SQ6bIjwAVZCV0TZZ68mkgw3w40xuPY+fJ6aYXgmS6a9/acouiRvLywkY1
	BwyEruw3Xl+RqwY6+qgkIZBeDlFoFnY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-WQV_c8CRMyG_KVUkvr2SLg-1; Fri,
 10 Oct 2025 04:34:18 -0400
X-MC-Unique: WQV_c8CRMyG_KVUkvr2SLg-1
X-Mimecast-MFC-AGG-ID: WQV_c8CRMyG_KVUkvr2SLg_1760085256
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA68F195608D;
	Fri, 10 Oct 2025 08:34:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.197])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4BA3219560BB;
	Fri, 10 Oct 2025 08:34:11 +0000 (UTC)
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
Subject: [PATCH 1/9] Documentation/rtla: Fix typo in common_options.txt
Date: Fri, 10 Oct 2025 10:33:30 +0200
Message-ID: <20251010083338.478961-2-tglozar@redhat.com>
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

Fix "unlike" being spelled "nlike" in --on-threshold documentation.

Fixes: 70165c78e31d ("Documentation/rtla: Add actions feature")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/common_options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/tools/rtla/common_options.txt b/Documentation/tools/rtla/common_options.txt
index 77ef35d3f831..8ca424ab0faf 100644
--- a/Documentation/tools/rtla/common_options.txt
+++ b/Documentation/tools/rtla/common_options.txt
@@ -67,7 +67,7 @@
         - *trace[,file=<filename>]*
 
           Saves trace output, optionally taking a filename. Alternative to -t/--trace.
-          Note that nlike -t/--trace, specifying this multiple times will result in
+          Note that unlike -t/--trace, specifying this multiple times will result in
           the trace being saved multiple times.
 
         - *signal,num=<sig>,pid=<pid>*
-- 
2.51.0


