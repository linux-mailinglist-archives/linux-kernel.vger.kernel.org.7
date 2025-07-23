Return-Path: <linux-kernel+bounces-742839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE80B0F73F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25EDE3AA238
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759AE1FA859;
	Wed, 23 Jul 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qf9MIWZl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50B61A073F;
	Wed, 23 Jul 2025 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285185; cv=none; b=i/aYw4tGgsk7C7v1UDZbKFth7kx+gB6ToPmSRbsShJTjtWwbrCATb6Xy5raLsgUkgvGoOA6m8lucIt9YAPMG6cMdoOD90O7SbYb4EpRkYw9IbQ3866XFdlGEEf05CUQWSB9Wg0HWGRjlsd+gvHDIua85LKme6pkRgCyYQd29qwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285185; c=relaxed/simple;
	bh=JDR0jcZ3hCvdnx4Nv+HhHC83x/f6C5vUo3Z7CFq8ZSI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=melzFNiLqsq2tnP2MhEnEv3fKU7N8J1bK2kLzbmsHoVLpf8iuMQ82YhTMnfh/LZqbGjVx4KF1xpe/xeGSwDgvLSRqSkCVFwJWdpSo9F/4loNYak855/ZGinQsTHrMs3ANSlIMENE1aH8gBs1NDaaC5nrpjnk1asgkVGKmPmRhbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qf9MIWZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1142BC4CEE7;
	Wed, 23 Jul 2025 15:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285184;
	bh=JDR0jcZ3hCvdnx4Nv+HhHC83x/f6C5vUo3Z7CFq8ZSI=;
	h=From:Subject:Date:To:Cc:From;
	b=Qf9MIWZl12Lq42hkpJGhWDjasE4yU0HKcbXhTFJ51QMvouaZyS5U4Rw2FBlsPyd1F
	 Ecp9Jm+G656D763Vho2WFrMzDBBabIcuzRPJRRGVqyCKcNWIalnOCH562n82SYKfjA
	 JkJP23FufRMBjfWA7cegnSTLu77qrbX0UB1dFIDfU3S52K6gjwqoBUhLb2PEZ3yt5y
	 huxd4O6TX7WCVqVoVo3ItFNuNqQp9vt33ROMHSfzCWzXsTZTZspzF4qmsqoRKZCjQh
	 4bAPkxdqugkBJRJtzP85CpMB7mBhM2+9wqN3RSkDIsI1YL/oJiQoPlApTIwj1Yokop
	 iR/vJpcX1bDfw==
From: Tamir Duberstein <tamird@kernel.org>
Subject: [PATCH 0/3] scripts: generate_rust_analyzer: match rust/Makefile
Date: Wed, 23 Jul 2025 11:39:39 -0400
Message-Id: <20250723-rust-analyzer-pin-init-v1-0-3c6956173c78@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADsCgWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyNj3aLS4hLdxLzEnMqq1CLdgsw83cy8zBJdSyNTEzNzIzNLAwNDJaD
 mgqLUtMwKsMHRsbW1AMy7ZoBoAAAA
X-Change-ID: 20250723-rust-analyzer-pin-init-925467269001
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1753285182; l=745;
 i=tamird@kernel.org; h=from:subject:message-id;
 bh=JDR0jcZ3hCvdnx4Nv+HhHC83x/f6C5vUo3Z7CFq8ZSI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCPcor03iOgOg9LDvhCFO2jQnbv/SN8WY343yR6nTMz1e66ReIahTAQP4weshIxymgWU9eEO1qs
 WxtQpubWF+wI=
X-Developer-Key: i=tamird@kernel.org; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Minor fixes in this series. The main one is fixing navigation in
pin_init_internal.

This is my first series using tamird@kernel.org; please excude any
hiccups.

Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
Tamir Duberstein (3):
      scripts: generate_rust_analyzer: Add compiler_builtins -> core dep
      scripts: generate_rust_analyzer: Add pin_init -> compiler_builtins dep
      scripts: generate_rust_analyzer: Add pin_init_internal deps

 scripts/generate_rust_analyzer.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: dff64b072708ffef23c117fa1ee1ea59eb417807
change-id: 20250723-rust-analyzer-pin-init-925467269001

Best regards,
--  
Tamir Duberstein <tamird@kernel.org>


