Return-Path: <linux-kernel+bounces-872991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8040EC12CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F97D461BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E276B27F18F;
	Tue, 28 Oct 2025 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4cefW23"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92A6242D84
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761623066; cv=none; b=K1XVv6FCpFXmuOcDP58QUDtyFGvMN/76FTzt1VCcUfIh0CuIvMteEsH1REn9u2VGkhjMS1TDcJE8BSZloHJR6K61fvCPCzRCL/nvObw9qTTnnARvvVnyJlV4JUtB5dxXrhrh7J54XXuiGiRL4b9ASnGskMp48LqmyeXin47Mijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761623066; c=relaxed/simple;
	bh=RENY3oPuBzYjGraycm4NaWcxhyTA5BMczejzi/9+Osc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PRLKJbTkaRGUuIeJWV8OKhNW3k8urkkzR3cBjbWMGZEJxr2ZGyVPW8j3septhetCBVJotNABVLr/dEgMUXxdvN0RpnDAhNvpjWXxjIwYkQM0w7Vgl38y34fVgDC5iJh2rty5H1XMqPK9+TOqu4s8z9d3wblJM/Sqt5N/exHimkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4cefW23; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-793021f348fso4750181b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761623064; x=1762227864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w0JrnIhlm/tyRktTDJR6cB/aVJVLzjS3bo23HpgjFIA=;
        b=B4cefW23QbxYjBWUE4CnJ++EM+aZg50LcwltldTGHXoCD6Tev1GAQVducrglQ0NuvC
         CxYQmVBb/7JN3HwNvmTZMRfrUZMhDLUKMG6UcBRrzMxBUJzqKw6r1xEUNo3Ux2X8ZvaJ
         4izxNn/jSU5ABqVYGWoTsxQ5AynLjBwOFhxClkG6Zv1IJg4bAbZ359yY13OqRMkNHf9G
         9jL2W+ArXS6Dq4iqhX9qVLfCp4cLNxjAa96sy8Uwh5zQ/1CUzfX8Rwo2CGcWf26AZz9q
         7OrmKjKYErRIzMDW9l/5FBJ0VxvPhQljjYUVM9qLAuEfnb5qTe3t3rAmSXXKPH7a0/gm
         8dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761623064; x=1762227864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0JrnIhlm/tyRktTDJR6cB/aVJVLzjS3bo23HpgjFIA=;
        b=vLiDAn3JFKisU0e4NWYsMx36Hn7ETMp0lunm/29f4BIuXIKk8mh26JL0kv/55VPrVC
         HPnKNf90A3p8KqU+/rL+sY83SC0PNJvBX5x/1BokRN/bnMOjPMppdVeaIhVfqkjCga6l
         rpDpjxrQjlTiXpMnkdX55SsVukKB4rRwYWdI5npwKn2U+DAarz5fVKwZ+uvlrjbJCMTK
         D3ogTlMASI0XkFey9htCn8K0sZGudWzKZ2htGQj4GZfPp1onxLFx5LXdNKnVahEAArWe
         14yBEiIJ5JZs/0j/n5V9TwSATKteulUT7OtixceSQmunsRJptKhZKHe74FKQhDBU2Tj6
         +4Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWKPxyE4Gq6VACG95UVxD1xjr9WMur/gbzdjlTraqj2xCSrrjPMYafcL32JmTOJRr49/p6jjJ2bEMlxDGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4jWZvhmD7OtsBljgKfcGpbgo3a5ynR38svQlG4EP5cnzpzr5b
	QsDNfGGdyRPioCP4m0LY6FMsc7N0bdtse0BTHKOU4uhcoEbFFCjHwKNR
X-Gm-Gg: ASbGncv9lKBk0KMJrtZF+9a5hBVcrm7zgruZfLu8vydECqe9aafX/NcgzP06893gbT5
	ofjTKlcU7bKsnRIhx2HgsQkRtMyb/33L4tsaa02brDgzxO0KN7J9aTFkm87raK8oMsGlAggcWm3
	BqdiFAdRrPu1LLRhdAZKwPgobQ1GEmPggrdl2QgHLis0LwL1OARI9ZKZCHSMom0l6VRvrdj/LB/
	mIT2YcJPPJ2laOUBHsUj5mrcAGIaOCutcVtj3qHb5KsyRzZoOuQdDL/oBoW/v1Zwwbnw5u4lboG
	f0UDQ0kKNL/UJIUAdORJ7G2n9lvFvkr1vYXrujAl71AGee8+LhqBb1j94y0BmGx0gBCLKQi9AhB
	Ehf7crmyscHynMmFn6wis0m8B6RqtvkoOScfHcsZ4p++++F7YpmbILeeFDAAgLH7skyPDJTBQYQ
	0kmILMnrbFPF6pdspa+AsnQeKhQA4oNzYi
X-Google-Smtp-Source: AGHT+IEt1om1kfGFI7LBBAzYyTXzZGznvpM+rLoorZyrqYnofQVBvIAI1Vb9MVfEwmR1vGMeyTbZqg==
X-Received: by 2002:a05:6a20:7343:b0:341:3b91:69d1 with SMTP id adf61e73a8af0-344d1da82demr2405551637.5.1761623064155;
        Mon, 27 Oct 2025 20:44:24 -0700 (PDT)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:7eda:5d15:414e:cb9e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712f0c0b1asm8946849a12.32.2025.10.27.20.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 20:44:23 -0700 (PDT)
From: Chintan Patel <chintanlike@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	maxime.ripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com,
	Chintan Patel <chintanlike@gmail.com>
Subject: [PATCH v4] drm/vblank: Increase timeout in drm_wait_one_vblank()
Date: Mon, 27 Oct 2025 20:43:37 -0700
Message-ID: <20251028034337.6341-1-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, wait_event_timeout() in drm_wait_one_vblank() uses a 100ms
timeout. Under heavy scheduling pressure or rare delayed vblank
handling, this can trigger WARNs unnecessarily.

Increase the timeout to 1000ms to reduce spurious WARNs, while still
catching genuine issues.

Reported-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
Tested-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
Signed-off-by: Chintan Patel <chintanlike@gmail.com>

v2:
 - Dropped unnecessary in-code comment (suggested by Thomas Zimmermann)
 - Removed else branch, only log timeout case

v3:
 - Replaced drm_dbg_kms()/manual logging with drm_err() (suggested by Ville Syrjälä)
 - Removed unnecessary curr = drm_vblank_count() (suggested by Thomas Zimmermann)
 - Fixed commit message wording ("invalid userspace calls" → "delayed vblank handling")

v4:
 - Keep the original drm_WARN() to catch genuine kernel issues
 - Increased timeout from 100ms → 1000ms to reduce spurious WARNs (suggested by Thomas Zimmermann)
---
 drivers/gpu/drm/drm_vblank.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 46f59883183d..f779103b261b 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1303,7 +1303,7 @@ void drm_wait_one_vblank(struct drm_device *dev, unsigned int pipe)
 
 	ret = wait_event_timeout(vblank->queue,
 				 last != drm_vblank_count(dev, pipe),
-				 msecs_to_jiffies(100));
+				 msecs_to_jiffies(1000));
 
 	drm_WARN(dev, ret == 0, "vblank wait timed out on crtc %i\n", pipe);
 
-- 
2.43.0


