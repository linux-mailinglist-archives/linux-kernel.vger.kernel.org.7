Return-Path: <linux-kernel+bounces-817721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 217ACB5859F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28F657B2775
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD5E287515;
	Mon, 15 Sep 2025 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URrTDOqs"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB323E229
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966115; cv=none; b=p+zZYOr5/Hkal+Y8tHhJebjeS00Mo3LkMd7BSLPaF0LS46kkH67hPaP5QtLM6bWFx7vQcBiKrVK2n90oZ3kmoHwgONXNpCoBq+Hks6/4pckbd3FUDmV8qzYQ4Ub9uKedKUwR6lAxq/iJMoyV1MR7Ii0IP/gNyHmSdGEZB1wAbmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966115; c=relaxed/simple;
	bh=oX6S3cWQPf1Wb59k65AxqPaya62lhiPp4qMPjhmTyNc=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=RMrIeMzQRQsO2R4Nwivfz4DVrRBejjQ8Ky+05EB27VnLu6gV2gCoW3Urn0WjLoW94MlEij9vZyFG5sMUa+8aYXmsm2p6znriSDGBcEFEbbhtqh6QgeJhLv3nC/l/Q3OOU6FoL64qI8xTjBPDNWRjajNohcTDHxf+rBvEr0cjLZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URrTDOqs; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8250869d5d8so397948885a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757966112; x=1758570912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LrHpUBXq6LbkNxh4bGp0NBkouZcQAg01k90RPNhfloY=;
        b=URrTDOqsZlnEx07R/uklzEm654OnofT6MxN5fYpSgrPXi71RR0Mgyp5e2oAaTOfBj+
         Qflz01ocnq+fLRT7ZNJyI8C45GR4FtDbjhRfQvlrWpi/8PUwY+eSzYyZhUdUrps+O46X
         bPq2ytbrtX/wY3jafv3I4B8E4LeIIJOLschV0TBH+7MO7n8Lx4J97+maw1Xa816Vzgh/
         huErKJiBxKZVm+jejUQBEz80v++ccXsLQ2ClqkeG0asg9HbYzLlbIl7gtl8XaGONmXTA
         sfWRzf3pCRu74zXq1P14Vk1MOhHCGR73FI+3Z1FAJSWB6Gm7be5u8PIf9jX46hLyV8Ru
         JT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757966112; x=1758570912;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrHpUBXq6LbkNxh4bGp0NBkouZcQAg01k90RPNhfloY=;
        b=m0Gkk17B6i7IJm78EusbRIwUJ1J+Si8s0t/O4hI9croHIUJDR8msCvirfOcbFvDK2h
         ILszamrZQqpWWDfrgzTEC5TyQIrE9N15uziaWqqGm81XhJ6gvSd49aFUgrpkPVc8n4xL
         qIJo+e5i3ajYOdpuVpWKoLHa/bm2+p36y/t4zbl7luimsDpZzKQeQAjkj0o43f39+LsC
         GsdDtUhpviJbJrjYP8Z1Rc9N984t4XZGsHfhWuLEzoSnPD9P1MQ46bJwroNdR9UEDo0C
         /mWszJHCBbUSmfKAyenAf1M5yOT3lIuMHXODPsElD0iauGnjuZ059uDxIQT/Z9bPmlF1
         2haA==
X-Gm-Message-State: AOJu0YzW7C+cQ+CVGIRmZT/PXKEOGInYvQJ2wUAx90A7gyXBi5FV4pDf
	/m3a+L4d4DLi9FHDX+ypCck010q8eO8oIVyqRWu2QpUK9YAB6g2zzIxsUjmQFVjqTxT2hnNAysH
	Za6X1Mo5+8XqJUeow+kEqBw5A5HG6iTtkVQ==
X-Gm-Gg: ASbGncsmOmqqBK6joWXfwZcq+Y3FA74eGxOgS9xCXyUBFxG38z1XRIdJyyEpJjWWXI0
	+8LG/XSwDHPpf7Ro1FtzlNKb8cI4vbYAtqIa2UbES9gfv1ZmucBZCWeHZEj4Bo7yBESdS5zVvMp
	CFgw8ZX38dPimz/lQLyy7IhMaY6S+qOLRdGpd17vcU2AXgEHXbO5nRW/7F5tYd498B44i9zzM4q
	ru9AJ4=
