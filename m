Return-Path: <linux-kernel+bounces-833204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4781DBA167E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14511C026E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652C0321421;
	Thu, 25 Sep 2025 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1XZ+xQH"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E946321264
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833120; cv=none; b=MQhpANmWHoMuD2nWf8fW5weI80v3qDCweg4tyK2b5e/yRF/xpQZjJmq/X/oRyR2um5i9ai2ImSiD91Adn2QJ5b0aQR7bslQOKBcMCsVzmUzaEcPLvtWjmYuVk2KODWydTYq5Xo5s9NE2dhS9U2F6tI0cq3224enm9zQajFG8FBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833120; c=relaxed/simple;
	bh=Ru0U+UR4TDnU4YEoC4bgh7/N8KX36OuOCEfHwKRdWLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rEE4PpL98eGOFc+w24KDkQ0q5KYTUgT/MlmLPF5tJNig6qNa/dhm/hjzlpiwUfrt9mZ+BzfmXjGDBrC9yH0LJ/LvHRzehU1SkxbeWTD538mS8yFWXapwYBmDgoCjqNIiB0sw7C0H2RNPal4nGi70XnizkPYieBvuIiMQy/YUyQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1XZ+xQH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f2e621ef8so1924084b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758833118; x=1759437918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3eDhSQL/LKEOp5/PaHTtO2MouZaE3+HdZOo9nr4tRw8=;
        b=A1XZ+xQHdxJBef1PoAnWGxFrbUQn0d7bpnBx8nQ9EoGcG4AvVPZBheFTHlV/BG8Yal
         bU15BYAQKUqkM2ww2GWfXF3QrXMh1l47yImEzghZBB7qoBfEW8O13LrAgoHKEdb3Ict3
         Gj8PqM2ATXntQPp1nzARIjo6iHO2vX+hnXvIhDw39gVYPJbZg76gUgJdnQW40Zi7Kd7S
         MxWfT2OO6ki//xxicMX4e9zT3TXH8VTtrziUkJsAIiJ4VsNIaB1OeMT+vx9do8moxFij
         6cWUygD/zNqEho5rj9xcfruudU0PtQmeDzPhhu14UJgwoHHsln+CME2bhPTLBgexwoxh
         12sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833118; x=1759437918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3eDhSQL/LKEOp5/PaHTtO2MouZaE3+HdZOo9nr4tRw8=;
        b=gA2PGK0B1NAL5B4m3k6D6l97Ilx2LQKdQCDOteLaG1UxWjCWNw7JuuYBGuA6F7m1c+
         UK8GGup6/JThMoDqAKl+ks4+ibUEKR9nox8K0RlmP/7ulGr3CMglRCBa2d3gfuDqnpfV
         MfjxRzdvlHRFNgaYqid+X9RZSQUeFNu8Xbdme+SsEPMA2hkDQET7wnxbVQYnUPPafdID
         o2Owg7ZOi1w3zIe8PUl+QzzPb8F8NtRQ7SQxt9HT/Qn+lzK0IYE2E+zhKI3p822OYg3A
         xFFANAMjSEHl/IC+ZNK0t1pcLtVgHerwA/xJ8TGqrCW8rBXmqUxW3BPRJGYIcQt78d3K
         KaLA==
X-Forwarded-Encrypted: i=1; AJvYcCVRlImQA2enYPbTv+1DWEz4I70O2Pu9Okc1WMw8VWcxqMMk9ibzh7fhIi4rVwyx16wyitYIayeJ7GQ1ALs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoa0QObVntwj2m3TmlM06SZdgGMBUA2n0CuFHzPMx0vC0YofwP
	mPMWbCdw29k3qJFXTKviE/ag1cnA8rR6SqUwg/y4h5Z8VELUSekEuVBj
