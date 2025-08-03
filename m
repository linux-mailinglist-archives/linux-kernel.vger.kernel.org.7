Return-Path: <linux-kernel+bounces-754469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D70B194A2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 19:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEB63B540C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0431D86DC;
	Sun,  3 Aug 2025 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZQwhEGb"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFBF74420;
	Sun,  3 Aug 2025 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754241025; cv=none; b=XCXhw++9FNEWjWkf7K0gFP75J1Ap04yVJR5X98kbKUADcwlJhIpoOSPCsMJHotNy6T0/H53IYcbw9OqyAQO/jcTo94laWqqUZ0ZAuLBGVT6HIF8X750bj7Q9L77V6vofQM2FVdyzNRLf3euUbrzxu5UvEz8PwRq7CEdqSOtkUww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754241025; c=relaxed/simple;
	bh=Z6rfeoM5SjHM5As1Ad1NT7kXJoQDl6JlFi0x7DPVbJs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hH1JIHvBBHpZWKSP7jPDillKKSfsax+cUsMSx8EoQdtTJhgHLkmf98Vdkjv7YMDYlo00H+sB4vET5/HLSrfw7kzn4X+Mw0xunw7Hqwd1oGcfMWoa/9AwyESEQBM8nD/VD5JjyWT6KCWhJvNOSEajqo8+MZ5Iy8INruJwO3p867M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZQwhEGb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24003ed822cso19509225ad.1;
        Sun, 03 Aug 2025 10:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754241023; x=1754845823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ueluHIyEd8/bCVWXSdSve5OPZwKCMfRlWCWLWCluXw4=;
        b=fZQwhEGbxXx8xAnCIfbapDFfnq5n3RmGdYe/Vz9D+VJK4XAMGVb3y46hBG2zjKcFa6
         jcyUHx17SHzYSthBuw4YzHqTeCdVoy73sTaiIDEN6SaJcPiEQWd+YecVPVQXvHP7Em3B
         XO0GoyJpoouGwhFrtWgsIg+nA2RpKZyJiunsbbYo7McEUfodj4qZATd5eHc4VNASoQNR
         qDXlgez3AzjILbQfznnvYM8clWnfWGDbgJxsSc4jCYMoRW4QJgfskc91Bh3IIscirrNq
         5HSc/1Lla6YLQEa/zpNAoarJCgVv6E4jWYEQyghsNCljJFXThNNObCJjFdoLv2qSd2hY
         IR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754241023; x=1754845823;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ueluHIyEd8/bCVWXSdSve5OPZwKCMfRlWCWLWCluXw4=;
        b=Rv7IotrkF/19xbGusYEnzjcXlJOQPcmqYirQ9JMmhEef4bsT7pFh+tEGDx/Y84MuUj
         hXXR6HLP8wEFqgcoMDvoPwLhPn8K8xTlGAPmDGmT6cLd+G1LyqYc/xarZFqwScE2bELP
         CUfVEoLWQ/s187+ZK934H6KYTWAREOmF92xzCrlm2vXUn+njIEtUnlw7i+qN88mp0YYV
         XBnzNrNu5ARon0LaK27mzrx9qKebBhX23G/jMr632OqrssLKAsUDFAytB+7IJKA0KV8a
         Zp9oUhaveiPmwEWeCsYcuoaq6KOUAiYD2yE+dwhq5ZbaK4i+3p4V7dAtR3yvQHWaiIOB
         tfsA==
X-Forwarded-Encrypted: i=1; AJvYcCVMMfKdfg3DtfeOLk9dYaV2Enpv2KLnGMMLCOziWAW7slalUPLO0Z38H9bChnmA1CzxKyymbMGHGfAlwlneAw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfl0F5ExnpN90ILrsFcmyYo09OD3D9HJVWLNqGxLpb0nMXKLhJ
	DfOXpZW9nV75nU9FyW/SiKCjRwoV1m1UCUGgODMwGnBtCWvfQb3ki1TKfRf8zfVoOD4BomE14cJ
	1WfGBU20OSnG4hV0yJ8PUZyEaXpkN0cs=
