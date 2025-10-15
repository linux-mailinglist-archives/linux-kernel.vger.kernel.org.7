Return-Path: <linux-kernel+bounces-855141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83366BE05ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0667B4827A8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6CF30F804;
	Wed, 15 Oct 2025 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA0e42Ho"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713CB30EF64
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556312; cv=none; b=QyM2T7rzBXovBi2AQFR6deC2FIOpg7rb0kle/ShrHCYx3Ta4tom+2n1ZM2Q15y4EfyyxDeoRPZHuYpjOiF7VFM5RKRW49aIeMNxmXpFyBXpkSVMBogvicus9UjnW9BZD9HEo9pFrtjPlNbBk/91xJECX0lXqN+aN4QcJU8rPxLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556312; c=relaxed/simple;
	bh=2D3oEpmQYcHuLZnWIpYHzvkvUja5YWzKptv7Pd2qprM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SjoeLHzjEz3i0OXy3Ne8lnd4tt9DyQxCRYtlGL5i7vBs3bcGZFClzV7XkdywLoGUjjKO8EW8Spyw8ezzdsHMQTeqvFVBy6/MHOjwNncBtYZ0frRVewczd9cq0jFxaWXDS8ZvVvjkbFnwfT2K1A3+ludqqC3AIA568YA8qggGXRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA0e42Ho; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-856cbf74c4aso1330144585a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556308; x=1761161108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eY/3IsdbfI0mC9DM0+1rrUO6mTTZQIEYJMq8pO85TCM=;
        b=cA0e42HoUfvW3gVGL6iILHQaTVyX/2HEor6DEKhjyaVcB7FRSv5qHA29OksEfPZqjS
         t7wxBGLxx8ApRZpqC5v1ILhA8EUiN84/+tYTfRCIyIPr8IfGo/63h5x2P/edOFmMYS8/
         DOOP49a1itunEXOlj78PLdKB2Gph4vdk9gmT2h3J5xmtwC9ga6OrGRNf/VCZeMf4rUtV
         lBO1IpexRrtiZLemfbk+Vods/Cq+LpvJFTJtIGTPVuONUhXgCq5pucfQ9ZBqjHklOUBL
         j9pbyGLmAVVWDd7lMM20z18ms32goqE2sMBByxyyuNXPuTGpygfAx0M2mgM9fH5JDkm2
         xCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556308; x=1761161108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eY/3IsdbfI0mC9DM0+1rrUO6mTTZQIEYJMq8pO85TCM=;
        b=fBxVVzVjCkffmMjew+NMmDHKSv+6JQGFSinbZ1PxHQF60/iJA90tlPN4ohl9vipaIC
         uHubQ+P/s7m9XUm9+tcs91YGAPpY4FOHNvUESsJFGeLV88t7v3iKf0+TGkEdJzCLC+3G
         hwFk3QXNuMSIWMbnwK+rFyFKdnxzHw3CNvTcKxlQFeKO/o3GKJUPnVQb0J49IrU+n8Yx
         yEft0mGuk3hS/+6KoI4pk4NXJ7Wx85A60geYVtumCcrdoACmQvEzfCr9nRPzt4EqdwSu
         ASjod34FxYSrzlgyJ6F3XFUerNQf1zxQfmrhPdHlCEaOoIGfrMBOy15KYqbeiT0ePPnY
         kRFg==
X-Forwarded-Encrypted: i=1; AJvYcCVPuyEeddkIdDIywMquSLYlwH9AlbLeGD4qIFgZDihdMrCt7gf7vxhL4bjsEjxBicFxzn6G6hpkpd2J+mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHQnlt7EuWMwOqNzcx5GWO69E/h8g85OYLSR7/fZKaK5nGw7WS
	gVEbS9Ovn7k3TakvGVxqzJ5M/6Y7cgZjIbefM8A66Fv37LoubbcphXXM
