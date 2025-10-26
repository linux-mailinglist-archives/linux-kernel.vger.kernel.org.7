Return-Path: <linux-kernel+bounces-870457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BEAC0ADDF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D263B4006
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 16:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72D52236F2;
	Sun, 26 Oct 2025 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gtF5Mof7"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C51610D
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761496724; cv=none; b=okE6FQZD+Yf4k3i9PY0lnm3Ne9V6BCWY6ANPFSB5crsMtfUn8EW/pxxwYH1F29vwfPsT9SD7UwTMFAYrrRJa5RXj2RSMtVmH/4gVlrZfv+/VUC42zB5Eg9xqMsg3qG1zNo6BACOgvqLOOMeLGDLcTQAnnwiWNqHWUrod5dA0N8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761496724; c=relaxed/simple;
	bh=Sj7EQgk8COjO3En+I+4AkavknHt8j+R1rN2b1IapuN4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MNKDRxW/ZbsmRNyTWkb2bi9dR6pe5sLxx6mjNSNuBV4X0G9JxR2DVgyZfiMjA/NtFk77s4dFVT6YwhzeHNpfV2C/7AUs5uZfDgC+s+2If1bnhW2/fvZltomql+PwgLrDJmPnwT9sDC44NF9YElGqDJHXWEqRF97/1r7IzFXWjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gtF5Mof7; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761496719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fEkR8ho0e0lDa+wJBLIyXVGdc4q/yccEqcF5GhbP2yU=;
	b=gtF5Mof7PMvxtGDGArhqFttn4RhPsRee+89QxyKDY0n2f/xvLGMeKVUxnA3MAfkfgGrGC3
	jd3cSqKm1EEcMOaIMRWYh79YTNKtc7su7WA6UF+yI8Lbr/V6g9SFh3e5qUbzLuceucGCHq
	7X5XSU1DDP88E/k6ROO/e2Y+QGRzUAU=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	paul.chaignon@gmail.com,
	m.shachnai@gmail.com,
	memxor@gmail.com,
	harishankar.vishwanathan@gmail.com,
	colin.i.king@gmail.com,
	kafai.wan@linux.dev,
	luis.gerhorst@fau.de,
	shung-hsi.yu@suse.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf: Fix tnum_overlap to check for zero mask first
Date: Mon, 27 Oct 2025 00:38:04 +0800
Message-ID: <20251026163806.3300636-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This small patchset is about avoid verifier bug warning when tnum_overlap()
is called with zero mask.

---
KaFai Wan (2):
  bpf: Fix tnum_overlap to check for zero mask first
  selftests/bpf: Range analysis test case for JEQ

 kernel/bpf/tnum.c                             |  2 ++
 .../selftests/bpf/progs/verifier_bounds.c     | 23 +++++++++++++++++++
 2 files changed, 25 insertions(+)

-- 
2.43.0


