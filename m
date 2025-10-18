Return-Path: <linux-kernel+bounces-859373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119CDBED6E8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F34F404C74
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3E6301473;
	Sat, 18 Oct 2025 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dykkDPOs"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6876D3009E3
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809575; cv=none; b=YFQb7s0Kzl2P9EzHio8BhvAlm/kfizC3DtspnGJiqXSgqRI0kdZL9dAzNTkthBUalgGXE+BBAbBhSGTGI8P7EVQbGKjwlDW05I8oC/YAH92OqYtCeAz+OfJIj2MLVgCnn98qBAi5tgHiIXx/ZPBjdZ7B5LK5MoHuMcY5T7OJ7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809575; c=relaxed/simple;
	bh=tThvb3NWkM3msr/ABoCM1JnbhTAqdV/nFrTXflsMRkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YfycNJiU4RfdbDIuiz6aaLfu8J9f+d1gRIcBXF2BZQB5vlwcn5FfJW5R1IQoNzwcZQ1U9tSb9zw6WAS4UIa04O3TTdhALkb0F6ocvlybVv3a2+h+2Pue4K3V5V9P5wxnr+SckXaC+8OeW74l39neDwXZ3OggV2NT2zFTJZ9Z0dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dykkDPOs; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-87c0ea50881so64018006d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809571; x=1761414371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GrnMpI60PzKwG6+cJ/Jxamo/bOJKX+J9SwLV1KKddM=;
        b=dykkDPOsKqZYhPS9KYiY6lWr3Z0ZhMJn/5+4vp0BTSy949tm1GzCG4Gs4d8CbqDTmw
         Zx9kfdyOJd66v2uOCSmdehWOBQ4WSMbd5WIFO8M1O479tSt1QJUZY1qw/fF0UKUhRAS3
         zj3b3my1775SIQRRNobdfv1RmuM/sAX2cO47BYAxiHgZqMgkR1Yl0Tf8O1tPo/iEzk/D
         Y3mEEmCKxS1m1nhBp0Ld9zE9iAUPtUj5NeyNtdM1ZEykp8SvaEWaT2lbMZwn5gW69N6D
         JZg/xKyDKNhr/pqwSsuSke8N9Seabin4wwyC1SInZRrYneH8EaOdqkLCPvySu+hPhhXz
         mYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809571; x=1761414371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GrnMpI60PzKwG6+cJ/Jxamo/bOJKX+J9SwLV1KKddM=;
        b=cq0zJbuB4Hj6/avlAqIbsqWc0NTY7lrRjHyvT9y6zrEml0+4vEtbnKmpTEHRR4SjhO
         cqBsqZv0Y3lXY3UPYItnPgVbaNxuN0kaaZJtIyGgR65I06zWb/aVNJLsTFCYOykfpp5a
         NwWhuw4c6SB3af1IkGnNwuliCOCtiN3g2pcmT80g35rYYDxm4GDpx65uoKVmeaspvXxh
         wNemCUyy0CPs8SKHmVmgJnsLob7GTEUVNMxuNrE//qCIa5JR6nrkZnnyFEddIZF0pzDJ
         bv2Op/pliqUQdxIwSD2hT87AGia2i/EEaPCyXQzdX67CjoI7zQVvd3bJVf1NgY00OryA
         Fglw==
X-Forwarded-Encrypted: i=1; AJvYcCVCJmmi2IuUrKLZXDhJKKHEw1dmC+3gmPVjovvqYaleIdmuLBKoJ7HUwfTRz6CWm3AmoZiYTdgFbb0nwAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZYmV9Wm/sVjI6Y4dtsD3O/0ZX0WOPCmyN/svn8tamZ4lciH/N
	ENZYB3O6fhSwIpH8f+KsreeNaSk9w/vSMyND9SEv6HuifNSQqOxShLAZ
X-Gm-Gg: ASbGncsBO+U4djXHFVJrNoj7S/dPC8PmD3kSRyA85AgTUvnALYe4JJLw19dFz7QQRhb
	FUiL+QAU8B2N98yY7lGALTqPGwhC70PVDiHZ1shqBc3NUx/Eh3y2XMMWyrhQUsjGWBL+ngjtF7Z
	/jjt4rIKxd0oHBV96UwE2Jey3SQI7PvVi9RjaA3zuZzvdi3nBdnb5KvSLj8qso7feaMC8McnAXI
	emRaCGcSZ6wkEjYlJ8wZbCnOW3oz6gWuyXv6dSrJ034B9NMcN6Jxu18urxAIFQa4xq7RlT32hOV
	w5OWIRndr/ADT3Yy7ZE+P86uDr+dPmVHIC5hGp0QUZc49UMXS9625XK0e3+DLSoIh4UvAPllrHS
	Fdos+Mk79eVL6dnJLx4gOzV/dSXpmTgACecfqeqy1xqITQphnSwEhT9jihj9Cmy7S5iZt3lvZev
	Wocptn1LY3sXCUlipJEHZHwX/DF1/nCTjHJRs6uPEZpXMWEoJ2s9m6LxSuHQJPi09L/JYNoMT55
	ECZ0oxilC29b/4jtK4odoftWq1aKpcXRk/tuMV4NRLhmMXHwKxJbBgutOcde2E=
X-Google-Smtp-Source: AGHT+IGZpCN4j9tmhaYbhdNdOMD/u+TXfP+iW99iy32Lbo2Vps7+kQzJb2YNFmaLWQVUUZPeDTJH+g==
X-Received: by 2002:ac8:7f0b:0:b0:4d4:4a2e:531a with SMTP id d75a77b69052e-4e89d29ad47mr112932081cf.30.1760809571213;
        Sat, 18 Oct 2025 10:46:11 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:46:09 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:22 -0400
Subject: [PATCH v18 11/16] rust: opp: fix broken rustdoc link
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-11-ef3d02760804@gmail.com>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
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
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809527; l=760;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=tThvb3NWkM3msr/ABoCM1JnbhTAqdV/nFrTXflsMRkU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBU9F3MfxxHsWXZNGSoYZmn2+0JKsH4AOCWoX3y57VzrfMaGPAHTAxZv38DFnb0J2kyhK3EDxZd
 2sBHoMwBFnAM=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Correct the spelling of "CString" to make the link work.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/opp.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 9d6c58178a6f..523a333553bd 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -87,7 +87,7 @@ fn drop(&mut self) {
 
 use macros::vtable;
 
-/// Creates a null-terminated slice of pointers to [`Cstring`]s.
+/// Creates a null-terminated slice of pointers to [`CString`]s.
 fn to_c_str_array(names: &[CString]) -> Result<KVec<*const c_char>> {
     // Allocated a null-terminated vector of pointers.
     let mut list = KVec::with_capacity(names.len() + 1, GFP_KERNEL)?;

-- 
2.51.1


