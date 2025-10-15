Return-Path: <linux-kernel+bounces-854660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EDABDF044
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A0A64E46FC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEE523BCEE;
	Wed, 15 Oct 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/hbLFPi"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83226C3A7
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538434; cv=none; b=GyPCE/hdrihrHOKFvfK274iVkYb6MLuLdhNj3EsI1SnT7eFZn5GKtl2Fbr8GMvIowNs2ZqwAAQSUmx9vcQRjpFFcpMJxtx3fFpURWlltMl8ud2U1JesIQ08UHZWKjd9q6HUdxC8CQiXDiezUyGvgzyeUW4HB+4rr1NHvRoxVzcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538434; c=relaxed/simple;
	bh=dsDI1RJ7iOJZ1o11rlqxYBdHaU+oibd6tlWuQ1XCfK0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bOGCFDx7HRH9bXJYFRHSA6KWxPDjPRrdmlkzzNc47WYFRijvEHXCi8e4M+mrzErTrDRLzEEvzJFbauEbMvYLp0WX8eo28kpKvy5/3VX/PHSMtoin84a3VcysPfAq0NKbhY7gaer7brizOiVFmCl84heLlZ69/wz3LZI/jKRgeaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/hbLFPi; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso5231008f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760538431; x=1761143231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Ud06CitN0X5llb6w2uGUfUt/SgqImUrPlKVZN1V9Iw=;
        b=i/hbLFPiw3M1w00J3KPfDLmJMlJ4sfPWn8DSrkZ73f1pnTexW1vLN4tM01GDXXxbUr
         IxatU9U7oUMgXoncN/83DMJxX6Y9M9wnjGkGTcmYoa6oza+L04WvgQkbXLns7uKDNFt/
         RNMt7T0Mb4LK5vfLHpqGC5U7DBtES1XKIGq+q6en7Q4wghAmvEzz6w2/JvL8/Z1uDFlt
         HIbntssfRkhkgL0NM4vGjfOeduCw/giAbS8/GqB9Qy6CjgodHsskZs52jCyrrKKD7MYq
         VaMnzgSagxlAxxmuKzOAGcqRqLY4v8EE8ypqNgJ3pd1HUb43zw6Q987WS4fEOl+7twIm
         JgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760538431; x=1761143231;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Ud06CitN0X5llb6w2uGUfUt/SgqImUrPlKVZN1V9Iw=;
        b=GmaaVIgPSTtairAB2bqFKwNxbVMM4y4a7GoGB7LuV1UgFovcUmsr0JCV81HzKPGT9q
         Z+x7uMDAvxV8RglPHkgBIbgS1egm9nLamiWd39T77zR56SY+3E6KhcRzIGbXF8hUW/ou
         tpDPpGdhLHycDxZKheSMBG7sMfXkuJM3aTIbIwNyX2iLshoyVLz8xMJK29ls7Y5ICQFF
         merGsjF0lO22QfHkXVqtBrQRsKirXfwRdk1MMdxzCXpma4kFcb6rKQPpLlZtfI7SJzfo
         iB1P0GZSfeXe8xG9/x+f/cM05IjNmibySIDoX1MIDCLPZXIGTzpUxu+l67TJXimcoDSq
         uf0A==
X-Forwarded-Encrypted: i=1; AJvYcCXAOx48hhSYSA+4rxFFYnITDFAurNlAW0YwHemwYEVB3p/tu5xpprGnOQ83zklsZp2fwTVnhGec997COfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAcj4slVv8lPZKOWTcMdvIZx2mxAvr193ei6MQ3xEAivs7VB2B
	8o4o2CLr2axMSbDkIRxUFXuFukdJWW7N/Z18ngISNvvg3wW18/YZ0KM9zgvvlmfwUz7Eq4wtjFV
	Q5ySsIFvzP+yFmy12Xw==
