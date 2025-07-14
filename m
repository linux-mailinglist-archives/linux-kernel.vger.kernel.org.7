Return-Path: <linux-kernel+bounces-730632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591ECB04761
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FACD4A2E06
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46FA275113;
	Mon, 14 Jul 2025 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qii506Yg"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6461B2E36F0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752517481; cv=none; b=VWybyHB4HSjlke4qtb8KEkPc5kpeYoNMaMPuMX03rtFbCBhw61Iu5WD2WWZeLAxcgDHlC3jsTbRtLFIEaeoQ1ECp6nDHVTXwrENz/6l/yRoA6ZsMc+nK5R6JF7DswbZEnjTWIbboioPYRpDk7rPezz9Hvx5TtDBGtfHc6YntdeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752517481; c=relaxed/simple;
	bh=3E7gXFskk2G7EJxNtMcRtoGxNqWlNIw+mxncFtLtnSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qx9xe7d4GVVYqYt3CH7blF83YsBVao6hUu3iDaoVR/k6kVAGFCouPHtZaZukcMc9RtIaZ4Y4Ymt9TG4qgo+iRzFgDnpurNJnPEs481urKJvRUK8aDCWFpzQOW7w/PrVK1FBRS3dfH8PFaKPCK8n4poT5VUUFMoYOoh0Ee3LC+5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qii506Yg; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752517465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yq4NCXu4M+aQJdh0LkzpUgSDQ7zQfhc3wp7bQR0H5Ks=;
	b=qii506YgbRUYoN4aMHRMXoU9KZz3IlAJB7pBw6VpT8YSIb0FiybtqejCyZFRoho4KLqIAw
	AbeLrP4R8ujYAtj8WwDPQEOQAtB8clVbmFb8bNZSr02xATZxNhsrTs43qkWUJ+AtrVOvOZ
	vs9KRcTTSrNaFsaD5xMQ0bCgvVqEICU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Replace deprecated strcpy() with strscpy()
Date: Mon, 14 Jul 2025 20:23:57 +0200
Message-ID: <20250714182358.238422-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/bpf/disasm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 20883c6b1546..c8f657237e97 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -349,7 +349,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 					__func_get_name(cbs, insn,
 							tmp, sizeof(tmp)));
 			} else {
-				strcpy(tmp, "unknown");
+				strscpy(tmp, "unknown");
 				verbose(cbs->private_data, "(%02x) call %s#%d\n", insn->code,
 					__func_get_name(cbs, insn,
 							tmp, sizeof(tmp)),
-- 
2.50.0


