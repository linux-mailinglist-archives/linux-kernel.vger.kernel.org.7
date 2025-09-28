Return-Path: <linux-kernel+bounces-835346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75456BA6CE7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A61176957
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710DB2D4B5A;
	Sun, 28 Sep 2025 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIu3OgHC"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C61C4A0A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759051108; cv=none; b=XTyYnKLuydOlLklYZm8ccYMjugbJUPBsLUpWePVv48QYbnOCt1kOzFKH3M+FHfcJaDPuSGPJ/0zwV53rqa2A6JNRh4KiMp3cPnjJaMuXA4zTTf9mW7Q4rMn6i9PJSSrdA/rZnqI6OETRmZvl3OWwMYm/U47QjC1Ut0YNCWTZYNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759051108; c=relaxed/simple;
	bh=ofqEcQ9NXDQgEKIfDsHRwO/RRELrot1TTFph5IPeXGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHFHvSAk6lXEEA3vD/R3ykEvxFDgv8TOAziCoROn+6MK0gc281aNp35nnDKdfaTDm9b/adIIN9BSF/HquEhfcBSO5zCBFaOrF8Nn84N3h/C6k2K9v15hKfQUtRvAHoQRnhSg+0sHl9aonFCEX/ICcYVCCkJr3gSEJxHPbI7V8Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIu3OgHC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso2404395f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 02:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759051105; x=1759655905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QBCINZFXBb6AVWDqgr+Mk+Uw/H22zFl0IVt/zipxIk8=;
        b=CIu3OgHCHXM/IvLnDUub/7zJfqN5atOiIIaZbpzKmEy5AbOkxKOm9eJJWULYcA04Xl
         ep4Bvr9YuwRKWftKO6P/LkkRpBK8o/mXTBhZfMP4++GxOsnsU2PPJ8tHSe8UY0vMjvtU
         xxV/BCNe+Uyt7iNfDQZcqe/eEfZVfyDVExOGbWA4JtSyNKW9OFHEfxPEoJyI6ITR3za8
         304x4NkvKR7EF5U+kGsB4h5AeFKADu9ufPCw6B7gU2Oelbhdq06BLz5gysC71cVdF8sd
         /XIcTUEx38Ci9IyJmbvNi8aUrX12bA7ox/25SPOl+NQx6+RZYz64UMXPu7XC8z0ew8VU
         Fztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759051105; x=1759655905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QBCINZFXBb6AVWDqgr+Mk+Uw/H22zFl0IVt/zipxIk8=;
        b=hlSscRtdK/7MYn4ET/Fdrhv4qrWmiKEIMl1V4nxICxEnOBn8YG+H+IJud2dr3bm+Vk
         sorzShHz6/cD5SJeSXnL0Ib4s3CpqdH3uQxFJyjZ27LkkqYDxyvImmm/OQmDmWoXQRO1
         KjrqDUOvt7Kf8gVoHVGI3ysjLIvIv2FFl6VwLUqyfzHwHBIQPYr0zy4gPrUAOwUPxVeA
         DUVR6QUQ8Dvq8iOgDzgO6DX36wKqvva+7SUkxRsOo1rra3gs9BlGEcs1olRObsZKBYeO
         tTM0vuc+J9kTHl6UoSrAo4s+hgDQwoOl6EcoJqPXgfywrRrXlfWGOCzzYMWe5uF5uAEs
         wpMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGmAp74SpWSuamVJSxH3ZYCbQmKDvyhIGdue/8+Fv/ColUazc8qxuvc0bcnVsaqbDmmFBFDBrtYeELX1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTM1kkydsIAUt0O30eOMC8YzINDf99L7Alf57bFIxYlBdVSmlj
	hdp9P8seqW2lQM4PQJwo1TM9Xh7JKzyPsZ/VtA905mMIIooSPdJktdGW
