Return-Path: <linux-kernel+bounces-804220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CC8B46D15
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1A6189822E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5123F2ED15A;
	Sat,  6 Sep 2025 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRTwZDmW"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F922EC561
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757163298; cv=none; b=QAICfnyCNeFbnnWrD5kI2wfU+Q0irAhhEHcV2guhk1x7owfEHq9dIIZhp/7Q9IKdtb9MoIFNejRc5u4aqlqP4wA35pUMLzpVfIMrd5BuEiUs+8fpHI1WAJhRIOfdV/2eoP6VhJgrAnXVn6Pwr8Apy8tJ4AZn2rZHNGoIoUHV7ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757163298; c=relaxed/simple;
	bh=aVwVRRwKFyUNFGgvpjosr9jg2Uh5JoehBnFt4mVeH8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QA9XcDHVaJF7E2dwIz8UBTCnJMC3ivWb6awOGyFDXgt50svdH73uUNAKOPTWWD6KnlBeI1rRoCaSxfTmG8pV4+thpY12chAJplDbYBlZ7a+BEEHTIhPJlZltFVUHWTMJ6DH6VXG0Ei6LU7WXZfsmrmkVMbdz4xsat5FFOjsNJqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRTwZDmW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b043a33b060so479233266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 05:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757163295; x=1757768095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UE2E1w8rpI/Rz1G+l/mrlTW7yKFl3iA8f0ZeFg6IUiY=;
        b=BRTwZDmWPVCKBGNfg1gg2hPNSCEOdXfjLPwzir/RTYm7qL9N7mbhTatbCbebkVkBcA
         ko3s8nKX2yIpFQx2m3QaFQnHihDJcxvuakHkNw5r83rwow2PYuezfVj6SeHV0LH8q8HT
         CLA6S87pV2O9O9C9a1FAsLYmBoqRuy6tOtNWLAUhCNiy1wpNWCldQJVl7gUTrov4mlsH
         c7In/7md9dxfGELbWPFxLlTn/4WRBkeRY1Iwd7oJTnslhCr9VBgIleDSix2CLWlfxRHk
         IHgFkEgVbbrItKTQFoohqJ55eJ/o48XCLazuvvzxCs9sevS0epio64Af6/KxfZE1cBNy
         IhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757163295; x=1757768095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UE2E1w8rpI/Rz1G+l/mrlTW7yKFl3iA8f0ZeFg6IUiY=;
        b=mnHoaItBaY31//pVqxiHfG4C+ummkIYL9dWtFCGDHD7y4dCZB+oNKZwWh8qvBwwJ4H
         QkPkYuKSn1/I0WfVoAsdRoaslW/rfAfeedJ2/xV/MhBY5PQJuUCQhyeKM0Wc5MUQLGEA
         6veJIyy1svXtU2byitJF2DDNbEW2+GxqGrzumY0OEWlrwTjfne+e7Hj+El+pmowBG4PN
         XGXMKOhu8j91nCNbft2EB+IfQuPVA4mx3ox7vuoV5BJw9DzuoqUsMFuJ8d/UI8PiXk49
         aFaVUxMYZ6JVj2kA5qwu6/wXTf3pfR9/65gDL/u0PMVAXH82Hdn4CIZiylfVz40NlbnK
         Z3Hg==
X-Forwarded-Encrypted: i=1; AJvYcCU8UieUFtUXUZxWbvEtRhjy7if2XsR/FN7vb4CToJ826lSPYaBiWHJRbR5Yjq/8xk8mzdDVXXFzhc8Bcg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMJt5nJZQngSAvE5GiuqklaKUIq5YeC1HJTHXygIK9PijH46LF
	r0Kb8Db2dI9oERHgAVqWbbHn48QO4Pw7TTDtyeu5xkyx3w6DeQcf96Dh
