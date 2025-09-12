Return-Path: <linux-kernel+bounces-813484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD95EB5461B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB654615B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D6E274666;
	Fri, 12 Sep 2025 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8kjsQcR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90966270552
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667395; cv=none; b=NR0DTQ/zuVCw28Y4BwzUIxXmofw2ylAQPZB5spMv4FRjiA3Hg7Fb+hZF9qw7DrU4BoDBsg9/Om6/Araf+rga/anHVELtnw26pdgExCC2Itq6iqejzMiHN5A4/M8FOSdVCfJWISFb9pgDhLwrsOqjvEtAJ+U0mMZmRxhpZfARYgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667395; c=relaxed/simple;
	bh=9TuQEBjmdDLinHayo5DYGUW8uac4nJfA7tkt5ck069Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n3468jq6/nLCzEROvEpKu9vl48upp0WEb6PfA6VRoxkPjGXU5TYT0dcc+N3KnI1lfrJ8JuofgkHrzlNwdMPuavFzYy02obunFF7sWHaZxGP7efmAV1Myt/g9uEPqc+sQjmtwrWBmQQaydxZ6EJOAlEOWDvu844yyI3Lg/fQJ9x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8kjsQcR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757667392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=IRz7gJ5evnxzZdOz9ZURRFhBrrpzY6w4PcJfSteWFao=;
	b=E8kjsQcR0hKbHnRBjOvu/C8Mc97sKDyYx/tS4HVfTqWfKRAwp2l+Xymmm1PCTZRtLd37Bd
	uAyiEGpUl1rpu2FyIHiVNgBilh2I62tR0wJ7rHVTFkTdR7ABHEz/aOwLes6ILr/a2oMGd6
	++xaG0PhnJc6tbylKbI7QLN5WA3xtdc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-TcdNX3E_PmSmJIqFhA2pwA-1; Fri, 12 Sep 2025 04:56:31 -0400
X-MC-Unique: TcdNX3E_PmSmJIqFhA2pwA-1
X-Mimecast-MFC-AGG-ID: TcdNX3E_PmSmJIqFhA2pwA_1757667390
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45deddf34b9so15728185e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757667390; x=1758272190;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IRz7gJ5evnxzZdOz9ZURRFhBrrpzY6w4PcJfSteWFao=;
        b=XaO+NQtqD0etCb42dz4NOdcJn0WsA0a/s0Tsoq2oIdGS3WIaNfIOXDEjurIU88eYwS
         D3GEY7bgHF7nqAGeg0r4kv6QLEwjj6ofuP0ENof7/X1z6DpKaVy5S50FYJtSLW3WDpYz
         OOwlCjjdAqjyNTVRcw2naF7diLAqqqtQnCHe+7IEbo9XynLWy/0tGLIsK1Xaf8ksyTcK
         IFVceuo2e+etL9+oPOMVM1TK05pemkgy0h4/D+3R3BKpwnEC9foMIS2q0JSgHZDmGuXV
         1cExwRCx95b/64m3LCgVdOkh5BqUtD9cjDvNcFmRYC269EZpS1xm4MjE/DDnVImfJ/ec
         aLQw==
X-Gm-Message-State: AOJu0YzP5ga+pvvFMr6po28riBN1SwLq7L8xPPTbyjAqgWnebTXqQ1qX
	FxaLMzuWR25TFA9U2uFK1Aemb9paNE/s/DoPp4TzrECrsBzi1bjIYkAGVT+Nb2nQwiJhiYwVvTw
	WBY4rNAE7jhXYMuAaE5fBHjjOGFgH/QgJ2K2YjaYmJOGtCE+1eg/u6G1xYj8ezoV9U9N8+fbWCu
	zR4flVF/qWCH/wkqNtOJVprsuXk90DnfjbpJzUXBZDOZg=
X-Gm-Gg: ASbGnctOBwR778G82g9e/lY5ldmddB3zJkyb/DtBKs/pU88dGz6jaYqrQE7Fru4/XoG
	0m6cbLGr7jwPsi9HLfDNsHxxyM5YxxJe4NXJHqZOiLK2pAdESaVpgBzLX80vwXeb8FFizKW5Omh
	5nsHvQ9p0Fy8POsxtfNeUpEDWfUdAGUjn+skyUBJ8poJ5z02l8ZK/Z3CEQ5P5hIpAHO69EVx/TX
	WtBe3Q7ouK6TH4gh2PbbwzJ2AmLYKJV9YrBJiNlhGyDz8y60pTzACRFZxUu53M8TYR3UO7i/teR
	S+Revy4OELrrAIrlVLx0LLNyl2ykz77v
X-Received: by 2002:a05:600c:c112:b0:45b:9b9f:88cb with SMTP id 5b1f17b1804b1-45dfd5fa22amr49077045e9.16.1757667389773;
        Fri, 12 Sep 2025 01:56:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT97SrCYae/KHK1SjWMxo7ctidNkypzXX3y27/RMu/mOH/TwU0NXoK5V3noVbuk8Wle3HkFw==
X-Received: by 2002:a05:600c:c112:b0:45b:9b9f:88cb with SMTP id 5b1f17b1804b1-45dfd5fa22amr49076635e9.16.1757667388938;
        Fri, 12 Sep 2025 01:56:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:c800:2952:74e:d261:8021])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372ae57sm53442645e9.8.2025.09.12.01.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:56:28 -0700 (PDT)
Date: Fri, 12 Sep 2025 04:56:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Filip Hejsek <filip.hejsek@gmail.com>,
	Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev
Subject: [PATCH] Revert "virtio_console: fix order of fields cols and rows"
Message-ID: <601edd0a61e9a31d3d4f525a7c0648dbb4baa603.1757667309.git.mst@redhat.com>
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

It seems better to just drop the change (it was only in 2 releases so
far), going back to the status quo.

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


