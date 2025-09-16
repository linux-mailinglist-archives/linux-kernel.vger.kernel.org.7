Return-Path: <linux-kernel+bounces-818780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43027B59660
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774D6188E823
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B4130E0CD;
	Tue, 16 Sep 2025 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgGCR0PQ"
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6791021CC59
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026483; cv=none; b=u8Phtava1nSLOcavPS6wBV54cirCW0dQWbWAMsc1EhAJCse/a7dy2rq4V135HdL1Fwmi80ZnCf7OZu5Pt3bEMaIxTj3E75hPNw3doSitSlM4N1yye0frmqHjut2T91/8qNhKuxuQG2KFYAtTou0Y+WPfTQnJXq4leBJ/3VbLiU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026483; c=relaxed/simple;
	bh=iuY67WVePs9KiduC+k9AQZP60zJpeVxjLxorW0CY2MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p/amE2qQK+ZtKfWFqJlnIw4BSwLE+fyl8n1oLm97uRYgHZxF93rMtj+CizglT5jDybvD5DCrO6Dntdt9yDe/3el3OQxv5V60BUOSDLC7hgUlWS/FCDKHsPV4sPlpTIj0XE4DHA3EvquTSxl9F5fbSLLaGeqpYCaXQJEUJWvpUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgGCR0PQ; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b54a8c2eb5cso4279225a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758026481; x=1758631281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2tqvSw+O2QuvnDz6ws7PU1PREoECQAI/OBK+RkGaDJo=;
        b=PgGCR0PQojYebOE2e2JVaOvKTutdVoeMy9HniSlQf5Kj0MtLreNrtD8fw9KSEvdkS0
         Kq2qPwogbZc5bkjW9ImyhwTmcY1+hwWeRjzL36DzanNpSO4nrJjq+me4JC8XDakA1gKr
         5TFVNDp+wtwfHbkFSkRS7+GJofGRI/pqIO7SuAw6MZXXSipCW0AYBaW68EtcWaqMMMno
         ZDwOueL7YZA87bqG3RQohNqlqkqyqTkcq8/pTxffRRQxWpg5MQySbN2FNF9ENxqF/i+e
         GlM5otOS28pnQECmhscGZglPJDGJxdAhtjPWteVdY3I/KIanS+oUJbD6iWAj86W1Ao0T
         nvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758026481; x=1758631281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tqvSw+O2QuvnDz6ws7PU1PREoECQAI/OBK+RkGaDJo=;
        b=oI6w6yS5C28Enmchq8Mufc03iIF6zzElSW5u6n/ldVJTjIzcSC+YoVEyDU6DNSqq01
         kdDd1+liPNYeg8qiBIJOXPA6vKyTuZ4aAAb2+UpMu46EYXXjRbQe/EiuhGDiQBxkHm9Z
         pp65tGgJjxGksIJkIOEBj0pRyN5Srg53tbA6MeLutc0/tzMQQaYZHaGPYFhfbRfzmTq0
         9qqKE6auUmpDcERjHbmVsf5FZaQtFsUVVK6kKUQ9jxmkk4ot8zeXptdKJRPnDFuQkcro
         I1J2gNZ2ddIcfSW+SfZTTAveyDidOESmfZF/XyhpWyk4O4mAtSx+gMTO4TNPh7ouNKsQ
         Kqnw==
X-Forwarded-Encrypted: i=1; AJvYcCU+KfB0oehNt2CCeAl11PlXNqxx4K1w8fg0ngUOoIQwGrdGng9Ip2/hWU7SNg02fe7eUXsNjcqaelgM5/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO6oHi7Fjo1qOl+oRO3xvwRcZg6v3P0bA7+nSw3SC41WK328/1
	eNnKsNW+IMHhxXTSLNi1Y3wDO2M5kiGMgyZJfnrzlRi7LhPWpLcp6rA=
X-Gm-Gg: ASbGncsBgsSn8xzEhi+YkDth/uZKf1kYW++xsQfMEsoXHBbH8Rn7jFFNzCATTKioN9F
	Uhsup4rMMx9C8fwD0t7GWEZy1EgM/IORrYKZRlfDfmKuEHmfBKUZZvtD0gLuSbMbGBiEYNG+jVg
	+BPshGVnkD0j8zlIAc+xRwD6j2G5bQ79b+8jawRXs3Vvr4psitsSDhGoyCSbyKVRLUO/+sEPjHk
	tK1ICOvkSus4rjYNEyhS73dhNtLZLl5cWFKsebPjTi8I14AQ2sl74kqlLG4ie1SEbTx18WLtJ5O
	Pa62iVu4cDaxxYHH7X/7FBvYIDW/wc00jS9zxg2/edJB7fzEVi1SsKNKjZkS0hyyKbGM/jvwDuh
	QaivKFO8y2903CpQPmE2lDjr/n1Y4IHnhgc4sf0p8e++rPXS+5OGK7K2wvbNVidDoNwc38WBLGM
	HZ9aEHToPZuzkJ/bcyInO6
X-Google-Smtp-Source: AGHT+IHgUg6djFhXrbzUFkEtt+EVn1UGwMgH0i5j+uCXI/1jMyPy/YHcFq03zuX4cZSzyNY+bhbKsQ==
X-Received: by 2002:a17:902:d2ca:b0:265:ff71:401c with SMTP id d9443c01a7336-265ff714151mr102482135ad.27.1758026480624;
        Tue, 16 Sep 2025 05:41:20 -0700 (PDT)
Received: from codespaces-8c10cd.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net ([23.97.62.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26175efc667sm97050945ad.112.2025.09.16.05.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 05:41:20 -0700 (PDT)
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
Subject: [PATCH] rust: auxiliary: fix "initialialized" typo
Date: Tue, 16 Sep 2025 12:41:02 +0000
Message-ID: <20250916124102.14182-1-jaimefine6@gmail.com>
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


