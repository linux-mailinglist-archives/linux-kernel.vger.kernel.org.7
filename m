Return-Path: <linux-kernel+bounces-762334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AB2B2050A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF023A4443
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE36F2253E9;
	Mon, 11 Aug 2025 10:16:59 +0000 (UTC)
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A6E1DF97F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907419; cv=none; b=swF7EKpiVrXABse5cbW84/4VKt4fZcGS2OkvlS1vcBtq5SOkJJuEjGI3Zgq42fW77PyMzQGqwfKE0Nks1YyMLtEMvB5rhWzkDGpZj8w3YJS7FJERACF9DW0hHbJpj/OCEiOQ/ajhIc8aFgTcRZ3Oh5dSUJe+rgR4m2S4+ztEyuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907419; c=relaxed/simple;
	bh=LSE9BMAlVcfDDCkIHpx1eHqXTO0CSRsabrkNnNPLaV4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=bYlp1NZSmAc9DfZ+qy/Qg4iDg2mpYCv7T8ATJebfoGecbKrd62FvFHDBad/eQq+f2ax0BUvfr0zae4F/Jk+fUu8zH2xuQSakqEqCWTMZClIwgzSHup4VXm1+ty8qigqmc9kBQ3VECoYikHp9REhpH4rQG6MjpFLGUhjm0Ngig/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
	by 156.147.23.53 with ESMTP; 11 Aug 2025 18:46:53 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.31.96)
	by 156.147.1.121 with ESMTP; 11 Aug 2025 18:46:53 +0900
X-Original-SENDERIP: 10.178.31.96
X-Original-MAILFROM: chanho.min@lge.com
From: Chanho Min <chanho.min@lge.com>
To: Steve French <sfrench@samba.org>,
	linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	gunho.lee@lge.com,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	Chanho Min <chanho.min@lge.com>
Subject: [PATCH 0/4] smb: Backport UAF fixes for v5.4.y
Date: Mon, 11 Aug 2025 18:46:35 +0900
Message-Id: <20250811094639.37446-1-chanho.min@lge.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch series backports four fixes from v5.10.y and later to the v5.4.y,
addressing potential UAF issues in the SMB client implementation.
The patches have been adapted to account for the directory rename from fs/smb/client/*
to fs/cifs/* in v5.4.y, ensuring compatibility with the target kernel.

Paulo Alcantara (4):
  smb: client: fix potential UAF in cifs_debug_files_proc_show()
  smb: client: fix potential UAF in is_valid_oplock_break()
  smb: client: fix potential UAF in smb2_is_valid_lease_break()
  smb: client: fix potential UAF in cifs_stats_proc_write()

 fs/cifs/cifs_debug.c | 4 ++++
 fs/cifs/cifsglob.h   | 8 ++++++++
 fs/cifs/misc.c       | 2 ++
 fs/cifs/smb2misc.c   | 3 ++-
 4 files changed, 16 insertions(+), 1 deletion(-)


