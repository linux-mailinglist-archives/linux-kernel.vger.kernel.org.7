Return-Path: <linux-kernel+bounces-676065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEC4AD0717
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 18:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0716E7A7162
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 16:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AEE28A409;
	Fri,  6 Jun 2025 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q9TSLEi/"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946B228A1F5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229134; cv=none; b=nSTlCfD+HoOzPl/6fiivDuw1zo7vw0ftvmivMRaajjepyqB6Ja0+Vj5ZfjLaHip+qgszBWfZgn2Fv9Lrb55c32xLwRLk3dC2FgTn9ARlzRqXxdpSGaPc1/hhFb7ZU4hrVkNglVssXxFNAA+JKH3gWF5/7WWYiUjAW+fpxiSB+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229134; c=relaxed/simple;
	bh=YF9/AavsaRHygSWjgLMhFwrqJkPsB2jZwCeKsDG1gxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l8KmVudaJ1/ZxWdQq/dcCsqYM8LNX+H+q+KJ0kiuIr6ynAMxRNAJVkiVjFC7p3vs8YgWbRkt9jgdDZ67YJk/tS+UR5DS5/9pGTA4Bal96IfVJxe6jy/T5dJNLXzCfuSYtuat4mayruxwWeMVHW8cBByo9qkxOEiMg8Nhhgoze3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q9TSLEi/; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749229130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6K3C8Hb8prT3+vpDpvIO7nVxOTcfcLoynL11pSoIQ0=;
	b=q9TSLEi/YCBEcJr1YPrVwdOKnQt/o4YOvjs54EKMCpeaeo+6lZpA37JonQgRuAUEmC29yZ
	pzdRP+tjZJh8Ktex/PDcjZznTLrtj7kTbUNsxtWyNCXJFZezCxKJu4D4T461yxVKwOPDq+
	brnnqQDUy2e98iA2fyQlKe9WFlGYSeY=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	qmo@kernel.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next  3/5] bpftool: Display cookie for tracing link probe
Date: Sat,  7 Jun 2025 00:58:16 +0800
Message-Id: <20250606165818.3394397-3-chen.dylane@linux.dev>
In-Reply-To: <20250606165818.3394397-1-chen.dylane@linux.dev>
References: <20250606165818.3394397-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Display cookie for tracing link probe, in plain mode:

 #bpftool link
5: tracing  prog 34
	prog_type tracing  attach_type trace_fentry
	target_obj_id 1  target_btf_id 60355
	cookie 4503599627370496
	pids test_progs(176)

And in json mode:

 #bpftool link -j | jq
{
    "id": 5,
    "type": "tracing",
    "prog_id": 34,
    "prog_type": "tracing",
    "attach_type": "trace_fentry",
    "target_obj_id": 1,
    "target_btf_id": 60355,
    "cookie": 4503599627370496,
    "pids": [
      {
        "pid": 176,
        "comm": "test_progs"
      }
    ]
 }

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/bpf/bpftool/link.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index cb67ce4eba2..03513ffffb7 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -503,6 +503,7 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 					   json_wtr);
 		jsonw_uint_field(json_wtr, "target_obj_id", info->tracing.target_obj_id);
 		jsonw_uint_field(json_wtr, "target_btf_id", info->tracing.target_btf_id);
+		jsonw_uint_field(json_wtr, "cookie", info->tracing.cookie);
 		break;
 	case BPF_LINK_TYPE_CGROUP:
 		jsonw_lluint_field(json_wtr, "cgroup_id",
@@ -900,6 +901,8 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 			printf("\n\ttarget_obj_id %u  target_btf_id %u  ",
 			       info->tracing.target_obj_id,
 			       info->tracing.target_btf_id);
+		if (info->tracing.cookie)
+			printf("\n\tcookie %llu  ", info->tracing.cookie);
 		break;
 	case BPF_LINK_TYPE_CGROUP:
 		printf("\n\tcgroup_id %zu  ", (size_t)info->cgroup.cgroup_id);
-- 
2.43.0


