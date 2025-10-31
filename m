Return-Path: <linux-kernel+bounces-879825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 579A0C241E3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8CAA4F5ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F053330313;
	Fri, 31 Oct 2025 09:18:44 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2080329399
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761902324; cv=none; b=uwGOJ3iLN7iFhufj4emVfP8PKopla/IENXaGFp/PmvC3ggd87hJunnKqHcDAtYCuJGD9Jl8OsPGuRBWKmQ+tR8dOuPoSg74vv8aGb1JLgC1bc+StWK3QlvXIDC1L3qzYZOs2GPDn912mQHNEo9lwDOXW03OlaN9/s41hF284eC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761902324; c=relaxed/simple;
	bh=CKwLRXWSs8CRQTtdRUeDXnJdU3d4K2VDAIjleCdmPeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMR3ZoOUnh4R1NQzqABvInXOBDos78oKo5tSquPE5//OJz+amIDN+M5hxjMe0HhnpZVxmlaubVCVtIyYRC1gUh5KUoenqj1Z53u4vuwgW4hIk6TKhguv42ypQOPcBkGjdpZ8HmnAOaiin9an1u3WS/4N1ZLQkq5m0i+ruJKujn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2953ad5517dso898515ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761902322; x=1762507122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+NZHuy7slH1tEgRbDXmTQJQ+Q/vMpvRiCleu5bnlac=;
        b=a/8hT/muW4PRsymUbKi3j17MwytWY10nN0b9pv0xzZm+GEOvpOdNtIdCSKdkVQsSrF
         lU6ETCFdD9zwXbWQu7vX/HIOxY4edmZxGW+B2QAGGWKycetTE1ncGLMEwVPJyCmSLrhs
         uXX8iKeT0H4a2phmrEYc7vGBktDD9BS6ehRo4avpIsDLBnAnYn4SBc7OuLN/B6Sy3FtO
         p2VR75e+d24DTuDPw0lBbeE7qndTCtrZO63r8qok6MPzQqG1lyjaGaYxy7gJnc5Tyeiv
         r8JXRMPygsV9WVxB5m50inTd5R40/XUtYS2Gl7dyOrd+DKMtUlzg+3Z1tyzSTwh9xvGE
         vKfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUimy3fwwNqf7whH1wEZgiBOSI32O0MeLZHM0FzT6n3nZMKw2IDfRpZb28Va0KlY9PYie0THMICGnY13jE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpus1Zcksa+WVHkmErywijVgIL5j8l01GMkSgU/rO9y9V038ha
	BNO+53tXStMk7sG3kjaS10G3ohooviNuNgzA97DxvpZ+dml6tLmjWvPR
X-Gm-Gg: ASbGncuw3HvF7ZezVGnw9uiytW5vJppNg/yk48CGR250dGnYaa33/a/D8DXebIkwfOW
	4YVg4CkzucSsDp2i3R5B3ljWz5jB7soUGenfz/NRj6uGmS8CqOIAHcwq1FDSqO19WxV2mU4DYOI
	DI75yYFQiH5+tb7C4F6adKCK3/T27TVibS2b5j8qfT2NqQfeuZd6+DfJ8JtaS75qnivG62lCe1p
	gALE8+Q4KR9oVl7Vq3FXNefhRU/ZFgHlMxXf6o/goWil5MDVPdhqNM2FGzUq1XkdgNW+aAQc2fJ
	Fx/LnjQOjUhFewVM242skeCQO+HcREWNI2YDTEg9nXOHceBoKb96WirK4RblRSQ0eyd+bvzhfHh
	hf5webJ0eMdX1r3rzr5vW1kELa+2fWIytJEeBMvF0AD+MdGVKIoV4JhYypC+VvclqTs0KBRPQBN
	fVCGHoK6maTe7KcP6Q3qt3wjE=
X-Google-Smtp-Source: AGHT+IGaY5+g1K6KFzwg6ulzp43eGNlMp6k/vOU+6dw4kyEoznXaP1AMdrHNLfDz0Nl70DbFrEP/Wg==
X-Received: by 2002:a17:903:18a:b0:290:7803:9e8 with SMTP id d9443c01a7336-2951a48cf38mr43274965ad.48.1761902322016;
        Fri, 31 Oct 2025 02:18:42 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3409288c7c0sm1524575a91.5.2025.10.31.02.18.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Oct 2025 02:18:41 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: big-sleep-vuln-reports@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	rppt@kernel.org,
	willy@infradead.org,
	david@redhat.com,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 1/1] mm/secretmem: fix use-after-free race in fault handler
Date: Fri, 31 Oct 2025 17:18:18 +0800
Message-ID: <20251031091818.66843-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com>
References: <CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

The error path in secretmem_fault() frees a folio before restoring its
direct map status, which is a race leading to a panic.

Fix the ordering to restore the map before the folio is freed.

Cc: <stable@vger.kernel.org>
Reported-by: Google Big Sleep <big-sleep-vuln-reports@google.com>
Closes: https://lore.kernel.org/linux-mm/CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com/
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/secretmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index c1bd9a4b663d..37f6d1097853 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -82,13 +82,13 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 		__folio_mark_uptodate(folio);
 		err = filemap_add_folio(mapping, folio, offset, gfp);
 		if (unlikely(err)) {
-			folio_put(folio);
 			/*
 			 * If a split of large page was required, it
 			 * already happened when we marked the page invalid
 			 * which guarantees that this call won't fail
 			 */
 			set_direct_map_default_noflush(folio_page(folio, 0));
+			folio_put(folio);
 			if (err == -EEXIST)
 				goto retry;
 
-- 
2.49.0


