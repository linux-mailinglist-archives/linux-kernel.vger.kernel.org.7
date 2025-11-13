Return-Path: <linux-kernel+bounces-899543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA9EC58346
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC7C3B0F7E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEF82D9494;
	Thu, 13 Nov 2025 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kU9L8mux"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F76923ABAA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045906; cv=none; b=FDPmo5zQUv2un2vGYahDs/FNNRF1QCAR3KjnimBdK2isDaNOadarvjNAB9C6D3Jw0SOsgSPkykYyW4NInXRsUFUWDflvno3cbajaJbSQ08tRMkb78k1XpvKX9qZJhfgYHQZbqmgQWv18IW+MwFYXP3Z7EAf1+DwVtFaYrsGsK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045906; c=relaxed/simple;
	bh=Wvx0vca8x9FSfN9/Ah1wg5B8rRoomoNb9yeq24wV2po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8ujIqIIuzzrj0NdvJhhniiaxvRnwt/RphvvUovSo+KjZjdiBNb3JTfKLBGtkL595xNUH7SS4fn5CntE3y0hIb9f4WzoYhYzHwKRShpI5BWDpQgLT2ovo879sQfz9WOmHEB+eHDww4UKLSJVfgSwo3ibM5gxFrPGU23wAKpRS5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kU9L8mux; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b28f983333so98501685a.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1763045903; x=1763650703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h95S7y1O/AgiNG3Y8C5QHzJHwFzVPf+f5SdvEJl4g/c=;
        b=kU9L8muxTrU4B1mj6VDoIBfDSK/3aeCMsJpNPP+u2kG0XsHEP4jme3K0hWtYC3hfEL
         LMcnI4zU/lrge1kzsx3WPDTpCARUkv62ejTntOKcIDuH30p/ToPUV089McFIDCGnrOcg
         Eh8TLAFcvgvQh461zDcVyM3c8278sRT+XMvglCSEJiF+Nf2Yr08KYS/wr1EQ44KLsyaJ
         ueG+yb2HzHo8Pa91QVPCQLwMM5yCfxInIwfJOzYqcOdezMtxfv4yq0/CUdYLZkeFcy06
         k+dLHTm8x/Al+o6UVZd9QBCiypY46avwbASpB6+2kxmf/71GP2cuzFREMIl8ZIU3JApu
         rkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763045903; x=1763650703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h95S7y1O/AgiNG3Y8C5QHzJHwFzVPf+f5SdvEJl4g/c=;
        b=WeWo3gird9F7Tcm7VRSf8RRJDYx3G0qJCco024jvG7rV+cReXOttbS/q9P0oTCu272
         k/YJbaEaBN1cr4VCzzfBtDAVeiq2M0nTjq4kWzQJoUKvGAOQIpeEZ5UaFT3avTEzsjgL
         W+8yPm8apWf11aCePXJ68JUHuig8/h2ZeOfe+PrnFc1a6sNRd+OPFIXScCoAPFccrfOX
         wqwQkiXn+TyQCutCdBeECbD/FwyvHUW8oSaKu61IEtuhMQxOSBVQI+INb4i2bgoZxLKU
         WMeMzFGq35EXhAcZVEpU7Oe0QhukDpXFF3AH3+zvZudZytwXylcpeccQNC4EYX8CAvw2
         N8mA==
X-Forwarded-Encrypted: i=1; AJvYcCUc122XWZwNSqEd+sWwhiECTHKZpHkPG64YyE3nXXrpLKxwbTxoVnyLTa1lzJ0dMtwl7BqclVN0n4MhsvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfpmxMYWz0t4kqerC+ddwIr+ois5m9M+TuXytsnwDbWv8fWfcN
	uNtToAQflF7NDT/XFOX/MLnmJ6IRPPE2BaAAxVMkAoqhJOdh1C0QCg1tbkJeobwLz2EpsRufNaq
	oayoB
X-Gm-Gg: ASbGncvmXbf9ZwFEoqEIhpkkurYa5poPaFrHJdwz8JIxhXbCUsYl+jRTtdjpqYYnqdB
	jKB9p3gj2FmCsmUj8uI/SkOTnG8kPQ+QfJUfIoGsYkLoq7MUin/M/e38fcgpj+SVPJxX1Rkq8rj
	jBEY7uNe5jaGFXj8QrYurILxWu12XJMGy58HTHaeKrS8AcJODCAQmEdMGJ4K5QDXiyItZEI2Vl3
	TieXjvmLzWwWqtRDqaOMMvC0ilol6AEtN6189MET/0TzWgD8hpL4PFX3FqZWexBckat8nk5/2u3
	VRQZ6VQ1hx+bodw5qRQJ2SqSojQCScoWpR5MuGhb8wWqrR0GX2PwViAV/2qvIEF3BAIzm1YDQ+z
	smn/6b3j0/DhTf9ZYNwTOpPKzuG2jMGhwQRj0LAc+5+wdI2DJ4k/FoE01eLYJyzgPKc0Jq3a48W
	aaAERVwT3s8eLOXmAUNwwJmfbv3xlnC980LX+5dAynwPVk8lLWjuGUbKWGByPlHPVM
X-Google-Smtp-Source: AGHT+IE+lDqnvQHUYkAu0XYrmRvZEAyVZPzTEt8PYEgvi5cL1INBsBSk48uifZE1GEdbSXO88lLstg==
X-Received: by 2002:a05:620a:3941:b0:8ad:3bc8:3cdf with SMTP id af79cd13be357-8b29b77a876mr945204285a.29.1763045903188;
        Thu, 13 Nov 2025 06:58:23 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aef2fa3bsm141739185a.36.2025.11.13.06.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 06:58:22 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] memory-tiers: multi-definition fixup
Date: Thu, 13 Nov 2025 09:58:15 -0500
Message-ID: <20251113145815.2926823-1-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112192936.2574429-9-gourry@gourry.net>
References: <20251112192936.2574429-9-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt_set_node_type should be static

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory-tiers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 59443cbfaec3..aed9dc9e0c82 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -194,7 +194,7 @@ static inline void mt_put_memory_types(struct list_head *memory_types)
 {
 }
 
-int mt_set_node_type(int node, int type)
+static int mt_set_node_type(int node, int type)
 {
 	return 0;
 }
-- 
2.51.1


