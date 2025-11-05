Return-Path: <linux-kernel+bounces-886208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8A9C34FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B68B18C15AE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A8C30CD92;
	Wed,  5 Nov 2025 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbX3g38o"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19930C61B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336613; cv=none; b=CgBFgPgIN9FIbpxf42zgkR6KxfjDD64aicBhPefQl4I8LGkkBcgDfa79yabKvGidFaEt6L9Hf/8+F8uYZGAumhPPiJcHIZJQAx49XfLeloe5eJBY3cuDLEzIwj71AsHae56m2vB99EOpvGuLqLXKqATC/5ohr7C2qIfWshQVVV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336613; c=relaxed/simple;
	bh=uhtPyUARMh6iqTL6T+FkCm4KL2BKQJC1wSSAlBNThFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eqbK61ESqOkYe0lX8n4Va/65s4uNkQGl6YMbgdrgS5RsL6xj7FW8GCZ/ESwKxp5eycpz6DjLClGSkRCmWEPti3G7Uq7M+iKKYobtUy9nST8gr+UUXWhMUZeJZ7WFtcs1C4mVPqhcqxOsYRW3N3WcWO6v1YFyM+CsggeC0r26xAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbX3g38o; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b70fb7b54cdso352522766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762336610; x=1762941410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTXisoAd0Dg/UVvUO2lIGrX9MKyF/plfDMYlzBba5Os=;
        b=IbX3g38o4MXh/ekiru+AyASGtD9LzwWr9rqRBYu59cIgSdr+PXQahKBDYXb1dYIdeC
         QY9XqjFgJwmBvEzNHB0UqGcFeBiZw3EX8p5hbGjc1RxcVo1XU4qsdpwrbt1B8t00Nv1E
         AuB7+L9Dl5DAIqg03b/BU9gzZTpR0Z3JTCSLzZ7MrGrpthS0fnrvGs4+MRQslEt49o8A
         ZFj11QekNKJAwG/LWI6sRpRVrYxGTkyPYh21wOfZgLGgv54a8PWNjsjeP+bqKA3OGCTW
         4m7VutICknd1LehaVvRyxOIXJf65JKJ3RcCxdNPjO5OeiWUPGAQtapLI35Qc5dwLwyyf
         gN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762336610; x=1762941410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTXisoAd0Dg/UVvUO2lIGrX9MKyF/plfDMYlzBba5Os=;
        b=QAlgc6niSggdD2JRDyXo1BrbukCE8dK+U9ZHonZrh6PZ+3WVLXazXD8V6Y6znhdjpk
         BoZg97QNHxaDQo+Fvx6rnfnTgruXs+5lvAhfH8CBrIZjW+GmPanOfmk4yRzSsg/V9VtV
         ilxncITbNM9UGnTTxeND3EGlqcR/cU8tI5hX+wcujh3oIz9ZFrvsTwmvZq3pUYR7bylJ
         7iQZn4GY/I489O9DGHAoTYDEK4LykuX9O23wZsPFYcAoHDTyB59dwVbCK+vCZmKz8aA4
         mv1Fr55uyMYEIrC0bg7xdcFq1nzeMKaYsVQOrdi5Vy5KchhWJEGM8JeoKlPzRLPxHkYo
         7tBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt0/nsDCHz/QjcItF2em9N2mxNNnN2fvV7gwN49ypJspjBgIymc7DwzHYe8ltwJSgpaGhic+tHc69o3Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJLVf859JWK8/f+IE7z0+9V2V8XJiV7+2XJNBBXOTJDT+HmEil
	45m9OZnhKr0gtAiQcuZppdVZqg8f0e4B/i33s8Lx41N0XJmkEYAw7i4u
X-Gm-Gg: ASbGnctEqcKNNgsWRiseAzL2D/iPa9LKfimzWUb+VnTg4XAR1U6GoPySbBTI7WPaBxQ
	2b9cqwk3IZAI1X092FpCFPv5hLIEwLcPxOJbWKrC9b1A/xtxuRhR3P63E/QEed1JeTyr+zDRLqJ
	YL4I37tw/YL7lk6BqsHBhQvcFhZxELwNvD0ILB4JjrEh3r2DEsvDhRHjKm4aS5PtC13QQ05x/YH
	kK/oCpqvtsaX47cbNxzL6pCJvfQ2G93hcWCG5kIrF55O65ZXxbUr+6vtU6nJhAK2o5hny35oNZT
	3l/ViicusdQTbEWSdgKA8VPBZDI0h05W4sJN8hac2fQDWrPyQ1avz+8SCYGbmu1kiRyxCSdQQDP
	0F60Z9/O3PSAcANQbjqQHGpdRC/F/OnifZqIs8DNy4xMVhikCbwT2NtgWw7LWDTF3grnPA91D8a
	pB0r6ScQMWhJVY1CkZkM00KJhm7SQ=
X-Google-Smtp-Source: AGHT+IFQTND/jr+bbPyDxEQ0kqsa49/BgX2lBGe838P97ni4aXWpdvc+e2txxEZO/Dgut5ldnfdwGQ==
X-Received: by 2002:a17:907:1c1b:b0:b70:5aa6:1535 with SMTP id a640c23a62f3a-b72652a221amr254518466b.18.1762336609662;
        Wed, 05 Nov 2025 01:56:49 -0800 (PST)
Received: from localhost.localdomain ([78.211.196.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fe37b7asm440266866b.60.2025.11.05.01.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:56:49 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3 3/3] iio: ABI: document pressure event attributes
Date: Wed,  5 Nov 2025 10:56:15 +0100
Message-Id: <20251105095615.4310-4-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105095615.4310-1-apokusinski01@gmail.com>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sysfs pressure event attributes exposed by the mpl3115 driver. These
allow controlling the threshold value and the enable state.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 352ab7b8476c..5f87dcee78f7 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -898,6 +898,7 @@ What:		/sys/.../iio:deviceX/events/in_tempY_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_tempY_thresh_falling_en
 What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_pressure_thresh_rising_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1047,6 +1048,7 @@ What:		/sys/.../events/in_capacitanceY_thresh_rising_value
 What:		/sys/.../events/in_capacitanceY_thresh_falling_value
 What:		/sys/.../events/in_capacitanceY_thresh_adaptive_rising_value
 What:		/sys/.../events/in_capacitanceY_thresh_falling_rising_value
+What:		/sys/.../events/in_pressure_thresh_rising_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
2.25.1


