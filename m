Return-Path: <linux-kernel+bounces-783647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E71EB3302A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 15:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55E91B2645D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 13:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E2E2DA779;
	Sun, 24 Aug 2025 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIKCOTSU"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6748C23A9BE;
	Sun, 24 Aug 2025 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756042707; cv=none; b=eRdbckxBSYzRTrudnTkeUc6yBl9yX5MrogLPsn162BBws4X8K+WmpI8JiFUt+sRNbQqezdEv4cQk05X6sA9LyAUA2Fqf8XNgdASnBab24OSa10RHXxDU6XOCuGj3Y/op2GQKpxpMgBBq8IZdZ3Y5Avjh80L51bom84oTrSjCboc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756042707; c=relaxed/simple;
	bh=s7X0pnbm3msXE4wLTcR0lElsT2tyRtlOMQhPbrtjDYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IhQU0bVIfBH97LguOImZT99yXdtyiVV6H1+mt38Ey/Ryyrm/f7E6eFuMtvXNajjxn6k55Zfn/MRpy+wViFWYKmVvpT1MTKlmVaWGXD1k8NpZwOrfz52jH62+8WMD3UI6hKu/qXu0O49WyL1jqMucdf8f83P+FmprL6Ml5V0Vm5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIKCOTSU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-246648f833aso8877325ad.3;
        Sun, 24 Aug 2025 06:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756042705; x=1756647505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=90MLzQuonsDG64dbtL+/stK1T9HCDY9n2Npjr4Lf2lI=;
        b=EIKCOTSUD586M7ApGG4X1qM1/oHf0aePwhPjUB1+b/tTHSC4YBqe2Po4ItnAb3NkpW
         FRZhZlmAyRrYmee7WMaGLtgE14C0jVDv7tIL9PriON/tfdM2AD6sTDlOwWRyJYH6ZLG9
         U7+e+4BUBGbJkIPIwnKQFsYI0hxxOwgcCqR00qvQXUqh5NKQsrnle8SFIvDOs7M+7WhS
         Qi311VXwmUyYiZn7Azvy9KI/Uhr+oODETEHLP69YsDwi59ywgH48k2X7njnLnNdmY+hm
         LM+Sr+gMFWUttW4Ktb5WV6DNmXnG9yDbRbFPQnO0pjhKcjhty28aBzs+9f8Vba0mhbbk
         qnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756042705; x=1756647505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90MLzQuonsDG64dbtL+/stK1T9HCDY9n2Npjr4Lf2lI=;
        b=o/fr1WosF5hg+nm9x/OyWk/AfB+MnKoX8LeRq7rP/DnSQVuX/01/Zkndu3egD/Xfji
         7/a1SSRC2SDR1osqk4KDsoX43UGe1c4jI5tnfF4hDM6LOtlSVmk4eOipjNVvUIdLfedx
         +jU+bhsKi1p/OJkonZgrit7y8Wl16HDrZhrykDSG52SXxAcTNr16vMUd48zT+G+BU5LJ
         2yytjLVZr/qRj181GZKYAmM7vzCFUFjrqOIbRijR1b468tV1uMrfv2i3IQ7KdXX7yqLH
         bWn5Yk+uzO69k4ElfYS9xL/PjGRISWBY5gzrKULx718dN/PmFraWDqUFiiBteomWuGGS
         4RZw==
X-Forwarded-Encrypted: i=1; AJvYcCUBoL79Q3qqQVclHXJm3mwDaKnkbri/I/YZHf28pmn6UvPn9vpx2OiLoqzZwx2dYdnNEcSJwphUcGU=@vger.kernel.org, AJvYcCVQ/sSkwWdZyevrHJ6ZsVelwAUhvsj+0NGt1f8Um9i0PTKJ/6AMksxxu4CrMJHfbL5vtVf1OuFlJ+D1XXuJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7OGFvNFcGPw0e/6ngBwYIzXkASKJevA1CmJj/mwEf8xfp5e+W
	DZcwhaCl/71rzmy68iPd8oIJyPp178oQnDjxHL0zUatE6Tteq6NrAq6F
