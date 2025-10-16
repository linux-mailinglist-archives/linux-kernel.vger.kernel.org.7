Return-Path: <linux-kernel+bounces-856576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50110BE487B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8894560F55
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15223329C76;
	Thu, 16 Oct 2025 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QaB3TdRb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6723EAB6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631411; cv=none; b=ejiG8Ru/l5+JqFbWj7UroYMyp7XhhGArzuJHpVtZYrU+RmMoBBot/Q06mO/Od4JcWZR/fXf/OF5y8DLv9Ab3lrWz9NxQ4UFBHxVQYUMvDx0VJs+sD1F03UjON2TRj0dopXbXucxqLHrEtwuKqIyyu2uIQk2B8gDKRCeP/klPWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631411; c=relaxed/simple;
	bh=sajVuHlrm2j5p4dvKFCrX83KKZFmwX+0mnVl8nsEZ7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZT9pW89O7ZPc+REXdB+tloOpq9VDe9yS9ooMTfmGFZ9cnXcpA66Esc//GEVGm/GWXH14vPLFp8zETShdlgXXI9KVOqee1/1p0JYSG2hUBtJi0jPXpuRtrP6j79+dMqqKktPkXU4L5xiB5hGWGqw2GyS3sLHmRKzkoUkGQo/TIsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QaB3TdRb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760631408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWhkEYna5/SHg/QfisP2H3SeHXg7yoX1e7QIT+fEZJg=;
	b=QaB3TdRbN9L7tfCea1OnUfiHLUVQp9LoZ17GYqw1QEWj5SIm70QBWww97/C5PtG8WLArht
	mM6JTgo/efO09fu0dMLLxMjZekoefjd++K7o0lLM/yMswzNTUdwb0eYVYxYuj1wf4X5wpk
	may04xwIfcPsj9mdsnzeauNdMoF4Z6I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-ZkA3LSqaP_m5F-O6j0w4QA-1; Thu, 16 Oct 2025 12:16:47 -0400
X-MC-Unique: ZkA3LSqaP_m5F-O6j0w4QA-1
X-Mimecast-MFC-AGG-ID: ZkA3LSqaP_m5F-O6j0w4QA_1760631406
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87a0e9be970so33552706d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760631406; x=1761236206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWhkEYna5/SHg/QfisP2H3SeHXg7yoX1e7QIT+fEZJg=;
        b=XK8QEW9vdRj4WaTtXVz5BtBS+pOCMkmClSSLFZ0FMjGHD3uqL0PVcKm9JVDxaZ6v79
         /utSDCpt7ZXM+L6vuCSDdZMEY425WECFqheZrvZSFFisFburgnolaZirl0dbXbIPRpwj
         iQZ18+DKc5Ck6n+UitB781SvfsyCSHvgkbu5jySckTPAu0pn7RWgMhBbUCpptBjx349R
         cixeYhXGMJOvx6bhyn6bwCcJ1sIrFc+1lDGpCqHucCMKIktDmiNweIZxbDRhiKllOFGC
         BHG3PgApqz4xtwE+CrcO21sPKlDUVRythkQJhiM8NNsee04BdnJdQwbS+gJmYLQ7Ah9A
         ag8g==
X-Forwarded-Encrypted: i=1; AJvYcCXDw7hST9rQny7DnOj1T3szGPzE8MdON6UX/gxdvSE1ZCuTLfgkZLY0nHrcQCljFytnO48mbTzZe6rvUJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/8RlD2l3b04/HWi371RjDmI3vF2yqjAUKJSD2UUsL9DqHWIW
	ceccEmdaA3Dq/M6iLTnbYD2aV/HcqPVEybWZ6uYoz2ly7P5K3DC5nc8sXNcqS5zZQQwzOwYnUm9
	wTvaYHsLEe+l7DFoEuOm6xL+j2m1i91U62doEZCvh5BzDLnwyTzxSNlrfkl0dZdg2Gg==
