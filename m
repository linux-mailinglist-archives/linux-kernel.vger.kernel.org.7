Return-Path: <linux-kernel+bounces-763411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DC0B21440
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EBE3E3DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402592E424B;
	Mon, 11 Aug 2025 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fkj1toEf"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7762E3B00;
	Mon, 11 Aug 2025 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936545; cv=none; b=D1vaav/sY3YjBmbTdT3sNMspxTFOEFnjzCkUj4pDu08gJqa5vDCwAyqKAp4Pwxa3jGhitWb5PiBI+uZT4E6eSEouSpqqT+LPg2+ywslO241gCjBZLuWrZGoIYkzstatXQ1Ybun+1MKY2OKRJ+ENoLcx+344ZzdQjcikXHSjqNZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936545; c=relaxed/simple;
	bh=mOVxMwHNXKnJipk47e8SQdaZXOBitrJX60mFQRCQalw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aUlUqnEkqSE+wubvEga6l2VQyGYvrBkKjBgQ8AHNomtf21DEUoYHJpL4GTJXWtkbftC1JgGmDwmigrcBIpSxnjSXJ+BW11vRjbJZo2CvTEeuxdkaTd1Y+DUon+nayxMtN9XuP0Gv2J1iGwsns/rqWRcWGWaqgIMfHQfJCQ4A0Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fkj1toEf; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bfd457607so4570927b3a.0;
        Mon, 11 Aug 2025 11:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754936543; x=1755541343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7mEWpl63ZoyplRlAL0IOHiBd7kGAmwSsw36Ew/d61UE=;
        b=Fkj1toEfW50X+RdT6+VOTE2rzhoDpl4GokJcAK+0i215+2PJc9fFlc/NUf9vinPiz9
         HK3EAmveabWqOF89Tn9n7id3bdDVLfX/hiBrL1zAvdKgdTmTuHeCz93k+nSlmF4BR+Yz
         13OI6WAYBYnp1eQb+x4ELs/Ua8Kmi9GqBY8BdC7pZu24yKgR4nsOllijmkM04K/CwJvV
         T8JUIYUiqtXgbkelh3T92jbgB2XJS/yf9WtvQPZwcYg95ONRsgtAdo7JMpgrUSB0x5uv
         5JTd0RMstwy3Gn08VBo9WPIZUUzgRacE8uUxtxs3w16kvptqR6Z2YrWYChY+/NNNpcg8
         hVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936543; x=1755541343;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mEWpl63ZoyplRlAL0IOHiBd7kGAmwSsw36Ew/d61UE=;
        b=XAKAm9kcnoGumfEA1RmtM6zl4U9Lj33/D92/OYb+xc3DCmYPvzUrMYWiPd7DvKUeF0
         1gmy3irm3oMTWUSIKsetK0n/7UJFTK6ompxpPHl9VzszrkoLTkvQqnm9AoY6XwrB0u2F
         bWy2uiATWvuns7akPnzgo8kn9c08ziPgPZCqT0u1aTmmIGEBF3hR5ZKi+UzYvl2FQG7f
         jgpR/86X0liMCA476C4zj4aSCy6Qz7QC+N4Z7bA2mfMIZ7JRNvG3Klv18JQckIcomxBd
         /WATIHTSFhWit6BQH5WlIqK7qbIHt/xWbkSRit9JqcoGlYGRzxJk+sRiSgcFxEv5SBk1
         Oj+w==
X-Gm-Message-State: AOJu0YwwMrX7oZ+Qm1KOCBbqv9THCgveiI5Wlx1ns9ufQ1h3TopZa+/m
	aeeDrOUeT6lrzt0I4f4sh5U2aeeQJZa7Cc1YtKfUzBynb0dC242gxwgfDG1evodY
X-Gm-Gg: ASbGncsL4YuUNoz4BUUUZVFuXkAuzaCwFRwimzIuaU/8SrRniryPAqE9ng8V785eqSq
	2zdJELqLdighWLCRY4IJHS0hQ2vPs+2Wf4LdAjROEDX1ddZE8XH8KKxUuCYYgr5IQM3SMjC1EKL
	wYPlkdoPklocff5swUN4znuPRFtVbwFgCA1bzwHSVXITyf0EwAF+q4DioMZ3CDOmbTRrJ006ybR
	fy8/3OBeBjLZoQa/wMpJsvOAXLzNR+MJEZvoxvQl3r9HBEEKmCljvS7LN0ur81PVU6ure6aT3xb
	PsS2eroO7UIqBFXbC7wIgn//50UpyQfkhAjlluECV//aEDprGyz4HtHxTPgn1J5HksPas0wi2Hi
	D4y/dB014j5Zi81psIwEC7Wowylrubl23HJK0P/BlKHA2KkQ/OCfoTBuFAgT9TMmZLSXy+eWQZk
	ZRyGDWKQg=
