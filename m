Return-Path: <linux-kernel+bounces-778718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E538DB2E960
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C771C861E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9C81AF0AF;
	Thu, 21 Aug 2025 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JINUF67V"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4B2AD4B;
	Thu, 21 Aug 2025 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755735718; cv=none; b=BxFYeD2crJVmprVPRxCpbKE2/9I4NjjDPPdW26PtVNYMrOBMbovCgmu6Irk8scZkI9cMJWpU0TSZTtLN3OaDm2VKvMIidUCscaw99pse6lwSdBhkdjHMI49Nj5WxO4uOhl+sZ0poDJjKa1rVYP7JAeiXkoCeJzT76EGAarWou9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755735718; c=relaxed/simple;
	bh=+2p2NhAawyOrqQqF94sRztES/YOdSvzxma3TAMtDO0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IdEXak1rVFJDuVe3JEH3IJGF7jcVB94HVXw43UdfTtZYLbBuKCy0KqlHSfJVi1W07c8Q/1XTTGyu0gJUsPFvu4/W59pUhAGcM8XraAF9c4MHKnCBWuioGiPdjO8koQBxhVEfSiZp6YypWD/ELa/QpHagWJ7kYjsfiFYXc7wYDog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JINUF67V; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24457f581aeso3054995ad.0;
        Wed, 20 Aug 2025 17:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755735716; x=1756340516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TSzXDMgFLbcT7snT7dZNu/JvQUzsiA/Nht9HMTv0If8=;
        b=JINUF67VKdX9262pGa21c6CtNAcjbC/GlV1TchF/QTSSOt+M3A6xYZdzXs44pDZWL0
         Ux+aq5+yo8Gs5YOH+TQUiLFXOv0ZaiGG4CGvH6dalV9VdIzeBbM5MHZLDXa2AeWG5Bi+
         X5DWJqzcZ3QYz1yQ7jp9XNtKQ8Xqa4PQiUrv4TKrNBR4mn81VTDKm8xFIm7pQUaVx9VV
         pct8DXBbFwL1dBoeT6b6tf52m+bWXZGM1kGKotQIaBTC9Tgs31l8thk7jBA9mKHZT3eF
         LFyARm+VULdexH6UoF4rRdDn01Ba6wYv9C6V/e9Ef7FiuuZs+PoBU9mtdfxx7jRQN2V9
         8GLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755735716; x=1756340516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSzXDMgFLbcT7snT7dZNu/JvQUzsiA/Nht9HMTv0If8=;
        b=jh42vlpTaov/GtpuEt3MEVBV7iv60ZAlzED2g2huk/wgwlWW3KacRmDx9e7wAYkL7A
         r1vSKlSwlC5ujIC9xER0PSVAWNxW/NgFsXIQht0G5w0GujHhJb1bZEC8kU5gFPanCt7i
         fmG2wFqu+HM+BYCijydHJ7PmvemW6kEx0r4cEQqH9YvkagERc5H7whXp55W1gqNj5F19
         TZuPH2SZTItXl21GZMBfmKUqdO1u72QFIXwpu8UqWPIKIu0zoa0DKY6D1cEzei7nSUpk
         QMNNjIw9kzK47vOdS57w1xZY42x9pTyho9KXCmhtk1ILok76xvp3C0mt2ID01hEjWA4B
         g9rA==
X-Forwarded-Encrypted: i=1; AJvYcCVW6RwcvHgJ/GinhyNyg3ymXSkrS5H20c4pReBxJCE60t5hb8FcHgk3974LHTxuVsiZDxxs6jihITC/BMAewD8=@vger.kernel.org, AJvYcCWgyF6CZyNSXlf9BVESoRpF3fzvpGSOiUum08W6nt9OfkDSBcJob0sA3wzfndaCynEbWg7pyKA2BoNQ2WE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd+//NeGruUNtcwcIunGqS3vJvBEXF8+xB05LBLYXGLjY/Pnas
	Fbza6uLOGIbgvVLLbxG6Y+eT4xvd1hOgDzoXYlvX5Tr3zQZFSAPDg15Y
