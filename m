Return-Path: <linux-kernel+bounces-828642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E35B95134
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6AC2E1D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D862701CF;
	Tue, 23 Sep 2025 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZ2UEUVn"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECE1302158
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617586; cv=none; b=fupRjm35ciwbArBVcZ9RHQ0QkjcZhBX29DbRgElc3X3XCxLuVdvgK8PGO+tYlncLX4CkDACdHoXPHwAhKgddZr9lBV0V0XZbCZrj/AtX/luTBwwx9LqtStvQaKXqM7LJynJ4nB5t53oEEbTLeY60VUEERHAeYvpZ3wlHTkyizMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617586; c=relaxed/simple;
	bh=L9TSdM6ceeD8ljbIELNBkv1m6KBoy85O9aC9JMdtFjQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HLNGp7g03YMy46zATxZKESXDLG47XTisDZa80PkLgtEKdvQmcf54WPFglO5Ed1tT4ICDz15hHYAUiObX3fa8fMgIhjD5VnYh/MqWjLGRhafQYD/NkJzd8LWeH3tGl8sWmx5mKi329+JVegF3ikvtIH8xXW958Y/vEmJjkV8y2Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZ2UEUVn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45de5246dc4so11770455e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758617583; x=1759222383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HejTWNpWzxc6zcJhy00/kkFkRjULOR58cZ1QBwMT80E=;
        b=cZ2UEUVnmiYSXQC4n06JHXJfdrCLqkV1yUl47oIag/Wgb1Sg7ybxGmohlvFJOXIREh
         p6XVwGogiMEJXRgtQnlV285c08MOlv/IhWhu98Irvbc9CR3jh/fLO9OZ1Ju9qFtuK558
         OpkieG9Fv7ReakVMEw97DUYC7GHsJAL0CuTxHyy9/Cu4EDMNhb3fw56TNTOPB34EuMjM
         Oa6LbH7JQbjuDu/cBZx+/3JWHHwY8cpVf308DJCbTzpUSKg8Yb21JNsjDdL3l3drZoMq
         ErLBOqD8xLKyCkLnp+tW7RMazkazpyIv45LEAoPg3mLcf8b1uWoG1FsVAsGcnvgZ0oax
         /0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758617583; x=1759222383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HejTWNpWzxc6zcJhy00/kkFkRjULOR58cZ1QBwMT80E=;
        b=gFsk+UWpSIgWPaNvifYBWuyCpF7dakwkAG0DZW+DBumUqf8e8KAa945+xRmTRVc3Tn
         pPxE1ORPjfoM4S+CYrAXKZ27s3+xZt9VEB8gR6HpNU2AiNXla/J8IV1Ta5OhrH4GY5eA
         tDIjSOyA/FzyHykAuB8onnAOymQjnKeYEnD47KJNh57hG3N1xbRCAjeKs2QEeqVnEzKG
         vaKbsVVYK3eORY3Xymb/jm1If9oR4frinzb3lus4XmBniTVADgSjE1eOVU0uwxrcaFFi
         /tETeXm5p8KkmRaZC3c0zkQwn9W8FxtQXZKN3Vo2WWbPdZqlRI/H72cfCGnP9dXi6RYu
         Id1w==
X-Forwarded-Encrypted: i=1; AJvYcCUo0PaGoWT9tn6ZCTp3pDa/jhO2EG1bEKoc+QZBLmFHwZbKV+ogdekn73NIVdJOvrJiHXywXykvFDPkaXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGdb+Td3a4BkDWjrDVPAUrGfzy6nMPj/Cu3+BXxErHMFdVvWGO
	C2VUnBKKdlX4vwT9i2rMNuYwUKjYcOJ8KmGgTmHpFNQSrHzQ1a1+CAU2
X-Gm-Gg: ASbGncvcult9wk4U0r/U/rZx+1q+5Yycsk/0VYKtJi7cBhOuicDIZq28SLlcAd40pfe
	g0E3RRJPTSgprUES5Dos/X7Dxm/ZgN8MdAA3wztDLUlSYpwV22Bab6OGC97XvNNOWH84kV98hto
	A7kGmR9ZFByIb7h6zzalms9JsbJcf5WKzyH4CoXbu1j0t70do8wSE7K8Ek60gpKJZHvTPHWRz6x
	runFujApMLV08uSOpxI1EZTMphOCPJnW0vpRZKEYKCCGfPPHugdMFP8xscTDQvVWoZf+K4HyzT0
	ARBTIcbDUH6Bf+785gzeXOmBkAlcnQQW0QYV8BYCwYuP4GcE6g+63/oQAlxH5l3ekR7/bq21tuO
	4iMeyZ6KIyjDgeq+f2xylL8gY7raxRzeRcgH1rdInfG2f3ko=
X-Google-Smtp-Source: AGHT+IF+pe+VjNamL550YfvLiwpzja5iPw2JpG5LSj5sevXgBPnDhd/LroHyEH2A+QZT+qzzkEG02g==
X-Received: by 2002:a05:600c:828f:b0:462:3c05:3c00 with SMTP id 5b1f17b1804b1-46e1dac9966mr8681385e9.5.1758617582289;
        Tue, 23 Sep 2025 01:53:02 -0700 (PDT)
Received: from bhk.router ([102.170.50.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46d1f3e1b03sm81136945e9.23.2025.09.23.01.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:53:02 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	mingo@kernel.org,
	tglx@linutronix.de,
	mehdi.benhadjkhelifa@gmail.com,
	jfalempe@redhat.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	rubenru09@aol.com
Subject: [PATCH v2] drm/gud: Use kmalloc_array() instead of kmalloc()
Date: Tue, 23 Sep 2025 09:51:44 +0100
Message-ID: <20250923085144.22582-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kmalloc with kmalloc array in drm/gud/gud_pipe.c since the
calculation inside kmalloc is dynamic 'width * height' to avoid
overflow.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
Changelog:

Changes since v1:
- Use of width as element count and height as size of element to
eliminate the mentionned calculation and overflow issues.

 drivers/gpu/drm/gud/gud_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 8d548d08f127..8898dc9393fb 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -70,7 +70,7 @@ static size_t gud_xrgb8888_to_r124(u8 *dst, const struct drm_format_info *format
 	height = drm_rect_height(rect);
 	len = drm_format_info_min_pitch(format, 0, width) * height;
 
-	buf = kmalloc(width * height, GFP_KERNEL);
+	buf = kmalloc_array(width, height, GFP_KERNEL);
 	if (!buf)
 		return 0;
 
-- 
2.51.0