X-Gm-Gg: ASbGncvNXkuBbS+le4r6NyWkRpFp6Bf7GnixQW2tzpNpzccy+8zQYPAG+tE1GPTGjzG
	WMZOVIheU6r36jPEPXTEh4oEeH+ylEOagQu2kyDaBZYXXfbKWFyH+qVk7+acRXcCW3pDH/c+GSr
	ja9zhjCAG660WwDfBlfMRuei+Bis4qN7eTZKl7l1/N2HyErwjBW4eYal0LyZiwXMDeBajmZpEPJ
	ymKJ/jJoIclZ5NJkwpkqH0SRdkidh3gZz54P+5UFQk7gBoRZN82peHGamY7by92/MM2TiTFZDNR
	rhcJOD0Kettn5Zmkjr+8h2t8u8K4b1bBh7jM2KITpyse2UMv9zcHIUUHmyOVY/XtG/U6NlZb3LN
	L3MKpe4fuMhZylKtjVFB+keXB4c2V8ESWWKmNhtQ=
X-Google-Smtp-Source: AGHT+IHAMz5CMMWeR4tII30EjfIdX2VnbTPNJkIYi+47i3rAuGHIXnYdncaPKHzzQmFkMUxBtAQtoQ==
X-Received: by 2002:a05:6a20:7348:b0:262:52de:c576 with SMTP id adf61e73a8af0-2e7d3db5fcdmr6163922637.29.1758833118401;
        Thu, 25 Sep 2025 13:45:18 -0700 (PDT)
Received: from cortexauth ([2401:4900:889b:7045:558:5033:2b7a:fd84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239d99dsm2675456b3a.21.2025.09.25.13.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:45:17 -0700 (PDT)
From: Deepak Sharma <deepak.sharma.472935@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pwn9uin@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com,
	Deepak Sharma <deepak.sharma.472935@gmail.com>,
	syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Subject: [PATCH net v2] atm: Fix the cleanup on alloc_mpc failure in atm_mpoa_mpoad_attach
Date: Fri, 26 Sep 2025 02:12:51 +0530
Message-ID: <20250925204251.232473-1-deepak.sharma.472935@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a warning at `add_timer`, which is called from the
`atm_mpoa_mpoad_attach` function

The reason for warning is that in the first call to the ioctl, if
there is no MPOA client created yet (mpcs is the linked list for
these MPOA clients) we do a `mpc_timer_refresh` to arm the timer.
Later on, if the `alloc_mpc` fails (which on success will also
initialize mpcs if it's first MPOA client created) and we didn't
have any MPOA client yet, we return without the timer de-armed

If the same ioctl is called again, since we don't have any MPOA
clients yet we again arm the timer, which might already be left
armed by the previous call to this ioctl in which `alloc_mpc` failed

Hence, de-arm the timer in the event that `alloc_mpc` fails and we
don't have any other MPOA client (that is, `mpcs` is NULL)

Do a `timer_delete_sync` instead of `timer_delete`, since the timer
callback can arm it back again

This does not need to be done at the early return in case of
`mpc->mpoad_vcc`, or a control channel to MPOAD already exists.
The timer should remain there to periodically process caches

Reported-by: syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=07b635b9c111c566af8b
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
---
v2:
 - Improved commit message
 - Fix the faulty condition check to disarm the timer
 - Use `timer_delete_sync` instead to avoid re-arming of timer

v1:
 - Disarm the timer using `timer_delete` in case `alloc_mpc`
   fails`

 net/atm/mpc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index f6b447bba329..4f67ad1d6bef 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -804,7 +804,7 @@ static int atm_mpoa_mpoad_attach(struct atm_vcc *vcc, int arg)
 		/* This lets us now how our LECs are doing */
 		err = register_netdevice_notifier(&mpoa_notifier);
 		if (err < 0) {
-			timer_delete(&mpc_timer);
+			timer_delete_sync(&mpc_timer);
 			return err;
 		}
 	}
@@ -813,8 +813,10 @@ static int atm_mpoa_mpoad_attach(struct atm_vcc *vcc, int arg)
 	if (mpc == NULL) {
 		dprintk("allocating new mpc for itf %d\n", arg);
 		mpc = alloc_mpc();
-		if (mpc == NULL)
+		if (!mpcs) {
+			timer_delete_sync(&mpc_timer);
 			return -ENOMEM;
+		}
 		mpc->dev_num = arg;
 		mpc->dev = find_lec_by_itfnum(arg);
 					/* NULL if there was no lec */
-- 
2.51.0


