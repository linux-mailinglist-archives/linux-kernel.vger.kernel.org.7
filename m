Return-Path: <linux-kernel+bounces-879873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B09E3C244A9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47DE189A337
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B8E333740;
	Fri, 31 Oct 2025 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvXTNdmI"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005F34D3B5
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904443; cv=none; b=XkYX+4oWEDKdOv1jBzIjXJ+Rcnp9y5jdXlxeZxQPkM6okD/59UUxvb+kwKU8WcqI38ahSHhiaB0cR8mG7u7yaHPpQugk6wPPyTIBcACwLDzywB2GFFyUxawYHqrDm19rGI6WJc1jd61+wAt8Je4HrXTh8GfFYGFtWrr8RNGkNd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904443; c=relaxed/simple;
	bh=Klmh3jjuYCOmOQGrka0ucLeEvTrFCcJ8wdqYdFBdeFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=om1kcH/cIv8kn7Lx5/HIAYWb5gRtui++/P94yzkSt5q0E+skm0HNMDavumNA8NEOk2Iu/bZ3Z/kyL7UStu+rZIP5Y771KFcGNrNUjbxx8gcNTp6aD2yZwzhKoVjcG29LZDy5B7xhuMymwsmZe0vzXyZm38PEhh5y65INrlRQSNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvXTNdmI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-294fb21b068so21795695ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761904441; x=1762509241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cLNPmDkWzf8eEQQPMNYd08lwz6rZ0+F8xG5ehROMMhs=;
        b=JvXTNdmIPJz+aVSxwVU2BHYTppBGcdpr2jw9u/XeTLXNLe4jp5/2u62DISxIrP4Bmk
         85utbcL4pv8nn9ekW+BrcdUT15hCQ48ssKXnTwKcTIagUNmaZAuB1e6MCILUl6WJ3ilC
         ovlleLNBDzrx28pzU+78QFePsPVBIbVAUzNq159lnftK9vF6+4eqn06qVAGM4SZeIKE7
         FCs3OpZt4K8Uw4pe42BIeIgMWTEM4g+qNJ9Hdq+l3viiA99hkiZKqoJY2cuOYgsGpN50
         Y3+tpTMw8cRBxdNR3RCuE/2JMk6s5kQhyzYXYaaPkv7EwtZT6iGTmB9SVX4pZCF434uX
         jqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904441; x=1762509241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLNPmDkWzf8eEQQPMNYd08lwz6rZ0+F8xG5ehROMMhs=;
        b=LXJYC0MEyrtzgzXjGuQec5uMMsrkHl5NqRIBvBywUG2QeQYDQpfXaNeJqbKMU9uKEl
         JU+mGvHbBkaqM1mUbpHk1b7kVHNEiGDEpwqBTZZyQpPw/498RNEE1ePiMssDLdAZqjLb
         rWg29n9TAiaOsRkuXoHl6k9mIOq2rUdFZxZ+bNLoQ5YKMa3uieazXHb/qUuQ+SbQ/W0o
         rRqZAy7m1TdR+A5qR6SRUOY1IKSLuO0znWpXWB1QXxEj6SRU54f0+O/mPvbnYq+E51KM
         +xeUs+BNvVF1dZmmBKsU1ydtAb4o52opXjg+D4fsNG1iQH1eC/6ppcyYS5X4Gt/btRCj
         yYtw==
X-Forwarded-Encrypted: i=1; AJvYcCWCybB+DrQ5Bimr5vNmyy+InI8cLlzFJD9aKjG9i0xZ0t2P5R9hr30CpAPyt/owf/qoRFPiLiut65ki9Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzExsxdZlCHkN7gtxoJkPLb09WK2R9N/qIGkmeCx5ygx6BNDz2V
	fu5PEj39nf9LBxx2YGW/itn7n+/2rbkyPSGX0c73JlRbAV0pc9ZjgtMD
X-Gm-Gg: ASbGncv2KtrjE5oKKNZgq/kg55GF3dFiZUZbQZ4wdsHwmmumBhTucDpzNxoD0GKLQFT
	1GsucvivsaTAGBMvRdHwaG49OrAETpmaIBvJzXxqzVv+Jo3uXL5j1WbLiv0ZHeR+eFwsLb0TrQ3
	J0QSClKyjF4D9GILIgCD9w9ac3aOsWaVNBAeTHHBtykd4kJf4EYVAOGf9Z6sxQt+b6ol3xLgnKr
	8x8pnvuWeGg670bzRI0ReRNEs7h8DtqFpMcRtEH5iEZVNzTltPUCeQV7KsgGUMVrR2fUaCdh/LF
	7DHXYZ2t2cc9/qHNFml1uohnKo9UwK5YXVEySKUhBYNHEi+CA7MlqfxaGhUBThtUuOqwajQNMeU
	eLV9lqJ4aknKS/hHU8hzydQAX+oKVhgsBSNB3OgEL/8gWkbJ4BfsUID1aIhEX19jgjm0xh27z90
	v6WBiBmHmwNabc
X-Google-Smtp-Source: AGHT+IEaWtnPSkn8bEYuOq2PjxBQpign0Dr3z7sevrRCbVO/NKyO3H7xejdOk0+IGGRdzvycMwogmQ==
X-Received: by 2002:a17:902:f683:b0:295:34ba:7b0b with SMTP id d9443c01a7336-29534ba7bd4mr8072985ad.35.1761904441183;
        Fri, 31 Oct 2025 02:54:01 -0700 (PDT)
Received: from fedora ([2401:4900:1f32:68ad:2e67:289c:5dac:46fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699b791sm17746035ad.75.2025.10.31.02.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:54:00 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i.shihao.999@gmail.com
Subject: [PATCH] scsi: target: replace strncpy() with strscpy()
Date: Fri, 31 Oct 2025 15:23:48 +0530
Message-ID: <20251031095348.24775-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strncpy function calls to more reliable function
like strscpy for safer null termination.

Earlier code had some strncpy functions still in use which could be
replaced with strscpy() since it always NULL terminates the destina
-tion buffer also it does not waste cycles padding with zeros unlike
strncpy(). In regard to this convert strncpy to strscpy to prevent
accidental buffer overreads and ensure null termination of destination
buffer.

No functional changes intended.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/target/target_core_transport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 0a76bdfe5528..9c255ed21789 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -1112,7 +1112,7 @@ void transport_dump_vpd_proto_id(
 	}

 	if (p_buf)
-		strncpy(p_buf, buf, p_buf_len);
+		strscpy(p_buf, buf, p_buf_len);
 	else
 		pr_debug("%s", buf);
 }
@@ -1162,7 +1162,7 @@ int transport_dump_vpd_assoc(
 	}

 	if (p_buf)
-		strncpy(p_buf, buf, p_buf_len);
+		strscpy(p_buf, buf, p_buf_len);
 	else
 		pr_debug("%s", buf);

@@ -1222,7 +1222,7 @@ int transport_dump_vpd_ident_type(
 	if (p_buf) {
 		if (p_buf_len < strlen(buf)+1)
 			return -EINVAL;
-		strncpy(p_buf, buf, p_buf_len);
+		strscpy(p_buf, buf, p_buf_len);
 	} else {
 		pr_debug("%s", buf);
 	}
@@ -1276,7 +1276,7 @@ int transport_dump_vpd_ident(
 	}

 	if (p_buf)
-		strncpy(p_buf, buf, p_buf_len);
+		strscpy(p_buf, buf, p_buf_len);
 	else
 		pr_debug("%s", buf);

--
2.51.0


