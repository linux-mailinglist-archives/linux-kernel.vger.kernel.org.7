Return-Path: <linux-kernel+bounces-890888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4EAC414B9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 947BB4E360C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3EC3396F3;
	Fri,  7 Nov 2025 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc7IUGvk"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD0832860F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540392; cv=none; b=NOfOpYpC+RC+pENhHde0MhrEw0qX1k6BV03jdGx8hMiBxDIsm5TXwnnMfKcNQ9vjAL7RoSdSYmAEpl52SPSlJE76eF6WBGQ/cfF4Wl7hhB7FOl1NWeUCIPwxPhooxr3KWeZ6bzSLadntdm6cg8/kI0gjGdqJhOuZe6au3Z/dcBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540392; c=relaxed/simple;
	bh=LEGAtv06Hrn9QV9+NCYV7AJGqINssJ0BskTW4tl1wKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J7ys1qvGxr1dwjXNJqjFWjR9YkvfEr0XsWh6bdjhEL+nCaTnEIvl9mQJtCWTXZPR6sfJRTwCTjngG7hAtxlFbjSzTeSyl4V94NnFejcIkU4DOIgyvRpC+9iI7LmuqVj7O2rhaqNuNJ4y/SV4GFURa8f7d9wM7spHPm4AV/IQTDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sc7IUGvk; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33bba55200bso115932a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762540390; x=1763145190; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYXcwqST2s0E31dZAINQA8t4CykBZFIXj3bpdmbnoi8=;
        b=Sc7IUGvkc8ldAkDjYTt0PAILIiRW5dU4wQVKtWbDPZwxLe34Mq0W65NFpUkIWoaPBd
         pFzIXo3AEpW2KF5IedN42UcSlfJtRnZqi+QvDvjgqi79BMKp+puekYFnJehhHqpGhQxf
         mkhp/eJuKzdta8FkFfb+cx8F8KAQdatB93D2f9rghBFD1WOkM5z8Ud1y4d/570gonmub
         ompIEak9D3TuB19jQ9mO4OcRNojnUquvfJyziEEi2LDLIttkBNwbok8Gn3J4y/IPshWo
         F6/Vzxp0ehunjEuGabtv7lr4VhZvpU/seD1omU/6PT9Lfwh0+ceNTKS8VFVPvglTox0k
         QquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762540390; x=1763145190;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYXcwqST2s0E31dZAINQA8t4CykBZFIXj3bpdmbnoi8=;
        b=J1qYmuHMLi9iFO2Fb2oDiQ+gEx9/DbLwt+65hKiHTGePpqDfmJmZ3USgzQYNLgEJEI
         nUX/0JTCLC4TDHvEIFgUmuZgBFRW6suLwCtx1xrwimf72hlX8yelPtCYqoLWpS1sMW6i
         PzzU2xLjSfbqiXVEZ4pMEZVF6Ol9PhfNjFnFyHJbojsKBoKZJB04jUtNxZCqhtiITZw9
         MSyh7JAV8USkIG8gII+kEboKZUcTzsTm+B2JS9w3nKb9q7usxYL3TcVESH2QrOPcpbK1
         90q5ojr6dniOC8xViJYwTZniLUoSxsawMa1MUK4HXm95IyuoX3S4eSWfh58Jj7ln0k77
         vQcg==
X-Forwarded-Encrypted: i=1; AJvYcCXWNF23ChfkG5SkB2k9WIAW1N2oDfMHcZUv40zcF7o8UQ7TrjAgcwe/d8FP3bEoa8WqXn+MReFkmGMx3pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNqpkMSYRUQ36DoqmMXI5qn3mZuBYDrn/5i0TdlmuDs5NBKLAR
	4Juxt3ppdkFc9wH8BNIecfoYT+n3u4miKjJqReJrSDc5ZswQsf45QmHl
X-Gm-Gg: ASbGnctRsEzqQnl+PlN+CpvhJRJjS7CjTqf6iYxR4cutvjlVVaLLb+uktSrTE9Z4diL
	AV6I2I2ZFMD/pmW4OP7KLqAkYn3CxBeYdZPMoJAxyqkUK3C6514ayH98Bsj4hkxsFZIU9NN3/YV
	Ka3DbsIp4UDkYdm7/8Hw5pZJqvjcl0UWcW0+STsZbNQtNAOx8Rl590opsgXaAr54zB2J3EV4GTA
	x2y/9WDKXdVHfU5MjOfBBtRh++kK4F8E7zXVJ0BkYEPtv81qmwqoTHTMyfCh7Mnarah/ovCFwzQ
	YAMMRxDpbM2Kh9yZ0jzCH2SpZJ5zDhD1CSsGiETGWcyJTMKTrR5LqmnAY02afjCYY4QwHH6THkP
	gQ/hzPp+F8WaRqYmjYtkvzsRend/vBd8QthsAil7ea5z/2tzF1jeyk4nKRWrfV+gE9JXGGCesaf
	CHTPvrKdLbyNRObRK4QJjhPvQKGQeMsHxGBrWxv9AH8g==
