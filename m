Return-Path: <linux-kernel+bounces-734653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACA8B08462
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4D9565402
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 05:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7462147E6;
	Thu, 17 Jul 2025 05:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKy3RGCg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FC4212B0C;
	Thu, 17 Jul 2025 05:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752731699; cv=none; b=TXxky6bbrFnN/YjFTtWaSa0LHhmKiLozTsPBRR0vg6pKcms2c+mOzvODg0/jt5epek67Gbdf7SE3/ainxTGmJEh9aseqNR4q+SOhjZUfcuXVczw7OTa4K3eItpYTRDqHZIjboPvE+QHlI9/MYJzxkt8rwykepLTI3gT5JafDfB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752731699; c=relaxed/simple;
	bh=5dKUsHzkX+n8nsnRzImhzFTCp2iFjuwVjkIGRzZyPD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lfP//OnHgVRc62kTNCYo18uduAj+Ru53qpKDtPCgBkSsbYgjAsb6kn1/JI9QyvA5Md3SOrFy3NrQRACpnfehPogc/s4223rASgAuV69O+LwG8MlfMqqRw0tOO3RFFCsM6Lv+y/cVO4QJ9q97EWyKDXCJzoZ7BpBvZrVRhhfX/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKy3RGCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D06C4CEED;
	Thu, 17 Jul 2025 05:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752731698;
	bh=5dKUsHzkX+n8nsnRzImhzFTCp2iFjuwVjkIGRzZyPD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKy3RGCgzPHZXIc9nbFtuOwmi5jZcwD7aOhMeRQgNDkABLEyEKDHd/1V6ildUpIWM
	 2Agu/4yIQwBXJ/SYIwmrnrn7ETJdPf2aoiusELHVvEv7r7/gDC/eE19OkthhzZW6Vc
	 kM8lb3io83q10oY8D0/Nwc840EsCPOhTlp2bwQMmhM7XCLWhjRighIZRLm65MvtPAT
	 dXQu0pz+3f4c9s0FUNsceaRqHHdrjh3GnP4xAlsblds4nNDlkzmykj/gJWh2aUFOVb
	 G9Kk6dPHZVZrfWYOHtmmwfSmSys7Eg6qTEOT8N5a+x8JePbqCqUxz7VH4lxZRKsjFF
	 pPwDEihVowHvw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/4] Docs/ABI/damon: update for refresh_ms
Date: Wed, 16 Jul 2025 22:54:48 -0700
Message-Id: <20250717055448.56976-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717055448.56976-1-sj@kernel.org>
References: <20250717055448.56976-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new DAMON sysfs file, refresh_ms, on the ABI document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index e98974dfac7a..6791d879759e 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -44,6 +44,13 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Reading this file returns the pid of the kdamond if it is
 		running.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/refresh_ms
+Date:		Jul 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the time interval for
+		automatic DAMON status file contents update.  Writing '0'
+		disables the update.  Reading this file returns the value.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/nr_contexts
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.39.5

