Return-Path: <linux-kernel+bounces-890860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86343C4138F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 870714E8192
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EFE334C09;
	Fri,  7 Nov 2025 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="big0rlkc"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0524328B6C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762538781; cv=none; b=Q9J7m+DJGAs0+5H0bTAH1xitpfTK/Of0oJxs0FdGXCJ+numE+SSm+acY7lJiN+TukrUXhbCLO4IKLxevGIcY+FT14FtPo1L+fKh9gzAcpLT9KqzWJ7bSz7MKTdb+vKDC/vFGmNlDLpqbdfFisdue/YWewMGFr8oavrYpvyzm9Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762538781; c=relaxed/simple;
	bh=bXO08HsRuK2ScRN9CtJfzG/AzZSvuFwB4eE3T97HZ9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kxIkzfbXW06/Y/3CrtMNEM3S5T7bYVT5KpmI3gD0QswdTFiW7qK0jpjcA5WiFUOEeaWw9Tfvh1mVLsvMUo6O8/0SJvpoHdunie17OKGbAjbwPpcnVWyzO+0ZVHUzdDFxRQBHwfZdesO4ViPsuGp2Twi21bHLC/43t3SxDJGI/Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=big0rlkc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29470bc80ceso11276425ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762538779; x=1763143579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MfwD5o72GvI3Oi7do9Qhg/wh9m8XWbNc1QLnbh3PlwA=;
        b=big0rlkc7WNLVzD/A4i45Ipxctob4QdzUsE5hU+0C1HISOkGXZPKnOXGu33YzrL7aZ
         3RQ1rEUAwxKrJu3h0I4ZGVX/aZPdY0AbExEnCkuU1GRWXye0n4kZai7a6IHJYLf5TS3e
         EaxEfCF/bAJyrWJ7N19P3YrgXuIZQZiqkrAec63Q38M4NNtaeXjRd0t+iMhyyXlc/6rE
         mtHYWG+tKiP1c/z64djkLI3sf8JYNUpnZhtJr601yD1IMhY4cCw7aXQME87sgLnlVHeU
         veBVSe6TLjC28YWGGlDX0AKLM7kk06QCC8x0bDLY5tPYAixPUWf5KXqtoqpBKfvPgDR4
         Lfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762538779; x=1763143579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfwD5o72GvI3Oi7do9Qhg/wh9m8XWbNc1QLnbh3PlwA=;
        b=f46jgj8XR9Yqq1QTu1tkImLDV6zqJJqBgXVu54FanEvanBzF1jz7atS8q+fcKgiG5w
         kT32Gr0c8GOn5CgRQXobowXiU/D/4V5n6HIAIzVA+o0nzADm7Cd3yOKbXQIjUFzKi8zt
         iJihP/TFH1wgtlidLZnb9ZvYk//00a4KxEv6ZOOtb8y1T+7u5H1vICPRq1gqyntbtRc4
         TA0wZzfeMGf5DFqzIzGlpnkmMo+UalVsE+bPi8vbD/6RJp4rLybrHW5pvbbEEgD+JCzk
         3Q+ZCZjT5QQ1HaggPKP5h5I9Ekv2In6QFjLglKXYKFhbOmfo4iZrqqVlH214BqZxawmr
         6KLA==
X-Gm-Message-State: AOJu0YziNQGGlvcWZN1YueLPRBjpkGObwyEAbFFEgRqSehB78LOUSvSR
	r+CHyctaUmDPdJGhD9WSPcHgkBzHHw6dq4uKOnByDd+isJK3JwGS7AKS+VWq+eBo
X-Gm-Gg: ASbGnct1DsSBVzmi4HOmKeSNYjc+jcqnzTTVEJTIGfEYWf/ACCcc26OD2Pw3j6jiUWG
	Xm3OLL6/UDnRSzkzz0F4Asc6172s5wvr8W+0Z4VMMVEuLKxhx1MVhW17vkDjNAkHCv4NchdNyWL
	WHkLSV0z/RlUcymUPUz9EljNhy0iLq1nqe4vtPCiwc4zbbqv3kGkC3w8ul21ZvVYviwnM5Iz0qp
	Upd9kLdblq1JgDZdqGDFXQ4LAT9PGr7sAeKPqyF0o6Xm80JfnTFwdy3Olwm4VqVfXTXfa4429+D
	Uy+NCrF/MCe/NEvg4QL19w31TrsJg7e69AeXfDmcku5uXKt2+lh6E70A4/uX9NH7iawLOjHd96k
	YzmxHd38qNLZPteT17+Mu59JgdLMw1BnwO/mAQs8gt8q31off4k8bp5lWU8tUi8RWByUI6zo3XA
	qhi8Yttiiwin8TCHszd4NGIBhjuXGgTN1t
X-Google-Smtp-Source: AGHT+IGYsvRM3j8jIBPNh/tOz/jpy7JkvOUnVH0lWt7NtuZkUURJAGNXeQqSigiGcSls55h1u/VBUA==
X-Received: by 2002:a17:902:e80e:b0:24b:270e:56d4 with SMTP id d9443c01a7336-297e1d7667fmr4448295ad.4.1762538778577;
        Fri, 07 Nov 2025 10:06:18 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-296509683easm66131215ad.15.2025.11.07.10.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:06:18 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Cc: Huacai Chen <chenhuacai@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH] LoongArch: Remove __GFP_HIGHMEM masking
Date: Fri,  7 Nov 2025 10:06:01 -0800
Message-ID: <20251107180601.86483-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary __GFP_HIGHMEM masking, which was introduced with
commit 382739797f79 ("loongarch: convert various functions to use
ptdescs"). GFP_KERNEL doesn't contain __GFP_HIGHMEM.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/loongarch/include/asm/pgalloc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index 1c63a9d9a6d3..08dcc698ec18 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -88,7 +88,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pud_t *pud;
-	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
 
 	if (!ptdesc)
 		return NULL;
-- 
2.51.1


