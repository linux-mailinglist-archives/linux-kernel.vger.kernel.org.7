Return-Path: <linux-kernel+bounces-746743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC168B12AB4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0357A7AB165
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D0B285CA8;
	Sat, 26 Jul 2025 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1alVtXGx"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDFD254841
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753536220; cv=none; b=IT3swgkX0faBnn8ewllixkRkMMDEzstclhufhgGU0TW6cnEKWRhz6vCAHFHNRtmq5TUzlScAUHuOh7CjNG0mhjngJH5yjnX1X7pV4ZtOegO+iVyBNtj49FFW9UFuu6VOplDwmmpX/GRciinoVqkamRVGkwS7NDOSjwYg2sbLC4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753536220; c=relaxed/simple;
	bh=KeWfTnh8Chuw1TOz3MzZf+vZMoN7xHrcY5K2UXkz3KM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FkSmQeEMG9+XZMjQWuXTNrzsdHIbA2v1/MWjKeD/cpdlJbHHPaqZqWX0ZIgUxm8bStePPjKNEdhtxwAWx7dANcEmCvHbHVziDYZX+EafXgZADzYX3iihh+1gBafva6dJ8Sa1n5KKj96rfDdseGMqp5lE3ieStlPI9kP2PQLw/W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1alVtXGx; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-613559d197dso2550574a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 06:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753536217; x=1754141017; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v6pXmOOa+uL3izdLaylEgPW09ZR5nRV/PajHQlIRQ8c=;
        b=1alVtXGxF0n69rg/1ECorCgnwsw+3q3FYAO/bTZRKNGUzcpfmv1LAseIQxns5RpaVQ
         Ju/2jtiIbj6Cu6Fop2gz4hrhFyXNBozCf8Z6zxOxJYgKk9SCjYoNQBVeyVKx6fkOdUYa
         j8oz2wyZ3hBXOitzbgejwFgUdbVrlKGqkFcNV22wdD4lAdms9sMxqJSRZ0W+FwdEAelv
         8HUZTezOzn0tdBYX4o+e4wNE9AVDCeHHJPtyff2ag1n9zQdzb0SfDwSn/KAX+cwWuci2
         VsDyucG0rOyOZg8I8jaI6YjpTsi/pzX45Nyv0dnTlegTE0I3vhVaNYh83V/KuEvEOXX5
         mtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753536217; x=1754141017;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v6pXmOOa+uL3izdLaylEgPW09ZR5nRV/PajHQlIRQ8c=;
        b=oqTyflQrz+qL7XYs4kshVv/hhXFzNeHyvpt9MEgDO1MVPy/ZMJwXPyO9Q/vvNumue1
         dw2QA3q6s1cPqDqQ9FoCMWYfr2Wn94nPk4YdwP67/2kcBbzH+XUWmPQhNtGE1w0aV/JY
         6aEbg9/cq7bjMiuuMigds5E8rz6us++6VDUgpDT7gishMQI9xuGsWWLk9/JlRCWVvuNH
         gxT5yvFQ0BnJKHGNRCCFp7QdcHFsDTfiIgQr+EWd3HY+vvB2cYAANErcp7VyEGXP4ToG
         C3Qtl2KNdbJR/lRr6Wxg0sUEpywEVCfsOv5vlIxoguNqkeYim7H8UxNizMsfS2qtcWUI
         4n9g==
X-Forwarded-Encrypted: i=1; AJvYcCUeLlDtrQNAiXFvrQtf80D38r7WjH9D84BBqwUOnbxd7LPxe9nybU1YqnA2QyVkFgMyHSFKAFe+qEIGfv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbxCmjukYQvMf7F8ppSGSU9/8a5BqYAz0k4cFpTVu8J20bDStk
	FppwYopnUKWoqNb3ZtTN/i/Xlk7VJ9FBgDF8MHa0YHB4i6xHamIZLxhudvVUAcK/wCCT2u5aAS2
	o0w/meuV45HLvL4rOIw==
