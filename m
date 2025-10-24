Return-Path: <linux-kernel+bounces-869444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDF4C07E65
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42C934E4827
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE8F298CAF;
	Fri, 24 Oct 2025 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="kuF80KZG"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF037291C33
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333946; cv=none; b=ntMR1DXYmKXzClmS2u4pcDUiN1gPL0bPLNf+JluizjY7Xs4nrh7dTrRYbVoe9M+KCPWtUIgqgBhhAgQ8wzvZmaQCGcDYy3kpBF+UGhb/geg3zhtqLOy7TdfoeajnRW6l0UDbfKRPLeGfajDEtVu/KqTgwR5DLlUOiijMzHVtZ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333946; c=relaxed/simple;
	bh=Muc95G7rlUhzAehbq1czj3Swd9R7pZyWx6CCa2Vo4TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W6HXBjcoNp0pfJoWsUjfu6/M7r4F29ttS31PBhc/EGsqCitMob6MM+yc9mxIjaJK2g3WmZklYJtEFG4ZamoJQpXM7DcvfcSBsF3HXNWOJS4jT4iHXmm3TUv2LNfDotKZwy4v08Do/O8LsscYksE9H32ANRYL36E8J/xHQn6YiVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=kuF80KZG; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-89048f76ec2so273530585a.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1761333942; x=1761938742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fgizs1HCq1WLCAQQTUkutHFP75+yUyTVrTdsaQGAtYg=;
        b=kuF80KZGo/bfsNuslKnW6+cqCdX/nF8yGZb8lS4ZPFbRxL55n9sZpPZrVpRASX/8Zt
         KwA0xcsUWWtIILC8Mf/fCcjPe0FgYdj2vW5FDQUKulQJbypDWavIzw839WwOVWdDJwZ2
         PYbQMoGc0UMOA3fhTuwedy8KmrfXk5IDokRz3SD7DQDI883wxHYVjIDd1TZ/5EWbfNTy
         JDGFeaGfInVACMtQuQCqznv3Fu7l8OupSY7LHlObCvxdSBg6j3pSFy2ELyZYE3UNIlgk
         mwnCp6jIVPgwjOBsKjtIKEm5nYfVt4bXjYyaMJZb3+3SLeigTLjy4X9bvdTmEOS2xjWp
         A6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333942; x=1761938742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgizs1HCq1WLCAQQTUkutHFP75+yUyTVrTdsaQGAtYg=;
        b=cZSyCJKwFWEr8JuYsZbNwdrwOq82jQSjB64ETO7AEx2X8vERVov9BXXKm1h+3FldVQ
         sWYg7dkK4Q5f0fOYB1jd0lEzS0IOKM5NQiwon2ogUtnzNqCf/6OPLIi9TW5LhOQuTcEm
         +tjhyDIAZ+ZnGXxmHWE1IPK/l5/CvX4lSnDcKPAQy95tpDd5fmHoPGbc2JYcigWo7vJp
         pQgQ8xIONc+MDj1zZ2ojCRNA93JWPt3JSCcgnTPvGETALOppTN3l6j23UxQf2+0PMmgG
         SAmaCqpWTl5Ft5T6KdKboGoFinnjTIu5Pcox6rPn6j8r7rwynEQ7Lyn9N8By5l18yZyD
         TTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXik4A37WpsJkr/RXTkGvHt22E4iDXU33rnAzwAJlDQRe3JCwmBR35O/dJAQ6LSd+oeab3QWo/NXnDAXuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk6uijLP1kDN8Q0Ny6b00vf8xw5KP6TRsvrzjMQy6Sbdejybzm
	ckQfq59B0+xBES11SlxOJoGX0RnDaLZ87HtDSWNX0uop92kIU/2OwKTqYutAonvLIUo=
X-Gm-Gg: ASbGncssBbo+KNtlPTvOPGTTL89N+FOHwugvaHrQaS+coJ3g1Iuzy3R32xsvIwIKQuK
	OoUtqsoxsu2a5sqEnLnjeEWSLC4ceatnIU7BNo3rUWoxQkn8riX6vSLJ/JzITk7+OtVMODiOUvi
	KO2W+t7y/SaDKJgVqygS5zqQQ9a3NQGlLsEAUUdW/TkVfFTISYDQZkJKs8Lp8ACBc7gS50koxzg
	EJ4QLix9XFxxVkv9bxG7ej7JpCzSnUdyby931imDeC0qulEuGT1GD0Ps/CQc6cMOTK8m5J58QxZ
	7UK9q47VsAsoCh+UEysYtygOQis5koHbL2rpaAcy3KRj8vbm1vEWfGEWvUx4EKUeGwUyExr4PCr
	mvBSffKOgI2yjTwhTDyNv46/pdaYmWUO04NgdJjYJ2sfK/fxfbFduChAYciwTHnXyPoZQ60Xba9
	OEGAhtQEuepgSBFOJs
X-Google-Smtp-Source: AGHT+IF+oLH6KhhyIS0OoqXEqbmUvHsRs1xEAC59weOn98ckZYRgBioEPZO/kln7GkQOamvkKza+uQ==
X-Received: by 2002:a05:620a:700b:b0:892:5c9d:edce with SMTP id af79cd13be357-8925cad32d3mr2952964285a.62.1761333942534;
        Fri, 24 Oct 2025 12:25:42 -0700 (PDT)
Received: from fedora (dh207-15-125.xnet.hr. [88.207.15.125])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-89c0e97efa6sm438239185a.24.2025.10.24.12.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:25:42 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: srini@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	horatiu.vultur@microchip.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/2] dt-bindings: nvmem: lan9662-otpc: Add LAN969x series
Date: Fri, 24 Oct 2025 21:24:52 +0200
Message-ID: <20251024192532.637563-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x series also has the same HW block, its just 16KB instead of 8KB
like on LAN966x series.

So, document compatibles for the LAN969x series.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
index f97c6beb4766..f8c68cf22c1c 100644
--- a/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
+++ b/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
@@ -23,8 +23,15 @@ properties:
       - items:
           - const: microchip,lan9668-otpc
           - const: microchip,lan9662-otpc
+          - const: microchip,lan9691-otpc
+          - const: microchip,lan9692-otpc
+          - const: microchip,lan9693-otpc
+          - const: microchip,lan9694-otpc
+          - const: microchip,lan9696-otpc
+          - const: microchip,lan9698-otpc
       - enum:
           - microchip,lan9662-otpc
+          - microchip,lan9691-otpc
 
   reg:
     maxItems: 1
-- 
2.51.0


