Return-Path: <linux-kernel+bounces-861241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C11BF2279
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4B3C4FA71D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5671026CE1A;
	Mon, 20 Oct 2025 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="pMIrPz/n"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F68E26B942
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974697; cv=none; b=AuCOl0skl03vriEqrLBFG6ASYMYZ6zPaCkMTnTchHm2HiKukCsF9ZgFgBYZMbmE1bH/y80WUV1dDjKckdm4fJpWDureCP04jP9GY2U4JCPPF9zKAT+c7Yiy46zAC6YOlKOJ01k/QuZTyX3gfOfbpldP5Wi2QpAmEdZdL0GM866g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974697; c=relaxed/simple;
	bh=4Gn9R0aTjPs5l0ki4rUGt4tVd4RPiNQ5UPjgvg6b9R4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UAJ/VJu1+dL+ddvNx8Z5YAzjDVnNyptApnUuL47/q8UuHQsQEB7NffKeQjT/YTXvyqxo2EEMfRgjEA/Me1NJ1QHabxvhHiYHuOcXUGGN2VLwOFfH0Tvq8FLG4vBPB7mbbIHG1cTTLrYIn5sJ9e5w/BfUZo4IeCA0Jn+muXbZjKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=pMIrPz/n; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so42517695e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1760974693; x=1761579493; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+XrYXLK1FVfs/nOKpxVQaiFAr1Ow+MNITWBLsHoU02g=;
        b=pMIrPz/n/R/i8/E2uosAiEw3Taj190ijIszyzP3M7xdy2RihXzq4Qtvgofg7iYSHhv
         VX1c9wkBf71zlq7r3rT6Lbw2B/6LFULViaAotJVgCFEPFxeniOxFA51KeKCe0AAERd9S
         wX2ZGJCTaWzMAyuZKNzRrI+hRWE2VL1wZAdbu5kKmMlyqMhOmd0FeCicY8HFECTXcsjp
         5KbVcEwGp7YMsrDwUbeKc4p0lTGUnmkfDsqt8kBgzCvDdWbxp7t2SX5qeclgt/iGPW8W
         2Bzc5b2fkprK5Dvg5dfXab/K+83WqOhfTzGF7czr+EIHBAj1utV2BE2nRDYJyQomw4nY
         UZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760974693; x=1761579493;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XrYXLK1FVfs/nOKpxVQaiFAr1Ow+MNITWBLsHoU02g=;
        b=wejHEuVOpEsdhAKLRCmGiqYnLpp2PCJFUdDXKrMMeglekqMk1Oke7cJJ09a//yB7Y4
         KkluqIoCHpw9dR7M2uVYqCvUeNDMuqmvnslvVUyG/u/TemJ+fYcS4PKAJxQsEGuYeioR
         nahox0a8swrzzC9KIbvYVdlqWa25+Pi3cQW2+JcHod2g+P/6Fr6AIai5fWdsCcHhK1Sd
         gU7Oet5oMsjedrSg9zlc9sbpzpcMiL0DUG7DcYCkjXr7goLUAjyAhG8jZP8tMdS4oRVR
         Z+aUla8JXEgV+1Zck+KAz7Ogkeq9MuX3Dnan6j0WYYHHVSkhgYqLkCSCqH0qgXnrmlJR
         pnyA==
X-Gm-Message-State: AOJu0YwmU4ygb9hE5fu9OaFeUksXrA0sYys0hSqb56O0sEo9lQc7tN4w
	lo62ayWn/AMCZb3nW7CR7POUDwbbSZtEZFl3JkacP+SGt1917KkKbMNgvW8fLLmmxvuhQ7vzd2t
	otx5CO/lAeS5p
X-Gm-Gg: ASbGncu4hn28H/bX0zR6ltHVd5ESdXsrSWJaV54/JXB+JDZWdk1rGll/WohqegDVfUa
	vEOlf5AUjWqvmQ9cTf6Tl8932LVsAUQ3CmW8TThipbklvpIMf0opJaWfV9gSVFNuRUN8ah5ZKX+
	0F7CyIiaTpqDQAT6hRPovNy/DCrOCzmMchtrCrtwWiIOkcj61kd8LVFiOuBF4LjlxNaKvliwXqR
	0NFvKSUCwodJh5Fco9NTOFj1RwarXeq5U3kjVFiqutdnBZFYpGShYkxGv0zP+9ngY2nM0gYTgGG
	AoX6Zq6cMwDUOsXPZMPKdCGc+HcnnraMuL5cnBd9g6PKLWSjrRMC0ZOtH+q3z0GrGf1naEcXKM4
	wibcTAI2Fiw4Kh+s2RA8d6oW1cKM+SdY1LFgtoHn5fqvPxERHmigYDk3e0GlhKsqd0UQipGYfI/
	yUxU2ShaDsbMp+IcThRyjO7jvQ
