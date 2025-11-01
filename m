Return-Path: <linux-kernel+bounces-881196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA01C27B15
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E3DB4E39F2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1476E2D3720;
	Sat,  1 Nov 2025 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU2izvzU"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0852C3274
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761990485; cv=none; b=XuAEaw/0KkoFBnhK+UN0EvqznSfw9FKWCcgln2G3t1GwS/4xmexy9sJD1+dNnvl8xz5mExe5eM12+eWBo7jow0d/FMCp/XeQN81uFlIeLcOhv0zBwY31UlyZgbVKf6McX881MlwTqQvp1Cr7Tro95Dx63tGE7vCjWkvEtAxejs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761990485; c=relaxed/simple;
	bh=0r/UGJ3UaHLl4TwoicvZX0eMMWSJJZ+kcuaobIcvNx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnQ2eyFmNLb1/bulcrK+kSOcx0swAepWtmuKX4c0zlIh/VCKZfLh92fqh2W6aLnsEvvvkZBacVJzDyDyj3jp+KhzYHkpvXxOAGnS7xb2LIKqKcn143AfDJR9JQoOciTrsULKqH+e1qWi360dnPoz2jmNvxXmoB/66yNN1K7+wRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lU2izvzU; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33255011eafso2687147a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761990483; x=1762595283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KN/frS9jg4jcQJc1DwfaOMBwxNMdwpEGRN00rohe3M=;
        b=lU2izvzUaCbol2zZGwLYF/TRdhnjXAZbWWTsInBfdVoWcaRE0aI3FprLoCSgj6E26f
         b3zV2UmSOoFeh11m54G2diji5oUmxUSqN02cszQiowxgSKE1UXW0QBX9SMidVlynYvz8
         98rK+arP9GF3ehUYW6bStoDX8ziNkaNIljQ0+Xm+4za98rrtzN3lW3Ftc6hEU96wSEmw
         m4X6QGCwRwm5wJ8N6h3trA14E140l5S9bxqAKR22bRBPYV65cXMB897dv1MA8Lqve7kO
         I9qTe18o1X/kGRKvynnHlMPV7sz+w1xhVOyD8+q1n5idwMF/WG0T1ypTlWdCgGkxugvh
         a2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761990483; x=1762595283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KN/frS9jg4jcQJc1DwfaOMBwxNMdwpEGRN00rohe3M=;
        b=szy1OCnRPYnwZAeWxZ6dO7Zz4kbplLocBi7gIh62fov9uBq2FxJotPPdIBjYhhmGkx
         WZUkSbwRepzb+sPsGjcglArVG7jXiJCxqBuQufxAkBSBagO1PrdOkB1npU35l9dR/HjU
         JRUqx1BUoUgBpk043ufa6b6Wv7WovnGxZKOvDpeujAV7qt6CiZwYZfh5k0ovMbwft3on
         mTldKMDfI/Msf7geN9Lf96qsx/Uy3RndpTQQMvpFPddYRSOLxTPFoWN/+lFcDgU/yMwk
         ct8U2CTVgT8dsk0W2PgywkkTaI12aC+d6mctF0LcIFCaZ6t/jArJD3etQ46bXTpj46OT
         mTRQ==
X-Gm-Message-State: AOJu0YwBB3Ap6g+aR2bwdn2ywkJMqBq0C/VVG94qoKYb0wBUMKX7FFIX
	O+x00G2MMMNzxcmO4o6eAP7Ni3mtFdLhumaU0mD/c3VymuKUMttu/hKg
X-Gm-Gg: ASbGnctP/68GQIXY2yroz/+ZoOzw4JsQ3l7uozKLwi3vdXW/BlT1/Am7KLoa9EnxdVi
	yjMVGq6HgiwmSXgJzqIO4Y/XIREl4XJoKmQ3wjPp47zZ88sVwuNZc8KOjm5WHFSqs2cpgHv7L43
	4bMc8dTUmjBR/tJW9cBCvGQ+LpwDXrEeMRzPjsBeDIq82O5JV0WZ0Xh1hAud0SHe4ofFwwbROTa
	ckP+L9EzVtL5dj9vaa5V8skshimnNFRdiLmiB3bKw6xZ9wO9GDEBMS9xxbw+UmMHaIEQfRehuit
	gpxmlRgXHb29l9vBUH3RB05Ve1aj5Ms6N+dallv9WLy7IEsZJyJN7/n1E9TeUsaN8ZXvwheI6z8
	S6JNpu0xtakuI2Aw3ZM8Jf4m4SKDUcWyNDqmUzzW7RQYiaEYb3AWwfthlgw81KBSJYzGIycc+yp
	2TL2ZaWiDkkLc=
X-Google-Smtp-Source: AGHT+IGsYXtd1T7KUQJwUmXpPfa8NKulKKA88l/h+qYrG9Wj+FnsHwCW+OhVIOHiRESe6quJKXaOlg==
X-Received: by 2002:a17:90b:3f4b:b0:327:9e88:7714 with SMTP id 98e67ed59e1d1-3408309dafdmr9468011a91.37.1761990483094;
        Sat, 01 Nov 2025 02:48:03 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34092d69b89sm4609672a91.20.2025.11.01.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:48:00 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9BBA041FA3A2; Sat, 01 Nov 2025 16:47:56 +0700 (WIB)
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
Subject: [PATCH net-next v2 3/8] Documentation: xfrm_device: Separate hardware offload sublists
Date: Sat,  1 Nov 2025 16:47:39 +0700
Message-ID: <20251101094744.46932-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251101094744.46932-1-bagasdotme@gmail.com>
References: <20251101094744.46932-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=bagasdotme@gmail.com; h=from:subject; bh=0r/UGJ3UaHLl4TwoicvZX0eMMWSJJZ+kcuaobIcvNx8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJms13L/N23ty73Xvau/VKZ5goLNL6vkoKQL65l3/NLJ3 bXRkvVvRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACYSdZSRYcOHbU2fPJ7Jxb5o eSQb6JvpJK7hv5LR9lP/7XcGTkaq5owM+21jc5bXSz4//43dq53LPiuMTXjxwQXurTExz74HTZ3 KBAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sublists of hardware offload type lists are rendered in combined
paragraph due to lack of separator from their parent list. Add it.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_device.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index 86db3f42552dd0..b0d85a5f57d1d5 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -20,11 +20,15 @@ can radically increase throughput and decrease CPU utilization.  The XFRM
 Device interface allows NIC drivers to offer to the stack access to the
 hardware offload.
 
-Right now, there are two types of hardware offload that kernel supports.
+Right now, there are two types of hardware offload that kernel supports:
+
  * IPsec crypto offload:
+
    * NIC performs encrypt/decrypt
    * Kernel does everything else
+
  * IPsec packet offload:
+
    * NIC performs encrypt/decrypt
    * NIC does encapsulation
    * Kernel and NIC have SA and policy in-sync
-- 
An old man doll... just what I always wanted! - Clara


