Return-Path: <linux-kernel+bounces-882179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCC1C29D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8543B13C7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 01:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EAB2836A4;
	Mon,  3 Nov 2025 01:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNDKYXGF"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7343E27F4C7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134667; cv=none; b=odJqDRAcKwyjhrp+uv7u7uhwvMCZ/HZVCuhb59weJrhPGHYfggd55KYKp6ouC2hqjJbmd8eA8+7U/jtdNOlsb2YOdKUzPQfHehQPkiVP+1P/se2J7lxJH3AD57HBtuox49ksIwiR10HLtAquVgvvrFlSP6om+IqGTBc1TOxfcoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134667; c=relaxed/simple;
	bh=WsMaVYjhEX5xzYsbLkIYbNUU/KAzYM8jBkJPwJqvx+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T090oujOzX1oWxEJ987nfFhbOZePgRLdj8jXWJ1RxrTsV/aRWlqSOrido6oXHWpllQ7/DJ15I/ToAPqx0xIMHUdEtlPzSMpWYZmLWHaPJ4iGAl49H2jWtuIT5AxCLfRfA1dktlIYrjnGXiKAg9ECKLDf5GoF8A5sxx+mIagMRcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNDKYXGF; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34029a194bcso4106708a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 17:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134666; x=1762739466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ys+iXshBYZnizwFhgQPeQbnnGsPPwsLlRfA8FiXKhyI=;
        b=TNDKYXGF1rZb/lUsBfw8QGVsaVNX5gI1ToRvqKZ4HRwWUkhIBGG5zO4+dUcsepfwVs
         Q0yeNvEH1K19ABcK47d/4nLeYKmV+BfWLZHlXnCIyio7zcggEcUkYFOrdBxPQ0ezdnIS
         P/7eGP0p0WgqsOq2pkZzUNwmzcpNeFTCjLwu9a4GIMN6+eAw8k/U4Ctx7zmmKNTkxqQu
         kgVxUCeYtfewt3FYD0xwb4oh7bgaUSxqEZUSQYKmF0RgINMFgvQYd6KRaAGmDY6JO4sn
         S2w4fZUmY1VVFRqdFrqiPFPaBQjZr3a7eoDtN3q5FEeX1u9PeXlMF1xwZoWQrlrKvLmg
         KyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134666; x=1762739466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ys+iXshBYZnizwFhgQPeQbnnGsPPwsLlRfA8FiXKhyI=;
        b=iF57vIav9tEmRF8MeZOtOMxVck0yyNIQunY0lVh+Mn/fM34X7sjCLSsLsoKsQ6YTMx
         Q4OAdixcIfzk0WmyrNlFW0CpieTtEI+9efoKCL8M2uMAesiKP/6Tw+zfjlOqVW3nrlbQ
         R2A/Jtm8Fbj/gDRISOJpCYP2JOp0zmn8lWQyJ7umkY85iw/8y3Z7WsCruLOhcTjtA7vV
         2QakVe0TeN8tDITf+UxSCht6UVgPu6ou2iMvsjk3Q3zgYDsGWOJbi3sG+ZxLlYy+AS+6
         IFtxt7rBtz0pEomstgALHw5PXYWImnP/NV9SdgQZ0nlDzqrcvM98kwzO9cKvwrN16sob
         3zPQ==
X-Gm-Message-State: AOJu0Yz494M5+O7OxCBSLYsMAZPFYxPxDmlXS9s9Zq1/8x3VbNRF59L+
	J3oqsciP8O7m5dWSbtFLQ97veVTRU79b7thaB5T7Mq132WYXGJJCGpFJ
X-Gm-Gg: ASbGncsjyDDnIpVdD8VYfQcX8cdI1AfNA1knuHNoW9RrPQGa3wBIQOILwLktZ3udJ6m
	RmKdiiw/QYZNOvKExe0qzJ1SIUwsENbE4JdyQBREMjpkFmY2XPrMAQJFmJDryVYTrdzpTml6OXH
	xAgVzf8GRilKa9isHiwy7zLD1349TiG7ONvs5Uz+Zghh4SMipNSAwrAOW6IttQn4Taql2jrOXKY
	MJGKJc8MN4/R0XWWt9kKUi5qZ5LGioEfHSpv1NpV7wFaHn8Oj41oZfnb2eqylINZU+A1qdQBuU0
	A0fUN2ydktBnBKF6sAJjHZKkfOTNwbMxXdTiKp5ULwNymb9StkGHxfAuE7wFlWBNbtPGa4dYHQH
	vMwUcx1cVup3ZffHRdO9jbr+0G1/CS8iGkr8t+LeqXnYYw5UnNGhBlCDTiDkLcNhpxV5czZ5UJs
	mTYntB5wo5luPK4xcvDxf7wQ==
X-Google-Smtp-Source: AGHT+IGWgVa6WHTDfT17DDH7arAJVN5amdUFhvm3NGYTyUI83zaE0YwI9XGN5/sUPrGGtBHIlkh23Q==
X-Received: by 2002:a17:90a:c2cc:b0:33b:d74b:179 with SMTP id 98e67ed59e1d1-3408308ccebmr12489063a91.27.1762134665741;
        Sun, 02 Nov 2025 17:51:05 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93bd9616c9sm8943505a12.23.2025.11.02.17.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 17:51:05 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id D29634222E2E; Mon, 03 Nov 2025 08:50:58 +0700 (WIB)
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
Subject: [PATCH net-next v3 1/9] Documentation: xfrm_device: Wrap iproute2 snippets in literal code block
Date: Mon,  3 Nov 2025 08:50:22 +0700
Message-ID: <20251103015029.17018-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103015029.17018-2-bagasdotme@gmail.com>
References: <20251103015029.17018-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=bagasdotme@gmail.com; h=from:subject; bh=WsMaVYjhEX5xzYsbLkIYbNUU/KAzYM8jBkJPwJqvx+Y=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkcnBVNS7fVNz35EfL+ofJHi+aUxa2XouZ4bHVdcOLnC 6byj9fOdJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAif68wMnwK7GHTzox5mG8y 09ubc7Vt0IvMSR7+BT5hkm4r+5yXrWFkmHy/9rjHrIydYveX7nsZ+9MqaVNDpd6Sq/uS1r5LUNJ nZQAA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

iproute2 snippets (ip x) are shown in long-running definition lists
instead. Format them as literal code blocks that do the semantic job
better.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_device.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index 122204da0fff69..7a13075b5bf06a 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -34,7 +34,7 @@ Right now, there are two types of hardware offload that kernel supports.
 Userland access to the offload is typically through a system such as
 libreswan or KAME/raccoon, but the iproute2 'ip xfrm' command set can
 be handy when experimenting.  An example command might look something
-like this for crypto offload:
+like this for crypto offload::
 
   ip x s add proto esp dst 14.0.0.70 src 14.0.0.52 spi 0x07 mode transport \
      reqid 0x07 replay-window 32 \
@@ -42,7 +42,7 @@ like this for crypto offload:
      sel src 14.0.0.52/24 dst 14.0.0.70/24 proto tcp \
      offload dev eth4 dir in
 
-and for packet offload
+and for packet offload::
 
   ip x s add proto esp dst 14.0.0.70 src 14.0.0.52 spi 0x07 mode transport \
      reqid 0x07 replay-window 32 \
-- 
An old man doll... just what I always wanted! - Clara


