Return-Path: <linux-kernel+bounces-863076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 520C1BF6F36
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12F8464892
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D45033A00E;
	Tue, 21 Oct 2025 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="ZcN+7qNt"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC90332EBA
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055270; cv=none; b=TZUgxydcQH4l2sgCT1VPedH4pqh320Ouiq3TCGKq4tr4K3vQplZAOUG3gk+iWjtGqXSS8vA62+oz9EaNEWSng3wMJYxwaEK6prfcejN4yebHsvje/mwtbPahXGa7RG4erdHLdR+4v88Q1as0y/wcpj7++Edea1BHLDsZElKI9Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055270; c=relaxed/simple;
	bh=xFWB7cLmWtPWd25tnaZFBdw5b2Sdw8DhgYW2ozjUqPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g+C+H82Jj7729bME0ykwnRp2ArAVD2+r3JwM5ABS9l9czblClN93jfvCOCfA4YMU5J2jzYltNSz2X6zKB87rCIcEtdaO9RskT6cZYeXlE/tQ6/up/5n8JpCZPne71oHlni92gop5O/3IayuOkeJovXj4VuS+4/K6N740+4hQ6zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=ZcN+7qNt; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so5480862a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761055266; x=1761660066; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UoHkviHp3rnrs6ZK58wDDKN9Nodu5vcwsjLs5uZ+glE=;
        b=ZcN+7qNtgv/R7EQpXmG0tHQWq6syFZglu694ldH2HV9uI7Ph6M9FWCkLKUdG+RSAGw
         /CMdgQb4Iq5bJwmqInu7yZZIJxhrW9Q3sh7cogxdg1TeEgWVhIiBTPWnJMzCPxQQXpEU
         AW1g7KHa9mepmAV5j1n8DqJCNF+6OQcK9qcCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761055266; x=1761660066;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UoHkviHp3rnrs6ZK58wDDKN9Nodu5vcwsjLs5uZ+glE=;
        b=W/XpOlFKe+z8idVTCzl+1Iw4GyiTE6t1cFwy+ygAQW0I3MD0PSS6m7Cw6DF0ZM8tmI
         NBxdkyHxp92Na/YR+3fNEycZxXYv69aXcd58BkGJzkA0HVmAJOemD0Bb/A8+sc3Dcqgi
         NFOn3JFiuPIb4JVLs//aMm6cvNmjyMweBLZXcZwheIEf865SV+nkacGmVTuXDRbNal/Z
         0uHu4uipqVz4G2wJibuqeycF/16CpJFqyvSRR2HlErhg/4J+SSdtOkxT/BPe4LQDBYYf
         O7aWOh8PJW+APOS0FB6GJ+MObzocIyetSZxJSjbQF5QALDYMAhpbEtJgbnjeV4/LLFg/
         p2tA==
X-Gm-Message-State: AOJu0Yw8ut+ijbxJEHty7d69DgVD+KwfrVvna6lsukYh6sJm1Fsta/QP
	TfwW94j/bHAxn3QrlCtzETTfCPRZMk1hi/44Q9QZ6OVCDdWPFFuG0r8aEafPtpSsB+Hzf2bCbCK
	y+kO+L4o0LfuQhQJsRxMfRr+7O+iiKb/n/E3uovCpCWiQwwiw/f260VaatiwiJGX6xhy1yspA6u
	o=
X-Gm-Gg: ASbGncufGmjL2WOmj205Tg9kXdk2dN9ZJ7kbtBgSxATZWv61RRyn8pdMInobPVb/XrK
	D6CqwlhQ+5VuFx3WPeGROSiKLXqVIFrV5ROCpwEqcceFcBhWfoxSgquS4xVvOMG/uWT0xvGa3Oe
	hcgX6ZL3h6vIEkJMrq7sxXcQnIfLC7+EyvDTbRA6kmC02u/4QOo9ea1NulFM9xDNd+gYf7JBjn3
	BVP1xidkH/eSahZ1ZQ4aymWM5E6qKHU2KDp4RLQXthm2XjkFd0FKp4bPkv+Sh00j4r0aTUnCxe8
	apLCFVPdnQCGZc41ktTEojZxaf4A9sbdf+cAnnURtBvNOBecypqbGroPsdGFbGsTzVvRfU/Lj3n
	GqUyvCX6UnM78a4LSGc96yx4bsaoxRYSCkC2Z8FPZGkERl24N3NB92071H7yxsBtqvGz8XG3FzM
	F1zcMoR8Lt1K6jYcZNSQ+bsxsyJeix7DgwQXmke/X3JMsoF6bVCJAMd917do5+iUPiiubavj4Fk
	fSU
X-Google-Smtp-Source: AGHT+IGcPPdFWl+j9a0bAeijt2manD9K7Hb6Nq3eN/KduO4hTxKGkxDS4c1MuuEGyczVGOClHGughA==
X-Received: by 2002:a17:90b:1a8c:b0:32e:11cc:d17a with SMTP id 98e67ed59e1d1-33e21351ef6mr3389a91.4.1761055266014;
        Tue, 21 Oct 2025 07:01:06 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:d5f3:33d1:a1e0:46bc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff44d860sm948324a91.12.2025.10.21.07.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:01:05 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-kernel@vger.kernel.org
Cc: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] Spelling Fix :for current
Date: Tue, 21 Oct 2025 19:30:58 +0530
Message-ID: <20251021140058.32387-1-biancaa2210329@ssn.edu.in>
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
 drivers/crypto/omap-sham.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index ff8aac02994a..bd6b1cbc2ed0 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -1733,7 +1733,7 @@ static void omap_sham_done_task(struct work_struct *t)
 
 finish:
 	dev_dbg(dd->dev, "update done: err: %d\n", err);
-	/* finish curent request */
+	/* finish current request */
 	omap_sham_finish_req(dd->req, err);
 }
 
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

