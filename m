Return-Path: <linux-kernel+bounces-877690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1DCC1EC15
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B0B84E758B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D387F3370F8;
	Thu, 30 Oct 2025 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0ZmbZzI"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E513358B3
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809411; cv=none; b=B1Mag55++X6zy903FWY3Rz5+wg1wjVZ4PR4PIXrgwxRmD7zFdCJXbPafnqAs1CEiaLAcwtk4aehXzJ+5JVMpk6bWwpSpDot5dR4NT766uiwZb7XeRRWkHNjlzdRtXUEdhZCo/WLfcWokuekC8Afe7JnL2ZCx1DubwUE/KGbXz+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809411; c=relaxed/simple;
	bh=JEl9GC42JmfajoHCarU2JPEtxV/Dvh3GNqFUPBkz8So=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=es8UJBD9RWenMKB4IZhAZsFkB7c5LX+Q6PNsJZwTVJZSGnXPZQGct5dmvrYDwQRSBsPpJYiEQev7i7Vik9WgjfVOchC1Lohoc529Z1iP9lUc95461HOi1DAQSbbp6//hEOHDc7rhmvxFlPArFV5RyK5HJ3uIon+6/jElF6arVuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0ZmbZzI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33e27a3b153so840300a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761809404; x=1762414204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vdDJYs2ftj9g3gsNmVUwfcn6X4b2n8l3NR5CnT8xsbU=;
        b=V0ZmbZzIGnlOpu/06RNsyXxKeyupSXjb2mOzW3Wqkxq1KrJRk9iKcal67eoeNvpXJi
         FuOSNPtyqOcDo6QeOpicA7UxeRi99wd0BDn5IPVSXesgeBJvW/ewK8qmvPpDgJFJfGq5
         Bt6MrW60/qHSifP2n+o93iQeTKGtGGLEpfNwOHx9N3HpZ8aS4jRrR/JR8CjFiTo7TjRW
         WGxO2AdkSkZjUKtQHZdWh1cQ1ck2D1yYGy8x4bOaT78FmyCLGbNGeNSdu1Hvs3k7kGUS
         ihHqzSio+tTZvyz9+hqiEGn+Cl+p2lJ6jhoYLNGWZEcSq5umb0Eo/ng3VFBrM/t99X5j
         ossw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761809404; x=1762414204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdDJYs2ftj9g3gsNmVUwfcn6X4b2n8l3NR5CnT8xsbU=;
        b=c9yFt+H6s/ClaXmSE79z1RH8wKu52zwNABrycDxbk6A7e4oxicBdhLOl2sP5wpaVE/
         tNKyVAnbKerN9RUBufTe5SJ3lzCOOjEHAPAW35rvDmthzHQ8KDmlf+Hlp1Y3qceOxaZF
         GcQnPRyjpkQwOhenpBa/jhMP689DQBsW7b4wDE7qWsj3eGBKhwZ8ZBX+83OwKBAuQr3Z
         9McrcLxX2l1nronz+vREsTnhei66zTqQJSZaXj9xm5M1koKUocgAlbh3eo8qeXOl3pbC
         cKOT1pJ3U+Awf+lp2YKnSmGHDUlG2iDAiYgsNpxuNPBElpSu+NviEq8b4dkubOjxYHRG
         8KDA==
X-Gm-Message-State: AOJu0Yz+8CbsBalmwC5xGN9a6GC82FPiWHJCV31cVDnx6M2F2qCw08ph
	8/G8UI1cPy7Po1vFa967ltmAPKate6LWTGVlcCnRtD0oNTMj91zIAOte
X-Gm-Gg: ASbGncu69wUuYrx4r8J0UOy88Sg27HjCKTJAsYJWFmeAR1sjRnu7Xjq2FkI3PlIRUJk
	G4XLxHryNFsg+mTnDmlOd3YvRKrzG5H7RbKEooIIAG2TGq4oAxQViT6KX42Lg5vi+fgrprkGWgo
	/rWRZl/lirMnaTmCCsRQg2YLMH13tzBwgjz0uNvawJZPoj6CNqBz4ew8CV+zygvuMyuYHl4AUr0
	tVPpepYuX+JQIO2TbsEnQFkkDKFStaN4Uu5ro6vEL/9R3n+ZdID2uPQHkjPfm2EnkQ43ygRqkSg
	+vZgI64mWtGJE+kAGVoCG1S4lzAepCpES8g6ovtE1SlFa9IC1VMnl1AW1z46/nFnsDuT19zvy6e
	0Qw38yacpNWY+6mjusdnw3yImcmzdPsdeRYW7hTiZlM6vab98AjtLGDzV5NFOiFoVD7Q9/lgdO/
	Um
X-Google-Smtp-Source: AGHT+IHmZ2LrOAPsOHzLCV0R7WL6u7SHBbA5fx1AuypMoq9aZiir9lY6E508nqoYTXIY9ZDt2yElfg==
X-Received: by 2002:a17:90b:3906:b0:33b:ba50:fccc with SMTP id 98e67ed59e1d1-3403a29a3c2mr6444652a91.18.1761809403953;
        Thu, 30 Oct 2025 00:30:03 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3404be704efsm1002505a91.0.2025.10.30.00.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:30:02 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 358A34209E4B; Thu, 30 Oct 2025 14:29:49 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next] Documentation: netconsole: Separate literal code blocks for full and short netcat command name versions
Date: Thu, 30 Oct 2025 14:29:44 +0700
Message-ID: <20251030072945.38686-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=bagasdotme@gmail.com; h=from:subject; bh=JEl9GC42JmfajoHCarU2JPEtxV/Dvh3GNqFUPBkz8So=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJnMwhlOXPI/DJQmTfk5adEEqQUnNix8yLrm1ou9Mbpf9 rlcfROj31HKwiDGxSArpsgyKZGv6fQuI5EL7WsdYeawMoEMYeDiFICJTK1k+F/xcGfWlaBJJ//J ZvqcPx3p9qUw4oXfE9sDYj9fV11zW6zKyPC4x7tt2V7RhLQMT7s017pXX1aHaCvv7b3DduBVTH+ XHhcA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Both full and short (abbreviated) command name versions of netcat
example are combined in single literal code block due to 'or::'
paragraph being indented one more space than the preceding paragraph
(before the short version example).

Unindent it to separate the versions.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v1 [1]:

  - Apply proofreading suggestions on patch title and description (Randy)

[1]: https://lore.kernel.org/linux-doc/20251029015940.10350-1-bagasdotme@gmail.com/

 Documentation/networking/netconsole.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 59cb9982afe60a..0816ce64dcfd68 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -91,7 +91,7 @@ for example:
 
 	nc -u -l -p <port>' / 'nc -u -l <port>
 
-    or::
+   or::
 
 	netcat -u -l -p <port>' / 'netcat -u -l <port>
 

base-commit: 1bae0fd90077875b6c9c853245189032cbf019f7
-- 
An old man doll... just what I always wanted! - Clara


