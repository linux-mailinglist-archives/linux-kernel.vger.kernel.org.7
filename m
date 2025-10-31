Return-Path: <linux-kernel+bounces-880111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618CAC24E75
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13AE3BFBC5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED0633E36D;
	Fri, 31 Oct 2025 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEUTepPw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72C233E352;
	Fri, 31 Oct 2025 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912038; cv=none; b=pRsStxIZJW0fuuvU58QYCN9vjHLfqZRhaNxQXxmbahE7kVl8z49VhwYW2Qx0B9Yb2Eba69htOEEWDCoOV8zkKmqz8GDD+Xi+1GbInLvLqdCr9ktX1hZ7NqS4sSqC0vDihdOLECMX7/cjndkOb42THc/qAp/MQbKG94M1Q5RXN+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912038; c=relaxed/simple;
	bh=5Y2K69DPuTxufr2/30uL7COrThaw9oWJXaibDgLkv3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFJRfG9zAQeLRidrG57NvcOnBjgHwFPgZceeDNFh/NpGYSFXIpBaEKGKriZM3AF3xD2ECm/QNCLknaFowz8W9XWhBH6AmWC9ZEj7OkTS4UXkzJ7EbIen8Hc+6bB6bSyOyJMsieQRnST0lHxyJ62Aqmjb2SX+PHAzBAEfwDKr0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEUTepPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5CFC4CEFB;
	Fri, 31 Oct 2025 12:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761912038;
	bh=5Y2K69DPuTxufr2/30uL7COrThaw9oWJXaibDgLkv3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vEUTepPwhkQmpxfK8CEXqfwhXgYhIcPm7nNen+UsWtqrisuiz5Peyp5WXllkTGtLs
	 J4Jc4g7fyHIII5OnqUtgmB/NFzNUsXHDAJuNR0PYwGMIiEogZz62hWd+xR42vFW02A
	 HJbM29Zgy8cdeC3XtjFVcNCzum2H87VpT3TK/vA+7obu12IZgwJVD1mlqt8KyVisXJ
	 wje2R340p3eZNFfpUfDsVdYqtRJzxgY65Me5QsT5tkygf3+zUxV+2CTHMHybHAK53V
	 vMvkJNaaC4lwGb8NO1npdlC1mGOGwAntkZBZ0+BuGwum2RuqSrQvYxaMjuuRzV+REP
	 Dbk+q+MujeA/g==
From: Philipp Stanner <phasta@kernel.org>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 2/2] drm/todo: Add entry for unlocked drm/sched rq readers
Date: Fri, 31 Oct 2025 13:00:15 +0100
Message-ID: <20251031120014.248416-4-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251031120014.248416-2-phasta@kernel.org>
References: <20251031120014.248416-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Runqueues are currently almost everywhere being read unlocked in
drm/sched. At XDC 2025, the assembled developers were unsure whether
that's legal and whether it can be fixed. Someone should find out.

Add a todo entry for the unlocked runqueue reader problem.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 Documentation/gpu/todo.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 835e799ddfe2..7d7e9e3741e9 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -909,6 +909,20 @@ Contact: Christian König <ckoenig.leichtzumerken@gmail.com>
 
 Level: Advanced
 
+Add locking for runqueues
+-------------------------
+
+There is an old FIXME by Sima in include/drm/gpu_scheduler.h. It details that
+struct drm_sched_rq is read at many places without any locks, not even with a
+READ_ONCE. At XDC 2025 no one could really tell why that is the case, whether
+locks are needed and whether they could be added. (But for real, that should
+probably be locked!). Check whether it's possible to add locks everywhere, and
+do so if yes.
+
+Contact: Philipp Stanner <phasta@kernel.org>
+
+Level: Intermediate
+
 Outside DRM
 ===========
 
-- 
2.49.0


