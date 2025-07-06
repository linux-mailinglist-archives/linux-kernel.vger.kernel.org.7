Return-Path: <linux-kernel+bounces-712505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE90AF0A86
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 07:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102264E4810
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 05:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC5423644D;
	Wed,  2 Jul 2025 05:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQEAORAv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41398234977;
	Wed,  2 Jul 2025 05:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433372; cv=none; b=URzfnsrlKytOi54MmPH9hbZCAiQCOcOu5ajijcEi8faerTKEj2VZuKrOtphk5wFkH8Tvp6njvqy+ilUHtpCsyvNau8S8yVJSsCTIOkRGWJeOFcFGmJkFHKClmO5IGwBV3BevdZTX6v6aZML4lTkMwPCcQdgsjOEWtS0QNFkMWyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433372; c=relaxed/simple;
	bh=6b488vZ2iWxqTR7YVUSrEsxdrssHAMUzwsCzJVA6L+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZSb1KzKm6d21QcvQzgxDpF0I1sQ4g30najvOszR8GZExpLKLOraLCGyBKsy8aA5TmugenQcy3kXnhngwcKYXW5Pj3MtPoZcQyd9louIK5z6mAg9sEtijkQzhp5+quxTO4ixbSAfW7g8f0C/AKa6FQsT4Q0GAVDX+P641mI5V31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQEAORAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6799C4CEF1;
	Wed,  2 Jul 2025 05:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751433372;
	bh=6b488vZ2iWxqTR7YVUSrEsxdrssHAMUzwsCzJVA6L+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQEAORAvP4AsILpEleQnoxqKrsi6DUC2+7vLAcIYswnyM2L5NdIouXEFNUKb2e6Sq
	 HIZLWYietZawQkVFcLiYcJvWhfuLzCIWmrnkgFCxWUxeflirqu8d//zy13SxGaHL4b
	 2XIkbvWwG7JywD3vYWhJW5gzcZgrhQaqk8JPra8D1WYWKl1tEkwrpDVQLcCP1U+Nve
	 6NsKU0dm6rHoSG01IlX0uj4HtxvbMYfZSCGoAntUQsmRMgQdUWp7RkjHusf6k9rtyJ
	 V87Np9ggUsWoswSyWDFxpkLxRu6NjVa9C5hcOA/udGF+NRspB0jeoSFZaaHIKEcByZ
	 Y54lc7kekLprQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 5/6] Docs/ABI/damon: document schemes dests directory
Date: Tue,  1 Jul 2025 22:15:57 -0700
Message-Id: <20250702051558.54138-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702051558.54138-1-sj@kernel.org>
References: <20250702051558.54138-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new DAMOS action destinations sysfs directories on ABI doc.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 5697ab154c1f..e98974dfac7a 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -431,6 +431,28 @@ Description:	Directory for DAMON operations set layer-handled DAMOS filters.
 		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters
 		directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/dests/nr_dests
+Date:		Jul 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for setting action destinations of the scheme named
+		'0' to 'N-1' under the dests/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/dests/<D>/id
+Date:		Jul 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the id of
+		the DAMOS action destination.  For DAMOS_MIGRATE_{HOT,COLD}
+		actions, the destination node's node id can be written and
+		read.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/dests/<D>/weight
+Date:		Jul 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the weight
+		of the DAMOS action destination to select as the destination of
+		each action among the destinations.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/nr_tried
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.39.5

