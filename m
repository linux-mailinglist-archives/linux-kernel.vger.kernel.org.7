Return-Path: <linux-kernel+bounces-872481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AC3C114C2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CEA4464FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ACB2DCF46;
	Mon, 27 Oct 2025 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYXtKJHs"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F83191CC
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595130; cv=none; b=cz1zbGbOWpXPbajnegs7XysF6Z/bo3F7xYD+GO+7OVAfOZbz91hcks1TLr22yduSezLjR5x++XWkJNsr2zQPlOIcV5SGGrY03by3wA4828EbbRSRxPGNfMptKDBQZfQevKy0WjA9MB7dPVTYcIhlfi+/+gtLsfFlESbif7CXN2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595130; c=relaxed/simple;
	bh=BZAMu1oHu0FAo/JjzkXlFAe2wQUjaV1a3CnBnCROdY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAaBErJbrIpPox2prQvf6Sy8BWGdVNB58dwnlUs6YNtzvSP9xfCHdEkbLw13A2OH5DZAxjiKWTa/6Wtyd1t0PVwdFW85efPQ790Nhlu0H7TIeYsP8guuptIXN5lx4deZMc2CYMTe2HiE0G84rNaGWZ/WkAjyWVcXxpjUV8cVDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYXtKJHs; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-430ccd45f19so55043375ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761595128; x=1762199928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYatPSd64HPpUGouUUXNhRGsgX4uRfvZpmNrkJocNvw=;
        b=cYXtKJHs6ldQtGoW8EYO1JAH0UjOaoObpgxymdkIvjN3szuqkYD6+7hM2LGrrEBce4
         poGaoEAeafC9gphJTT7zwe0YVoeRojLaSvCpKiZJsra/4Era62j/uuBQh8DTLkt6BrOM
         ray4e3vRa92jYbGazlQbarQDVefXHicCeCxrJKixg7lkjmxrG0ABui1gifjxeUgTrr3L
         U9L8oqpy7CdfOXFu2CBh9htZtKCs7vromQXJkXDxBTutRb4FNxzgGt0tRxfe08ZZ0ac/
         6LAv08K7DED2gxX6PZ7GQLxMfoHD0IK28/94sINQ712KbwFd9XbbRM5dqLU1v2C/Bpra
         hgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761595128; x=1762199928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYatPSd64HPpUGouUUXNhRGsgX4uRfvZpmNrkJocNvw=;
        b=GXyL5nOUry6eBWZm0yEcEkm5oWA6147RgItO+DoNm65K/ib0oTSxdHqqE9dmkuIv5N
         DxNsQ6UhvjsfoS4oQPiySetT6ssK+Np/AS1aQdI+TdHnbpXQtoZcrAMGlwV5ChYwnmhR
         rO3RrBbgzJVQhDMIPHmVgFoS96eL6oZeuuVvpO4JtOpHTEtHzCYQaviF3FkcN4/XNyxk
         insuzmg1JJRS8D6WapgnmxHgKoTiXrUxeNz/K5KTXhxz0iu/wisM+/KS258E+MJ/w9jX
         cbX0EHt1rl6Nor8Ie1/xZXJFpxmlk5lQ4FZteZMnM+DQmCppafTgG0KaQ6SRDNm1dhaa
         qFbw==
X-Gm-Message-State: AOJu0YzO6NMpFHDB5n6FbQ4A2NlWz42m0Bd0+R1XLJF02oBBUOmBBJz6
	dkQEJxwRQZ8GbxU8BAeCpIMDLftPXn4Bed2EcQm15My0FNbaKGafmdEAIrjLLL1GGHY=
X-Gm-Gg: ASbGncuP1kaipDzZcrAfm1pKYvyAMXnYn3nWBTkPnJ7ljVuqFTxWDNGYa4foDcRBBCF
	TOs8ZiqZ7bpdarGvYlZNqUIXVXlVBkXsWuQMpeGvJwpwf1k5h3rEfEPp13vrJQiv/I0f1DqlKGf
	m0mNeocX1ywr0GcRH6L74qjT6Mz3ohpt+5o5yMnlMZJSqVcJKkbyCXhB8ocsN7sno3s0vLfo9OZ
	qmYW/tU2+8KFUFM+3zP1iiADaY6lqtFttn4TFEDxKlidfRJ0k0Y5O3zAR6UDiKQd3S68vZjNuHG
	KeQGNHl7iGXnyilHB0a3l21yT/t7+goVji9nmSrreyGzF0J1n/juQ1lkfRoYwKaYGQdD8VvY/ny
	tyB7R6FqwGu9hAeeMLlqIT1nfPk7buhZg99dfH99ufoD01v9nJIct6lIVN9/DUiaEEafx/kjn7g
	oQnywyPuHqIN1ln/H+t4SWQHYrpu6Tb0vMHhe5U0HqKJ8q53opvI8l7MEAJ5chvCo=
X-Google-Smtp-Source: AGHT+IEkTfSZCn7CNOjQuB1y9+Tg4K2UtnkiV7xpyYLiudbMJCZ6ETdnYK6ETtCF4JjQpHvmSwYWPQ==
X-Received: by 2002:a92:ca0c:0:b0:430:afe4:6a4b with SMTP id e9e14a558f8ab-4320f77080cmr18452315ab.19.1761595127885;
        Mon, 27 Oct 2025 12:58:47 -0700 (PDT)
Received: from princess (76-224-4-192.lightspeed.clmboh.sbcglobal.net. [76.224.4.192])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea9e37cd4sm3482853173.60.2025.10.27.12.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 12:58:46 -0700 (PDT)
From: Ben Hoff <hoff.benjamin.k@gmail.com>
To: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	hverkuil@kernel.org,
	lukas.bulwahn@redhat.com,
	hoff.benjamin.k@gmail.com
Subject: [RFC PATCH v1 2/2] MAINTAINERS: add entry for AVMatrix HWS driver
Date: Mon, 27 Oct 2025 15:56:37 -0400
Message-ID: <20251027195638.481129-4-hoff.benjamin.k@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027195638.481129-1-hoff.benjamin.k@gmail.com>
References: <20251027195638.481129-1-hoff.benjamin.k@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3da2c26a796b..313ac53f647d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4128,6 +4128,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
 F:	drivers/iio/adc/hx711.c
 
+AVMATRIX HWS CAPTURE DRIVER
+M:	Ben Hoff <hoff.benjamin.k@gmail.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	drivers/media/pci/hws/
+
 AX.25 NETWORK LAYER
 L:	linux-hams@vger.kernel.org
 S:	Orphan
-- 
2.51.0


