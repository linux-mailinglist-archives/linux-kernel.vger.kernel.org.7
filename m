Return-Path: <linux-kernel+bounces-892412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6564C45095
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BBA188E29C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954AC2E88A7;
	Mon, 10 Nov 2025 05:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LacHBl70";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFXxq60y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF7134D381
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762753665; cv=none; b=GIXPZzkMzm4YwZgt4eqZEEn9BFs12RJWbUBe1BahWc7n52zlOTxhuf52xETyJXGzPBTkYYrNnTeTGEslzzL2JjhISyn7RMdZOIPgcJUBictKOnfp9av4vkGFmGVNkSZ9GeLpd1u3ozqFNbotLcEFk1f8XroPsLC+QDkl+lBhUz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762753665; c=relaxed/simple;
	bh=YJ3BZTtfcw/RfpDQRx5abrEDF8mvR1AzdIWq9uO4+4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZ3POXXD7XUMI1yY+D/rd+itYo0KFOFQ4PIR240Qq6evgCLLlDM3TudHh30WsLUiruYzEf3d24dw5Hgc7Otng7YuD3pYLKBnu1/Iwn28rCMRi/ZZNgmtBMXkXuDbt9iD/kfbYZd09ttQBopXJwysjCf0geVLOvCjCrx8f0V+cH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LacHBl70; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IFXxq60y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762753663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RQaAl37qZpJp8CXFfUzE16/w8LUDu3uajsmunq/iTJE=;
	b=LacHBl70OVG3WFIAJUKmTg8r2AP9qgUX9zBjs/MCjNTOAcgZml2RR8b6uxaxgQA4AimuKY
	Za9R73a/G6VVcSJw4340GKlZIaoj7VA24exgX9kLp1TC0PAZJHe/axtm495Xz00DDLd0iK
	U/bmGMcMsYvvRZ2TVrGlEsXd/AYvPAY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-aa_8k1NSOQubRnuwySUYBw-1; Mon, 10 Nov 2025 00:47:41 -0500
X-MC-Unique: aa_8k1NSOQubRnuwySUYBw-1
X-Mimecast-MFC-AGG-ID: aa_8k1NSOQubRnuwySUYBw_1762753660
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6407bd092b6so4145535a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 21:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762753660; x=1763358460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RQaAl37qZpJp8CXFfUzE16/w8LUDu3uajsmunq/iTJE=;
        b=IFXxq60yn7NQQgsW6QAwSmGflQY5cR2p2r6Jevbmqipvf8iBKChXoDcokETmnxIJUC
         b/KVytCo2vUHPIHqxy7b/+diIhXxZFpGWUgK4r3Uwu8bRHIuvMPk5vSfiRxxEtgaA2rI
         hRVBB6wxg/I6vqRQtHvgsVlfLxjZfeBA0PM2vPaEnkKNLq+fFWa0jD7hbqw+1jdhpKmr
         DC5zIf+aVp0lnP7h0WG2xZmBIf8Sz377xRBFoCXtlgodQknnbCchLZS1fF2S2O5qrf/t
         mfXrVTUoQoXT4ro2ksyJQQkOFbRkwR5IUWHtYTBOf4iCxFuru7QLSP/L+iaaXpvn+DXX
         kfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762753660; x=1763358460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQaAl37qZpJp8CXFfUzE16/w8LUDu3uajsmunq/iTJE=;
        b=khIsB1uxm52a0swKIIcZB94WmFNMvxKl+Clw6kkW0po/9iUpKs4saaZlp9eFODNjhG
         qNZH7AkbEhjWr/MbqVO3ooksjwDcT7lDPObT8AWMg7l9IzA06U1IM1uU/VoEYw4FHDRf
         0ZoEFPra/e6nNzDFXf8bQVd3k9QhpWLZFPT5GJm7lHtjRly0FblSmkOjQ0CHBzQ8IuUU
         HnRt38sYO2847R9i+TtJmwfjeApNWvExcPy++yS/j9Fcqb5wKy3/EFYopwyjd8x644Vh
         OOTTE3aG9SUdySy932jQbOZQ7srohXjVr3HiXz9k8XCtEoqxCIBgzLfFRK+lvUMZ0L6o
         164w==
