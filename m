Return-Path: <linux-kernel+bounces-849027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA33BCF092
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 645C44E2265
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 06:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E604221F13;
	Sat, 11 Oct 2025 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9DMYZBe"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F423220F2A
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 06:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760164740; cv=none; b=Efo8LsD3IxP6LzA0Lm67Pbxp8YVKQa66Uj3VbvzGak3/T6JimQEyNgTzGAkROR2hlW3iBTJG0hm0NPqPrquzAF8dt1DejNahvq2AglP0/d+Wk/NhqbAVEolLkhcDnS7NhI1q9oS+o9a/M1dLQfXt0P9uUn+IbzrI0SdFUEWxzvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760164740; c=relaxed/simple;
	bh=3dRcTgtlUbhprugDzakFjVFYZR+UrtY7GpAYrCcYdq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X0f5hh59J/SANxjPEEr1t9CJkbfHhXkbsVWPCbucKCd1e0vfLuvMuOIP7sZ4JdedlP2b1rlk9MPMeC14aMepBhbpOOd0Jd/J7tFe36KlsMT1vxYtlkVUI/17bjXqzRwD/dZSFclmLKQFxl/eq78j7UjGHj8qC3xx2p1dUrKQxo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9DMYZBe; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b5515eaefceso2356257a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 23:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760164738; x=1760769538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NBMH7or48bro2O5Ot+b/aN/ZaqN/RoCbOtQN6UzKSMQ=;
        b=U9DMYZBetSOS6p0QvmxdlyEqOvO+os0anW8/FM2VM+GtjTstZ220GsznNAf+UxqzGC
         zlF3N7iFi58uUBuJ2D2xyQWwXMCnVZqjNn9FEntVUEkq85i1bCg1ZOrQjwx1wGfZwXZl
         LUUVkwUKwUi9ZKl4yh7R4nkdc2cfi59ojmWvxn2trEO5qoO92Ta7CNmgjn6sxfFHEr+N
         V9MVe8RXuK1xNtep+o0ZrvRlTlLUMB2jajbv1Ks6o0V2ZmjPg9uePmkEhW4OXYmXgQyM
         +j4JHehHL0fX2ie+AZJ+WwGXK+r1cyjCadN7GgtCa818ZhAuJSclKJlw7qcOLyW0Fv88
         E5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760164738; x=1760769538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBMH7or48bro2O5Ot+b/aN/ZaqN/RoCbOtQN6UzKSMQ=;
        b=RY2PbkCNpsqTtlslRP2kg6h6+EYxLnuZdCecQX7pwPe7F1bpFKH7VWEKtadyJMfcGa
         Bxe3pOCG/1GdMHPzB098OuKZDgKJpIvWYdVuyWLqDE3Y/8ID+WNMXdYUGov50wP1WGOo
         K36WK2P+QZao/fGFV8t3HkApWAo0M8Tvka4gJD1zzIGPJCDFaJ4Q/iO1XqXcbM9lRW/F
         lfD6JNUuhv4Mt7u+qnsIwyDnFthV4UxVjJHrToIppzIDYRGe3lQPHa3yqCTUt3s+67Fx
         BHbH5dHVZC0FIJqs0iGEJYZ4pvo75k5WWoEZlEfGN7AExr8j6KQCQIeAaDCjdXuujwMI
         riNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNXInNztEhrIa2GitBHJXsuxwUJUWAKo0a9E9LlV2O9iXJOsSzeJmkz+2Xtypzb94RmEqWqls+fuF3eCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSLZq8hEYrZTP7prnFddhnbOzuON34IxVDlfnzi/u6+Bia5Nce
	NHzMvT180JgRaJdCYk0QsmZ6QApqra7dt2vVr40+92xv4dHLRXL5ANp1
X-Gm-Gg: ASbGncv75oTfGrPpWmprb/8Dqhi1MtXeXRil/yN4gtC8JFsHGNVHWpvFfa6PD7vQhf2
	8C6XmkRc1gufaiNOiCiVrbnJTw7uNcnUsdSHS2iD9FQQk8TDgjP3QNzdTPk+jSGJ7101THdtnP/
	AbouxXk4qEfH/hsDyRzeaCPIfYR/4Zxbs65g0CXKzrzCGipb3mnJeGeNpYRiGlCgdcYuB6g5mZy
	6gsp1pWzrQNIqHuXXqxD56NS6S1EHVR6oJxH1fNqkPdTeOo4G9QX2UIn5oSb2YK2RvYNkLiVuTt
	F/HCmzCrcOq2dgU4DMNtFtr25yJXbnoRagKDaHYU6pRaQJVyYtvQdrYNGQ5b/6HlOD6B2Ocmd/y
	g70ItiYUnq9SVmEtK0gJvWSRKao3SFGVUQOE2FPzzeoBAs0X7UcqUQwzcS3LmkciEywaTIkFAYq
	kfSqKlag==
X-Google-Smtp-Source: AGHT+IGaDajwMvM09IHL0fig5Vpag1YEqb9pdE1rp3FDVkbkCwNkquhqyGZ/Vx6+L31WW4Xx/Zr5+w==
X-Received: by 2002:a17:903:1a03:b0:290:2a14:2eab with SMTP id d9443c01a7336-2902a143b9cmr175163625ad.11.1760164738426;
        Fri, 10 Oct 2025 23:38:58 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f362efsm75647005ad.89.2025.10.10.23.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 23:38:58 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: mario.limonciello@amd.com
Cc: perry.yuan@amd.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jserv@ccns.ncku.edu.tw,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/2] platform/x86/amd: hfi: A couple of cleanups
Date: Sat, 11 Oct 2025 14:38:35 +0800
Message-Id: <20251011063837.2318535-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series provides a couple of cleanups for the AMD HFI driver
by removing unused and redundant code.

The changes remove an unused cpumask field from the amd_hfi_cpuinfo
struct, along with a boilerplate .owner assignment that is already
handled by the driver core and was flagged by coccicheck.

Kuan-Wei Chiu (2):
  platform/x86/amd: hfi: Remove unused cpumask from cpuinfo struct
  platform/x86/amd: hfi: Remove redundant assignment to .owner

 drivers/platform/x86/amd/hfi/hfi.c | 11 -----------
 1 file changed, 11 deletions(-)

-- 
2.34.1


