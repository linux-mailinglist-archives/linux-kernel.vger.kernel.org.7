Return-Path: <linux-kernel+bounces-852478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E1BBD913B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DDCA4FAEC4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB2F30CD80;
	Tue, 14 Oct 2025 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b="whrYiz/X"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3A30FF00
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442221; cv=none; b=DBTvjCZVjgBN98o/vyyrison0XpPL/FIcUunV93zm6tGMbakC0JjWkbOM9FGbRDZHvjq3qfMqEB8gx/VJvkfEn3+fWpfmMPwtjg/8rt/JaNcVo/dQmyHzdeOlQ2dPNq2yaOC0eEMcBlA5rz7hbM8ilO0zpOJmjJcmyDTjL1TnG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442221; c=relaxed/simple;
	bh=9Anz8SdWCHj//cI708iSDs2qphpPgNV3XK3W9CnyRRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJYro8VYiDP0R4IGJv4nkxHznBzfExwIed7mopwPb/qTAw60vl3Snhhatbl8UdPqCSo4th2hQzJkuHd/ig2g+j//YT0TzT4wmRx0oVe8kzWJu0gigkpwPP25u8JAgxS9touqZmOs5Z+cq8+Hdd3+EDfai+F1q/08cjYBr46cLoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io; spf=pass smtp.mailfrom=vyos.io; dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b=whrYiz/X; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vyos.io
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b00a9989633so1017728866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vyos.io; s=google; t=1760442218; x=1761047018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tzi/ei+DoEPQ0UXsEb+6ZYb7S4ThZhfVu5KSSSvXqaE=;
        b=whrYiz/X92bu0MLAMI7oDBmG4J8MsyotukbZ+P9yvz3KFXjkRjiet6ecHeVRQCe7nk
         ZG30hDJPH4FeW9jPnBO4TCFnRZw0anVkNwUTWCMzrk6JowQL1/W9vrvsauMs9BZCjFfH
         7/xwgtIQO+RGWny2R9IgouA1UdCOf4qUcYCse2KhGH4X35rHLuVfnzGb8XmnKC/rjxBZ
         P5c1sFZGxGe/nsba18UqhxbpvFquIdq8ohZAnTFPSI9jEAp2dfXdkD0lm6lfRCbwbnKN
         xWJsqK/ht+fs7XVhe0AoBjLEEi2ZprMmC5Xqz0vnMnoIqAWtr7IUt0kzn2XPvVp16LSg
         +MBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760442218; x=1761047018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzi/ei+DoEPQ0UXsEb+6ZYb7S4ThZhfVu5KSSSvXqaE=;
        b=fShZfzBmyDERHNPwC8+1GV4rk+8aRnefxPlZTEKuRD3vQA+oXcWISwGw7unnuUCx2c
         aee32px70NP2ioKTKJlBHUUTL+Ef6bTHLueIV3/zr3k4oXhr7CZYhiAbyoU3M+ckkPmZ
         eNmwP7PoIHQh5r0Caqjrt2ceJK2Wz9QoJl0fczYWqd98zgvN4rWoCGvEQrFrxEk+Hvxv
         6scTwjN05ZjNb+OrkxQNrKgnSfk6wBh87d2y9aUFn1lu2PT+X3hN05TaKzqOsMM4gFpq
         fZzltaaQwbE6+n5j/8P6CCpA8ZGAgRQgnUjPj9DfoiqcJCHSE6GdG1DbsrQfdZ7/aRZo
         0z5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNXAwfrYswpYQxbEN/NvbSKU0vuVw05VgdQI4FSTuBMR7mK49fSzW+SfXumLBo9PQqNCVoV0Amu3vE/44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwgGB3pKQ0HwE9seu+FkEXDkSitl0BH4PaJbcUO4owbINBQflC
	zbQzZSMRy0fmnvJ2aV2V9NmpoNLj2l394fLJZTJlsCzoAYtBD/hEnwGiKc7LRT0nHog=
X-Gm-Gg: ASbGncv4fBxUrnu9rZeXKy1tZwoRMDWT/kiHlvIZn6mk3b6DjSELSK0Cz/lJD2lIk+l
	wJTPC4YbA/EPHmC91M06XtXY9pm/AOIKYqLTB/sQ4zMNDL3Zrhi+WU16NgiE2JwbfKTddc0JVzS
	RpPor7LwgkWKQKiAmcqh9SWeRX5lqgPXPBRipqRiVQDWavK5H6OypvHXz+s1+42XfdGrDF0cKOw
	P8a15N8lA/lf3mjjCpGVsU1zVl9tm97jeaf6Q9u7jNf0iK7g0xp0woP7f6J9Z0kOjt7IOilCE4I
	0AdWw8FXtbReQoivAPZX0wy3TQ2rWSPXJWG4nFAd+xJi4oCDXLB4PsIWUlFeZpB/XnwOWaxL7AN
	7liV6NROlumyhFAtZn/VpFg26a9bxEzXorqOJWxKOOZkabQLYPu32fpTXvpKl0DdWq/zEYbVotr
	KGhNMth26BfJ9MoA==
X-Google-Smtp-Source: AGHT+IGZy8B5qcY5omdqnsSW8uejd8MU/DWT1dZAEfS/f9Fb8Rfos0k20W7zR+hFEx57vClHrSnnPQ==
X-Received: by 2002:a17:907:8694:b0:b40:7305:b93d with SMTP id a640c23a62f3a-b50bcbe2701mr3007302166b.2.1760442218015;
        Tue, 14 Oct 2025 04:43:38 -0700 (PDT)
Received: from VyOS.. (089144196114.atnat0005.highway.a1.net. [89.144.196.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c129c4sm1150091766b.41.2025.10.14.04.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:43:37 -0700 (PDT)
From: Andrii Melnychenko <a.melnychenko@vyos.io>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] netfilter: Added nfct_seqadj_ext_add() for ftp's conntrack.
Date: Tue, 14 Oct 2025 13:43:34 +0200
Message-ID: <20251014114334.4167561-1-a.melnychenko@vyos.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was an issue with NAT'ed ftp and replaced messages
for PASV/EPSV mode. "New" IP in the message may have a
different length that would require sequence adjustment.

Signed-off-by: Andrii Melnychenko <a.melnychenko@vyos.io>
---
 net/netfilter/nf_conntrack_ftp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_conntrack_ftp.c b/net/netfilter/nf_conntrack_ftp.c
index 617f744a2..555ff77f4 100644
--- a/net/netfilter/nf_conntrack_ftp.c
+++ b/net/netfilter/nf_conntrack_ftp.c
@@ -390,6 +390,8 @@ static int help(struct sk_buff *skb,
 	/* Until there's been traffic both ways, don't look in packets. */
 	if (ctinfo != IP_CT_ESTABLISHED &&
 	    ctinfo != IP_CT_ESTABLISHED_REPLY) {
+		if (!nf_ct_is_confirmed(ct))
+			nfct_seqadj_ext_add(ct);
 		pr_debug("ftp: Conntrackinfo = %u\n", ctinfo);
 		return NF_ACCEPT;
 	}
-- 
2.43.0


