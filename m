Return-Path: <linux-kernel+bounces-870431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B190DC0ACE2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 16:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 349FD4E9F10
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9302E92DA;
	Sun, 26 Oct 2025 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UQaFgV0j"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4DC2D94B2
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761493246; cv=none; b=EQ8ezQBKkWsFje7uehTzKcphHqcR8eC1sc1qwpDJM/eOfi7+HPpr0JzU9ekiBQyFqkzGXEHmwErVJKkst693p+m4kKFTwrEhGLri5fmSdSloXaKrc2BSBJ8Nn4as1izs2fEFOsb603zqBIQk623d15D35yTOtAO3crtAB2VKRO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761493246; c=relaxed/simple;
	bh=s3IR1Rj8Ag8368KG/w3P+8z2VWNFjQ++UP5BSrFxkz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCv9SzVUno5qYgO1CdU/kmq3Ldoyh4qQTCW+lN+qaSpwFDHdDX32bBFhLpm8vejg8gw481P3NSQ1u5Vg48qNS6mrui6i8pgjEEL7r8VRKHFvd3cRJD7ZQQu2IYWK+1aiXIMMRZf0zHQE2BdZ7OvqCO8rvEvA4W99vPpM0F28xto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UQaFgV0j; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761493240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aN8oN34iZoLpzlmFeG3uFVvEYqjiK8nko/J9BQXfRs0=;
	b=UQaFgV0j7ML9bj3I2e0WrNsGpkRYULMaUbidt6LMoqhzh3nA3pqLkKV+S017bfuXE2cPyX
	PTQ2Hql8YFXCEEa1YQM3xHo8jm2cxTRr3zCF2H5aUUfpE6G0N/Kyfzptq4PDMYzoqeItBy
	yhU3rP3z9MXWPNiPAG5IB/gP/ue5QmM=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	linux-kernel@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf v3 1/4] bpf: Free special fields when update [lru_,]percpu_hash maps
Date: Sun, 26 Oct 2025 23:39:57 +0800
Message-ID: <20251026154000.34151-2-leon.hwang@linux.dev>
In-Reply-To: <20251026154000.34151-1-leon.hwang@linux.dev>
References: <20251026154000.34151-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

As [lru_,]percpu_hash maps support BPF_KPTR_{REF,PERCPU}, missing
calls to 'bpf_obj_free_fields()' in 'pcpu_copy_value()' could cause the
memory referenced by BPF_KPTR_{REF,PERCPU} fields to be held until the
map gets freed.

Fix this by calling 'bpf_obj_free_fields()' after
'copy_map_value[,_long]()' in 'pcpu_copy_value()'.

Fixes: 65334e64a493 ("bpf: Support kptrs in percpu hashmap and percpu LRU hashmap")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/hashtab.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index c2fcd0cd51e51..26308adc9ccb3 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -950,12 +950,14 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
 	if (!onallcpus) {
 		/* copy true value_size bytes */
 		copy_map_value(&htab->map, this_cpu_ptr(pptr), value);
+		bpf_obj_free_fields(htab->map.record, this_cpu_ptr(pptr));
 	} else {
 		u32 size = round_up(htab->map.value_size, 8);
 		int off = 0, cpu;
 
 		for_each_possible_cpu(cpu) {
 			copy_map_value_long(&htab->map, per_cpu_ptr(pptr, cpu), value + off);
+			bpf_obj_free_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
 			off += size;
 		}
 	}
-- 
2.51.0


