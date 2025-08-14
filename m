Return-Path: <linux-kernel+bounces-768201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BC0B25E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3B51888639
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B502E2DC8;
	Thu, 14 Aug 2025 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMWUXmaL"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ABE2E2844
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158120; cv=none; b=m1+WYVOK4NXBV2KHTyI2hDDIk2NUZJ8wWG40l4CooC6PAH+pynNXSeOvfo0SXsZdsgQvG077RiAYzGAPtAa1JpybcwTEb4mLbZwGfh/9cfbQGF93IcVytp2dJKnSlZT4XAuO/zYjCPqvkJ+vZyAe7i9IxJ9vbN0JYi78RxK3C5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158120; c=relaxed/simple;
	bh=VMoY9uH+QCsljh5aA/42PVLV0HoLhQc+LEs/AXP4pXo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZMApKwQTFt0oic8EoNAPwBtxRswty/qWVQblm3Ea2JfJ9FcBsxZBE3pl/5t8zJY4nPMr03PZ6vhiI+Vakh/ndrXxe6QVqlamIj4TXDV5F5YgXmWsyZvzAEKWy8GAGH3mIlmGVBoXSAx6AAmY4SxFTJsQfOl/ixGqL6XBnSdMtdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bMWUXmaL; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b00352eso2527485e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755158117; x=1755762917; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pkt9ozF4HjNo8N7YGJsDJbGhL2IzfusvyUWTBzPyf7M=;
        b=bMWUXmaLJ2VY9BrnPhBdWDTNKgaidBDAgDHtqzX1xwruasy3p2zdPeVofPOOCy+H6F
         ur6rlycSX3XzkRE3Y7/N0JNC+VNWp0GkarcvAubefHc02phibGLuLnbSatCoGXNFef7l
         EAeswCuZ6NK8kZ07G5F0cOMGzixl5ayQSKIx/ZrZi+TLTwpNotOoeKJNJWZssh/coEO8
         VfV9QIkhwn2HXjQ5EtWQzcTKF2HBED148ZAJ2gKWfgpjadfy6zWCzaya/RuUSZR63wHR
         Oo17x60f+W873WOaEIRcqx3VWMw9XAiAr4CmNK5Pjf2OvsHS5Dt2uYPIs2HTxxsWWvTM
         wWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755158117; x=1755762917;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pkt9ozF4HjNo8N7YGJsDJbGhL2IzfusvyUWTBzPyf7M=;
        b=hQQVxKQ4F9Xk0hCCPRcXkePZ2UoP7sGJXuKzmLg4f437JFXbe22q81+Fqu4cQLVwLF
         qo4A42cFjwMVYVi+KwQrSts0D6Gbv+2DlFCP0WmUuh9WXzDXQD0pAR9yx19i8EBpubrV
         l54iDm8leG+30IEtXRgOGCck1QPrUIywOOaKgnR2XUvVc98K7IqthzZgpWuyZ5KRkF9L
         NE+j4dSUuAFM6+ErtMACd+uTmPMbsrEgB/HHwY8bx0mbxNO9DynLXByMcFnQ3CReInS7
         bDOS9JI3hqygOgHRh4yu9PZySDjTDRtg2TJ56eOv614jRoWKj6Af0+sw2mCJvhO51sP+
         Ws9A==
X-Forwarded-Encrypted: i=1; AJvYcCX/SQQZ6n5Y10205rOyGiTHEylMeq8onuBkrI6+gyD8ZPDBkOrmOXWfrDayDKKWrN4hJhfFl8Yo5+y4mn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZNMFmR9kqKE3Sd5KkbtTMcZUo6ahSDE8wREl76qDmgAHfQ8Wb
	O+LUYY6bnzMnznG0pDPRSDDKvEmq/Qyawfl1XL++SoOFj2DZhj/a2zAaYgHxjv+qw1LYVChtQwS
	jWbAukTcYWTVBFrfDuQ==
