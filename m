Return-Path: <linux-kernel+bounces-844035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D57BC0DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71CED189F61A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FBE2D8391;
	Tue,  7 Oct 2025 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nUUet7J8"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EC72D77F5
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830001; cv=none; b=OuBphTQJOaW+Py3lBtifvP3rF6x0D9tlk6dkN6k2SVKJzkKBCV8orzyOqJ4whoUOHKpwMQCKO8PkFVvYMPsZ2Chnz5G5aj0EXPdijGYoFn/CgRL+FFnUKOhUNx6FqXD9xtAvzxchMLF6BSFnPMtKmFMxiJzPYAWJoQ6lrf0w+lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830001; c=relaxed/simple;
	bh=QpvyhwnXAfXkQ7I1kL3n8PvNh/8XJMhS30c4xnByIew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E+iyfoBhz4yIrk1tik8yOGvip4w3LQ6NlKPGuPHMFkNo33zAoRQ4K7bBXEyj5OG5poyopwu6ateJQAa88VfIan6kd2T+ixcRsaD63/5frsGDcerkqgem89QDXg2rcRaJEeI8S4SQZDL6Rj0tDzRVRQqqnCeQMHnoLPd/J7D1vfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nUUet7J8; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46eee58d405so9037455e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759829998; x=1760434798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PD7m4V3LcOsNmzAyutP1ZogMCH/P0pzhxL44mJuhTQw=;
        b=nUUet7J8OtS/DJfgbNKbRvQVB+TX8w2pMTp5m4dlIC0L4ICoFDq1EruwVybVMoatKo
         m8b6onxuwzhM1SOmHG+kX+MVp1MVq+RrbsU+hv0RCzYrFZjZ++0ZHEU+bafM8+2S3A0x
         ya1ezS6yR09gZHWJloSFtehBslro4pSIs7NYWH+DdcKL1rF0WQZjWCrKN6JzNN5rpcdK
         nbiNYmXuzBOqWWI+rsWAg4TKdyGf5geP0CqWIq8/CCa7XBst16jOs3WXvqaOsdjE0IIb
         ke8hChgvgMIFwZLpPxyc5zGxAR6iPjjy0FvT+DK+zzEnzyFZqPgg71TRmSyW2yTACom6
         u4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759829998; x=1760434798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PD7m4V3LcOsNmzAyutP1ZogMCH/P0pzhxL44mJuhTQw=;
        b=ID59DmMJQcCqg1ZV8HZZTOE5FP0PeoO/RJIEGQjdySsg/YXyz0qhjcYYiiCWam5uL0
         asfJcWbWMrG/pwrixKDjF5jq2MUg5yq7juo1f0tK10ugFFS6WBafD94vzWdkneYiGmc6
         5Qh1QdSMsloTTJb9SLBQF/djWduJzoNuxLRNTJsg5Gvsw61IdSVjnY7gKfaRyvcpMSYO
         CvVJsgmMjBFhg8gDzBBdc/IVGF1MqkZhYPvzSExpSaUdgNBHsPAIUrPnVz5ZNhrHnjRd
         PI6mIWRA0DVQvxFOxH/O5UlFLyJNIeeIaQgXVWyparnSnF8L8VJXiB1WxHRYg2p/NfFz
         l/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXDc93idHBpHZxBszpmH5XX6QXMC1fgP2lk6U1tZ8JB+Zdi9OXF4ovjb8fqIugzreUjD5jLKViBEJcO6SA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzchCQcR8SG2j0k3enxudlPX6zMnnHiatjD1UDq465VsQQqlbv7
	kmmNIIUsluxxsYckD+0B0TinIvwDUmFC3owYBDCb4nIWP9MpUUwQzbh3dT3mKoO13aR1xIFAisU
	bVIeNfLK1AouKGW1AFw==
X-Google-Smtp-Source: AGHT+IGDQ5871GzAA2FmZnN+u4l+4HJ9kTGxv68wBTIylL9+aSmjekfu0EbApFKz4Nn+FYrGWBHEa6nrVKiiKq8=
X-Received: from wmbh4.prod.google.com ([2002:a05:600c:a104:b0:45f:2306:167])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83cf:b0:46e:4705:4958 with SMTP id 5b1f17b1804b1-46e7114e8a1mr118843605e9.30.1759829998566;
 Tue, 07 Oct 2025 02:39:58 -0700 (PDT)