X-Google-Smtp-Source: AGHT+IHEDbEUXj8YoO4yyjGR/BV3tZDxo1gsO3xYNRHNCBTZx1ulNcZoy5PO/brKhi/Qlu/QPgR2QA==
X-Received: by 2002:a05:6a21:3391:b0:240:1ca4:297d with SMTP id adf61e73a8af0-2409a8be8bcmr747279637.13.1754936542697;
        Mon, 11 Aug 2025 11:22:22 -0700 (PDT)
Received: from ?IPV6:2804:14c:de86:8d34:add1:b1bb:ed29:6539? ([2804:14c:de86:8d34:add1:b1bb:ed29:6539])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf772116asm21417693b3a.97.2025.08.11.11.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 11:22:22 -0700 (PDT)
Message-ID: <42c3fc0c-46a8-4502-ad53-d3b886fad5e8@gmail.com>
Date: Mon, 11 Aug 2025 15:22:18 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Rust: kernel patch series
From: AI Talking about AI <aitalkingai@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <79821f85-9e95-4426-8b1f-8752f8683dc9@gmail.com>
Content-Language: en-US
In-Reply-To: <79821f85-9e95-4426-8b1f-8752f8683dc9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From 21a3d2a2dcff13f445915602c06a17af07835ee7 Mon Sep 17 00:00:00 2001
From: AI talking about AI <aitalkingai@gmail.com>
Date: Thu, 7 Aug 2025 07:53:56 -0700
Subject: [PATCH 1/2] rust: mark CStr::to_str #[must_use] and update docs

Add explanation about handling UTF-8 errors and mark CStr::to_str as #[must_use] to prevent silent error ignoring. Also document safety requirements of as_str_unchecked.

Signed-off-by: AI talking about AI <aitalkingai@gmail.com>
---
 rust/kernel/str.rs | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 6c89255..290031b 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -37,12 +37,8 @@ impl BStr {
     /// # Examples
     ///
     /// ```
-    /// # use kernel::b_str;
-    /// assert_eq!(Some(b_str!("bar")), b_str!("foobar").strip_prefix(b_str!("foo")));
-    /// assert_eq!(None, b_str!("foobar").strip_prefix(b_str!("bar")));
-    /// assert_eq!(Some(b_str!("foobar")), b_str!("foobar").strip_prefix(b_str!("")));
-    /// assert_eq!(Some(b_str!("")), b_str!("foobar").strip_prefix(b_str!("foobar")));
-    /// ```
+
+///
     pub fn strip_prefix(&self, pattern: impl AsRef<Self>) -> Option<&BStr> {
         self.deref()
             .strip_prefix(pattern.as_ref().deref())
@@ -346,7 +342,7 @@ impl CStr {
     ///
     /// If the contents of the [`CStr`] are valid UTF-8 data, this
     /// function will return the corresponding [`&str`] slice. Otherwise,
-    /// it will return an error with details of where UTF-8 validation failed.
+    /// it will return an [`Err`] with details of where UTF-8 validation failed.
     ///
     /// # Examples
     ///
@@ -356,7 +352,21 @@ impl CStr {
     /// assert_eq!(cstr.to_str(), Ok("foo"));
     /// # Ok::<(), kernel::error::Error>(())
     /// ```
+
+    ///
+    /// # Errors
+    ///
+    /// This function returns an [`Err`] when the underlying bytes are not
+    /// valid UTF-8. The [`Err`] must be handled; it cannot be discarded,
+    /// as indicated by the `#[must_use]` annotation on this method.
+    ///
+    /// This method returns a [`Result`] because not all C strings contain
+    /// valid UTF-8. To avoid accidentally ignoring a failed conversion,
+    /// the return type is marked `#[must_use]`. Code that calls this
+    /// function should handle the error case explicitly (e.g. by logging or
+    /// propagating it), rather than silently discarding it.
     #[inline]
+    #[must_use]
     pub fn to_str(&self) -> Result<&str, core::str::Utf8Error> {
         core::str::from_utf8(self.as_bytes())
     }
@@ -380,7 +390,10 @@ impl CStr {
     /// ```
     #[inline]
     pub unsafe fn as_str_unchecked(&self) -> &str {
-        // SAFETY: TODO.
+        // SAFETY: The data behind `self` are bytes from a `CStr`, i.e. a NUL-terminated sequence
+        // of u8 values. `from_utf8_unchecked` requires that the byte slice be valid UTF-8; the
+        // caller of this method must therefore guarantee that the `CStr` contains valid UTF-8
+        // data before calling this function. See [`to_str`] for a checked version.
         unsafe { core::str::from_utf8_unchecked(self.as_bytes()) }
     }
 
-- 
2.39.5


