Return-Path: <linux-kernel+bounces-790639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4D4B3AB34
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC398173773
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6141B258EF5;
	Thu, 28 Aug 2025 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bl6VdbE4"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F4011187
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411289; cv=none; b=nORAuJlaMv9A2WrUj2G2NkMiHuzNoIQu5P1IXcLo9wpdvALkAeJ+T92n7/ijWxfrZaPuWJ0mPK2TMCOGAIyeU1BKNF0xQePl/km/NzHkzp3x6FVuv3da1IpmG7kpNey1sQvQaqGDXrRIQoSKTYH0rBINLwfOzGO2R3+ypbr0bSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411289; c=relaxed/simple;
	bh=wYeCqqVUC6w77K1AciZD4diNIIglWHzDxrq0IrZT66Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CcwVhNdMr112afZWweBU22yz7+1KtpveTeiTRDzxagTY0FwZYT12g6kEGxSTtXLdSvi6gw7FPb0PiPe8qjqLKkmBepXX7QhCJ9p4TopmzjTmDORzR0nmzrPPDZG3kY0sEa5RtOlGjAN5HHscIdhsxdIW9fhl3xflMqvSxqKID6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bl6VdbE4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7720f23123dso1369941b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756411286; x=1757016086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DoX+D3KaxG6mhPRJt1jiYUNQEj7P2IZ5gRQ1rTq/NJ4=;
        b=bl6VdbE4FVygHIUs+iSDg0xGj7oyt0ErFzR446moJFT1lxmh8K8hZ+3sM24BYsxLzs
         xx3AJmgnxvU+eLGw61c147mBzZjSUITeY8+CeQHzW0EvZcJ972l1ktXJy+IoV6j6+8HK
         3esl/u7+LrNwEuPkzDtGhuvxIxSBtHiH5Y718gKgx3kUMmoeLebk+YyAfiNrlT+wtcfn
         km6gu8l1SkSggCQL++9LhObowhY6A6aYxUCxM6WCsoAwyYfs8LkIdmm0pFk6dHpre488
         SAFCPXMpWIdwbMUjAUKBAwQu/kx4odQ6JCUD8qqrbLdaj9pfRwsbhBVaRQz5wYGXEpD9
         Ls1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756411286; x=1757016086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoX+D3KaxG6mhPRJt1jiYUNQEj7P2IZ5gRQ1rTq/NJ4=;
        b=I59WJ/mB3/MSo5F/yarahELi+cy4IK/6/C4/bVjHm6iNsTgplWT4RilKbwh3aadCrM
         mM+SuEpYruvP5hzYDcTxB/8otvthDTGhUFsnJjXATXgHG/ojWu9fqq+E0mIumY3ju9ga
         Ca7P1b7w0UOhLU5eHt3767W+e4dPaatLPi6NLQ059lmyMP9RpUXkBrogpKYL9Re4j5R7
         A0TOkoq33/GY6mSuBRGUlLmb37eJndPyeccj/0wRhpl4+XpjpFFOxLPI6nII0yzkU23m
         tPzHoIEgWYFI0gOKNuImRs1RlQdZyUzalGMu/ehlkvwyy9YJO3XviUdQ1rJOJ39BSMCC
         3sFg==
X-Forwarded-Encrypted: i=1; AJvYcCXk/GvXo7oPkP/xdmofkNUUmjZEgGlSNeH/w1sK9FZ8hx2iFacUS3RoHL6rcczEHoZ/clwkB6WlcrmIRRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAZ9lQiRglsoC5GbYYPk4TYrOAWZoLSj8q1azSYMqgIkP4s7Dz
	Zbgf/CYDHRK5GgwCsTxmbH65mnP5Hvu0XiFP1iphdqsmKNcSgJ4MkHma
X-Gm-Gg: ASbGncuNprUtaSYjtp8/sdf67IsUuxn+6KJS4/qNtnvIBh0kOTCp1QsW8m0eZz3qftU
	pLCaQEGMDYmthloONwWK/H52kQDJ557vs67GiZFckYRBoqqVdXnksmkrv03goufYdrar3iV73VA
	QYTQI8mFZ6BftDp+M/ntakgnrAaOmVI0dCdIUG1lC9Z0RjD0mn+bJWF1lYNVekX1+n2FxiEKXXY
	3iT8FXCK/Mb/dHSLiI0XbhXiMgQmS6XdN8oM+GWx/1VcuN3SZlQXpMjMxr4ePXFMgJQcHm1zs72
	UB7piWF7CRlN4Fx6pc89tjGPL8wl8sHw0st2uZl6upwvf3l4U8Kxr0kNTmL7CmkgZaF5rWMPh94
	t14xMWSU9fuEOvWNLlf1kZqiav/JcfBGNSBAqjD7cIMJNcLAX56SXlw==
X-Google-Smtp-Source: AGHT+IG3iIFJQWz+lf0lUAPD1+rtke3zrgqOtQQFIlzOWjMf2Xm3ZfvP61CcKTGB/JPPwSX1rFi7+g==
X-Received: by 2002:a05:6a20:7290:b0:23e:19fd:e18f with SMTP id adf61e73a8af0-24340daf747mr33344878637.35.1756411285859;
        Thu, 28 Aug 2025 13:01:25 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7722a2af911sm279861b3a.23.2025.08.28.13.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 13:01:25 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panthor: check bo offset alignment in vm bind
Date: Thu, 28 Aug 2025 13:01:16 -0700
Message-ID: <20250828200116.3532255-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fail early from panthor_vm_bind_prepare_op_ctx instead of late from
ops->map_pages.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index bad720f23eb70..6dec4354e3789 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1222,7 +1222,7 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	    (flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) != DRM_PANTHOR_VM_BIND_OP_TYPE_MAP)
 		return -EINVAL;
 
-	/* Make sure the VA and size are aligned and in-bounds. */
+	/* Make sure the VA and size are in-bounds. */
 	if (size > bo->base.base.size || offset > bo->base.base.size - size)
 		return -EINVAL;
 
@@ -2447,7 +2447,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 	int ret;
 
 	/* Aligned on page size. */
-	if (!IS_ALIGNED(op->va | op->size, vm_pgsz))
+	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
 		return -EINVAL;
 
 	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
-- 
2.51.0.318.gd7df087d1a-goog


