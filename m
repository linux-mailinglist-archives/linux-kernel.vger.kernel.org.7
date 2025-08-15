Return-Path: <linux-kernel+bounces-770209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D0BB2787A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35CF25A1C13
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223FA28689A;
	Fri, 15 Aug 2025 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSdYinFJ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270161D8DE1;
	Fri, 15 Aug 2025 05:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235948; cv=none; b=NZ/EmQ8fuX1JSBmQsqUOKXHDOaD3XzUGsC5KZiEi/MZuvRxVI7vkSMQaO6Nm0KDfVE5/hEzVttwRkklAcyH9cO1+iSy21hTzuUl9a5oBH8Fe8zifVeJFg+wgfsY7cTW6RdSfc7Ood9a/wJ6Go3lMbJf8+MK6jDlyTpknxPp1Otc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235948; c=relaxed/simple;
	bh=iwge3R32IXECx9RdznMb3cz0SdfEaiCmzyI9iQM6b3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dVMIrdu4kkyQt+Q5f1ytNWCWeKmOnOEXsyLlwLcGi6IQtwSEMtUkTD2a9+zMTCF4z3qj/w/iHHRR59I7FID04fkmNsQKetH1hoxUhDKyrZP32R16X1cbNoqdVep46DTiMNf4Gu52s7OLXVaVHnDtIxX/Ee1Khwu35FzH3DQoUNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSdYinFJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e34c4ce54so1209296b3a.0;
        Thu, 14 Aug 2025 22:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755235946; x=1755840746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tj8alhnC42zOgdWmbReIStJyeIvcsx7DOGYTDPXIH3o=;
        b=hSdYinFJ3kVVixhf+i9ONV8CHhGDNqb1y0BbxOINHuAqq9rXOuhT7vxQhpsMfo5A12
         J9nd/hzOUmO+LOQXy/607JgouWGxAgbwiL7zIFMbJENIaDJe+gNYX32qqcNKZmY6OyVL
         c5tdbMnmBjvKWdJw0KLpjvRwmX1Suphf4o+y4dnCWkH1F1UDyhyJLxikUqliruELx3Z6
         hN8MyoUrtaKcXxPncmoZd/WBS7r6ZVKFYQjhmMNEFvzc5sekVLn9kFPEE8BTftMupmNp
         vQdtTokeAgHBkzfBupgM1miXRkqsWIgUHBDi9oXTFQR3lEtRLvEdrdSnP/kaXMrb88cI
         ud4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235946; x=1755840746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tj8alhnC42zOgdWmbReIStJyeIvcsx7DOGYTDPXIH3o=;
        b=tLDzWt0i7cBvBjLPVKUPCfSSueY4kYskskclyZMCE5WHtlhNClUKvwpmbzbtAAerQP
         iHLAQj8bn0GzaQIKEx0H9ItiPvjuRX3yt0qju4bAlARfv1v8Ngy4x8bGFq2VDtzcF325
         Y6C2HB9JbTFZo8iQkFW1YgdeRfYXAjWof3QfKWKvbA/PIRqa5viyYnvsvSb6zrCuHVtU
         V8wLjvsHE5+SFLkuTCnjQcFYXeskDp1VbAxOHz6TMfeQusDUssXN/T70G54qLQVSFKdl
         1cyAJZNdVIGttXi3yyOxk4rUheIw42pvwKCEw3D/4TjjMWvupzYNrLW49+apiq9LygJo
         DVeg==
X-Forwarded-Encrypted: i=1; AJvYcCV58mdgtBFsi7hZAM+GEc/s/p6CQngrupJ4f+4V4ErLFWRv8m9Vuda+4Kvrq/3VsNnHF7yW1OILhjZWqAchGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp7Zcd4Iw44cTX+KyDzINV2Y87NmpfdKBeEal3CzP2b4hGq+Sc
	KZDGalSS4+NNMJhZvZku27FLKYQzZ9qy/cuI2p/EM4f34jgVjkasNPP4
X-Gm-Gg: ASbGncvryhxYUaMWdZVQ8dvCSJaYTC7eg0ml3RMOF0+QPsoAKU09ifZF4hU+3mJjI08
	RZyb5tp99b00IYUVZgTSr+G380nK8fKZPB0CT2BwiC5moXTC7V6bqPmyu/lmUMkHWtpVzOVaJBI
	oiIjWD7d2VXZQdomjSJd6gsX3AolW8JLdyn5W9q4t47hjDAt7GC05Xh+JF7jhGt5eG6xzioPsDR
	qEIdXCt7tnAOSG5wS6zvzAvSRfFZQ3YXJBLwuX1VpFg4XjLDgSecf1Up6ESxCbluYOPp+0wtA0H
	fY7UYF2EAsDG+FaHp/Kb12f8Soz4eL0LmA5CatTdtTetcOotZKjx8Z+KR8LADOPQHKHEEPu6QX+
	KX3aWE5EN7AGgQ/rVlzTOFnOHi78pNHBMkB3b3GxUHtE=
X-Google-Smtp-Source: AGHT+IFCsRaNxSKfgdKIzJGdC3kmDJE1saL5U/096QghmpyQmx94QRHF2hQOXKrFPWiqlWYXXcOugw==
X-Received: by 2002:a05:6a00:6f1a:b0:76c:44b5:4f62 with SMTP id d2e1a72fcca58-76e320e4f97mr7429186b3a.0.1755235946165;
        Thu, 14 Aug 2025 22:32:26 -0700 (PDT)
Received: from localhost.localdomain ([112.149.32.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4556692bsm335234b3a.61.2025.08.14.22.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:32:25 -0700 (PDT)
From: Jesung Yang <y.j3ms.n@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	Jesung Yang <y.j3ms.n@gmail.com>
Subject: [PATCH v2 0/5] rust: add `TryFrom` and `Into` derive macros
Date: Fri, 15 Aug 2025 05:32:10 +0000
Message-Id: <cover.1755235180.git.y.j3ms.n@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces derive macros for `TryFrom` and `Into`
traits.

A few enhancements were made to the custom `quote!()` macro to write
the derive macro. These include support for additional punctuation
tokens and a fix for an unused variable warning when quoting simple
forms. Detailed information about these enhancements is provided in the
relevant patches.

This series builds on the previous work [1], where the `FromPrimitive`
trait was considered too heavy for the current use cases. In response
to the emerging need for functionality similar to `ToPrimitive`, this
series also implements the `Into` derive macro.

The original discussion can be found on Zulip [2].

[1] https://lore.kernel.org/rust-for-linux/cover.1750689857.git.y.j3ms.n@gmail.com/
[2] https://rust-for-linux.zulipchat.com/#narrow/channel/288089/topic/x/near/524335626

Changes in v2 (no functional changes):
  - Split the patch "rust: macros: extend custom `quote!()` macro"
    into two separate patches.
  - Remove unnecessary spaces between tags.
  - Use a consistent commit subject prefix: "rust: macros:".
  - Add Tested-by tags.


Jesung Yang (5):
  rust: macros: allow conversion from `&T` to `TokenStream`
  rust: macros: extend custom `quote!()` macro
  rust: macros: prefix variable `span` with underscore
  rust: macros: add derive macro for `TryFrom`
  rust: macros: add derive macro for `Into`

 rust/macros/convert.rs | 361 +++++++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs     | 239 +++++++++++++++++++++++++++
 rust/macros/quote.rs   |  40 ++++-
 3 files changed, 638 insertions(+), 2 deletions(-)
 create mode 100644 rust/macros/convert.rs


base-commit: dff64b072708ffef23c117fa1ee1ea59eb417807
-- 
2.39.5


