Return-Path: <linux-kernel+bounces-882185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9E3C29D63
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E023B55CB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 01:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9D1295516;
	Mon,  3 Nov 2025 01:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1c19nDS"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BE128B7EA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 01:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134675; cv=none; b=O8UsEJdL+6zEmlz88YJMh/0osPDjTEKp6HAUIYDt3nMRALFTOk3Q0cnyKu6B98ucfSFFwKeh2LJ+h6j+gZ5Q7Go5LvANhOfUZQNhUjnP4wAnw1Ku9ce4cB+W3K2AUm/oR8kOevhAVZXxq0WygTsh7NoKHU3ulPK4eERaYJH/KJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134675; c=relaxed/simple;
	bh=xYbBu2fMf0do2Y8PFkgmZ44ePl1qKHbhlD2bXGI6s6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwtEumnadjTO8TFSv0GuZYcrAh8EWilzaUFPtbxrC6qN0HZ5472XQkL1MZ93otmbImudEW6Qvzz1UDt0wvczAs2uaAJchQJGuBC9Wa2oevj4Q3Fli8F/ROQnWjWBfjYZ0AIoPsqSjZUhXux3/GomVmE0/d9Uk1z9AYcLwoyKS2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1c19nDS; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-330b4739538so3897755a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 17:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134672; x=1762739472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDAfAMTS/DdBYBQoTuWYXo0/wYkGq/INrH1coTZQ7c0=;
        b=g1c19nDSzk6Yko1GS4W3qggY2Xm2ixRZqOUUMEPGTfAOwa633tMjzB0FuAMUk4Lv15
         FjJWrEvJQM/HItaNzy5h7o6epE88b5SeNA+i+6bF2Qi2mn1+KERXwZ5Y1ihmc1DRKhLT
         qeTfPAaIYSyUA/Gtkeh1IDtowQjJsRfQ2ynARVJbAMy+3QJJqujWwilQgs5uKcFKu3qh
         QDvhRfXrg0OXZ0yV++024RcKEd2V/o+CSGzb0W7F9fELUoArIcAgXCJtkmxj61N2YoYI
         0xoq/WeSQoYjZpe7hWjbo1iNB81daISD4AZptpSu60+7gfhRqL6+X2s3vZRzeVhKNN2f
         WxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134672; x=1762739472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDAfAMTS/DdBYBQoTuWYXo0/wYkGq/INrH1coTZQ7c0=;
        b=ac94Un5BoiFW5rUpcmUyrXdPk4kIXyDQGGMaf8TG+xlnsQj/YUzNIVDGPVw26s4VoZ
         qOGBJAGHWpPT7462ixJSC5+Qqun4YSzz/YRbCqVtJ9Kd58/CFUtVC0nMpUdHjRrhRmL4
         nsht6m7MfrTzZwaeEbRGgSneI1cx1O3cv7fE1fYXphj9Ho2USXK/KLtkq/j63IIrqd+7
         iy5oBnw3U53HTbtkmtJBHPvNBTQwlTOpcsP1nYgLXOWOPIq1RyCiaC8e/B4++PXEhF2u
         lUdbrl4J6Fk9lHp3sKFLd+/1PG5pGUVrFEIlPUY/tDfEMjAOKCBk5J8hLn5Yzhv9i9KG
         TSAQ==
X-Gm-Message-State: AOJu0YyykNqWLTkg+Q1PUuB9VTR578mKT6w1JpO5EbMZVBWqDYoa29la
	KxZ92Zig5yhqJtcKTRq1kXxhe5Q5kZpFOXt3kXyhqu0kiLXbzff90fvG
X-Gm-Gg: ASbGncvs106JTOBdLlzryaBR5/poDxsUFXMlMiViYYJ52mzt09o19aOhS7SP3LxVMKm
	Z3M93peRFfUSoKZ7wZiS6+kKYBzOHX1sC8m117KEP81UsMETmPZNTwuQ5dvzDDJQAbQt21rSakF
	zA+gsiHCLWlRFzCJhKLIOhAww0RYd8FEdgGsNaSEu4NnnPijztGjCORCpUnMXePpvnCY4X/uY+J
	SsdPZpXDnEYwguSZ6VWLYEiv56xfMhVmDr+6vZfzOWfSi52WVe7nY3Gk06IpOh4uhB/X3n2mcjw
	GTW3DvCsL7VkAQjNa8NKPEcoxGzkKK+w2XvPvf8EtBgb2ML+UD3pyvo78VGAis/EU8rzjSoXacz
	PdiGGniEFrNyagBAyPMPndpTdBT49P2CUN7tckdQJrUXLBJBpFrMXZcaiZRiDBw9vUh4sTcRuGl
	kj
X-Google-Smtp-Source: AGHT+IHe3/m/vfP4n8dAnB++a4/roBr54Jczttq+5F/s76Bm2lMbUhEsFeIShoWIP9P2vd3f0r/p2A==
X-Received: by 2002:a17:903:2302:b0:295:557e:746f with SMTP id d9443c01a7336-295557e7a25mr85614305ad.32.1762134671769;
        Sun, 02 Nov 2025 17:51:11 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ef4c263sm4458053a91.3.2025.11.02.17.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 17:51:10 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 6EA02426D9E0; Mon, 03 Nov 2025 08:50:59 +0700 (WIB)
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
Subject: [PATCH net-next v3 9/9] MAINTAINERS: Add entry for XFRM documentation
Date: Mon,  3 Nov 2025 08:50:30 +0700
Message-ID: <20251103015029.17018-11-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103015029.17018-2-bagasdotme@gmail.com>
References: <20251103015029.17018-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=870; i=bagasdotme@gmail.com; h=from:subject; bh=xYbBu2fMf0do2Y8PFkgmZ44ePl1qKHbhlD2bXGI6s6k=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkcnJWJb6OS5AOvvHP2OxbZECTbpOA0/77NUZcNhk9fO Xjs8LraUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIlovWT4w/mKLzP/SJjVI7/9 G4ouTcqwuNwt+/6t9d07m9o2b9KYso+RoS3ZLfvA8uk9l7w8Gx8fnXIhKinowSH2n2pbDlx8dfe jOB8A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

XFRM patches are supposed to be sent to maintainers under "NETWORKING
[IPSEC]" heading, but it doesn't cover XFRM docs yet. Add the entry.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ab7e87462993b..6d2906b2600376 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18051,6 +18051,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git
+F:	Documentation/networking/xfrm/
 F:	include/net/xfrm.h
 F:	include/uapi/linux/xfrm.h
 F:	net/ipv4/ah4.c
-- 
An old man doll... just what I always wanted! - Clara


