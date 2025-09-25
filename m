Return-Path: <linux-kernel+bounces-831937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2874B9DF00
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2238F17BC33
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA3D2750F3;
	Thu, 25 Sep 2025 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjPBJr07"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A5A270ED9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758787022; cv=none; b=WTZX9WNPT0LNUMamdESFPbuaWmnhrZAZru1J3WpoxSSTeTM06oVV1W2SjhXUxvHsUgnLUKPDscsEuc+1Yp0ArUugtOGfrtuLxGgcRstk7vJTJrqI3uc8ui4xg6jDwAWjF83NZqBNaYu9YXiEuq2pWrUtLiaIw4zyB9f6EqOpyvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758787022; c=relaxed/simple;
	bh=G3X0HulBzhqLQGcKTKzDjrZkNM1oOZyyGOHbwlQdB3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/RduxWKAN2ZP7tE7ACD4oLmTbq/CJMoF940MeSE4X0vOdQlDB+DEj3CHpgkdEFFpzEZmeBlCOeCGuVJ5i0JU6K0jFo3fIHRPGvkAZ0xFvG4fP00m3zwzIdhetBW+rEFUw4oqApTq8lafLKEtUiP9ruxoduMIvddExBX8p20cHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjPBJr07; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3515a0bca13so20274901fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758787019; x=1759391819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/LvC+F24rOHUo0H6x23FHMGYpNv9JEWx6/Wh3pzddxk=;
        b=WjPBJr07U738o2LPgmOsSeMxBhhUyCH7VOUPfIG+MnO/4czlpFW8oD3qqOv6S6vEkg
         i15mP1HiaieUtfp67i++xk3hHD47Z7axmvkGRJEAokPg4bf/+iy8OQ2I10zJmrlICe87
         aZJE31AM7jjo6vT/49HlZ/nMt+4U4CFmbML63fLVMhUNARrgKvjmu8B3SgSO4CoLNUJW
         FmaXrahc5j0HAHqsexNbN/VohBRgdMvPewNUwylfQWxdtaOJYA+83nDVNxgKqI5mTgtA
         GghUx7D0ze/xL4Ge6XVlx9bVjkF7ChnA20TdcPxaqFgndBxHX83X2/7mkGvRyWJGyaJ8
         bhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758787019; x=1759391819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LvC+F24rOHUo0H6x23FHMGYpNv9JEWx6/Wh3pzddxk=;
        b=SND04M9irppETCb/Xl6mIxG8r2iqBh/1yMVFnupl0DO43meRvHaBVdXTw9k30LF0nS
         EiTC6NtvCdlHq7qqUE4dkPP659YNJDpeB2hrQq+arQi24VzWCfZ1PWkov+/TwgWwN0a6
         0iHVogqgyNFBPh4gNHfEP7chspl5eEMWf6Cnq2iOEr+VRc2HKrPUKdSvtUJcLj7CXCFX
         A3z96/2ENxQzGCE8oVuGOBSAP/NwPV17SkuXAqgljock3qvRHWQduIv3H/6Jhkrj1UjF
         B3DajX1f68tvVJtPBwiyc0xfd+G7unOVNDIMCWaNTtXuT2tT0Ve7z51xjPBaEg9C4r8G
         sVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVX1XyPr6duwXopA0ZYh+M2s7hj3ephgiHqRtp7SwRjl+kGoVI3JN+0b9xy08IaeXHjPTi4ER8cMXOLfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUa8tCtYOAFXf1OV9dNRy+/rEo4GLuqUN+LwN4u/TeVWjoClpF
	ewlczjTlb/Hsz4mfonYFQ6VFlrBYDboQQH1XjZJz1CjxQjEmWRzzjGwZ
X-Gm-Gg: ASbGncvTAUdouwdDP69ZkX241JC1ffzs+r4vZgpi827VVe9GJmjBBulfvGc63uLoYxO
	/7PVZQjImbgm36W5+5v749pPzOVs5iraf6AW6BysuQLUnBJt9xQEU2nasWi8TEkQLUg0Zf9KLcG
	XVcFbVJ1YudzFdYctWID4eRSbmy1ZPwzzKuBWg4euqRIAp+mtUyTfHOBFOUvvjbgd+XRfR5ripn
	FfGxKYG07kOgSha/lBHLmR62rRnqJ1R31ndOYPzyAlWF3/EjZofOYZieAs2AVMQ5y4IoDi8yYJl
	fkA69PDkQKMhmohLx178Ju2/aRr7M0uf1KaQOdWoeqDXjdhsDFzqr16vNqRPNUsCtnciMlU1ZlR
	AcMjoo0dtah2qlRgnUZ+nxHrXH9nN7hbWN2i1AvxUCoWI6w4/P80OwFxx8u20R0Sm3t/ayc9Dp6
	ea2ChtId8pP7FKF7xP
X-Google-Smtp-Source: AGHT+IEy5RHEB8Y3WCb1UHovAH+ye8tCG6UXPpK5piKqgeIHHYdFqZmWGJZvP6OP/JMTKg1WVGuJeg==
X-Received: by 2002:a2e:bc19:0:b0:36b:2fab:fa6f with SMTP id 38308e7fff4ca-36fb03a3834mr5397971fa.3.1758787018322;
        Thu, 25 Sep 2025 00:56:58 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb4772ca2sm3867031fa.12.2025.09.25.00.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 00:56:58 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH] nfsd: fix arithmetic expression overflow in decode_saddr()
Date: Thu, 25 Sep 2025 10:56:52 +0300
Message-ID: <20250925075653.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

The value of an arithmetic expression 'tmp1 * NSEC_PER_USEC' 
is a subject to overflow because its operands are not cast 
to a larger data type before performing arithmetic

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 fs/nfsd/nfsxdr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 5777f40c7353..df62ed5099de 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -172,6 +172,8 @@ svcxdr_decode_sattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	tmp1 = be32_to_cpup(p++);
 	tmp2 = be32_to_cpup(p++);
 	if (tmp1 != (u32)-1 && tmp2 != (u32)-1) {
+		if (tmp2 > 1000000)
+			tmp2 = 1000000;
 		iap->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
 		iap->ia_atime.tv_sec = tmp1;
 		iap->ia_atime.tv_nsec = tmp2 * NSEC_PER_USEC;
@@ -180,6 +182,8 @@ svcxdr_decode_sattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	tmp1 = be32_to_cpup(p++);
 	tmp2 = be32_to_cpup(p++);
 	if (tmp1 != (u32)-1 && tmp2 != (u32)-1) {
+		if (tmp2 > 1000000)
+			tmp2 = 999999;
 		iap->ia_valid |= ATTR_MTIME | ATTR_MTIME_SET;
 		iap->ia_mtime.tv_sec = tmp1;
 		iap->ia_mtime.tv_nsec = tmp2 * NSEC_PER_USEC;
-- 
2.43.0


