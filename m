Return-Path: <linux-kernel+bounces-897970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 923A0C540AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17F15346BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D8734E74D;
	Wed, 12 Nov 2025 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVshVBD+"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21EA34DB62
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973930; cv=none; b=RW2ilD5pnJSjPLvivTMBxi0CI3gOpX3ypHIFvkWLc2WoNexUrzd28/BNrLznnupzTMilNUP1Bv9mZXMq++yyh/fCDaGIx2V6CLisUrPFIC2JSyFGUlEyW7SLaLxRujluZhaqch6cW2oeXnKTVpWgMaCx1UHn7gib/E7GolCmi9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973930; c=relaxed/simple;
	bh=nN2xdyMdxFwpjMYxAIENipm0YmxDg71Krkxhb9aKY4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TW3SOtCrf9BZhpV8OZgHdcCb0cPb+MR0fgaxryx6AJN8sok26sma7eslpnblD8hvte2EULEMMGZHPx59Ed/NPz/asInHhKivk9LnSox0BzwRbmT+ahDCI21KsaiHMdX0VR3a0WankZJKdprfDWLQCWSd4gEfQuMyklFmtltN9HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVshVBD+; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3436d6ca17bso1326415a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762973927; x=1763578727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1I7Klz6oAgGe3SSsI7DSFPvLctg25agoEpI/CIFVteM=;
        b=ZVshVBD+H7nQZbmin4+TWKQ25Ec8t8VPG2t9u5h/4+svhvojw/5egcqDlKKU6j1Hk3
         HDFXEaxNj+7puIGW70+jhmyb6F1UFbHTqSYANOj3hTxMmE6EkfGvD8vk7Tw+vgpwpFis
         Q5wgQin+KJTMJAod/CbY37Df4MhbbF68YyKj0MkKV8lj7uuxU9jopaQ5gchPRysjlmrd
         SKJ51BnrJuMZLsw9sJPz2qTyc0BbvHfkE1VR77Uv1vmDTntfpdKf4xsJjINWCnvwEXog
         1frmystghLhelG2oUMe8btewmCH2QwOpfYcSSd1UqaDXKeuBGY/HjybqKCgCTX0YG4fP
         JxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762973927; x=1763578727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1I7Klz6oAgGe3SSsI7DSFPvLctg25agoEpI/CIFVteM=;
        b=jGEQ8FWfggfopcT1pTPuAQBvnLZoo4MNybJUaeqpDvbBkFg5ZmlejJ4Bdjatj/CIAb
         FPaZ/XZeZtLGz4vrlWcvq2YZDK6bOaf8DegivvdkI4KNtf6yKrO1lWiWqyZAgEBB4bNd
         olX+dSEu0BZBOydvZOL5l69CfseWGsQOevXtwgrcba4l+QJoxFEAejRLaaD9J22JsdXx
         Zah6zr+KoOF3YsDO7wzt4gVhLRirYULI5+WiXucK4tJ0GgBlyIhWsqmYPkXHLOzxmnWh
         hvx3JaH9+keMzdFoNlKjh6Yuup7gm7IX5T50i+fMDqlqfEOZ4rNnE5bogRjtY50aEk/5
         CFRg==
X-Forwarded-Encrypted: i=1; AJvYcCVetXWcR7TmkqX58kRJ3RhQFO3a5FpOpen2bGFEOrTbxGgE3s9K900cG9F8pRWNKBrAJl59oEWoz/TxyIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnAELyGIjs7gKkXactiRQCv+TR5WgAsRdSZngkX3aaDNGLXqqB
	RuFrY63CHYItndTrgpRLMGgHoxmfNvWxTns1GQZMvAfBqXJJYjVB20VY
X-Gm-Gg: ASbGncu1S+nBhJipetdQjZgFbTZ29tih4J37tZ/QHt5D8wHLSaUegRmjC6D0IFB1EFe
	hVsYmVVfu1dYZREMgta+kfyT/Hykqk/xlqY1N8ChM7wKtUw/uTNhs4FT45U8uQUB9KV7Qntr0Vk
	kZlcr63wJfo+mL/4rvJwyZAVHDYSzoACX19QBMv4wm1ztwyJINLQE9zufTVzTjk9ipUXcpQPPNK
	HOHzgGdDoGNnz6ltU6HUcnYze6j1ldaqEzgOrObtl0PE7sVLGBu7CikvplmUz/WcreyGYZjQ1ga
	0V8kFyrPWl19C9b6rEXxIi0nsbGVGZ8VS44ARt+EKvTe9kzgYU47m4PW/oYAE3YsP6ajLmkWkfq
	FWIlFdHniZnkaNiuIDjFGrUIDbgBYeWIMdvk8UhRrN8Yvr4RISBZJ5GzsKsNcCR8aSOu4YWNLFG
	skAq6pD0ncFRk5DjCQBs6TYKSgHfFbfy/t
X-Google-Smtp-Source: AGHT+IEXSRKPlnUmANkCKnv2Ry+gqRz/FWfvHlbIj2RgqDD993fXyqdwaPS9bBtM9eHGXaWe2sWATQ==
X-Received: by 2002:a17:90b:590b:b0:343:7714:4cad with SMTP id 98e67ed59e1d1-343dddeefbfmr4942912a91.5.1762973927256;
        Wed, 12 Nov 2025 10:58:47 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-343e06fe521sm3491565a91.1.2025.11.12.10.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 10:58:46 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 4/4] mm/vmalloc: cleanup gfp flag use in new_vmap_block()
Date: Wed, 12 Nov 2025 10:58:33 -0800
Message-ID: <20251112185834.32487-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112185834.32487-1-vishal.moola@gmail.com>
References: <20251112185834.32487-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only caller, vb_alloc(), passes GFP_KERNEL into new_vmap_block()
which is a subset of GFP_RECLAIM_MASK. Since there's no reason to use
this mask here, remove it.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6a3ee36d77c5..49e0b68768d7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2699,8 +2699,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 
 	node = numa_node_id();
 
-	vb = kmalloc_node(sizeof(struct vmap_block),
-			gfp_mask & GFP_RECLAIM_MASK, node);
+	vb = kmalloc_node(sizeof(struct vmap_block), gfp_mask, node);
 	if (unlikely(!vb))
 		return ERR_PTR(-ENOMEM);
 
-- 
2.51.1


