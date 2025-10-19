Return-Path: <linux-kernel+bounces-859832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 384A5BEEB60
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 20:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C307189A250
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 18:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C4F2E427C;
	Sun, 19 Oct 2025 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmZqZqar"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6746B2248A0
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760898581; cv=none; b=mZ3gz/FGhl5KDeusDNjHqH1NEFCAfowuYCP71005H/mV8uTSRNk9VVClYQ8Pk8RXw7O+6B6UWP/3VRUiw3l9f3N3YErJiZtvxfWoFxR1YiWFJp6siqSPf3mXRQyMR33HnRAr19K7bs1mMFjv9cPYc4nMXnl147LzyrdS4ITlcEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760898581; c=relaxed/simple;
	bh=59XmYm+EO88Dl2kDsRxEUIhQrtftD0EGVhi/zb8n6VI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Guq0tE78sOXI3uqEVMl0QCmqge10d+nH8XyJ/WFdxj0Y5snT+or9Vx/FY/qUrA2JPIBRHSIL6ZcbjNy3rA5pMztjVQHVPWHwdbfQFTGEvUSv2YP5ZAJlt82qVs+4lsWPisQxJBdBz4aN92B/k7MIZ3WMM4/uvSSCrmcFu5tHowk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmZqZqar; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781251eec51so2866292b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760898580; x=1761503380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAz1Xrjkzd6ULry6VIZLlce2IMxVc3+Yynj8Z/hkgEw=;
        b=WmZqZqar0t6luIx91JGUNnkSgkvwipbQucbAezyDMWymetCi2EdGZPx+wb828rzm1g
         O4M7mmfvJ7WV5CBKPUgYo1kldw7q4rR0ANr0Z8drNncc2UgziY6MsvZbspEG/8Wtok5L
         SgwBTet+VdLrx07bTsfzoxwgnWPSKdcE0v9nuEeD9hhi4OK6so0fUcoNpGQIuPDBsCep
         f9zub6gR4RdMpSlNFfgOAxDgcVFmlbVBwqcX2TsYEg1Ut9JPdBwhsh217eFSJNR1TCUu
         U0AA+wp1vq0oEtM2fHZP41bpwGZkHUaQLqsVZplLIJ7AlOY8VHhsz8vyF9y3xrz3QqKl
         2wEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760898580; x=1761503380;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAz1Xrjkzd6ULry6VIZLlce2IMxVc3+Yynj8Z/hkgEw=;
        b=JkCCY0sHEUsmnwEQolMRQJCPzdJ3nMAZP5WR21UuSHMVuRWiu4ZzhkHiJDM3v/wakR
         2zUNIWIZRdVJQQrU/4XOaz0LiT4QPXRwTV4i5sfzMdHjEqu83i0EaTmNc/1DcD5YJo1D
         b34EooARLNMiA2CDAn3Z1/uE1QF0dPsH6gTYBXubG7SNjSv3wjywzxJpGllJJHWhmQqO
         NrD/g96F5zkRlgGlOQrmKABggS8e+BoiFRGnNT7ZHus4JPRPjhUlsqyApQ83oKetk9Ur
         jIERAFMp08QR+R9YsQSIHEYsOCMTYWyIHhvUC4McWBqO8OULW0e7wXFvycQffCM/LFl0
         UiCw==
X-Forwarded-Encrypted: i=1; AJvYcCVNvMS4KaVKGVf0lPLh9zvdUu6C0RyWBueur8z7CA0WmGcazFJITPo4EU3XfNUrx/gAZyDwuJP4xRn86lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJxaJyfdk5jqotAoJC4SkLFWTrnFfqmIuXufZGPwHhabMTAWO
	mVNQ1oL1OSEefd8EI4sy9Qwy0w1L1XSBV8pXh/X01YdqgkiKjfkv1WBb
X-Gm-Gg: ASbGnct0+KF+Klosq3adIM7Ggbz3gluoGUh3mBIZA9Sri0agXwDliTBLxjiR2edMN6O
	DSg7nRDc4vXlMx+oI2mwQ8dpG2+xVanZA62SCSAUWZPFCoMXS8t1/Ya2TasYmicfFxRP2ezOuin
	H//pM8yoWOfZ9mGADxwIJscHQefNJ3Oq9xq0WDC9iVjeGRol3WB9EtZ+2ISuCcQrl7puBhWqB7K
	LOH/Bw+jrzPNcVZO4UsiKIiUyzR5tNV3OVcGpRolELecj2UG1k4xxAlFW9o1ggNozmBmRCkRfJ6
	VdFUfYaIzo/CfyLKuU4tgDX0F45t27xll3q+YZtI7SimbYlQnlOOvoqis7XlDFlXlgNBEYb/7hQ
	ugX3OmVhZAAkIRyxR4kQxkjQf+/P+ps/wCUO0otaWH5JTkGRfhPZNNuTJCNJpBkFEGzgeawzroZ
	C3896CtA==
X-Google-Smtp-Source: AGHT+IHYBsBIyQhofVEIUqLK4ufZTXWodxz/p8RD+UfHYw+jNsprvNHmxEIT7mMHJPaXaI2v/Og3Pw==
X-Received: by 2002:a05:6a00:3cce:b0:781:be:277e with SMTP id d2e1a72fcca58-7a220a584c6mr12962221b3a.4.1760898579683;
        Sun, 19 Oct 2025 11:29:39 -0700 (PDT)
Received: from [192.168.1.13] ([110.226.181.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff15985sm6218413b3a.5.2025.10.19.11.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 11:29:39 -0700 (PDT)
Message-ID: <1b4aeb68-bf9a-40a1-ab86-a52ef91eb3a4@gmail.com>
Date: Sun, 19 Oct 2025 23:59:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Cc: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com,
 syzkaller-bugs@googlegroups.com
References: <68f1d9d6.050a0220.91a22.0419.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
Content-Language: en-US
From: shaurya <ssranevjti@gmail.com>
In-Reply-To: <68f1d9d6.050a0220.91a22.0419.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


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
   end:  0x180 (384 bytes)

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

+    /* Reject invalid/unsupported address families */
+    if (!socklen)
+        return -EINVAL;
+
      size_req = sizeof(struct sadb_x_ipsecrequest) +
             pfkey_sockaddr_pair_size(family);

-- 
2.34.1



