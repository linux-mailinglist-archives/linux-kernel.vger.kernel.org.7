Return-Path: <linux-kernel+bounces-829845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3D1B98095
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C5D2E4B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A536520DD51;
	Wed, 24 Sep 2025 01:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhYNB1tk"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C62878F3E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758678977; cv=none; b=kKIq/fwAYIGKqTISYjaEZwll1x178ZQqSf7mjR9IyU1Rp5ad05zwwpS6Ww05D7p3fL8Zqp10tWjnU3eCgngyTTY/d3F2sUxh9zJK/9xy4uCa7dy3nD+WKVdc3fSE/XlePQmDIOgtM4i13Ut5E26czqPnLW1hLhCSFQDOQdqoxNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758678977; c=relaxed/simple;
	bh=mveThYS13G+7KNQwz76VZIIbZN3IajdbzskP0SwjrSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MHZi0NCGMI5dYUcKvvhrIXBvHujaKnhzOi4pNkCR74SL42F8otm5gZa8Fdh/bp7iXQUfODmLtcFuIHh1eylxVSRGON+oyHf112atJNfjTjm+KrMXoQ4pAvDxEW/RSZ1FWmyPtL6kXarqeoEe5hJJOHc9MUZUkttUOHpzMROW4gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhYNB1tk; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b55197907d1so3439921a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758678973; x=1759283773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4+zYKz1kHy459E58Sn5/cOtdQNDxsj8jPv5CvTyz0Q=;
        b=WhYNB1tkoHRHqtGnBEHiMYYICyRNAey8woMgmBRbtjvlfy3xXrWFbiq4HjjuwretIn
         wfQJ4RecA4UcwU/+7R1vZn+zRbDKelFniXsDeklYetXOLcU/ju8/IRxfM1ylCobiUqhx
         a53bGsG0X+Z3azAQsW5ph+2ZXWG4jh4MBJgOxEW3TRO0ALvDiA9Ts2kbr/D3kHMOhFaE
         chXERV2PrXKWCVOFIBmmFKf7HiIblTxyGTCMGCHEXLNaLc50jhsPUZUnAYFoCuNLozc7
         txEN6wl9iVy+t3X13CMUAmSEtMksrjPUm3zD3sTModcVrKezcru/fWcIKhNK25WaT7P7
         CO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758678973; x=1759283773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4+zYKz1kHy459E58Sn5/cOtdQNDxsj8jPv5CvTyz0Q=;
        b=D2ykzZI0KJmFoJSQE81+cVjn0lFSkOi8g5JtEYl6Etmhhqx/5jyncOaJfSnqt4SNJH
         qusZgEBR6++vBFaQa8tT6bUjOPGQukhUCFQ9JeL6rIbyxiahwEg9QmFGAgtixLs33Zk9
         STwQ32YCzJiJV1XZb5fxrdWO18DWrfrOjuhAOzO8sgsJKiuop1vfkiMxKAgn5tRxudqF
         7nRfmZeW67z3VD5XHR4jmGQsg6gcuuO19DvanOIkCDTVFPruqRbLRKL2zB3n/ZvcCrVl
         nKyuJFePuvzGlYYeWeL+QvZm8D7LmsOXg2KFeO6A7PC/wiS+FT+/o0MeEcLqObx+H1Y/
         JDvw==
X-Forwarded-Encrypted: i=1; AJvYcCWBuaZxeUoM4hZiJXlUiU9f18AfPbz6korNMRQJvMZuIRv7E6C99/XBc+dhjLFwYAC9L14IMnh6347M2/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YznT2xcGn3xh0SxoPCx8u9hnI86vZbMwuqDCfXzMjD4aamcAlJE
	+fdkgxaUApzBQ6bjYIanjYOCN5oqQa8pnG+4Ey5rc9qMdWbooV7RYlps
X-Gm-Gg: ASbGncuiNvwRKNuX2OoRAUxmXvoxLY05DVBnl2UHWlqwnMVbREkYU2L9EXUjyzxU8ys
	sDTi0j9JVaoIX9EPvqaE1QJYmn4asA+X6FJX1ffzi8SORboDLZbQZknErd54Kuhrx4/iPS1ok3h
	7F3qcyEoXOTWwjcHFzpQoig5BTZ9suy9Sh9f6vNqQq4JHCtaSaJTuwo0Edx9c4Qx+0yxrB2Adas
	Rq9wb5UHDhRWNHgNIKH5pNO10byTIs6iCN+rK0Vt7tuMm3mOopk7ulw91o5ou5QXDUyavgnAMAP
	d6hSkRCVRniJhYSbluDZfr1fkoRlOBWvVVwlPbzISwhSsivv0T1/FOigWJSwHgQiN4tikwIJnGM
	HLxppNxwz3Jou+xqQwDRltORsdV92vD/VFFpurwb9ikiHevFuz16ENUbUsjg60x5kq11u5t/jMO
	Ndgw==
X-Google-Smtp-Source: AGHT+IEBlwBOgeFyu+ftXErZj0XmIMLoGEfVrAjBJfNuSrd7qIFwYoitM5ulTDc1r1vZ59HBSqCqGA==
X-Received: by 2002:a17:903:19ec:b0:275:c2f:1b41 with SMTP id d9443c01a7336-27cc79ca055mr46304915ad.53.1758678973465;
        Tue, 23 Sep 2025 18:56:13 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:a860:817b:dcc:3e4a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053248sm175418655ad.15.2025.09.23.18.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 18:56:12 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com
Subject: [PATCH] comedi: fix divide-by-zero in comedi_buf_munge()
Date: Wed, 24 Sep 2025 07:26:06 +0530
Message-ID: <20250924015606.1098345-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comedi_buf_munge() function performs a modulo operation
`async->munge_chan %= async->cmd.chanlist_len` without first
checking if chanlist_len is zero. If a user program submits
a command with chanlist_len set to zero, this causes a
divide-by-zero error when the device processes data in the
interrupt handler path.

Add a check for zero chanlist_len at the beginning of the
function, similar to the existing checks for !map and
CMDF_RAWDATA flag. When chanlist_len is zero, update
munge_count and return early, indicating the data was
handled without munging.

This prevents potential kernel panics from malformed user commands.

Reported-by: syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f6c3c066162d2c43a66c
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/comedi/comedi_buf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
index 002c0e76baff..786f888299ce 100644
--- a/drivers/comedi/comedi_buf.c
+++ b/drivers/comedi/comedi_buf.c
@@ -321,6 +321,11 @@ static unsigned int comedi_buf_munge(struct comedi_subdevice *s,
 		async->munge_count += num_bytes;
 		return num_bytes;
 	}
+
+	if (async->cmd.chanlist_len == 0) {
+		async->munge_count += num_bytes;
+		return num_bytes;
+	}
 
 	/* don't munge partial samples */
 	num_bytes -= num_bytes % num_sample_bytes;
-- 
2.43.0