X-Google-Smtp-Source: AGHT+IFTjy4zMKFRhSx8SfTkGkzermkNqjXCWKMsgHb3M7BdlNyC7+80Wg0L9u3CvDmZlwnsJPyZ5g==
X-Received: by 2002:a05:600c:3b0c:b0:471:669:ec1f with SMTP id 5b1f17b1804b1-471178785e1mr100893535e9.8.1760974693320;
        Mon, 20 Oct 2025 08:38:13 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710e8037aasm120631405e9.2.2025.10.20.08.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:38:12 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: [PATCH v3 0/3] printk: Release console_lock between printing
 records in legacy thread
Date: Mon, 20 Oct 2025 16:38:04 +0100
Message-Id: <20251020-printk_legacy_thread_console_lock-v3-0-00f1f0ac055a@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFxX9mgC/43NTQqDMBhF0a2UjBvJj1bSUfdRSojxiwYlkUSlI
 u69USh0UnB43+C8FUUIFiK6X1YUYLbRepeCXy9It8o1gG2dGjHCCiJojodg3djJHhqlFzm2AVQ
 ttXfR9yB7rztMNStNISojBEHJGQIY+z4+nq/UrY2jD8txOdN9/erFCX2mmGDD8zpnSlS64o+xh
 cb7egDXTNZl2mdTh/ajmf3grDyDs4RrY4QhN05Kqv7g27Z9AHAZ5vY6AQAA
X-Change-ID: 20250914-printk_legacy_thread_console_lock-1c27f59bf990
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760974692; l=2078;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=4Gn9R0aTjPs5l0ki4rUGt4tVd4RPiNQ5UPjgvg6b9R4=;
 b=jpMeWdaSV2XS2+tOCijvYMJjMsII3fK+w22MG3UPES19Jd6QwNG90fmZZATmmMf+kDP8iHKwe
 jcxZWnTl8JyDIxv8CmzIUk7B46uU7gVqX5L7y+ES1TM2d2pVHDuU8TP
X-Developer-Key: i=amurray@thegoodpenguin.co.uk; a=ed25519;
 pk=0SU0Q8S/uEiCdbXbXS+PvJGUCaBG1nDszD+HPU3Js0Q=

The legacy printer kthread uses console_lock and
__console_flush_and_unlock to flush records to the console which
holds the console_lock being held for the entire flush. This
results in large waiting times for console_lock waiters
especially where there is a large volume of records or where the
console is slow (e.g. serial). During boot, this contention causes
delays in the filp_open call in console_on_rootfs.
   
Let's instead release and reacquire console_lock in between
printing individual records.

Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
Changes in v3:
- Rebased on v6.18-rc2
- Reordering of variables and minor tweak to comments in console_flush_one_record
  in first patch
- Improve semantics of console_flush_one_record in the second patch through different
  use of return value and by replacing any_usable with try_again.
- Update third patch to use newer version of console_flush_one_record
- Link to v2: https://lore.kernel.org/r/20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk

Changes in v2:
- Move any_usable=false to console_flush_all in the 'introduce
  console_flush_one_record' patch to match original implementation.
- Add Petr's console_flush_one_record() code cleanup patch
- Open code flushing implementation in legacy_kthread_func instead
  of introducing new console_flush functions.
- Link to v1: https://lore.kernel.org/r/20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk

---
Andrew Murray (2):
      printk: Introduce console_flush_one_record
      printk: Use console_flush_one_record for legacy printer kthread

Petr Mladek (1):
      printk: console_flush_one_record() code cleanup

 kernel/printk/printk.c | 186 +++++++++++++++++++++++++++++++------------------
 1 file changed, 119 insertions(+), 67 deletions(-)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20250914-printk_legacy_thread_console_lock-1c27f59bf990

Best regards,
-- 
Andrew Murray <amurray@thegoodpenguin.co.uk>


