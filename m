Return-Path: <linux-kernel+bounces-754435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61B4B19446
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 16:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 635807AB179
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 14:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD9D25D55D;
	Sun,  3 Aug 2025 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAscbk9C"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3AB156677
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754232689; cv=none; b=UiDZhFXkdJn6P5BA+1Hv2oFWsYh9Fnkv5r7HL1YRqMqs/V/1j3PhQVrkwra4hF/p4guugDfx0pDNMwdCV5tw9a1RIu+4VZ0MLSQrTxbIowUPdE5Rh1MfnqLBiQfw1L0/8Vd3ZNAHzsJrMyWjncH6FQe4uXytTOYVRO5JcArlA70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754232689; c=relaxed/simple;
	bh=cEjJqrjkdu85D7hMcySd2okllKQd6Lk8T2xMh2fR6aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dmQPE57A15HluIog6Y5zkyCsMqlhPAdli5eYVCVeXAUDCN0O5PR5t18fZBgKZVQtZQMkMW7bcXqZQER1HCPG4CnkpJzjRpwO3oMewxOKhmGZo9JktNwCGhgQKbyzTx3MhC+4sr9r9SZ/hVyF+XhOOLnSLnCQZzwLJsqGziBX+Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAscbk9C; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2400f746440so27441975ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 07:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754232687; x=1754837487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOXzwUR1xN6C56FBDM0YfzjbrTfVtKGUbzZ4GDTfB5A=;
        b=UAscbk9CuuwQ8mbI0h1jWR8GbEQCHd7N208ZWlBxCjUOyYe93fdw7oa9vvrY6364zZ
         NL4IQ4BAJRgl3cZW5PY8kPlPSXKJYS+MNtsR0pG0vLh4PIi+MXO2uCHlkWQWlr9cnLYp
         i75bL14x2Y/mfPMekXebscPxsE1rHNDIvmIXao4TkGSO26jxdhoeXtXbps7o2jhOtM4z
         Hd9IvkFGDCev6Jp1f1xbhibunIPk/OVpr4uBHQWLEIw/BFr8AKItLznLdg1mpP1rxTYw
         0nbc33VX3EMDlrQHv18UnH+TxDLNHG5Eu0vusida84LJR/q2i3qpxEc+jbc1RtqWxL+J
         yhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754232687; x=1754837487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOXzwUR1xN6C56FBDM0YfzjbrTfVtKGUbzZ4GDTfB5A=;
        b=DRvIyZfpp/FjX2xn4iAs/VC+L4QiJ3jVuQDQrcv6zYq66rBw6pqqLkRrqyzEE+R2Eu
         zVHVZRKO5GoVn0xrffNHhyopW1fermzJPybVWwNnmbP6Np6TyB952zsXUcHUXdFsENgv
         1ZcKQN1QcTK23KndypKQswYTvFEJoNWwCJ0MI9NaURyaETOq0VwjRh2OjxCLyLNoWCJi
         +MdNhdm9/CoNlcyuN3EyjkdHvyEPpgWGmUEdDDCBp5BEa3dl/3rq2ImfDX7qlcUhL36e
         UnQEnSZaz6f7gSfqnEfw1Y8clMpQVjhI/xVFHb4N7sI9i/2D/nHSg7Bt1I0FWv0ySbrV
         ocqg==
X-Gm-Message-State: AOJu0YxssIbmiCEhYgg6Top6rHUaw9U7BT+P7+dgi1Sx58PCbyCOfCIg
	jw35lemzUXeJe2POCfiYnIUDXklEiEnVyBEVcbtavwlbzL6XiwnGqVe+EpY3FFY=
X-Gm-Gg: ASbGncspvQbkrTI6B3pDZpRswKjEwt4mYzvEy39aa7qKehIrG+rRL0s8boCfLGDgJ6G
	fQMJljoR7+DJx8a/FvjLBp1Ut7B5RFahPdxvoMRoDDTYk/2Wz+XX0UtMtNbvGlvuXvjqwscT9IR
	Yi9hqLlLGW5vBimO9f5jOlQfHK5jUCFKj4H/333OxmbJM2iRRtY5oXshzlbfn7S98egFAoxkRkk
	oSVE0Z85/VYQGJ7AFO3Ixa+4g3c8MPQljFXcMAOe+EqDTVu9nTq3uZ7tyB0iLExsE3+QU18ynrw
	jF/litc/wdN8IIvZbwmkKxQeXLuHNkq8iYWJ1iC0HHlbYZhvCGn+yZx3Ovh+BmdS0wszCm/aCD1
	YA9XCpR57snkqsH5cXlLlbVwUq49c
X-Google-Smtp-Source: AGHT+IG0zTNBFJPS2bISA05GvsNBjiL+BqDiHx7jQBVa8kpxB4GvQeiGW/TfbOx1CtRAZuUjeGF+5w==
X-Received: by 2002:a17:903:174e:b0:234:d778:13fa with SMTP id d9443c01a7336-24246ff19bemr85635255ad.26.1754232686891;
        Sun, 03 Aug 2025 07:51:26 -0700 (PDT)
Received: from VSPRIME.. ([106.220.185.138])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8977896sm88475825ad.79.2025.08.03.07.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 07:51:26 -0700 (PDT)
From: vsshingne <vaibhavshingne66@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: vsshingne <vaibhavshingne66@gmail.com>
Subject: [PATCH] Changes in Makefile to change patch version
Date: Sun,  3 Aug 2025 20:21:11 +0530
Message-ID: <20250803145113.7149-1-vaibhavshingne66@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c09766beb7ef..06eb670c6c36 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 VERSION = 6
 PATCHLEVEL = 16
 SUBLEVEL = 0
-EXTRAVERSION = -rc6
+EXTRAVERSION = -vsprime
 NAME = Baby Opossum Posse
 
 # *DOCUMENTATION*
-- 
2.48.1