X-Google-Smtp-Source: AGHT+IFUzzuKQ8JsfJOXQyRYVUMVYOuuFNnM/IAsaG2fXI4NKfNZLDWdB0liX7BfPt053GTWuMSCzOJ5Fhqsf3ub5oA=
X-Received: by 2002:a05:620a:178a:b0:82a:1dc8:2139 with SMTP id
 af79cd13be357-82a1dc82187mr450528285a.13.1757966111509; Mon, 15 Sep 2025
 12:55:11 -0700 (PDT)
Received: from 377903785069 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Sep 2025 15:55:10 -0400
Received: from 377903785069 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Sep 2025 15:55:10 -0400
From: Forest Crossman <cyrozap@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Sep 2025 15:55:10 -0400
X-Gm-Features: Ac12FXzjEDjGuN-06MEOsUYrs9iJmmp3HVtQ3bq0H83JzQKrw5fDVigzNACASBA
Message-ID: <CAO3ALPxU5RzcoueC454L=WZ1qGMfAcnxm+T+p+9D8O9mcrUbCQ@mail.gmail.com>
Subject: [PATCH] usb: mon: Increase BUFF_MAX to 64 MiB to support multi-MB URBs
To: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The usbmon binary interface currently truncates captures of large
transfers from higher-speed USB devices. Because a single event capture
is limited to one-fifth of the total buffer size, the current maximum
size of a captured URB is around 240 KiB. This is insufficient when
capturing traffic from modern devices that use transfers of several
hundred kilobytes or more, as truncated URBs can make it impossible for
user-space USB analysis tools like Wireshark to properly defragment and
reassemble higher-level protocol packets in the captured data.

The root cause of this issue is the 1200 KiB BUFF_MAX limit, which has
not been changed since the binary interface was introduced in 2006.

To resolve this issue, this patch increases BUFF_MAX to 64 MiB. The
original comment for BUFF_MAX based the limit's calculation on a
saturated 480 Mbit/s bus. Applying the same logic to a modern USB 3.2
Gen 2=C3=972 20 Gbit/s bus (~2500 MB/s over a 20ms window) indicates the
buffer should be at least 50 MB. The new limit of 64 MiB covers that,
plus a little extra for any overhead.

With this change, both users and developers should now be able to debug
and reverse engineer modern USB devices even when running unmodified
distro kernels.

Please note that this change does not affect the default buffer size. A
larger buffer is only allocated when a user explicitly requests it via
the MON_IOCT_RING_SIZE ioctl, so the change to the maximum buffer size
should not unduly increase memory usage for users that don't
deliberately request a larger buffer.

Fixes: 6f23ee1fefdc ("USB: add binary API to usbmon")
Link: https://lore.kernel.org/CAO3ALPzdUkmMr0YMrODLeDSLZqNCkWcAP8NumuPHLjNJ=
8wC1kQ@mail.gmail.com
Signed-off-by: Forest Crossman <cyrozap@gmail.com>
---
 drivers/usb/mon/mon_bin.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
index c93b43f5bc46..e713fc5964b1 100644
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -68,18 +68,20 @@
  * The magic limit was calculated so that it allows the monitoring
  * application to pick data once in two ticks. This way, another applicati=
on,
  * which presumably drives the bus, gets to hog CPU, yet we collect our da=
ta.
- * If HZ is 100, a 480 mbit/s bus drives 614 KB every jiffy. USB has an
- * enormous overhead built into the bus protocol, so we need about 1000 KB=
.
+ *
+ * Originally, for a 480 Mbit/s bus this required a buffer of about 1 MB. =
For
+ * modern 20 Gbps buses, this value increases to over 50 MB. The maximum
+ * buffer size is set to 64 MiB to accommodate this.
  *
  * This is still too much for most cases, where we just snoop a few
  * descriptor fetches for enumeration. So, the default is a "reasonable"
- * amount for systems with HZ=3D250 and incomplete bus saturation.
+ * amount for typical, low-throughput use cases.
  *
  * XXX What about multi-megabyte URBs which take minutes to transfer?
  */
-#define BUFF_MAX  CHUNK_ALIGN(1200*1024)
-#define BUFF_DFL   CHUNK_ALIGN(300*1024)
-#define BUFF_MIN     CHUNK_ALIGN(8*1024)
+#define BUFF_MAX  CHUNK_ALIGN(64*1024*1024)
+#define BUFF_DFL      CHUNK_ALIGN(300*1024)
+#define BUFF_MIN        CHUNK_ALIGN(8*1024)

 /*
  * The per-event API header (2 per URB).
--=20
2.50.1

