Return-Path: <linux-kernel+bounces-627527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBEBAA51F3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 18:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576EF9E2EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 16:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C393A8F7;
	Wed, 30 Apr 2025 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ex2q6wUv"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105E2262FE7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031634; cv=none; b=GfLE9sbhWpp2OvcBK9W2SVhyTo7pwqbYvl7fP67v+FNdOwYrjj72ejB0Cfz9X8aFsSSvqBCPZceyEEEdCNVP3mSquDI06vnGQlfpclPwbPU2ZpqH9HhyjWWCWngFoAUSDQD5a7UzVW6FuVB6D8MyRuKskyMBhyU/pvwFjrwQGrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031634; c=relaxed/simple;
	bh=Z4+c36xlrpQnmEMOiKZcbo6zN4E7rBAyOguYrJB/StU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LwTY2YWgN3bihXbH2DCD+aE/5KI9iC9kZPyTdYpx4JcKShkz9v2StI71ec7uShdOFkrAm1WMVSvYHcL7swpTdHOrObAW+wwrK4G0SygbGX4eqlpeLlGGc7dgFjT0Tp4vWcCxI92DEUXiZv7WY8xRCNEc5FU7/G7tzXROw44MvIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ex2q6wUv; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746031621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WNUmJmzk1ISm5BdSoA14fep8NYFtReY+NRi29+VsNv4=;
	b=ex2q6wUvT9s8AxYBN2tBfv6sEpzwJ/MG85+lZ4hY7a66Q9/xh9DxNG4CnvE0hVvuvYGEcY
	PBzsXAyD4y2m633k7BgdSpuiXFnCIveJnxFrcMan1Ec4ZhR2jZSSGQ6deVqS+ypWZpEOTf
	gGMMICvfA9Bvp0MXQxGycZ2UW4qM3P0=
From: Tao Chen <chen.dylane@linux.dev>
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
	alan.maguire@oracle.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [RFC PATCH bpf-next 0/2] fentry supports function optimized by complier
Date: Thu,  1 May 2025 00:46:06 +0800
Message-Id: <20250430164608.3790552-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The previous discussion about fentry invalid on function optimeized by complier
is as follows:
https://lore.kernel.org/bpf/3c6f539b-b498-4587-b0dc-5fdeba717600@oracle.com/

This seems to be something that pahole needs to resolve. However, Alan
mentioned that there are many situations involved in this, and he proposed
that the available_filter_functions_addr can be used to find the address of
the real function. If we can get the real address from user, maybe this address
can be used when the function obtained from the BTF is invalid.

The specific selftest has not been added yet. I just wrote a simple test
program and ran it.

This is the initial RFC patch, feedback is welcome.

Tao Chen (2):
  libbpf: Try get fentry func addr from available_filter_functions_addr
  bpf: Get fentry func addr from user when BTF info invalid

 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           |  1 +
 kernel/bpf/verifier.c          |  9 ++++++
 tools/include/uapi/linux/bpf.h |  1 +
 tools/lib/bpf/bpf.c            |  1 +
 tools/lib/bpf/bpf.h            |  1 +
 tools/lib/bpf/gen_loader.c     |  1 +
 tools/lib/bpf/libbpf.c         | 53 ++++++++++++++++++++++++++++++++++
 9 files changed, 69 insertions(+)

-- 
2.43.0


