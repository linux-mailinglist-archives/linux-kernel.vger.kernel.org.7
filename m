Return-Path: <linux-kernel+bounces-859387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 536B2BED79C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 20:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EAD7234D385
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 18:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1981122576E;
	Sat, 18 Oct 2025 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2jwp8wm"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E7422173F
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760811146; cv=none; b=MEP9wV7swjJhFtOZzrKR2sGw3SEg1arstIMU+4JIG3upowqJM1n33Ha7d7zCQUmvp790YoHaanbEryc62vD8lsHiRzyN8fDdw1YKdmCkOUVPzc4pdV+ta9XlD9MdF/mncWMNi2vwmspSNWAUjWCGGD67jGCDpauQlieuH5hi9oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760811146; c=relaxed/simple;
	bh=NbePi+IahQbSkjH9l4oUjZqDWZYGDLqO0mT3Tj52yNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSNgey1wRLtqGY7QyNVRN8YAUH2tVcXImLaO/231aU3rx5ReH9jcxRJiwcF+7/hFP6FPIabHE1vZwzybHV/YtRzxhspz9sU+yYcT6GF/0G4nehaGNBIJgcOjnmd1L1IbCu3OY7OBAqdr4gwFlFkiVrHsOOK9gGvqvlkDBk3swc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2jwp8wm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27c369f898fso42650035ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760811144; x=1761415944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NNz7x8ijdaSKfJZxmVzdQGgD/aRBaTgM298y1Bdrq7s=;
        b=T2jwp8wmTHXWY2NkbQnZClV1+dp4IVji0B+6atraPsZLZ63slY4j7Ea+FQYiIX8GfR
         KOGGIUuv5icC7s6b8vwSoYKkiZNNt3KYetIg6AJTlfQ1tYoTKGLxgqaE5vma70RGXNud
         J0tbQ/CjnYau6C9q6MjXIgvJe8aCBkdOqkm7rlX4eJYxPsqY1uVc8DgUVrum6s5dB54w
         5Vw7NDNIiTjlOqshxxQxJ+U3Kmadft9+33VzseABmxuvdRvg24S8S5F3J561ogl6tZUV
         NChD57jiOw55jl9sT1J9uhGhB3/Iq0Msg0TKe+fLlzPW0Rlg90Vat0WFrxYZwcB9SJpL
         44Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760811144; x=1761415944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNz7x8ijdaSKfJZxmVzdQGgD/aRBaTgM298y1Bdrq7s=;
        b=PmchOCHWQ+pOBuuFi2d9bvjelCMYtJaosvPxSz4gZUsmAeNa7K5YzeTPD4ygjF5P8g
         6QeyD1zHDViu/+1rtuQ4BwXEWX3UZabSznasnROG3ovHcnHc3d/hwPMuj5R5hlNosX3x
         TWv2F4W4FO46dkjo4u91eabgCZB7wSUuOS9fMrDOkR9rbForC0yEpHiGXMD/SQ7Y/O3C
         YF0NrqAR9tNfW4oVzjcd4Hlq3RkIr/3SHrxLmzgYvfp/7YY8DF6F43B1niet1eJQrJh9
         CPghqucYAYStrQzhiBYYzejGYq9i38DS9NSAez1E7QzswiqD/lJM4+/POd0HtcXIclVz
         xSww==
X-Forwarded-Encrypted: i=1; AJvYcCXBv87L0xsTXYq63CszZrpHTIO1CXNo/k7zVegISCQ55GDixNUS6PmlvdDSp1bjOxkKZFrtfCiJc7uk1AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzdzCu+3AkmwqbX8rO3+IAIc+D+3UMtpU0DUXqofD7ZN/Ik/K3
	6wDO4xQ0KuBYQ8Al5t74KSZk3TrWzgiwKZFlq+hkIKgePTrSRHCKTxVW
X-Gm-Gg: ASbGnctAJ9kNnruxTBE6tsM8zF4/DSpOGCaLKkfDKn7Fl8OAJn6nvArvp/HE+e/Qr5F
	bnJAq8itkrEv7nNR9SuDXyRIsdSvls2E1BIF/pjCZJJ1SIn4dWLKDbZo/r083bj6duyyCvlfH76
	0YZlNT1yM7dWKiQzmAlW1ZvIuoU+N9ey6DmZgPq9Hh6udmagNCQDCqty7+e8hXuCxrPla49jGAZ
	4OpTBcwRMwU7Ink8ZAKuy7lJevIZHl7FyKj/BCZZ9I3ZueKqdjKibYeAd0X0MESX9nfF0mUZ12+
	wLqwfvQW8VgqdzFlBHScUslaAvEHg6b8V9NcOtPxN6NunG6sEcWkk4jJTDPwwNLDoXmG0uzwIVz
	S8iTh2JXobDiIjV0fwsqBsnxdzPyxFsRJ6Z50EIProumHK6McUiYYBVLCyh6zMsiVWyk3CGQzH3
	s5RXF+Pco=
X-Google-Smtp-Source: AGHT+IEM2As5xd01T9MyhOsY7Jq/vUwDCLwwpWmhJm9mhyk+XJJ2oR4QOLSxSgbrOM2CG4/v7kn10g==
X-Received: by 2002:a17:903:46cd:b0:272:dee1:c133 with SMTP id d9443c01a7336-290c9cbc210mr90330765ad.22.1760811144160;
        Sat, 18 Oct 2025 11:12:24 -0700 (PDT)
Received: from fedora ([45.112.145.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5deaed0csm3220410a91.22.2025.10.18.11.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 11:12:23 -0700 (PDT)
From: neqbal <nooraineqbal@gmail.com>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter@linuxfoundation.org,
	syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com,
	linux-kernel-mentees@lists.linux.dev,
	neqbal <nooraineqbal@gmail.com>
Subject: [PATCH] bpf: sync pending IRQ work before freeing ring buffer
Date: Sat, 18 Oct 2025 23:41:56 +0530
Message-ID: <20251018181156.59907-1-nooraineqbal@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a possible vmalloc out-of-bounds access caused by pending IRQ work
by ensuring all pending IRQ work completes before freeing.

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Reported-by: syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2617fc732430968b45d2
Tested-by: syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com
Signed-off-by: neqbal <nooraineqbal@gmail.com>
---
 kernel/bpf/ringbuf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 719d73299397..d706c4b7f532 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -216,6 +216,8 @@ static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
 
 static void bpf_ringbuf_free(struct bpf_ringbuf *rb)
 {
+	irq_work_sync(&rb->work);
+
 	/* copy pages pointer and nr_pages to local variable, as we are going
 	 * to unmap rb itself with vunmap() below
 	 */
-- 
2.51.0


