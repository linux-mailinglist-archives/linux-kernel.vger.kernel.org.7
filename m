Return-Path: <linux-kernel+bounces-885416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E79AFC32D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06E594EDF6A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E36126F2B6;
	Tue,  4 Nov 2025 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO13qzGY"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B422DF12D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762285090; cv=none; b=L9aPkfUF94FM35n7SVzRDx8YwyPR2ntxC1BIS90YtCzWSgEX9BhC7BQchqfbfb5TmpHvMerU5kNl2ZHlNUhGEPpGOqhUh+BWgn3mG4pTynG2u6rXr/8+nCgfHEFOb+DfWX8T/KZfs7hr9C4VyaoG0Y9wmu/HIl+j1RssNmqn0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762285090; c=relaxed/simple;
	bh=5W8zvHEGFk7W8lcQQ51BUT76U5kQ6osgcX9DQnxB/Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1/4fVc55R8qMpt8ds3Ba5rt2VHCST+bgD4bhys8sIMGqirvxEer4KHdTL8uR2/UVIYTzEb0i32lMkf5BeWvdx89jtTfli2JLML0yFo9qXKLlyOvPjwMYbyTfAduQ2yM9fV8TtLXNn4uzmcbuzXUc45/4nnGp0pIgz75QGhEMpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YO13qzGY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47754b9b050so9398755e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 11:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762285087; x=1762889887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+vu3BFi3eMkE8uZDd0o1RrqC7gSQvZv7E8xHlJ1qM4=;
        b=YO13qzGYagGV3Qe7yiMsMTnKPlD2qIs/XToDPOdCAXGsgCcFMhKKFFvke1HQZfJ+G6
         D0F0YOeAab6njCqlymHHPaU4+U11aUwgDsZByiADargQT2AWh+cO6PbZJG/Q4nbNFBZt
         SW7zNopxEBqCb6JU1BoSgg/cHFzjwoBpjvT6V8SF7CIVdjhe2Z0Tcr3zLCEsSGCF6nMQ
         /C4OLXJYkOl7yNkkYRhxjgmHhsptIaNAqYlxqcaXytWHrHpML/6SPqEN/l/rkKfTVxVd
         Fxt6cpdeNEShRapjJo+2CRZ+GZte0RA8crNERH25U3FmCN5qY2SwdZ0H1rMfBmW2dDQm
         d2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762285087; x=1762889887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+vu3BFi3eMkE8uZDd0o1RrqC7gSQvZv7E8xHlJ1qM4=;
        b=pIHRBQGIPrN5+AzAd5jm8FG1vco1JzQPYXXTjunZ+bq53bFGo3vUYh74AuBRevSSvf
         AnhpSF87cuL+Isko7jCZfiezvaZvEYoBFeLYqCod+KB3nmfnd+XOvkHv3rtywfk1ayau
         UA9L0fO6RxdZlWcXc3s2aaR+qOsegFH9O7wWc/DMgo+c9DGuy+IdmiUndKhjrBY2YxPT
         ZEZBk+tFTtTjZNJDXVWxy54+j+KPJ3Vqlt6qJDjty5Lgb6nDqjmxqEhR/pz1oezharSw
         X2LgB3huGBXGI/3MkqGAjetTsKJscK2y+LT3lr597ZQge57WQ7UnbJEROLgQt1vB9PUk
         DxEw==
X-Forwarded-Encrypted: i=1; AJvYcCUndM8yZ6YgcNiQDqngUQ6W/yonhd6/Uw76Zb//Wy+4EqJOh44qmUCMdLnjwX54H0uKny5AFEnAjAdSbDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuVuAcQ2W/ACxiehxQNAaVQT1WSzxVUCUENiGuanXvSz6+ev8a
	Pi+UpV74WyS967qzwa8sCqygShSpCRQyqXDcfL0xUkevS2xzaz186lse
X-Gm-Gg: ASbGncuuayWl0ypQ1cnQoAymtZj43m2ZXWZl1vYyGMATTGUGTwuZFjAX5R4P1VqSbVF
	TXWV0tqguNwDNcwBdf/zV7HWsPz7GEldAB/fpGBnCH/BMDEBkApx4e/0LP6H3vadFk89P3B4VnU
	/IaAlFviE4RnqvwxytQ0Rqbv+Ehn4yfG8P3UbbIiuSZVFPTRpKWnaDH5o/5TYvw6KUlfkm6Cc0F
	AEf+g9xUyObuydcJbdFUpyLDqb3JwhftsVyYKeZFUl43RxpKBLmx4mFiwE31yRwAif1jWgM6zKb
	5OlG3+Wju/La/Fn4FGK2AHxybbW/Pb/G2e0FKO8IwIeTk7v2x8kEM89mYBF0RxNf9kelELWoGFl
	jmZEd7L6cbLMkDPhIKWNzaHUdH62C6uW8IPa2DTRwtGKESOzTWmCxOW/V4eJy/1UYNJZXUC4OnA
	Rw93OcuyIxllAk9lvatemThQZEoLDd
X-Google-Smtp-Source: AGHT+IGSD5JKDCdaTTmAp0MYMS91XvkPp8oz/dP1zmqG4g5rPRzVgWr7fySwvEo5EuPqrlAAIl7B9Q==
X-Received: by 2002:a05:600c:4444:b0:46e:477a:f3dd with SMTP id 5b1f17b1804b1-4775ce2878cmr4985525e9.36.1762285087353;
        Tue, 04 Nov 2025 11:38:07 -0800 (PST)
Received: from archito ([2a01:e0a:acc:bb60:756b:64e3:20ef:1d08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce3ef38sm5549195e9.17.2025.11.04.11.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 11:38:07 -0800 (PST)
From: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
Subject: [PATCH v3 4/4] nova: Update the nova todo list
Date: Tue,  4 Nov 2025 20:37:51 +0100
Message-ID: <20251104193756.57726-4-delcastillodelarosadaniel@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104193756.57726-1-delcastillodelarosadaniel@gmail.com>
References: <20251104193756.57726-1-delcastillodelarosadaniel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small patch updates the nova todo list to
remove some tasks that have been solved lately:
* COHA is solved in this patch series
* TRSM was solved recently [1]

[1] https://lore.kernel.org/rust-for-linux/DCEJ9SV4LBJL.11EUZVXX6EB9H@nvidia.com/

Signed-off-by: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
---
 Documentation/gpu/nova/core/todo.rst | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/Documentation/gpu/nova/core/todo.rst b/Documentation/gpu/nova/core/todo.rst
index c55c7bedbfdf..35cc7c31d423 100644
--- a/Documentation/gpu/nova/core/todo.rst
+++ b/Documentation/gpu/nova/core/todo.rst
@@ -44,25 +44,6 @@ automatically generates the corresponding mappings between a value and a number.
 | Complexity: Beginner
 | Link: https://docs.rs/num/latest/num/trait.FromPrimitive.html
 
-Conversion from byte slices for types implementing FromBytes [TRSM]
--------------------------------------------------------------------
-
-We retrieve several structures from byte streams coming from the BIOS or loaded
-firmware. At the moment converting the bytes slice into the proper type require
-an inelegant `unsafe` operation; this will go away once `FromBytes` implements
-a proper `from_bytes` method.
-
-| Complexity: Beginner
-
-CoherentAllocation improvements [COHA]
---------------------------------------
-
-`CoherentAllocation` needs a safe way to write into the allocation, and to
-obtain slices within the allocation.
-
-| Complexity: Beginner
-| Contact: Abdiel Janulgue
-
 Generic register abstraction [REGA]
 -----------------------------------
 
-- 
2.51.2


