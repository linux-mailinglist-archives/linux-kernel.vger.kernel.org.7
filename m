Return-Path: <linux-kernel+bounces-870845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E61C0BD38
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B763B636E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B5A1DE2AF;
	Mon, 27 Oct 2025 05:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWJLei58"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1241F4622
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761543138; cv=none; b=ZNBexFgApQwJvRZaVu9taQ2VPCkmIUl+QxxCuCrehthmg4ZRMXe8YdmSXkQ1reIQn7WJlffl5fnjVUAE+w/9MowWpiDqSkfBz/W8NP7Hog5feZhl+zaIRnPQObMUTjED1mGmFhl/Isug9wrnaMztZ3ScI60hv9Ofhmjf+1xmeUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761543138; c=relaxed/simple;
	bh=BiZQZWYzCEbU/wZ9q9vihxV/NEjhA6GMCF121pXKmzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3sMRKC0NhIBid6VRv4Bxvy7dlttRG+0cHDLyz5hJ8atVVrf+38Mnb/cEs0hY9MAXcFudnUCg4RDpx/DLbNS+rHgvRHbz++T9PX+SZIWM7dT+SdydkmFKUwiyFuClfUxe18TkdjbiE6yM8wGyph2+jMJlK/5JgMUAwidroM10yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWJLei58; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-33f9aec69b6so5925728a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 22:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761543135; x=1762147935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XvaWnuts0+GAzN1C4s4frRI39aWzTgLO69HpFB7yOYY=;
        b=VWJLei5800qFQKNLzx0eFu3KsQKOQHwaX1ugKh3/uhksJ0r++UBgaR0N9iE2XKuIyq
         RV0BmrF3eu46ABvcYO44fEdj6uDLsgaIzVbZRQebWGqfKHtV+s3A9KMCBHHdH2aYrfn3
         K4LuBDkGjLQg+9uBTTGZ/R5oxc4QErad+0DlviZ/6JqHuuOV0g7/4iuyCZTHvLLLwYdy
         DynleRefFHcLzZYWR75vbwK1OhalyoXw2jKYHJeSuhpKOvnl97h/cdtzKOonrlo1llbe
         XMQchco1w3XVRz3ejjjANQteGujmR+FFoINGwVIMWnzclcjilGfoFoz5rDVw9MOkJJV1
         APNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761543135; x=1762147935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XvaWnuts0+GAzN1C4s4frRI39aWzTgLO69HpFB7yOYY=;
        b=YEEd9lnGKqLfJXJ/RQHKNm3hnh8aTFRdG3u7AItsHYXfUZKoW1xstU5kpQakdFnsco
         6guEgelIEPmp8KyFzqUOu+VapwVaqBTde4oEGZc23Dmbn57SivFsbeARwdWtqrbfla2k
         JXhV6fY61/6VfykA+H2vQtGbVP6XINZ0Em7Oc5OemtT1KOFFx6UUHt0JDSVKuNXwB4uZ
         MvOkg/UeAJEmTjNKlr3yzL8b775ceRJdEHAuN0p0RSQFRLqLdIAGMBkpFlCoq8t0IHF9
         2uM7jSZmvKlNLDueVOJI9X5Kb6/xk2s+N/cjPMrQuXfHZKIASU/yAjaV9wvoXuVYshQd
         hq2w==
X-Forwarded-Encrypted: i=1; AJvYcCVCfBxZ/yj0pjEd7tQMbbbJ1UPYOdsEA1sx68KZY4yi/APN7PKeBdJCadqZkf2emXhi9v/c1SQsvKBv+U4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx72yJdaVXpAmsF26sNM3y5MpKQqR2zGLbUowwAuil+J6XwlkJY
	UyRCpauCpRCpVN5bkiY2z+xairehnRT3lcrlIfGJVVGU3iz6YYCaMOulXcCM7jWjfCg=
