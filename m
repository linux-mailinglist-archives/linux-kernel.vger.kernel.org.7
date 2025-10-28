Return-Path: <linux-kernel+bounces-874053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03790C1565A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB541B256EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410EC341AC8;
	Tue, 28 Oct 2025 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NjJ8ru2j"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B998433F8DC
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664819; cv=none; b=S1HsrnY1e7uo4UubBD3Y+67+eBo0HjJx7YlbPZ2FUiyWY0Hi8DdsrP0vQKm5KLECWnbO+T4JWSMD9cC8Gn6Wu61pU2vjSvfWwtTkEPOcTuBqNiis6TJbmHnvJGn3p2qu1GmWbMs5fem4TXoQ6sK8b6mwa4aqZBXl6NSbbARR2BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664819; c=relaxed/simple;
	bh=KiMvJaTew1YHNiKfgdPOfLoDPJZ+GN7jRXSQJ5trAzw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qatvehqhY9BaSQ+clO38kXvyPOU7vW4HQ56LpbeWF41+PbX2ACtJOEbuNAeVROUqdLWqUNbcA1Ia2ZqJ8Hy1pYhuX0XNzXUDPzk8erw8lNT8HJDU9d3/hMKMhBQpAAK26QbSy3DquXt9Wto9ZOf1Dfex1yFvVTGI7Y3hvsL9EgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NjJ8ru2j; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761664814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YyYvf+fvSrlf/zx6Wpz6IBTQDiN9neqrcFDocO0D1sU=;
	b=NjJ8ru2j+6b8cBmW16gfEcMGb2HbcgvPS8khZJaxO/7eesTFgZ3CkJMGiqCPhjUyV09UF4
	imbIaaSn2ELHHqkTVu2upRIM333J+x6xFLaJyhnFcDVKTgZi62tW23mNj02YrYC64qJTkk
	zwDI/61ZxmSwr7BOPoys9FSco2fy9Ow=
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
	kafai.wan@linux.dev,
	harishankar.vishwanathan@gmail.com,
	colin.i.king@gmail.com,
	luis.gerhorst@fau.de,
	shung-hsi.yu@suse.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] bpf: Fix tnum_overlap to check for zero mask intersection
Date: Tue, 28 Oct 2025 23:19:36 +0800
Message-ID: <20251028151938.3872003-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This small patchset is about avoid verifier bug warning when tnum_overlap()
is called with zero mask intersection.

v2:
 - fix runtime error

v1:
 https://lore.kernel.org/all/20251026163806.3300636-1-kafai.wan@linux.dev/
---
KaFai Wan (2):
  bpf: Fix tnum_overlap to check for zero mask intersection
  selftests/bpf: Range analysis test case for JEQ

 kernel/bpf/tnum.c                             |  2 ++
 .../selftests/bpf/progs/verifier_bounds.c     | 23 +++++++++++++++++++
 2 files changed, 25 insertions(+)

-- 
2.43.0


