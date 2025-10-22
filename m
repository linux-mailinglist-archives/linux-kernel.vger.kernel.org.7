Return-Path: <linux-kernel+bounces-865321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 353E3BFCC84
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DFE64FB47C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334AE347BD4;
	Wed, 22 Oct 2025 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH6rD+LG"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06464322A2E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145656; cv=none; b=bpclGAd9ssDjUtDnEdHKfDij6W5YG6Xo3By3rxixcrsp4ujg2+p/GMqJC9vyGiwWnNpi5dgALwIb8Mymk8agUnwCYmc1YWxMQd19nIBOXUcH4GS9ToqePT2a3+cek1fSTttN5c99iWsb99N5zZYecXVFTkjN2znGMDgC1MqdAQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145656; c=relaxed/simple;
	bh=laoIWGu4p0dTammd2Nay5qWKbVIQdGqiuFOD52Zityg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PbflYsmSp3FtnRC38DhZQGoXruMgAtj1xDUAMpJDC/pN4FQBPl8G4dNW0feTXLzA6/YRtFkopdwU4HbPi6u8sGqCyym7soqV88GzpEhlEijhabquCqJM0Z1ziIzsnevJi+Ee+5w+1UUj5RSQOtib/vwjXT9q9mrFtJ/NePyHSa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZH6rD+LG; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4e896e91368so15556811cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761145654; x=1761750454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LwzTm8USs1oolFR4WnnlWLIHx/1z1zWMBPnOEps6YoA=;
        b=ZH6rD+LGQdTAZgGs0I50PCHpiQ4FR+8W/ThEunCTK52ksJFo/4y6TLwy2WZdq7feq4
         YlGsTLEZzQ5K9U3cY6nShgaDK3F1be7wfKmhKIPOXFu45OjlhodwwZ34m1EEAmurzQDU
         tlm+9EPLvzvBHef1oxhDeRfFaEU4pb6JjFBqZVDwYzTLs4CFTlELCuF++wrVAUVZym55
         ywqv4cnncylC2vOSLEI9GRvTDqES1wtnW5GfQY1TXcoIDT5+Ul65ttS9X7rZ5xGc5kq+
         fHB/w+XrhbSPutrTAGWItrp1447gQPz1tM9vGxu+U57TeQ0Ouuez+PU96AWeaET2ZdqI
         yO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145654; x=1761750454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwzTm8USs1oolFR4WnnlWLIHx/1z1zWMBPnOEps6YoA=;
        b=kEt+iB/XACfdB2TW8hv23LItQCxNVb11kil0+fmFOLyK9yHKXKCz8pcpiL8gWt0LOa
         ReizW4TmFNG1Z1uHHEoN1+IPKpCs90Vv9g+z20mjnCIXRZP2+lUxxYB8n13khkOnsCez
         azhyxCGddlkgYBfzITWdpbpcDiVAODC90OWiw/drAZNrjT2mTOi/gsdPs5Gmg5JGRA+0
         kxuhRt7vXpP7dizM+KRsNzX/LYklQoq0wSPzgrr1hpr8l7N2SQ9g/gCSpyyJ5AXhE5Su
         7H1efuG8qJfBDPW6jUE3jHfPZiLeHzo88UkAkj405p8CoSBVT4rE7TKCy1NWHCZ772L2
         CZTg==
X-Forwarded-Encrypted: i=1; AJvYcCV0skTCrYCO8AhLSnCiUDYCDnH+FwpyADU2Ir+2tg81CSlZEwnCS3aKl+YQjqhQ8m9BO9wGbUA0S7CBd94=@vger.kernel.org
X-Gm-Message-State: AOJu0YykGCBBRLYWLG+5vJgmvlASjW8PiopfOx0zzfzWN4qYyNDrX1ln
	bLHGSdDIEncHLI0Yo84sWlQcZ0UIxSkVLzyxKWyzavRd8tos337VFm8E
