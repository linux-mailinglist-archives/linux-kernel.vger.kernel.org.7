Return-Path: <linux-kernel+bounces-728814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F47B02D39
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 23:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C2CA40710
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 21:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7744B22D9F1;
	Sat, 12 Jul 2025 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcfP4Izk"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2C5228C9D;
	Sat, 12 Jul 2025 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752355928; cv=none; b=F2MlpkkMU+YgSS/wCHEDCx29QlOUjLAm02BKJgiydn5FkRYEK5Nrqe4hncLXG8hXHefpnPJnVn42OMfWSj6O1N41Xj3ZO6hi38E3XSgiNnxDylDrZAF16gm+WQerUNHmJSscVOfd6/IWS8ErQ+LlmFb4qnCjfbDzUmXI16t299c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752355928; c=relaxed/simple;
	bh=AP8shLBDvKbYuth+8++0JymfuCshZQX8ezE8AjEF8do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFlq+SkCa6ZnmYQ9ukbLTzKr+WbBM+o1rCJQPuyfHaBBuCY8VTdMAtxfh5cZRakLgpWQWI3r2PH0ADv1zl17R6V/mF96mTAZMyaEjtMuwNdzqQ7NRUu4T0EHtWAwchYIZsXNWoFZBfkbKxjojdwcnjyF2dPtTBU4MsIGAXpj+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcfP4Izk; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-879d2e419b9so2398627a12.2;
        Sat, 12 Jul 2025 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752355927; x=1752960727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LO0TxQnKvrLipyxCSYXSthueOvIoODhR5Ygf1iirZRk=;
        b=XcfP4Izkdds3YAdF5ndogxAS3YmR0BfSmdft/n17dIC0/xecJYyUnZnhV70Jd6wJS9
         cMuVfgVlz4AfRSFJuAlAbpZpeXAnUNyD04yl1PjdUAeXLOc3FwqR6QhjG+YLO1e5eUer
         ZE3iIG10BoBJh16VUbtE8QM6yVQbKWOicoxe9SKF2NpGPHmzYbsB6zamq+cCFtuT1mmC
         YQLY4fTKCUgn02NJyReKmeoFvYaLa2F8ZjVLpcbRZPy2xDdn3i6Tz3oMSZSwcaTc19Oo
         pUqrFx8aMA6JIvVvH3iEaRaMoW8liZv+TPkB+FP0Z4nG/ccEt9utM7NYztDeLMlxkZrP
         ml4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752355927; x=1752960727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LO0TxQnKvrLipyxCSYXSthueOvIoODhR5Ygf1iirZRk=;
        b=Sqz4xQV+hBygMEU58h+yY9oyBh4r1EZ4JWgwGpRM4Orj2gzcm+o3Wrc+x3oa+HRsgJ
         8bcWztB9gMpzoQNYGh/pt4ihHqK7HaFzNMEtTsFLc6IdRTbJUtgp+Co2o8n/px+d3BJf
         QOGrGXr3ZsfQfnUnF2OquUqfNM/XfoF35nV6PP6aVnI8EKo79XSn3tlSwT55e+W9A3FW
         tbbFttmRJsHoMR8hDeGa3N4AigG2PKKQSDtA+Ax+glppqnIizZoe4W8X8JSpBuUCzwn2
         i+rN1ynuwXE9kcFJVO5SbLZD87KG0Qc0LTnQvyK6M2A2ZbfjgcQbzKWGEnkw/gxv/K1J
         TnPA==
X-Forwarded-Encrypted: i=1; AJvYcCWxB9fkNENPnXbZ6wH4rr3aMVtc2/C03QMyPzCsixB2Z4KPfa495HOgFxuc1yZ1wC+DbHyecgWhxzLe9ULjew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1YiOnS/joE3qi+F4qXuaDJoVXW3oTknpgnhC+hTAonW4j/yS
	x0zzCYT1SnFEXS7VDvaLSugnmFOa0/EFCg3UfTFaCaQqZ2itgnkAjdGa
X-Gm-Gg: ASbGncu1zaLlwXdni24SarpnwSoW40wguzABZJqq9lpYt/AsRPs6Fm4kPWujSYvD21U
	YDzfQa/wexh7aKQKMjONtbbKiCObJ4RD24/Txuz5K2GDyb1eNzqBrQArLjeoFFFPuaobQMvFgYB
	jXTkCJIW5AnxAwAMxFEq1mVS8xyKKmfl+vGs7yyKCAQj/bI9I9VCGJMPtY8GHpCPI4tvp3/dvyZ
	r98R3jIawRgCecJpo0hySrFLJ+qZ4t285mmao+bF6XYtHa/FN9bFqEQCm1iN7kmqPwdnnueeMot
	xiOVdppoQDkCoN/OjcpbROp5DuoDUggXiOprkBNPH+Y5U0Mv2RGyq/c1Q2s4BGg7mZE/tBIbl9U
	nuG8mqkpFfv6jpPjAvSOKEWCLKWT0PIMVTCJYsXc7YsucEWD8ttwZHQz7
X-Google-Smtp-Source: AGHT+IFPX3vsrSmFB/bzkd4mz1ZHYM0i6Eaod7AfCsmL0k7n193sAJy+iT0OV/FyWJP513vCy+Nl8w==
X-Received: by 2002:a17:90b:5101:b0:312:db8:dbd2 with SMTP id 98e67ed59e1d1-31c4cd704f5mr11477475a91.19.1752355926653;
        Sat, 12 Jul 2025 14:32:06 -0700 (PDT)
Received: from mitchelllevy.localdomain ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb65aa2sm8003935a91.40.2025.07.12.14.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:32:06 -0700 (PDT)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Sat, 12 Jul 2025 14:31:13 -0700
Subject: [PATCH v2 2/5] rust: rust-analyzer: add lib to dirs searched for
 crates
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250712-rust-percpu-v2-2-826f2567521b@gmail.com>
References: <20250712-rust-percpu-v2-0-826f2567521b@gmail.com>
In-Reply-To: <20250712-rust-percpu-v2-0-826f2567521b@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Morton <akpm@linux-foundation.org>, 
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Christoph Lameter <cl@linux.com>, Danilo Krummrich <dakr@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-mm@kvack.org, Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752355923; l=925;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=AP8shLBDvKbYuth+8++0JymfuCshZQX8ezE8AjEF8do=;
 b=03+IgQe2BFqZTMGtBiBKVhcvABMJFgRtkYVcIW8McilA/S6CB3mUuXaqWNv0d/2AtfLUUb8NW
 +4W5XFT/fdbCnKpZ5UQXgRCf/5Y9/HTZgnV27ZNcBXSB/U9nWlpmWkc
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

When generating rust-project.json, also include crates in lib/

Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 scripts/generate_rust_analyzer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 7c3ea2b55041..08e14ae9c1a0 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -152,7 +152,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
     # Then, the rest outside of `rust/`.
     #
     # We explicitly mention the top-level folders we want to cover.
-    extra_dirs = map(lambda dir: srctree / dir, ("samples", "drivers"))
+    extra_dirs = map(lambda dir: srctree / dir, ("samples", "drivers", "lib"))
     if external_src is not None:
         extra_dirs = [external_src]
     for folder in extra_dirs:

-- 
2.34.1


