Return-Path: <linux-kernel+bounces-832888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EC0BA0AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AF707B7A14
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA5D30CB4F;
	Thu, 25 Sep 2025 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWmYQdQe"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C6730C34E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818459; cv=none; b=ONlRmavHc9pqcHKp6/xA6LZqJ+jYogypBI9EYCwhlEH7AGMFh8c1cNzrCe2mLYzolg4rm0MIiFvUePOjWncE5BSg+8FcM8C5EVZeGxvDZ1rvwQeFhDQ+2JIJWLZew/VINEp1yZN52MXEGlNqcpNURn4HypSZ0tGHxZe8MJmjlSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818459; c=relaxed/simple;
	bh=v7/bGU7ZHCKWwoPLxIX6yU+W6cwtgrDMpcJa/blq4Ig=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iam91O2ZZh0xPdYAh1WaRtfQgutO4SamZ8KAqVVY68VzS0TUBgFRIYmqWtAv1BlPJtMqhckey2OnuIJ5mb4Rsvw3Simqgdgr1/9yrQLOoo4wYPx1nPP181UwsBuxmnlZL7pRMEB5NAQ3VmdYFHqThXImNIEp+ryvhcwsqzeCxDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWmYQdQe; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so1146899f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758818456; x=1759423256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOcrIoNr25HDz/QJv/9nz1km8B+JKQd3A3tnWDgtjkQ=;
        b=XWmYQdQe39PjSYHTPfQ8BN8pIXpLGrUwjcy4s+P2SIQkq1CDiIsZ/ivXG80BvKdPf2
         0YEp6AwNRZNF3Qfy3axo7zfu5Q+zAFRuSY/toJLvRa/l2uSf4Z1Yp2fR2vcf/TOe/e/A
         r4G08N/d5aJlPwNXX/Nx+uQ5fk+f87BsXjmjxWdvcaQ4RrXmilNdSi1D6ENpUXiZPM1u
         c7FLQiAqdpr9xexiVRdelXH32dsWLQkuXbRzt0cuwmFUjELJO5wcofLuubbvBYOwpnHf
         6QuK+z42d5AX7GXFlFCLHgofUpE5v+yWUBMzigUnowWU3WvQnrogzi7ULa3KNGq5p//h
         Cmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758818456; x=1759423256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOcrIoNr25HDz/QJv/9nz1km8B+JKQd3A3tnWDgtjkQ=;
        b=l+6T50PjPHnXQKR4/Yj+y3dsY2bnao9f2nTwNRdFhEvqB8xNSAyFTzsMvwSumnDJlm
         X2RSPfCYUACIr2O+HcNl5reTp9RY4zQsDau9yuwmIi4HTYEcpT1XvePUuUG6vSgAJPRb
         tjksgAJKxK/TekV0GWDP67f6jkb3CrXUuZ+SE6wcq18O2EduPo9uS3GlRRnZlGeUaR6x
         YJp+8vYvdITZkO7r+mbuxMzgT4tIWdKWovi6LqpqyJwbE8ynz7gBnp1AOoQopc5nLktW
         EsyEKNQTyhJKqlR9fJHgb0WHiKAdte3AUG+6B118WAioFFggpdPetP7T26VHFB3I/1mz
         VNOg==
X-Forwarded-Encrypted: i=1; AJvYcCVsmI1FfpQceB6ySciTibaSu7UNVscoIL3Ixx1sCf0N3VfscQeLtSpqYXvNLJIqBKJD0RggS3JZKst762k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKF4rVnTgDkXFtjx1+N5Ug3OAt+EpGbTH4zeGAoSWuiUSA5BXf
	lBwUjvXlSZ0S9hkXpVOpw7Zz6ycX0iJYDRae0b76ABWcpp3Cg5RZ0zA8
X-Gm-Gg: ASbGncs9NE+Ax0aOkzkBNCspXSVAcf+iE0j7GOBls8PAMyr+kmMiK4V3TVPahSU6zuQ
	gUbcv3cMRYTjQDcAyLekk3z02g2bRwAubT1sdeyqzOPePcsYuXtZDY0gz2kEe7bOeMhf1XUEGf+
	Fvy4EEoH2e5JxQbnyFjExR6chTui09L+xhnCKMlK1eP6pngPjVXWhZzvlaPk59tSnZ0dqAX2x+W
	TC9AKOutjxNL7XXH1bBF0o46wf3BUAurjgieA/nmHcW42Iq02gelm2KCUSHjBjhceu7XSWBCDhy
	16apREPU7FGyNkt1wjl/+2V5zhLMcnkn19Ld6wvT0zQKWyNbHfBdGbMHdP+pyZPwsPNM7w03302
	gpc4C+cm2zF0OArMugFO2uqlVB9x6e7zJd3wHeCpWftv5v5aPq4ydBTlQsudTNqo7yaT8sq8=
X-Google-Smtp-Source: AGHT+IHX/CI2L/vfg9Dj8p1oMbt+FsoCRcXjcK4DCzITBXnWVWzmuBAbvqxNfCx8Z5RM2iRB5ODlEw==
X-Received: by 2002:adf:8b88:0:b0:410:3a4f:1298 with SMTP id ffacd0b85a97d-4103a4f15e3mr2182661f8f.15.1758818455924;
        Thu, 25 Sep 2025 09:40:55 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-40fc6921f4esm3591904f8f.44.2025.09.25.09.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:40:55 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 3/4] dt-bindings: arm64: dts: airoha: Add AN7583 compatible
Date: Thu, 25 Sep 2025 18:40:36 +0200
Message-ID: <20250925164038.13987-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925164038.13987-1-ansuelsmth@gmail.com>
References: <20250925164038.13987-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Airoha AN7583 compatible to the list of enum for Airoha Supported
SoCs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/arm/airoha.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/airoha.yaml b/Documentation/devicetree/bindings/arm/airoha.yaml
index 7c38c08dbf3f..df897227b870 100644
--- a/Documentation/devicetree/bindings/arm/airoha.yaml
+++ b/Documentation/devicetree/bindings/arm/airoha.yaml
@@ -18,6 +18,10 @@ properties:
     const: '/'
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - airoha,an7583-evb
+          - const: airoha,an7583
       - items:
           - enum:
               - airoha,en7523-evb
-- 
2.51.0


