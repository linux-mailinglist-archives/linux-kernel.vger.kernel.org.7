Return-Path: <linux-kernel+bounces-855138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BA8BE05BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A665357ED6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9CE30C62A;
	Wed, 15 Oct 2025 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlhWDi91"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA13307494
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556304; cv=none; b=lRNyi0yeIgIJPIIuA69e8s+WqKixQ77eqTJQwk/5l//8oTWFrKY+6RzNfcLO1kiJouL9YWMhFBLwFILik4fOtPYXYz+OTJUZdJXI0tblCXkhoJmhSb+XQscPcmrnk7B+znF4wsgWfUyYaKMF08XSqqAirVkB38FLF0pgDa/2vhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556304; c=relaxed/simple;
	bh=2Vk6qFD+khvBWosYiPgnWwsc9w2ItSZw9y9K7Wf3lO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OrYXRbSrJEMzZKmmgCZsMDBRdKUt4uwTZKhaR3ywf8+KBBfTae4NDJxtkOa32AIpzbn0P7R0y+x8oMRiVdXIHBhhfXVz86ELX9pzZS46DLl0JVh74+6rZqYzQTl/pAeghrkK/n1MsfyhEhy9i0zNz8H58uSbmvtv87wcVkFbZrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlhWDi91; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-87a092251eeso23819616d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556302; x=1761161102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjPhqOIsQnP5icf3xI8+fTWI6demrBvMGeJug28QAmc=;
        b=nlhWDi91qOdTS06ilTTWQqtxrya8sKOBO4uYooo3tAkXgmoaZAAQpqclmG+Qemtj5n
         XMrGgYVkjdysr0wizWs3RX7uQ0cAhIJBRxoGnSF7I1F4HnmBMxUqzckCOU12ahfm0BNb
         IDJINVcC+rXwHuD7BRtZQhSnP9MBxaeGzZkDoketIXMWAGvXnOSulJvfcB2/5quP6vlq
         wEDRUny+HsPm3CogvL48V6a2JzeQ+6Is/FxZpweOdc4YWyVu71H1V0FegJmi7/j9hkG/
         O/R+eq/fgpI6w1hE4q/iXU6MxKUDViYudjtsn1hw0IaC03q7OTS0jwrTrmKzmqbreEQo
         lulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556302; x=1761161102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjPhqOIsQnP5icf3xI8+fTWI6demrBvMGeJug28QAmc=;
        b=cQorNVwNNHyQJ4XeFIm7a1ABnAJbqU/quiGouAn0ZyXf7m6pa3qcplCWb/GscUvRFG
         +1FUpF3/kna/3hc7MCD57yfXbKo0VHy2gfc/OM6O6/Cg7p2GSCGOSXzL5XVGyipAfxfa
         VQ8LkLPXEUq9MFpZmaY+XuoJ4HdQmmPi+9ZcsMdLtZTKzrzgISGgKSua5BOPe2mh5XHt
         YgFHDjTUWM5mxPIPbZNYc1jZS+23kBRim53o2klly7V2sA/AD64vBsu8Xxcx+z3L7ohl
         T7kAQTcgqeBnyJ/rM+t9SgQdm+PNCLfS6WTFUTTJzZupD7fkKl2pWPht7ewIB464pbHq
         HLig==
X-Forwarded-Encrypted: i=1; AJvYcCU7+cC5e4tztdrOxFyTj5lENA3qMdQnwdD6koL6pven9i8EDPVwlPrzyHZkS1kE/9wWom6Z5X0VvOSd36o=@vger.kernel.org
X-Gm-Message-State: AOJu0YznLUrbDigDga9EDaZIIRytoofM+Ld48SDfLXNAlEIgiThDCvtE
	uAP6e+jmEEKANye1BXGAYZ1aybLgxM7mheEXSOhucrlEKyVTlDT6Z4X8
X-Gm-Gg: ASbGncs7C3h5kkA5gWfvvTm8pOmRtOSGa/8xzFcyWVXLEJN4jPvLCk/0rgoPSVSb3hE
	1ecvXxl5cKXhaT21x6sz5YutyG1Af2s3WbHUndRVgTAf0cmAGi/GsG9g5JBHNWBPI77cOyhk/E3
	bbroGLKoVw1D04rin/rsh5Yi1Y5b0D2KRloCZZiLUP+JYTgrKKNIQfgfgOdyTP9l2tpdVrtvjTB
	n4GDO5XzuWX42CV7fvp0cLXXfWHLNCrtbdZ25paHuwKHxAHMQ7GWB7t53Bq5G7mBmIimT5s8Kgr
	r0REHCNUfhpMHZxR8vWK8sXMIfQGkxFHIskU+RNN0EptZFgvAdHhC0VnqO/1tv5kVhoI1Zq/KIF
	78UA04mWgNz0dBCnu0zhTiXo/9dU2hwUpSih1JQMYxki3aIpfPcjQmQzVgC92YufuklpF+q5zFB
	5DLkpyvwQWfqbI4TYssvaOrcUvZjzqHbKlfNWWB9fUr/U035Mvbon0rIaCGYvDisGRdD5l3dzQp
	SBP3gXbcbzBun3OFxuGTFRbXmDVFo4k5fqpy1SxIoaZK9pJnMdbQY6V2NL0AzI=
X-Google-Smtp-Source: AGHT+IE/6/93cmzALh4Jmouh/MLI95PCde1EljHLkZKlJY4iPwz/j8r/4JCLGlbGVcRLXtlHwQc0sw==
X-Received: by 2002:ad4:596f:0:b0:783:f54f:418a with SMTP id 6a1803df08f44-87c0c8131a5mr22292536d6.15.1760556301319;
        Wed, 15 Oct 2025 12:25:01 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:00 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:31 -0400
Subject: [PATCH v17 01/11] samples: rust: platform: remove trailing commas
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-1-dc5e7aec870d@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556295; l=1642;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=2Vk6qFD+khvBWosYiPgnWwsc9w2ItSZw9y9K7Wf3lO0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKJ1BUAmPVQjuKlRlHXyE7o0qpMUW2qdVnOqngFN6VFfXZIKKvKAJg9piKZPdbhI25H2DhoqGoP
 iQgwB+DS24Aw=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This prepares for a later commit in which we introduce a custom
formatting macro; that macro doesn't handle trailing commas so just
remove them.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 samples/rust/rust_driver_platform.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 6473baf4f120..8a82e251820f 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -146,7 +146,7 @@ fn properties_parse(dev: &device::Device) -> Result {
 
         let name = c_str!("test,u32-optional-prop");
         let prop = fwnode.property_read::<u32>(name).or(0x12);
-        dev_info!(dev, "'{name}'='{prop:#x}' (default = 0x12)\n",);
+        dev_info!(dev, "'{name}'='{prop:#x}' (default = 0x12)\n");
 
         // A missing required property will print an error. Discard the error to
         // prevent properties_parse from failing in that case.
@@ -161,7 +161,7 @@ fn properties_parse(dev: &device::Device) -> Result {
         let prop: [i16; 4] = fwnode.property_read(name).required_by(dev)?;
         dev_info!(dev, "'{name}'='{prop:?}'\n");
         let len = fwnode.property_count_elem::<u16>(name)?;
-        dev_info!(dev, "'{name}' length is {len}\n",);
+        dev_info!(dev, "'{name}' length is {len}\n");
 
         let name = c_str!("test,i16-array");
         let prop: KVec<i16> = fwnode.property_read_array_vec(name, 4)?.required_by(dev)?;

-- 
2.51.0


