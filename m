Return-Path: <linux-kernel+bounces-869899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 462F9C08F5B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 13:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5170D4E4A77
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 11:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104B42F5485;
	Sat, 25 Oct 2025 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="fnVhg5fV"
Received: from smtp.smtpout.orange.fr (smtp-76.smtpout.orange.fr [80.12.242.76])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75E8261B70
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761391073; cv=none; b=lUsVWBE4q2FeOChO7dBI2b/KQ0OZhF0pIbmdcaqqXWeAftwjfyMlPAxteGbS8b0S7B8eO4Sl4FkhQutz7CNqK7/Hr/gxOL5/XStGQ48055WXPQzG2m44PUIdBzCku5Kd4gRJSiF8PlzXYCIDjirSHwQskTGvRdskVMRVn8AV4vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761391073; c=relaxed/simple;
	bh=Lq2wWKt0qZqtk96S6i0E28snka6m7DlsRQdcmzY33vM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVXo2H1X6tUAHh0B3U2C7c/PjHxQvnyxHLLyR+K8UbsIXhgRTWFwxQn9rFanjI/rnSRaqSb9X6TKjoGdrU9X18xeiMD+56ncVVQLHKpfRhRDXYe3+EHTQN6D63cwnNcjqrgwCTdISANu/5CLQDKNcknAc1Bfp0JYSkt6ZdiuvDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=fnVhg5fV; arc=none smtp.client-ip=80.12.242.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id CcHGvE38qB8skCcHGvnEQC; Sat, 25 Oct 2025 13:17:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1761391063;
	bh=X7rEnnozJtAWUkQG2ZxrQbrzsJGLonDAIDW0QNmRp68=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fnVhg5fVlQYXsaZ1pkYCrOgnN5sDsjMQrdqaI4bSBDIiUTPx5S9Lc4ugkiGdE4v73
	 zKmzRUaJIREga6u/X1X6VQSJFAMb1CY53Afd/bDl3OMnGvVwqcVyxkKPak4irGCM5D
	 UnMXATaH6C8NnbnrsFQjrV1Bb85MRzqZnla3tAJeotydNy2i5bWvJkP5BH/14vYhXf
	 z1ef9o6k0ST8sUBLZRlCi6zzDxio6fezk9Y9yMU9ZQIsrh3+1hD512j+sRTAjK6G7y
	 Y/Ga0q0GYs7d5j947DYYTCGp3tan4wHrvlmJ4PtQ3tsLX+fmJ6aFmq+etrudF9vF3e
	 trTKt5WjdC4zw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 25 Oct 2025 13:17:43 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: a.hindborg@kernel.org,
	leitao@debian.org
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/2] configfs: Constify some fileds in struct config_item_type
Date: Sat, 25 Oct 2025 13:15:36 +0200
Message-ID: <cover.1761390472.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These 2 patches constify ct_item_ops and ct_group_ops in struct
config_item_type.

When/if they are applied, I'll send some patchess in each subsystem to
constify the corresponding structures.

This 2 steps approach is IMHO easier way to make these changes.
This avoids long series and cover-letter/first patches sent to many
maintainers and lists.

However, if you prefer things to be done in the same serie, I can do
that as well.

Christophe JAILLET (2):
  configfs: Constify ct_group_ops in struct config_item_type
  configfs: Constify ct_item_ops in struct config_item_type

 fs/configfs/dir.c        | 2 +-
 fs/configfs/file.c       | 2 +-
 include/linux/configfs.h | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.51.0


