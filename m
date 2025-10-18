Return-Path: <linux-kernel+bounces-859370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADEABED6A9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA1114F1CED
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7832F9C2A;
	Sat, 18 Oct 2025 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4d5twMq"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A83A2EC0A3
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809563; cv=none; b=sO5QNulUu+8LeGFZJUmfCW03I4/72CvySM4c50CngiFoFKyo8HJDJkpDkSaXJmOqb4xk63GB0WDRQKsO93vciOR6kyGBc5IaQdb0wczc0ym6lF87AKSr5MkMw8CYiOFKZxTkzWLazeldzSPYz0deNpwwEzMt5/3GTN76F96fx3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809563; c=relaxed/simple;
	bh=03bsWp5q/RvNg/sXSrzNos1bBBR49+qyJdq4+m4Ha6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MIcm+XGRtaSijSgFvlFIth61mGtD9e8/MvuTHL/Umbx8GFIkH2xdDaKz2ntQfIArKz27Q0vQUXF7Fg9jJlBuJHdcYTPoKHalDkg85Nclnk/s5RM3GY6hioLIe3Bd3MRKak9DDadEObgp9oxHdJFr0X/sgkS7tqRkMlyvyFRxBY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4d5twMq; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-891208f6185so224977385a.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809561; x=1761414361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5WimfWZlEqiYHKzfmcAckTYkDvTe0+bpTYNTmk8aT4=;
        b=B4d5twMqq15Bm4EX95wI9H+g9Jr4ulZ0Z2Blp27d9tlkapDkfxPWxVvAX3MR5FcYD1
         j1C7SIRD1af1Caj62Q0lteSNdf3CpvaN7soagf+2Rh6DfU1ehN+iYXDRlJM4NYLJoR/8
         jKmLVTuarADNH/eQhdgR3DKmZ/bVA98jgdLCnCRjqJdeZ9ASlFozjb/Skv0W9xczvSUX
         5tSIAmas2MIlcs0es82VfRqbFmPt2zDg2T4Z5u2urQBT2siO60YzSSZ1PaCqBdGpMcP/
         pD7KQwBQHFgvXeXTpNVJX3x3fXFu5zj+ZVIKJHizeeg2I9b08xEwSIuUmKYSPa7s3u4V
         bCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809561; x=1761414361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5WimfWZlEqiYHKzfmcAckTYkDvTe0+bpTYNTmk8aT4=;
        b=jYUsLZ5oFOseuA2z8bYfVx/gFHmI/cPzhHbF8q6hpjMBdHnI/09Nyg5FS02pGYWEZO
         vPMMfpAXWN2NwWdNwl2rmWsRjnOs1nadphCWHShU3GGHOjJRcZ5YjSlPof1502W1p+HG
         QW8rGzYRn8cwmMgZ80Vo8mSsOPB3CTkfJEUgoIVLizJEhPyKN1zlWHy9JsdFtdrqQS+v
         5QRFMosCnCW6vAnMxJP1JJAU1cSA75EAJ1PDhuvL+6+VSFzUrbd9Nsrra2dSuaEoABtg
         TWDy+SD5ytiHD+ykazTUZH8C/KTStHaBFEI3x5LqAtZ66YSHGiTAMXUug1+tcOP6iP+W
         ooyg==
X-Forwarded-Encrypted: i=1; AJvYcCVtIrUVUlIyXYRgZFc4jkupWVWwncPHd5izQJZpw4htzUbi+IpBZAln764SZnbZgjOAYPe5J8f3gY+DSW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc8c+CZBwkYsBj8tJnaqm7+giP6+XX+vMb1DDVfZJZtZzq8a5e
	6jWA7GEZFtJZ1ezjKKxMpLhngBv6ctkq4cYIHk62WGYdm2lMumDpeu7J
X-Gm-Gg: ASbGncuQYTl/s52S68p1PoJcOO3/ytKQH9ZyDooFZ5CtdN1jxgbPTo8QizVjthmWDKa
	o8hHlEIwTejiUPB3HErTKuEfSMYceos2rK1PpCnDQgUQx2P/zV51IyzDcly2BR5aF6BVibM50PK
	2Yemy1IxprVMzEoOlBdmVllIUrxEqFMkXd1WyosmJ+BTVBRJerq6nHT6udcCUEsiNU+CYkT8OjK
	gWpTjTGfODhB/srG2M5ZfIkyxpLz5qH8y7FX8p8d76w3gT0NhknEwE4Q2us2yEPmKPhpuzSm+OT
	9IkElsaA7X9WSdDwJ7CSrQKujti4xbLsrBK7KuQyUNcrD2fZKCtJAVaZv8o/svMXELxzDPFJzPi
	GYUGNDuSjLJVbyPhmN/FLhxLrDHKStmLjxkl/7EoXeVEmpoEEba7/lVBvs8p7bMrv1HCDj/1LMk
	zvxpjQpxQe+w4k1kKsGLtEzyDeKWV8+0lNE1zMUqg2aprbCCYL1Sy5wTXFf4kB73UfVH1CkjwOD
	iBirPLAfuwyGItM+j/F0p08SMgmIQo1wdaSDE9kzogEnIAU4zZLYpMg/Vx7l2w=
X-Google-Smtp-Source: AGHT+IH8lweP2XYB08E+inbzDnXw7d9uWVgrdDvTnlgrkRHMKVP2lag0JhfKwKbfvNE1zYcp4Zi2rA==
X-Received: by 2002:a05:622a:15cd:b0:4e8:894e:1345 with SMTP id d75a77b69052e-4e89d07d9b1mr104925911cf.0.1760809560785;
        Sat, 18 Oct 2025 10:46:00 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:45:59 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:19 -0400
Subject: [PATCH v18 08/16] rust: pci: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-8-ef3d02760804@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809527; l=918;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=03bsWp5q/RvNg/sXSrzNos1bBBR49+qyJdq4+m4Ha6w=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QH27Y5uAfTmrvKZIdGCHYL/oomYMJkFLfNEOLtlLtpxxDPHsRr1ISH3D/10dPkATw5kw42q12/O
 zIe1ETaFKVAY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit ed78a01887e2 ("rust: pci: provide access to PCI
Class and Class-related items").

Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/pci/id.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index 7f2a7f57507f..5f5d59ff49fc 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -4,8 +4,7 @@
 //!
 //! This module contains PCI class codes, Vendor IDs, and supporting types.
 
-use crate::{bindings, error::code::EINVAL, error::Error, prelude::*};
-use core::fmt;
+use crate::{bindings, error::code::EINVAL, error::Error, fmt, prelude::*};
 
 /// PCI device class codes.
 ///

-- 
2.51.1