X-Gm-Gg: ASbGncv0OyIYLZVvBo0VRcvJyk5ig2tVWd6FFvXwLVjhAYZc3xDijXiI7CAOhcKA92q
	XjvA9PuX4tEZvGKQAJduUEYJyTWce95j8RLZUSrStOCfHriYU/+cMJZV8KHMuxE4OMfXbrhXKNA
	RhT/2iGbX5s7Wn03lIMuwwrnVuhv+cRckN2sOLeWnVwJ4nhNB2EuHJ+cXj88wo6/ZWkBskNGEpJ
	USssJYK1XCYbd1iE6SGA64uZve+rvdkoxTYwdhsM+u6Z/2GijSPbXH/3sDYOiD/4Z6F3G3kC9oF
	OwUakoqo/OQSKW2yD5gNo+FCcD+IQF3ZaWEAEiQKig9JqKmBpca70EXq6yke2QsAryvlmsyQ0LK
	LXQHW7uh4vlwRKVoxoPJxpCD5MrYq63oT4LmOaQ1JunwpfJd3
X-Google-Smtp-Source: AGHT+IErP8ERPQgt2nHabO2vaauhPtQUS3TOjxY7+8HVednMIgZMbS0DXgA80j05eErJB8vH8T+2WA==
X-Received: by 2002:a05:6000:1acc:b0:3fa:ebaf:4c53 with SMTP id ffacd0b85a97d-418077a5f34mr4553981f8f.29.1759051105153;
        Sun, 28 Sep 2025 02:18:25 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc7e2bf35sm13859710f8f.53.2025.09.28.02.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 02:18:24 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH] staging: gpib: Fix no EOI on 1 and 2 byte writes
Date: Sun, 28 Sep 2025 11:18:18 +0200
Message-ID: <20250928091818.4243-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EOI (End Or Identify) is a hardware line on the GPIB bus that can be
asserted with the last byte of a message to indicate the end of the
transfer to the receiving device.

In this driver, a write with send_eoi true is done in 3 parts:
  Send first byte directly
  Send remaining but 1 bytes using the fifo
  Send the last byte directly with EOI asserted

The first byte in a write is always sent by writing to the tms9914
chip directly to setup for the subsequent fifo transfer.  We were not
checking for a 1 byte write with send_eoi true resulting in EOI not
being asserted. Since the fifo transfer was not executed
(fifotransfersize == 0) the retval in the test after the fifo transfer
code was still 1 from the preceding direct write. This caused it to
return without executing the final direct write which would have sent
an unsollicited extra byte.

For a 2 byte message the first byte was sent directly. But since the
fifo transfer was not executed (fifotransfersize == 1) and the retval
in the test after the fifo transfer code was still 1 from the
preceding first byte write it returned before the final direct byte
write with send_eoi true. The second byte was then sent as a separate
1 byte write to complete the 2 byte write count again without EOI
being asserted as above.

Only send the first byte directly if more than 1 byte is to be
transferred with send_eoi true.

Also check for retval < 0 for the error return in case the fifo code
is not used (1 or 2 byte message with send_eoi true).

Fixes: 09a4655ee1eb ("staging: gpib: Add HP/Agilent/Keysight 8235xx PCI GPIB driver")
Tested-by: Dave Penkler <dpenkler@gmail.com>
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index 94bbb3b6576d..01a5bb43cd2d 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -182,10 +182,12 @@ static int agilent_82350b_accel_write(struct gpib_board *board, u8 *buffer,
 		return retval;
 #endif
 
-	retval = agilent_82350b_write(board, buffer, 1, 0, &num_bytes);
-	*bytes_written += num_bytes;
-	if (retval < 0)
-		return retval;
+	if (fifotransferlength > 0) {
+		retval = agilent_82350b_write(board, buffer, 1, 0, &num_bytes);
+		*bytes_written += num_bytes;
+		if (retval < 0)
+			return retval;
+	}
 
 	write_byte(tms_priv, tms_priv->imr0_bits & ~HR_BOIE, IMR0);
 	for (i = 1; i < fifotransferlength;) {
@@ -217,7 +219,7 @@ static int agilent_82350b_accel_write(struct gpib_board *board, u8 *buffer,
 			break;
 	}
 	write_byte(tms_priv, tms_priv->imr0_bits, IMR0);
-	if (retval)
+	if (retval < 0)
 		return retval;
 
 	if (send_eoi) {
-- 
2.51.0


