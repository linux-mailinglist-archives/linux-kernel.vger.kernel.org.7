Return-Path: <linux-kernel+bounces-813997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC80DB54E14
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DB03BD992
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E8F3043D1;
	Fri, 12 Sep 2025 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="go/mh72T"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979D63043B3;
	Fri, 12 Sep 2025 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680266; cv=none; b=AadwjvXgGm3Le/8VjvwtwKgJ1zxlCZYxYi9DMrN/8At6eOkzYnT5+tZouaIcHH04/YvsVooREiMZq9iQEIv8JOrQVEy4/335X+a41T4LguqcF6W22UPSwhRHXigGPS+GZ9ZuMy/H8JWcvL/89u5MQihi/kxztaqHaBJ10NJF8MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680266; c=relaxed/simple;
	bh=elK2OVkAWNH11BVauJrIqWGv2pByY9tyO9tpXTGnLK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pEfFfmOYQtamVE5kXjkcplvPaP3AHuz/j8ExAOUSEufgilGW2EWFkxvBPQ5PDNJ8IEgj1AFCap8x4I41vXxoEZo2OscU/Yj6g0opaALmymfeu5KJ0ONDblkCFv3wnsUEXw8pbH/vIe5NlTpE+ZywDXAeDndUZNxhj5v7NHlnabQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=go/mh72T; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757680262;
	bh=elK2OVkAWNH11BVauJrIqWGv2pByY9tyO9tpXTGnLK4=;
	h=From:To:Cc:Subject:Date:From;
	b=go/mh72TQ1Tn0MxfuBEPSlQZlZ2MAaU5rge56NRLiCE9EFtlPr/l+dtaxj/bq+WMz
	 tcmOVPQt9BIoyXzjAEcICgIw1Dh0/DW1AB6HldjxO6mA4JFGS+UBf+Es5Nv+zaBAdv
	 4+5nlkpXS5MhUD2BW9xzvfqmWe9VM28nfqOdCxydzA0iqJusFNDFeCq2sgghEdkl5R
	 tnZSB4cENJySrHJ7dP8PxBLgqh7TWGFY1m3SGdFnWL7f+0lnjOaQroTrqqOm6J58HS
	 MEULQGyGsF0P2vMYTkTgdNX5qD/91P3Upl3zAP+R3x9CuJXWAVY9XEFg+MbY8oKbtF
	 7H7ESDQ3EI9kA==
Received: from mt.tail9873f4.ts.net (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4D29117E0927;
	Fri, 12 Sep 2025 14:30:55 +0200 (CEST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH 0/2] selftests/mm: Add -Wunreachable-code and fix warnings
Date: Fri, 12 Sep 2025 17:30:20 +0500
Message-ID: <20250912123025.1271051-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is trimmed down version of previous more generic series[1].
In this new series, only -wunreachable-code flag is being added and dead
code is being removed from generated warnings.

[1] https://lore.kernel.org/all/20250822082145.4145617-1-usama.anjum@collabora.com

Muhammad Usama Anjum (2):
  selftests/mm: Add -Wunreachable-code and fix warnings
  selftests/mm: protection_keys: Fix dead code

 tools/testing/selftests/mm/Makefile                | 1 +
 tools/testing/selftests/mm/hmm-tests.c             | 5 ++---
 tools/testing/selftests/mm/pkey_sighandler_tests.c | 2 +-
 tools/testing/selftests/mm/protection_keys.c       | 4 +---
 tools/testing/selftests/mm/split_huge_page_test.c  | 2 +-
 5 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.47.3