X-Gm-Gg: ASbGncuuwFsQbt0aNOTRJbIcoZ4NXPt9vk6F7bo9i2p3Qoy6D/3bVIhkhfj8aX2rqkN
	FBOn7llv6lkM7jlrZwMacr+Lsad7613ioLTF7FKhHGWkAf2ZA4WH5vehijyjQ9f6AMehrrBnS1s
	sTXRg9S+8gZlyEvfUs6BHWdNSizr0B3gnvXqN3ByndKdORcQiAh/NjrqlhZPjLYShtkBOL9dhXx
	I5dE0b5FXxgEALPJSRY8XpvyxCU/jUM38slmGSswauOGf0UNIvsATUf0IvYgaqDchleOM6SeObe
	lzYbcZyGKKM+PcEZEXCz6mZSSk8oIMWb08b6aF+ICFMQFnDoV6rHZCsxC39vEaXJ0eeqCghW7TK
	Vt3y3wqVSJwHMvL/Tei5v8jUB8pX3Yi2eLzjHFI8+IlRkXDWtv6gjKSE7/bwqU5hAI1rzvSK8Jy
	mZ8hK+Vc6YmaMRnvXfwWdCdBECHecUX68xM9FV6iFYmW90x+E8Fe69rt7yjgUBbTaHxdefkjYq6
	C+wgx1e2saBtjDZzGQkSReFe+X/qaLHd5ycJvAroSI3sXe4jQcKbwjn3/q9rWz5zcXsZTyH
X-Google-Smtp-Source: AGHT+IHsEoy9TxGzvUXGFHK7BCWyNK142Lft2EHU0bFZvJFw5sqf9x3YTrPE8ZGiTyyaXtUe0r/i+Q==
X-Received: by 2002:a05:6214:21e7:b0:7fa:3202:5261 with SMTP id 6a1803df08f44-87c20543291mr269537286d6.12.1761145653653;
        Wed, 22 Oct 2025 08:07:33 -0700 (PDT)
Received: from NEU1-L01066-Ubuntu-22.04-valeo-wsl2.vnet.valeo.com (ip1f10fd85.dynamic.kabel-deutschland.de. [31.16.253.133])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf521c2c7sm89448266d6.19.2025.10.22.08.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:07:33 -0700 (PDT)
From: Mallikarjun Thammanavar <mallikarjunst09@gmail.com>
To: axboe@kernel.dk
Cc: io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Mallikarjun Thammanavar <mallikarjunst09@gmail.com>,
	"kernelci . org bot" <bot@kernelci.org>
Subject: [PATCH] io_uring: initialize vairable "sqe" to silence build warning
Date: Wed, 22 Oct 2025 17:07:16 +0200
Message-Id: <20251022150716.2157854-1-mallikarjunst09@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang-17 compiler throws build error when [-Werror,-Wuninitialized] are enabled
error: variable 'sqe' is uninitialized when used here [-Werror,-Wuninitialized]

Initialize struct io_uring_sqe *sqe = NULL; to have clean build
Reported-by: kernelci.org bot <bot@kernelci.org>
Link: https://lore.kernel.org/regressions/176110914348.5309.724397608932251368@15dd6324cc71/

Signed-off-by: Mallikarjun Thammanavar <mallikarjunst09@gmail.com>
---
 io_uring/fdinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
index d5aa64203de5..e5792b794f8b 100644
--- a/io_uring/fdinfo.c
+++ b/io_uring/fdinfo.c
@@ -89,7 +89,7 @@ static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
 	seq_printf(m, "CachedCqTail:\t%u\n", data_race(ctx->cached_cq_tail));
 	seq_printf(m, "SQEs:\t%u\n", sq_tail - sq_head);
 	while (sq_head < sq_tail) {
-		struct io_uring_sqe *sqe;
+		struct io_uring_sqe *sqe = NULL;
 		unsigned int sq_idx;
 		bool sqe128 = false;
 		u8 opcode;
-- 
2.34.1