X-Google-Smtp-Source: AGHT+IFydgreo8L69m8Lj3Wz5N9g6puBAf7AeTzOPaImHV+/mEDckn77WmWr595qhcl05UceLjJUEQ==
X-Received: by 2002:a17:90b:164a:b0:33d:55b1:e336 with SMTP id 98e67ed59e1d1-3436cbf092emr56119a91.6.1762540390342;
        Fri, 07 Nov 2025 10:33:10 -0800 (PST)
Received: from [127.0.1.1] ([2406:7400:10c:53a0:ba5d:ce6a:b1bc:5685])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d08afb02sm3619943a91.0.2025.11.07.10.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:33:09 -0800 (PST)
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Sat, 08 Nov 2025 00:03:00 +0530
Subject: [PATCH v2] wifi: cfg80211: Fix uninitialized header access in
 cfg80211_classify8021d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-fifth-v2-1-405da01c6684@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFs7DmkC/zXMQQrCMBCF4auUWRvppAk1rryHdFGSSTtgG0lKU
 Erubiy6/B+Pb4dEkSnBtdkhUubEYa0hTw3YeVwnEuxqg2ylRmxRePbbLC7KamPIeW0U1O8zkuf
 X4dyH2jOnLcT3wWb8rn+h+wkZBQo1Sol91zvn6TYtIz/ONiwwlFI+EUbyAJoAAAA=
To: Johannes Berg <johannes@sipsolutions.net>, 
 =?utf-8?q?Dave_T=C3=A4ht?= <dave.taht@bufferbloat.net>, 
 "John W. Linville" <linville@tuxdriver.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
 syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com, 
 Ranganath V N <vnranganath.20@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762540387; l=2349;
 i=vnranganath.20@gmail.com; s=20250816; h=from:subject:message-id;
 bh=LEGAtv06Hrn9QV9+NCYV7AJGqINssJ0BskTW4tl1wKg=;
 b=pZfo+VA9Xy1E3Mep907lbRLADH/mPjwkdXOA2gD8ol6J183CoZIi0z9jtxZR0W+3cYRAjDP/O
 NHcOcC1cqbvBEW5x+tYt4L3Ux5FdUepnXB6MTOVSAzOAuxIUnIBA+Rl
X-Developer-Key: i=vnranganath.20@gmail.com; a=ed25519;
 pk=7mxHFYWOcIJ5Ls8etzgLkcB0M8/hxmOh8pH6Mce5Z1A=

Fix an issue detected by  syzbot with KMSAN
BUG: KMSAN: uninit-value in cfg80211_classify8021d+0x99d/0x12b0
net/wireless/util.c:1027

The function accessed DSCP fields from IP and IPv6 headers without first
verifying that sufficient header data was present in the skb. When a
packet reaches this path, the header dereference could access
uninitialized memory, as reported by KMSAN under fuzzing with syzkaller.

Add explicit pskb_may_pull() checks for both IPv4 and IPv6 headers to
ensure that the required header data is available before extracting the
DSCP field. This prevents uninitialized memory reads while preserving
existing behavior for valid packets

This fix has been tested and validated by syzbot. This patch closes the
bug reported at the following syzkaller link.Fixes the uninitialized
header access.

Reported-by: syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com./bug?extid=878ddc3962f792e9af59
Tested-by: syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com
Fixes: b156579b1404 ("wireless: Treat IPv6 diffserv the same as IPv4 for 802.11e")
Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
validate header before DSCP read in cfg80211_classify8021d().
pskb_may_pull() checks before accessing header structures to ensure
safe and fully initialized data access.
---
Changes in v2:
- Corrected the commit subject and Fixes tag.
- Link to v1: https://lore.kernel.org/r/20251103-fifth-v1-1-4a221737ddfe@gmail.com
---
 net/wireless/util.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 56724b33af04..23bca5e687c1 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -963,9 +963,13 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
+		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+			return 0;
 		dscp = ipv4_get_dsfield(ip_hdr(skb)) & 0xfc;
 		break;
 	case htons(ETH_P_IPV6):
+		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
+			return 0;
 		dscp = ipv6_get_dsfield(ipv6_hdr(skb)) & 0xfc;
 		break;
 	case htons(ETH_P_MPLS_UC):

---
base-commit: ba36dd5ee6fd4643ebbf6ee6eefcecf0b07e35c7
change-id: 20251101-fifth-84c599edf594

Best regards,
-- 
Ranganath V N <vnranganath.20@gmail.com>