X-Google-Smtp-Source: AGHT+IHWglauExVkBXOOx026pljplAP08f0yD9Cr0BMTM6PlulvfQerRxLC1kYo6rMFl/9nKW2LJ3nTgSyP3ULs=
X-Received: from eddt16.prod.google.com ([2002:a05:6402:5250:b0:608:8531:cfba])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:524d:b0:612:d8b3:a9e7 with SMTP id 4fb4d7f45d1cf-614f1bbc851mr4834520a12.5.1753536217105;
 Sat, 26 Jul 2025 06:23:37 -0700 (PDT)
Date: Sat, 26 Jul 2025 13:23:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMnWhGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyMz3dzEgpxU3ZKi1FRdw8Q0AwsD48RkUyMTJaCGgqLUtMwKsGHRsbW 1AB9VRGxcAAAA
X-Change-Id: 20250726-maple-tree-1af0803ac524
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1557; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=KeWfTnh8Chuw1TOz3MzZf+vZMoN7xHrcY5K2UXkz3KM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBohNbXAjFmBxetcuSVDw1fq5oeIc4vZTOdh9fV6
 pR1wDXyJSyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaITW1wAKCRAEWL7uWMY5
 Rg90D/9MO7luxZ4q8pRG7c8lGm0BaifeTGvGJCGM841tyFan5WL37r/Iesg7FptBXwuiXNXSdcs
 G8nh8mXNuzffIdonqNmWS8p0kFbPb4R4tYz0TcsNf4guIAHVj+1zz+yawKWmrcfiX2k0SA1oOCs
 e6jxY4NZg7lMNniPmQmqsiWtNdV0apTwYVKKvoD/wHNr7ilTjYTLq2Rzuk1o1suKfTX5m9sGXbU
 40CytLKtb5J4vhq/7gs8ci1ijB8Hj+FMTWk5X8L4VvU5Erp/o/3RC0yfV/3sBLfSpMgeUcDMcZS
 co/TC3M429/qn/fR230bgWSiqe7tkrliKGGDukX7rn7HdZxJGhujuoNBlPjwJMwofRW667TS1S5
 brMHJKqYwHc/sxBNyOhXIhYYneB33oNA8aEC2yqksPyJTA3Vi1s6pefIxk7xGP1wu63WuvUAeZr
 6iQVwI5l/+MEyPDWI7eXplqTEgi3pJA1RFEOtpQm7Y3cZ8tZ7nbemXyfTmYNrTeHO405lqBsAyj
 ACVmdUoSWjrD11WuGRytpYHdrTZ4fMrp1Tu6GUwHcjiW3/c4Z7WvWfQX1d3Z6gZewsDKwTn+kE8
 GR+IWzTB5AFYLBXITIIggQSxm9DvK1XDDBwJ5KSVo3WKPnLhFqo3dXToMyYRTYWH59M8VhrBnUx wriUrTX8Leu4axA==
X-Mailer: b4 0.14.2
Message-ID: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
Subject: [PATCH 0/3] Add Rust abstraction for Maple Trees
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

This will be used in the Tyr driver [1] to allocate from the GPU's VA
space that is not owned by userspace, but by the kernel, for kernel GPU
mappings.

Danilo tells me that in nouveau, the maple tree is used for keeping
track of "VM regions" on top of GPUVM, and that he will most likely end
up doing the same in the Rust Nova driver as well.

These abstractions intentionally do not expose any way to make use of
external locking. You are required to use the internal spinlock. For
now, we do not support loads that only utilize rcu for protection.

This contains some parts taken from Andrew Ballance's RFC [2] from
April. However, it has also been reworked significantly compared to that
RFC taking the use-cases in Tyr into account.

[1]: https://lore.kernel.org/r/20250627-tyr-v1-1-cb5f4c6ced46@collabora.com
[2]: https://lore.kernel.org/r/20250405060154.1550858-1-andrewjballance@gmail.com

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (3):
      rust: maple_tree: add MapleTree
      rust: maple_tree: add MapleTree::lock() and load()
      rust: maple_tree: add MapleTreeAlloc

 MAINTAINERS               |   2 +
 rust/helpers/helpers.c    |   1 +
 rust/helpers/maple_tree.c |  14 ++
 rust/kernel/lib.rs        |   1 +
 rust/kernel/maple_tree.rs | 538 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 556 insertions(+)
---
base-commit: dff64b072708ffef23c117fa1ee1ea59eb417807
change-id: 20250726-maple-tree-1af0803ac524

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


