Return-Path: <linux-kernel+bounces-838254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52255BAECE2
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 01:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FA91752B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA4E2D2496;
	Tue, 30 Sep 2025 23:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGQYkKoC"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B5B20FA81
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276402; cv=none; b=owUcHWW13dPQ5JUCPXHErnskV0IqapkWzc9PqSUxAnIwx2Ijy/SXWaMT1kRpiqmbYMizm+JRRBmSdy8vK0OomfYGJno5VOw7xlXZ5Yd22IGCBJpVrsXuwgUXLBzSVnWv61oM1KzMUaGZ36PX2e2bztzVUeoif9S8OfjEycegOcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276402; c=relaxed/simple;
	bh=fnzDnGDIEr/7xnTBEXTbXV/eznz5SUL2gZTYfAtL/GU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HdYa2FimUe0OdB1VbI6QpTVDcv/7HauF0OT1/yfJJYosemfUTfjdGPIgT090XICwv4KqXy9O5B0tv7YlL0ocHD+miVRU3T04w9MApW1ZgoqMtfPnikMhNq6UQ7y4/B9f73piI4OD53BjLSVYMnpyUFWEw208MzyAqMKXmoHaB4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGQYkKoC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so65502015e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759276398; x=1759881198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WgLRO9js12XB310Ohs2cmlzDOh4o1hts+MVrdeihU4o=;
        b=EGQYkKoCZE+X0yGP8xj7iqgpCf+XXWY+MDkKgfcGXC6rmfPiqdTG3Lz40foCCRqcVN
         OX33R8p2sVHIeD0g5SnDJOFt2XZvsRQTjdxKwG+nuMaUVlO15JgVuz8qJbRK9aoTe4ye
         1OBCAbd1CQc/XfcqD30Awj8326ZMSxYB6OTzdI7iAy/A7BltyicWgncrTuof4/odQQmB
         DEZIMyuxltc6mLC1BdchjdaH0CAkxYTAcpl2IyBpmN5HR7+SpC0cLthRMq1tL0Pf07xU
         030+Xb/dKeofH/AuGeNs/AQysrzpKVcHD7mxfnN9iGtxL6SUnjtKWN7Zh23fOKgVURFv
         Ppow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759276398; x=1759881198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgLRO9js12XB310Ohs2cmlzDOh4o1hts+MVrdeihU4o=;
        b=I4u/tSXMUU3VJM60hJaFJoBBxzQUrebosRLzS4o68FUDxqQcoZ1C8eGyKKZzowv7RL
         Kpup+hZAxR5UZr4Daugcnoi8aaa6hpgZBIzVsagj5yF3/zcUXpHE3n1ksGGDrUk6UGvN
         OTc1WDZ4irygAcs97va6VMvsFR6nZyqU80IyHcREs9g+rJLiL2AFrhZnbjEb1qTPw+BQ
         +lcwWvkwAXPEFqaRfVCHLGFzWlZceVt50kEObK7GWyGfUvXaNxCdT3DLeS5TfuDkPUz1
         AkfCaDPGmMuOb2A7C2TpBzN0YR1JNrkds1ppS8+RQOI8nn4u8NOzwKrlckAUzBfdZiIm
         0tyA==
X-Forwarded-Encrypted: i=1; AJvYcCWIirt1caX3GbVGgDvqjcFKPBpzdERui0K8ab9cgnJ6+A9CuUDQoTyJkUbc0nseYg+RSZ4i4zemdqvmU8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YykrLJUH1eKGxS6sZXaiaf+aYAFdG6EV7/4lXPF+pYe1HYKI618
	KFFJ2rCHcCaxDdQ8vAbnJZV52aUXBkQl0ugHOLLjwwhsH5eNCqQI2WV1
X-Gm-Gg: ASbGncs4yD/YLcY0VVVJgiyTmRnOYIzZsRIhY4ag7gpjYuv+2x4n7SdlEpjWIhOxkIq
	Wb7OUSYK4DPzS179qnkYITG4IhVOJS2lJS60ZEf/593zVwKYyEtiYeH2YRoh7KHpbpu6We/vRvL
	Zt5nO7xAP6/kGGwO67yXpml7iMMccyLuWGozUBF52/jH9mwxmDKecMcsKaDXIVfmBwTqaECTQB9
	yflKIpwVp368pxnSCFxeML1hqEHUKrcEJcF1VheI9mM+gjsb3TNixsfI5Mo38e9y9uP7Bbo77cE
	aT2ewdv4cyMEaIq52LEUpJ5aq+o5n94lACQFUsuO6NnJosOSTbwnhzcQGg9OMwp8iqiasVINGA4
	8H+eq07XXp9sXtCasdEFMLFRy6hjTGhBgWyb8MzIUTo2qbC3zrAIPLYiH06S8rPr7/VQh1uwG8Y
	RqoSm98W/BT2viCOax0Uj7hw==
X-Google-Smtp-Source: AGHT+IF9DcVEOSJoK4GyZ0bNGFNGz4ZtdCDXCKLDDmF3uZLhdPpyHjUsCyZasbXoPEK+ArB85uSZUg==
X-Received: by 2002:a05:600c:6306:b0:45d:e6b6:55fe with SMTP id 5b1f17b1804b1-46e612e54acmr10245825e9.34.1759276398455;
        Tue, 30 Sep 2025 16:53:18 -0700 (PDT)
Received: from f.. (cst-prg-21-74.cust.vodafone.cz. [46.135.21.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a020a3sm12744365e9.10.2025.09.30.16.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 16:53:17 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: assert ->i_lock held in __iget()
Date: Wed,  1 Oct 2025 01:53:14 +0200
Message-ID: <20250930235314.88372-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also remove the now redundant comment.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

verified this booted with ext4 on root, no splats

 include/linux/fs.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9e9d7c757efe..4c773c4ee7aa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3368,11 +3368,9 @@ static inline bool is_zero_ino(ino_t ino)
 	return (u32)ino == 0;
 }
 
-/*
- * inode->i_lock must be held
- */
 static inline void __iget(struct inode *inode)
 {
+	lockdep_assert_held(&inode->i_lock);
 	atomic_inc(&inode->i_count);
 }
 
-- 
2.34.1


