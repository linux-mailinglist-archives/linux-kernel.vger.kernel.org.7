Return-Path: <linux-kernel+bounces-862514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A68BF5800
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F30542203E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768AE32B9A4;
	Tue, 21 Oct 2025 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTWfzsph"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204C032ABD6
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038875; cv=none; b=AdNWuYQ3MMS7ONy6bN6PPGswbvE0mxZQkt7IDSzryYHXmtS5ELA3fBJUD6/iGaC8UksdXzkeDL/kYQ/K+a8UUCc8HlzAe0T2ZS7zf+Tz8P0qN1o/pH946gBF+r8Z+EfLVc+eAiWQ6BY3rIQ66aERO+qQ2ltuqMuSF2/shUAVDqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038875; c=relaxed/simple;
	bh=HaRv5VyyfQD/M02LECLvCAgbJjUl1ZdqnmY2ulTf2s8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aETubB6DnNLWgkNivfR93ZDkmkThWZrxVLzlhOf1LSDshotAs8GnEpDLYLDeCTX8DoFN3ngbBbKNipdac98fY/w9z+F6C9VNHlIAVy5MFxFLNKJohu6T111S+rnWRkMUEnWaVUZGU2aYUXJS/9kB4RXwfjLyBNTu0WdhIlPWVHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTWfzsph; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-78af743c232so4203992b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761038873; x=1761643673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+kglR9y7os7mQk0o4TszsRp8WyyKIWcJcUjeWX0BXTU=;
        b=hTWfzsphSpOFRrBz17YUPJhPQKZYzwAsmpUj33Ps9G2dggfzlp9P+Mk4PVS9CN/2j4
         WNH3vnKgfL2whvrmtpRMLDiyzcEkQbS71yVv50JjHvYctZiwwIDoyNCdUiG6bgcCPF3z
         K4WQeZvTRgh+ysWQaorb8xqQlCH6Cvhaq/h557xxpwZAI3Dt3bw+n8GKIvlNpW+kDyJS
         AGVgWbT5s0BQ9+1GZdSSax+l1HcW3Zh/OhodjVDm5k1h0Po2VbLkb/OcSBcitbyGwhMA
         itqCRMwoBYvwGS5K29OiY/Psv6BILfNoABJchxmhxd0BrA4S8wu868q/ejpsqaXg1g1k
         o2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038873; x=1761643673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+kglR9y7os7mQk0o4TszsRp8WyyKIWcJcUjeWX0BXTU=;
        b=EFpGEjC+bCz8lHfMcd7QxRk8qnVz9kEv5XqG7sA3QcuGQ0NfPPLXGWvolQ8MBTR9a1
         Ed5AlvkFnkncsXm28rzXmP5VliPLuCS9RRvkFkoa2ohkvEU7pYOGUATy78ORyLFFWDLX
         IBuGScGzLSIaGY0csyAi+uINdplB24kD6CM2fnZHPRMrwh5K4SWH5TcaybfoPP0d/H44
         gEOacsQI2GGdAD+E6hg7+GI8yUEOWrhjF0McXHf83bCisCORiPtirpWx5FedWAGP9nLz
         NOo3mIBHISmmne/clss0kN5HvRtuuR7sUOkea8wxjV6qJqqCetuRlMXHgPQV0/zV4D5p
         CdAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGKvB6K3674K+Sln1QlzNL8NvDrniC3AhU0a5SgI49G7QnPaaqyUwHNdBt/zHeOV+oLfRBMLAj2buHT7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlE8U7XozMf0FdXXKeHJS53ZKBGXDbUqlYrWhYs6K4qAUy71Wv
	kKdtkmbZZSaMFwGiAw3ORbVERiHqI2zOn3K4tmq4s3u05Zs2F37tjX5W
X-Gm-Gg: ASbGncuYnCqz1ggsyqbYXxOm89w8APKXPsOvpDA6uBWoiO0ZFfflQ83njDEZA4istHT
	eLCETM4NABHP6y+MEBOKcGKJzj0H3CCsTEKdGNiLyMKS6TP1zBRIH1+RnDbSK0vElys4Zyzi8Fq
	Jw4SojoiGSaZxT049EYe4fAihnIvxKJnFdlQoUweOe/y8cvXP7lwPo2sM2XxIx20jP4YaVdAW2K
	/tMqSNcBDDp2ApYE4NjtmcFkj3EuMOGQrhMNOLCf8fgOg7oxBKLu5CWoDbxW0eFogXuwZ1nZjCn
	nAe1W04oduT+vuiISCUXF7tOsXGn4wDTAsCmw3bl1WvDFffFpPmELEP2Yo4GpqiMRVcHwS7ITNp
	9ZIWu6cQuunIwxzimdsojkj0pwGpnT45PqTtdDWDKANQrqQY3VS47F9TsnvyQp3VMOB9ybQRN59
	ScyKZCv9AVKmuHiJeQuYvd0nrBeiJ4jJoKtSRXDCsvq775spVB
X-Google-Smtp-Source: AGHT+IHDdJUUyy2/lnWhcN6WecKI1X2TU8NhpiAbnyiGwmti8cS2MOl6n3DpU9tB/v38jytZQ39ykQ==
X-Received: by 2002:a05:6a00:94ce:b0:784:5d3a:5f63 with SMTP id d2e1a72fcca58-7a2208fe6b4mr22110698b3a.2.1761038873163;
        Tue, 21 Oct 2025 02:27:53 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a25f41ad15sm493996b3a.41.2025.10.21.02.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:27:52 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: dakr@kernel.org,
	aliceryhl@google.com,
	daniel.almeida@collabora.com,
	a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	ojeda@kernel.org
Cc: anna-maria@linutronix.de,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	frederic@kernel.org,
	gary@garyguo.net,
	jstultz@google.com,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	lyude@redhat.com,
	rust-for-linux@vger.kernel.org,
	sboyd@kernel.org,
	tglx@linutronix.de,
	tmgross@umich.edu
Subject: [PATCH v2 0/2] Add read_poll_count_atomic support
Date: Tue, 21 Oct 2025 16:11:44 +0900
Message-ID: <20251021071146.2357069-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add read_poll_count_atomic function which polls periodically until a
condition is met, an error occurs, or the attempt limit is reached.

This helper is used to wait for a condition in atomic context,
mirroring the C's read_poll_timeout_atomic().

In atomic context, the timekeeping infrastructure is unavailable, so
reliable time-based timeouts cannot be implemented. So instead, the
helper accepts a maximum number of attempts and busy-waits (udelay +
cpu_relax) between tries.

v1: https://lore.kernel.org/lkml/20250821035710.3692455-1-fujita.tomonori@gmail.com/
- use the attempt limit instead of timeout
- rename the function to read_poll_count_atomic
- add the comment about C's udelay behavior.


FUJITA Tomonori (2):
  rust: add udelay() function
  rust: Add read_poll_count_atomic function

 rust/helpers/time.c       |  5 +++
 rust/kernel/io/poll.rs    | 80 ++++++++++++++++++++++++++++++++++++++-
 rust/kernel/time/delay.rs | 37 ++++++++++++++++++
 3 files changed, 121 insertions(+), 1 deletion(-)


base-commit: e6901808a3b28d8bdabfa98a618b2eab6f8798e8
-- 
2.43.0