X-Gm-Gg: ASbGncsDXdqo95PWXQ8Uu1Edxnx7TZpnza7BuCgr3hgrI8rFl72ulN97McytkeLV+gu
	cuZh7jb5AyUDl4HnWIGFDEtk6fu8hb2FpdkgcB4rUk0X229RxiDELK54rZNx1oHIRuBqtoVU1FT
	kXMt23Zeul1w+9h+3es09a6wLpHI0JLW60vRdOmVeGr9ui7ai6yULt1/y52R36olaqerEZj260Y
	W3zxWgaJyGEjgyaS1MPxiEfD9VT/kevOZ5rKbSn34S5+NDbC3JOK0gATZP/MPcFz5Sz+GmczV7I
	INfXi7zo4951HhIfr3ms4u7v4U0FX9Huy1SGjOM5qsNvWdCbnEWAJFmKrLIQzSK16JVbLRgJoAc
	sotSq6S06L2qVo5fd9yJ3tDY8eeSE/KMzXsfal/cN2HKK9FZufCpbIzXF9yQkRqsaZfRgVw6KOF
	XtqtZ1PQ==
X-Google-Smtp-Source: AGHT+IHUJncOAECoQzBJP1RfceKUYmBjzXFYbzYZ3nPPlWL95jCO2rVDdIhforoqQT7UNCX/6+yFzg==
X-Received: by 2002:a17:903:37ce:b0:235:c9a7:d5f5 with SMTP id d9443c01a7336-245fec00816mr7791155ad.13.1755735715781;
        Wed, 20 Aug 2025 17:21:55 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed50352esm37464065ad.128.2025.08.20.17.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 17:21:55 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	ojeda@kernel.org
Cc: aliceryhl@google.com,
	anna-maria@linutronix.de,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	frederic@kernel.org,
	gary@garyguo.net,
	jstultz@google.com,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	lyude@redhat.com,
	rust-for-linux@vger.kernel.org,
	sboyd@kernel.org,
	tglx@linutronix.de,
	tmgross@umich.edu,
	acourbot@nvidia.com,
	daniel.almeida@collabora.com
Subject: [PATCH v3 0/2] rust: Add read_poll_timeout
Date: Thu, 21 Aug 2025 09:20:53 +0900
Message-ID: <20250821002055.3654160-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper function to poll periodically until a condition is met or
a timeout is reached.

This patch was previously reviewed as part of another patchset [1] but
was removed to expedite merging into the mainline. Now that all the
features it depends on have been merged into the mainline, it is being
reposted as a new independent patchset.

I put this function kernel/io/poll.rs. This function is not
necessarily related to I/O though. I don't think this function
perfectly matches the existing abstraction. Suggestions for a more
appropriate place are welcome.

v3
- update the comments
v2: https://lore.kernel.org/lkml/20250817044724.3528968-1-fujita.tomonori@gmail.com/
- make cpu_relax() inline
- remove the example code to call might_sleep with a lock hold
- move kernel/time/poll.rs to kernel/io/poll.rs
- remove the Option for timeout argument
- avoid the extra variable, sleep.
- update the comment and commit message
- writing closures directly inline in the example code
v1: https://lore.kernel.org/lkml/20250811041039.3231548-1-fujita.tomonori@gmail.com/
The changes since the last posting [2] are
- removed might_sleep() change since it was already merged separately.
- split out cpu_relax() in a separate patch
- make the example code compilable
- update the code to use Clocksource (MONOTONIC)
- call might_sleep() always (even when the function doesn't sleep)
- cosmetic changes to the doc

[1] https://lore.kernel.org/lkml/20250207132623.168854-1-fujita.tomonori@gmail.com/
[2] https://lore.kernel.org/lkml/20250220070611.214262-8-fujita.tomonori@gmail.com/


FUJITA Tomonori (2):
  rust: Add cpu_relax() helper
  rust: Add read_poll_timeout function

 rust/helpers/helpers.c   |   1 +
 rust/helpers/processor.c |   8 +++
 rust/kernel/io.rs        |   1 +
 rust/kernel/io/poll.rs   | 104 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs       |   1 +
 rust/kernel/processor.rs |  14 ++++++
 6 files changed, 129 insertions(+)
 create mode 100644 rust/helpers/processor.c
 create mode 100644 rust/kernel/io/poll.rs
 create mode 100644 rust/kernel/processor.rs


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.43.0


