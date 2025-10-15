Return-Path: <linux-kernel+bounces-855143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8430EBE0611
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92611A2251D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE4C307AFA;
	Wed, 15 Oct 2025 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvURDB2b"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A55F30FC2B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556317; cv=none; b=sFJhoq4x9IgfxPLDZK4hAE9HiumI2gts+UshEMRDrRrftKoZ3I+UcEYvwdfu9CaN2fHpJO87tE6Rv8rx0s+p7n07nfQDqAsC3xEBBvHwiKPAeitihFQGUx0Cyx/VbNFK4cssqn6AXyGJExGhjd6UdgDJbJVa6obr/FvYnzpJ6GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556317; c=relaxed/simple;
	bh=1C7R0OlcDfzCrDNlHP23bsVD6WxFN5roYyk953BnBNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=okyjQeSWJDbJVsAAsrU6qOMvT98eyPZ1rZs+CCymDjOryxMR1sMjlUS4Q4b4aqVnc5qz58orcZiuL82j2DBxrYDlUk/0u683omxfJNFstErD2Inc81fO7LUQN1P/VOoEZdCBhRmOqxCiizIma7Sg8bJgzippI9g4lonyUaKwMPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvURDB2b; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-78f58f4230cso80725856d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556313; x=1761161113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZKdkbczThzjFB/XasmnId0cLwQ4C+67cjGeOTOncUU=;
        b=LvURDB2bWmzmqc3ssvxSZ5e41cSaG+FYiEbdcfC9cY184Iz7xDLZ2mw3gltSKQZ6lt
         Gb8i4g746WVUeM/u5dyezFGSPw1rFoXL14Q5oDlX7uU6fkq1637nSqsSYL6PhKV+4Fb5
         C7jZ2hBCCUC7DqzxJL+TtR7wO0b4MS0C3O8r8NW1qVBPjaP8aePXqbEXCaW75xJ8XJRY
         4+Yk/GVU24t25jo3GQ3Im4KSPqtg+3pHWmCjVvktEnpWEuHY+NT3WiXN9H+vAukTqkTw
         EhC1pibdM7mdZGBixA6HOy4B3TKHjcSOBgPSHuHjwhoOEeXIVeB9f+BQ5AP5SBAWmR64
         vIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556313; x=1761161113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZKdkbczThzjFB/XasmnId0cLwQ4C+67cjGeOTOncUU=;
        b=uKL/aoEjaveOIaBQ8AYtcgIOTWNMEAAg1s9Ft9zElsGoqNKxK5L7NZX1ovqv9rFX64
         V+sAp8XSttQFcFAcWl25L950OGrXfc+Qtw6gGnRRr72PgKeDbulZtw0YreQk+ilBK2JO
         KmW4wfeCZdidonovcUsKZu97sMRXu/LAkpqYJRANVENT7yKmklEGnhjP1JoIrp5rmTen
         68q+BmXiMJcqkIJJb9kl+PO0p/5mKTNfmmmkpdIe7/u6eTehBS3MTKViws94hANklt4x
         Tp3d9hZlzozETlTvNW/sSD6VIT6siQB3jJIM6/kXPlG4d5kZ7Y+583zdGkOpp/uFFcM2
         mvuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBYuEq2eHcJa3cpXX0rNLK0ib3TsANsz/ykFtEDXb38ti9pT3AeFlq4PCbCCtqxPcjDfz10bQ4DQgZAAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwNXnZGWlL/kD8GHGjY0Ae0tZfMpVDNzygG6w1ipYQvNqySEBp
	o1GJNj2ed3XR7xrck9sB2pShlSVzrAJNpHGqhyGafuMimNZi5PxUgO7p
X-Gm-Gg: ASbGncvfCtKNtImcaJgVQU9W7DntGFpVibiE6vf//jLZ2M7KVelqdOse0GjKS7t7drD
	RU6OnItoAbj+btNFFLFhs+0EitLC+bNY5bfxEd4qcXpMfD6M7XCpTC9kTk64FQ/n3hwjMb1nv84
	/SnXOl66OhZL+lY+QSa0z8ax8VMUn2mdy7tR3IfMVUT8F8yMur82hSAmNjD12aKiIw4sViKvICp
	cI+PFhjbPlgUepLp7rcsBUssSgvS0luj9PhR1XDNmOTATcXp8FpcconuZbadwsuVkjp/oDDyCFZ
	yDBeT67nIfqUJXwslW43h1UdjHXWyV9quDXnlAxhEUYTb66ORrDW0/8kU6i3yhETi2zTOU3Ncic
	W2qLS+EF7TwDUDXHAmAmRpruNDcr+/Dj8PbCxUgB3tsEm4VMXfJBcvp/k7SV8N0FzoW3R8dvHjx
	SDN1rZLlJ/B9yEs/1A8RLC1JD233+i6q8KA0KbAb6FnowbVEwSFyjkXIZTE79sAcpKfJD8ABcNo
	tslCPghUnyB4p70cTQz7dMGc1iZKd4Sw4ukvO+dwVyMSN1Q2UnnIE4djiaUPVc=
X-Google-Smtp-Source: AGHT+IG7liVg/dFGAXjOyaKmVuQjChyGkmShQ9JV9oLbo6kDusjiP3kvxzCrSASqCG/bT3aBHrC7KQ==
X-Received: by 2002:a05:6214:da5:b0:81c:b934:a01 with SMTP id 6a1803df08f44-87b2efb9b5fmr472291556d6.31.1760556312957;
        Wed, 15 Oct 2025 12:25:12 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:12 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:36 -0400
Subject: [PATCH v17 06/11] rust: alloc: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-6-dc5e7aec870d@gmail.com>
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
In-Reply-To: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556295; l=1945;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=1C7R0OlcDfzCrDNlHP23bsVD6WxFN5roYyk953BnBNs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDAN3p325daLL4ZjhjcTgzqClyBuzpHB1y4m1///5j/K+30qaqRH3Sgm2aqLHXCgT2ZR6uF5mJU
 hkiaomJhEowg=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit 9def0d0a2a1c ("rust: alloc: add
Vec::push_within_capacity").

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kvec/errors.rs | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/alloc/kvec/errors.rs b/rust/kernel/alloc/kvec/errors.rs
index 21a920a4b09b..e7de5049ee47 100644
--- a/rust/kernel/alloc/kvec/errors.rs
+++ b/rust/kernel/alloc/kvec/errors.rs
@@ -2,14 +2,14 @@
 
 //! Errors for the [`Vec`] type.
 
-use kernel::fmt::{self, Debug, Formatter};
+use kernel::fmt;
 use kernel::prelude::*;
 
 /// Error type for [`Vec::push_within_capacity`].
 pub struct PushError<T>(pub T);
 
-impl<T> Debug for PushError<T> {
-    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
+impl<T> fmt::Debug for PushError<T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         write!(f, "Not enough capacity")
     }
 }
@@ -25,8 +25,8 @@ fn from(_: PushError<T>) -> Error {
 /// Error type for [`Vec::remove`].
 pub struct RemoveError;
 
-impl Debug for RemoveError {
-    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
+impl fmt::Debug for RemoveError {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         write!(f, "Index out of bounds")
     }
 }
@@ -45,8 +45,8 @@ pub enum InsertError<T> {
     OutOfCapacity(T),
 }
 
-impl<T> Debug for InsertError<T> {
-    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
+impl<T> fmt::Debug for InsertError<T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         match self {
             InsertError::IndexOutOfBounds(_) => write!(f, "Index out of bounds"),
             InsertError::OutOfCapacity(_) => write!(f, "Not enough capacity"),

-- 
2.51.0


