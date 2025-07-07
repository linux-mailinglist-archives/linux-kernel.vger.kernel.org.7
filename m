Return-Path: <linux-kernel+bounces-720404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCEEAFBB27
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C27560124
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886B7264A65;
	Mon,  7 Jul 2025 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOwMvPRb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5635222A4F6
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914272; cv=none; b=MeTbM+vBLyHjUTRHkOujLbE1D8vb5h8Wj1cTSBdXx1Djk3g+coBgvvoIXXS7dzF+6By7VacGBoHmRP2uW4rM3itBqkLxmRdmx4YCF9X2Ec23BLogTlHF5+CsRSWoqAYiaQ/dFoTI8Y9I8imeDxpa5fkv97WodLxkAI67xirpqSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914272; c=relaxed/simple;
	bh=EmTkUDlNb+tqn2e+5n7sqpFH5cPgd2o3AaBFRlnlTek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ukAXJbYM/bkulAM7bFzxhZ+m1LUXuOQIa9T/tSQbPuNG6p1HFIte5iMoQvSLIh1Kw9MQL7t1HLV/CtGxjGOvRNDRIbiM7warWcxrAlEIDwqM2Xxo/tIG9AEOjzSQC9giBK6okG0FPiOkmWQ7SNp1B49iT7IuBIDEqTg1ljZiscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOwMvPRb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751914269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YwKSfy5lWqdY3iKsOrU51HXlg+YCbXQbnmmhGVQTCoU=;
	b=KOwMvPRbQLhlvTo8pyDN15wfVoT+WWH8+z5tJDlRTDTd7e5sX6Utk8hcKapiiyNVReO4bN
	y/sduEhS0USOrDP+cXlIagM/qJA3/JS0AW2kGXUt3Aruzk/PCffDIvVRQU+4WjjPfnY1SH
	v7FZ/7EIgAZKMqK+mvkYiNV+CrVgvLs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-76OGRBWVO_STno-pmGohkg-1; Mon,
 07 Jul 2025 14:51:05 -0400
X-MC-Unique: 76OGRBWVO_STno-pmGohkg-1
X-Mimecast-MFC-AGG-ID: 76OGRBWVO_STno-pmGohkg_1751914263
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05CA1193585F;
	Mon,  7 Jul 2025 18:51:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.96])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6343519560B2;
	Mon,  7 Jul 2025 18:51:01 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: david@redhat.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	shivankg@amd.com,
	sj@kernel.org
Subject: [PATCH v2 0/4] mm: introduce snapshot_page()
Date: Mon,  7 Jul 2025 14:50:42 -0400
Message-ID: <cover.1751914235.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi,

The series introduction will follow the changelog. This is against v6.16-rc5.

Changelog
=========

v1 -> v2
  - Include is_huge_zero_pfn() patch and use it (David)
  - Move free page detection to snapshot_page() (David)
  - Changelog improvements (Shivank)
  - Added Acked-bys

RFC -> v1
  - Include <linux/page_idle.h> to avoid build error on sh arch

Introduction
============

This series introduces snapshot_page(), a helper function that can be used
to create a snapshot of a struct page and its associated struct folio.

This function is intended to help callers with a consistent view of a
a folio while reducing the chance of encountering partially updated or
inconsistent state, such as during folio splitting which could lead to
crashes and BUG_ON()s being triggered.

David Hildenbrand (1):
  mm/memory: introduce is_huge_zero_pfn() and use it in
    vm_normal_page_pmd()

Luiz Capitulino (3):
  mm/util: introduce snapshot_page()
  proc: kpagecount: use snapshot_page()
  fs: stable_page_flags(): use snapshot_page()

 fs/proc/page.c          | 50 +++++++++++++++-----------
 include/linux/huge_mm.h | 12 ++++++-
 include/linux/mm.h      | 19 ++++++++++
 mm/debug.c              | 42 +++-------------------
 mm/memory.c             |  2 +-
 mm/util.c               | 77 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 142 insertions(+), 60 deletions(-)

-- 
2.50.0


