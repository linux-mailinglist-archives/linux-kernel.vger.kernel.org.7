Return-Path: <linux-kernel+bounces-827212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B37FB9129C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E947D168C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BD8308F38;
	Mon, 22 Sep 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elboACVj"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2AC30648C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544929; cv=none; b=EBsmenaZjUoK7Ybpz4Eif0muJs1skIgR8M5LSzFIUYyhCoz1pedN+zp4l4CfrhhQBj3KuAe4xqwrs38uoq8zSq9h752YeH2WUL+9WLNXZIcl+ptRq4v0DzpswBuYUn9wu5LDpjZ7ek9fI76KRLwZDxKDCij62tGUuUDwPEG0ff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544929; c=relaxed/simple;
	bh=1Z/FIrvKbz7+7KzkAOkAw8QtjVUi2Kn58A3/jKJj3TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pztBjAXplhBWVNX+dyhiXYJUkGbjtjhVc/0NPwNrfuh00gSBz8Zh7PY3h9C3xpb9NUhPUOGNNOK8TS5X81GQeT8BnU+JNio4QaVXbSswy0Q7mrFgAsz3QnmYyGyANSq6SvXVc9ymxBmjYazGwtDlZ9IX8HrIptRbDn+ITRshJ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elboACVj; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f198bd8eeso1141490b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 05:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758544927; x=1759149727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gLN+Eh1NQwEjC26VvFwkCS0AGaveETF0mZj2seOGw3U=;
        b=elboACVjG3ERGMEQyn/F/LD2fkjahXgRw2T9SibZwHkV1BfkANqQbA3vmC2qZovPGt
         rfLLC5PP77C739aCnPMkyBn2iZ/CVw2uUXDPCnp1XtbaClFeR388Yp9Xi9UJzB92KNju
         tQZB81dwJ6Kw1+7fnerFDy+l4uEteVxJm8b2m0BrLxUYFKVE457ysEoFxTpu3fM/j3hj
         lMjuXxw0S25ZE5AhqzQnmqV9/OE3IOsCkhF4KIcaAdy3cM0Wwtdt+X6+/RWJwQzs2ggp
         L3Uy9Ajf/yeMftPLrn7UP67OYOY5wmrcS5au90mwrsaBaz4xcx3xg/3S+EUfvgxmEjGa
         W9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758544927; x=1759149727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLN+Eh1NQwEjC26VvFwkCS0AGaveETF0mZj2seOGw3U=;
        b=rN32wh8gbNWoVGfDYqiXN/b/BUuKQG726BtzO93zPKOSrDsHQXzFXADoP3oIqp+Tg9
         H3iCMihI7VENiM6YCruDEs2JUQtgNcWOSKjLDd/blDFx/Sdyw7ESPUPNcpc1QrP1g1K4
         bsZXzXR9nIwwpxyjs3yMGNmOLEFQn8GbfkjZJuh2RfaCSuH3RgM2zjVTYXBtOgM3wwAH
         xkgVjDAbbOl1L++10oC26xHNvG1KP/duEkZcOFPyjNfG9txBJJEUJHcBFQzCmiz4b5rV
         fPVO2KTHzJeGmrPF15n6mO2HaHZcg0Qy4uelO8daBhCziJnTqtZWCo8SAFRhzECoVqRz
         DWFQ==
X-Gm-Message-State: AOJu0YxT0P8D8YX9wYcFbFi2hj1scjEeW98uNChbbK9fUWLZpR7564FW
	K1Y7a0AY054w+MlQ4KAFb8FllUHD+728k0kS+QzoOEjMVY8EG5GwXH5j
X-Gm-Gg: ASbGncu1NvhUpau+KC+ZMQzJCErK3Dsw+DgFJ8S3T1YyoYskgiPwqHfwpBl6i1JSg6T
	XSud3fwNjzEHjniVU/lu4RkTRrigXXmQzMJ1GHpRQrEYn6IFU2xiD7M0pnNzGijNYO+uXUvaoED
	Ydy4WvgddW1GG6Ejtk9fM1sO/K9Qc0lO3WVUOPTUdAb5AaDJPgXEcte+8ajBijP2elrsz1mjuWv
	QOfkH9CWkv7WFIZRnM0FTWFKNrAuXG3luKubqnePbHLzG0phcIuVHb0WkUFop9kZn55YNo8xzyN
	FHHCWiW9f8L0iE0PMY187iaLszRveoVa2YUxfaylc+zvx2VUioHb4bOmB091qC4ezFWwJwnQnky
	jt8ykwkVtdUyTwJZS7yNzB8xnDB6H5h9g
X-Google-Smtp-Source: AGHT+IEZLp81YiMoMr4WJAQZOMI4sY+pLzRlLOa2OPN7d+0DTygMiaREKyXTG4t3hhVgfLTO4tewwg==
X-Received: by 2002:a05:6a20:1584:b0:24e:5de0:1661 with SMTP id adf61e73a8af0-2925a79e6a7mr16414061637.11.1758544926906;
        Mon, 22 Sep 2025 05:42:06 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2f76f87dsm3956723b3a.48.2025.09.22.05.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 05:42:06 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 431F34220596; Mon, 22 Sep 2025 19:42:04 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux AFS <linux-afs@lists.infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next RESEND] Documentation: rxrpc: Demote three sections
Date: Mon, 22 Sep 2025 19:41:37 +0700
Message-ID: <20250922124137.5266-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1523; i=bagasdotme@gmail.com; h=from:subject; bh=1Z/FIrvKbz7+7KzkAOkAw8QtjVUi2Kn58A3/jKJj3TA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkXnf4lORUeDLplmjbL5F1+i9Sy///zDxvV8JpxHHGoM 1L9/kGio5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABP5sYPhfxHLKpebfW8myr1q 6k9e/FFswoeKQHavp/0v/OczM6UpbGRkeNs59d6uA945b/fbrfp60NtHvXvL9vAGgVNTfLjylvh 68gMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Three sections ("Socket Options", "Security", and "Example Client Usage")
use title headings, which increase number of entries in the networking
docs toctree by three, and also make the rest of sections headed under
"Example Client Usage".

Demote these sections back to section headings.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/rxrpc.rst | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
index d63e3e27dd06be..8926dab8e2e60d 100644
--- a/Documentation/networking/rxrpc.rst
+++ b/Documentation/networking/rxrpc.rst
@@ -437,8 +437,7 @@ message type supported.  At run time this can be queried by means of the
 RXRPC_SUPPORTED_CMSG socket option (see below).
 
 
-==============
-SOCKET OPTIONS
+Socket Options
 ==============
 
 AF_RXRPC sockets support a few socket options at the SOL_RXRPC level:
@@ -495,8 +494,7 @@ AF_RXRPC sockets support a few socket options at the SOL_RXRPC level:
      the highest control message type supported.
 
 
-========
-SECURITY
+Security
 ========
 
 Currently, only the kerberos 4 equivalent protocol has been implemented
@@ -540,8 +538,7 @@ be found at:
 	http://people.redhat.com/~dhowells/rxrpc/listen.c
 
 
-====================
-EXAMPLE CLIENT USAGE
+Example Client Usage
 ====================
 
 A client would issue an operation by:
-- 
An old man doll... just what I always wanted! - Clara


