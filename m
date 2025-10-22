Return-Path: <linux-kernel+bounces-865538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D153BFD6F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EFD8501981
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7E32C11F8;
	Wed, 22 Oct 2025 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aprilg.moe header.i=@aprilg.moe header.b="OPs3ptV9"
Received: from a4i517.smtp2go.com (a4i517.smtp2go.com [158.120.82.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307D7296BC8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.82.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151141; cv=none; b=SfF/Jek12axfsYJKerPmTdhcONo8CXXF7NJ7mo1teDv3tJMJOqcQDooYQ3FUYs6W1G1yWqF+Dz+j20SNrIthjGxD4I0eS8Qt7HdYdwQHpPh2ygiJlxAYe8dw9U6oza38omMsk5uRUVSzePAW5wr2GL7RXVjitBF4r7TwwdeZhcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151141; c=relaxed/simple;
	bh=DPBA1cEnteThqlbYCaIQpR6lbEIC8T3GqqRLJOWPZb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qFiQc78R9PBWPY2XoRp473hvqfO+RjCgQx+cSPpTeF0eWe25ft31DWUMmIImGpPH9ugG0jSKfEtCkuVgkqctcyNnE/B9kpErNz545Hnq0hfSYyKD91Qm/6muinY9ApPC/mmwKrXv4GCy/lSEqw2DGoc90qww2yhOaCiQ1z3nbcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aprilg.moe; spf=pass smtp.mailfrom=em810805.aprilg.moe; dkim=pass (2048-bit key) header.d=aprilg.moe header.i=@aprilg.moe header.b=OPs3ptV9; arc=none smtp.client-ip=158.120.82.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aprilg.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em810805.aprilg.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aprilg.moe;
 i=@aprilg.moe; q=dns/txt; s=s810805; t=1761151137; h=from : subject :
 to : message-id : date;
 bh=/irYkdYYv9XO+lHWk+huvIBG8k7L/412MUvHRa00Fa0=;
 b=OPs3ptV9//Esq/IoWyy3XqBX1Zae1y+LhkC7nhdqFjrnxQy0Wcb+TeC+l5+07FBt+HCtv
 Xkyw7mBWwJy763cT8HSzU9BzLHiEA6L4Pn4NUspi4E7E6Jb1ckkDhamdqqsFV5rclhlQkSK
 BwVx/A7Nl9heMn5yH3zf7QMBQypdEdL3JftiToLSR4SSg5QF49Z0V3QoNLLMInWJWo1H2sY
 jmJWhrUgd3KG1evBEzHZnXBkKUU8xyjqaxxp9AK2y1aBUTzzh5FhKVg+fWOnGwkPX91M3B7
 5kfrCYGrGMjbg43kaG/c5TTFUgscXlcLRL+UrE0NbvyzIa00t95pdyRmprZA==
Received: from [10.178.243.157] (helo=aprilg.moe)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <april@aprilg.moe>)
	id 1vBbrR-FnQW0hPwFuZ-Jkxq;
	Wed, 22 Oct 2025 16:38:53 +0000
Received: from AprilGrimoire-Mechrevo (unknown [23.249.17.191])
	by aprilg.moe (Postfix) with ESMTPSA id 66573662F0;
	Wed, 22 Oct 2025 12:38:50 -0400 (EDT)
From: April Grimoire <april@aprilg.moe>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jikos@kernel.org,
	April Grimoire <april@aprilg.moe>
Subject: [PATCH] HID: apple: Add SONiX AK870 PRO to non_apple_keyboards quirk list
Date: Thu, 23 Oct 2025 00:37:26 +0800
Message-ID: <20251022163726.19667-1-april@aprilg.moe>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 810805m:810805a5lOAc2:810805scwCczSjBE
X-smtpcorp-track: dagOrnmCda1x.Rf96Vc5mx_nY.0MNA4w13Ktb

SONiX AK870 PRO keyboard pretends to be an apple keyboard by VID:PID,
rendering function keys not treated properly. Despite being a
SONiX USB DEVICE, it uses a different name, so adding it to the list.

Signed-off-by: April Grimoire <april@aprilg.moe>
---
 drivers/hid/hid-apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 61404d7a4..57da4f86a 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -355,6 +355,7 @@ static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
 
 static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
 	{ "SONiX USB DEVICE" },
+	{ "SONiX AK870 PRO" },
 	{ "Keychron" },
 	{ "AONE" },
 	{ "GANSS" },
-- 
2.51.0


