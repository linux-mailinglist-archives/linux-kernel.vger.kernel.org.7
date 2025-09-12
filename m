Return-Path: <linux-kernel+bounces-813454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26234B545AF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE128162F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164582D5436;
	Fri, 12 Sep 2025 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BX4sXHIy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CAE1E1DE9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666446; cv=none; b=glTYgP8/CtDapCD3Lp5Qj6+QX3txxWMBAwPJIRu6BxRsibMeQVIZPpt6AOUzIQTQTq4r04ysg3QSoGWy1PbqJbQV1Wi8rnQMMBXO9X0UnfdvwIZz57NlYDdzRLB9GPIw6L4zo7dYZrH+jzsjHxDfNeaG1WEA/UPhfq/ykxETBWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666446; c=relaxed/simple;
	bh=JFm9q5MHFWvo/CMc0shtVH4Yt0n17LPmzfEtHqz8xTw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J5K3UvClTQBCTggdidOFkMAlx2SVeeONgHK9xoHd02aZaTLeImoK0xOfJboJ55OfKG8VqB8OEsrpURW+7sVOiCKxJPeysf8lbFg+4C1aqYWmpiDblrDk6ALdIj+7cuaAxHFFSZ9NMVe1xm8CU+g7j57vky9U+LYeFpfq1K2qoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BX4sXHIy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757666443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=PvsOvjK7iiT9XUkiykze+uFI53RNvUT/umyb7XIvWRc=;
	b=BX4sXHIyfmUqX/re2OO3kYV0coQ/I1Uo2TkytzxInPBNQ/cQNAR/6xzk9a+eAfC3//yg+9
	dG4dflkc6Pjbpwo1PcWRG9UHrJbpotgSvcMRpWHOzKudUhGepEkB9IH29Sxw4aefHkvGiz
	4f/twswpEXgKxVjxJPlT74bG/q/+quo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-igpGSFQPPUGjsYRh7uy6sw-1; Fri, 12 Sep 2025 04:40:42 -0400
X-MC-Unique: igpGSFQPPUGjsYRh7uy6sw-1
X-Mimecast-MFC-AGG-ID: igpGSFQPPUGjsYRh7uy6sw_1757666441
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45de07b831dso9986125e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757666441; x=1758271241;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvsOvjK7iiT9XUkiykze+uFI53RNvUT/umyb7XIvWRc=;
        b=gqGjp3Ha1rrxy8kePxoiwiRFapfBPiDBcfDD5Jypb1QO8YkfsUFVNhGWoWjWzMiEj1
         KtSB39cFdJvb7bZ9UAad5nP2r/nnLmtx3hXxuBpTtG6+zUNHRZ1m0Qt06+VpoORMw/cs
         4YlkGKQNrz7i7nImQDGat1trEDDiDXwV30X+VYeQPFt1t/H/FyiLzYA/YjTKNF3W9m09
         cikAiwe4Iw9cFs/JGgNbDT9wWMbHZ8uOI9eqFj9MnPrgmdHa+HdaEPn7dMDNz8rp7uWB
         SiwIZ+jQgnRoqfFgZwTRdU16vzM4zVmlqR68VgleqJqaDL+xkyRAjOVDvov1HTRQzXwB
         vdsA==
X-Gm-Message-State: AOJu0YzF5u7k1oc9xj7Z7A3meMLPxZB1EWTPfOieJtQS2O7Gism1x6Mt
	qQcUlKdvEKHwRSVKTRqCrr2Tssw8jdCVUUF5XfTGcejBf614smIFXsz2IjiKWgZSt+aOgWZi2f3
	Kqmih/cA/HBfm6cPSGvtIH50Dtb5nTe38HSImHEpPVUO0g5YL7Z8swj1Jy4qBGjtL3VqJekDAaX
	WNEbH56DWQ4Nmi0w6FLLOzJAOgYiFOKWuFm5vwzu5Nmns=
X-Gm-Gg: ASbGncuD2H+lBC5/DgEM1KWsKVNUEDfgXkskNMNU9o7RC7PuY0coOJMrSkBxu7VSct3
	4/xQ8GbOlrCi+RfQzbVDPi+EymZNzyYYAqfzGEAl+XsPBAML9F78YvcbKZx14R3Tzkb4vsiqz2t
	u0O+TqvFLVuAfW/zWJQA4oALgALHUvM4Li56nNfk55lcslC9ska+i005DKzAi5V/wyNFNeRyu6S
	y0/UwZyMFcooz8V6jNjN+qvWG9dQkkzfdVM41gU4bvc7fUC5CX5k1gcbrI0uz4qlefGVy9uw1E/
	z+3yQc3ZZASVw5kDpqoIc1ZbHHq4SSNi
X-Received: by 2002:a05:600c:1c9b:b0:45d:dd47:b465 with SMTP id 5b1f17b1804b1-45f211c8395mr18631815e9.7.1757666441126;
        Fri, 12 Sep 2025 01:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpABu+JYhUlWvQU7+IMiPKX/l2FbW8SOSOf9lAUj55zctSTxUjYZ6Qb1tuKOdhGKXoNOk0oQ==
X-Received: by 2002:a05:600c:1c9b:b0:45d:dd47:b465 with SMTP id 5b1f17b1804b1-45f211c8395mr18631505e9.7.1757666440626;
        Fri, 12 Sep 2025 01:40:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:c800:2952:74e:d261:8021])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0153fbd5sm29710965e9.5.2025.09.12.01.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:40:40 -0700 (PDT)
Date: Fri, 12 Sep 2025 04:40:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Filip Hejsek <filip.hejsek@gmail.com>,
	Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev
Subject: [PATCH] Revert "virtio_console: fix order of fields cols and rows"
Message-ID: <7ebfa9a5ec3f07506b3d8f01cd4f2a35e2135679.1757666355.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

This reverts commit 5326ab737a47278dbd16ed3ee7380b26c7056ddd.

The problem is that for a long time, the
Linux kernel used a different field order from what was specified in the
virtio spec. The kernel implementation was apparently merged around 2010,
while the virtio spec came in 2014, so when a previous version of this
patch series was being discussed here on this mailing list in 2020, it
was decided that QEMU should match the Linux implementation, and ideally,
the virtio spec should be changed.

There are about 15 years' worth
of kernel versions with the swapped field order, including the kernel
currently shipped in Debian stable. The effects of the swapped dimensions
can sometimes be quite annoying - e.g. if you have a terminal with
24 rows, this will be interpreted as 24 columns, and your shell may limit
line editing to this small space, most of which will be taken by your
prompt.

NB: the command structures really should move to the UAPI header so it
is easier to notice when a change is breaking the guest/host ABI.

Reported-by: Filip Hejsek <filip.hejsek@gmail.com>
Fixes: 5326ab737a47 ("virtio_console: fix order of fields cols and rows")
Cc: "Maximilian Immanuel Brandtner" <maxbr@linux.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 088182e54deb..216c5115637d 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1576,8 +1576,8 @@ static void handle_control_message(struct virtio_device *vdev,
 		break;
 	case VIRTIO_CONSOLE_RESIZE: {
 		struct {
-			__virtio16 cols;
 			__virtio16 rows;
+			__virtio16 cols;
 		} size;
 
 		if (!is_console_port(port))
-- 
MST


