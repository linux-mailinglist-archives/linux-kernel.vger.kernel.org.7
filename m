Return-Path: <linux-kernel+bounces-818182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCECB58DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A8E3B1894
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8032D661A;
	Tue, 16 Sep 2025 05:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XK2kaxFq"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835DA2D23A9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001302; cv=none; b=ah3vVDLvq4g2y1xmTYqgIFpjQkbppX9GI5VevNdlhHsgC/e6ZYOD/uWpNtyozG/1Si3gKearIv0TNH/scsOkzuLR+jY2ORYG5X4Qn5/gZeuDWF+LPbyhF+3uL79/eXUsL5FWUEJIF/fCkJu7U0a1nOjyoRulrT5SoOHycYrntoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001302; c=relaxed/simple;
	bh=ZXOvU7e0c9chQNIv15h0oZ+Tc4LcCxW0p1+eM4k7DXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQAQDh8IfXoKVu0pH0qDzLwuyhpknCM1qDpGjubflJ7XbdwJlpSwmz0YcM+Gv15YHZExgjq259V2bo1wPpF25koOQXAEFckZ3evoKTNssJG5YARQIQPVOB07E8Ars1z7woqgmpOlQis0XMzS6vwtBhmEqF5acHxdymO75W0FknM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XK2kaxFq; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758001288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yHPUvcifRpyk66usxf24gEk4y9IAPj/5jsJNnJQMIhw=;
	b=XK2kaxFqTbFXoLb6lSgLVJH7lsXE977n9qJpt5rX3k9YxuNSe1WyysAy+MNTDsollQyI4w
	WttndJcLJ6gDIVzk2jyVQF+nKjSPC7DpmKlbwFlpWZZ8oKj4efcdIHvUely669i3aaGj7E
	T6J7YcoH29JpdmouM/pl3IaaHDtgJSI=
From: Tao Chen <chen.dylane@linux.dev>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	chen.dylane@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpftool: Add HELP_SPEC_OPTIONS in token.c
Date: Tue, 16 Sep 2025 13:41:10 +0800
Message-ID: <20250916054111.1151487-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

$ ./bpftool token help

Usage: bpftool token { show | list }
       bpftool token help
       OPTIONS := { {-j|--json} [{-p|--pretty}] | {-d|--debug} }

Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/bpf/bpftool/token.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
index 6312e662a12..82b829e44c8 100644
--- a/tools/bpf/bpftool/token.c
+++ b/tools/bpf/bpftool/token.c
@@ -206,6 +206,7 @@ static int do_help(int argc, char **argv)
 	fprintf(stderr,
 		"Usage: %1$s %2$s { show | list }\n"
 		"       %1$s %2$s help\n"
+		"       " HELP_SPEC_OPTIONS " }\n"
 		"\n"
 		"",
 		bin_name, argv[-2]);
-- 
2.48.1


