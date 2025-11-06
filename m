Return-Path: <linux-kernel+bounces-889416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9023FC3D80E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80FF84E69B7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDA130EF96;
	Thu,  6 Nov 2025 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgiegNxT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE8F3081AE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464568; cv=none; b=udF7Q9EZy3cggeaf1SvlrTjJJGUM/kSOAhB+BwmfAdv+mjTb8HxpQgX84ZD1Sq/2LK74U2pZGiQBZ8w4LdjpcZO6x0zFkNFn7fL6r9KAWMcYE7gHePyuCtPwfD2IPxAh0kEMc0DdQllAjOanOVsunT4AioRjPJ/QYqDBmoXwhBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464568; c=relaxed/simple;
	bh=tGGgVXSaRpY0JSAHiPTOxSgAae9U1GHb2Wx5eM3LJrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoKkTf9gLT0m/PAgbRTbrkbm15MdP6SL+jvYHW5wj8kJU/WxAzhR1lUlD5WYHb16BF1CYZ8mCk1DrtCDX6//MngOTwQBb1IjQ+zUjEhCP+GSZ5hBC9KvYMspVzlPL1V5iiSsy0CnCYYM/8L0UwCcodVG6sKk/9JVdBzYfcQ5guM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TgiegNxT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762464566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKmnrwBJh2QsEJ5R8DLB0opqHAQSJh/LYJ/G3AZFd2k=;
	b=TgiegNxTQgEAONyqlDcSOGj0bGKE+Y1uLUYpcxMA/CsA1iGQgqiTmHoGuh+nW8OFwu5uWw
	cjXSNs46YOC40AKW/qKLTcnz++bxTv9OhhWRQx6NYYsBbCbrDU+DF0hp/mB9oSbKQ4dUAC
	ySf2iQlxJbxL2C+BG0QRNFZjaI2iv/I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-hpWa3tvvNlG9IJXkEFsTig-1; Thu,
 06 Nov 2025 16:29:22 -0500
X-MC-Unique: hpWa3tvvNlG9IJXkEFsTig-1
X-Mimecast-MFC-AGG-ID: hpWa3tvvNlG9IJXkEFsTig_1762464560
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 968D7195608F;
	Thu,  6 Nov 2025 21:29:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A6E919560A7;
	Thu,  6 Nov 2025 21:29:19 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: david@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com
Subject: [RFC 04/10] drivers: i915 selftest: use pgtable_has_pmd_leaves()
Date: Thu,  6 Nov 2025 16:28:51 -0500
Message-ID: <297c6fa3dfc50c28c05c0974c86a205984d752ed.1762464515.git.luizcap@redhat.com>
In-Reply-To: <cover.1762464515.git.luizcap@redhat.com>
References: <cover.1762464515.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

igt_can_allocate_thp() uses has_transparente_hugepage() to check if
PMD-sized pages are supported, use pgtable_has_pmd_leaves() instead.

Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
index bd08605a1611..c76aafa36d2b 100644
--- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
+++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
@@ -1316,7 +1316,7 @@ typedef struct drm_i915_gem_object *
 
 static inline bool igt_can_allocate_thp(struct drm_i915_private *i915)
 {
-	return i915->mm.gemfs && has_transparent_hugepage();
+	return i915->mm.gemfs && pgtable_has_pmd_leaves();
 }
 
 static struct drm_i915_gem_object *
-- 
2.51.1


