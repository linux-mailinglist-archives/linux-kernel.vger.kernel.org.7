Return-Path: <linux-kernel+bounces-875811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AF5C19D21
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D5AD357E7B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB1532F773;
	Wed, 29 Oct 2025 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z36sryK3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477D9329C4D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734557; cv=none; b=gBfhQbHnKhu8nirIPtNf3MA1WGvaUFJfdOCZBdW+KejUXqsGSIg7Y8gHzLlEeg/2DgdibhUxkKNZ1tHQr7eQbA1P/VSYh0is9kuEj/3pP2BDRdF7OimRRRlzevJzx97vjnWfpPvdRIx+LoLtPg+RW4iAwohK6RBUcpo8Fffp6is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734557; c=relaxed/simple;
	bh=7gxDdxyM9gVNPiVVC4eGHnzzvY2SF9OG1/2DP5fZaVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P9NPgP/IHdz9rXDN7DZkk84DsBS3NwcEkvvxwyCcZZcVaY/hXxbbLeGHD2+3ef3Hq1GJOwDjbClwHECv7pa9WjiVAHj0qc+WihvTfzt2odN/HBgohZcPQGnyoAP2JF1tUTPHi+V0i2yhCoLhAT18hTcq0fy45+EBMj4/mjoVOjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z36sryK3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761734555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VO6JMeF+Y/rlXeytLrI1t4e8cSgJmr6x8lUSlNHIFuE=;
	b=Z36sryK3Jm2AxgrP4wBDRqUXvDJmyGVtW5U3Wx/6ABTOJ3D+lRn6PSdbkmWMhpCjS8RC7N
	Ao+JTMEfEOa0vuRiUgMVIC/06+ew3ebgXkAb7Supscma/Ck4C5Vcsi/NZ1454YGk74qdzU
	tcLkJDLeAPpEFHDaCtf7AsEmgFeIU8s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-Pqor8IM7MWmiG8o0Qya0zw-1; Wed, 29 Oct 2025 06:42:33 -0400
X-MC-Unique: Pqor8IM7MWmiG8o0Qya0zw-1
X-Mimecast-MFC-AGG-ID: Pqor8IM7MWmiG8o0Qya0zw_1761734552
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42705afbf19so504785f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761734552; x=1762339352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VO6JMeF+Y/rlXeytLrI1t4e8cSgJmr6x8lUSlNHIFuE=;
        b=w2Xao6fBDa8p/6VMg742NMxpvMHAKCfAAnihXo8dn7KFIwgzEcl6DNLW5phnVtKcGF
         /IrLQAR1BDbV9ztHPkihjJOAgh/7E8THmP2St8kbl1I0vf9yWjfg/xnS5bFa9+K1Obiz
         6WhxP2zpnV+QdNwDUyl2VsqyZSrGq4kd/aMOEpnas3+o/4YeCjsnszwOD4Y35a7Iu7z/
         Hu0kfYfG42ol4d6nOMiVbUW5Tfh/eDvLHUHRRoD68rW7R1ViTDmUaN5SvrM+aMGS647C
         8C8L9cLxWnROX8XRCcd/hkgExOOQZhXJXTNeKVjHzaC3WIKua6uKiPyxm2YQ/7LFfu5g
         ZHOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtsGajqyN5fiPj4jUr4exiGFjoIWPKh/TPboXX/iMdYsfjUGjC+xxLQMOW/0hQOF8yNhLpqS+D0HqsaR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOIVhMgBPavjlbgd0yYyz6IbOeKlhLDWdYJ8TaJgVWZ2wfFfyZ
	IhGleuGwr/tGi2SSi5vPODrFD9sRvR0N6fWQxyky7jVkk/q2tuH5B8Z+3fiqmRqJeyZExTigqek
	UcUS4FDc3Z3R2H8Se/aeL9h2I+myf5l5cg5VlJCrI8yVaXvrLoctpTQS5IrnWn0FXeg==
X-Gm-Gg: ASbGncsbeFQA6ueHNHpKvL6WjZfct5WPEoP0st5RqQrmGQSMP/Dj+kll7RBFMvVTemW
	cUk13GDalh8VrN1fiAEsptqSzP9TRCXboI+YLuB7LLxt4AiS93tOFjeIeGiMKvQrxvI+9AlLSjC
	moiAIC3nHRGEyR11TModSoftWwDQ+FOQCmOJM060V3/kSK9xN6LVOSOaswUB+BCUT7xGtEF5aP7
	KKc9syxVGHt6p7AFaiyXvh8cOCaQS4KRcbmoUziIanGaKvMUNJ1yLKYJ0IVqM8Z4L0aohF3FHnU
	1+99Kh9LT4Z6NwlBMmmkkIRjdKr76s4++jisXRdv6XuGKCFstMp34blomtEIdeXSVWLbQELrD71
	81rk+GovDe3Zf9V0wEY35KFji0q8Mk1FEylvRLm0AkVQrhjS8
X-Received: by 2002:a05:6000:2313:b0:425:6fb5:2add with SMTP id ffacd0b85a97d-429a81eb864mr5415904f8f.19.1761734552396;
        Wed, 29 Oct 2025 03:42:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl6mj9Yhn8JAOvs+rKKdsBa63eFivbLmo5z2lKtEdDXOT0AMmmPQdmaMB5a5oRC1AheFEt+w==
X-Received: by 2002:a05:6000:2313:b0:425:6fb5:2add with SMTP id ffacd0b85a97d-429a81eb864mr5415884f8f.19.1761734552031;
        Wed, 29 Oct 2025 03:42:32 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e387baesm40719725e9.2.2025.10.29.03.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:42:31 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>,
	Lee Jones <lee@kernel.org>,
	imx@lists.linux.dev
Cc: Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sean Nyekjaer <sean@geanix.com>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in NXP PF1550 PMIC MFD DRIVER
Date: Wed, 29 Oct 2025 11:42:28 +0100
Message-ID: <20251029104228.95498-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit ebaec90ec0b5 ("mfd: pf1550: Add core driver for the PF1550 PMIC")
adds the header file pf1550.h in include/linux/mfd/, and commit
a7d6255a0bf3 ("MAINTAINERS: Add an entry for PF1550 MFD driver") adds a new
section NXP PF1550 PMIC MFD DRIVER intending to refer to that header file.
It however adds the entry for pfd1550.h; note the additional letter in the
filename.

Adjust the file entry to refer to the intended file.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 70de2f9c4a50..e428ec79dd24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18718,7 +18718,7 @@ F:	drivers/input/misc/pf1550-onkey.c
 F:	drivers/mfd/pf1550.c
 F:	drivers/power/supply/pf1550-charger.c
 F:	drivers/regulator/pf1550-regulator.c
-F:	include/linux/mfd/pfd1550.h
+F:	include/linux/mfd/pf1550.h
 
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
-- 
2.51.0


