Return-Path: <linux-kernel+bounces-779966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8C9B2FB86
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD7BB6723C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CA523D7C5;
	Thu, 21 Aug 2025 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjm8FrmB"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01977230981
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784529; cv=none; b=qVHVqcdaLy6zBi5YlyE6Psp46+EPCSVkgh+UQLI7TkSNdvdVCgVxgtkNOgKZGfrwu5eVbweLxuCyjBau35x/q8T4ZLyUHHqauH3Su6dW4J5SMLs/IYWltafJnhPyajE/K2+4Ub08ga0cGhFpvZAgWPUKRGiYwR1ki+DiMPD3hHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784529; c=relaxed/simple;
	bh=wHspB9lP9ytZ5qoP/apoEbwEudQSgCr+8Ne7IMCn/0k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ommOzFEVs5Ygwt4nHfTHM2aHEAelQ85Db7A1VIRtHGJo7ryQ66MMtQHZDatjBitHk3DM6jcSbunlxVr5L72q8Yp82n8aAnnECWNkXzlUzCv5Xtt6e5Hh84jLmrqc+lzY+LEpC4JApGRgD/dVhAcV/uprC+3kWiGqmKFHfmJKh74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjm8FrmB; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323267915ebso2284025a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755784527; x=1756389327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lKdnyTkgvffM7mkS2a96ehAiqGPtNgTkiNVc3WNtEtY=;
        b=gjm8FrmBbQp7asF8cKHCZUMTFFwFuB9vQb/JAj3PN17eht+yeIorCau16Il27U+U1I
         JJ5dsZ+vYoFJIMM14w3HOaCqGWIWPhgvSU5gjPL1KADWM7Av6UU1BpuwFlU5CSw5YuYg
         TOCXPp13NYpJyRxKzxff8A9kHDxttawP0AyxDm97h23VZKHk2UxpmYxllJrKJqZhDGWX
         NpM9UgaAOXi157/QiJP14kSTVhYxT4kKzGlKa9RFyo3U4QSYDdlNCP3PqbETuPONjZpV
         b0G3hdifBWN+RYY1Zlj8C6/k0v+dxtmYqD7tzs9rw/2B1dA/I60ysOZU5uJ/lXDLD5+Q
         kw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755784527; x=1756389327;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKdnyTkgvffM7mkS2a96ehAiqGPtNgTkiNVc3WNtEtY=;
        b=wj4MzYfFuzjBljN6/D2IMpoS7/i0Hf6RlLAihY3r2X5nBlOv3VKJKFoSu5jviFzzRS
         NTVzYEObD4MYYOL/GU2wEfC34VB4XCMp6NI3Ynwa6Jo0CLY+tHqXR066wX58pkIEy6yi
         F2Kzs4oLn/l6wzFtZg2Q1rYdR9KwBfq8pELc2ONnStEsDB3Y52oVJZ859hq9zgveEwLP
         QZecBCxN7mNoRZEqYlryBEDs+oqkpQ4xGij03RtKqk+Sebv34eTugbtw5tIztwC5f1sB
         IQDp56qEJ/t65vS/mifFJGQDVA/tyk0WSBrIBFrWvjOSKdTsOcwLMISeiZwomrWuNRAa
         l2RA==
X-Forwarded-Encrypted: i=1; AJvYcCViH3C4mVHPy83gQgiby4w818G7hAggTX/vTk0htzUoFQcmvCcqJLS2nW8AR91msebBr5IamBCC1I0wozU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqtT3nVAoVnplfYeAyV7rMKy83VEu1YrQiVBF6KJwRyP32YTRX
	1pHdXBCyt1ZbiZI6a2FkqSXurqTJGKzI59ThWb5sANBJfRNk+VFDxZraaNY5A5kwgKo2g4hLjbK
	euoBNzUkVtp8YSw==
X-Google-Smtp-Source: AGHT+IHsMqhR+FC1Vaoc1hCDg2gMTNywVUl9RwkU/LLcAQVairjJf0TCsVawP0vFsJexqsUgLxEVKVJAb9sjRQ==
X-Received: from pljc15.prod.google.com ([2002:a17:903:3b8f:b0:243:31a:f8e2])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2f85:b0:242:cf0b:66cd with SMTP id d9443c01a7336-245fed69268mr38021605ad.34.1755784527309;
 Thu, 21 Aug 2025 06:55:27 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:55:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821135522.2878772-1-cmllamas@google.com>
Subject: [PATCH] netlink: specs: binder: replace underscores with dashes in names
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Li Li <dualli@google.com>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Thorsten Leemhuis <linux@leemhuis.info>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

The usage of underscores is no longer allowed for the 'name' format in
the yaml spec. Instead, dashes should be used. This fixes the build
issue reported by Thorsten that showed up on linux-next.

Note this change has no impact on C code.

Cc: Jakub Kicinski <kuba@kernel.org>
Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes: https://lore.kernel.org/all/e21744a4-0155-40ec-b8c1-d81b14107c9f@leemhuis.info/
Fixes: 63740349eba7 ("binder: introduce transaction reports via netlink")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 Documentation/netlink/specs/binder.yaml | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/netlink/specs/binder.yaml b/Documentation/netlink/specs/binder.yaml
index 140b77a6afee..0f0575ad1265 100644
--- a/Documentation/netlink/specs/binder.yaml
+++ b/Documentation/netlink/specs/binder.yaml
@@ -26,27 +26,27 @@ attribute-sets:
         type: string
         doc: The binder context where the transaction occurred.
       -
-        name: from_pid
+        name: from-pid
         type: u32
         doc: The PID of the sender process.
       -
-        name: from_tid
+        name: from-tid
         type: u32
         doc: The TID of the sender thread.
       -
-        name: to_pid
+        name: to-pid
         type: u32
         doc: |
           The PID of the recipient process. This attribute may not be present
           if the target could not be determined.
       -
-        name: to_tid
+        name: to-tid
         type: u32
         doc: |
           The TID of the recipient thread. This attribute may not be present
           if the target could not be determined.
       -
-        name: is_reply
+        name: is-reply
         type: flag
         doc: When present, indicates the failed transaction is a reply.
       -
@@ -58,7 +58,7 @@ attribute-sets:
         type: u32
         doc: The application-defined code from the transaction.
       -
-        name: data_size
+        name: data-size
         type: u32
         doc: The transaction payload size in bytes.
 
@@ -78,14 +78,14 @@ operations:
         attributes:
           - error
           - context
-          - from_pid
-          - from_tid
-          - to_pid
-          - to_tid
-          - is_reply
+          - from-pid
+          - from-tid
+          - to-pid
+          - to-tid
+          - is-reply
           - flags
           - code
-          - data_size
+          - data-size
 
 mcast-groups:
   list:
-- 
2.51.0.rc1.193.gad69d77794-goog