X-Gm-Gg: ASbGnct/Y8Y2WpCxy+9ANzSP/SSKBVfm7Ux7IbCm2MdaWc7AECkgP3e9nCOps5G3Eyx
	5V6L2lxVDWJvyu3nbxbxN4cMl9pGYhBQvTANUcmDM0x8EAzC5Lu833wec/IAMLbxIMxnGrdLXiO
	Ay7zY0HYdRHFxdCfMY8CiCiYDhlM63bMtKKcJEsVD7M6pdb2StMtlN0gCuMnMCdyVcuuHCzZcqT
	XnePhv3Aktn8F4VFoo=
X-Google-Smtp-Source: AGHT+IE5ojc0C1gLjLIxqPuovL3gOAFiQT/CuvYNdpqBkWurzGhWfYEspXEQYyOmEwsgkOSr0KlvNzIO8YhMdI/uvy4=
X-Received: by 2002:a17:902:ec81:b0:240:71ad:a454 with SMTP id
 d9443c01a7336-24246f1fdc9mr105877215ad.1.1754241022939; Sun, 03 Aug 2025
 10:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jinheng LI <ahengljh@gmail.com>
Date: Mon, 4 Aug 2025 01:10:12 +0800
X-Gm-Features: Ac12FXzN-AVCUZm4dSLiz3BJCTnkQmDDdDzAhPca8ia2sgJshzVB9wMd71xNK2k
Message-ID: <CA+TpbOLLATyTRtNxVEJ9Dz6=YSZHAyYOrt20TR8AAEfP+qm1Qw@mail.gmail.com>
Subject: [PATCH] rust: kernel: add missing safety comments
To: ojeda@kernel.org, rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"

From 5cba005b59a032fc80f818b393b7e4c36a460710 Mon Sep 17 00:00:00 2001
From: Jinheng Li <ahengljh@gmail.com>
Date: Mon, 4 Aug 2025 00:56:11 +0800
Subject: [PATCH] rust: kernel: add missing safety comments

Add safety documentation for unsafe functions that were missing proper
SAFETY comments. This improves code maintainability and helps
developers understand the safety requirements.

- str.rs: Document safety requirements for as_str_unchecked()
- list.rs: Document safety requirements for remove() method

These functions had TODO markers for safety documentation that are
now properly filled in with clear explanations of the invariants
and caller responsibilities.

Signed-off-by: Jinheng Li <ahengljh@gmail.com>
---
rust/kernel/list.rs | 5 ++++-
rust/kernel/str.rs  | 5 ++++-
2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index c391c30b80f8..b9dbb73a7ebe 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -456,7 +456,10 @@ pub fn pop_front(&mut self) -> Option<ListArc<T, ID>> {
  ///
  /// `item` must not be in a different linked list (with the same id).
  pub unsafe fn remove(&mut self, item: &T) -> Option<ListArc<T, ID>> {
-        // SAFETY: TODO.
+        // SAFETY: The caller guarantees that `item` is not in a
different linked list with the
+        // same ID. Since we have a mutable reference to the list, we
have exclusive access to all
+        // items in this list. The `view_links` and `fields`
functions are safe to call on any
+        // item reference, and will return the location of the list
links for this item.
      let mut item = unsafe { ListLinks::fields(T::view_links(item)) };
      // SAFETY: The user provided a reference, and reference are
never dangling.
      //
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index a927db8e079c..8fe9a15fc16e 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -349,7 +349,10 @@ pub fn to_str(&self) -> Result<&str,
core::str::Utf8Error> {
  /// ```
  #[inline]
  pub unsafe fn as_str_unchecked(&self) -> &str {
-        // SAFETY: TODO.
+        // SAFETY: The caller guarantees that this `CStr` contains
only valid UTF-8 bytes.
+        // Since `CStr` is guaranteed to contain no interior null
bytes (by its invariants),
+        // and we're excluding the trailing null byte via
`as_bytes()`, the resulting slice
+        // is valid for `from_utf8_unchecked`.
      unsafe { core::str::from_utf8_unchecked(self.as_bytes()) }
  }

-- 
2.39.5 (Apple Git-154)

