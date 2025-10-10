Return-Path: <linux-kernel+bounces-847779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6547BCBB07
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4979135156C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 05:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3472826B74D;
	Fri, 10 Oct 2025 05:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZlWfOJ4"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442471B4F08
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760072641; cv=none; b=ggmyH17ti+pOdLoz/dnQqHNNYsQ2Yei0Xu4h0DATgMaVvpC9EpXxwDDVUCaDz0LvWdEpUYiUqM2KyaNYFCxSMBPRfUb0uI5+flBVWOofFjkMMf84zdeu+Ri9J9vHAa3OHH7yVUNRBGveDv/wRYFJZ099x42ds3U2vPOXRHskos0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760072641; c=relaxed/simple;
	bh=1Dc701lWNd96LkNgZ9yo8fbcDa5EjS3FNySFxixaJsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Taab0v2XIcF2RBq+RYSdkxrjdE0pumzova3rextJWDlAVQNrFQxpxZIUTT0fTuAYe7x3i1NkoTbqeijBglEYVu09NSUqEepKZbo6K2MYoFkxfIqE+RtBZ+6UYv/5LWWzkEiHmOE6C6Ib5Su9wn73yiHLi7iwQnzUTcpGltiU80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZlWfOJ4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77f343231fcso1262860b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 22:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760072639; x=1760677439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QOIbcB6sHuY59NsTH9o+B3XGfKC27cxgCVvQpYalfzk=;
        b=UZlWfOJ47gLWD4xqhE67hUNZf+pbRQc1Z/rO+wjLVNcIRBc/FvKIMrudizMLhtKCsg
         dkmRDnzZB/lEjFhPtAMBVXbBaCy9dZeeEtE3tTPyWlKj6QBLZz6qkFHC78P2rts6GjFt
         ASCQqXDpJfJ9j+WgJ12xcdjQJpTlsucxWbtHj9vTxFMpLHyR71ibPLEK9huS9D7Vdxx5
         9tFvxDfIrQd2z/hj7DZTbHzVoh6EUCBfGVFgoX2G8D70x9cXr9OqMTxu5tduIf66F1pE
         /GSb/bfS9xhVXdb3akbDWBxhdES8iY+oiJmO/RGdsgME6i+z4PyR9fTWKXTFEibI1Vke
         Xq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760072639; x=1760677439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOIbcB6sHuY59NsTH9o+B3XGfKC27cxgCVvQpYalfzk=;
        b=N09WqL7SfoDmiQcCgIMsKj7N2v3omRLN8IAwsmOE+JDvNh7HiluyjLtt1L2pVTV0JQ
         O/ac3N2wPQ+ZsThNduuBNo8OXoGoecE6dpvAp3joQMEzcshxdPitLcBkTAvXC4a8RmuC
         ZkPcV5f08tbdfmhfjMx7u4z0XEB0GGzyLEFLhwnt1zBRDq4ift1TNfUQDcTyRjY8w7VC
         /J348BqlAGkWgNW67krgWq3uyGeaMXLvWKIHaCMr8QCRUGedVPMy6QyH5VHjA2Mf7os7
         oc6AjMd6BX08zYx+vCpWIia3hd8F0SMAdhoMH3P221TpiXAhQIoryhkNRxj2frs0C2/V
         +qlw==
X-Forwarded-Encrypted: i=1; AJvYcCU+ikKCW8w1W1bU+EpGQNVwb7fhQaXS/K1GuvGFIsK8AGGU2iMS4sLYZhq3kQjGOKW0snZhodUYj+5iGzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4nrK0fnITxJ0XBR7b9j6d0DsOCz3ka+mgjlgQcBOH2I1TZ4Zx
	j+tLj8j2YS37g8FlVeHCaj3t3lKLfSQOFeLQp5B8CRxGzz9G1q0gYz7g
X-Gm-Gg: ASbGncu6SppgYjn9e+iV3HTjiu4E7ViS3RfI+uEKuXLZ2MkJhQ/doONUpGBzpmIBoM/
	wcgOCGybavvZnBGeXwnIASwCwoj8oxg2JpjPLUD2fhnRKqauTxkQyPSNe1J8ssClyLMCMt7EHU9
	r5N2Rwj/vm4Xu6mzDy3z0s+IEZ17U7iHxBTvK9ZGfeLEi13gxHJFtgblb3z4As7Eo9ySnCetv8H
	Ex/RrejBRWTuUGLBHFlcHE1ThyvwwymmdrXF0wU7Iv7RRbtvEk5AMXhly3BW/ucsK9dGmD2UilI
	ZFC6AGMRr52x8JueqLSbVey+pQO88zcuRWsbPdLI0eaVT/1oAk8LYQ76T2o8GCiod5HIuPiyTYU
	d4qMRJM61vNO2ersovA4G5DyPgi5oc59ieFHldCMiN+wkmrm1EFaXUqlpR1RHqkbmpUoL
X-Google-Smtp-Source: AGHT+IGuDVmXLZYX/y/OUM5zsyxoqV8HwvNsVgBWqVPj9W6hKvMwFMtAmda8Lcymjv6YGDInXNZEmA==
X-Received: by 2002:aa7:88c8:0:b0:77f:143d:eff2 with SMTP id d2e1a72fcca58-79387c191fcmr12173718b3a.28.1760072639240;
        Thu, 09 Oct 2025 22:03:59 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b733355sm1505098b3a.26.2025.10.09.22.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 22:03:58 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	pali@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v2] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
Date: Fri, 10 Oct 2025 14:03:29 +0900
Message-Id: <20251010050329.796971-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In exfat_nls_to_ucs2(), if there is no NLS loss and the char-to-ucs2
conversion is successfully completed, the variable "i" will have the same
value as len. 

However, exfat_nls_to_ucs2() checks p_cstring[i] to determine whether nls
is lost immediately after the while loop ends, so if len is FSLABEL_MAX,
"i" will also be FSLABEL_MAX immediately after the while loop ends,
resulting in an out-of-bounds read of 1 byte from the p_cstring stack
memory.

Therefore, to prevent this and properly determine whether nls has been
lost, it should be modified to check if "i" and len are equal, rather than
dereferencing p_cstring.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=98cc76a76de46b3714d4
Fixes: 370e812b3ec1 ("exfat: add nls operations")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/exfat/nls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 8243d94ceaf4..de06abe426d7 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -616,7 +616,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
 		unilen++;
 	}
 
-	if (p_cstring[i] != '\0')
+	if (i != len)
 		lossy |= NLS_NAME_OVERLEN;
 
 	*uniname = '\0';
--

