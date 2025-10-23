Return-Path: <linux-kernel+bounces-867760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584CBC03725
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8A01AA3595
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E345A238159;
	Thu, 23 Oct 2025 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f963R5Xu"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56222741A6
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252724; cv=none; b=t9H66o3u9L6YKyb1sPp5eGsYGHijFXme9sHV6fnJzLLQj/aJrajAR0TFFUctivBot1/jjjZNfWEkkiCLvC24ScIk2P4Bg9zwG0/zpqQcOPA1/vltdcGn0ISRBAYRW4LSOnWpzOvfUfCB87GcZcFxvA9cpInyxcaOMAzfqcN5xrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252724; c=relaxed/simple;
	bh=DJWdQiAIjZ0x6xqn9K9EvnwCkqDW3FIUIy/iqVqJsi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFjx4mClARwacYg0fTuN/+HAW2B1lKN8UK+Vx/uzQFlVyihvBi/HWD6TpHmi8TtBeN6wP3X7v10OZKIE4cPf7FZ3vOQsYDXAaY0NtriVcCRQO2679HsReoTMG4QY9ojvLeGsJ3tx1p8MjNjy7BmYfdg6JjrNjxBkGqnlPX6NafE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f963R5Xu; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c31c20b64so2380397a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761252719; x=1761857519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAPXNY+YzoexJ0d/TkSSgHS667VNidACYdJWMiQnzPM=;
        b=f963R5Xuov1yCJTSjhUsZPQdZTWaANJlOonkvPJzJwL2lbEmqg6vC+3dnA6Gc2o5fK
         hdCtG+N2zcmwJBw7X+bfetDlb2f2Xjg4R81fFMetWBJMV+LxMs+TRd9SmwzeTpqc4xOB
         L5q6sDtJstT1yHmrycq6DZhI8D/Znd6agJPlO8Nq8SxmOq1n5CebBp96kq1CWlQ3TXkt
         cawXUyD2pUvE5JVZWPh2DzsmlgEm3m57SbScV/Piocnvg8Kg9JiGB6iobgjeIBCERfsZ
         D8/bhy3cV4X4JNLfCoSx6A/+nCgwtg3DyVlbn5SwXjySQ0S8WAKyDmfpSZ/edsqx+QLc
         1uGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252719; x=1761857519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAPXNY+YzoexJ0d/TkSSgHS667VNidACYdJWMiQnzPM=;
        b=vUaropn0vnUHxqaNuaf4N85cAZ/rZNt/urvYPgt3NdGMOEiprIvxHBmTuRxztt7GQN
         jxk3RpJsUusaaNMRnM3GARmGguWKiL+N+otxYSjLLGq81zFAUB9zsz37ZTvb4mS1q1p+
         6Dx0M0ND6+E/oVgiqozuQYzpcakcbMg65DITvl1DSYxr/DY4ZIHj+N3H9etxrZlZe7a4
         sdzaUtXVyS6XM8rxxIDSNpaXBZGIobl0fL/P2rBPvsRI6fLxEeEbC0BByIsEbuAVg7MV
         EiZGjCI1Edhh1FEWx6Xh1qSuuaY1gXXswNDo+5ZnNrTSMvtgqG4CEsw8adb+6aao6f/e
         Yj7g==
X-Forwarded-Encrypted: i=1; AJvYcCWxTRNDCQ9bs93dYMggs98M6ZhqTbPgPvwiNTKRE3CWvNoHiF3hVjDsaBzQdlwPz4Lc00Mmouv1bCdA2pU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5XZRy7uFgFKqthJ6fF0s/q4Dv/Ai6iEgVtWWan9D9XJby66ZU
	detS0yhrsVeT7kl18mAEEw/Tpu+oXaSpX6iL8Q46vqduy3+wMLgt3bIk
X-Gm-Gg: ASbGncvK6s5V2L5gFUI4mYSJyg+5nu5PHGGl7v+PifhRA6cVK6xz6xqOAhEmE/sM3TJ
	so1Nziit8DmEsYiEUEEzkKoz48mLqCMqBWKIranIiP9xIfrpFpx1ePWr+7KCCWaJco8xvMUrRux
	rNC8Szbv9h1IiM7Pra5iAtWOUyLwiYE8GUG+D4gNBMCAS9ljtf4wfDdBv4Q8WWi4H8AnVQefdvL
	eERWn/jw6RqrU80Y5Pn1QsIBUidzfw7NlcvJ2cwsBJBsUYag1N/GNWf9Y3DehvjOPAZWKAq/5Me
	R167T+JDTJ6kRG8jvmC3m7y25w23i0BScgPS7tvuTGAs+xpx1yz6i2upksZ4IXGh2+wzayObezn
	05SG+ydoGMVhPANZaKtqGJG4kq3VzSxfvE8Vi88j0nPtYAS6XlKZ2QF33fiKPPpWmrAtxKSvyAm
	5omsgI8bcjW/JbEu7jdw==
X-Google-Smtp-Source: AGHT+IFOkN+DkcmLNJzRNIqysto7sYM8LlsTGTSLlhGfULzr9KAi+B1XnIznbLvzFcpxukEGtb28dQ==
X-Received: by 2002:a05:6402:51d1:b0:63c:3efe:d996 with SMTP id 4fb4d7f45d1cf-63c3efeee79mr22748502a12.20.1761252718877;
        Thu, 23 Oct 2025 13:51:58 -0700 (PDT)
Received: from archito ([2a01:e0a:acc:bb60:756b:64e3:20ef:1d08])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3ebb3299sm2564120a12.2.2025.10.23.13.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:51:58 -0700 (PDT)
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
Subject: [PATCH v2 3/3] nova: Update the nova todo list
Date: Thu, 23 Oct 2025 22:51:37 +0200
Message-ID: <20251023205146.196042-3-delcastillodelarosadaniel@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251023205146.196042-1-delcastillodelarosadaniel@gmail.com>
References: <20251023205146.196042-1-delcastillodelarosadaniel@gmail.com>
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
index 48b20656dcb1..be8063030d44 100644
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
2.51.1