X-Gm-Gg: ASbGncvbckao71uWmO19yIfVeXWOGTTOY02srCJRV9FMI0jxkbDhWN/Y8TZYd67d431
	NT33FePGa6Q87fwEE3H4/A4hyz66y33fOMAWa3O0zm3i1dk58AA5u48prWusjNUB38h00zLc/RO
	OQeerFWVj1fomv0prt+rYyEXKayfw80ZgWt3iIIxWaht87s36KN9i/0ORRIJaqgZ/ssKNF8tQC5
	79+P6ZJZhsdARVEOyXt088Hr4qaS1cClxPeFOcj7/t9VZEkHe9c2u9Lq8A4lpoFsHgEz4eHcBr5
	OVWs4XDn6RXIiTxtBX1+xv82b8hm/yUj6GdGivnBmX3FlJyUAeLuKbOB/Zi2fdRfrpyv6H1GMai
	1a5+7SdDdOr6vH8XEoogSPyEPrNsJryqb6+NlDW6iBqp3A8A06/FrO1xFshDIgj/y1adNHay/Fu
	3CHwq2Tfj4P6AC0pxItG8=
X-Google-Smtp-Source: AGHT+IGFxkBGGf3onfO8Chr2ltK6y4LuXfk+2qofYqflJam8vbY4kH2nypV/mGTAj8xXg0sXgRUULQ==
X-Received: by 2002:a17:903:1746:b0:269:a4ed:13c9 with SMTP id d9443c01a7336-290caf85146mr423652875ad.30.1761543135506;
        Sun, 26 Oct 2025 22:32:15 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e41125sm67120155ad.94.2025.10.26.22.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 22:32:15 -0700 (PDT)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Xing <kernelxing@tencent.com>
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH v2] selftest: net: fix variable sized type issue not at the end of a struct
Date: Mon, 27 Oct 2025 11:01:56 +0530
Message-ID: <20251027053156.34368-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some network selftests defined variable-sized types variable at the middle
of struct causing -Wgnu-variable-sized-type-not-at-end warning.

warning:
timestamping.c:285:18: warning: field 'cm' with variable sized type 
'struct cmsghdr' not at the end of a struct or class is a GNU 
extension [-Wgnu-variable-sized-type-not-at-end]
  285 |                 struct cmsghdr cm;
      |                                ^

ipsec.c:835:5: warning: field 'u' with variable sized type 'union 
(unnamed union at ipsec.c:831:3)' not at the end of a struct or class 
is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
  835 |                 } u;
      |                   ^

This patch move these field at the end of struct to fix these warnings.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
Changelog:
v2: https://lore.kernel.org/linux-kselftest/20251027050856.30270-1-ankitkhushwaha.linux@gmail.com/
- fixed typos in the commit msg.

---
 tools/testing/selftests/net/ipsec.c        | 2 +-
 tools/testing/selftests/net/timestamping.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index 0ccf484b1d9d..36083c8f884f 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -828,12 +828,12 @@ static int xfrm_state_pack_algo(struct nlmsghdr *nh, size_t req_sz,
 		struct xfrm_desc *desc)
 {
 	struct {
+		char buf[XFRM_ALGO_KEY_BUF_SIZE];
 		union {
 			struct xfrm_algo	alg;
 			struct xfrm_algo_aead	aead;
 			struct xfrm_algo_auth	auth;
 		} u;
-		char buf[XFRM_ALGO_KEY_BUF_SIZE];
 	} alg = {};
 	size_t alen, elen, clen, aelen;
 	unsigned short type;
diff --git a/tools/testing/selftests/net/timestamping.c b/tools/testing/selftests/net/timestamping.c
index 044bc0e9ed81..ad2be2143698 100644
--- a/tools/testing/selftests/net/timestamping.c
+++ b/tools/testing/selftests/net/timestamping.c
@@ -282,8 +282,8 @@ static void recvpacket(int sock, int recvmsg_flags,
 	struct iovec entry;
 	struct sockaddr_in from_addr;
 	struct {
-		struct cmsghdr cm;
 		char control[512];
+		struct cmsghdr cm;
 	} control;
 	int res;
 
-- 
2.51.0