X-Gm-Gg: ASbGncuZL2PXDzXpVGCr3jzeLyM1Qi+nnwbhoSVhD3PUARgyxnL0JerR952T77rUhlL
	gtN+9OOTJT3vP1c0MYwUlKEbpMoY/YOJqfRCqPDyJMp+m75CtiUGYFnelDjHqI7Nw7oM3hxcnYr
	pNoaK/37JSqJga9srYuYr6SEIatxgkfu+e7YFF6CS9uBkcyfFPVSI1+mRP334PHzRF4/u+zDOBG
	fX2n5y1SbprFmKG+kNUSDx6r22hodl2odbpNuixxShUrmFQDmzeMPhm0e/sL1sHrKTCRBFJNdcp
	p4KJEWLO+hRjy/vsduAmObkrYnnTjftQWqv3UgK7IQEcDbUZsD6yDUPytLn5XqrrLpgxQVU0y2d
	rX8ikjjSl0XARNRnyGzAnfsQouEiWXfSwpZHl0CLvDbZ/ysZSA7Oo3lmbSdvL8erMuQFlsVvzwl
	jI/KZilkQEwhYhINC8C2+HfoLqfDJMeodyIYlQ6ewDhO4Vbzv7j5Enl04+mX75
X-Google-Smtp-Source: AGHT+IH+7BOI358ylmKp8atw8bsdyRj/71mHyL9dUszzoXcWqukq4MMj2v7GgMWLJqT+/pR3VfCtNQ==
X-Received: by 2002:a17:907:2d1f:b0:b04:3fe2:23c4 with SMTP id a640c23a62f3a-b04b1437f92mr198976866b.19.1757163295028;
        Sat, 06 Sep 2025 05:54:55 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.vodafonedsl.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046b783722sm838883666b.97.2025.09.06.05.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 05:54:54 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
To: alessio.attilio.dev@gmail.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	teigland@redhat.com
Subject: [PATCH] fix: delete del_proc_lock
Date: Sat,  6 Sep 2025 14:54:51 +0200
Message-ID: <20250906125451.19206-1-alessio.attilio.dev@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250905160552.496879-1-alessio.attilio.dev@gmail.com>
References: <20250905160552.496879-1-alessio.attilio.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The del_proc_lock function was originally retained for testing purposes during development of the Distributed Lock Manager (DLM).
With testing now complete and the function no longer serving a runtime role, it is safe to remove.

Reason for Removal: The function is unused in production code and was only kept temporarily for debugging and validation.
Its presence is no longer necessary and may cause confusion or clutter.

Impact: This change simplifies the codebase and improves maintainability without affecting functionality or stability.

Signed-off-by: Alessio Attilio <alessio.attilio.dev@gmail.com>
---
 fs/dlm/lock.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 9d74b78d3544..9170b5c09823 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -6146,35 +6146,9 @@ static int unlock_proc_lock(struct dlm_ls *ls, struct dlm_lkb *lkb)
 	return error;
 }
 
-/* We have to release clear_proc_locks mutex before calling unlock_proc_lock()
-   (which does lock_rsb) due to deadlock with receiving a message that does
-   lock_rsb followed by dlm_user_add_cb() */
-
-static struct dlm_lkb *del_proc_lock(struct dlm_ls *ls,
-				     struct dlm_user_proc *proc)
+static void clean_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
 {
-	struct dlm_lkb *lkb = NULL;
-
-	spin_lock_bh(&ls->ls_clear_proc_locks);
-	if (list_empty(&proc->locks))
-		goto out;
-
-	lkb = list_entry(proc->locks.next, struct dlm_lkb, lkb_ownqueue);
-	list_del_init(&lkb->lkb_ownqueue);
-
-	if (lkb->lkb_exflags & DLM_LKF_PERSISTENT)
-		set_bit(DLM_DFL_ORPHAN_BIT, &lkb->lkb_dflags);
-	else
-		set_bit(DLM_IFL_DEAD_BIT, &lkb->lkb_iflags);
- out:
-	spin_unlock_bh(&ls->ls_clear_proc_locks);
-	return lkb;
-}
-
-void dlm_clear_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
-{
-	struct dlm_callback *cb, *cb_safe;
-	struct dlm_lkb *lkb, *safe;
+	struct dlm_lkb *lkb;
 
 	dlm_lock_recovery(ls);
 
-- 
2.48.1