X-Google-Smtp-Source: AGHT+IHb64lw21XmyOYVh0OeJqvub8sjU7F/QnsuRgl4Q0CzpeMJy1L6FXCnF4eh5HgYQdl9Kjdj910PwKUzEqE=
X-Received: from wrqh11.prod.google.com ([2002:a5d:430b:0:b0:426:fae8:577a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2891:b0:3ee:1523:2310 with SMTP id ffacd0b85a97d-4266e7c203emr20408076f8f.27.1760538431108;
 Wed, 15 Oct 2025 07:27:11 -0700 (PDT)
Date: Wed, 15 Oct 2025 14:26:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC6v72gC/x3MwQpAQBRG4VfRXbtlbkbxKrJg5sdNDc0USt7dZ
 PktznkoISoSdcVDEacm3UOGKQty6xgWsPpskkqsqYzlSYNH5Avjxhocz9LWaMQLXEO5OiJmvf9 jP7zvB/mwQSlhAAAA
X-Change-Id: 20251015-binder-weak-inc-f294e62d2ec6
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2089; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=dsDI1RJ7iOJZ1o11rlqxYBdHaU+oibd6tlWuQ1XCfK0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo76856a/H40IM4N39AKKBc9FidyuLop+8rXnPx
 pcy4CN1AsOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaO+vOQAKCRAEWL7uWMY5
 Rgg4D/9YG95l7RrRdP2bQdN1MHlvxY5HzIIuEHPKf3eW97I5t2ewC/Hf6D+y/y23MkgmT/i04gK
 CX9lA1mjxjxlZ++Q81IOjAOmaGK+9F35wnbrKN5EJBXOZBNrEgFIxs0QyebhKyREhaCiOmkK513
 bMmKjXFESiWI0QIcUAm3u9KmQUeYQFFBbZ5B/ncVOBMQ+uErSa9FJZlqIPhErkc83JJu+GW3N7Q
 DhqBH3ScldTbl2olHfqkR3jotkj6RGH3Me3z7Iw7v11+CCNaDFTupGfOO8FlebAttXnPTCMbUYc
 cXTPcd6xOcxH+jsWmty1AvO5amZ28YF+3H+PmI91vv73xCWeG7IylO3bFJkPTG35C9IQqpW9Gth
 O8FAX466ZOVPBVacI1ORUF9KfNsJ7D9zN27xxNqurKcACHNkRvOts7LKGJsRwuaDsC9ZCWtCJK6
 lKMgHz/Fs6Kpb8lgMd1MrM+/yFqp5wojrDy6PejxgwP0+lZU206PwkhBQAPWepg5WH/foMiZoU6
 FTKf/ynfAW3Wgmoy8PNUgkoGBJHm+ZhOWtCOW9W+F3CawvI6P55v4hrjbrbwIl6hTaF9nywzlv6
 3vJ6LqF770URK8hNr+Clm5NJ6F9eF1jC8xgXQ8dJXZ21DMmwYWFzAfoxNexebl6dlh1BacbTTFk jZ0t4nDgLjSm/6A==
X-Mailer: b4 0.14.2
Message-ID: <20251015-binder-weak-inc-v1-1-7914b092c371@google.com>
Subject: [PATCH] binder: remove "invalid inc weak" check
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Brian Swetland <swetland@google.com>, 
	Greg Kroah-Hartman <gregkh@suse.de>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

There are no scenarios where a weak increment is invalid on binder_node.
The only possible case where it could be invalid is if the kernel
delivers BR_DECREFS to the process that owns the node, and then
increments the weak refcount again, effectively "reviving" a dead node.

However, that is not possible: when the BR_DECREFS command is delivered,
the kernel removes and frees the binder_node. The fact that you were
able to call binder_inc_node_nilocked() implies that the node is not yet
destroyed, which implies that BR_DECREFS has not been delivered to
userspace, so incrementing the weak refcount is valid.

Note that it's currently possible to trigger this condition if the owner
calls BINDER_THREAD_EXIT while node->has_weak_ref is true. This causes
BC_INCREFS on binder_ref instances to fail when they should not.

Cc: stable@vger.kernel.org
Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Reported-by: Yu-Ting Tseng <yutingtseng@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8c99ceaa303bad8751571a337770df857e72d981..3915d8d2d896d1e3a861c336d900d7a4657a0104 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -851,17 +851,8 @@ static int binder_inc_node_nilocked(struct binder_node *node, int strong,
 	} else {
 		if (!internal)
 			node->local_weak_refs++;
-		if (!node->has_weak_ref && list_empty(&node->work.entry)) {
-			if (target_list == NULL) {
-				pr_err("invalid inc weak node for %d\n",
-					node->debug_id);
-				return -EINVAL;
-			}
-			/*
-			 * See comment above
-			 */
+		if (!node->has_weak_ref && target_list && list_empty(&node->work.entry))
 			binder_enqueue_work_ilocked(&node->work, target_list);
-		}
 	}
 	return 0;
 }

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251015-binder-weak-inc-f294e62d2ec6

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


