Return-Path: <linux-kernel+bounces-869919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 948F7C0900B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 14:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6770B34DEF6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38EA2C11E8;
	Sat, 25 Oct 2025 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pgieb3JZ"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51F61F5838
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761394051; cv=none; b=SuVLMNIulcz70hyUjetNFxFG9d1d//oWlyNAt/441YkD5OrprjxG1pFn3J+CsII1WyZPCDqyJBc8Il+fOUBtSFsGUGKSjaKWm/Tq56sDAUHJBE+Jchzkfrzz/Blf8bszYlLWTvu8j1GoPbVhYx/tyrIOdiLIJYuhnHwiLIsr9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761394051; c=relaxed/simple;
	bh=wZJADg3XnZ6RwpXOOcROiNVqbWnU5p1aLlzgqnZjIX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JjLm8qTIkPWq44+GtBF2/2EGl9hofF3Wme5tv04OMVOFcXQBvOqoURcNeiARtYe4I1dMrE/yniIX8oT/CqFkYhmjBIDPWwVp7jEgKpNCY/jYADFg7PjVlQ4ikL60wJGu+qe+L8oT3Ax5t0zU+p2AD4yaZgMfFgZYLQUwdXbRvbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pgieb3JZ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so2926032a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 05:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761394049; x=1761998849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GvErBYG+vAV0vX5EwaTO9Q2laL6zacG+FzbGHb5fv/4=;
        b=Pgieb3JZPxoUx175vGf+R47vp01daXZgOR9vtGZBwjzxwPlDVMQE4kc3TLCsQM7Clt
         +PLd+PoD7+F/PjVEwPi/AvFAkr2aXLDX0fGAp0JxlU/HCVDkWihMpM3ImwFlMMJCOy1f
         1yXpLO+XEvn2U+M6/FZnnMdKC/uGwZ8AUWUI5RxtPb5kHRb7iuypVNzxYXO9ewvIwtMJ
         gOz/FBdZLjMq/YBnZv6ObiuibUn2PN2iB0LpmSIbeijbNj0lynePu9XXWWHvfYhetTDc
         5eWNqGuluBv5xsYbgcV1FXHS0eBXBc0rFO8QShn2nxyIxkQ881+n31vX52WvuUjbZStk
         j5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761394049; x=1761998849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvErBYG+vAV0vX5EwaTO9Q2laL6zacG+FzbGHb5fv/4=;
        b=d+IxOJ7egK2qLL9x/Us6Dn0SDNP9s0egXbAC8mqpLkBsBUlpNOCOY7fafMRrW82vn+
         LNU5Uuehgcg2I9AI/YG8J8uP4j2ZDYOZKi5op/+2yWIOEIxoJYtRaf1RRPFdw8EWXWo6
         vWxArODGMbUzwdPlRKIFojmbzgeuAvRmnbgkZDBAK20ChZCujxiq9DMPcwWbpLkj7ItQ
         mam2C3sxCYEqn/xK5FqvYhVJbeXI/34s+CHXxcYQZQEjZA3lM4yQqdv2YScG2ya8o7lG
         vOgc9eOMq7V5dl1EYZIp/6nmrH6gP6EE8Iie6xC+H3Hz1NqqoRo02b5iQOiUkDwS0HhD
         1pkg==
X-Forwarded-Encrypted: i=1; AJvYcCV2d2fUr80MGS87CXdkumczSlh9f6UOjz+4qvRdYWt5CblGZzv+ZOPv/6r0fs5a/ypkYR84AF4SLhHd8BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG1ISkXbPes+HHTGXi/Qc9gTVPoxTtxayrI9z6qjez18UQmz2I
	K1rtFgDDCU7NaecvxM3AlousLuHCzdH0jvvSQctN62Oz6hRMsupNKSW4
X-Gm-Gg: ASbGncsS1qRQ7YY4dVx4hlZsL/gYIy6wUST8ZKntwt+uoovUJ4NZm1qzS5tFLqpmozA
	NOU5O4lPbZlATMwSYRrGpK0GEZsOOb9ET2W9IFQeNR3HYEqUWC90kK8N4RlEJDvK61J7qJS9KhR
	DX+DsL0mkQDeGkfafK0d3KNVFT486WnOaJiLNBJG58lXaFdnBNy6MlULUN9upEoK+32bk0mLv0R
	nbH6l8Emho8/mNuNPvbL8MBTuvkuba7BOkyXG1kiKUlcNpa+cC+yLldUfZwcGFZptCYw3t+Y8oX
	VgFSNVj/6F3kbF4anFWe5NipoHS60ySapRDAADewiRR3KiqQygfL6tUn1CvdsgtxuYan4+5/P1G
	XjwAuctgcukrDSXf1eY3pQkW4F0OLTIdydcxZ9+QcFp55VRLu/rWLlAuhhemOOFmdkzblMcF0E4
	jVpQJG6nN86QRJYFxt
X-Google-Smtp-Source: AGHT+IHAYxum3m94nffwJVgTx2pWh1WNJorhHj73gH4JXy6dRTn2aqTnLu+PFuJH09vGy3wCXje9sQ==
X-Received: by 2002:a17:90b:28c4:b0:327:c0c6:8829 with SMTP id 98e67ed59e1d1-33bcf8e4f50mr39883472a91.24.1761394048970;
        Sat, 25 Oct 2025 05:07:28 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fee405b6asm945846a91.3.2025.10.25.05.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 05:07:28 -0700 (PDT)
From: kriish.sharma2006@gmail.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] hv: fix missing kernel-doc description for 'size' in request_arr_init()
Date: Sat, 25 Oct 2025 12:07:07 +0000
Message-Id: <20251025120707.686825-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kriish Sharma <kriish.sharma2006@gmail.com>

Add missing kernel-doc entry for the @size parameter in
request_arr_init(), fixing the following documentation warning
reported by the kernel test robot and detected via kernel-doc:

Warning: drivers/hv/channel.c:595 function parameter 'size' not described in 'request_arr_init'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503021934.wH1BERla-lkp@intel.com
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 drivers/hv/channel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 88485d255a42..6821f225248b 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -590,7 +590,7 @@ EXPORT_SYMBOL_GPL(vmbus_establish_gpadl);
  * keeps track of the next available slot in the array. Initially, each
  * slot points to the next one (as in a Linked List). The last slot
  * does not point to anything, so its value is U64_MAX by default.
- * @size The size of the array
+ * @size: The size of the array
  */
 static u64 *request_arr_init(u32 size)
 {
-- 
2.34.1


