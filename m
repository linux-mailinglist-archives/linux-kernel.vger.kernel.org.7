Return-Path: <linux-kernel+bounces-871976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB31CC0F01E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDA640367B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1B630EF91;
	Mon, 27 Oct 2025 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnmvUMgd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E356330E856
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579277; cv=none; b=KQ1poge6rbD/tr14wFnpEjZMpGBoWyBTdh5/9AYHlhBqmAfcYSYkEMzDxybBOHSkkbbqkBIAdIuzrbQQst43LijE01O0rPpmHSmY0E2NROCE0Kb84bAHtvAwO4895FfbradnWlTswkuPaTX7iTmrQZGIv62lfOwUAPFm9TJ0DX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579277; c=relaxed/simple;
	bh=YMf+9R/PB7Rn/nSanJ1qN6xwBpW1JxcXcqf/9NeCKjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOSJs/yAusNFGeueQO7suoJPaoTieY/F4yCGSC79QIe7U0GaBjcL05w0M1C/neAgkoDpQvvcw8o7ewWmmBtros2evVbNYKGWaQZyMmXdeo9z6K/Rxk9AyfkROiyCSknzgDeptA0cuOvK0m50tqLHfOnVwqM7v2talp4TDhe2EsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GnmvUMgd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761579274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSN84v7pXU4iL2XOp2r81stsd6YXOv55W/nDN5c8mgU=;
	b=GnmvUMgdakfxMxinpIhUaGKiFX+2je2eYwtAmsjXucxT57R20Tm/ShunIGEcKwLGoy+dr4
	PW9vECID5/5o3NXENlSCGtfxbuu9iRgDse0o8Qh3E2VWt00F5wNyk7L5RvYZjsbU1zKOEU
	NlMy7Vg0qj8Ibwn69rC9RTC9ZEjbGJo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-xoKuXJJQM4CUYuUx_eblBQ-1; Mon,
 27 Oct 2025 11:34:31 -0400
X-MC-Unique: xoKuXJJQM4CUYuUx_eblBQ-1
X-Mimecast-MFC-AGG-ID: xoKuXJJQM4CUYuUx_eblBQ_1761579270
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E4D219540DF;
	Mon, 27 Oct 2025 15:34:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DD0E195398C;
	Mon, 27 Oct 2025 15:34:26 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v3 5/7] rtla/tests: Run Test::Harness in verbose mode
Date: Mon, 27 Oct 2025 16:33:59 +0100
Message-ID: <20251027153401.1039217-6-tglozar@redhat.com>
In-Reply-To: <20251027153401.1039217-1-tglozar@redhat.com>
References: <20251027153401.1039217-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add -v flag to prove command to also print the names of tests that
succeeded, not only those that failed, to allow easier debugging of the
test suite.

Also, drop printing the option and value to stdout in
check_with_osnoise_options, which was a debugging print that was
accidentally left in the final commit, and which would be otherwise now
visible in make check output, as stdout is no longer suppressed.

Suggested-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/Makefile        | 2 +-
 tools/tracing/rtla/tests/engine.sh | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index aef814b639b7..2701256abaf3 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -110,6 +110,6 @@ clean: doc_clean fixdep-clean
 	$(Q)rm -rf feature
 	$(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h example/timerlat_bpf_action.o
 check: $(RTLA) tests/bpf/bpf_action_map.o
-	RTLA=$(RTLA) BPFTOOL=$(SYSTEM_BPFTOOL) prove -o -f tests/
+	RTLA=$(RTLA) BPFTOOL=$(SYSTEM_BPFTOOL) prove -o -f -v tests/
 examples: example/timerlat_bpf_action.o
 .PHONY: FORCE clean check
diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index c7de3d6ed6a8..ed261e07c6d9 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -105,7 +105,6 @@ check_with_osnoise_options() {
 			[ "$1" == "" ] && continue
 			option=$(echo $1 | cut -d '=' -f 1)
 			value=$(echo $1 | cut -d '=' -f 2)
-			echo "option: $option, value: $value"
 			echo "$value" > "/sys/kernel/tracing/osnoise/$option" || return 1
 		done
 	fi
-- 
2.51.0


