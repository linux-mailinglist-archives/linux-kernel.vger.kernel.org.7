Return-Path: <linux-kernel+bounces-877465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFACC1E2C8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE168188B241
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219ED214A6A;
	Thu, 30 Oct 2025 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGKITDbR"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B177083C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761793220; cv=none; b=d9Be28AXH9TI9IfYv1BwEimwwOI8rNsIcS9v0HCtGAd+5GkRAWT7EY9FMPTS+g8cfmkfrP+B7HGIE0dn6VbQgN+MutqBJXeif+TZqzFQ7WGiAFglGmf0gWMQ+Lw4IiDK7eOePKjwITA/TFLx8SFHqmbVzQrZOxQ83PSl3gSJls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761793220; c=relaxed/simple;
	bh=K0f1o1VbpszWwR/fKC4DOMxwlCsFKCVrRuZo1Za1t8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcC8DTxUdj/TkPreh6zmK6kW7KZxaG14KO4hecOpFQo/Xp7bM8VWJTS4K2Dqe8cppafhU7YBOPkDVV0B6dk44Rn26fmZDpIRI3YsBf/kbnMoCiitmffqSxn/u/buTc114Awc/ESa4CAFDCaKkmQDSj0oxF/DVS0l/ivhGyGVN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGKITDbR; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-79af647cef2so589379b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761793218; x=1762398018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NvVaTZoHjzFOfTaOS9c6wuXAkDCXJtnG/9Vx8Zjx4vo=;
        b=fGKITDbR9pKJ4Q0JngUR2VfKXwjLW4FxC2IyKLMkUe6yoEdekfSsxbfgSXFoQ63Nfe
         Dp4Stx53BttSIvUGuvSWaZuqJD7XbiWGfdkf+eOjZsS8TByT3bTforlejuejc/DWNNZw
         yefvi4N8t9Gi/zc3WeItaQ4Vy9J3A0C9DQi1HM9CDINQxHf9l0ctU8Ll2fhSshmKr0lJ
         rrGzwmVjrtKjlbG8JsGfJMAO4ft2LTlocfdSOcQvEYeEjnl9HQPiW3g8kEnIl4BGviNv
         a/nqLQRbQ5g7TGFoc/zFubLAv2xmrtrfDQHJF3gN/55u24BiMWFQAvI15HZDvwlz5TzD
         kRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761793218; x=1762398018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvVaTZoHjzFOfTaOS9c6wuXAkDCXJtnG/9Vx8Zjx4vo=;
        b=nQsQvloKEZy4QXC6G8YMCa46pRiuS2Y0wVaVbmMBQd3lfQNEX9tqNc4IqbFGBZI0h3
         qSi4pph05N7vfB2ApGGM+LnZRohoxyzbezND0Qt7wpzF5J/S6Z3oFwjoLLkGW95yMLrj
         eA3AYV8kP415R9QWJYlMpLLhC46LQUP5ll5bTIW73tIWxnvw5cZL3qGtUVB6lrPc39It
         etodaHlQg5L6HdMQGOstvBTujYFum8miXVYUlu36B/OMg581lETlHINAE7moHpdlXy3v
         1K1BHiujQzpL2HzMeG00LtPAwjJO76bNybhCsAmsewksLx9lQk2AGbswKHkzoA0bxtbY
         9A0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdzifKp/bmgp72sTC6Mw4YWnCjYjgIic9BYftBaQXjabPY/5GZUY44FZwKRfD+Jyg1XFMwDzQoaPzrX5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFvCxUdNM7ee5zG55/Qa4xI1/+kcyzx14S82s/lTJLz0xmHSpK
	ilMRaCgU8+SOTXA6cCl5BSqyoJtdMSADPs45D5VEzmcpK/P4NFk5kCOi
X-Gm-Gg: ASbGncsIlUorwCQSrQOJ6c1MGz0c725WPoYXrYoLIFPEsnetkct3DcM4Ynrc+iYQtv4
	x5HWJDZ5wEZQvz4iioa4bpumLj82a3CFCT7HVOBslwS9q1rD04yc31VrBuSduW7Lkl9Xa7yF4Dp
	Dxnpf5JdiGgm5f4j+E5oUvLmixYqck4M7fsiCp4nrFNKJtQtuu5oAqDl7bpDU2+524l8/kbDewn
	kzobtMzJx5klcg5z3ewRHgNuH+KzaZ2g1QwEXEmBkBWnFsUp2Rfr3OuiBvPtG86txxLQZo+B/U/
	CVkwjQq6/JvnHrIY0U19BiLLIHK+vGcatEbBrvvOKlV2qb65xenw5V+mjHfTxonuZiGZClVTVk6
	dKP2abMJXyhMUZ2+bYW1rF2HmKs5Yj4kbBbcpvCK6QqfH7KLjmuLxFk0cwla7i4pLFUgMyaJ6Xx
	yMGxGV+XhP4FM=
X-Google-Smtp-Source: AGHT+IHFjScuupRcBVVx/y0EmSBi/aHgLpKdYf+L8LdTc0k0O/fP4xz2JXMfSv3sb6YF0O7c0uIYZw==
X-Received: by 2002:a05:6a21:3288:b0:2b1:c9dc:6da0 with SMTP id adf61e73a8af0-34786f61014mr2257534637.46.1761793218462;
        Wed, 29 Oct 2025 20:00:18 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012b19sm16663311b3a.12.2025.10.29.20.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 20:00:17 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: martin.lau@linux.dev,
	leon.hwang@linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 0/2] use rqspinlock for bpf lru map
Date: Thu, 30 Oct 2025 11:00:08 +0800
Message-ID: <20251030030010.95352-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the raw_spinlock to rqspinlock to fix the possible deadlock in
[1] for bpf lru map. Meanwhile, add the testcase for the deadlock.

Link: https://lore.kernel.org/bpf/CAEf4BzbTJCUx0D=zjx6+5m5iiGhwLzaP94hnw36ZMDHAf4-U_w@mail.gmail.com/[1]
Menglong Dong (2):
  bpf: use rqspinlock for lru map
  selftests/bpf: test map deadlock caused by NMI

 kernel/bpf/bpf_lru_list.c                     |  47 +++---
 kernel/bpf/bpf_lru_list.h                     |   5 +-
 .../selftests/bpf/prog_tests/map_deadlock.c   | 134 ++++++++++++++++++
 .../selftests/bpf/progs/map_deadlock.c        |  52 +++++++
 4 files changed, 217 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_deadlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_deadlock.c

-- 
2.51.2