Date: Tue, 07 Oct 2025 09:39:52 +0000
In-Reply-To: <20251007-binder-freeze-v2-0-5376bd64fb59@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007-binder-freeze-v2-0-5376bd64fb59@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2076; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=QpvyhwnXAfXkQ7I1kL3n8PvNh/8XJMhS30c4xnByIew=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo5N/rNt03RWB2Xg09BXFWbrbXDEWxbg7kX8p6O
 1UoGk4r3iqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaOTf6wAKCRAEWL7uWMY5
 RhKyEAC1Hu9FC1oIoPydREz9xjJ6EAq7i/IviL25a6BcUQSIg3kHeA3BOSDobvMsYNF3d5cuSqF
 Q2bngrPga6jL9KVMpHMeZu/BSAivHucuI7XjeqiOxmRBlQoknuUc/m2IJgi4w6ZqgSBD5qU4tsk
 dJ4QnxlutHAQtVjabot9JXJNNOHRibzP4M2RkPJDheL00ukcpFV7lVqDQck6RS+T9O2Cv4k9WVF
 mW5N7+U4NpVs3vyfisXzip/Sh04RMQXTHpXy0/QCj8rNcOWA+oDT+LpylxFX6Z3mFFpbjarkYDT
 f7wXpfJlUwymUOZgBXTWws1K3JxcA8gN2swARnUHjSDZLcSBY3Od2wEqrEwgBSvqJTdVKkzeJPC
 4DNccfXKSvBmpzrolHLiy48mS/OfoGHeQomxwP9AqaPefy4OjmY+rucYkub2xY4sJVQYTULjD7L
 R/xuh7uAUw8o1On5XPMNmVOA7APpg2ifk+xJXZtoBgxg5BG+u9i4G7uadv8klKXVSh9jG1ORaKK
 3swZTABCHK0y9UWmm7S5N7OYdD8MrANJdxWm1FMpHUcool+zwseUF58k+HyZ6jrk7v4YZtnVWFi
 RB8BFp1cwHxP90qrsDql1r4Mqgmp6p5ltXOR+AfvNlykP1Mq35EOjgiWzhr/wYoHip27C8G/1bt kVBp9GwLD/mDaAA==
X-Mailer: b4 0.14.2
Message-ID: <20251007-binder-freeze-v2-2-5376bd64fb59@google.com>
Subject: [PATCH v2 2/3] rust_binder: don't delete FreezeListener if there are
 pending duplicates
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

When userspace issues commands to a freeze listener, it identifies it
using a cookie. Normally this cookie uniquely identifies a freeze
listener, but when userspace clears a listener with the intent of
deleting it, it's allowed to "regret" clearing it and create a new
freeze listener for the same node using the same cookie. (IMO this was
an API mistake, but userspace relies on it.)

Currently if the active freeze listener gets fully deleted while there
are still pending duplicates, then the code incorrectly deletes the
pending duplicates too. To fix this, do not delete the entry if there
are still pending duplicates.

Since the current data structure requires a main freeze listener, we
convert one pending duplicate into the primary listener in this
scenario.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/freeze.rs | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder/freeze.rs b/drivers/android/binder/freeze.rs
index 74bebb8d4d9b24860eed34363ce69b1c6df58028..e304aceca7f31c15444cf67bb13488cd144345e6 100644
--- a/drivers/android/binder/freeze.rs
+++ b/drivers/android/binder/freeze.rs
@@ -106,7 +106,16 @@ fn do_work(
             return Ok(true);
         }
         if freeze.is_clearing {
-            _removed_listener = freeze_entry.remove_node();
+            kernel::warn_on!(freeze.num_cleared_duplicates != 0);
+            if freeze.num_pending_duplicates > 0 {
+                // The primary freeze listener was deleted, so convert a pending duplicate back
+                // into the primary one.
+                freeze.num_pending_duplicates -= 1;
+                freeze.is_pending = true;
+                freeze.is_clearing = true;
+            } else {
+                _removed_listener = freeze_entry.remove_node();
+            }
             drop(node_refs);
             writer.write_code(BR_CLEAR_FREEZE_NOTIFICATION_DONE)?;
             writer.write_payload(&self.cookie.0)?;

-- 
2.51.0.618.g983fd99d29-goog


