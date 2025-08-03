Return-Path: <linux-kernel+bounces-754428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D797B19436
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 16:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D411891C72
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 14:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B33025F99B;
	Sun,  3 Aug 2025 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpUfPy9Y"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9411B367;
	Sun,  3 Aug 2025 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754230887; cv=none; b=DPRNO3n9ZZJw8EOK+Fxn+/YKovdCFDKx1htNBz15ih70sRSglkxVgm4AVC1YF9mN3GgDVK6Hv+/zutWjO3OaX3Dbqp/WHRxlK35gaePjGQkEp+DC5mzKl0O0QonKIyxESDJBeGW2noQd2w+4xJAQNpyu2BmY2kFfYCLqdzvFLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754230887; c=relaxed/simple;
	bh=URxuNWQXyB0Ms6TEelOwSdubsMA5BX2aXgkqPEU1vJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OQZRjKCKzDGDBuvkMWm2Skwb4aSVph+NnyLWylSqAUzEKyZs6Lp8OxJJY52J5+aA7TfQjlDqmmmAAk9Wxk1XUcZZ8apXglBCB0K0iDeKS5l/UWjclQFljRDzt9171Owi+BEf0L2dq5OAwMwZv7a7JZX58Q806L6hONeXSdLUplw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpUfPy9Y; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74264d1832eso2807381b3a.0;
        Sun, 03 Aug 2025 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754230885; x=1754835685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G673etPTXeIcmcx61zJWy5V5b2tMbETyox5/A/4S4cs=;
        b=hpUfPy9YlSFgd3lWJVa9OScKG4tqMKaFl9cfaJX5K5xjoXBm7GQuRlJChEnl3ZN45i
         +JqrbdYhth89dY6q1z2uLmyvYqmTL6GivQmRVIohAdw85LTSp94FbDsqeCC1YBCLY5EC
         Nk2cT86PJt2pjfSo2Ss9LkUMS3BjouWHtglvs260ucxJugK/VvM/uSxx49iYHfpeHpbU
         8RQV9uS1E9R5co7fZsQdBTrUWtAzPf/j0t4Uq1NmnztkqZhDYLs5oxQy2ajkEF8KD+i9
         s+PlxsjrCFfdGV3AAQ/Nu88HgVVOc8yEkkZnxbh0DaI5n8rUVYbI7BuJcMS8eioTHLh3
         vWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754230885; x=1754835685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G673etPTXeIcmcx61zJWy5V5b2tMbETyox5/A/4S4cs=;
        b=bTqESgNYPotR7yINXBsZlQT13jUKViC9NZgKpjTzIPusB8V4gU6U6g7P2MFjrewXK0
         2NpGTkEpcPz9eT/ps1em/qYCVnzG+Mmw7AbCCzkAcD60232fe7Ji8iGiLycrEu0oZJug
         +oX48FK5zutkRjnqyTW+C5UlA4bVXjAcOHv/dLzLWkJfR5kJ+Ccb7/KAlgxNEmupD7p7
         80d2JAcTWur1FmbwCfoW9snUxTP7hky+WY08zKGLH03720gsGW6nCWS7NtT3LVfS2Jq1
         GoKrW5foWjjZ2VoXzePoCmdPphPFPJudAJyOw+5kKieyTiolXLA51dICk178L2BcP8x4
         RKcA==
X-Forwarded-Encrypted: i=1; AJvYcCXaghotFvMvz8OiGIMAl4pEtbF42vdU8qPRyMf5033cFTDAbztN75IzZWPMs+IlA2gAJcq5rTpY1qk1TzIWQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd5XpnLZIPP06PBtVHPFuYOTT6ZC5eICT66gjq2l0JKXD4OWTm
	d0b1L9RSMS7vhcULdiNSVPDO0RJ1kIvoA1MDXu6lYzLJQVynmKLVRwl2
X-Gm-Gg: ASbGncvoETLtijTLe231joZgr79Yi0ETrkaPcNV+U2cZkTs6z/iqrbwEZcy36jS1VMr
	FBRtcjHLn4fL3OM8meQx9LpZNXfx8ZIFgcOfBmTbK1yTo8w6JeQ34ICrsqUWeVg3KWzYzCB/12D
	95hKfHUyiBkDotzg8/NHDTDJY8rXYcH/xGttUTqP9ANPQSba7Bs9rB2xyYHlKpte5b5jaK2wy3X
	UZCEf3JYiWrv0SZ7BwpE8EYJ3RG14JL7Q13BnV36y8fk+Ns21WqIIV4v44w2wZF4HtdBsEA1L7T
	nMBKGit6RjitjcnCmzX3+tSCgw3c6X8aCq3IQ6+rOIDf2gZ8OPNTuesFdcAy4dElXzCqGDXVKn6
	AUwTNowvLedlv/wf0XabIGgNZwJPBhFDziA==
X-Google-Smtp-Source: AGHT+IGe/BhUamFbhOMfZiORHg14lmOox+kl2v8y2ocGIRHR1Q9PfmfJpWEEIbsCp12zkytZhwQ9uw==
X-Received: by 2002:a05:6a00:21d4:b0:74e:ab93:422b with SMTP id d2e1a72fcca58-76bec2f304fmr8216752b3a.4.1754230884756;
        Sun, 03 Aug 2025 07:21:24 -0700 (PDT)
Received: from localhost.localdomain ([104.28.217.213])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd0279sm8431306b3a.98.2025.08.03.07.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 07:21:24 -0700 (PDT)
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
Subject: [PATCH 0/4] rust: add `TryFrom` and `Into` derive macros
Date: Sun,  3 Aug 2025 14:20:50 +0000
Message-Id: <cover.1754228164.git.y.j3ms.n@gmail.com>
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

Jesung Yang (4):
  rust: macros: extend custom `quote!()` macro
  rust: macros: prefix variable `span` with underscore
  rust: macro: add derive macro for `TryFrom`
  rust: macro: add derive macro for `Into`

 rust/macros/convert.rs | 361 +++++++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs     | 239 +++++++++++++++++++++++++++
 rust/macros/quote.rs   |  40 ++++-
 3 files changed, 638 insertions(+), 2 deletions(-)
 create mode 100644 rust/macros/convert.rs


base-commit: dff64b072708ffef23c117fa1ee1ea59eb417807
-- 
2.39.5


