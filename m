Return-Path: <linux-kernel+bounces-883227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF7AC2CC80
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 008DB4F1013
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBB21C3BE0;
	Mon,  3 Nov 2025 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="vYGrqKn9"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6430218EFD1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183323; cv=none; b=VDH8HAnNEkYrw/r+wmbKE0rXUFoeVPZPlAbA4cB237ewKc3upIyziLIUELjZImniVTtX4n/NfS69Gq0Bo8HD3KbM+bB+xM3TidfhZA64xSsg7KoJ8WTwre7BmIWw7IO6LG8EqMX6a28IS6PJT3Xgnu2N2Q20vconlIbXGSD0Nps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183323; c=relaxed/simple;
	bh=W0H8wIzq7DXfBe93EKD+bbVEydLWibfGwgLHwrs8l0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E34kym3GVsMd+2RzNUyqlD1D9Swy6T/hdwPlcEfThoQ8DU7luoL79ZI/5eLTed/rbBn1ERVe2jmvRz+XqMgO5KmNkvHCJvssHr3dFjh7n2+jGQHMBGtl6dvFKb1qb034pkckgfX1cUIEaj6BLG0QGAnRFR3xZR8MdUbplpSZT/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=vYGrqKn9; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so2781232a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1762183319; x=1762788119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sq46i+h051lR0zNhATSUzIFpyE1tPhlJ5BeZkc/DJ5Q=;
        b=vYGrqKn9GYRMWXKSWimERsZb2dkQNyryR9toUSCqdSYe098UAvrvuFPug4tDlF8cuJ
         33o2bKU9DrpmueU41q8kmkLXLa8rpGlTSCzoQMhpTStG85c+/FvcBgUY5hzk5TmWrDtW
         Pqupz97fEE8qeXttwRcfJFiyIlY3I1d91cRXzkOUsnrJndK2qfjM7e8Lf95oVjtKWrbe
         Y/ghabMSLBekF9gfkQJn5Ivom0ar9WzY/WnYVeOST9hOBwwmnV9KiPd+dMRCHEComT9R
         MY7eJF3t1dN0Bj4kLSxabOkxGm9Qku7oLFgOoGU8JsmAkR+waVkZFMQSCWWRY5oOhcvq
         UgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183319; x=1762788119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sq46i+h051lR0zNhATSUzIFpyE1tPhlJ5BeZkc/DJ5Q=;
        b=T4684sDinlDPcqXJIKIYxdv68imm0TWh9OYXz2ZqZFIVUviHttgAn2N08EzgceMDGc
         b6jdD8dzgGp0TR3/XH0PeUw6eFriFnthZLWnLWFzLoJVIS/7F3EK3I0dYsa1923b53my
         nslZddgfxu9sL8RFNp2Pkjj000sHP8QL4vxuoOwxT3jZozUz0H1jl8n/55MOZbLdgk/z
         Sq1nTqmW4mKoOuHn5DpE3r3Vu2iKFIWqSvhKd2LnS77i7ncyGENWnrcfFOpfJC3mHUWe
         27di/bakCTvClFe5YAx/zZUSBmWrQdedb4OgNSaOea7fph4qB20dQIco6cp/YugP6Cwl
         oZMg==
X-Forwarded-Encrypted: i=1; AJvYcCU8nktr5G5xfFTKhjUDxcmyFH6xx3ABm4fsaPGM8lJEZJ7a9IT4eZcDXNgzaH3/xC+btcxUHayp/9eH9K0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6eTH6RSu+SegblKv1k5d1ihtOIgeHwzPGX5ApijsJa0ZM9uC6
	60aGRs7KETeJPGEzmZVUi6ZHOUse0QqgRkHi8Yx4w8x4jlNCPJGABdYvhHpupyhEIQg=
X-Gm-Gg: ASbGncsjvXXoWEAiTf43sBP5vVWPhSiJOY1RMuleGIAzgBAtIcvcubcHHExnzi4rFCH
	3nOf80BA2LNHovLVVnQ7ONIBvLvkrWRGfR5eNEGUt/KoqBwLxDTNdcHKbxVGfDfTyE1IYbRVbPn
	I641dP4dQh2ssBALg0EcOhf54DJYg0ZGAw6/MJmc8KcgbKuRCoNC47zw88iP/22nyGeQuKWtcnv
	yCcT0epA5Z0CMCsxn+cfoPsF0g5zUoHdXEdJ/36eQjIWHmHTGSpLiSi58XFTLoiT40/cMmIqRg4
	Z/wKxNrsaqE+c6QtainXqcKq2rTGW+Y7RB9mb1nuCWUncLLEOSkecT9Br2eH3UVpSZz+ywDrMjr
	6sqbCKIDt1CYuy7cVu88cnuUofChDXTIj/gXH5+cmKPC3CozU+I5Vf9N7+3vc81OR2Wrq87MbMc
	Bv/f5IOenWdY1hJg==
X-Google-Smtp-Source: AGHT+IEZ36hQAR3lqXiWLha/EOf1Hq+fNo3sVkRglt1Vo/PD+PWu8Ym2w1I6vWFecirPPmZz+rgQiA==
X-Received: by 2002:a17:902:e803:b0:295:5a15:63db with SMTP id d9443c01a7336-2955a16fd56mr110344515ad.61.1762183319268;
        Mon, 03 Nov 2025 07:21:59 -0800 (PST)
Received: from localhost.localdomain ([49.37.219.248])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b93bf44ecdesm10731534a12.37.2025.11.03.07.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:21:58 -0800 (PST)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: miquel.raynal@bootlin.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: maps: pcmciamtd: fix potential memory leak in pcmciamtd_detach()
Date: Mon,  3 Nov 2025 20:51:39 +0530
Message-ID: <20251103152141.57160-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for struct pcmciamtd_dev in pcmciamtd_probe() is
not freed in the corresponding remove function pcmciamtd_detach().
Fix that by freeing it in the remove function.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/mtd/maps/pcmciamtd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/maps/pcmciamtd.c b/drivers/mtd/maps/pcmciamtd.c
index 2ac79e1cedd9..206a3c463e6e 100644
--- a/drivers/mtd/maps/pcmciamtd.c
+++ b/drivers/mtd/maps/pcmciamtd.c
@@ -665,6 +665,7 @@ static void pcmciamtd_detach(struct pcmcia_device *link)
 	}
 
 	pcmciamtd_release(link);
+	kfree(dev);
 }
 
 
-- 
2.43.0


