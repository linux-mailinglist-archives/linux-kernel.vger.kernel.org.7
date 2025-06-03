Return-Path: <linux-kernel+bounces-671241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FBDACBE7E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 04:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFDB93A54D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 02:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9393F14F121;
	Tue,  3 Jun 2025 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nc4Bx8+1"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B222F32
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 02:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748917605; cv=none; b=Hcv9qpo49md+N4LvVJ6emTZmN4x5Cc2vTT5vcaXMbtSw/ABcHdgIWoL35hp4uSAYEEm9DKg6ZiHr2p2EK36Nd/n2B0+fnwXOWPLr3ILxbnZeRMgpCX+sv/W9q4gG8EgcouOiriep1egZefFACZH1syObKkLYyygRcqMfBMevHA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748917605; c=relaxed/simple;
	bh=fn6Gypx0jppX4ZfV/wU6Lot+KTQW1fMN2RLSLn7ESP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gRiPL2lFiYtHBQINbe/cf6Y1DpQV6me/gsCEsnfjfipNLkVfH8lTkn6OHe96lC7DrX2Y0oqh+b8f8xBq5nniA6+Wmk3yV2IoDeQCWGpuNZ8cXu7mKj6gK+UOSlx4uDYGVFWMgHpIRQS1eiKcAAR1dXYGc4B9CBL5qhUz2yG75jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nc4Bx8+1; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748917601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oo40gIonSC9h0uhsHSMEjkgSCyqiY1FN2iI8Vf98Jlo=;
	b=Nc4Bx8+1GnZaZ4mR8REY299LpkynqQhfZ1zDczIf1O7hmm6xvRFm37ypXdpgmt91rkDWwb
	M++BQsmGWmmnwWt3qgPUkCe8EhPcWNC1+kWkj3efggSwzbP+5n5hcpNBOfYzBk7UmQMVBG
	oVJyqqcwRKd9yqTLRtsbOUSGIGwUhzI=
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
Subject: [PATCH bpf-next v2 3/3] bpftool: Display cookie for raw_tp link probe
Date: Tue,  3 Jun 2025 10:26:10 +0800
Message-Id: <20250603022610.3005963-3-chen.dylane@linux.dev>
In-Reply-To: <20250603022610.3005963-1-chen.dylane@linux.dev>
References: <20250603022610.3005963-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Display cookie for raw_tp link probe, in plain mode:

 #bpftool link

22: raw_tracepoint  prog 14
        tp 'sys_enter'  cookie 23925373020405760
        pids test_progs(176)

And in json mode:

 #bpftool link -j | jq

[
  {
    "id": 47,
    "type": "raw_tracepoint",
    "prog_id": 79,
    "tp_name": "sys_enter",
    "cookie": 23925373020405760,
    "pids": [
      {
        "pid": 274,
        "comm": "test_progs"
      }
    ]
  }
]

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/bpf/bpftool/link.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 52fd2c9fac..bd37f364be 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -484,6 +484,7 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 	case BPF_LINK_TYPE_RAW_TRACEPOINT:
 		jsonw_string_field(json_wtr, "tp_name",
 				   u64_to_ptr(info->raw_tracepoint.tp_name));
+		jsonw_lluint_field(json_wtr, "cookie", info->raw_tracepoint.cookie);
 		break;
 	case BPF_LINK_TYPE_TRACING:
 		err = get_prog_info(info->prog_id, &prog_info);
@@ -876,6 +877,8 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 	case BPF_LINK_TYPE_RAW_TRACEPOINT:
 		printf("\n\ttp '%s'  ",
 		       (const char *)u64_to_ptr(info->raw_tracepoint.tp_name));
+		if (info->raw_tracepoint.cookie)
+			printf("cookie %llu ", info->raw_tracepoint.cookie);
 		break;
 	case BPF_LINK_TYPE_TRACING:
 		err = get_prog_info(info->prog_id, &prog_info);
-- 
2.43.0


