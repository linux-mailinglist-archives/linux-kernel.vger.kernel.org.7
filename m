Return-Path: <linux-kernel+bounces-775426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BC2B2BF0E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F49683576
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1B0322C99;
	Tue, 19 Aug 2025 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1jb0Lmb"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF99322A22
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599695; cv=none; b=ukn6vUm8O0qLk9/9xDoLaxBCw46sWIecinqjJ1ikOdTx0BPLA4bzf56f4tL7Bp/mo1Hj8L1zKIxSODYWCLFGpx5tS+Amd9yZEGc01dtx/FOuKFC2hem2T5GogVQHU22lIzu4miX8KsgOUnIKq1ZDdtFTg9XexQXwAWlbatthX4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599695; c=relaxed/simple;
	bh=7lgTDryzjPL5Xg/gMsVbQOEVBBvts7hg247LEVfqcuA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F3SwlLANOMqhEU8gbgpOd1tFB+8rSO6a2PRLy31ozEi7l795OsQ5GkyazAQ0npxqFBP+MqCDFjkhTkVoG30br7CroigdTYyw8is/ISrHVbKZVEn6YhUJX7EgoKTcCDMQAtobkDXElRjoyicbnNuMUH+nMWj+npd07rzFAh7qpt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v1jb0Lmb; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-afcb78d3b3cso413766666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755599692; x=1756204492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=08JqJr7G1gjWdMKCvvnL7bTDodkNWFyfbH7nQBOCVjE=;
        b=v1jb0Lmby8zlsQVVBpuNI8ZPtR00i8HV+DNVAIwrzHvXXQZbXt+DQQK3sfWaxgO79f
         pkFEmR1isqLU1tebvvQ5WFR9w7iLU7zM6UOsMg9x9IkE1QAIfVkw3acy3K8wY9y8NhNR
         FU199ViLd0b4+GctuH8JL0WG9noY03O1zS+yWyol/UcX1O8iyNyb+K+/QJ04L5T/5k9s
         CwAGJz4j/7sz9Q3GHYzS3Ufw13tCS0NF1xo2RyX4iNImJj1jwuFrdypa50T662MogybW
         hF3K+hf5SiNvfMbEQDd0HS4Ee2yjElLdsaiiQllR3BrVGnuz8Zy3iC8VdmVr9XRUOL3g
         okMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755599692; x=1756204492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08JqJr7G1gjWdMKCvvnL7bTDodkNWFyfbH7nQBOCVjE=;
        b=b0/xnzPb3FiJ6f36fns8Em5H1QGLM7jI8pyJecic32om/wIK7Civmvm/HLqmkmzCkg
         BBNVTdZQlISgDjaFoL9OMz0Mqf5/PwPbO8dpEPFJ4RthSN1akJSnekod+qvb/7eNe10G
         1hqrqMDZwDJW91GsUK5j+V08YmNjGTV/Y/TWrBc4t1Ivx7A/K1/Ym6ji69dO+fs09pLA
         lwu1ug9WzN1XjAPSTIniJspsyzu2c7pIiXG/0Dz3Esm788K0qJQTpSgITpG5JOY2pU+q
         9TKIX5WyFFM7JgYniE8LT2sCpPS2KMVSud/TgWk7HPaWZanmRH4QCpvGK7MCf+TQVzXN
         Phag==
X-Forwarded-Encrypted: i=1; AJvYcCWMxTCgtA2fSmG88rQTd7MeEafB3vNO2Zw9+5xJTJReaGL0PhT1o5GQY3lomQRXQFRKvRWEuF8fB6bny/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdxbP0M6aEQNnA9tZ3EqeD3TIDL5CHfhm0OHrwksyxFGp0o0Sc
	RZHlIkuFlm2Xns+LK2AoredOSlFt+ZbQog26JAiRf5ZD8K0XaPkVk/oAy17OR3iMRE+c6yyzheU
	xXqka3QRIBSeNBVfEQA==
