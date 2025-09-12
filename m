Return-Path: <linux-kernel+bounces-814075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1138B54EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416207C7223
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C2330DEAA;
	Fri, 12 Sep 2025 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUsetn50"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4158A30CDA8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682768; cv=none; b=Mg4IuDPmWN+oV/zIbgVLmWlQGCZLe+9PpBkmTr8Q2TA39olI2m5T2v/xotcEjbfdc+k1Ea/G61YxMkWyT/UsY2ygP1dtZ07V5UhoxMd+qWEacWxa0jav4ptvbgeXqaS2AEap4rWX8Mj7tDYwcGVL7gk4gvTRs74Z5Q314i8T2Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682768; c=relaxed/simple;
	bh=ML+J1hzOhRH6oLAIpeMUgWQCTl/SPVGx1igrx3kjYAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VInl6bi8seSUvIeSQ4Myui+JVMRQtAH2rL+1tJCmx4ifPB/AuYwhC6H4cGIvpSBn0w9yNrpwYw3mTKws1hNkJ9k1Zc75dGdjfVu9QFVStEWLWq27jHhAd+BV+7JA6dNdDlHei9nLzsSQSYqM2av9habcXN/O2814q1rT/8xZvQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUsetn50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E82C4CEF1;
	Fri, 12 Sep 2025 13:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682767;
	bh=ML+J1hzOhRH6oLAIpeMUgWQCTl/SPVGx1igrx3kjYAI=;
	h=From:To:Cc:Subject:Date:From;
	b=jUsetn50QXYMgLngbAO0JYlGJIl2s6YDbcROdrTWzrAYjEuJwqwWONijbMMMAsrvn
	 hHjLVdGN+NS+ePhiD4tU/bBN5LgohI/Q03VhuHtuNdEZ8BjreKAEqtgHU73GrkEZ81
	 dpvmgspsloMuA0TSPLpoJUFKA5vl1G14CmtUlZfBCcj0FB4bDl9TxIYnj/prP11QAR
	 3oUyAw/pxXqjSDahGqS1BId5JgOXrUe3lVPyE1/XuscGYK0eesGOOtWWdqP3A71F0S
	 I8HJ6tuWzC6VR6s4esnWkCFV+hpyOfqS5btHbWjBWKOyuN1ZGwRbaPfT205Zme48xj
	 NJVJ+0d6zRksQ==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 0/4] fastrpc: fixes for 6.17
Date: Fri, 12 Sep 2025 14:12:32 +0100
Message-ID: <20250912131236.303102-1-srini@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srini@kernel.org>

Here are few fastrpc fixes which can go for 6.17 release
If its not too late, could you please queue these as 6.17 material.

Fixes include:
	- fixes around usage of fastrpc map and
	 memory leaks around it.
Thanks,
Srini

Ling Xu (4):
  misc: fastrpc: Save actual DMA size in fastrpc_map structure
  misc: fastrpc: Fix fastrpc_map_lookup operation
  misc: fastrpc: fix possible map leak in fastrpc_put_args
  misc: fastrpc: Skip reference for DMA handles

 drivers/misc/fastrpc.c | 89 +++++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 31 deletions(-)

-- 
2.50.0


