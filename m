Return-Path: <linux-kernel+bounces-846196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FD9BC7419
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA49F4F06BD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990851E6DC5;
	Thu,  9 Oct 2025 02:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIQZcjHl"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E77B849C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759978677; cv=none; b=a9I0yFfMhJOKhLGutrXchaseNQ2JxJK8v//xmBtKlvSmL0DqlOBxYjI/RM8btccf4Hw//2eDHKLauoNp44o8aTEsL+RE0ynY3G/R0mUjQ65Nlc8HaLy0q6RyqXea2A/O0Fx7OmhuKga/2RNabWe/Cp6xzXF0nnNZ3Y8lerLfjT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759978677; c=relaxed/simple;
	bh=lF7BW2ohCLI1X07kVAARu7zfDJnU4/XAq0NhBy9tApk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKJZ/3/rmg9pdp9GCrtnsaiTYoeCjfWVfR/vzoZSBPwGzxvtcHeNuKlxhWQOlELxRcJ6TC4KlnYv1KWb38bE++UwXHAgz+1pEIClJ2h+5ZDc8WkySvmbHLU7TH3Jv6zj0cE6yQeGeDTZgAjbavKaM9mId4JB7dAZ6O2uNWcnmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIQZcjHl; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-854585036e8so48273785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 19:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759978674; x=1760583474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlG0GD1lh6iJAvDPmOa/rB/T6NwWaH3uKxr67w639yc=;
        b=nIQZcjHlZ1PwaSL0fXgX6ELsoBgDdMETdRevkwI2OSzwZnLZlXisundfX/dPuetQn3
         pBvAlhEY61HYn+1u0UqJEsuPGpxXIG/GBAK9TMYqE4CBaA2ouZaz/OeCQsA6h2PmnIBt
         B2auZ1/N4Pgr5DPkFT2Ok0mjRgjAkitDEEcR3FUNz6238hzrePAKzT6KlyI1Bx0WMMmm
         p0KziYOgQslSg9PfKqz4/0++6Qf1s3SkUJivyQlBFZJSNm0ruk0UmGZG6RRIIWvEUqvr
         tpKjRAyuVxbMRDEnMOgMOA5TxTgJb/fxvDZp9p/NnBXnoZLuouqPWGT/6pjA4sWZ9tJv
         a9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759978674; x=1760583474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlG0GD1lh6iJAvDPmOa/rB/T6NwWaH3uKxr67w639yc=;
        b=a0Gqf+EKk9Tvh1ZCvfHSQAgvSKQ614RbzweY/8YnsUPXbavVafkgIbdLx0Bdaic983
         eW7MJnLwgMuH5anrwIQ0k5kSVrT78k5iaHQnzpC5WsLj6A1eRBrT7KL+xfiQmwLSQ7fZ
         m4iHfiXwySlIABYf34bifP+fWHBR348rcF3tgwuBqVTiXPzAkzW6S8hvRf/xFc7XZlGe
         vyq9qYylQYs2Q6g1TE36aZuUnPPo7+w0xXKAjrxi5QNJiWZbScUhkNauOYI5SpUEL8Rc
         XUT/poQqno1BVgKwyfULHm0nxOgzP3DYqComZDA106kGf/+vDOIptVSgnaITbd8VLs4q
         mRVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMb6805clEobALh/pial/YqwmsnKnfeKVo6vWpy//JY8++k/mhrJ35KWy4BpgA4WYAZbTHqxNbOADM6OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTxvnR+HXhoVi39N5afKnB+OtdzhxvzVundJRmM9gqpoMPT7Pi
	yFruMCSfMQCnjUmSqkq1vnncZAosV7JZPzllSiz7h1kbA1G0c4/1IA8a
X-Gm-Gg: ASbGnctVt0/ljtRyY4kTvYxXy+rRdBVptrVssu6j0iMV+reDQvNLLDkBQ2YgOjQ5pfB
	A7uQRSSELSu5Iu6RMI51olyiULfS9/NVB33GN1KleEO8HqqtocruQvUTq+PE6bTkUj+ZgTAJmpZ
	iwo0CayVQB5DwuK5D+FoZNTtyVh/zhw0dWPeytnQwUdN/1/QjGcu+dWUVB0fIBv+8w+vmSnkyEw
	tqgEfYzyRA7zub4AXdWilsWi/J09SwecH5jPY3UdmdYRq9QfSZ1fE0amwKoL+YaZxxrddEP/gO/
	KzYY2oqZ/Ostu0rypO/rjmZ8/mSTXON9exYZEOy+PeEn84HG8rZPaVdP0dPdX/rVb+3Jeyj56I1
	vQ6DwwnWQrk5j8jkXOclgu/yEdkmHpoMXClMsqqueOsFtxOLNM/mlHTC3N6wxjXbjvcEwJGSjAR
	1EpKXNbqQwGsE2LouOXiBt3GBddW78FkY=
X-Google-Smtp-Source: AGHT+IFeXJCxTk34Ai1JrFRrwRib866Y526WpeJO+H78PvcAR+LJHG+ZBY6j7Bj7ixRivCbirG2znQ==
X-Received: by 2002:a05:620a:25cf:b0:845:8f50:9d29 with SMTP id af79cd13be357-8834d1aa700mr867293485a.0.1759978674217;
        Wed, 08 Oct 2025 19:57:54 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a2369a0dsm114261085a.48.2025.10.08.19.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 19:57:53 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: bfusb: Fix buffer over-read in rx processing loop
Date: Wed,  8 Oct 2025 22:57:01 -0400
Message-ID: <20251009025701.3756598-2-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <77bde79f-2080-4e40-a013-52b480c0928c@molgen.mpg.de>
References: <77bde79f-2080-4e40-a013-52b480c0928c@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

The bfusb_rx_complete() function parses incoming URB data in a while loop.
The logic does not sufficiently validate the remaining buffer size(count)
across loop iterations, which can lead to a buffer over-read.

For example, with 4-bytes remaining buffer, if the first iteration takes
the `hdr & 0x4000` branch, 2-bytes are consumed. On the next iteration,
only 2-bytes remain, but the else branch is trying to access the third
byte(buf[2]). This causes an out-of-bounds read and a potential kernel
panic.

This patch fixes the vulnerability by adding checks to ensure enough
data remains in the buffer before it is accessed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 v1 -> v2: Fixing the error function name
 v2 -> v3: Addressing feedback from Paul Menzel

 drivers/bluetooth/bfusb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 8df310983bf6..90ca5ab2acc3 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -360,6 +360,12 @@ static void bfusb_rx_complete(struct urb *urb)
 			count -= 2;
 			buf   += 2;
 		} else {
+			if (count < 3) {
+				bt_dev_err(data->hdev,
+				       "block header is too short (count=%d, expected=3)",
+				       count);
+				break;
+			}
 			len = (buf[2] == 0) ? 256 : buf[2];
 			count -= 3;
 			buf   += 3;
-- 
2.43.0


