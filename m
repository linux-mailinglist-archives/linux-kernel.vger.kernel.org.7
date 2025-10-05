Return-Path: <linux-kernel+bounces-842447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6B5BBCBFF
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 22:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C92B3B6DF4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 20:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BD3233D9C;
	Sun,  5 Oct 2025 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivFkiYE0"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2753F1DF26A
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 20:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759697468; cv=none; b=p3JFlLrqfAyNOb7kZLh4ZvKPmDlEu+OixgiMPkE8JYlc7y3+6+Du1HnDoURaBP9ufgHAtBfydSVR2mxkA5kb1Hdd29MQlZ6x5WgZrNfdvJ35GeFCguHHCwohqIlkd2VU6JJQeGAQLh5NAz3MP3ew1+Xs1GxOStk1XZKp7PfmCyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759697468; c=relaxed/simple;
	bh=sGOdOd5lj8RNH7bLfh4PeOtHP2wnFce2PImaX2QQu08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g48QRiq/DtA2A/DB9ud4nTEoVqb0gtiYwQh64wUwxHBnV2jfXdZoXYLuMXz2KlRgHhjH9E/SGQPl1BfEiScerIMIFZKRQ4xjNBURYDsGaIyCA4FOJMVrgy8MYqP5e21MfbqDpfqubU6ce+L+NhiqCRALzNmQ2Dw6Lm0+MP3diK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivFkiYE0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so3830685b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 13:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759697465; x=1760302265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o0PulYaesouydzPIXRseNOAbBXULJfQ7jKlImAk9vNY=;
        b=ivFkiYE0o7K4WkX9n+kh+TMo6ZOgNr5RZ8iLOHOHvaKgNiLxAFoS89nsKO2uUI4fle
         DsAojqYYYJELjUOYB9P6x0Lprx6iXYKY3R0hC1R2qOe22COgS7LusomQYxJUeMOXZn/O
         rHKmSoj+ZX6AWQkfXd0skCaEXYHytFatdKmtAU1tq5piM10EP+6CAMi3bzglYPmvzvu4
         sflASavVE4od+IYZ0DZ89Sbwp45wp2Z7eSF8IcOFDCPkuQmwNazm+KycIf1xbRkeiMJ1
         SSHiOIThzXSnyEPZnnadvvbK7iwMobYBLoXHDN6IUGR3HCoEpEMy5JzSK8LLC5SufYBd
         r05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759697465; x=1760302265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0PulYaesouydzPIXRseNOAbBXULJfQ7jKlImAk9vNY=;
        b=gQC4m9UWAUkuz8n9QYNr6pvvF+BJ+Oodxo0DmIvChoy01uBL4jNVRGJY7XbsLBS6YA
         IzXsB7PlvInui9c0yhFXfSHPyegGNAl9bqukNNnvCRLHgzeVgN24R1vdmLlRZS1B06Bk
         OSsFmc1kpyqzk9H8UAN9bXviAPI0uMefZFF58x4Xk+FR9s71qqpk0qCk7U88J/OKPPxB
         Av0NBlqjzxtHEUUYN/QTpGDXqBIucfplY1DuXEe+PBj6IzGxqug6Nz95+jOKB4+mgZH/
         f6liPp8Aiuf2+xfH+venMzJXzGcvzdlQ1iWhZ2F6lbBE4+/YlfOl63koAlGLIfXG6TmA
         7bJw==
X-Forwarded-Encrypted: i=1; AJvYcCV8R6Kf8FMfYkR8OfLD4++v6/OBMY7Or6SSWbYNTSarUrbgaPGDzMGLRTsgSgicuZ0v5eV74uin0ifYT84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJtpQB8zEAlEgO1qqRG+4fk1EPcRr5BDy3c0uII3pE2nJUFYTh
	eS+E5kTrQgx3SQqHMcxtmrPodntK4hDgtI7njgHmP6x8rtjTsFkX4uRz
X-Gm-Gg: ASbGncvT6kxXmZSaD6BNMAwknyF8OaTW02sL6LXpR10aeXIXIIkndpx/20ywFvOVuGb
	2RhU13rg0SwB2LztdohAlAuwxE5tQ9hGO1XI2BEBXQew8j1r7ZpUQuuZsvE980KTNzeZUuyt1oV
	sq9a7xnA/81d/00mrUXd/Cete1UzSGvI1d1UzbmTJTb7QzS0WW3BwLW5w5mukw1HLe3APLLWENA
	LW3FKJ2tPeLyNnXzqAHGRToE+0qx7rLY1muQN3NEFwvfYWkeP48oHHLkdxXHomESdy4goh0ZmrU
	APm2tO6Pif4CEXRcznfJUC0tZkxAn6kA1NjCgjdnWntxPxK8QSnv49IfGXGO0HsaBzD4r/e6cFk
	4MD573HXQcG20yJfZvTqsPQ3A5g3Njjhy+nijo4fMMIquknDaQBCQoc5UMWOyOFxAilqJX9bRZQ
	t9o8S6aWSp6vrkf/dphQh6cgybjvw4lAR920kEmaFAbpP/7292L3phkbnu3Q==
X-Google-Smtp-Source: AGHT+IGE6psfDyF/tpG5iD9+AN4sMGtubuFXdijlLDL6L8UyOx68nbT2vXp8iohVZVMCKB2D81UvNw==
X-Received: by 2002:a17:903:1ae6:b0:269:936c:88da with SMTP id d9443c01a7336-28e9a61ef1fmr103838395ad.41.1759697465228;
        Sun, 05 Oct 2025 13:51:05 -0700 (PDT)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1267d7sm110498115ad.49.2025.10.05.13.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 13:51:04 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	corbet@lwn.net
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH 1/2] dt-bindings: trivial-devices: add mps,mp9945
Date: Mon,  6 Oct 2025 04:48:54 +0800
Message-ID: <20251005204855.190270-1-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-bindings for MPS mp9945 controller.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 58ff948d93c9..08e2ca1b573e 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -317,6 +317,8 @@ properties:
           - mps,mp5998
             # Monolithic Power Systems Inc. digital step-down converter mp9941
           - mps,mp9941
+            # Monolithic Power Systems Inc. digital step-down converter mp9945
+          - mps,mp9945
             # Temperature sensor with integrated fan control
           - national,lm63
             # Temperature sensor with integrated fan control
-- 
2.43.0


