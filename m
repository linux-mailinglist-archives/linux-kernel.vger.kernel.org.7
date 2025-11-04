Return-Path: <linux-kernel+bounces-884014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C93AC2F1AB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 04:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF7084F7492
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 03:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F062E26FDB3;
	Tue,  4 Nov 2025 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYmuf2Qh"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A5626E702
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 03:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762225762; cv=none; b=M7DBN64a1PkhpnfmVT8rkVixyuWkCrtehPVXQiyfJXCiukeF5EfGpV4iFtsHAAmNPJLNFdTg7oULdKZ9QqNiTJqYWMSg+yRUD0Cbcw4VdGkXzZNoA6TfCLTnx5g5MUvR7bHxrY0BTrr3Mq8ZfTCAz/2RA4pItP2rpUUyiy1sYFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762225762; c=relaxed/simple;
	bh=Xj9j19NUebfhCpN+tKuVusSgp1CaNz+6chYqy4FYeXk=;
	h=MIME-Version:From:Date:Message-ID:Subject:Cc:Content-Type; b=I3OPFWp0Oht4zkh0SmSOr88wTeZ0udfKjJgoQs72P06HtBEflhq67aGu5KI3yZKh4H70to7lH+D9bPkvO82XcFAv9235ooXOaByZG4ywKq0GVRex/ZM+RKPGSReu4q5ZfWSBnN6wl3xaZXY3jX308yFCvWqxK/8OYCoHR8p2frg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYmuf2Qh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33292adb180so5517551a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 19:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762225759; x=1762830559; darn=vger.kernel.org;
        h=cc:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DowcRCBqJVOn8qJbRYvE9kJyC1sCjtRI/WutxQvl+J8=;
        b=EYmuf2QhbwyeYkHay6dTPfbMVXkjpy/wozX7oqRRLHD6M1qFBCZAVYFt1K7FbEpdLm
         7hYCBDuEwPwo5/ivpX8WFxDOTzizcDR/Jr+2Kzw0A+rLsoYQ9Rrl0RBTV7eadSbu7Uvf
         LT53roH6Q4BWOJ/Pt2PW/vGz0hjhkBCpA39fAGQNHedBmxhp6aHmpvq8tWU2sFNmzEEj
         +2hka72XXCRJcY5j4mQNquZ4hQGQ3vO5K1+UxEnc0IlGZ0V0BDuwhVoWjO3NjLg2nSCC
         PSSGfpbEMJo6V4XNpBn0dRE4f5QuWGZg5z5cr2fdZCJntPBVHZ1IOYrGVfhY9Z6QIAeH
         0wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762225759; x=1762830559;
        h=cc:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DowcRCBqJVOn8qJbRYvE9kJyC1sCjtRI/WutxQvl+J8=;
        b=iCWK51eaWVe12kQ7YCjbm9EI/fppSsySggd85TpJKjSEKOve7n30VLm0i4LubLuxOy
         HgTNiJWGsHEAdXl4OgDZUpEaUhlHKq1PyJy5eVIE8Cj5eLqDEYD1ObM9PiRUFKknvRQy
         eNtaLJh1tXT8BaF15XevUWvBaFlhrNslYBAfCQk8VDeRE5a/d3ysWEg4/Rt0DZRwpATL
         TZXHcfhzCn9UtgeZOW8HLdcNiNx3ubelzcZmQNCTJ8Yl2BYEHGmd0hspThXbXcyomtVC
         dT0TwVvDCmqrJJiBkZnMFfI+ePojxVFPL9iUYyxtvE7Uv9XVjMau0gW6luPHV+IxPbDY
         qNsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFljBD21UZjBWJlkUA/AvXspOJ2YXlRTr9t7wnSHgOkfLsoggUerdH9oD3tVOYSeWSecnK5kig0fcn2a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOvhQYcE6HZFq9GwvNzUqT9ca51t2h1FuUWwr2fWnWJqGIdmPm
	Y/usms/lNXQXNjvfv7bxq5Tyrej98p5S8V9FIaY6RNLfBEiCryyGIt1EXeoYUaEp0B9yrZhbWaz
	q4oNLkTGOz2gcKOhxEeqxFuF1q9Hopus=
