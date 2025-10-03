Return-Path: <linux-kernel+bounces-841161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 275B3BB6602
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38683B796C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DAA2DCF4B;
	Fri,  3 Oct 2025 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ang0vBWs"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBDA2DC797
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483834; cv=none; b=UoM/NqdAOKhYbJ89FE9R7MLjVwKn73CWhSCWs1S1f80jaKBuI2tcroH61z+ty4tpkNzv3gvaaOTrXJhSy8iM++AkLQY0ssP7ynsluq6MT9k0B5CVy5of8Uig4AmAd1esjyvQH2AtWNrGvNbKlh5HQ5yN0IucRSOOq7iBKHREVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483834; c=relaxed/simple;
	bh=K1XuBmDU8mc6yigmwhvBbU965kD3981Swiiou2geAgg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MlOlYgj2zacxNFNIQ+JFffw3PzcpZJBOB7xZietfD7XIE3FQ7ozxiEPFMMZHUFodllA+QrGV3W4ujetorHKBlxn3VF6lPv7Y7eqVz/GgOQO5DlKAooQxw7aCxjQfzdj8Ly1zUlcDszzZRehs4pAocLQf5HAvchAYq9ZyRmbx5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ang0vBWs; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7811fa91774so1695666b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759483832; x=1760088632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MY+BZNsR+IgMIYiBsZuUgrwraYujXaWdCc917CV2LJE=;
        b=ang0vBWs+LewcZwrKFT1GFj6MgwOaF/kaGLcswfA1Gnxj1+g7aNqqVQfRjgXXrVgPd
         TodaxCDiBCSGFHa4JZq4KQEIfB0G2ALOk2E48xnPuIokRR52wKl0SapdUQEsgLJ6ViRc
         A0/bEFi1Nm2mMB3ytHoPTxUQhVyE3szHysjvKECtvf5u5/sIJal/3DPcQKu2lnR8b2eQ
         U61RzTKTszkRLwNYm0ICquAByAa/t2wpVxOzUBnAq30yRJ5RA8fDf2PL1Qto4u1yssgX
         PKaS2xcaZMk2P7Jd4UdScRI9dF+PORcwZ/QGBiOm7lUdZLgHEXvbBAif3icfOrQMbVxc
         Rx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759483832; x=1760088632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MY+BZNsR+IgMIYiBsZuUgrwraYujXaWdCc917CV2LJE=;
        b=Rr806xCUoGS5CLvu5rjPpMWClW+QX7zU6XoHJwnome89PYg1s2VoTu7LYyx9rwFT5U
         sOXrEXhMl71+JJMlShGspDUUY9i2L9YNPnUV1NBd47TUgi08kbMyrrjBpgcCxDPGcIwX
         gRpxwEtDfILTSXHe7MdP9xHzRAvRMHkJVcaZ1UtoVKqlMIpMZ+MnaEakYVUy8cINyZDK
         S1W11hk3uWDyojpJsas9anT/4uK6qluAt4Ilarzp8gxvAoc/T5fTZ0WMoMc/GwOQuosq
         wgadFDa3CoZNw7Uiv+yKfQItBjYkCUlafK3ER3J2NzH+Q9OI+UfVM5Uh3YLbW8f+DqTt
         a3oA==
X-Forwarded-Encrypted: i=1; AJvYcCVdX6UnvDKEE0OFJN1xk9Jj9VP7oUbb2/UhDg0qG9D4SkVRSVMI/hEKov4PXHecJT4mEBabSzqwuJP7l0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNGxo0aa+7PFkbDky5ktceQGVHVAHotSJXZBtB95c4276FPUib
	BU/B3jNnzfc2JRMWLsMj/9apNGEkmNz3c9g1EvBRn64c/avoLmLJEyVY
X-Gm-Gg: ASbGncscCGdrLVZ5gbnFvzN41Q6hRK3y5aQlOPKiOO3Jl4M54lCM+Ho92BWl45va9lS
	+NBpFi94a97YCG1gz1oom9uDo7h0qXIBur2T/E/sRPFuwk73IRwxGHuNl0JIzi8UTjkfwnp7NyU
	qxDhvh7sjJ6CSVF1xqxHZn36WSpeKes59lBxEmehvWMb9KmtlHDu0GqFhOC6IeVR+/DfSrMfYJL
	qr3gLdjY5Hn4+ifqmHVUIHHvQWeffCqjiYVH1ipwp71mQHAhIkZLeQAwzu30R97v3LS/3SfjY12
	VM7HvtVydj6p5ZbI/+Udh+16bNXQMYAH2xvRe1EZHVKQhmms45PAdtwfo7ZVXRJe1xPsifL8VUh
	wmSbaW3gYFK2mIciYtDuvHc+xJipLyKhhdwVB5i38eq/8XjmmluLkdxQyDTOjxEkGNrB14fqE8g
	DCF+HYuqwiT9xzB/Nvj8V3fu7PpWbp2H/4RHjs0rYVaAmbJo+KgA==
X-Google-Smtp-Source: AGHT+IFBKj1yIRQ33z84hpXZz/pFfTvSRpTxqvryCB6k4gcBIERMIdg20rONeTjo6vtkrZojofCL6Q==
X-Received: by 2002:a05:6a00:39a3:b0:781:1a9f:aeeb with SMTP id d2e1a72fcca58-78c98d2e6aemr3357057b3a.1.1759483830908;
        Fri, 03 Oct 2025 02:30:30 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb16d9sm4362046b3a.22.2025.10.03.02.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:30:30 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: khalasa@piap.pl,
	khc@pm.waw.pl,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH net v2] hdlc_ppp: fix potential null pointer in ppp_cp_event logging
Date: Fri,  3 Oct 2025 09:29:18 +0000
Message-Id: <20251003092918.1428164-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixes warnings observed during compilation with -Wformat-overflow:

drivers/net/wan/hdlc_ppp.c: In function ‘ppp_cp_event’:
drivers/net/wan/hdlc_ppp.c:353:17: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
  353 |                 netdev_info(dev, "%s down\n", proto_name(pid));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wan/hdlc_ppp.c:342:17: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
  342 |                 netdev_info(dev, "%s up\n", proto_name(pid));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Update proto_name() to return "LCP" by default instead of NULL.
This change silences the compiler without changing existing behavior
and removes the need for the local 'pname' variable in ppp_cp_event.

Suggested-by: Krzysztof Hałasa <khalasa@piap.pl>
Fixes: 262858079afd ("Add linux-next specific files for 20250926")
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
v2:
  - Target the net tree with proper subject prefix "[PATCH net]"
  - Update proto_name() to return "LCP" by default instead of NULL
  - Remove local 'pname' variable in ppp_cp_event
  - Add Suggested-by tag for Krzysztof Hałasa

v1: https://lore.kernel.org/all/20251002180541.1375151-1-kriish.sharma2006@gmail.com/

 drivers/net/wan/hdlc_ppp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/hdlc_ppp.c b/drivers/net/wan/hdlc_ppp.c
index 7496a2e9a282..281699e8d799 100644
--- a/drivers/net/wan/hdlc_ppp.c
+++ b/drivers/net/wan/hdlc_ppp.c
@@ -133,7 +133,7 @@ static inline const char *proto_name(u16 pid)
 	case PID_IPV6CP:
 		return "IPV6CP";
 	default:
-		return NULL;
+		return "LCP";
 	}
 }
 
-- 
2.34.1


