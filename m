Return-Path: <linux-kernel+bounces-865548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09455BFD5BA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A64918828D4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B90286D56;
	Wed, 22 Oct 2025 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DglCSK7/"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB902566D2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151584; cv=none; b=kkWyEZCdtNfQwnkY7RhuEM6p5ijYWhat8+0LyWY44IwBKrsnorOIKMG+M7x919F1z+RLwHTiK1hi7bEp+jJ1BzQ+jl13URJRc4aX5rg07cBWwHz4zW3bBY9Q5nvLn32SCdJMoFNYZkcjBX2WJG4fdmCz817czxxSianUx/nefJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151584; c=relaxed/simple;
	bh=kHipxjPKdfKyZjusmW/Xen/+cggiUczv4HaoaLIzec4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eHwxk/zZtqjYTCbCM/Rwu9iAH8yfUh5goxxFqs22DuGhT05tvic8Vak5mSErCjHrNuyvIsw0tC3TpUpGCtKBscMVHDA2J2+hhoY7RsSd0U4T6j3k2EdVE3iGjVWwgmbHP68KAzbLvAkKbTS/cpChj49CdpfQk3ZIYunHNZ/gE04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DglCSK7/; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761151571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YR3WnEjvrHHzguVdZ+7J/zHY0xABiTWzZ7eMT7M8+Do=;
	b=DglCSK7/VAhxn7bUjD72797plehx2OIH1weyvIRcgUYCfvrG/Xa2C5H1ADDd+geZrS3grI
	sAxp1WAOBdxuaxSPhxH5JlVTsuopnm/x0zh2fwb4Q9d3uzgOm2YeoJ0iI3r2YfCPXvOyXE
	Fg8WURLOUskyp2geh7U9T36eIACet50=
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
	luis.gerhorst@fau.de,
	colin.i.king@gmail.com,
	harishankar.vishwanathan@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: KaFai Wan <kafai.wan@linux.dev>
Subject: [PATCH bpf-next 0/2] bpf: Skip bounds adjustment for conditional jumps on same register
Date: Thu, 23 Oct 2025 00:44:55 +0800
Message-ID: <20251022164457.1203756-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This small patchset is about avoid verifier bug warning when conditional
 jumps on same register when the register holds a scalar with range.

---
KaFai Wan (2):
  bpf: Skip bounds adjustment for conditional jumps on same register
  selftests/bpf: Add test for conditional jumps on same register

 kernel/bpf/verifier.c                           |  4 ++++
 .../selftests/bpf/progs/verifier_bounds.c       | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

-- 
2.43.0


