Return-Path: <linux-kernel+bounces-722684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7000FAFDDB1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6194E846B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4DC1DE2B4;
	Wed,  9 Jul 2025 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTzl9pQJ"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6663D1F4C8D;
	Wed,  9 Jul 2025 02:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029281; cv=none; b=BLnPxoVGDB2qBx9cESqFCi38kd27r3G4ES4q6F2ozZrkUTiszKQBNURI2oE1+ipySkDHcrcNzZaznBtl1C1JWkNi3XowUByAy69cheqdqkn2yR29SWgJppxn0HRmqfhT3kfnYY5QwqyxhPude3u2f26clvKnXown1nMkr/zMK4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029281; c=relaxed/simple;
	bh=0i8f4mMX60d7rJPgUIhbt8Yx0sSeapyg+nO6pq/lpEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3BDv9/BYWB4J9d8efU8mmJi32inFI5jBpTiS4Z0XUM3W50VOCVKAk0/uSC6MDpCk7QB7yqDStxVZ8oR3m4+0iuNdEh/AVNB/CBzsz/j3yUi6wIuOqJUOZggu1wjQrX1eJU1UOvjl/JP8UaubZSzeWFJLCTi/4+Ybnqbc+iF2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTzl9pQJ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b31c84b8052so5818478a12.1;
        Tue, 08 Jul 2025 19:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752029280; x=1752634080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtWQmqWvzp7TvFxXJEdnhUttK90Fsp8kAOwv3rc1+9g=;
        b=VTzl9pQJ5guA6RrGyZLAEwt6cadyy/B9DDK0ig31OlGYH1mlVQUZXi0RKfwRWch1Sg
         /h4eQq8vsOYwIr5FAn1z37sPt2Q6BlcCFDFFcCtmdwRr704Z7MBfeqT+W8VncTGhsHxK
         uCDi5lUnzllD5L+NO+3DL8dnwfBJlKbWLVtu9U5kwexvl8XbKRdJ1BECcGHjmpljdc0d
         iB3+V/XM0ZUJGqs/iPJY2OjqDH9GyHOrD5XMlMg3sNykJjcTOwFovUTuuN5JDYKjBzg6
         VYxYtsqSVU4fLmvDv5EHz31EV3V9baQZ4Ik993RkUbPYE1DAysaKI1OFwST33rP0z6zV
         jE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752029280; x=1752634080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtWQmqWvzp7TvFxXJEdnhUttK90Fsp8kAOwv3rc1+9g=;
        b=bCaCaRbiAhReuYf5xXMRMUG8hw7O3dHY6+eLfLUikC0KZA9l3HrtD3+hBNj8sy1pqV
         dV1ev4TLb009/Tc9ZoZ0GlroTMTffND7J4/85xDYtuDd58INqC7nh9bNFmaJ3Z+/dZ99
         g1q8kTrnhnwrf1UmCpUruUsq/0ry2whVchn0vyK7A/3A52WYXkfG9GvtSM4SnCVzVFzi
         vFqYKjxiqYhKxsMJvsm97ac1dvLSbNhXQX0vVpKKaAqzqgV2xiPsZL8E6wGsvoP5kR4T
         TjHSJPL3Us0lMIqh4B5z1ftSQVF7FfqD1hdm9m/UcsqDp5NITmssaKSUEX3zlJEq4SZ6
         1mFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy1fcNNxo++XT9fDl7WHfCzFZ5pF/WGBhrPxd1eZhVLrnIeEAhTOOB+4fp47FiWAm75BM8ck3mkGe7@vger.kernel.org, AJvYcCWeK9RVeSi3mbYxZV9QqPja11titHfD7SCwrfGpRKxiMQZYW1nCCvMAiw0/HkmhTFCNuwk5znCE9cMsV8T5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2NYYkUQy0lVky1MxrZTRItv+6ouf8RGZqVUnay3KXOR8QMP+m
	xkGzr2KkNwJnfYL5k59Q2sQdIQTTJ8T5v58N63s1Ffw2XjKSrVhsckaI2B3sWw==
X-Gm-Gg: ASbGncuPD6I+SHC4zOKOpsssVZWX+57r8Ghz5d5NcnUknCWsTOKKG84Qdk+B++Ee18z
	SRRwgM1j+Qqx/NI3Ec/VmQHK+5yhYVw5aRCi/+8wnh0QXJUcdI68b8o355xiCz1qNL81q+k+6Zp
	RBxcyt+R8FkIS5Jj4nCboTGAnr2CEHHX3jSKU36raXN6DCETaETB/T26PvvL6VmWnxYn4n0ev7b
	Oc0BPgaAZPNrd2A7b4UW7QhPrelJel5ZGlIUhSK8sIvEka2Xp/3cPnYkOsHdP66KYTmJ4jusulJ
	udOuAM1s6KKgUBviUIEZb4/ChLpfaWg386O4PHBa2kgxrZNVRLNaL2X43jZU5LNAEArJrIMBl4+
	AtQhH
X-Google-Smtp-Source: AGHT+IG6g1uUmXwqk+my7sc935bv14xSiO2/qSmLL7bQITvk1oGhT/vKZ8ar1EUYqBMNY5rXhnCtAA==
X-Received: by 2002:a17:90a:e98b:b0:312:1ae9:152b with SMTP id 98e67ed59e1d1-31c2fdd0249mr848450a91.23.1752029279560;
        Tue, 08 Jul 2025 19:47:59 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300b50e8sm535082a91.31.2025.07.08.19.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:47:59 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] dt-bindings: reset: add BCM6318 ephy reset definitions
Date: Tue,  8 Jul 2025 19:47:28 -0700
Message-ID: <20250709024740.194520-5-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709024740.194520-1-kylehendrydev@gmail.com>
References: <20250709024740.194520-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add definitions for resets in the ephy control register.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 include/dt-bindings/reset/bcm6318-reset.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/reset/bcm6318-reset.h b/include/dt-bindings/reset/bcm6318-reset.h
index f882662505ea..33d06b45704f 100644
--- a/include/dt-bindings/reset/bcm6318-reset.h
+++ b/include/dt-bindings/reset/bcm6318-reset.h
@@ -17,4 +17,9 @@
 #define BCM6318_RST_PHYMIPS	11
 #define BCM6318_RST_HOSTMIPS	12
 
+#define BCM6318_RST_EPHY1 0
+#define BCM6318_RST_EPHY2 1
+#define BCM6318_RST_EPHY3 2
+#define BCM6318_RST_EPHY4 3
+
 #endif /* __DT_BINDINGS_RESET_BCM6318_H */
-- 
2.43.0


