Return-Path: <linux-kernel+bounces-831914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35F2B9DDC5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9B04A7E43
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5C22E9EAE;
	Thu, 25 Sep 2025 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nGlhSU7U"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A222E92A2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785562; cv=none; b=ml8wD3FQTOqbWFxAtYY3EzmggKou/UxobgtIJHSw1ZKhfk6rAgw37kq2NAOzd9S48d7So+vLuQrSEIXaYEO9inURS06KvlcwipgJacflx7naEoZQzLVrHHqLKbutuZlanIfhc1lbmxDS3R+nQMasG7q3sT0O3JjDoR3surj21Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785562; c=relaxed/simple;
	bh=blyNHmuvK5kGnlxOCzg2gdtM2hZQ9dX7LUMRDOy/Yhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rM108puHl8QC5E1Gd7zliQ0cCtoD0WeHAbTRosEr6ZBsXlHkXHgyLrKpOm0wVd1cga0fR3MRiL6O4umv+1Rr9lWl07z6Y2LX5Ngo9B44tJr75zX/JW04IfmpEpTQSgewUHO7cZ9krsKUbxGUkDlOZQXtYA/lYm6L/Qq3sZiwyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nGlhSU7U; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758785552; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yQVwO6hUbDs4yUnm9nVZ1yfHrPmI7sVRMQiWliYRxhs=;
	b=nGlhSU7UNpY7AMIJJjbT63ilyu9tAyM+KlOmO7NSEvUGYaDm6b/jnTwU5WUhCJ6Ni6vQtxsgg99HB/lk7H+CuC9cySADH3584PeyvaMMYT+hlpVByGkwP8iQg6XCJGNIZ7iRqI8CuK2JOWueO/QK8DjetEeYny0525kDd7+Upxc=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WomvkLG_1758785549 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 15:32:30 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org
Cc: david@redhat.com,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com,
	hughd@google.com,
	willy@infradead.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] optimize the logic for handling dirty file folios during reclaim
Date: Thu, 25 Sep 2025 15:32:10 +0800
Message-ID: <cover.1758785194.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we no longer attempt to write back filesystem folios during reclaim,
some logic for handling dirty file folios in the reclaim process also needs
to be updated. Please check the details in each patch.

Baolin Wang (2):
  mm: vmscan: filter out the dirty file folios for node_reclaim()
  mm: vmscan: simplify the logic for activating dirty file folios

 include/linux/mmzone.h |  4 ----
 mm/vmscan.c            | 33 ++++++++-------------------------
 2 files changed, 8 insertions(+), 29 deletions(-)

-- 
2.43.7


