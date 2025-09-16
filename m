Return-Path: <linux-kernel+bounces-818825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A614B596D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3511C01399
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EF730CDA3;
	Tue, 16 Sep 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKfGMmid"
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7162D7803
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027685; cv=none; b=Q6DzM6VUujEzyyKk3Ehhd9CVR1QMURm0wePbBJ6i/F9Ro140vgLi5wse+elTIErzRPcUy4G2loXVvVjBRqiJ/fGTGswxNkTBUeDA3+E56E9oj0GgJcl64c+OC1x4fzD9IAZWbevkXlNnuoTmD+qxv4NZtDRJ3H8Nx2UTjsaXRUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027685; c=relaxed/simple;
	bh=ijEVJ3RCDJHNXQSSFS2h6wbG7e51k5u2dlJCJBgiy94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TvFJwZfGDTVHoSMQKInuhaRImQE/PkecBiYgk8ZAfJZCj0SWuEiE+91QQ5KiOaUo6QN0i/ltaQwXK4FOdHsLKO8voOuKErVGohUswnBqXsPbUUNquy5Joai+asc100FmKpD72Sm+l9HnwVqJsNI0+m/rdhgpvXkvU0dGM2W7B8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKfGMmid; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-32e1c68d806so2088992a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758027683; x=1758632483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RP5wUBXQx/eVCQg8WvT3qU6fnoKH5dLQkp1auUt9HmA=;
        b=DKfGMmidbaHtpq0zdXluCaHXxr4QGJeK4IoHqc6wd7tbN+ZWPLq85OsqoGbSnb3z3J
         Ba3rJTeWADUCvHJF0tUJMPkw/DkrEIMXIGga1sdReu9BnBzAuX4VLuMiuWi1q2AFXeYR
         jQ201KK3mjKve1b20TR6etrMbw4A0T3TnKJTywQrAIO0POSfGyAVgwSHG3xmPBpSr1ii
         o3fU/tnvvn16rNG958QbQBw+N+ACbjXf6DFoMFxMuKmJjE9VzvjzHvMTjFL74vlm/eYe
         KZxtrOQL5ZUYjK4gHRjJPyV+dmjlTNtFm8H4px08VtXldiyhAxseCq259f36d5EPqOjl
         bM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758027684; x=1758632484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RP5wUBXQx/eVCQg8WvT3qU6fnoKH5dLQkp1auUt9HmA=;
        b=o5ijloRMbDQIxJn6wLHEqh6HO2j2QqRlVDQY7haTOJS0haFnc7S/cBZAK/NmCl5LAU
         GIQFukVWh4wVxTlEc0stGkkCpLUFBfctl/+wjdjxcw1fy2ru9Gcz8mQW+HQY22Jy3J+X
         M9Kh3ePCOaM8DF/Gn9JrZh8xmuQ9EZwIOPU7PsHWIluN5NBB6RDJtAMkJPDNe9VfMSiP
         LkUHrUMjJFOQh+bbcAHEdPyr7sWfmgCe5foOjMk5ypafBy1aQLoms0N52N5NgACqptaa
         di3XyFC4yxqMGHSBzUgxdAH8QA4xC0UX1LsXmL2UcDTj8ITKJxOQ+zxPsXE6qHkLBXeX
         33xw==
X-Forwarded-Encrypted: i=1; AJvYcCWQoWiGoI4SOoX2xt9aOwbDyprvKNNwCBwJGW2Tltw9kYq4Qhhp61SKqVOn51KHGOVre86TXVkLfmuM5s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEqL+/4t7iMPcIKC0lL/ra4nQCQG6Nkzf9VlIt3n7XiF6D/t+C
	0Zo+rSxvFpkuA1H/xDtG/UlpIpi99dcdYVs579Pfr9sVMmGb8vyRjzk=
X-Gm-Gg: ASbGncvBsRwFrWOurZcsBivedvK1ifg2r6nH6J9HgKMdn2eHe2EWjmxap2QgGwtQc1X
	U45H9ovICAmxkjax1mHKmU8oOwQibi7S3JMvQovmXwmq0U32+5GJVGIf1SrxVyjE/YR6XT+CWtj
	/TY4ZpC7XzA+4CoFo1tYEcV5sveVh8BFgjYAaI5a1O1IozcQxX40zzTgcLh26kKLzmk9g3OwDmq
	s2CdtV7NBkF8ii3h3hHxHznzvhNSyRdod8eIis548uFjB94TfWjcxvg2dAxlcnG7QeSFEPLGz4j
	qJPFi3ZD782sI/MfA4YjN/0z6wSdPrzdGeu7JpJxzcWGVLnJbtdn1OtzCcBWGGxuiSHIfTF8G9p
	Q6p5fDpNPfjOoWUoFAjwNXCcEe3XGkXjHYaO81JSQ9za8RW88ueH8vTs4L+Ww3oQcAs4dwkLQAQ
	TVYhWwDjOoc5iuNWTGp8Tp+GwWbqxqZvU=
X-Google-Smtp-Source: AGHT+IEC7TPSUCMJ+hGpDzxTsleVcYPGSvPYPtbVhAREzZU+U2F/nc42NnIvVKgmDSI3sK1x+yqX7g==
X-Received: by 2002:a17:90a:d40c:b0:32b:cb15:5fdc with SMTP id 98e67ed59e1d1-32de4fba102mr18651053a91.30.1758027683204;
        Tue, 16 Sep 2025 06:01:23 -0700 (PDT)
Received: from codespaces-8c10cd.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net ([23.97.62.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32e1e5ad768sm9345943a91.0.2025.09.16.06.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:01:22 -0700 (PDT)
From: JaimeF <jaimefine6@gmail.com>
To: gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com
Cc: david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jaime Fan <jaimefine6@gmail.com>,
	onur-ozkan <work@onurozkan.dev>
Subject: [PATCH v2] rust: auxiliary: fix "initialialized" typo
Date: Tue, 16 Sep 2025 13:01:03 +0000
Message-ID: <20250916130103.22946-1-jaimefine6@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jaime Fan <jaimefine6@gmail.com>

Fixes a spelling mistake in a comment: "initialialized" → "initialized".
This improves clarity in the documentation and avoids confusion for readers.

Suggested-by: onur-ozkan <work@onurozkan.dev>
Link: https://github.com/Rust-for-Linux/linux/issues/1187
Signed-off-by: Jaime Fan <jaimefine6@gmail.com>
---
v2:
  - Fixed Signed-off-by name to match From: line
  - Added explanatory changelog paragraph before tags
  
 rust/kernel/auxiliary.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 58be09871397..129eae8ff2e7 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -317,12 +317,12 @@ pub fn new(parent: &device::Device, name: &CStr, id: u32, modname: &CStr) -> Res
 
         // SAFETY:
         // - `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`, which has
-        //   been initialialized,
+        //   been initialized,
         // - `modname.as_char_ptr()` is a NULL terminated string.
         let ret = unsafe { bindings::__auxiliary_device_add(adev, modname.as_char_ptr()) };
         if ret != 0 {
             // SAFETY: `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`,
-            // which has been initialialized.
+            // which has been initialized.
             unsafe { bindings::auxiliary_device_uninit(adev) };
 
             return Err(Error::from_errno(ret));
-- 
2.50.1


