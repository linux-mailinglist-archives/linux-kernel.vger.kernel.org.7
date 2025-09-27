Return-Path: <linux-kernel+bounces-834974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD40BA5F1A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D54A77A4E65
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1AA2E0B69;
	Sat, 27 Sep 2025 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFOskScP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5045D223DD0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758976185; cv=none; b=WAr/49KJO7JJjxZjxyEMowI6wJnt46Y5lvcyk7y+KYXKPVc6wfozwBPTR+wqr/6a7cHZGa0nIPcMQNwtrG1teW9HcFGQoiAwuxrlQwmrn/S39v4vdkdQRXb7w05NoYmEDJwM/1SX++FYLlDIy2pIRL6uY+UlZSlB9DBGwx55sVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758976185; c=relaxed/simple;
	bh=8/mfn+l6yMck2ssfb36rZsznF0V+As3XlEaLgTKq8IM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J1X/1jDa2F/+OX++cPK0wZLGGgtszW3bHp72ozohF+8LQGqdwsej+oNuwCBLQY9fHBSrrC6BEx9pT7WeVPZlTTTXhB+fK1EOSp2pnObBxFUDWyIAkokBN5fg2hhMiYFsTG00UUPeWolDV5o8B3sIBtg8rbxgwrvhFo/nPkL22VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFOskScP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758976181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=DUxaVKtW+jmtZoD1iTuQ/I8y8JP+Ut6bd3xSwcm4XoM=;
	b=jFOskScP3BFcoWKgL9T+omuHirdv/J6Py2aK/t50ambMaNA9CiWXIoTa3w1qX+NwTqrR+l
	Q+5F6WE1QdKtczS6RxjnfH73zfpff5Mr9phqWAkt8IO3av/PbedKth7KTDx/oifgpgMYui
	TuHkJtdeWqSxw35PngQHvEgaYsQMt3w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-g84p1hvVPcWki6J6G0HLpg-1; Sat, 27 Sep 2025 08:29:39 -0400
X-MC-Unique: g84p1hvVPcWki6J6G0HLpg-1
X-Mimecast-MFC-AGG-ID: g84p1hvVPcWki6J6G0HLpg_1758976178
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so20238045e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 05:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758976178; x=1759580978;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUxaVKtW+jmtZoD1iTuQ/I8y8JP+Ut6bd3xSwcm4XoM=;
        b=aKBmivDdZRfvtnN3xmvSiTmxe56yJCs9Gh10o3uF8ocktCPIhE2MDIbKRo4WMI+mCY
         WK2wjzg16pU+q7ePVft2F4UbPheBxVTaxJV/NweQNl2+CO/+mRc9yYiBcj4dulwhkhwN
         97ixNZRMXa6p8zZdk6AtfgTkeJtZrntHk5H1WZhHThiPWK9lwkFk2hWq4s9C0QqUt426
         c7mXmL4OIEOa4VtRhsxqQX2iSSzwe0z77ifx2rb/shGwJwWDFfKDQJIsOpAwSgboS203
         tQBd4kXTsEPnotcIaMSp7ec+bekgmHpMDtW6mCm7N39iX+SeXC9NRQTWNrAUC6+Vr1+d
         5zPw==
X-Gm-Message-State: AOJu0Yydl/xCbIv6BSbIXSBllBcq75MVJRgDjdsZFPcSzzjsNBGS/ucO
	sjBN8uj0ZjXp8zkS9E0JxJL2eUZXcYGRKMZ60fjk/DoHk6EWR5wwkkjAsi5h0uFNqc83erbwkkT
	XBxQC92ZesisekyTqZkP0nbHwKrPhAkwdJgitHDaMG224qWMHDELnx8PusytuTSvEio3ns2AjTt
	ICy5If/yhkg+TQQW+1154olRn6XLAurRDtzQaBNwteCto=
X-Gm-Gg: ASbGncslAi8qjeDxmG/sFew86HulO7mJf333kVwmQB65AHBG17Lh06e/8V3Xq6dx7Ug
	sB0BjdSoS4EgNNDK6in4OoYQlHqRHgchD1O+zm5BvXqr+MvZ6UEmaz+5rZcDolLUoXR1+fMYbdO
	n8AXewfPM5+HqnsOc3OK3AHMPnwanauAWc1+HOk1sIHrdVxRy0vl6kTRxXw2oNKK3InbKEhEe0N
	SI8ZNbEJx7GbE6Zk6jHcp4f/nd3dnrg2uSMxoEpFqotCzkWybEmKr8IUcpnA11kuQWaUEyySaX0
	splwSYZ0nYAIwl2E2yRsT+XbCcSny6jg2XY=
X-Received: by 2002:a05:600c:1f16:b0:45f:2cf9:c229 with SMTP id 5b1f17b1804b1-46e3292ea63mr95445795e9.0.1758976177772;
        Sat, 27 Sep 2025 05:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEagI+nikv0aK5TJvkBxM8RtXzOb8DG45eGaOv2UMs7Rcf6pJhnXJUfURdRo12z2XArJNGUDA==
X-Received: by 2002:a05:600c:1f16:b0:45f:2cf9:c229 with SMTP id 5b1f17b1804b1-46e3292ea63mr95445515e9.0.1758976176996;
        Sat, 27 Sep 2025 05:29:36 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9eabbsm117919275e9.3.2025.09.27.05.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 05:29:36 -0700 (PDT)
Date: Sat, 27 Sep 2025 08:29:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next] ptr_ring: __ptr_ring_zero_tail micro optimization
Message-ID: <bcd630c7edc628e20d4f8e037341f26c90ab4365.1758976026.git.mst@redhat.com>
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

__ptr_ring_zero_tail currently does the - 1 operation twice:
- during initialization of head
- at each loop iteration

Let's just do it in one place, all we need to do
is adjust the loop condition. this is better:
- a slightly clearer logic with less duplication
- uses prefix -- we don't need to save the old value
- one less - 1 operation - for example, when ring is empty
  we now don't do - 1 at all, existing code does it once

Text size shrinks from 15081 to 15050 bytes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/ptr_ring.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 4d014b6c4206..ba90c0e6ce70 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -248,15 +248,15 @@ static inline bool ptr_ring_empty_bh(struct ptr_ring *r)
  */
 static inline void __ptr_ring_zero_tail(struct ptr_ring *r, int consumer_head)
 {
-	int head = consumer_head - 1;
+	int head = consumer_head;
 
 	/* Zero out entries in the reverse order: this way we touch the
 	 * cache line that producer might currently be reading the last;
 	 * producer won't make progress and touch other cache lines
 	 * besides the first one until we write out all entries.
 	 */
-	while (likely(head >= r->consumer_tail))
-		r->queue[head--] = NULL;
+	while (likely(head > r->consumer_tail))
+		r->queue[--head] = NULL;
 
 	r->consumer_tail = consumer_head;
 }
-- 
MST


