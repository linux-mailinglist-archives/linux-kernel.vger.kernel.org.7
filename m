Return-Path: <linux-kernel+bounces-874379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E57C162E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 932FE50464A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0E534F474;
	Tue, 28 Oct 2025 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTTSJAPJ"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EA734D91C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672606; cv=none; b=Bqt1M9OijbkgbhTxgwbMtA1vWSfWXZrC+LKnpo3eGPSyWGjqt7NibwARv8DdzN5NczXTZRlIoOihkTrrearBPpxQjFQggvuDYduNtLXJ9uptLTkcM5ims3531jv5lpRO+Cmdalje1nvGRVKwEnB3pmql5FXEsUMA3UYFsWfXQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672606; c=relaxed/simple;
	bh=SuJH3HWPiM306OrhrNAnCKKfLjQue1QzIizP6/wUym4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/BK+f66I5MDvvE31A+fb5U8q8pdxuPylDcg6yLndnR6L+bqINCKTJZNktNBS853eQGP5RpPxXpeDiX/wqm3dhXJpEirt4VMPmJTuCKiZ9n07Pf5UXRztKIgslqqEVN4a8Msg1cQiyCYzMPXuWeMq8kTmwX9m4QwkLnbXFfLzzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTTSJAPJ; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2697899a202so980545ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761672604; x=1762277404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eLUXKj3JdQcNGrW23cOuQo3J+oSHDUHH9EfbwIbJJXk=;
        b=aTTSJAPJynIoQg0lb3IO/0eK8p4kLxzuQSHUauj5fzlwjsenWnT4fOcGy79r33bDgp
         pDRw9SEg36LGsa3gTvPBlJvB6vf6TZO5UCOL6nZ3qx7S6JGLCJ5GBydj8mPsmu7ahb9m
         QZPBcFeNEz36G8ZMohy7YJXKqbj5X6zdyveGzB2RgqHjUoLbohV/aSuV/LLsEpWBBEMv
         d3N8Kf463x1V9hOikdJN/ZFac8CWeWQ7xc5K/8SQHVLhy+XN9/c+cHw7gDMDiE/x8Ppi
         8StagREI89fnRQklOKRCc2a2FYU+Jm0vxFAXAtIsXbwsDex5Bx1zNCCuRqqb/0awlqrl
         eKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761672604; x=1762277404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLUXKj3JdQcNGrW23cOuQo3J+oSHDUHH9EfbwIbJJXk=;
        b=uFU/hVSoOFGO1+zUpOPQ5QLXPOy2XsNSQ13rKTFW7Pl/vZljoW0GK6gJkwUVxK2ms0
         JKVuzTgcv7REfCmlL33gGlvzYBjbRd7h4qIoNzyavtKw+eO5EbO9VTi+8SwUXgO6W9iZ
         YorzPuVwCXDXPh7I9bYQJlXKgyF94OjiLjZcZGjRqoZPgFsd7PwQ21yJ7ty8DtKisQ42
         op63yzRsUUdWkFT/zlU6Mgx9LWo60pXcCvf7gLsUWvY3VN6tIj9AM++h74CiRHQ7MsjG
         Bun2rMIj3WPhfH9YJKV66zojEaqlNhs1ziJb1K3MN1lD8I+JEwhl69NbQUe9e9Z5Rvw7
         7Z/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWo8/YA4mNMmaLQGASGZRIQag9IzXOHxIqaYUFYvLk3TMnno5vHE/b45QUQCQub/S6Nh4WgCRg+VRxnm4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd4SXmSyc+RoOUAowqkM6AxrQAAlCvol2v/rAiJV8kwwZ9x1hq
	suVAqYl4JDl3+dgdRZ8j5GIF5+vMa/f9T6W2nE58J6sUaGEakhhoynYd
X-Gm-Gg: ASbGncu/FOFymMWWGBsZOmjgjYAIeVCa8xlZGtpzwIemdVOYNGakaqkHHrEfCxcH3Pg
	WoTwYSn+MDvIgWP5trixJT2x7WxIUJSwkkmLPBRqfYSrIi+kUl4qklEHMp0zE5LuBjO5dtuLf9d
	YR29vp8i++NN6n+kIS59Vet9UT6vs9m/dGifNW1GmQZwrI6dW4su0iwMrsi1lAjdFe2m84F5VjR
	aD+s3fXMMnGi+OipWcg2BPWR1Xp979VzQqRV11Mb8eMYOzJ+ZgRyqPKwOnegUiQMqW9Htw6mfZf
	rTwmZBJIrljyc2dnp6lFsiD3JnleD+pOdZb4BuQBUrF3vdbL4FmG08AQA6GcbIbj7uVaR+bywna
	d6Zlqg7Y6vOWn/JNaTiy+3DLabUxCtxkd1K+X5j0bnDoGyoizDi3AWNyuVmndfl4JBzhno5t5Li
	zZtqNJtCLK8IWwsuH+gILg3WZrwmfvGA==
X-Google-Smtp-Source: AGHT+IFtX2DEf86QAUTfh07/RypVq+7k1EhRmR6o/ag686o7shl3n/6W/Quvmd/xiNh5jfkuDo/tDA==
X-Received: by 2002:a17:903:2f83:b0:294:8c99:f318 with SMTP id d9443c01a7336-294de7f3f19mr861325ad.3.1761672603628;
        Tue, 28 Oct 2025 10:30:03 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d41c4esm124942545ad.81.2025.10.28.10.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:30:03 -0700 (PDT)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v2] selftest: net: fix socklen_t type mismatch in sctp_collision test
Date: Tue, 28 Oct 2025 22:59:47 +0530
Message-ID: <20251028172947.53153-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Socket APIs like recvfrom(), accept(), and getsockname() expect socklen_t*
arg, but tests were using int variables. This causes -Wpointer-sign 
warnings on platforms where socklen_t is unsigned.

Change the variable type from int to socklen_t to resolve the warning and
ensure type safety across platforms.

warning fixed:

sctp_collision.c:62:70: warning: passing 'int *' to parameter of 
type 'socklen_t *' (aka 'unsigned int *') converts between pointers to 
integer types with different sign [-Wpointer-sign]
   62 |                 ret = recvfrom(sd, buf, sizeof(buf), 
									0, (struct sockaddr *)&daddr, &len);
      |                                                           ^~~~
/usr/include/sys/socket.h:165:27: note: passing argument to 
parameter '__addr_len' here
  165 |                          socklen_t *__restrict __addr_len);
      |                                                ^

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
 tools/testing/selftests/net/netfilter/sctp_collision.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netfilter/sctp_collision.c b/tools/testing/selftests/net/netfilter/sctp_collision.c
index 21bb1cfd8a85..91df996367e9 100644
--- a/tools/testing/selftests/net/netfilter/sctp_collision.c
+++ b/tools/testing/selftests/net/netfilter/sctp_collision.c
@@ -9,7 +9,8 @@
 int main(int argc, char *argv[])
 {
 	struct sockaddr_in saddr = {}, daddr = {};
-	int sd, ret, len = sizeof(daddr);
+	socklen_t len = sizeof(daddr);
 	struct timeval tv = {25, 0};
 	char buf[] = "hello";
+	int sd, ret;
 
-- 
2.51.0