X-Google-Smtp-Source: AGHT+IEwXLvyCAoWDtNfNW5WIiz6Y+KDZTy2eN5q6Eu1bB6BXaaznui8SXDAth8yHInJovhcWZQN9Sn9q2E2DRU=
X-Received: from wmbem15.prod.google.com ([2002:a05:600c:820f:b0:451:d768:b11d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d16:b0:459:94a7:220f with SMTP id 5b1f17b1804b1-45a1b6577f9mr12470205e9.26.1755158116883;
 Thu, 14 Aug 2025 00:55:16 -0700 (PDT)
Date: Thu, 14 Aug 2025 07:54:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090; i=aliceryhl@google.com;
 h=from:subject; bh=VMoY9uH+QCsljh5aA/42PVLV0HoLhQc+LEs/AXP4pXo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBonZXTyaGB12UQz+He5R88gG56onLNWGp1jIqZ1
 vmC6SORLquJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaJ2V0wAKCRAEWL7uWMY5
 RmxKD/9XTAtpkY0tqkvQ/KI118GdnayeBzkBm3Ju8ZviwzKu1pt+Tj6C1oq7NXbmw4VPt2/JwEr
 +R97IGMF5xudWN38Ee9hYouRwVKyE4412lVzr9KrDd0L59UpOvfYViUFV2Jt8pZynbJUUdDeVu4
 NJ7AQJguuboQVezTI72dlooiVSoEqQgjqlTI5695l8FS31ddO7IBRt1gd3402n3emVpGjNUq7FD
 QJz4++Wa2QsJ2SK8w9beudiWP1zXoFtJFQqQJp7eYVbFCtYi044prekxwkOpZayKSOa6YU6WfCq
 dtSPrqA9zQESg+HbayhaPci7lGtJyGIqO70/gLuGesr5Ql440rigeOD8lO9OXkVLGw7+q5tAZWi
 M1PQffntwdm6EQBR+fS437Z6Fu+wD6hXnDjJDpv/r/0DN22z0WH2Vd4+VP5qnsM3GQcl+GitSXo
 gvbx3C/SuktLE7U1OMFFY9X9fzmV+lwi9ToMuL6OkwGpHYyX41TuoftVpF+qhDcqfoSXKAA2SI4
 O54FedWn8jTp8GeasAV/pVgFAC/aklaQ5CBrmWyaZ4GH7kBSBzC9EEMz41LXZK/0jCJ4DamiqAh
 guRlN8WW7goErG1vaOvwNELh0WlekDFeb8MoU4WRMBtLwLYLaqie52aaITPoleWWXJoept+Lbc7 83Xlpn3nO+wY5Hg==
X-Mailer: git-send-email 2.51.0.rc0.215.g125493bb4a-goog
Message-ID: <20250814075454.1596482-1-aliceryhl@google.com>
Subject: [PATCH] mm: rust: add page.rs to MEMORY MANAGEMENT - RUST
From: Alice Ryhl <aliceryhl@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Danilo Krummrich <dakr@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: rust-for-linux@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

The page.rs file currently isn't included anywhere, and I think it's a
good fit for the MEMORY MANAGEMENT - RUST entry. The file was originally
added for use by Rust Binder, but I believe there is also work to use it
in the upcoming scatterlist abstractions.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..45f7a21dafd4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16244,15 +16244,17 @@ S:	Maintained
 MEMORY MANAGEMENT - RUST
 M:	Alice Ryhl <aliceryhl@google.com>
 R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
 R:	Liam R. Howlett <Liam.Howlett@oracle.com>
 L:	linux-mm@kvack.org
 L:	rust-for-linux@vger.kernel.org
 S:	Maintained
 W:	http://www.linux-mm.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 F:	rust/helpers/mm.c
+F:	rust/helpers/page.c
 F:	rust/kernel/mm.rs
 F:	rust/kernel/mm/
+F:	rust/kernel/page.rs
 
 MEMORY MAPPING
 M:	Andrew Morton <akpm@linux-foundation.org>
-- 
2.51.0.rc0.215.g125493bb4a-goog


