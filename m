Return-Path: <linux-kernel+bounces-757650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C748B1C4C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB6E62102C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C3C257AD1;
	Wed,  6 Aug 2025 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6JjNDbX"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF771F3BA9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479303; cv=none; b=aI4Ux7CJ0A/EGu9jYoIX/S4uVkyQUHmo3bZMiauARJ9vQPhkHQqlHDQYJRHxphrjzCTDEntutrcA1yb3GVauTrxm+XNRooCuPWYa8NaCeZZiKMLvACwRHtihkFDU0QfRxzmpeg4rJfLae4wBwViTXIEj9N4K1mycMtvigVscMOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479303; c=relaxed/simple;
	bh=ScgJmxQeSgWvxAdU2JDlT15LUAAmWbzYbxAxHxM68Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTdyRG0VhMfxW/70V4NSCYsx6iacJv00qUfqIX0y5H7NdYMaBc/1gIdNM68NDcG5sJIiqHYhLatn8evvpZDYPbKO6KouEMtD0rl7kmGmKz2fktcQjJ501HDzD5ZXopsIgcpUxhhHytmyGwwc4o8dPo1gZsaY0OTyyBQccsaOb3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6JjNDbX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23fe2be6061so5962545ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 04:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754479301; x=1755084101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=udQy1oQJOraZZeifLInZy3dbifbY55aMQYh60VZ4m7c=;
        b=Y6JjNDbXuhDpFTlzD/mkK5TtRETcLQYcKuowETKZpNQeKJHXCwqXt8UuikQp0EMgNh
         jOmHXNDneTqsvN4x+YdBQndFutkT+COW7S/OZr41riN6WvobLzG93frRse6hX472Z2q9
         IQYPhro7K51nxxl/Oe1f1OduzuoeZsLgTgA29leiUma2CVcxVBsSPAoef1+gTtbKCPy5
         11KytyGIzeQvAQAz1kIQqnwIf/bQqD2pQIWLDWMRHRmui1l3N5Xaesay0eRxw5+NO0i0
         lQCOqhRYN0KlTudaeud3W/eXEuFP12+54PjxkooMhMkjsTxoCrXQChkivV00Nhpw09G0
         txeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754479301; x=1755084101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udQy1oQJOraZZeifLInZy3dbifbY55aMQYh60VZ4m7c=;
        b=mSTya5oNOYdxdysyohBhOJs4MOV3dwxr7/QtJSN8NZxK9mp+xmMysphTXAq8UU4/9s
         cnzqkAtIKkAWcjSbnqJUvCxDQjBM0DHmZNXNa2y+2uplD80JZs6Dw/j55Y6PAZu0mMoL
         0QHIKKGYSJhBHRw+N/49YEDyKq1ERZn+1AFLyYQfz1+Fk0FCcCBReJ1fzJRwgmXAdaTL
         IvG8K5s6MpzvMDRm54lkHYDXGozAmun3sf8NfSaiGXvH5c4swQwuF81oNkMqEGAZSCI7
         c2ufkT6lvom82YFkbA6JOhkhez79DA2Fe9VdiU7M0i5gMw7VFDn4u9iS0BLKlqvuM4J7
         nOAA==
X-Forwarded-Encrypted: i=1; AJvYcCW0pxoLdettgQLgtmnEHD8z5VO1wStOMtib7BkJFU/ZM8uEzhoAfg4ZX1j3aaVvxY7bP38ey7m8cFcV/a4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6GyJNCyQfwb9P+fHNKyUosei6rJZLyiFoQWlHMnjJdenEzznJ
	yhhpTCwocrfK9cYCDbj58M525x1FIZxCfX//SeZHF9I2TUW5LWMJGA3H
X-Gm-Gg: ASbGncuS5yp5ChaSj1uYnhcQWB6ak2uR/e6ieoAokHPsJh/0hOMjnMTnXITS+LUa61S
	DBXN2reyF+3oO1EpZ9DLLjrnQjvQr1xtJtwZPVeU2TtO8aWSwi0Qs5Kd1IU7ciHYds7VbB2a7OV
	h6maFZCzKr9fRz/7HQit7mF1zN2cqMg3JMj+KnTh+mHItU2ESguuStN7Q4YOJvPz5m6wb4NhYy2
	M2wh6AQpaCZcq7ZD9POipYTqvVdglrxBUyzAP5d3OAS9lKA5vOeBfkno4oGOIVIELqtifd/5LXs
	1Tnid5HAIP4hGS+fZ1dg5TdIoXC73p5/1TY/QLgcxUqNBOJyd/bUAhI23B5Tpj40JQhcK6PBQ8+
	KdC6IuiHpeRRK4zErm2w+G9Jp3u8C2zY=
X-Google-Smtp-Source: AGHT+IE6wptvdZC0VAFviQVg0AlXF6OF4wkxkGE0X9aYVMpt/MOrq4TxNhEwP+PNJouNBYedsb/uZg==
X-Received: by 2002:a17:903:4b50:b0:240:1ed3:fc28 with SMTP id d9443c01a7336-2429f957616mr35022425ad.12.1754479301212;
        Wed, 06 Aug 2025 04:21:41 -0700 (PDT)
Received: from localhost ([61.152.208.176])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241d1f13a31sm155040335ad.64.2025.08.06.04.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 04:21:40 -0700 (PDT)
From: "mason.zhang" <masonzhang.linuxer@gmail.com>
To: chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	masonzhang.linuxer@gmail.com
Subject: [PATCH v2] f2fs: fix CURSEG_HOT_DATA left space check
Date: Wed,  6 Aug 2025 19:21:35 +0800
Message-ID: <20250806112135.3434-1-masonzhang.linuxer@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix combines the space check for data_blocks and dent_blocks when
verifying HOT_DATA segment capacity, preventing potential insufficient
space issues during checkpoint.

'Fixes: bf34c93 ("f2fs: check curseg space before foreground GC")'
Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>
---
 fs/f2fs/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index db619fd2f51a..d8dae0049b6a 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -649,7 +649,7 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 				get_ckpt_valid_blocks(sbi, segno, true);
 	}
 
-	if (dent_blocks > left_blocks)
+	if (dent_blocks + data_blocks > left_blocks)
 		return false;
 	return true;
 }
-- 
2.48.1


