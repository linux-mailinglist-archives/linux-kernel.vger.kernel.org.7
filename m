Return-Path: <linux-kernel+bounces-863453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 920B8BF7E22
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D97019C5ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4A334C124;
	Tue, 21 Oct 2025 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="BqcxruLb"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC0348462
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067331; cv=none; b=i2PtRm74v7QS9a0OkBrIxPyZgkYwTsb43FKUUHpK6ZTPvg1hgyfbZR12JlFezKyh5E5r3DeV7XFaD9CpVX8d6PMBzqXsgH2sDPin7HwIB40S6q84PW7bn1vB7cvTCx1/XL/MUq27pDb47Dy+WF1C6yq0PH4fsvikP56Hs5apP7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067331; c=relaxed/simple;
	bh=gFqJdj80h/be0aG5qfr/YoS0OUa75SO1vxFrGipVgNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uemfdRtAXLceCXpdg1ByxtxnPueU38VC9drMqP8PGC2F++W7IsW7k+hFyG7uOBSuojrLfe66mi9tqP6zyX5saMJNfZqAaaON4qRWMOt6Q7JegGBIBLquEFKkqLoosAmkIZy4AXCwZF1AEAfTgMxUXfi4UyQUh0Aekx6326mOv9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=BqcxruLb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-290b48e09a7so69763275ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761067326; x=1761672126; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GwdpC/TjTPjM/W/Yn9o7f1GDYTCJVyhJfNsXik8groI=;
        b=BqcxruLbipEXFt5MX+uWEIAFmmUtCnb6HYAYI/ez7cmKd0sLCq1fczysoufW9rmjHJ
         sZE2MkNziFgyAJI5j2SIWZd2W5bxy1LAY01Em6UjnrW1WGkf7hF9TEdxslQ32qos6kFC
         ilLavO7/K8MG1zAG4SK/WDjJrtsCP1L6RQ1t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067326; x=1761672126;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GwdpC/TjTPjM/W/Yn9o7f1GDYTCJVyhJfNsXik8groI=;
        b=xDP4b5Pgq67rvjbKS8RNNL/Q1+ZCymJW+GqpcnBcFtvZHM7qzVsRb7+pNe+dHRkd9W
         UON6Fl9V2Z8izQ9FRbpqaxKapcysEuv91uFleHejFjit6KjQoSculeVsSbTZrH+Bek0p
         LkIAaD7YSdmc/FBYMBl0uQ2CZx4vDFYc6jkXdbeL8mQN5vCMdyBcgO90MagglWss/cfC
         TqS2t9q0M8AF+PZJXXfIShIhPoLqmJLWMEVrDTxeVSuhLke8AjNPJrLp79a8Jo/0Kw3I
         CRv6DyHewDWgjR8jhLOkaCFZFIG++maUqpiOzzbqT2BUVKzClzbSguY8Xk7c8EmwnNkH
         tHcw==
X-Gm-Message-State: AOJu0YyXS52O5siBwiDyzSFhtVZfZjv8QSnQOqs80FcEBX3FPoef/er3
	IkOLB3F9460EPX/3IIK1+u1moQT0fbT9q3uqhCYrdxAbbiTg6f3SES9ddpb12BEUdzDEItF2lCs
	B6eQbc2YZH/7bOEZCu5sz9Zgyq1S4HTRM9tj7AMsahWnj73ogkoU/iXqdq0yj8Tf56Ph1en55KC
	E=
X-Gm-Gg: ASbGncvbBVhbzw8GrjJzvaiRgi7gyaEMZ2x1nM4KgRK4Vxivv/JiRMKeHlRuICqxOXo
	UuafxLo80dqqju13YKOm21F+SxpM/FO7GWVF+yKhvtE9qNFXcNfN0SXng3Xz8cCrGCTFdt3OeLm
	dVkt3y3Xxx2cn2RdYfHHGqaWEHYR74JA0INoaazPG1WzbQpyHr2NVNyM4XgM+v/9eUZ/wodgZpW
	RAWMpgYUHx2oFfYNwcegQiNHPzCFvo9hBcO7yvjjd96hm9yry8CXQCS0d9YwHI1hHF9p+FtFC4k
	Hs7JdKaUoQXh4T/6HByy4A+lrOI/NOTwrtvW8Bkxr+Xiz2jqX8oMEQnQLt8eQLaKFRK6sHORxy3
	JPDcB5u0Mp6I5xpaR0pKPg+XrrwocueaM2BFu+0s3TwGJUP5je+WAdBtWp4DrzBQJmeKT0JiASV
	NYeQuiCaF3O2VkIXmHM/VutscWREXqI3b8rkQ8fsXbUjZX1v5UWHUpBZHK/DBRaLJTXcXTBs7dy
	Q25V4QWDSbFyeo=
X-Google-Smtp-Source: AGHT+IH2KEXVpH8xLJ6eWL13PAnBfQ6UqZgOoampku+eFQDoOCWIKsTjVH8w7CmoPtCucRqlZGaVIw==
X-Received: by 2002:a17:902:ce0e:b0:292:324e:24bc with SMTP id d9443c01a7336-292324e26damr195111515ad.16.1761067325861;
        Tue, 21 Oct 2025 10:22:05 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:d5f3:33d1:a1e0:46bc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2924721980bsm114249425ad.110.2025.10.21.10.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 10:22:05 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-kernel@vger.kernel.org
Cc: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] set initial length of string to 0 instead of 64
Date: Tue, 21 Oct 2025 22:51:59 +0530
Message-ID: <20251021172159.47314-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
---
 scripts/kconfig/util.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index 176ec03bb3f0..f55e3ce496e1 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -64,13 +64,14 @@ const char *file_lookup(const char *name)
 struct gstr str_new(void)
 {
 	struct gstr gs;
-	gs.s = xmalloc(sizeof(char) * 64);
-	gs.len = 64;
+	gs.s = xmalloc(64);   // allocate buffer
+	gs.len = 0;           // string is empty
 	gs.max_width = 0;
-	strscpy(gs.s, "\0");
+	gs.s[0] = '\0';       // initialize as empty string
 	return gs;
 }
 
+
 /* Free storage for growable string */
 void str_free(struct gstr *gs)
 {
-- 
2.43.0


-- 
::DISCLAIMER::

---------------------------------------------------------------------
The 
contents of this e-mail and any attachment(s) are confidential and
intended 
for the named recipient(s) only. Views or opinions, if any,
presented in 
this email are solely those of the author and may not
necessarily reflect 
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form 
of reproduction, dissemination, copying, disclosure,
modification, 
distribution and / or publication of this message without the
prior written 
consent of authorized representative of SSN is strictly
prohibited. If you 
have received this email in error please delete it and
notify the sender 
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain 
ssn.edu.in <http://www.ssn.edu.in/>

