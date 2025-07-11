Return-Path: <linux-kernel+bounces-728104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44731B023B4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E471CC2D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B009A2F3650;
	Fri, 11 Jul 2025 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="kje644ut"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE02F234C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258809; cv=none; b=rTrsaLmDh8vDz2pzsWjYMGfPIlmaX1OEgdTguTzeCUbiY7UtTnLfSNrgs+XJ4nGDhwi7Aa2kx9r8IZOChuXI8Cu7Sftvq03Y4ucw0peAapygY0ZT3tKlf2kFpnsjB9ZUkS3SBEHp9x4TxMdOU7V0cWFK7BpWq/NG22ApnIRG4zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258809; c=relaxed/simple;
	bh=c4G0nLEkAkq5XZ+dS0OGLjwmFuBAtU1HZ1+fl7Ai0jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvJO8N8xpcvAa+Fs+beYHFKjyr225D2gf3KIv/yvWDxKkLEllaBvWcsZtzy0O+UftDv7q0v7y7QcBVedGQRIAWllHIjo4p/sgIGxXoHILQe5wA5Brnos5jpJJNHul49e8zo2+C+SXSFyvccgG120X0gkV6nxZYBjbyHS+WS4bm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=kje644ut; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-453643020bdso18565425e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1752258805; x=1752863605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ/08yx9KdEYvED/sNtpfI8PHIlJl7VHvIaa+wkBHBM=;
        b=kje644utvO0IIhH4K1TwZzolPWg9FsEjWzHorNPXziExAyAQiqcDiFXooQrvQlE/Vo
         +8OhW5HP7ARFOwEspnukmftgjAV72nC/Lf978IceqS5NsDU6SaQ4PErqZ7BH4gyuSaau
         4zZ6JmKwqAc1eqzg1xNW9eqMylYiMLiRaawMY4rLUaDMsskP/06Q9TEIP20uHvlCOodg
         O/seSafzJK6XNVOXILRqoAObx30WD3TKBhCUiYjpdybZuhhuyN1raYRp/4zl1mUxyDgv
         5LbspVYkcXAfTgaED6RNs/sesY/+n5C99JYJrKD312B56o+YSNTI9QvveKSE9TU+/1m/
         PI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752258805; x=1752863605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZ/08yx9KdEYvED/sNtpfI8PHIlJl7VHvIaa+wkBHBM=;
        b=CW0QXCaBSrhLOdib5i4TzfpIU9pHy8dHGQuY5f6h7rIgXqLvZmRgUOOSPtHQUWqEYW
         VGdJMO8ik399i0CM1KI6uA2ZKP7+a/HK0PSJiLImKZtPA/vBT2QEEnH+VXuU1LfMp3+Y
         3g9A0s3CfSjaJpCDUm4J/Ri92kyZLQ3fnEIfkNRpc+Jlr/kWo6hBLJxE+j46pOlfemNK
         EkulDAhwOAI8Bkia5eTaRdfsU5xZZXKNh5LVwMWfM1mln2hroU8jVNSO/KdY52y4ooOq
         bTfFBXeB3To2eOJbpNRPNuFzrqqSIJEn3khalpyMKDrkzAlDRBI4FNJxEZJPzbDsiW1p
         TueQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRk8A20++Ya3Zt4z9litUCCql6v1NpBxjEwWzuG43lVenAXZuIQpMqzi28m9FyBl0+D6//u4TBRSHeo9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwFdH40j8YaeUiCRy6blo5Dc4Jz2mqVOJdogSEKqFshGhq1ZFb
	rTVed281L4yaSQeUVRIQa11+XeEk5udRArlOg+zVDwcESrGihk+BIP9xfOhkTVh9h44=
X-Gm-Gg: ASbGncv2QPbJxHtCFkHxZVmsQPEDXpGwk6r2eflJiJu536ImmmlmR4fubFOlNSaM6Ha
	D2WuA8o1/7HSvQ9HeNKeYYwgNOpmNBsny+t1wJuPq+vxN8zlXyU7vDUCEnnt+vQA2wI35iBPIOC
	VQJ9l7pVMLIXVwzDzrWLdg+E+TMtNAud+oG+dkp+AD8I4takGIyr8og5LByroKZVs4JndH8Zi15
	0BN9X+hflTA/IXWfHQVl9yl+JzrH9cfet37I3RRCuioBGtL86LHjMCcIu1klC0knIh0F4+eRtDz
	T/eumoqpw4MDHyF9ThSmi7lU6+Z7nQo7IBVnvF9KHcrEeQKpWLgP4z+its/WT7vmXAYLvOSJdbZ
	a6DkXkam/7B5nOoh1Iu2PyZK2G/S0kzu1K3lS/Ir0VhYV2SxxwLarNZWdXzTr
X-Google-Smtp-Source: AGHT+IEvPbYDu3buwmTl0D0zspg4iHm2lPmeDh4bhM2691VW8eqw0kaZFk/7vW1I7JEp69ktUPgeng==
X-Received: by 2002:a05:600c:8b26:b0:442:ccf9:e6f2 with SMTP id 5b1f17b1804b1-454fe0f93d6mr45409645e9.16.1752258805054;
        Fri, 11 Jul 2025 11:33:25 -0700 (PDT)
Received: from pop-os.telenet.be ([2a02:1807:2a00:3400:bed2:2848:b66c:32d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45601053020sm705205e9.36.2025.07.11.11.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 11:33:24 -0700 (PDT)
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dlan@gentoo.org,
	palmer@dabbelt.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: [PATCH 1/2] dt-bindings: riscv: spacemit: Add OrangePi RV2 board
Date: Fri, 11 Jul 2025 20:32:44 +0200
Message-ID: <20250711183245.256683-2-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711183245.256683-1-hendrik.hamerlinck@hammernet.be>
References: <20250711183245.256683-1-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible string for the OrangePi RV2 board [1], which
is marketed as using the Ky X1 SoC but is in fact identical to
the SpacemiT K1 SoC [2].

Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-RV2.html [1]
Link: https://www.spacemit.com/en/key-stone-k1 [2]
Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
---
 Documentation/devicetree/bindings/riscv/spacemit.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
index 077b94f10dca..c56b62a6299a 100644
--- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
+++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
@@ -22,6 +22,7 @@ properties:
           - enum:
               - bananapi,bpi-f3
               - milkv,jupiter
+              - xunlong,orangepi-rv2
           - const: spacemit,k1
 
 additionalProperties: true
-- 
2.43.0


