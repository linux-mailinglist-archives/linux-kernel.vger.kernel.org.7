Return-Path: <linux-kernel+bounces-860006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CB1BEF203
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13BE3B026D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D86429BDB6;
	Mon, 20 Oct 2025 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="AUOXQ4U6"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A015C1D54E2
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760928606; cv=none; b=LhpDl/19Ib83SeIsxLICb8mv8QjhyvMq4mRhqQYXVpg/oVvhaOfV3yR0E11sArnGtv3d012GrNgM8anBucB4JT12tWdX8yNbrQnI05fHlSTVt1a1roDb1o2ML/7d7+bfB0SM5rElAjaxpX/uc/a00PC2fdt9kdtqxyBnwHltwZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760928606; c=relaxed/simple;
	bh=3wpwCecmyV/NJOn8EtkxacL5jdQzwDbCsRAxDYCXMTY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WuIaAn4gj5KFLkaTnNisfxwiZp7XWallwJo1apTo/bQfnj6IH7Tt345PVfeH68Fj/LOVdQx8gX/DObNp5PwOHpqqMSEzoQM2CdEfd/DHuyMdegSRjR22+hmLy/3RzAuNLfox6Onyt7OB7bRd46v1N5xyL3L9cZ/QbMhu5/qDCeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=AUOXQ4U6; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7815092cd0bso38228297b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1760928601; x=1761533401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZzLybvm6rQ/SZfuZuCVccpB0+XbR1hwk4zHrp1RZnt4=;
        b=AUOXQ4U6P8ZWo4BggpRmSGYllSriIpA14jwZnyYypncNj+BK8waijQl6Az+7+BpVnH
         N0Pjt5DXTDiLJOLW23GniWF0CT5oi+jAknXvqL87gsCpQL++bByVaKr4P1s3fD+f/wRU
         OhOs9UbH67r7QiLZ6IWeaQM/nVyGnKvyM8syw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760928601; x=1761533401;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZzLybvm6rQ/SZfuZuCVccpB0+XbR1hwk4zHrp1RZnt4=;
        b=jTyJRocs7cbFR1+XGn29iAVlRwfCXtAoiOr9yJ7irZVxSNCS0FOgtltjsu2mbrNvjL
         17lPj1oidZUcYGgHsUuf0k0Mts4AAdnUJqrTOJr+VPNNqtIQt6KcNiTXMVRK3BInTIQf
         d5EVH1mjlu8n+cTwA8m2NZJg5pdG8g0n0zHB51Sn6Tajg6t1NYlhYDrYM31TojHvqsPH
         OmG0+u1dXUdSzO0FMnHKuU70ibKD1vgAskqnubRBDPDJ9h1L79rnmACYF07XFjtGlK4N
         A57n1BGYQVcR6zi5XYg3dbVXeQm3Na8RlMcQ1cX7HGmPExVHWZIPbSEHbgzMzt0inCVY
         zkiA==
X-Forwarded-Encrypted: i=1; AJvYcCXKTAPSjdSbhVwoqThrt9ab7bKSMSCmnM1zTF0JHvrbjgtThTPA6pM8XZQKg6KHnwNXAmEDA/pRyDbT/Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvipsYOsOEI9d/gCmYDpBAx399Uo8NBPJvR2jES4rkpWAS+R4/
	faZhxheQ5QEPpqad2pSPYBX6YIEwMjdCFhPiSXSXg8q0bPKQELLNgtJp3GC6s001ZWytWMh5m/q
	r2zi8ABIakhs+j0KAYeQEN1A1PDQ/Hk+NsAK2jOHBJg==
X-Gm-Gg: ASbGnct0xmxhKviZMzboRGA4E4SURq7fyIh5uuLEr9wtASj8KvpYiV5LyrAGTS/OuvI
	lJm04hsLTBT7U10Ahj1rIZ4HWNZf6b/APLVXqXIfG+fdqOR+jLIlaYD02cL43tb0Ha1BEtXlPrI
	1j2DikPSQgt/mD9tWqNgapQCUm0I/NnwdR2s3yXXsjS0UdsJKqiriGhtvM5DDWI75LkYq67fCj3
	0ExImwN3BNuSoTIVb/B2X92mVbR2G6jLW/KJaJg9VUX1ge11Exfcg/2jTfDtkIEvChU1moh
X-Google-Smtp-Source: AGHT+IH/CFAht/O2GnafzPeQ+I5kuVsM3xbiD3VVh7auuOXBXqlPb6+pZc30M0xEI+h6bDQbHueVWdKyajWfv2UQx8k=
X-Received: by 2002:a05:690c:d91:b0:783:116b:fc5 with SMTP id
 00721157ae682-7836d2d669bmr207397957b3.33.1760928601556; Sun, 19 Oct 2025
 19:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>
Date: Mon, 20 Oct 2025 08:19:50 +0530
X-Gm-Features: AS18NWB9KnaNglZk_pGuDn5x4gPPuwdOpJenF3vZoDgxum6_ss_8inU_5YuOPek
Message-ID: <CANNWa05pX3ratdawb2A6AUBocUgYo+EKZeHBZohQWuBC6_W1AA@mail.gmail.com>
Subject: [PATCH] net: key: Validate address family in set_ipsecrequest()
To: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	steffen.klassert@secunet.com
Content-Type: text/plain; charset="UTF-8"

Hi syzbot,

Please test the following patch.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master

Thanks,
Shaurya Rane


From 123c5ac9ba261681b58a6217409c94722fde4249 Mon Sep 17 00:00:00 2001
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Date: Sun, 19 Oct 2025 23:18:30 +0530
Subject: [PATCH] net: key: Validate address family in set_ipsecrequest()

syzbot reported a kernel BUG in set_ipsecrequest() due to an
skb_over_panic when processing XFRM_MSG_MIGRATE messages.

The root cause is that set_ipsecrequest() does not validate the
address family parameter before using it to calculate buffer sizes.
When an unsupported family value (such as 0) is passed,
pfkey_sockaddr_len() returns 0, leading to incorrect size calculations.

In pfkey_send_migrate(), the buffer size is calculated based on
pfkey_sockaddr_pair_size(), which uses pfkey_sockaddr_len(). When
family=0, this returns 0, so only sizeof(struct sadb_x_ipsecrequest)
(16 bytes) is allocated per entry. However, set_ipsecrequest() is
called multiple times in a loop (once for old_family, once for
new_family, for each migration bundle), repeatedly calling skb_put_zero()
with 16 bytes each time.

This causes the tail pointer to exceed the end pointer of the skb,
triggering skb_over_panic:
  tail: 0x188 (392 bytes)
  end:  0x180 (384 bytes)

Fix this by validating that pfkey_sockaddr_len() returns a non-zero
value before proceeding with buffer operations. This ensures proper
size calculations and prevents buffer overflow. Checking socklen
instead of just family==0 provides comprehensive validation for all
unsupported address families.

Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of
endpoint address(es)")
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 net/key/af_key.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 2ebde0352245..713344c594d4 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3526,6 +3526,10 @@ static int set_ipsecrequest(struct sk_buff *skb,
     int socklen = pfkey_sockaddr_len(family);
     int size_req;

+    /* Reject invalid/unsupported address families */
+    if (!socklen)
+        return -EINVAL;
+
     size_req = sizeof(struct sadb_x_ipsecrequest) +
            pfkey_sockaddr_pair_size(family);

-- 
2.34.1

