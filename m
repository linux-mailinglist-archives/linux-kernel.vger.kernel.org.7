Return-Path: <linux-kernel+bounces-837338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB90CBAC12A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8435616A23D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A6D24DFF4;
	Tue, 30 Sep 2025 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAq02j4G"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8136223BCF5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221337; cv=none; b=rmuxac58wd7NtE3vVp2oMYDPNZjigi3ZHKHAjKdKnrnlYdQeBJhQLGkjICwtEjU3Xd7hS/ajUuoWrQ1CPQtOTlSDEl3cC7lht1XPdsFNvAn/mr17JtUP77sVYU6iLBRmypSKz7MD9f6i652OKKDud9o23qaft85wJ33j93LzpFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221337; c=relaxed/simple;
	bh=ADEdvYCZrQhbb8wIcB8O8HKwCMDJp6UBw/AeIwUpfK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JUWyw1qaEwBP1bjex2jUVwPw6OW1ERIU/ywN7jAFGbKQFK1XEsxEWPHNrAsPMEflnEwavdOELtPPIKW3JjnKbm+r38vb+V9vgxIiBwQUT1hjo8YXBxLhMuT3ilkV0sQh32IMw+lkljsr7HWIkmjId245jHS14/T04kSNPPEE44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAq02j4G; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3fba2c43a16so247925f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759221334; x=1759826134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GUJqvmeemqRm1gvXL7Ny2YCLo6gR6Nwv5491LCLZ8/Q=;
        b=YAq02j4G03oMxA0zuj0UGiuDx2VYj1KNrz/gd+/DArAmzWRauuvWT6jv3EZ4utN8z9
         sfuqmSaDg3IQuv5yQdkYU1meJNIhRnnm0p2FnVKrwb/mXZ1gFHcvIqAcEBYgpz29qWS9
         Irsuko66oJtO80GMqyxNoFL16DOcjfI3lDeuFpdjbpxIDkCkOLNT6+2ohvvuqdl/LSZ4
         kU2C9EWFmNC5C9jXNRS88HYzA+fdnyiiyVS50wYcW53164aWC/6qqDhaeILqAsXVyhdg
         xOu0I2ufHDidzt9FxlkOEDeFWaPLsqfQo5+rZvXEyw8yJdDhJ6yYzttV6k8z5d2FwR4i
         JLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759221334; x=1759826134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUJqvmeemqRm1gvXL7Ny2YCLo6gR6Nwv5491LCLZ8/Q=;
        b=uRpHeSt0+RWbFQ85Oy3VjYeXnVxyu/lb8MsRJgD54TSjspamrbGawnnzbdZv1mv/Hd
         ydb0fqJBvePpKT1hVqQIF7/+fjU5CVmItCiQIRNyC0+vsj+s8qJ9LBe11kdTKesJFBsJ
         kZ+wCuehilVE59oPCzv7LfsnnXOTzE4GmamFpOXeo7t+J5QPxbNoflTOa8m9lQ4E0cFD
         eBb+E6RfC/9Rj0IoF6y0NsFU1wGm27Llo8m7HhVqwOik6lutUOtqekOvyBpqBFNr0bXd
         KO6Nu5qtq3I7HOSmt06OkRtY1Wp8U/v4e7wvc6t23/8vyumv30EtarWDR0Yt/aBj2zVm
         BarQ==
X-Forwarded-Encrypted: i=1; AJvYcCUefIi2UihNN2F7HyFnPTmo5Kwd9thDxRKLzCtTtOfC9snA/ncRXMtK24cQpHkExiHb56GYk+14ynVico4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYaXhEkNsmwHJZ1k0zsPnOP6H2I5ixzlSwhvdsV03XHS/lZ3xH
	DUVXhPxoV7Gmyzzs+kWTb4N6MblE6yGJl5OeHl7ZzHB5ELpaJcSUd/+T
X-Gm-Gg: ASbGnctB+ryuybxHDsmT1ry/nBuQ3l8vqYAhXbKDKHl20mMwzznXSK4ZGF7mgrd5NXq
	SZAvcDwl43O+c8snG5qX3eJYU26ZLMEPuMB5P6pBtjcTFEnMDHTFLrDwZ0tjLKwg8QotNk84z1J
	v35uZMOsiP3fLFIHNoLLXpxplXIzuCil+dpy1WHfFFMjwRk1Y1lh4nLy9oFzXySbU377n5plP/l
	OljG0cDzLWQj7DXY0pSGGldG7NVz98Y36L7A3T6qIFXTtgbxOxSrAfG1lyB/vS7VquCgO0sQDuq
	b/stO0PEzsS1kcpgUfsD0MjHs0rYXS/yAUw65TmF+HDdOekjevXiLUq4TSZslOHiilGzLM6dAEj
	xmuT+lI7892mNBXBc/ls6sfTyn7uFHQKJb4ii9lUGAisZScBq1AAbhxz4ONeNjHnk
X-Google-Smtp-Source: AGHT+IEnc4h4ssP9sS7icqNK2zeN2NBLAu8VYYr2nlceMXRBqj2zPJC/ON5vQZnbcoK/iRDFPcwyVQ==
X-Received: by 2002:a05:6000:26cc:b0:410:f600:c36e with SMTP id ffacd0b85a97d-410f600c731mr8845629f8f.4.1759221333463;
        Tue, 30 Sep 2025 01:35:33 -0700 (PDT)
Received: from bhk.router ([102.171.36.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb1a3sm22132771f8f.10.2025.09.30.01.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:35:33 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH] init: Use kcalloc() instead of kzalloc()
Date: Tue, 30 Sep 2025 09:35:37 +0100
Message-ID: <20250930083542.18915-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kzalloc() with kcalloc() in init/initramfs_test.c since the
calculation inside kzalloc is dynamic and could overflow.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 init/initramfs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 517e5e04e5cc..fed1911b73cb 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -97,7 +97,7 @@ static void __init initramfs_test_extract(struct kunit *test)
 	} };
 
 	/* +3 to cater for any 4-byte end-alignment */
-	cpio_srcbuf = kzalloc(ARRAY_SIZE(c) * (CPIO_HDRLEN + PATH_MAX + 3),
+	cpio_srcbuf = kcalloc(ARRAY_SIZE(c), (CPIO_HDRLEN + PATH_MAX + 3),
 			      GFP_KERNEL);
 	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
 
-- 
2.51.0


