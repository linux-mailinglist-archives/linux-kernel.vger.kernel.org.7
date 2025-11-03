Return-Path: <linux-kernel+bounces-882773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9D8C2B6CB
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E08E3A45A8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293E2303A3B;
	Mon,  3 Nov 2025 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byP3W5O1"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287642BFC7B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169438; cv=none; b=PeMRzVkb8x2cTb6OQNJ6n32LFic5t1DCDiX+2gXhR+IsR4b9dnpsTkvtXKt3UZ/bGfuMcyD8ibFylXXftQfjt+WTCX8GlyCOIMpFlA77hzLE6Q/yFj30WS51T1C+qY4GkWh8Poej1Tn+Ka6ifiDZ4s+ykRx+cFMiTC+amXcCgKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169438; c=relaxed/simple;
	bh=0suKgHuLRwkBTP77PUvWJkf99RJxwXQOarlKT4reJUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/bS5uVwrh+Sp4dBjKuRZ0yRmgutnaTEkWa7ErcMaZztt4sSwSex5Q8RbYP5ynEvfNZtMONqkq9wqEdxNrZwday+UIWEy/johTZjgDnKbzRVpDRxijHyBRCxRJMZFVMrURcV9gJw9LajhjfoCB3RqveuMycLVTe7GI4aDI1yg60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byP3W5O1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a9c64dfa6eso959746b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 03:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762169436; x=1762774236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/qh3QJ9wKU70Pva3b0Eg2Hw/21TsuzKDzuHyxygKns=;
        b=byP3W5O1IesJt+Kyr+/uVzGRjG2XpiU4fZr4oBghP27LAvz4hmFMMvIkx6cbKwYko0
         /wStooa9RAuYayeqeax9YbmNrX4yX0DX/reZ3FoguzsfYfcfieva9uMg2mNNoL2qBPDT
         MeqQ7XOqB1yqQ/iZzkd9nZhriH+F2P8/2k67TkDzwimEcIJpCbyD79DDanQroEO8SmEX
         P3BN0gTYYzy+AdMJaj/sseo/JB/pNLwdYq+sjhBBpPIUgFI9OgpMH5mJ5UNferaNTlar
         gNtjAiLvfQaETrXNSv+Ok6UyZWjYa7QDbXIdcAkGofJ3N/ZGZvRfc6PaBS7A7QwBqb4Q
         61Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762169436; x=1762774236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/qh3QJ9wKU70Pva3b0Eg2Hw/21TsuzKDzuHyxygKns=;
        b=htVwYXSaSpTXKUEQEmGv4hLWBuEhuk8ZnwkAsFyjJ3OZHoQJI0JBQFHQH9+izAl8Rh
         VcgW5rFCaJV4J6+H5yzFQuoK8KF2v0H2ErdHnOfRlPGcTbYLr/iVuGm+Ka/yq4z00SLj
         lB3LzlZJc+ccfVuaHG6rNCIsoBrHii/5rwtzMwnySOZLLMC+oUy9B49+h21oWVqiU7Jy
         v4+lZSBOgSo5iCapsXuKkJE8xpHpir+T7W01xDZxRuxqVm3/er6qPJupkQAY4O6NGrKV
         fAmSZ8Ig3O2rgh9jbOZpYiSoKGvqnUhSPgGINg6WdB1nnDfL4pza7QoR7jYo54W3utAR
         udng==
X-Forwarded-Encrypted: i=1; AJvYcCWw3OtfQJ0CausBje8CHsrL1vrZBL6CIpbLVonwKMSoO+xOVTI0gRze6auz5Xj/tN+kHIC3GU2SQMSpYVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxagoZ0rhGe49eKwNrHWwMUog0s/z5f8gBgPh7guTwEitCUpzbb
	KgiZJYyqUf4c2/eHB0aEyWaReGF6BdLfvVAAitcDEpFJjEIEN44mm3Lh
X-Gm-Gg: ASbGncsaHH4bYzi9EGZhRtwAaZoYDutuBC37Q8zVGxuIQEJRYk7ZWUNOP6P5yA4jPBl
	nNQW7Z0+yPnSwsDn7Z5H5+T/fMkLU8InRFkwve6UfxhV7Sv8Iqvhb/VcghdE7tDPKiFUIrT03l4
	HP4PR3zdJwXg2/vYKZMf2Z4z+yaehmIDXtbGN1M/i4y0/is/e9I2vnOiYUBAd0+K/smMYe4t99M
	cit4M1M8i/ciY950U6lreqEjX6PvLQcdKOpAAVF/y2XuWVxEdnVzwNf9zJ1j0pFOT/rYHJdN879
	OEmcAB8IbywFPaCHICEegvQdHB5c/u5AQpCZ7q4oFvXqgdnw9C0KsFMYT+Z2qiaG8cYO5TU8JbD
	giJ8JEUFqQRjNPZ8aSCin4KC3jTN9uXouuob5vA474HCEcSH+Fn1u+ryyYll/vErF++xutIXOtE
	L50MNNlwltQaxHmXa06yL7z8zNWyKyjOy+Xn0QeX595iie3BhsU8ky1fiYc6g=
X-Google-Smtp-Source: AGHT+IE5/oLm71Mm5Mx8J4RBYI2+xTTJ8AwTf4zBrIpxR08Ev1LR4nonjYQhd6iz+19QOqH9Sq10mQ==
X-Received: by 2002:a05:6a00:2d1d:b0:7aa:8397:7750 with SMTP id d2e1a72fcca58-7aa839780d6mr5007659b3a.12.1762169436363;
        Mon, 03 Nov 2025 03:30:36 -0800 (PST)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d897c632sm11011033b3a.10.2025.11.03.03.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:30:36 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
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
Subject: [PATCH v4 0/2] Add read_poll_timeout_atomic support
Date: Mon,  3 Nov 2025 20:29:56 +0900
Message-ID: <20251103112958.2961517-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add read_poll_timeout_atomic function which polls periodically until a
condition is met, an error occurs, or the attempt limit is reached.

This helper is used to wait for a condition in atomic context,
mirroring the C's read_poll_timeout_atomic().

In atomic context, the timekeeping infrastructure is unavailable, so
reliable time-based timeouts cannot be implemented. So instead, the
helper accepts a maximum number of attempts and busy-waits (udelay +
cpu_relax) between tries.

v4:
- update the comment on udelay
- add Alice and Andreas' Reviewed-by
v3: https://lore.kernel.org/lkml/20251026125458.2772103-1-fujita.tomonori@gmail.com/
- revert the function name
- simplify the example code
- add debug_assert to check the range for udelay
v2: https://lore.kernel.org/lkml/20251021071146.2357069-1-fujita.tomonori@gmail.com/
- use the attempt limit instead of timeout
- rename the function to read_poll_count_atomic
- add the comment about C's udelay behavior.
v1: https://lore.kernel.org/lkml/20250821035710.3692455-1-fujita.tomonori@gmail.com/

FUJITA Tomonori (2):
  rust: add udelay() function
  rust: Add read_poll_timeout_atomic function

 rust/helpers/time.c       |  5 +++
 rust/kernel/io/poll.rs    | 72 ++++++++++++++++++++++++++++++++++++++-
 rust/kernel/time/delay.rs | 37 ++++++++++++++++++++
 3 files changed, 113 insertions(+), 1 deletion(-)


base-commit: b0b7301b004301afe920b3d08caa6171dd3f4011
-- 
2.43.0


