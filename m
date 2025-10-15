Return-Path: <linux-kernel+bounces-855146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C273BE063B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9491584763
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55B331194D;
	Wed, 15 Oct 2025 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAWmy3km"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CDF3112DA
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556324; cv=none; b=eXP2eOoR8bXYbrkR8psUdzDe0WEaFnG2GjvqeokIRmoYjxTVUjW8qougAHmIsOTw8x/VcpKMqxbRtWjlCvjlcqwD34+rpbf71pDaoa/5CCr/DR+GTmMVSrGsQec++UUw5fBSwWDWjDFZNomKliSL5FAWB18w+6aVfulld4iQjrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556324; c=relaxed/simple;
	bh=5hkdJMBXvyM5ROn0CqVVfhpYPBMFyjtfSpETEaraIms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N331qd7h5ctR9xJmeMhf5mfBYpijpnCOJZtGDaWuVXUSFH68JyVyXxgjZaqbLfxknfpNPQvgIFeb0YmZR4W8cO8sSVJ2+dC32hLo8N/h/Uy40l2lddP9EPGymjZ+ugy8yPvAkpHx8MOzY7XlQ2Kj2dNN1Yo0Re8SSKW/BMs61W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAWmy3km; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8738c6fdbe8so22082736d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556320; x=1761161120; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zfr+jg9qjRBK3esGQQzBD5L0g4VK44y370TXRFAq7lU=;
        b=EAWmy3kml5F4+VbSFVMMwmSbTG1JPrXc25HIJ7wTREx+dvdcv925LAr+3H/MK2yo8J
         3b9T0AX5Ziu4paKrSgcqxGTenO1PwPrhrzkoNEbyIxoWWF+Aq3cWbc+5V2kh4UQ7AA8E
         VQsfzcDkX92HSyd5p5oao9KAr6R1RVTKp7/itf1AdXmq07NlGuakb3PvyX35cHUwmxC2
         6fjYPFDV97+fr4if6sLN4cmCN0hWUKM1L9CBEYXRKwNeu9kOCNzsg2+6Ek2mJsUJ0RPP
         OkPwUg+mIY2Pch+B8q08Kn7Z3MuD/FVy14virXSGtKUv+g0ES3E3mh0HVDExPtD2Wfh/
         SO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556320; x=1761161120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zfr+jg9qjRBK3esGQQzBD5L0g4VK44y370TXRFAq7lU=;
        b=TZNn6DDWz5D8+PEDDNvoeOHC5nEI9pjk1pgYkVgwh5bm1bCZL1KBDjEab3x7BvAQs1
         vQm4HshSv1I2uamFdEwLJJxIAJjmVu6LYb4YidG41HBJ9TyzZk5qmHtEEduGqzzMSayK
         v/f/62wwxYMg8/xHQ42KfNfuruORwNrj14LBYpxAG4oHRaIfGXH8jtqWgYecvlnC+yrn
         HcIUD5H0P0UEUnO4u2jmtDqA17iP7QdNZZO0eBgEfss5JSe5IeVkRkbJyxfJ7W53Zbkk
         mX1LCm8PTvv6sUfsONWQ3KsXZAaL9o6DjnJhYdZaP76Vz3CrW0xLbkKXRO97VFchvl3t
         7EXg==
X-Forwarded-Encrypted: i=1; AJvYcCUqqcLUdneyZ75X+ZfEv7vxa6aju7WlRglRNzoVvkex6LwDVB88sen4LUzbl1vIXD2LVDCUmB5W0MTu3IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGMPLTFSClo6HJQCcPIaYKYgZ08j46RZryeUu8ZICw3H3KoaI2
	C5Y5Yg2qLUwwP8MBtGFyERffJUTJh0Tz5n8bgMlrczMMYXLT3giiWX43
X-Gm-Gg: ASbGncvGnnThP09IwC7Mknb2+rkdUp1XGv+yoTcyD30xlTryPvQXB9WN6AfIoVdT0E/
	C8CbN+rRloL18vVLyy7BCCLLXC/UeUaWGnUGY75ol/mhs5f2P14Hhdec2zD0jO7VKatmIqsCcs3
	dhjoan9dk8lQA7qJbpI5UuRs9tyVaACTLU+NmE4tBK6vpRzBgW0SeYqg2XzY2qEV6Tn2Tni34/Z
	ertidhH6gmfqVlx6YOLTPP32nkjgz7weMgSAaJ3dK2xaVv3P7ZkElwEP2viHMPDApm/KiPyrRlJ
	tBU/fA/gNQzYByJU1oLUMLn0nh5QgsKzYxLMdsPRllIJQ9A9s66lr4yEK5xJj/4FE+ybV8Ktahn
	qa96jU1TxRMJhopqkwO5rUgBi8tST6MXSOR23PzyrDRqB7Nst9bdSfg6E3U0VyfVJdytaULWExT
	PseFmQUxgKh9kxA7G0Yu1dtm5y+FZL9CeXeQVehCHaC0pZIU5LV1CS2BZZALpAE+mLMGUq+fAJ9
	A/CXbK413TXjxFTnhaGnSO12PjblwXuKIBY4q6NyZgdai4NJFOP0fXGiivN7Rs=
X-Google-Smtp-Source: AGHT+IEDOgFM0nazGEEfzHtKDS647mvDkfCfJSWTYyfnR0K2d3p2LPiGQli6GsrPQ32Cigz0HxquCQ==
X-Received: by 2002:ad4:5fc5:0:b0:787:f736:bc66 with SMTP id 6a1803df08f44-87c0c5cb92fmr20009666d6.1.1760556320049;
        Wed, 15 Oct 2025 12:25:20 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:19 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:39 -0400
Subject: [PATCH v17 09/11] rust: remove spurious `use core::fmt::Debug`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-9-dc5e7aec870d@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556296; l=620;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=5hkdJMBXvyM5ROn0CqVVfhpYPBMFyjtfSpETEaraIms=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QA49f7ifUr2XwLcazgyI6X2saN5gtmXaaA6IvRCW2zqJXH2aWsvrcTeWwyt5IimaZuePXX9+Xm5
 hOtGKK/bcVgE=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

We want folks to use `kernel::fmt` but this is only used for `derive` so
can be removed entirely.

This backslid in commit ea60cea07d8c ("rust: add `Alignment` type").

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
2.51.0


