Return-Path: <linux-kernel+bounces-829137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDD7B965D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF2F19C4D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D26213B5AE;
	Tue, 23 Sep 2025 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wc3DnqXD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A70B231C91
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638403; cv=none; b=jORP8oJc0EB9e6ppvcVvg5RML4QBr/F9iu5/kIicZdCdWq6JU0wpDpdKVShTCY7MSyD3uyEXPutMEB+mIPXM75xIF3XE+EqcszMsET11JeXzGHBHT/xczZIWuxduSz2QMuTd/9MCVUPP9yWA5lZ+lPFMORHxmkCft6yYsCzjmI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638403; c=relaxed/simple;
	bh=cfNqvBT+4t4p82Xzh3cs6GlN0grJes6Be3PtGF5MnJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbQBKK8/ylwfQaDTq1XGaQqj53w7D5J9IKLH4KJd+5s/MfkxngyiHamZW49xS7pwpQAipcsqbGf3mDe7ZC7c+nTUrgQgJLReNsHIZVpR65SaftKD5Gr9VrrtuifMWx2w+uqtvCJpENZcK1JhZcjed3q3OKmFgJnO80584Gxs5ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wc3DnqXD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758638400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOLL9fGO5xV3TbAIppZMqjfRBpE7K4vhEZj54a7DmcU=;
	b=Wc3DnqXDD93HnryJWl7DAAbmBdbUIpt0wk0pCwiC4esHZfv73BGFpx0kOPmQf1JdKp/wGK
	9c0O4ZCtDttwQ9QW8UtSvWWgmkf8YSabcgDycWfzAHySdph0TUmEOB1+bcJdot+eC4j8lN
	GzzvyextXZbPKtGW6iaH9ldYP6NStyU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-FGIlhKFFMYSWCdVxASisOA-1; Tue, 23 Sep 2025 10:39:56 -0400
X-MC-Unique: FGIlhKFFMYSWCdVxASisOA-1
X-Mimecast-MFC-AGG-ID: FGIlhKFFMYSWCdVxASisOA_1758638396
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8492067f921so335883585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638396; x=1759243196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOLL9fGO5xV3TbAIppZMqjfRBpE7K4vhEZj54a7DmcU=;
        b=JpFUt+waYyeQNwZe3Fi+8YrSctrtm0ON6O7SSVv1b1ycw+qlY0WdxZOSGaFPvfiAvO
         nJc/laWL42hKKfNvtayl3bbvO63Us+M26vbANDuiLUAhFcsQ1rGYfqbtP/Beu06EGWqE
         bDCmZVJAFo7iMHgfoNzRIbi2vBBN2Ey2P/5queB/baGnrW+VJTQrY4pOvzQ03SX2fdqG
         BCdCbNw51ZNN8VgCxADreDkgfOf9tI/IQkTn7jY/GQOO63Qm2KXsHv2U+27M6bxxzd3G
         /Zhgwl/WJpX/vu9DAiWtrrefB8tlmqqi4LNJniU29eTCPtIVeYyIs2pNNjtsgpAluDzA
         DseQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6/GXh/i2B0D8nIybrMV3V7gd5usvyc9usaLUK7hkDajSu0HWt93tDqcLCB1DzuKcYxJbsSdyCJ1NfigM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFheLJ8Kwzl1ciKhkxm7WwoC4lQA3hjeZLrLKnLzApR+T/oruC
	Gg3Ml1JpV3E+owUEZTtVkn6hbOFcm8OlFnOt1bNnymPv0pxtGErErqcGyNH5VVI0jCgroyKJMQE
	tWfezYrVQJ9alG8Pf+3WoMXUu6XxDdZZL7i4j3n+t6G/UICcqoXMzdzXaTUTtJguoWA==
X-Gm-Gg: ASbGncskJhU8zFbZxkzyYXKqslxCD1Zdd1eC/f4xVMKRpcAEJIE7HS3L7eNigULQQpy
	Vd6RLFIWNqZ3kmcR+3azTlYjEbxTlr/uWeM+Trh3yKDubCRegFY6I83qgKZoV661wNqWrhPWU6x
	KFVAPeO2rUXSVtAtIMKXwpTD62xfmG1ZEpnUA8KCPewdDVo5v1Ycn2wGCmUdOlzv4gni4n2tJow
	whMZU0nm7wPEyjfYilc0Di9lYtXMHyt1bJw1eXF/iQQb//i3BmuTDuYasWORbwfQYkYVKQOrU27
	NiqvHfSRKMc7U8b3sD/ZQk/dQKmgpDjXDx6RRku9keeX7gIMGmvySy+qQrixivwnQMV2SYQw236
	F1HnvkUr7U89eTaUUW5ZPPMWMr9qTKmnjldpEnSg=
X-Received: by 2002:a05:620a:6cc4:b0:810:731f:32ff with SMTP id af79cd13be357-85173701be0mr359452285a.50.1758638395857;
        Tue, 23 Sep 2025 07:39:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9XR7K20CVO+2Sa3lgEN3xj1f6+KE/9jAZOYv1Eg7JSuBt2rHxjTNSu+IgMsqfCnyBEcwOqw==
X-Received: by 2002:a05:620a:6cc4:b0:810:731f:32ff with SMTP id af79cd13be357-85173701be0mr359445285a.50.1758638395207;
        Tue, 23 Sep 2025 07:39:55 -0700 (PDT)
Received: from [10.175.117.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84f2f6f3c25sm230272985a.49.2025.09.23.07.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:39:54 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Tue, 23 Sep 2025 10:39:21 -0400
Subject: [PATCH RFC v4 02/12] clk: test: convert constants to use
 HZ_PER_MHZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-clk-tests-docs-v4-2-9205cb3d3cba@redhat.com>
References: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
In-Reply-To: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=cfNqvBT+4t4p82Xzh3cs6GlN0grJes6Be3PtGF5MnJM=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDIubdRXn7B+t4L05d5y9vOdYadeiyq828T9W+dX28Fkk
 evNvGHyHaUsDGJcDLJiiixLco0KIlJX2d67o8kCM4eVCWQIAxenAEzEWJWRYQK76J1DzGbvDqb2
 ls2cnGOVbNyZu2Jze/oyDvEHOh2BHxgZzn1Zf3nDqW0t8s/CZmxey9F4UTdN9J/Sm2Tvno0tf2I
 CmQE=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Convert the DUMMY_CLOCK_* constants over to use HZ_PER_MHZ.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/clk_test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index a268d7b5d4cb28ec1f029f828c31107f8e130556..372dd289a7ba148a0725ea0643342ccda7196216 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -7,6 +7,7 @@
 #include <linux/clk/clk-conf.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/units.h>
 
 /* Needed for clk_hw_get_clk() */
 #include "clk.h"
@@ -21,9 +22,9 @@
 
 static const struct clk_ops empty_clk_ops = { };
 
-#define DUMMY_CLOCK_INIT_RATE	(42 * 1000 * 1000)
-#define DUMMY_CLOCK_RATE_1	(142 * 1000 * 1000)
-#define DUMMY_CLOCK_RATE_2	(242 * 1000 * 1000)
+#define DUMMY_CLOCK_INIT_RATE		(42 * HZ_PER_MHZ)
+#define DUMMY_CLOCK_RATE_1		(142 * HZ_PER_MHZ)
+#define DUMMY_CLOCK_RATE_2		(242 * HZ_PER_MHZ)
 
 struct clk_dummy_context {
 	struct clk_hw hw;

-- 
2.51.0