X-Gm-Gg: ASbGncv3QP0ZcA0DX0JpojfkyueqpLqSDnAxk46+zJI62JyQeoGkCiCrNOxMEMnf/kr
	SQE5wGt+nBR42q9bt0BArSbwK7UK7Tal8T2enip2Hm+4E404xisamhOv5XHxE5ac/CKi1CjcoS+
	xGkI+msJQHiNof36CuZlcjzAu4w4l2uQDOoo5seMGP3Jz47lyHuLfu9e/7nb4LH9ZNSX6MzaXZ8
	liGwmiqbHycGUQlr/L6h+ZpbdOwZYncF/tz9wXIfUetiHf8cg5I0WuzLqEe3kh1+/UqIJ4Q9WPz
	48dY27pJy3wc2h73VrwIgk4kBbxTySVaeNFjNo0xgG0ukMwaIfbHHlDT6kcvGVEMChVO6v6sT+b
	RwUMuexk9A0wizTJ29bljtLE8ekzQfRavEdiDyuoVhxuIm7YOLNjotirUsObyrwC4+I9l4Q==
X-Received: by 2002:a05:6214:4e83:b0:87c:2213:ee81 with SMTP id 6a1803df08f44-87c2213f473mr201356d6.33.1760631406219;
        Thu, 16 Oct 2025 09:16:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Y8GntutE5d9se6vWJ0Hb1FaI/TEI+nUaXnsRAhUqpoBFc3P1BuHNiWkdmpvZHsos/MbW6g==
X-Received: by 2002:a05:6214:4e83:b0:87c:2213:ee81 with SMTP id 6a1803df08f44-87c2213f473mr200786d6.33.1760631405649;
        Thu, 16 Oct 2025 09:16:45 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c0128c9d8sm44068466d6.33.2025.10.16.09.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 09:16:44 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 16 Oct 2025 12:16:27 -0400
Subject: [PATCH RESEND 2/4] media: i2c: max96717: convert from round_rate()
 to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-media-clk-round-rate-resend-v1-2-446c522fdaaf@redhat.com>
References: <20251016-media-clk-round-rate-resend-v1-0-446c522fdaaf@redhat.com>
In-Reply-To: <20251016-media-clk-round-rate-resend-v1-0-446c522fdaaf@redhat.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Julien Massot <julien.massot@collabora.com>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2000; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=sajVuHlrm2j5p4dvKFCrX83KKZFmwX+0mnVl8nsEZ7s=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDI+SqXtsLyb7KQitn3xHSmDJIOo39lG/yo8u87ae/l//
 DMv6MOljlIWBjEuBlkxRZYluUYFEamrbO/d0WSBmcPKBDKEgYtTACZSuJmR4frf+DYJj1SrRd8T
 3S7Jqz4RupYulWRjGOF2is+YXztbieGf1lRLB8elhc48E7PrrJTmVXEskA5/ZdE+M3/xLfmlckV
 MAA==
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/media/i2c/max96717.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/media/i2c/max96717.c b/drivers/media/i2c/max96717.c
index c8ae7890d9fa87a78084df1f3be631004acbf57b..111ed49fb97ad585832953fb9ff11de01a83b12a 100644
--- a/drivers/media/i2c/max96717.c
+++ b/drivers/media/i2c/max96717.c
@@ -782,21 +782,23 @@ static unsigned int max96717_clk_find_best_index(struct max96717_priv *priv,
 	return idx;
 }
 
-static long max96717_clk_round_rate(struct clk_hw *hw, unsigned long rate,
-				    unsigned long *parent_rate)
+static int max96717_clk_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
 	struct max96717_priv *priv = clk_hw_to_max96717(hw);
 	struct device *dev = &priv->client->dev;
 	unsigned int idx;
 
-	idx = max96717_clk_find_best_index(priv, rate);
+	idx = max96717_clk_find_best_index(priv, req->rate);
 
-	if (rate != max96717_predef_freqs[idx].freq) {
+	if (req->rate != max96717_predef_freqs[idx].freq) {
 		dev_warn(dev, "Request CLK freq:%lu, found CLK freq:%lu\n",
-			 rate, max96717_predef_freqs[idx].freq);
+			 req->rate, max96717_predef_freqs[idx].freq);
 	}
 
-	return max96717_predef_freqs[idx].freq;
+	req->rate = max96717_predef_freqs[idx].freq;
+
+	return 0;
 }
 
 static int max96717_clk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -847,7 +849,7 @@ static const struct clk_ops max96717_clk_ops = {
 	.unprepare   = max96717_clk_unprepare,
 	.set_rate    = max96717_clk_set_rate,
 	.recalc_rate = max96717_clk_recalc_rate,
-	.round_rate  = max96717_clk_round_rate,
+	.determine_rate = max96717_clk_determine_rate,
 };
 
 static int max96717_register_clkout(struct max96717_priv *priv)

-- 
2.51.0


