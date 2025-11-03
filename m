Return-Path: <linux-kernel+bounces-882183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF87C29D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155593B3A78
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 01:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD0928AAEE;
	Mon,  3 Nov 2025 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lES07R3Y"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA93727B4EB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134672; cv=none; b=ephPLN5XNAlBFvzVYokmdDaRQH0pbZkCoAgKmILlAq7J9eWRfUG0fV08uhlcQt1vVDKifZh8hG8SB73pdAvm5cDtug6xsnBn4VT4APtRU0c+/vxnTexyksqzd6ZgFcoVDx9ZX7OktLkTfIEi+3SC4q1XiPDbO/SAJMXvL9uwebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134672; c=relaxed/simple;
	bh=sfgU5y2QPjvrAXbG+U0LiiWgUg/Fuf6oZn2j1UBM6ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HM9TvfQJ+HDUpPQxWdRNmQFkD1JoUEf4ay6min8ZJDUMD8445yEbJlMP5oHDgRs0ZG650dEOTO6xR4gKE7ftGghQB+MoZyqd3dqTitSrKKG+2AhO3YWpOYKYUbL2mBuJHF2MV334jEdpJ+XrsjCZWbYcP/qMG2DuGBj2rMiQ4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lES07R3Y; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-294fe7c2e69so33817455ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 17:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134670; x=1762739470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0sO15jizAVsKQGPETfERnCJBpOXGRp0v1lRQCXQwiw=;
        b=lES07R3YbE8ojmo+4SEozXLt2VsYvvanu32C1uE5lWszukD4GmT9gbkr4XHUGTTB+q
         oTHYwj0IYh3UglEzdTrMq3L0aKtGZoRhnlhDnJZ+jogu6GZzIUTCdTUNn2Tc9iN0P4vN
         +EskWGSSTJr+HUYkAu7b0HJlmV63schH2kUfn0bO+mJo0dGtc6lZWhd3N5NsqPQcn/XH
         mhTOOGdKiE2BqxCuRcs3t3U3r9jkSGiQGS6evh3/cav4cGfd2ieTK5I+xqMhvm55z7JV
         deM4VuvjWLGzTzR6WLaXul0hOkl804lXBhy+K/tYE3dtosvn6pZJ+NNg2T34i9HKaylm
         tvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134670; x=1762739470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0sO15jizAVsKQGPETfERnCJBpOXGRp0v1lRQCXQwiw=;
        b=dQzM68kE1YRSWa3uriLOS4Gxvnrk9mjVbhWz8EKZQK/tU44bCZN3TXyzUlqIhC/QR0
         6/t8Ag+dKi4JwACD3pkpXGhvMIqRp7XDuHGSXZsqOJFu2ZuMgMGLiPNijSF2bWJp/pGl
         /rpkwxnAGZtWQkNSBE7kySKLFU3m2rPqlwawx9ZfsOJdnYU7zLQTl6aoUOujfymXzdUE
         WRim4B08kd2SXMo/G/c+Lb+8V0m11lYdrHS5P3KuY3T4+WQCVb/qZ4isdOghq6q0h/75
         HZwXkKCIA5zDYPUqqN/b6WazR000M6wRc0G9AVszj4ns8ETlxkO6NLp3xOXpGcrKb62N
         rnqQ==
X-Gm-Message-State: AOJu0Yw0Zqd534T5DZzVrWCQi4PvNEk4K5sZzx6iuwgXGnhqaiIU0/yj
	O9FgGSSyoZJC3GhhmHLCJEQrzAb2OG2oxyY6zl8g5uciFUMuyPKTiINT
X-Gm-Gg: ASbGncucCN5kWftG130NCDAZyaBTWyhml44E7mjkyBSvBsmi32OvByLnuakrg7Bvz25
	ptWxa3tztOw40Xleow/c72XsrqgKiMjyMEmyRBjvhdHVMOV5x0/jvPJbvFVazELngGVk0o8YXoF
	jQ8zHjoAKdZMZpnhyPKv28dCEdbO/WmnuaJzGubKg3vzbu3ZSxogjIXcJyG+mDd+xwUuKxTiXgc
	l19lYxLOgxIIR4ctOd+84r0AIN4IJbMG2zaORukMkTpEQ+vUbyENBAS+OmmvXQ7M970zoRte0ot
	8/nH/UifLCqqw4faIsjnBnS2UBrnXPuU+XxtqIqkxWqt8RxFgqFAWBkgb96jy3G52+aAw4XEmel
	M7oyyO4MPYKRoxXwgj9Z5BmH5My2fCNJ4LbncXeyeHO1CMImQ69M1jQ+AStS2P9Uj2Fq3LpMyku
	KsrQT5es3aNsU/b+E4vGhPVg==
X-Google-Smtp-Source: AGHT+IGnO7VQHFBrQJzosLohIa8HzbwgIqW4t6VCicsh6dui2sLEi2qdtR2544cc3QnT7CIjAJoUOA==
X-Received: by 2002:a17:902:d492:b0:295:b490:94bb with SMTP id d9443c01a7336-295b49094fdmr18206025ad.50.1762134669825;
        Sun, 02 Nov 2025 17:51:09 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b8aa2a7bsm8311062a12.12.2025.11.02.17.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 17:51:05 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 45B99426D9CE; Mon, 03 Nov 2025 08:50:59 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next v3 6/9] Documentation: xfrm_sysctl: Trim trailing colon in section heading
Date: Mon,  3 Nov 2025 08:50:27 +0700
Message-ID: <20251103015029.17018-8-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103015029.17018-2-bagasdotme@gmail.com>
References: <20251103015029.17018-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=908; i=bagasdotme@gmail.com; h=from:subject; bh=sfgU5y2QPjvrAXbG+U0LiiWgUg/Fuf6oZn2j1UBM6ow=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkcnJUHzKNE3jJLCJxdMFPJ4sHmd2mL7svNrNyrf9eyr zapjkG/o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABP5VsbI8E3ba7Huh0sHTE+U 9LpIdE589K2XoXLy342sni8WCen7NjH8L6qftth175q1P6Zbr+gLEWg/3clvWCgurPhy6pyeigX X2AE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

The sole section heading ("/proc/sys/net/core/xfrm_* Variables") has
trailing colon. Trim it.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_sysctl.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/xfrm_sysctl.rst b/Documentation/networking/xfrm_sysctl.rst
index 47b9bbdd017977..7d0c4b17c0bdf1 100644
--- a/Documentation/networking/xfrm_sysctl.rst
+++ b/Documentation/networking/xfrm_sysctl.rst
@@ -4,8 +4,8 @@
 XFRM Syscall
 ============
 
-/proc/sys/net/core/xfrm_* Variables:
-====================================
+/proc/sys/net/core/xfrm_* Variables
+===================================
 
 xfrm_acq_expires - INTEGER
 	default 30 - hard timeout in seconds for acquire requests
-- 
An old man doll... just what I always wanted! - Clara


