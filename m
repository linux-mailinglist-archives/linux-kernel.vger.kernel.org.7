Return-Path: <linux-kernel+bounces-819940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6F0B7CAA2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB7244E1C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3E26656F;
	Wed, 17 Sep 2025 03:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ugsjveQb"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A14DDA9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758080916; cv=none; b=dMuwDZmxOyVGg7PJAYp3po6h5cSpki50r0zsdY0F7co9qYGIMtQN6QlMK1xnq24W5ALQawaE7fesmWY49rLLjOymPx0g1RGZ8ELkPeEzlEB2zTDr+UnAVu/KIhcxA5sVc1LsMzwSlcxq1fXnKrZQ+cA/PJ/uhY21TWsmPeLmm3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758080916; c=relaxed/simple;
	bh=jq20iTS9jVDOxoWT+gH+uIIPrVQif5ioi/5KQckDVBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMJzPHXYjqhUTUF/6jLE3bx6M8MOEPlby189EKJVuQloPJzBp3TqdTpINM/CFiAnUeLWK4DE+MvyAtnsXq8J8AHKIL+Xkl8B6/mTV92Bk4GsQD7Msgnzwgam7pHHumTWfbkEmCZOngXzzIfwPmr1l4Rb3qYquHiTQgt/2fmEzhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ugsjveQb; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758080902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iOqw7V8ruMiVBd+YRR7oKYroMTd+7ZOnIXwfeZfS4uA=;
	b=ugsjveQblY1hC+zm3yC2sABjTr1iU9lCuGcKyKNCT7LbL0tnUE5GG7jBk9Ou0lPRhRd/F4
	wQHJe7bqSvqHKy/THEL9CPpD2LpAF1gq5/MmxxZ4NiLPGa2BsGTBnk6jG7YKj4UfOKV12Q
	Od2FYhOS6LtqFEORoRg+v3RO5BgyMd4=
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
Subject: [PATCH bpf-next v2 1/2] bpftool: Add HELP_SPEC_OPTIONS in token.c
Date: Wed, 17 Sep 2025 11:47:31 +0800
Message-ID: <20250917034732.1185429-1-chen.dylane@linux.dev>
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
Acked-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/bpf/bpftool/token.c | 1 +
 1 file changed, 1 insertion(+)

Change list:
 v1 -> v2:
  - strdup(mntent->mnt_opts) once per cmd/map/prog and
    remove another strdrup/free in print_items_per_line
    in patch2.(Alexei)
  v1: https://lore.kernel.org/bpf/20250916054111.1151487-1-chen.dylane@linux.dev

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


