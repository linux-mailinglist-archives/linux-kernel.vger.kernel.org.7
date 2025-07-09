Return-Path: <linux-kernel+bounces-723387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209B6AFE654
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3804E04FB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1201D293C5C;
	Wed,  9 Jul 2025 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZrvwtho"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63016293B7D;
	Wed,  9 Jul 2025 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057828; cv=none; b=NV4aNHtgg32etiBR3agkmpFkj5WlIAlpUOKN4Zf3JEXOdFDh+yae5q6rSubXLlXCOAym7R5KmQf8Oi0PU9cdYxjHWeHuliD8e6vN2edeGHysgiSDSY25sBKpV8UnM2ZK6S+TFJuyC9VjZwaUjavXBvMSuzxzdZrMbXKG8cdbQns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057828; c=relaxed/simple;
	bh=AWKJtvgbxB4/51UABL1HB+dWVfB7Jp45KPK9z3a2k94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pEwXqQFusQHG2gTSz9DAUEVa4UX9oJka+/06bjAN5kQK2L8hY4SvmVJtr72LLmzKHbVARCXiRTyrUqb40I4LQKCtQSZ6qJIB+0gUOU1IH983ynfCjAyqs2BxyMJ7Bs2ymkS/Heip3PvuhUEbwb6cUQ9AJ9YuIBXbKpZpVYJr6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZrvwtho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15799C4CEF4;
	Wed,  9 Jul 2025 10:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057828;
	bh=AWKJtvgbxB4/51UABL1HB+dWVfB7Jp45KPK9z3a2k94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aZrvwthoLY90ktVVD5CMwjT51mF5Y57TLgH+5lrf8UUnalhbqLxP+6JxkEdUmIbT4
	 dcYbdjcztwPkPRXfigEy/tQQ5iqNuGo0c4hD6Xa3VQb9WNhMVUxoezwxeERhcubCYD
	 VT3htg5FZ07miHKbNQAQKmkmAGH5wLE4564mD3hfym9I7+kXsRbqMX9nl4e/TYuROS
	 f96YkJeeRaQ4TSDx5tZ5x4hn/NokatZfRiAo+EUFG9cwPcCQqiDzEW+GqKHt1ZhnWb
	 r5VkatXuwBJpyU/O89VKDLCuzCy2PcpI8kDCWNBlhrDqKMniOviTbm9RkCoiuM1+0h
	 qBolOEbe1FDFQ==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 13/15] rcutorture: Make BUSTED scenario check and log readers
Date: Wed,  9 Jul 2025 16:12:13 +0530
Message-Id: <20250709104215.15562-14-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
References: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Because the BUSTED scenario intentionally executes too-short
readers, this commit enables the RCU_TORTURE_TEST_CHK_RDR_STATE,
RCU_TORTURE_TEST_LOG_CPU, and RCU_TORTURE_TEST_LOG_GP Kconfig options
to test the resulting reader-segment dump.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/BUSTED | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/BUSTED b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED
index 48d8a245c7fa..7d75f4b94943 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/BUSTED
+++ b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED
@@ -5,3 +5,6 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=y
+CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE=y
+CONFIG_RCU_TORTURE_TEST_LOG_CPU=y
+CONFIG_RCU_TORTURE_TEST_LOG_GP=y
-- 
2.40.1


