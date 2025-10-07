Return-Path: <linux-kernel+bounces-844796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB001BC2CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 23:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 849F734FA13
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 21:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14B32550AF;
	Tue,  7 Oct 2025 21:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7M0g4DI"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E530246BB2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873920; cv=none; b=Owb5WOaTSqCZYUUyFjLiQymghM8gK2Gz0c3uf0lzSsfr0hg0qxhIgmxgVBBSWtlbTmlysm8GAcqthcj8CEkd5YdCTH208yIySxzBOO3cRmP0ewgLzotCGEKqfiWNYfxwv5duYezoVlVoS62UOW2bPsxYFJTrqivrEcl+pM+m730=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873920; c=relaxed/simple;
	bh=QDGRau9hUTIw0LmGZxQbGkUnm+lvJ+Sc5cUwuswn8gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bN8K11FjImgQ2HAyKYn42O46z7u2T0DVzRwHq8sE7vpZol5hMWf+NjAWE/a8SBPrjWvZEtf/JXupT780yTCR7NXYVFLZ7bZp3sKKSIXzjT8KxUq+iHrzz2HglAglJIPDZ+eDbQ2/gu+iB5OuOllX/g0hORjxn2nboAztA0f9C9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7M0g4DI; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-85c66a8a462so967013385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759873916; x=1760478716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zspedv/g7MbmKhSduq0BNA8/CtYiYE9VtM2LqWSPvok=;
        b=k7M0g4DIQmPLKKBSH2K+BRrIRpBxar64hq/OqbP+UATzE/JJfPvQS4t1Ze2Hah7poU
         0cH4ptnxaLZj++AWaZI/V/K0zFZbcR9Ft/afHqqi6lOOuScrevHhwOu4go9DhgiaNkbK
         vvVGQ1PZBBqR1HQIFzIDqKRZ5V4KYjZHQgy1oFd/YIwcWH0P2tBOCs2cWf7h1MAB1O6Q
         b7LOPbf87PkTxujCPEb/iu4caC/aHieOGlOlFplYETEtzSFZNzxMW9Zh+RiClbrUCUDu
         wVPbGgbhCXtA+FAtRg2Oab7o82VyizOw+tjNur1+6MX+oAhSHGwWQCSqiCgbTlr4aY0r
         ATQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759873916; x=1760478716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zspedv/g7MbmKhSduq0BNA8/CtYiYE9VtM2LqWSPvok=;
        b=Q1hotghj9EzdfDpjnKmggBLpcK7J/lhhJZdrlcQdCxXhtlrcSQabtgqVaispinqxO/
         WD/Pt8wC4F/TRbAnSLxcP76wceIxLOKLbzT1s7uAyOyyWgkcurXNAiD6Pnad4YZU0zkm
         H5Pgf3qatnq6Q1vOwgegUJfAMM6zjDtfFMdrBpuXvhls9IzFEqN4IUqEc9PuchKS/8NR
         6TTkahvhl7QrKxw3Lo5lr7424/P01VWvxy9mS6vorC8KgjuS/1AlgPKrtmhAkdGnZxId
         Hg7DRDlfM2qIzxwJWhX9lHgsAsoRv50Xi85GK+smGAy/psxMtZkvfEjGe+Tm0aXuBHRG
         DsPw==
X-Forwarded-Encrypted: i=1; AJvYcCVW7qGNVcfIBZhvYOPaeTb9fyp7cafHSOlqPFyKjZvVLh0EFVGrUS72vgkgnojuw71gZR24g4s7ZbuK1mE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxy1HxG87vjpVT4oPvMEFfWOMkPVt6p1X68mJHMu4s3iP0YDqk
	Bb00XDrAlvHmx5iCD/sr19UWvgpo2FE6qbJNVkggp6+vYX3ntH4lDna2SrPHhCypMsg=
X-Gm-Gg: ASbGncu6oMdQXwWpQ2ce92qSTOSDZMyTgsUpmuAxwn5bPgVw6VJ/0WVeezQP8wJkg8N
	ibb2HDbtpYx/Zwgpe1vymCULqfqZTavdcI+vEIirAH2l/sIM/NOa/ptlFqeKiClN41R6LhL4gR5
	N2efCeIwYQiNClUujhn8QllmTmc+RcipqTH8mdO4knYhVZV5cSTkcRLV2e+84Ux0IXkUk+AqDOa
	KsnG0yVhXdt7zrRex22m+K/08QEkTT09bnpnDbDWjWKR5XdFeCrH1crfxXld2jlpp4uw7UuJr6X
	tfZH9F+vym7zbdr7JTguffA2p3QV+VjwTbwflxW0WIZ4HPcu81TslCdvFrm3aPgdX3/relr/Jnt
	/Ba5owcdEtIe6wTcw3RJJJeaqQ5NSzz2aVo2a+ISoiS3Fo0w1NZJEt3T0nbwf2/GQglRZxr/q9g
	kDWcuHSeG2a26/VXxITfwbqnOravRneEg=
X-Google-Smtp-Source: AGHT+IGOq5pYG58K8mMoqQOeJGCTbi6ZyRgh8XgbbYFkzRFf5ylz+GiLTUem9QZ+rZgBYEWJ1sLt5w==
X-Received: by 2002:a05:620a:4807:b0:84a:568:b7d3 with SMTP id af79cd13be357-883546e1a86mr163438385a.74.1759873916127;
        Tue, 07 Oct 2025 14:51:56 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129fdasm1618199585a.6.2025.10.07.14.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 14:51:54 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Input: pegasus-notetaker - fix out-of-bounds access vulnerability in pegasus_parse_packet() function of the pegasus driver
Date: Tue,  7 Oct 2025 17:41:32 -0400
Message-ID: <20251007214131.3737115-2-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

In the pegasus_notetaker driver, the pegasus_probe() function allocates
the URB transfer buffer using the wMaxPacketSize value from
the endpoint descriptor. An attacker can use a malicious USB descriptor
to force the allocation of a very small buffer.

Subsequently, if the device sends an interrupt packet with a specific
pattern (e.g., where the first byte is 0x80 or 0x42),
the pegasus_parse_packet() function parses the packet without checking
the allocated buffer size. This leads to an out-of-bounds memory access,
which could result in a system panic.

Fixes: 948bf18 ("Input: remove third argument of usb_maxpacket()")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 drivers/input/tablet/pegasus_notetaker.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 8d6b71d59793..6c4199712a4e 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -311,6 +311,11 @@ static int pegasus_probe(struct usb_interface *intf,
 	}
 
 	pegasus->data_len = usb_maxpacket(dev, pipe);
+    if (pegasus->data_len < 5) {
+		dev_err(&intf->dev, "Invalid number of wMaxPacketSize\n");
+		error = -EINVAL;
+		goto err_free_mem;
+	}
 
 	pegasus->data = usb_alloc_coherent(dev, pegasus->data_len, GFP_KERNEL,
 					   &pegasus->data_dma);
-- 
2.43.0


