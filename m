Return-Path: <linux-kernel+bounces-841909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58095BB8821
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 04:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CB04C1C61
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 02:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E98279DA6;
	Sat,  4 Oct 2025 02:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M18qvpkY"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B011427B335
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759543264; cv=none; b=mJl3OAcWoef9/v566Art2VGADxc1TD6A2Vr1Ow7ED4HG2QRObqVRoxkDpUduRirPkc4f+ssbvuxYwq1u+TiUqms00XM1kjLlOl7fLgzxgu3Rax892sjnG67OgatXghVYClbUzWAaUv8L9sjyX7wjKIV8IiSXRlS5SR3IAi/Ir5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759543264; c=relaxed/simple;
	bh=FNjMypG8qTRJuzjmhEr+eMaS0C6SaJRYPc+GhqGHshE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbITsJi1Kz2fEdYWNZsQLBoid4D0u2CZtVrQDp7Av2sDNiz8Yzx2A524mmRwqU6C46suLljFZZEeYC49cjBFAPu5GrYLYFFa/VssVJFTKSzC+bXw7eStVdj7qO8bNLvMfRmT9//A5fV3hQAgh0UVMd/5vVDyClVNyIUIBSObWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M18qvpkY; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759543260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVQD5hQkh9R4juqW+OSaRxBDn9iVxIqKll6yoMbIP80=;
	b=M18qvpkYfMjNmCtiTEiPATAjbVblWEY4MGz+kv0ihvqd7b0UdZTt9XZnl/SILAtCznHxIQ
	7qDn5IjgfU/RzZ15Fv2XUS1Wt4KUeRresPZ7ZNQUDEkvqvfoYfX/yjYb1n7e43+NF4T8GQ
	259mg5YQmTdFPKXFM8DPwkHHJa0sY4Y=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 5/7] lib: Give closures, min_heap config opts names
Date: Fri,  3 Oct 2025 22:00:47 -0400
Message-ID: <20251004020049.918665-6-kent.overstreet@linux.dev>
In-Reply-To: <20251004020049.918665-1-kent.overstreet@linux.dev>
References: <20251004020049.918665-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Give these config options names so that they show up under the "Library
routes" kernel configuration menu, and can be enabled by distributions.

These are needed for bcachefs to be built out of tree.

The closures and min_heap code originates from bcache and bcachefs.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 lib/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index c483951b624f..badcb5ca9efd 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -367,7 +367,7 @@ config ASSOCIATIVE_ARRAY
 	  for more information.
 
 config CLOSURES
-	bool
+	bool "bcache/bcachefs async widgets"
 
 config HAS_IOMEM
 	bool
@@ -646,4 +646,4 @@ config UNION_FIND
 	bool
 
 config MIN_HEAP
-	bool
+	bool "Generic minheap algorithm"
-- 
2.51.0


