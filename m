Return-Path: <linux-kernel+bounces-842012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81598BB8C59
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 12:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3250D4E968A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F3526F46F;
	Sat,  4 Oct 2025 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oRnheWsC"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51422472B1
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759572494; cv=none; b=Ta/INBMUxQcUuN5GYUnXFGeXsLj41ae9qOKuOtr6yrzxMkwXd5oGuBLchzP/t6h0njZBq1WpDMXIISFpKwErTgBAZU/rG3uBS9EU35/usTFIItN8wmkrHijAOMW3XO38mr8X/F492U9UL3EcIcXC/BOC2ELNVyDJXNdfqgN8+UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759572494; c=relaxed/simple;
	bh=QpvyhwnXAfXkQ7I1kL3n8PvNh/8XJMhS30c4xnByIew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I/DFpljmcRygqr/lo15eyfe2SP+JQz2Crhc4vE8ILfmF4QiBOlZz2eMpIE+aCebRBxEVj63A8K+llm2QTBmES7g8qc9Vjs6iEpEBdEzFYt7RXqCi9y9XI1XzaoUe38JNdtKJoV/RG7uPBJMFo2266SuXeJdgS6zYeWv1viEYuG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oRnheWsC; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e41c32209so12957845e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 03:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759572491; x=1760177291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PD7m4V3LcOsNmzAyutP1ZogMCH/P0pzhxL44mJuhTQw=;
        b=oRnheWsCZyEFN93F7UvCuGK1xktE3zqnvyTizF6HGa+CHmthLoX+GHPt6BhoHPOYKR
         XLxgpfQBjsnaLXJcJnCDu3ezvDbqbjkC170pv84LNv4MmEGr8QFHbOXEkYhYuOcInRp4
         EA/qrDAWZL5mk07DjtVrXK97rz8LoGjz8Tnrq/oGTlqJUGJVJExbmd4/hH5tDb3jf6XQ
         Q91B8FlLdDlHnl1IQ2MLpg/wgv9Kgr69bJhjXS4ufSyfl+lSloFn1pQpUKl+7DzDlKVB
         T7K0uIWD1zA+Qdg43jKzcojov00WHIjv8hnf6OJeUiQufURjK11PdkoIxwIC0vYTtQ0G
         9nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759572491; x=1760177291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PD7m4V3LcOsNmzAyutP1ZogMCH/P0pzhxL44mJuhTQw=;
        b=EA6Nxv31bxvEFTYu8Kr9Sac+WslG6S9fSAO1x5kiO9PcUS5HXlBOyV4COfC+oSwxvM
         mJW5ENeMyCpmP7x/pzBOf221aun+b3nu/lM/7okmIPyGyrUw/6C5688o46J4GutcRiPg
         52lOTk+j6eHcOpJZdTkx4h1c3ekGKE1kXcDSbIAtIu1Ql20UrHp2P6mw+zYoEaOTPKts
         yqfFt6FSf0a8eUKymZyE5wfy85jf887BrUNETrLQHHzn3/t8T0nxSdtpdGxXHloeEQND
         srswSRQJp9u0pFbe1ZmUamdv7+C/30k0MX0dL9LHOoyLifMVM6m5eetEH/c9VmXxd0K0
         5PkA==
X-Forwarded-Encrypted: i=1; AJvYcCUVrvixpiyvMFD+dcHPBTvdseWP6LSVydLnrslepJ3uG2DVTZFiqApesMbf0Fd+Hs2WEY4a5Juf9EvflvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQZjOrHDwvUpiRVXO0HmV7K+fLjqLmuPRyvN3bARXFrQsC3snT
	5P1xYlFQiz5j9XJrAyMf0GzomVt86Fgk/ALI84ZOneZnG/pDvS21RA7YZNYbKqnLgU/LW/VDmHf
	p2GQWEO2AL9k31uR6Lw==
X-Google-Smtp-Source: AGHT+IHWzxbv1MfbNVfAzWAdE5QTxwCdIUKUjX678W8xOCLxpm4vp7vvoUtDz03xKEL+YbtZBPohG4HU9IXusuA=
X-Received: from wmbju1.prod.google.com ([2002:a05:600c:56c1:b0:46e:2f78:5910])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b08:b0:46e:396b:f5ae with SMTP id 5b1f17b1804b1-46e7110cf6fmr45919975e9.16.1759572491043;
 Sat, 04 Oct 2025 03:08:11 -0700 (PDT)
Date: Sat, 04 Oct 2025 10:07:58 +0000
In-Reply-To: <20251004-binder-freeze-v1-0-fb9fcdcf2b73@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251004-binder-freeze-v1-0-fb9fcdcf2b73@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2076; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=QpvyhwnXAfXkQ7I1kL3n8PvNh/8XJMhS30c4xnByIew=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo4PIHCX7G0wS+ULmlB1Pj5EtReUQCUcOKsgMTS
 UN+IVXoMyCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaODyBwAKCRAEWL7uWMY5
 RqnZD/4scx2V0Zg3OUESuXeBN+lwHTPLcNynvK7Nre7ZltCpjeVUDKCjVJvh2IEXOMCuV0JCLF1
 SEhG9nb66U/bHg2RK2Bz1nKNK5jadFFNPR3vWZZLo4Aw2g40eoMMltFAZJOosU4CZsGBBGKwxl4
 pgcjPl68xWY7k5L0C5qEg6dnfVQdn4UQ1X+a0RgoesOzjY4DhgVLAzldOjp5y7tpql75WipzQbY
 OfOSTaSJWJLBDlSqm6kX0eJ3hA0APYBo84MoZW38uc/4VzawtgKqXBPQwquy38xkQOZFhnBzL+V
 BNDiuiDxuzET/OsMmIuVh9ugSh3S1Q1U/yi+Gt7V+YmIB651KsU3ypDsTYNd4Xdgns1mpESRzrk
 RAAfr7T9Uh4ewY5hhWewGt+CgW+RdVFWxDvZ1tM3s9X3q2VLDtKOJRjvLyEENbvZ3jOsh/5ZH1x
 WzhH+Jr2n7F1nZeqbsoyymFAMb/0f/o0ziTFn0s3sJQC/LQtVkLLibQYs3+NldbBNKljV95HNqL
 9MXDU2DCrHo/uKb7AxLTijf0e9FsWMegnoaO7VFCkbw8BY9QJ9dDSrAd0Ax5n3Lg/l2OomRBIvR
 ZP0xef+zAeuLjv2D/9b979vg1BeE81sKfu7EVFYsnEh5qyO3/k0WfFFvxYjDLK5vkY51+SXxG4D WY+FgAaPbtntJ+A==
X-Mailer: b4 0.14.2
Message-ID: <20251004-binder-freeze-v1-2-fb9fcdcf2b73@google.com>
Subject: [PATCH 2/2] rust_binder: don't delete FreezeListener if there are
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


