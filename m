Return-Path: <linux-kernel+bounces-821256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6D5B80DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9039F17D099
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE242FFFAC;
	Wed, 17 Sep 2025 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgGjZfBy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16AE2FFDE6;
	Wed, 17 Sep 2025 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125072; cv=none; b=ol79R8TT320b7eF8SdJP6XbODHiG1SxXQM4FtbhxNgLBTSabq06mPK08jzgyp2TNJaC+2GjzdvbgH/HMKO87TcGWl6/A2qVgweXWU/G7MDLCvYePkI27QOfUFbazx/EHI5uPqkOR2qJPqvOsSxKjCgC200sKY5/g0XAnbn9a958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125072; c=relaxed/simple;
	bh=ubUOhJ6Un4U7jOm0ZB8dqQKPXPIPBumzP6/AqYJ4GIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJ1ldI1pbAXWEL/XoHunsj1ZAnKOaC/igK/B3lZAxdzB/mu9Gfgp0UuHetj4t84LLQA1/vcYIrj8X96kkJ8ukzgy9FWWWqBWHxysJ6qiSqLKhH6eHtFL8CsH0TFALquZuBWbEm3xfu9SKiD+uqebtBdZuZoVcVJMCF0YfCcNb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgGjZfBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E1FC4CEF7;
	Wed, 17 Sep 2025 16:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758125072;
	bh=ubUOhJ6Un4U7jOm0ZB8dqQKPXPIPBumzP6/AqYJ4GIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgGjZfBy0vWWKGYxX2RgMNzS7YmeX4aFjAbcpNl26f4ir3h2pUrN8XHA41QgG2ipx
	 pnrmcCi6u8KgtCctJFkjsgna4up7bqcCB1kv21RaZlQViH1ZCwaQr+MEIQiB/hyKqs
	 cUFbMR00sOkVheFHfqlr0mXKkoR9QyDKYuVPTe+Me0gDVUFANGVwiVIHAQzHz8TX2y
	 XG2f4ydRh9AUur1mHwpTuLkWujQpVcw728vkEVV4sp0F9eMM7LraWZ9esYqGkAiZRE
	 4rVz5MgNk2V1RfpNCiShG7l/y+CwrTxUhJZY+4ywLkfS5q6DsJ9wfvCFFXiqB9AxwA
	 uyf9D74r5Xsng==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org,
	Song Liu <song@kernel.org>,
	laokz <laokz@foxmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Weinan Liu <wnliu@google.com>,
	Fazla Mehrab <a.mehrab@bytedance.com>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Dylan Hatch <dylanbhatch@google.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 23/63] objtool: Check for missing annotation entries in read_annotate()
Date: Wed, 17 Sep 2025 09:03:31 -0700
Message-ID: <410930ca7c6ae41231cc4758ceb70c696b1192e6.1758067943.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1758067942.git.jpoimboe@kernel.org>
References: <cover.1758067942.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sanity check to make sure none of the relocations for the
.discard.annotate_insn section have gone missing.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bea9b124dcf48..fdb83a0a592a3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2293,6 +2293,11 @@ static int read_annotate(struct objtool_file *file,
 		sec->sh.sh_entsize = 8;
 	}
 
+	if (sec_num_entries(sec) != sec_num_entries(sec->rsec)) {
+		ERROR("bad .discard.annotate_insn section: missing relocs");
+		return -1;
+	}
+
 	for_each_reloc(sec->rsec, reloc) {
 		type = *(u32 *)(sec->data->d_buf + (reloc_idx(reloc) * sec->sh.sh_entsize) + 4);
 		type = bswap_if_needed(file->elf, type);
-- 
2.50.0