X-Gm-Gg: ASbGncuFR9MmGvpm1CEMOHzmfSKqyAPGR9TINi/lWcPKItQ3/H7scx6oWE0skhF6esE
	CKqigJXi1K235DIhh6cLBloPDCWJ4+EAW3r+0vztkY6U8PDeXFuqPKvYQIN5aJeQTwAft6FXiuj
	fYNBL7HxMxF+eJqqPfoxg+YdZcFHXhtfncuMT3rFg2WMO4jpApn9x6fQgfsz0QvsDeOTywiZkhs
	mApJTo7sY3aE0w5abuI/eU1+XI3X1XGyD7d8H9AkUb4sT5rAA5Ra9YZGFm/j4gPmBxhVOU9
X-Received: by 2002:a17:90b:3fc3:b0:340:d1a1:af6d with SMTP id
 98e67ed59e1d1-340d1a1b159mt12839282a91.36.1762225759133; Mon, 03 Nov 2025
 19:09:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: chuang <nashuiliang@gmail.com>
Date: Tue, 4 Nov 2025 11:09:08 +0800
X-Gm-Features: AWmQ_bmmVmspnWKkIAYsyL-35hEeKumbw1UYU3ULQnvMFIWT8QTjYME5xwgvfsA
Message-ID: <CACueBy7yNo4jq4HbiLXn0ez14w8CUTtTpPHmpSB-Ou6jhhNypA@mail.gmail.com>
Subject: [PATCH net] ipv4: route: Prevent rt_bind_exception() from rebinding
 stale fnhe
Cc: Chuang Wang <nashuiliang@gmail.com>, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Networking <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From 35dbc9abd8da820007391b707bd2c1a9c99ee67d Mon Sep 17 00:00:00 2001
From: Chuang Wang <nashuiliang@gmail.com>
Date: Tue, 4 Nov 2025 02:52:11 +0000
Subject: [PATCH net] ipv4: route: Prevent rt_bind_exception() from rebinding
 stale fnhe

A race condition exists between fnhe_remove_oldest() and
rt_bind_exception() where a fnhe that is scheduled for removal can be
rebound to a new dst.

The issue occurs when fnhe_remove_oldest() selects an fnhe (fnheX)
for deletion, but before it can be flushed and freed via RCU,
CPU 0 enters rt_bind_exception() and attempts to reuse the entry.

CPU 0                             CPU 1
__mkroute_output()
  find_exception() [fnheX]
                                  update_or_create_fnhe()
                                    fnhe_remove_oldest() [fnheX]
  rt_bind_exception() [bind dst]
                                  RCU callback [fnheX freed, dst leak]

If rt_bind_exception() successfully binds fnheX to a new dst, the
newly bound dst will never be properly freed because fnheX will
soon be released by the RCU callback, leading to a permanent
reference count leak on the old dst and the device.

This issue manifests as a device reference count leak and a
warning in dmesg when unregistering the net device:

  unregister_netdevice: waiting for ethX to become free. Usage count = N

Fix this race by clearing 'oldest->fnhe_daddr' before calling
fnhe_flush_routes(). Since rt_bind_exception() checks this field,
setting it to zero prevents the stale fnhe from being reused and
bound to a new dst just before it is freed.

Cc: stable@vger.kernel.org
Fixes: 67d6d681e15b ("ipv4: make exception cache less predictible")
Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
---
 net/ipv4/route.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 6d27d3610c1c..b549d6a57307 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -607,6 +607,11 @@ static void fnhe_remove_oldest(struct
fnhe_hash_bucket *hash)
                        oldest_p = fnhe_p;
                }
        }
+
+       /* Clear oldest->fnhe_daddr to prevent this fnhe from being
+        * rebound with new dsts in rt_bind_exception().
+        */
+       oldest->fnhe_daddr = 0;
        fnhe_flush_routes(oldest);
        *oldest_p = oldest->fnhe_next;
        kfree_rcu(oldest, rcu);
--

