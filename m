Return-Path: <linux-kernel+bounces-763405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC0FB2142D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCAD3E3271
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EBF2E2848;
	Mon, 11 Aug 2025 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASaaVhFi"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AED2E266D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936328; cv=none; b=KIlstkGz9R2fdCU/pOFxOwodFN+9JnCqP+gNRtHM0bQp0TZaVprFUL9Td84GH9GHYlmGKfJBXeAgzkOntw4+/JUUpbCuhr+L5XdQzwWtFXlyhzwPvAPEJmIXZxOAhCiN/8jZiOqMy6KbAOvWA1xCrVczuQ/3HCOG+3vPhfvaVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936328; c=relaxed/simple;
	bh=DokD3vIRoHjif+5R31Uuaz7qu2/o6zaJk/QPZLREa1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HeVqA8k3jKy4/oddOAFxfPcurCA+sC/4fGB5v9pze98IRRGKndT5rmirY5GbrQQT0gU4DVktjbC5qOYZkogNjKSRANhFXD/HMK2fxODxVzWaeJn5QYbY03ideq20rfuItxcxWzPXuNRBcqaNXbzEXjN6M4wpsoQW0ClvVVpUmTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASaaVhFi; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-76bd041c431so4106274b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754936326; x=1755541126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFiR90ByEmrbZSIU4oPPtikQuOT0OadaiRvQ1pEaI/0=;
        b=ASaaVhFijX1EFy/h53ilCKHcByZX187ZlIjIg4iFfSErfrBsi14ghpJdlxzEa4p2J7
         qaJKcG3PScntT9+G1u7P1eqsbNRCGlRJ+y0y4kdHbX6f2fM3dLBhBqwi2P19Z9Z2Mc93
         BCUkR+9WV+Y3eXc0X46YEwSGGC4vBkarbbIPqn8uU1iMQCl7i4fFYrVykoWhwn94T7Pq
         jN1Id+J+UAoOi38PbhF7wLNQfk24M6ADG10rPOd3thrdX1lSnJA+EwFvln5eU88BrGc+
         Wtg6CDjlMawnae53IjoXWckrmdsalCei2tYFlB744jRYBFRgoPFyHPOvDPYc5TOACjMB
         mb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936326; x=1755541126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFiR90ByEmrbZSIU4oPPtikQuOT0OadaiRvQ1pEaI/0=;
        b=V7tofIRvqSdAHYdcOYNEr8FYt/iOsKqu97l8ZVD20p/YHbbGBUXYS9GTUea7A8xAsl
         xOhjjZKxoy6l6hTMHyCtGVyRRZSXYZwhUFg/Yu/kHdacfdG/RQUqAESgakD2TOrvsN/n
         XVltR6JGkpgHFgOspSlRuriNIWmqfYYKrszTznAuJcUx44nCMYILQRwpTLLxfpjE+tGm
         gIHUJ7Rl6LcVWKsgAtTYShbUknkmD9prwaVXHM2S566zxcHJsMW4sBB7VP//rHd7H3ar
         rdMHZF/FsanlXoQ0IPXN5/Do2Df8pOtSbDrZrNnNe5YGsULI3U/e3qnMQHphPDyepm4R
         ItqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6nCGHcRx1R3mceNTsY2nmhN4F2kMGgpXzgWrFgwHy3SZVSp15Axk9YUvJ1HeQYnAdyG3rS9WJbpXcpjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypvl7Tas1NYGTGz9s2jAMCmN3H7l84ZAenXyWGS5RtCBPXRlQq
	OApe/9vr7KVB8Ds0pG7m/5STXvJZx6gyQBnoTc3CW0oWm46jOqPRkcfzSaeo2SlPNLsEYQ==
X-Gm-Gg: ASbGncu9LJirGabDe4lOXKDcBItAUGhlKwrRZXWUAzDCOOxuAHxlUGZHI8sGCI+GUlS
	UKvs0ID5ZrjjypGW/rkwVKvuNcJyWJhdBXOJLmCN8JLTmZyUbztPetXI2ooVnDdNBydDZ0W/JVN
	Kz7Uhr+EOM5eZFlAOJAIg2jYl6/862nuKqdKrWInQnnb3Olti3Y25DE6K2xziqZooKleRcOu5uW
	bkSyCVFfAMwPGVx84nGbWTRAWlPH9Mi/iemQVokOfXEaqw0YJKGRX35O9Mm8/OkZHokM0uaNmUY
	ZSM/MnatUa1VUf54NCxJ/omTq43Ix5sjbgGIbksqBgz+7SY65pp1VbuaFnVinz35WkPPbXP35ez
	9gHRTF1bp4rVnWCxodG8SydbyLz8AtabcJNBWEA==
X-Google-Smtp-Source: AGHT+IHsSRuvLZp+IeWZ1rF4OqFgVzrZbtcAWXFfY1ktPgsrNPt0ldkJ1cSP50w3pBfymIwEqrLZtw==
X-Received: by 2002:a05:6a00:3c94:b0:76b:dbe2:40f4 with SMTP id d2e1a72fcca58-76e0df20b93mr710828b3a.16.1754936326180;
        Mon, 11 Aug 2025 11:18:46 -0700 (PDT)
Received: from archlinux.lan ([2406:da18:c0d:d265:8107:1fcd:5d57:ff7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8fa10sm27375134b3a.52.2025.08.11.11.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:18:45 -0700 (PDT)
From: Jialin Wang <wjl.linux@gmail.com>
To: 
Cc: Jialin Wang <wjl.linux@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/vmscan: remove redundant folio_test_swapbacked()
Date: Tue, 12 Aug 2025 02:18:39 +0800
Message-ID: <20250811181839.40336-1-wjl.linux@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When !folio_is_file_lru(folio) is false, it implies that
!folio_test_swapbacked(folio) must be true. Therefore, the additional
check for !folio_test_swapbacked(folio) is redundant and can be safely
removed.

This cleanup simplifies the code without changing any functionality.

Signed-off-by: Jialin Wang <wjl.linux@gmail.com>
---
 mm/vmscan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7de11524a936..9d4745ad5e23 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -985,8 +985,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
 	 * They could be mistakenly treated as file lru. So further anon
 	 * test is needed.
 	 */
-	if (!folio_is_file_lru(folio) ||
-	    (folio_test_anon(folio) && !folio_test_swapbacked(folio))) {
+	if (!folio_is_file_lru(folio) || folio_test_anon(folio)) {
 		*dirty = false;
 		*writeback = false;
 		return;
-- 
2.50.0


