Return-Path: <linux-kernel+bounces-787219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDD0B37325
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3CD046367F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F55374281;
	Tue, 26 Aug 2025 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzhc+x5f"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABE42F3603
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236840; cv=none; b=CwdbCu96o3tQPlHFPj0OvsoYfIKyWIxp2drOI7HDXM4Kq6WFmDGCmBY6OpXwq86QpiJOeVUDElTVMkDGzEd/DbBqBsJKLw1+a7C9rm3OyroxppZ0YICXRttNR3413HUOPgs0a/iFZ91UHdkiUU/F0/AxPAuhPLPYh7R1Wrdmuro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236840; c=relaxed/simple;
	bh=5v73ecJqH0S1coNLyxMXXxj9qAe7vvsx0XftmkhBJiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j97J2FLbbb/x/QZ8HTc/iEbi5d9+j3al3PmLzryet+6P5VVznVBbz0Ysfl2/U2DlcgCcV8GGOkhLDSGOVxVkhf9bssf17bTpKALOKorXBKIcHLHcJ7KazxQeBUbY3p0Ig65RUL9ANuFCHKuuQZidAUpA2m2jvUp+81yPOEb7VPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vzhc+x5f; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7704799d798so2656169b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756236837; x=1756841637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+rwqTqsm/ZsZGDIt2sbK5HdEEIm0ZDAp49YtE2Ezew=;
        b=Vzhc+x5fZl9z8JL6x4zhizJuvSYoGktOPjniNmAT0R8fg6iQps4YiKJG7Iwt8Q6I4x
         EWnyEXjfVjbDXtVwUJ4icoM0NtA1H2LpLxWYk6RtlQ++r+7IX7pKZdEr3bRvg+PJL04+
         ElNYRTfWJtyTY7tK7Y0x3MyqvAQYA+yFMZrQv+mRjaGzJNal0hU/BqbQXzSkK18F5OqR
         Vvz9WIUqrARgrxOHd9fsyUee4BPrJxVKE3N6tVtBCjy9pQZdJQyCz5j/UZhT+ASwzFop
         kKCRhuxnaAsTLkD64AsHDmlXbeoNu3yCtNCHEpckj1mCTBvH7DNGisrp+rQDrQRsu4Ci
         rLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756236837; x=1756841637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+rwqTqsm/ZsZGDIt2sbK5HdEEIm0ZDAp49YtE2Ezew=;
        b=u3KuE4Iha197t75VK1fQ/E0LejCe+st48++o8KeXd3PNpr+iirkP6LrMF3dsWL36tj
         zksKeYEmA666zU6oqV31st6JpYGRScVCBziqn679hTOoMiE5LrrVDpQBEmhsL4wYPO/S
         2z5/HQZ7siGh4R0XOFVPHAHkSFCdsk7xTkeo8eFRSftKT9MtoR8/iUvHTiusY1q5lMPf
         LmrxgldtOvO5Z7xFRIJ6x5tDz2VwTvBQo10puBe8MDwOWdyLN20zNlhuTyaQBRk0wdNf
         y6/RENF2xJagTHTJI5oYJsTwYUfJP7LRQ2Y/9O+tTJ/eJHDhOTPKC0VHziT04FIe2jwK
         rvUQ==
X-Gm-Message-State: AOJu0Yykv4EcN/AEVfbhOcbEgn/+TwK0VCHWGWcMYo9YqfR+zRK2nH5L
	5WxNs1k67c1Rb66SVPqLSJl86zwZSDBasDnJWVytQ1BQNCf2L9MoBmk6FB5ZZw==
X-Gm-Gg: ASbGncsgWMRNgbHoWhFG99AzBLCY6RNQWXA3Npl4Un+4fSRmxcyAeGm5HuwnSsegLTP
	bGARvPRxcDH8puCcZB7fmsgQA/l8EOXQB2odaQFFf6rSIJzNKtu6ELBpWvgKhz8BS8wsfrYY7sR
	u2BXL5rJSiE23UnVPBEWHHWnbniliExGPoLgvdm5wSwjlEOmj5MhsmCn+ys/6Ju1M3KEUEpfAH6
	YtIkBPCQo1xwANXZWwmjB3nhkvoi6l4pX6HgcyNdvd+f4eEpHr0hW5vZ6QYU079S7Nb8fd6fqmn
	6y1gqXyEWq2JQncH9LjfXmj8sKDn4UeMfWlLKi2u+Hbk2gbGImkYRD8+69PD2rmk75EpFuK60RU
	gQDKjeS2ck8xaidqutlrfNvwZjDK5eSomlLn9e8EpQzeumrfNCy5VxQ==
X-Google-Smtp-Source: AGHT+IFXNiHeLyR9ad6ENnhydukRYpHfL7W+c4d3otcDgB4qLzLTcun64OhpwzDFr6oUuvRj1X+e/Q==
X-Received: by 2002:a05:6a20:a124:b0:23d:6956:26e1 with SMTP id adf61e73a8af0-24340d72883mr23281699637.46.1756236837321;
        Tue, 26 Aug 2025 12:33:57 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7705647e03esm8054053b3a.59.2025.08.26.12.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:33:56 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 2/7] aoe: Stop calling page_address() in free_page()
Date: Tue, 26 Aug 2025 12:32:53 -0700
Message-ID: <20250826193258.902608-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826193258.902608-1-vishal.moola@gmail.com>
References: <20250826193258.902608-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_page() should be used when we only have a virtual address. We
should call __free_page() directly on our page instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 drivers/block/aoe/aoecmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 6298f8e271e3..a9affb7c264d 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -1761,6 +1761,6 @@ aoecmd_exit(void)
 	kfree(kts);
 	kfree(ktiowq);
 
-	free_page((unsigned long) page_address(empty_page));
+	__free_page(empty_page);
 	empty_page = NULL;
 }
-- 
2.51.0