X-Gm-Gg: ASbGncv5cMO0Sia0OLJtOfQ7UcpbKR6czvCnqwJwnm5yNi1Z1klRhnN3cwO0IWs+uQl
	+8stUXYmUJaiw1DdP1AqmyVLtAvTMsj725RXvjeRt5++RW7jkHK3JfHKHmhyR6P+THrGX1D1g06
	rm82M140CbmlYp6dA3HROjC8Fx/8NRa1dXxjVTI1hZ01xnKbXZurGBPbKaJMcTqE4umvFdrQibO
	rjF4DM35iWgnWkS8jYnXyX4oo08wT1vmINf0ByElo+/KnzlhxzMNmFNPYiQi4OJ2lTUY2MgpEsG
	+i16bfYxrzawCa8eM7C/PBqOTIx+L2z3MNRaZIApgleT9TSHOXotbIWonpwL0r3HJ+n+Td8UX+W
	EvFqr5nW0zzw/pLPNRKKtjDGFuBAmwZRjoVR0Zce5Jt+AnUYxTimGj/D6NlqijHdLM7DlQiVRQn
	TdaxuvrMzbPvZj13qdu+TJjMmr5loHBvYPegZ2trQMU1Z1qO4TJZn92vZUFOeA8RfAZ7EElaozm
	huOkHA5UfKm4iBEa96BeckYrml9
X-Google-Smtp-Source: AGHT+IF/CUBVvLt2dkQCDA5YZrHOn4tHGJzgB3mXHJTBxXrUXPaXJyBN4wC5HBKmPT8DqAH/ADgWzg==
X-Received: by 2002:ac8:7f8f:0:b0:4db:aeb0:b624 with SMTP id d75a77b69052e-4e6eaceb3e7mr380441741cf.30.1760556307886;
        Wed, 15 Oct 2025 12:25:07 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:07 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:34 -0400
Subject: [PATCH v17 04/11] rust_binder: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-4-dc5e7aec870d@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556295; l=1790;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=2D3oEpmQYcHuLZnWIpYHzvkvUja5YWzKptv7Pd2qprM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLuOpLGTfFQjBZXdio1nayh5dtiHoR1n54dLy3fgkauJkhueXEntNbGxy1JTge4mrx8nVKiNy+z
 1vw2Aya3HWws=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoiding methods that only exist on the latter.

This backslid in commit eafedbc7c050 ("rust_binder: add Rust Binder
driver").

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/android/binder/stats.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder/stats.rs b/drivers/android/binder/stats.rs
index a83ec111d2cb..10c43679d5c3 100644
--- a/drivers/android/binder/stats.rs
+++ b/drivers/android/binder/stats.rs
@@ -72,7 +72,7 @@ pub(super) fn command_string(i: usize) -> &'static str {
         // SAFETY: Accessing `binder_command_strings` is always safe.
         let c_str_ptr = unsafe { binder_command_strings[i] };
         // SAFETY: The `binder_command_strings` array only contains nul-terminated strings.
-        let bytes = unsafe { CStr::from_char_ptr(c_str_ptr) }.as_bytes();
+        let bytes = unsafe { CStr::from_char_ptr(c_str_ptr) }.to_bytes();
         // SAFETY: The `binder_command_strings` array only contains strings with ascii-chars.
         unsafe { from_utf8_unchecked(bytes) }
     }
@@ -81,7 +81,7 @@ pub(super) fn return_string(i: usize) -> &'static str {
         // SAFETY: Accessing `binder_return_strings` is always safe.
         let c_str_ptr = unsafe { binder_return_strings[i] };
         // SAFETY: The `binder_command_strings` array only contains nul-terminated strings.
-        let bytes = unsafe { CStr::from_char_ptr(c_str_ptr) }.as_bytes();
+        let bytes = unsafe { CStr::from_char_ptr(c_str_ptr) }.to_bytes();
         // SAFETY: The `binder_command_strings` array only contains strings with ascii-chars.
         unsafe { from_utf8_unchecked(bytes) }
     }

-- 
2.51.0