X-Forwarded-Encrypted: i=1; AJvYcCWkIAcqodx2vgWK0YRDS9qIRrswPd3f/jzIBLRmN8ZbnrJR93xNLXYdKpknPCyFVvv9XJlVTrRfw+/3rFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNxP5nCg2v/rjFjDVPBm5HJzd6g2kAXa18rEVElWN8RLIcybic
	aUGbCa0Ez4iTWylDMXXDNDD32bSpJM0W8ethJaj7AGiCUSfOjNb6B/u9vOEeRAJi/L4viEZ4pMQ
	dPl5GjmeGGxt3IR66Bk8p9OS16aGcu2Yc8/gjSK8tIk0tImuZ7kPeB8gonGMQDxYC1A==
X-Gm-Gg: ASbGnctWwfC56WDALG+idBHCCg1Wprm7TR5V+5SPcfU/bQkKVJgBb0jOl8TcxY+Ci/R
	d+mOzauv73aYPsHD3WpHktBG8x4I7qMBdE01gu6u878sv99VDF6kwfNLiBlXwhskTJMJ+NH8yEp
	x3IsYELNiVRkmGJrUzgWku/XS55veMC4K1m0HJuIiCvny9EjBPlt9/TMJn8ZR9LayULZugYxYXa
	go4SYNEU4evfx3r6NaDgiigklhjPiW1GXz2nVY1rPoXwHrWuzxRT72eCJQkjSZeIDJjftUYBzCa
	33ABnhzK2EkzKUoBe+rkSo3cadWVDRhnFCHGrHdAkKTAecLI5yxou7gVXi5S23+0sgNriLoNX9E
	m+aptF/Z04We1bsf55OCcA8ex8fdb/EF/IpLub+Y58m7rksyZ
X-Received: by 2002:a05:6402:1450:b0:640:7690:997e with SMTP id 4fb4d7f45d1cf-6415dbfba36mr5698076a12.3.1762753660466;
        Sun, 09 Nov 2025 21:47:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFztFBKZhlPJh2YWtsA5qKNwBUxmLe/vKjcOZksHYngaDToN73r0z6KmaOZay6WJDpaRa9mmQ==
X-Received: by 2002:a05:6402:1450:b0:640:7690:997e with SMTP id 4fb4d7f45d1cf-6415dbfba36mr5698062a12.3.1762753660148;
        Sun, 09 Nov 2025 21:47:40 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eabsm10365924a12.11.2025.11.09.21.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 21:47:38 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Job Noorman <job@noorman.info>,
	Frank Li <Frank.Li@nxp.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in HIMAX HX83112B TOUCHSCREEN SUPPORT
Date: Mon, 10 Nov 2025 06:47:33 +0100
Message-ID: <20251110054733.441893-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit a311c777f298 ("dt-bindings: touchscreen: consolidate simple touch
controller to trivial-touch.yaml") aggregates a few touchscreen yaml files
into a common trivial-touch.yaml, but misses to adjust the reference in
HIMAX HX83112B TOUCHSCREEN SUPPORT, which refers to the removed file
himax,hx83112b.yaml.

Make HIMAX HX83112B TOUCHSCREEN SUPPORT refer to trivial-touch.yaml, in
order to inform the maintainer on changes to the device-tree binding
relevant to that hardware driver.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 982998ec1134..2a881629003c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11213,7 +11213,7 @@ HIMAX HX83112B TOUCHSCREEN SUPPORT
 M:	Job Noorman <job@noorman.info>
 L:	linux-input@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
+F:	Documentation/devicetree/bindings/input/touchscreen/trivial-touch.yaml
 F:	drivers/input/touchscreen/himax_hx83112b.c
 
 HIMAX HX852X TOUCHSCREEN DRIVER
-- 
2.51.1


