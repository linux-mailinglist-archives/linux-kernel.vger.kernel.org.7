Return-Path: <linux-kernel+bounces-823967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35013B87D47
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA935811A7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F127B23C8C7;
	Fri, 19 Sep 2025 03:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YU0Wq6FX"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923AB16DEB1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758253731; cv=none; b=cf5NN8h/PX1kcgB0DuiQVlf6CkL5iUj0UsYCqG05/FjqtLEnyJa753d2AN8BzEEElUklSN2eZVF1iSzzAN8sLt8p/K4/MSmWK1fzyvCqpyapK8YC1Bn1If7xq4grxQ9qOcBx04RKi3UTctqxX2QqUXHvEOEHc2zwYdzFaPnDVXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758253731; c=relaxed/simple;
	bh=c1TKba1vvn2H3b40oqPAj/0PJ8nIcIAxRBiwdNbvGeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SeLHI7wiDV7q4utMKdYA51n7EkX9kTCE9hgc+3UilPGCN2JIIi1BPoEMsSzzTIDdNLAtk6LJBCQKx1k4QJ2SGdyQOju2/z8tchF9f+5fcmZo9YBmA6mMtZFD603mirvIwao3DT1d7IQQrIYM0qiDmFAu5DM6lc6eBfIXu2ARZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YU0Wq6FX; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758253717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GZkxiC1oU8jlftWTj5wHZtzSllvcNZu+cfil17d3+Gk=;
	b=YU0Wq6FXgmVkp3X2oQ1N/Q9ricu6RgHcycdVvEbOMnNwUg9tcJqnxVCeeB6/5U3CcS5lXs
	yHxmbwtEVP/Vewch9wGZVdCQE3jNO4gt6ABWuL+JANnFHqpBaJY1IWqoXt/+n04KjcGKE0
	PvvcMqPpsa02RaptjvclDpsOrYBxBTc=
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
Subject: [PATCH bpf-next v4 1/2] bpftool: Add HELP_SPEC_OPTIONS in token.c
Date: Fri, 19 Sep 2025 11:48:15 +0800
Message-ID: <20250919034816.1287280-1-chen.dylane@linux.dev>
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
 v2 -> v3:
  - Replace PRINT_DELEGATE_OPT* macros with functions.(Quentin)
  v2: https://lore.kernel.org/bpf/20250917034732.1185429-2-chen.dylane@linux.dev
 v3 -> v4:
  - move the declaration of variable "i" to the top of
    the function.(Quentin)
  - move the declaration of "opts" and "value" inside of
    the for loop.(Quentin)
  v3: https://lore.kernel.org/bpf/20250918120908.1255263-1-chen.dylane@linux.dev

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


