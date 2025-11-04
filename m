Return-Path: <linux-kernel+bounces-884901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D12E6C31724
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD51D4F89A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7185732C942;
	Tue,  4 Nov 2025 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imm7HD1R"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBC532C93A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265547; cv=none; b=QycID2gB5Ql14GOHKSkmlvgu3rsRiJEAE4jYcA8XX6/H0Y0bZk4gptSj9pAfdbf20y3kd3DEprAvPrrtFVQAw/7fy5qquXN8+Isg0rfjkEZkTBqxj389tFY8uYfHzGkEnsdHNMBod1c18Zw3aqTDAv1XSiIDTOJgfMC0MTcUmY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265547; c=relaxed/simple;
	bh=0nrrlREagafRXQeDgB+zbKiCfD15/eLfwA/KcOk41RA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jv9ecTehjMqLYlx8SmFsjFgCTsKZB893JZVvS4+b9ZBod0lK6ecer3+jC4d9/JypxylAr+rGj5wrwP1bEOSuikpsJ5ngxkqk5QDHH6ioGjScpgFq6t3+1MJV3cI5/QwrK4PhQWMMY/UNAO3H2GI8W8dDMotw8mCyLRJ0Z418Io4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imm7HD1R; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-26808b24a00so8416175ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762265546; x=1762870346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0HPvUdMK3sKhI8XnoOYJRY8A3cM+jePDjpaUPHvJoM=;
        b=imm7HD1RNd6jMNZCzpRX7BzlrZbNqUjvsp1l3W8QzrPX4q3dh8vszmrDZW389KPT5g
         Ng7BCF7jeA8gul+hQRDjs5UBYwwXf1LcBAdhsNRDKLe69zeVswZ+xvufRnhCLavXbVWg
         P6EC6qepEglAMefMYKwaiJEcqcUC4HFxAXqBTYC/l3HIGICMWmY/siWuq0Cs/dZ90x6e
         FlywCoOaB4Md6nEMpEENe/dNGrGQ/Z0vpYfpktRsyEmbdcNgEZE2YePcEW4o3rdKYD7N
         lZMlbVruGTUXfdXdw8oks3+TYHsO+8ukWDTB1lO+HZhvqTf4UObTndUdfJNT/nM8fogM
         Apaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762265546; x=1762870346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0HPvUdMK3sKhI8XnoOYJRY8A3cM+jePDjpaUPHvJoM=;
        b=L00jym4bwJffn/uK2rKpfFTPsVTXXV/NM2+a8QO2UmKripgiH0kp0dpV3dbqTJXHQ7
         tjw+J3yqzq4gCfRxfzCBQKVKDAP1y4ZD24k6IOl/adPZKgIzLq5d2G+U7ltCb6FUyNCz
         pLpLIVfXyzswqusT1Wd37cXZtLB/XHIigN9PchkYtFdqWIDsCs7DYD5V0i/dtAXW5DTu
         Btz0OY2PxSOdy4jz0Uf9nTMNJE9JjAI7qo2xnqcZJRoor+4CjNX8aUdJENb7UvEODrwi
         O+n3Bt0hLLSRlA3OEOIe9v18aSgPAOyCSStCK299xdwBVq3pNRRYy3C5OWBOhQkjciHG
         GPzw==
X-Forwarded-Encrypted: i=1; AJvYcCWeAp6/qQEyqCoT6MnMrp98AttRHC47HJQU3JRYwdXnZ+Uwty3+wEoK527ql5WdWYeu9ICX/zY2fm14+2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM4uAAp66/4tOGiGEUCd+TludZtAwBtSnmwKsua0Kph+jA60cB
	VSj7LAcLEMXpvnpvUKYGzUNl2xgUfXeMBFf27LdACIUyZO1Rmx4Vynu9
X-Gm-Gg: ASbGnctaiNslrFaZpB5IM0Oh1EPdnySJ2eZy4LgHUzfv2HmPNwx0cxuuRW4ps6zywg2
	E86iowWnuTOh3SBv4LgJ543Kdf927M284JcaI6DHSicAHk3Kg1uIRumONP2pqQYer7IK+ZPZ9HK
	MXDhqUc55LR1aFOp14bYihUsi++W7+wOOzaSZTi55XiJ8mQLhEKDAAq+pDgNN4Lj87UjCoSSdSR
	91pRuCErQ9MJXRUBb0nBWcGrs+RW8VPVMEK5wwLR3ZeoJIlbmEBny/2OfxozOEN6t3mRPL3vy9S
	dR9FvQgX9uWxo3OV2kEyGKkfyxH41GGDqZOlQ09nGLf0/NqzqWUqToAgCXZ88m82tSrE4D9zYjz
	8moE+4WGVnKG0HoAASnAPZ2G161oxRMW28xsWIndiwIQS9PiTRlCzg1hO+ov28OTbBz+JcLguU3
	n3K2I175WYH1JEBye7+GZFZkyD1h29SPRn3dsSLTh7YsaCqW4Wgl5ITLhAjNV03A==
X-Google-Smtp-Source: AGHT+IHAugMJ2nxjbD5sdy8UKfYjv2iz1PHt/Er2Dg2Libs5zWlSaypUfNKo7evt+LepO6KkcCxWDA==
X-Received: by 2002:a17:902:c651:b0:266:914a:2e7a with SMTP id d9443c01a7336-2951a491ecamr80222935ad.6.1762265545624;
        Tue, 04 Nov 2025 06:12:25 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a60ef0sm28866755ad.83.2025.11.04.06.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:12:25 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Qianchang Zhao <pioooooooooip@gmail.com>,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: fix leak of transform buffer on encrypt_resp() failure
Date: Tue,  4 Nov 2025 23:12:14 +0900
Message-Id: <20251104141214.345175-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025110432-maimed-polio-c7b4@gregkh>
References: <2025110432-maimed-polio-c7b4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When encrypt_resp() fails at the send path, we only set
STATUS_DATA_ERROR but leave the transform buffer allocated (work->tr_buf
in this tree). Repeating this path leaks kernel memory and can lead to
OOM (DoS) when encryption is required.

Reproduced on: Linux v6.18-rc2 (self-built test kernel)

Fix by freeing the transform buffer and forcing plaintext error reply.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 fs/smb/server/server.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 40420544c..15dd13e76 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -244,8 +244,14 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 	if (work->sess && work->sess->enc && work->encrypted &&
 	    conn->ops->encrypt_resp) {
 		rc = conn->ops->encrypt_resp(work);
-		if (rc < 0)
+		if (rc < 0) {
 			conn->ops->set_rsp_status(work, STATUS_DATA_ERROR);
+			work->encrypted = false;
+			if (work->tr_buf) {
+				kvfree(work->tr_buf);
+				work->tr_buf = NULL;
+			}
+		}
 	}
 	if (work->sess)
 		ksmbd_user_session_put(work->sess);
-- 
2.34.1