X-Gm-Gg: ASbGnctPq7lU+LFWhYPXc/6dAHQG1oTXtWBtND5PhTRDC6fpKMOZkrqrMRauBTXqJC8
	OazawOtUpgRpQiFg5YRRPGUrtZ1svQHXu7CxJo203fu2QU9WsizWJ3DILVYNY0ulUipgF6Wb9hw
	ePb3R5YWoynE0SdJ8YzNR/6E14boF5KeeOK42Fg7pCQFbB6Q7zkitoESET95qtwkSHO044vutPR
	7Xkocen6ev4R08aFQafRCcXRBxkrNTK73HDQN3P2jx1145M4k3v0uCN+LuLl411mKTYcKkEeV53
	qtXtjz9NMhOFdDmyCsDdSBeHcR27aLUxmA2ydkBaQqwwKuh7M+sDcZ/qz02oaLFIk5GDeh8KhYk
	FStYhdYJ8H2eLonBZyiJM5OBk1t4=
X-Google-Smtp-Source: AGHT+IF8IovTN96omGp3/ppnb3zr7HkMglLNXw7Fd633EEr6qn/prmg6jI8MICtzZ0GIepxE4BJk0A==
X-Received: by 2002:a17:903:46ce:b0:246:a120:8da5 with SMTP id d9443c01a7336-246a120913bmr46300935ad.54.1756042705534;
        Sun, 24 Aug 2025 06:38:25 -0700 (PDT)
Received: from pc.. ([202.126.91.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b0f9bsm43634545ad.37.2025.08.24.06.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 06:38:25 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs: scheduler: completion: Document
 complete_on_current_cpu()
Date: Sun, 24 Aug 2025 21:38:10 +0800
Message-ID: <20250824-complete_on_current_cpu_doc-v2-1-fd13debcb020@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250702-complete_on_current_cpu_doc-94dfc72a39f8
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756039790; l=1650;
 i=javier.carrasco.cruz@gmail.com; s=20250209; h=from:subject:message-id;
 bh=syDoUTo2dJyexWznUEBNddmCWTILFt31Fdy9Xjp84rQ=;
 b=bYi6PGEqVyK7U7QnKH8BM8SoUVTyguxad06l8UwFsHcL/YfAm6rNP+egn+aW+urJsqnzCN4L3
 6ULTI7EeZyfCRNSsCPEp0o84MTBajRoCulNmJPy8v+iv+Pfdz4oBLNr
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=/1fPZTF8kAIBZPO3D8IhqidB0sgYzPDkljBZXsXJZM8=
Content-Transfer-Encoding: quoted-printable

Commit 6f63904c8f3e ("sched: add a few helpers to wake up tasks on the=0D
current cpu") introduced this new function to the completion API that=0D
has not been documented yet.=0D
=0D
Document complete_on_current_cpu() explaining what it does and when its=0D
usage is justified.=0D
=0D
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>=0D
=0D
---=0D
Changes in v2:=0D
- Rebase onto v6.17-rc1=0D
- Fix patch formatting (drop --- before the Signed-off-by tag).=0D
- Link to v1: https://lore.kernel.org/r/20250703-complete_on_current_cpu_do=
c-v1-1-262dc859b38a@gmail.com=0D
---=0D
 Documentation/scheduler/completion.rst | 4 ++++=0D
 1 file changed, 4 insertions(+)=0D
=0D
diff --git a/Documentation/scheduler/completion.rst b/Documentation/schedul=
er/completion.rst=0D
index adf0c0a56d02..db9c131f0b62 100644=0D
--- a/Documentation/scheduler/completion.rst=0D
+++ b/Documentation/scheduler/completion.rst=0D
@@ -272,6 +272,10 @@ Signaling completion from IRQ context is fine as it wi=
ll appropriately=0D
 lock with spin_lock_irqsave()/spin_unlock_irqrestore() and it will never=0D
 sleep.=0D
 =0D
+Use complete_on_current_cpu() to wake up the task on the current CPU.=0D
+It makes use of the WF_CURRENT_CPU flag to move the task to be woken up=0D
+to the current CPU, achieving faster context switches. To use this variant=
,=0D
+the context switch speed must be relevant and the optimization justified.=
=0D
 =0D
 try_wait_for_completion()/completion_done():=0D
 --------------------------------------------=0D
=0D
---=0D
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585=0D
change-id: 20250702-complete_on_current_cpu_doc-94dfc72a39f8=0D
=0D
Best regards,=0D
--  =0D
Javier Carrasco <javier.carrasco.cruz@gmail.com>=0D
=0D

