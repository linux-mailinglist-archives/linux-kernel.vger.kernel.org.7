Return-Path: <linux-kernel+bounces-832544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDD4B9FA25
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 870517BE7DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65906273D9A;
	Thu, 25 Sep 2025 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvkTdqIb"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86C3273D77
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807784; cv=none; b=GREvz9Ro6pjUKqvtpgVuOp9B7lQDdiQXAbmtR+tq4n8BWqCXx5t+x39B4hCWE2Z39rP3T6e5VXaKSE6LBcgp2B5+eBh7SJfzSpggfzZYJR8ZqQyQDMoBoRfVfGtMl2a9kKTbHydKUlVlIcHlJnVOZGlbe1SJqNDvJi+hGseWIWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807784; c=relaxed/simple;
	bh=dR7SLmVNHIVh9rfgt0UBYbJhDHgMhtv5IQldU5Oo1x0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YiCRgEUPo0WQ6duoVHo05EwCmCZIleVekxmLXVODuW2KYeyY15WgAOUfdYjZ5/V17i5bE3w8DGI4Yr1FSotIJtuhM+EAeEbPj0GuzMy0cM/b6u6HM90Nwgou866EGZRSRewyxWqm8Nmg8WbMmm8gr1AM48jjTqNBUc1PT1KwNiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvkTdqIb; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-791fd6bffbaso9132626d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758807781; x=1759412581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbaY8V0OL9vVXDMnnkhXlW/3PWrqVdowYDRD++oQeQ0=;
        b=fvkTdqIboBDhLwpqclyE7on8TgSpv3iU+Y1Jus7HNn2Lml84xZqv+5zoehN3EYAacN
         tqEBipXYx5Bp38I9TQHc/Pinhk2ij5DIixsKTaUc8SMLAdxeZXUzVMZAVNU4yfit2ilv
         T0SBE4FIKoL9euv2df/pqKZKjb+HPp7nBa51lQO7bEcYvcCRpudxDeIcP4t7DrAbyJlD
         mHLFP2t8DP4RvqEDUtHsr/EccyoRvWqttF6uiWDqQaPD0f8x6Opm/KClgxeI6ScGAt1q
         d1dU645q4RGZJlGlQBSL95UI1jUJwYPr/xXQQsA1BJDH9QMUs7+vP2kOSTLNfxt1wUxp
         XCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758807781; x=1759412581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbaY8V0OL9vVXDMnnkhXlW/3PWrqVdowYDRD++oQeQ0=;
        b=fPeodCvc65vVI6jRUEphaf2jXRLFQJymEs6Lgjms7KRpGPF7thHgQ7xnUpSpwRUait
         FdN83h5R3yLC2Lz2BJC1e9RA1OQ/WAbAbL44Oy/h6nzTsejC8MS68kupbfUElWtNNibw
         Ac4R9nY74INYEFi1+eC7XislEvRw9g1mxUsbEbPskp8qDA8du56kg0ydtE0pWQs2ZfrJ
         UE0jHr4e3jYoaOtJpQOAqISMlzrVFPtd4hm6vaf2mdB6gwXVTWs/nLlujgQXxOD8NoWL
         f877AKVdC+BArgeFVMaNic71Fm4+lk1NyRil7MHTbx7t2JuU6X804NvplPjDaCXhAVdC
         gOag==
X-Forwarded-Encrypted: i=1; AJvYcCVvcDP0NVHWVBz5HttRYOHDFaag+qDdW6eNSnpzCK7H1dGGG9gC/MxvYSVRyQ1lPRxTAkWWsre2JS+mVNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4eUW0gbLmkohU1M5oHzAd/JgZ8h91BDNtC26I7MSjM7utuBYb
	g+u8hCEXsjb+4t55cIYhHJbdmm7Ecyk204E9EdhwM8NugJEKpAfzRb0X
X-Gm-Gg: ASbGnctmglmVhR5XR7ZAv8v/DSLofsQ9JABrfocpruL0Dbopqox2C99TtW5Oa+I/KM1
	ZrZGZRkFEKttDrstiRAZlfRPVTNFl5jPePxmLdPlYc4MbarGU41rkesz5v6HbOYKGPd+5LF3zRU
	7ARwwW5sJfqbhIzoO+LCn+L7zYzNlYFG+C4awIk9yzJ2P2kmnKas8GPq3BHP5qyeeA/rJCk72Lx
	qHRPP1OmMr0IIUcL8rUrjK99GFHoOKLKDmztIXjFzauOVF/OEIBjZ0taAjR9cFz94LlqmYCx2om
	avHNitSYmgGfB/JhOgPglIqUGXLKTW6Fb3/ee9rReJmtyAuSKxJYB/q+UR65kh8VJI5UJ4/39Gz
	uk1tA3L25h8DSVKM0GV/H39jKmV2yrXW7sB7+nRQa3eeuanTsCM/ogieVady2WEekvXe7ov5jIZ
	oos63aq/M77A5cg6OUhUwrx3CyEqGRmrAgIIOCCpfpOLHIm7pg8aZSqevUW38jXOMaVKWM
X-Google-Smtp-Source: AGHT+IHcXs/1zZiL4mRHRcJmMaysro1gRq3C6CI7WzBk8URswdICjX7WDasck2n3oTmE+fT66Qso5Q==
X-Received: by 2002:a05:6214:3017:b0:720:e5a:fe3b with SMTP id 6a1803df08f44-7fc417af017mr49768136d6.58.1758807780523;
        Thu, 25 Sep 2025 06:43:00 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-800fa5f6dd7sm11852546d6.0.2025.09.25.06.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:42:59 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:42:52 -0400
Subject: [PATCH v16 1/3] samples: rust: platform: remove trailing commas
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-cstr-core-v16-1-5cdcb3470ec2@gmail.com>
References: <20250925-cstr-core-v16-0-5cdcb3470ec2@gmail.com>
In-Reply-To: <20250925-cstr-core-v16-0-5cdcb3470ec2@gmail.com>
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
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1758807776; l=1557;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=dR7SLmVNHIVh9rfgt0UBYbJhDHgMhtv5IQldU5Oo1x0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMBRuV/ubGHi6AJrHtMWEogs+gWnxrbm2zAAbtuo9cLcfxR+ZO72SsA4+aDO80NYB5ZrsYfMwz8
 lhrWFoc//jAM=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This prepares for the next commit in which we introduce a custom
formatting macro; that macro doesn't handle these spurious commas, so
just remove them.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 samples/rust/rust_driver_platform.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 69ed55b7b0fa..ad08df0d73f0 100644
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


