Return-Path: <linux-kernel+bounces-893779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F899C4858B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584E53A9CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A042C0264;
	Mon, 10 Nov 2025 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="qiuyIjfV"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396BF2BDC2C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795795; cv=none; b=NibXlHStrnt/bU22xmBTqXxK0D+r9RZ/jcbI3glhtXaOol82zH1lwFCpf40b3QkLMgLpAVpfp/KNka9Dnpm1V3vYEjRWCjpyGEqCnAGLAA+vvyWLAMhvAWeVLc8gXBlBWSCcaMUPnjWXTdcuz3d89rOun2wYetAFqL/GJmkWI2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795795; c=relaxed/simple;
	bh=yivdRpurit05WrU2cZrJ+Ef2/cgeGJsEFkDdt6uHfcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=joAtqaHAz3kI7s3K6cNz/vgUt8Yx8f/GeJHPjBh7RBWPX/L0AbnwJTS+xf56T5OfvwKW3tXXSjpq9RkUwKVunfIHJcRUTuAn6hQJ5C+keUI1PFNCrJml54gsbCw6ZEaBpkEtnIYbrux6KtdgaYKYtUWirsG8deZw2uSIWftKjHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=qiuyIjfV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297dc3e299bso22886725ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1762795792; x=1763400592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5OL3Y3kmUNvDH8rRKkSC7um10A74MfKVea7Y92HY7Fo=;
        b=qiuyIjfVaXwGW78FQF6Fb5PzPCf3XbUBqfkb3aHZUrZdF4zi3orXp9MEEhHcDOojzn
         XZrP3OUZDps9VI/UEDC5Z1cYeN7tG0h4j69FCyT+guQ2wXXLVMnJpTKjNtF4wcFPtcsn
         7+TtMxfxzM04EeN6WYdyvQTBPX/+RnwAQ15Lyn9sUveauekvP/CfllHuDeQontB0curl
         4btUTe+jLYCH5r2+lS6J0YNyJcZAl2bwXbNPn5L3Do9MvAKPkcTjoc+fbQZrszqeoY5f
         RHUBAPuIt7DrrnIjKxMrpMh3V5VW10bT/oXZAAltWHrlmM9s2pF/AiRxceppC/xkHvRl
         NGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762795792; x=1763400592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OL3Y3kmUNvDH8rRKkSC7um10A74MfKVea7Y92HY7Fo=;
        b=uPHjhrsj2bsVp4yCb1z6zNwM8iV7uEa4JQfsDlFXj2ItV+X+o7iqGOp2dEpVcmp7fd
         nA19lzwHnW3PGqXvI02Rw8K6dvk1X1NVYfxrivYjeS0pOBoavfwkenjqL3MQN6mPq3tv
         LlPzowxqUVrsjRl/0Q8t5EIuq2BlslLmm4WXPmDAf8rhFWU8VL4fqVIeaWurOOwzVbA3
         7F4qm/Le5P1QzPP1GW1JV4lzgmqbkUDVSqAHHtYzETmtL7Odb1bdf5ZiGjawx6RdTaKb
         P5QDc35bAtEvCBQUyfR4rX9hHD9thTS09ncM5FxkvSn1FK9JlPWjbHgfpmzQlNRHAR9c
         ODZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWorvdBd0paXCMOmyypQlLfy58xnmU2+FYTpOfMofe2g4YPQRg4nZWBZgTVw5nZr3FNLDx2+vlVbXyfLI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2rPtOUrW/g2H4/TNzvFlkCR7QUlrTGIHPXFVpM8zE7DgIJ+T
	zg+X67Z+mfCtou+W+MA3iMV0DD5VMum4AqrHYjHpo9v1A+HdsA8LOEix4HH7fQ8BjTU6IGZCVBg
	Q2H3Tocg=
X-Gm-Gg: ASbGncsW+AMWZONbWUBQICsJshtMZhKzUEcKD0TmjI1yjeZ3sZMxq1MEXGkPFxEtw33
	9UuqboS1KHQ0rEb6pys5h/0wlMihB8tCC2BdOuqEUBww3Gitq2hiRZjEbGFa1RXhnPk//VXK3Ql
	R7E1pgkBBVcSsmEilVW5XMxEi1xOevqFWn4NmqBVFPAAhuITQPQR+FSxltq6knZje3sDxz4yrAu
	Fs4XfI96Skjfd3n9/k5nNLnm3lhYgDgnu61vf/x1YUee5crEU8+Xy5BnNEHcvz+3iicLJwdmIZb
	Tprik4SA4IE1/IXdtQb43gffy5aLrliHr1Kc8raMzeIXoc8mmCbI/Ms4fY5hHdb8oZDOrSHBbI5
	RR7KTJPClSpnrwOtwOU1v1DuPKxDhfMASijsvn/dSX7PiV2uHK2Llp166VPHsjZDMflbQVO88zW
	QeB4CZnN1e8u34ag==
X-Google-Smtp-Source: AGHT+IHBptCxQ+7XGOLeOR1X/58AtZt0orE0We0oyv3It40DgetpuVdWDUw0jLaNMWE6eOOOHMBwBg==
X-Received: by 2002:a17:902:cf42:b0:295:8da4:6404 with SMTP id d9443c01a7336-297e56f9154mr118234675ad.40.1762795792464;
        Mon, 10 Nov 2025 09:29:52 -0800 (PST)
Received: from localhost.localdomain ([49.37.219.248])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29650c5eb35sm152495085ad.38.2025.11.10.09.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 09:29:51 -0800 (PST)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: jikos@kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: uclogic: Fix potential memory leak in error path
Date: Mon, 10 Nov 2025 22:59:41 +0530
Message-ID: <20251110172943.99887-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In uclogic_params_ugee_v2_init_event_hooks(), the memory allocated for
event_hook is not freed in the next error path. Fix that by freeing it.

Fixes: a251d6576d2a ("HID: uclogic: Handle wireless device reconnection")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Found using static analysis.

 drivers/hid/hid-uclogic-params.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 59ea71299438..e28176d9d9c9 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1372,8 +1372,10 @@ static int uclogic_params_ugee_v2_init_event_hooks(struct hid_device *hdev,
 	event_hook->hdev = hdev;
 	event_hook->size = ARRAY_SIZE(reconnect_event);
 	event_hook->event = kmemdup(reconnect_event, event_hook->size, GFP_KERNEL);
-	if (!event_hook->event)
+	if (!event_hook->event) {
+		kfree(event_hook);
 		return -ENOMEM;
+	}
 
 	list_add_tail(&event_hook->list, &p->event_hooks->list);
 
-- 
2.43.0


