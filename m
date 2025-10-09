Return-Path: <linux-kernel+bounces-847471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7751ABCAF0A
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 23:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB99482E61
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 21:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C325028725A;
	Thu,  9 Oct 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsZJkrSA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F048286D73;
	Thu,  9 Oct 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044858; cv=none; b=QJ3FjFwjS+o8fz0ut8iHMNMdwNl+3shJwS+Q0RZT3JFDhjBpFEYuy3441Ww/KMc/KDI4MLjqG19DatiMXHECX7wP7GgVJvIqNMG1ZvYfWEn25NRQVjF19FZY0bJ6Mqg3am7F5u8DTuakjBT1OVuBoGojgorner4nKJorUzROV9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044858; c=relaxed/simple;
	bh=iYqIOlBPNnXz4smGK3ct25Bt+psvuvYa3PTnXBMC96s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gddHo9y2/XyPQN78J+Y8yZVcXjs4EeqraS+M2XqCTWcEUCXP1sGiwMXV5KXQ6vRoBiNoVa/O4LkBc5zI/9rA/0pXmINDandEXCiDa4pW0fg34yhmGhvImEd13GRATYd9HawgcG9/DXTEmEE0qdKTbPiRqJ5f0E28poe0QtuvbR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsZJkrSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB18C4CEE7;
	Thu,  9 Oct 2025 21:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760044857;
	bh=iYqIOlBPNnXz4smGK3ct25Bt+psvuvYa3PTnXBMC96s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fsZJkrSAFJEJJLDKmJO2px5MRhIl/Y8a7LsCOSzS7pxW2kFDEh3zUtAwA9i4z4DYp
	 kBTw+4KcA7oK5MwKs8kt8e7NK2/kuKXjgOZw6v247C1WtsBRi8CqhlyqAfDaFaTlYQ
	 pY7FlQ3Fd5Vz0YMqidMIdbf5IMu9kqm02eeCentFFzIQZ3dEQQ+vudU9CoYtwaa4QF
	 76WXDGgRzNgxzwkAdsd4ivR2yEhYN2CFNGv0gi2BTwyx/nD7reQ1PxOJEO/UY3J9JF
	 AoksE2Nzi70gRjv9xWY9PMfkCc5u95OzyR8WtyTUu1xmrGPNd32pcClBsIGqzDozMX
	 XT7W/T/8j3vXQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 08/10] Docs/mm/damon/design: document DAMOS_QUOTA_NODE_MEMCG_{USED,FREE}_BP
Date: Thu,  9 Oct 2025 14:20:40 -0700
Message-Id: <20251009212042.60084-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251009212042.60084-1-sj@kernel.org>
References: <20251009212042.60084-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update design doc for the newly added two DAMOS quota auto-tuning target
goal metrics, DAMOS_QUOTA_NODE_MEMCG_{USED,FREE}_BP.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 80354f4f42ba..b54925ea78e9 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -564,9 +564,9 @@ aggressiveness (the quota) of the corresponding scheme.  For example, if DAMOS
 is under achieving the goal, DAMOS automatically increases the quota.  If DAMOS
 is over achieving the goal, it decreases the quota.
 
-The goal can be specified with four parameters, namely ``target_metric``,
-``target_value``, ``current_value`` and ``nid``.  The auto-tuning mechanism
-tries to make ``current_value`` of ``target_metric`` be same to
+The goal can be specified with five parameters, namely ``target_metric``,
+``target_value``, ``current_value``, ``nid`` and ``path``.  The auto-tuning
+mechanism tries to make ``current_value`` of ``target_metric`` be same to
 ``target_value``.
 
 - ``user_input``: User-provided value.  Users could use any metric that they
@@ -581,9 +581,18 @@ tries to make ``current_value`` of ``target_metric`` be same to
   set by users at the initial time.  In other words, DAMOS does self-feedback.
 - ``node_mem_used_bp``: Specific NUMA node's used memory ratio in bp (1/10,000).
 - ``node_mem_free_bp``: Specific NUMA node's free memory ratio in bp (1/10,000).
-
-``nid`` is optionally required for only ``node_mem_used_bp`` and
-``node_mem_free_bp`` to point the specific NUMA node.
+- ``node_memcg_used_bp``: Specific cgroup's node used memory ratio for a
+  specific NUMA node, in bp (1/10,000).
+- ``node_memcg_free_bp``: Specific cgroup's node unused memory ratio for a
+  specific NUMA node, in bp (1/10,000).
+
+``nid`` is optionally required for only ``node_mem_used_bp``,
+``node_mem_free_bp``, ``node_memcg_used_bp`` and ``node_memcg_free_bp`` to
+point the specific NUMA node.
+
+``path`` is optionally required for only ``node_memcg_used_bp`` and
+``node_memcg_free_bp`` to point the path to the cgroup.  The value should be
+the path of the memory cgroup from the cgroups mount point.
 
 To know how user-space can set the tuning goal metric, the target value, and/or
 the current value via :ref:`DAMON sysfs interface <sysfs_interface>`, refer to
-- 
2.39.5

