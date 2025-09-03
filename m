Return-Path: <linux-kernel+bounces-799036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F343B42624
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CCD67AB216
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E4229BD91;
	Wed,  3 Sep 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS7N3K00"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB683299A90;
	Wed,  3 Sep 2025 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915315; cv=none; b=jI2FSadOv8SxaM0DQ8KY6TjFAFz7TcDwMMwxK+hnNHG6udnh7yG3xBwfowcWAIonXNUaJ6jxVGyQvOVgzB5/N3aA5LVo8PUJeHstAM5fAU08iD2YLcoueNth5xBC7VEgYGcg/5264s1bZBb6wGf9hqX2Ho2RAn2sXkSbwL8yiq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915315; c=relaxed/simple;
	bh=AoMwX5vmHhWYssaNGLA0MnBENp/jhOjFtXpHnbdkWQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fVQL7ocMoMm0MmegF2szvg2sh3eJbwQ7rJ3ZwMwWIN2bPflGmsCqf7dfWKSqTLJMLbF6uJzwzeBYz7HJC2J2mmHmc7j96qn+AGQkbyOrEriDUy4JmJxku5hNaCVwTjZ5wFqJ9aQmXF1L0/bq2YDHYQYRSrMQoz4hkKTu9fz3jps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cS7N3K00; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b84367affso818155e9.3;
        Wed, 03 Sep 2025 09:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756915312; x=1757520112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wYFPRs8fQ9pkONgDblMVcxXbnU9avpxGiFxkDBxyF1M=;
        b=cS7N3K00gscRf8ToYBKekauKhGjFAqZE4f80e0iPyQoP5LsTc1SVCteRigSIsOWzSQ
         P5Hx8j/Zrt869Av12BsqdFQjgyNzqLyiU/78hs99DioTFebsfEFxQ31wkl9VA+OTybNJ
         fNtIKgjsFS5qoa91s2WZboWRwScQTq+BlJJ00Tau67GalY+lEIH9660k4KUpbZkqqHnJ
         y/pqKhYwy7gDZKxBV85hJ3978tPaw25pmt1tAhG67/ZgPSngXgvyR5tBS//dryrcygtj
         WTR9I1omYnbMZd2d4GjYmPqU+2YU72FM0R1j9Y743ezFUSCtjQEu6fjoGqsu1hSK10R/
         AODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915312; x=1757520112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYFPRs8fQ9pkONgDblMVcxXbnU9avpxGiFxkDBxyF1M=;
        b=KFOBCFOsLQmPA9zrEkTMtmv02ikuZkmY8iYSTr/+yD7dcqhMlYgIMjEcH+qRpL3vSv
         6uvI5LqqJF1rwFOX4XzdROnC7nMYZvopLGxqX2BWuzAG+IdjAo68/Zjf68RaYOGq60Ak
         N7Ff5Rzr+h9dtOl+tFtCx12M2QJHUZWb8RzjfaVcbtYZS6/zCgZiWLw94JX6cjMy1oVe
         l6FHibUkx4jBHN+SCgcVLzlc0DkiX4XwVWS0yMXMbCijXuBmxvcm1N22uO+kCS1oOuTf
         n9DPKS1V/xKUyAOowOMzdKm/gNbd6+wcyBueyFd8Vl5hFXMzTsK4vRuYuvtP8plXNv2r
         Zmtw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ4F/zDi4UeGMovcOPKlDzTXppYFL+UKmJeWF+3Z4NSviHgxkJQ87CXwZAZ0gAJv5eM2DF2gFSQDmouYOL@vger.kernel.org, AJvYcCV7XwCvmPKRfNrz4GrwzVbVhUabQNV848TIi06ewdDw/9CdWgPmwffJ3FKfb1d/ntlzmQu3hPfidxuf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Z1991g3sYckLRTzwOKZXtBVPsEjxYFfrwCTl8Ah/TKiz1LnH
	VEyfqTFed5ElCeMJM7EuSCBYw27vLCdpUwl8zkEY5N9bRsiLqrjLKdD8iYIX4qE=
X-Gm-Gg: ASbGncv2si2JPnvkQTD2L8cXriTj4Te+tz8NMumsmE/0PAqpBcIcu9BLaBoXFEQ137c
	TOG+ZEcccXY6IFcdEnUAYMNvRn7jdmT3m4q2rEKC1V/I/5GnlLFjp3pTTq+n/drpe1f0KdyWmL1
	oW8muj3kZFSZ/4KHk+Ov5H8HeAx1BxU6UAJmFnqpLc0b9BnrH5Z0J3Sy4EcT0aBSQIcWWW+iWCe
	9Q0LhVPyEgVysWrMGbiDbpc2Z2spSNwpWvKbWa3zSqgVhaYzL1eBRHIeueGF9Z9RysL6fny9DQI
	lVnNTdUTi41t7binJzlYd9VjaRxirwDCVZVvr1sgiMSDvdGTN8y/eDCLlsoAA3Qh8FraI3nT28j
	/YDcPEQFHE3EJUgHIx9G/R05HrdEnyuJzWBrFVoPmWKue8QTlzsI=
X-Google-Smtp-Source: AGHT+IH5YYqKALa5p3/D5XUw/9GLkBdPZT+6aGQqWFAkFEEt145YZD+1fQDGckYzirs7EBJ/DZhtUQ==
X-Received: by 2002:a05:600c:1e87:b0:45b:47e1:f5fe with SMTP id 5b1f17b1804b1-45b855c0d3dmr112369795e9.34.1756915311464;
        Wed, 03 Sep 2025 09:01:51 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:221f:e1b9:d63e:6ec1:3551:61a6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8f6cd502sm61672745e9.1.2025.09.03.09.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:01:50 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: linux-sound@vger.kernel.org,
	krzk+dt@kernel.org
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	drake@endlessm.com,
	katsuhiro@katsuster.net,
	matteomartelli3@gmail.com,
	zhoubinbin@loongson.cn,
	KCHSU0@nuvoton.com,
	patches@opensource.cirrus.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v2 0/3] ASoC: dt-bindings: Document routing strings for various codecs
Date: Wed,  3 Sep 2025 18:01:16 +0200
Message-Id: <20250903160119.83625-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The series adds pin names for the es8316, wm8960, and nau8825
codecs to their respective binding files to improve the user
experience for board developers.

This v2 series addresses maintainer's feedback to rephrase the
description to refer to the device's pins and ports rather than the
driver.

Thank you,
Jihed

---
Changes in v2:
  - Rephrased description to refer to device pins instead of the
    driver.

Jihed Chaibi (3):
  ASoC: dt-bindings: everest,es8316: Document routing strings
  ASoC: dt-bindings: nuvoton,nau8825: Document routing strings
  ASoC: dt-bindings: wlf,wm8960: Document routing strings (pin names)

 .../bindings/sound/everest,es8316.yaml        | 16 ++++++++++++++
 .../bindings/sound/nuvoton,nau8825.yaml       | 14 ++++++++++++
 .../devicetree/bindings/sound/wlf,wm8960.yaml | 22 +++++++++++++++++++
 3 files changed, 52 insertions(+)

-- 
2.39.5


