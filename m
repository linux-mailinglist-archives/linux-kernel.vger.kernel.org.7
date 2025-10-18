Return-Path: <linux-kernel+bounces-859371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C674BED679
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 037F3349E03
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A79270ED9;
	Sat, 18 Oct 2025 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kszrL3uT"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BC72FB96D
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809568; cv=none; b=VS+fJvVRwXfD/IMMr65TZ7w9rUsKq7kAi0LTOgkUe1qak1p9mPc5GaCx2yWB/r6r61eg72h4xPU/6W/+o4/8pLbN9dZwhBbJ/lqre2TkeRkPFBFNqSmS0k67rYQAa+2sjCFRYkjB4AOXpsyCtaHNmPK2LVVaG44luF2y8iJeJYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809568; c=relaxed/simple;
	bh=uLnXUd5iHMMEJTAMJKY0bsxZkX3e5rGAkuIO16n9SP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=esUbmgpOeuUDlLOrFuLyspUnAG24w3FFSZqG7jpf/BZJxaCFcvyWeE4x32PgUASSF6wEDIlTspzN4qluzmuwUNzqAzm/0eqsuHi40rjl2V2HnX7/+E/EEQf5fBYToDukYH577XRgrQ9MlIU40eTv4/dq3BxLnxX/CFs+lAxWnKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kszrL3uT; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-78ed682e9d3so41505516d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809564; x=1761414364; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ycwx31K2mxLEujn4A81pZPUGOjv1ArmgOKcrq9XGsoU=;
        b=kszrL3uT2MycGYw/EJTSEoDBJOl51QsY1HRZBnoMS5rNQfrtHy8rFuVx4EYAQ3WWWb
         8/px861NEGq6zOBuMYIL7mCT4C6REeyknaRu/Ti4jVIqDau0raZ1hTYmks3cd5IO3u8X
         W2nIO954gLVt5PRBOPOx2xOkJumsZj1V5WLUMkGjUTfGypfSSVdZjCliHNgwP7qj63lq
         PhWHrNSjPXBLKZ1sHMsTi/jkD1tMJZhdDehO9L2Y5H588zeEkEarA1jYQYfCkzdp1Vqf
         8t59nYddG86FkXkY950HDvA7dQ0eIqrxhxw0B0DFVLxnjOkfsaQXLldBteNcXA5tJZdD
         ieJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809564; x=1761414364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ycwx31K2mxLEujn4A81pZPUGOjv1ArmgOKcrq9XGsoU=;
        b=XhKggPQ5NEUrB/JXkWILO7bMHU4za8hG3RgwT673gMxJi5peesH63i8h5PH1MrHsiO
         ubikQheW3PgiJTPRMi7DT5S1sAXaAjx0WW0Fp+F5MuMgNHoNbv4wmQfkxw8REjtQyubY
         jxGRbt5lD/bTtGD9RtCSalcgWbFGC+DwPIFvnnNitaGhiD2adfOIRmhcd2XHd12I6PDw
         HXPsEOXBvaqROC8y1N3ewy4n8wvXH0jaPwq4YyyurRK4r7Zf6rDssXkG+vKlEe4/PNhn
         wOrPUHqOS5Ce6xh4lUh4wnk5o7r8v5PAaJ60Ia6Cl9EySsKw4js0ez4WKYl5VXetRS31
         6DzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSHU0o7vvgVnzbM1fywsmwOjpjl4fbt87Q/IU72CHSE7CukpPXZMmMToZVpgm2eMUF5TLVYZZZG0YEQ70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGD5Ow3tZ+lGlH3lAow7CGpgLGXg5g7d/VvDbj4nQ/9HrJWG4h
	BDaZ4GH8+Zddc2KLMV7oqMfYZjGvUWqARlZFruD6hrR/KppcdYYchJC9
X-Gm-Gg: ASbGncvGFSC59nBtqsN+EJJajVJ6ZzDb7Nrs6dVME3rIxjVQHIAaKxmRl33IUMbSVJT
	+BZuWB7rMwBtRHQjzDMY6OvSsAcHi7+Uz8ExYfAsWUp5QoN9L3HcuYvmiJMLcId1aS/vPxTXXKU
	EsjVa5mJnX2LhzOycJnYlDl3afeyDYJ6eFNE/TFW3TcGpcyTWg/WTf25dtACfK874I9z0uth2u3
	+fyyLyeWsm9CEqwd+MXbJTNe2VP3On49TGjUOwEO63nW6lx1c9b1xC8O2q9pqC5rXBQLVAHE3vO
	9jGLuyfK5czM8dtu7BZmj/besPRKYch7rkvkpIQ8yZ6XK1KgaAjvasusDeH2z+0SANdksf5Xgl2
	8A/8fiVKER/wTxEz4XYIGSIYJnmtnwl1T+rS5IzuyYj2yI27C4uG962vBrn3IHd6AhAB4dumPXA
	Xqy+F9r9ni4/iLa7A/6+gTt9U3FKNnLlbI8HdpCAOXfXuhegP6StzHRse7ggZxTFRFTKK76peJk
	QXuHi9Bt/W1NLx4PGPdNtYiqpfov4dYECqrtOVB0YIOn6OX3GN4tczzb/+6hIA93fjoTuEB0w==
X-Google-Smtp-Source: AGHT+IGG7z7f3MNU21/Rti4PmtrZca4GFxKfblibRIkboUBwmpGvzYHP42u9XCSh6vTqFJ+cvotYfQ==
X-Received: by 2002:ac8:5910:0:b0:4e8:9596:ee77 with SMTP id d75a77b69052e-4e89d1eca83mr102709391cf.10.1760809563421;
        Sat, 18 Oct 2025 10:46:03 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:46:02 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:20 -0400
Subject: [PATCH v18 09/16] rust: remove spurious `use core::fmt::Debug`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-9-ef3d02760804@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809527; l=668;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=uLnXUd5iHMMEJTAMJKY0bsxZkX3e5rGAkuIO16n9SP8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGXXqQt9RHGxpoBFZLlXeLUPAugoqd/q2N96Ig7iFhgm9rnqX6mshM+HDXmtIVBN7F9GI6CbJIb
 k7xYI3LBrrwQ=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

We want folks to use `kernel::fmt` but this is only used for `derive` so
can be removed entirely.

This backslid in commit ea60cea07d8c ("rust: add `Alignment` type").

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/ptr.rs | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rust/kernel/ptr.rs b/rust/kernel/ptr.rs
index 2e5e2a090480..e3893ed04049 100644
--- a/rust/kernel/ptr.rs
+++ b/rust/kernel/ptr.rs
@@ -2,7 +2,6 @@
 
 //! Types and functions to work with pointers and addresses.
 
-use core::fmt::Debug;
 use core::mem::align_of;
 use core::num::NonZero;
 

-- 
2.51.1