X-Google-Smtp-Source: AGHT+IFSburLeN/bZPFzEEv5PgVznU3wJsVBP4Za2PFk07p+aJbgcziyUbh1qo8zQ4cn+Sc8HH0/fLdWChO+yMs=
X-Received: from edf23.prod.google.com ([2002:a05:6402:21d7:b0:619:ac6:aec3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:478b:b0:ae3:f299:ba47 with SMTP id a640c23a62f3a-afddcfbe96amr204399666b.32.1755599692268;
 Tue, 19 Aug 2025 03:34:52 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:34:42 +0000
In-Reply-To: <20250819-maple-tree-v2-0-229b48657bab@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1889; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=7lgTDryzjPL5Xg/gMsVbQOEVBBvts7hg247LEVfqcuA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBopFNJHnIw9YCL5xST5YbjRd/Fzqnm1QmO+dTfa
 R9nNQweAv6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaKRTSQAKCRAEWL7uWMY5
 Rps+D/99qMIDJ4FAIG06+w4Pu047hC0WFaEATdHVtqYrnG0o9tOBFTfCf2vmCTWFGrKSDW7Dtrp
 eryDx27c4f0TvBZK96kS4KmjNAWOnw3rPIbkY6By4WnBvNg5fWrKNNyI3QDZ+igp+xOANglhCwW
 KNoXBOmawcL+/Mh1TNZjNYjHr2ORd73s4qCl2KwA6fMRT0d/x2hRo5nk+pR7PQycyLa3tFVPGPs
 wJyhT0wBS9/y5+Gy+DMf2e6PBSq/+83z4WwL56wOLBv6AjEvezT3B7N6lY9GcVwIXVGZjxRsimb
 CA7uYTZ8Zsh60pNTfARC2FGcVpKsioQPaS2qfXVRfbjQgXy4TuxOxU/wdl8XEtlCl3hgOP2MVVy
 P2wgzi76vgMmK4xp7OdzS41dyaFHOIfRnRfFSJgFt0VtxWffccMpRfHyRhSfJXai7eKddUqZhL0
 6Tgb3ip7bQDBqVLn2KrXGrWXDVmKGUjP0Tyvhip8Q7O5NMwCqNQ26gZdlhF2/gw0ZQlWipcN7b8
 oLvmfvoYyk9iN7KbRPb0cTzn4QxYcNPy7kGAo03XDAHqioDNg6N3hDi/fDTtEw909c1Rq+SfMOI
 f7GZxUIiRK/bVeCKDjgqR6ds9j18xtrinjh1lJbIQtpNmDELQ/BqdlnlGGHeH/sM+Ks2B1eV1jD 0RLYklyP7QzszoA==
X-Mailer: b4 0.14.2
Message-ID: <20250819-maple-tree-v2-1-229b48657bab@google.com>
Subject: [PATCH v2 1/5] maple_tree: remove lockdep_map_p typedef
From: Alice Ryhl <aliceryhl@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Having the ma_external_lock field exist when CONFIG_LOCKDEP=n isn't used
anywhere, so just get rid of it. This also avoids generating a typedef
called lockdep_map_p that could overlap with typedefs in other header
files.

With this change, bindgen will generate better definitions for this
union, which makes it nicer to use from Rust. This avoids a cast in the
Rust abstractions for the maple tree, ensuring that Rust's type checker
will notice at build-time if ma_lock is changed from spinlock_t to
something else.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/linux/maple_tree.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index bafe143b1f783202e27b32567fffee4149e8e266..8244679ba1758235e049acbaedee62aae5c0e226 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -194,7 +194,6 @@ enum store_type {
 #define MAPLE_RESERVED_RANGE	4096
 
 #ifdef CONFIG_LOCKDEP
-typedef struct lockdep_map *lockdep_map_p;
 #define mt_lock_is_held(mt)                                             \
 	(!(mt)->ma_external_lock || lock_is_held((mt)->ma_external_lock))
 
@@ -207,7 +206,6 @@ typedef struct lockdep_map *lockdep_map_p;
 
 #define mt_on_stack(mt)			(mt).ma_external_lock = NULL
 #else
-typedef struct { /* nothing */ } lockdep_map_p;
 #define mt_lock_is_held(mt)		1
 #define mt_write_lock_is_held(mt)	1
 #define mt_set_external_lock(mt, lock)	do { } while (0)
@@ -230,8 +228,10 @@ typedef struct { /* nothing */ } lockdep_map_p;
  */
 struct maple_tree {
 	union {
-		spinlock_t	ma_lock;
-		lockdep_map_p	ma_external_lock;
+		spinlock_t		ma_lock;
+#ifdef CONFIG_LOCKDEP
+		struct lockdep_map	*ma_external_lock;
+#endif
 	};
 	unsigned int	ma_flags;
 	void __rcu      *ma_root;

-- 
2.51.0.rc1.167.g924127e9c0-goog


