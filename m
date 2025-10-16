Return-Path: <linux-kernel+bounces-856579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09910BE4893
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDA6F5623D3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30AE23EAAE;
	Thu, 16 Oct 2025 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNxmv7cL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD5332AAC1
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631415; cv=none; b=DCUyQGI1kNDjlIZZCxuDWrb2jIjiy+OufQOaPXNrBceWazEB0Mpb0GnmxPeaHgBDD0yixx4tDWYnNayp4kNa03X569U2TkBZRyCnKlmsML3ZNuauZANF5Dks+HL9FGEOtFtR2A261olictOr/xjB0TDLsclwDPqKa5ntCjEEJHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631415; c=relaxed/simple;
	bh=d7JCO3O9dRkRACL9U8RXwExrEcRYnrOli37/5PdH+sg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cTW9yL+/Of9KNK6jH7Z9UzoSOLpu04NS+VVBzTULABKTYOeYDbyjjU7D4NZQh0WVGjkx6HcAZ128gigVp0GXIOdJ6AdynPqh2KA7s4zpEBXaNbKsC/jJ9IBnY7DKfwSqxNbWEdbSh3BBkmd9ltnWC16EkrZNKKQ0tXiAfohK5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNxmv7cL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760631413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5qh5aSpK05wY0EhFU2WQK7ri954tL+7GouUI5B/RwY=;
	b=aNxmv7cLu1x9l/NBJOarBOZ4YP0N1j4snlEtWOuEoDxwhAGyT4xG5HwzVbxQLZmkvMx9Yw
	TNhChS2Scx88ca7NbhOb1ci50ugXw8yqFo3IdMZzwhh8sJs+qqnIPLnQrgk2aI9jAbHAVy
	F5Ab0K3i0ruQYHI4KEOejfzUaN0fNmg=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-v17tAAXTO--dIHICwVbPQw-1; Thu, 16 Oct 2025 12:16:49 -0400
X-MC-Unique: v17tAAXTO--dIHICwVbPQw-1
X-Mimecast-MFC-AGG-ID: v17tAAXTO--dIHICwVbPQw_1760631408
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-58401ea0738so1376216137.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760631408; x=1761236208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5qh5aSpK05wY0EhFU2WQK7ri954tL+7GouUI5B/RwY=;
        b=jP+lXc3OuT4wnJBVDUrupeZ05HzgAW2fj+SWLOJml3Sq+ZDFK3jbEmdL67d6NtFC8I
         bIQ6wvvfU6YTPZXaT0FoLoK/N4dGqv9r+4616p83E/45n0+NAgCYuIEeF+EyN9iIqpMX
         rrDECJ6GpDTaaC813T98Q3yNka+hUhOUP+joA1Jt7/mMe+iiC3Y5ZYewLSqAOOCI+gNv
         R+HRURg9DuCNr1kBCxWjUAA1qqh5e0wPjEDkZVBTFGYDM75llmHiyn4KC1FxQLCaORPx
         Tx3+fTMtCFLPtZ3M5YwvnKcjDXABIWm9acxpzAPWVeaSZmn1ZK+54ecCOuQZPjwzvgnz
         93Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVfAwyRqXoy9ezW+RsWyfXM148er9c2u5SmAetzEAyvT6fhqpISlrGKJUJqIH75+aR4BF797MitNd1lq30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoq3TRj1zAyWVWHdHoaVWm7eafHJ/lru/3AQBZFcAzY4OoB2iA
	ngQCSs2EXhjdKCKquNXXKo4D0LbFR1OHX4pVnF1q12PrvP6JeeL2T6hVM9gzmPo9UGTwZqjHFXT
	ilmqarPw+8DFTRdDAvphvhR7BIC1v+5KaxVgvXibQpNWhkAQT4o+3b0Gl8cdq6T+OKg==
X-Gm-Gg: ASbGncun/2ksnuSphb8wm/UDxsBlfVESV/68zB+4ms+z5edEnNvyezlHgJDKUnCZsSN
	bJaCUj0zOUggVo9g4+7XimjMKnrHlpEIPA7wbP+QAkMPK3kFyGLmSLhVsy6uX5hot0nkIMJIdnV
	B8ML5FvhjTOxC5PFEvFbsRsL+m+p6JUr4WokC5z1+rdG6srDzUN2SP/mmdCV+/1oGz9Wxe0pi3x
	VF0sIDHfibshn2k/8at/Scbzy4zRTjIFg1ic2Q+r+lmHhFITXQ9PLEDUR4CWS/83gTD4cLMjtTc
	svthkYr9NYwULm0QHSueZhj1m4VWelU5oU1UagRQsrNr4Zj3DGhOjBX4cKlEiCIsHG7BJ7j4/N1
	GD1C1C73sjTJI6nUR5fzVeoY/1Zu4DRx4KCPiAq0sF0kmHh7KqCpJT8zkDAedynBZnOecKg==
X-Received: by 2002:a05:6102:4404:b0:5d6:157e:86ac with SMTP id ada2fe7eead31-5d7dd5ef58emr534866137.36.1760631408333;
        Thu, 16 Oct 2025 09:16:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtvaWSDhP2hY83W5EyJXqX1gwkX8cx/STynn95ag9RtU4IA7EmelwPHWl+32kv6zYbIGjfrA==
X-Received: by 2002:a05:6102:4404:b0:5d6:157e:86ac with SMTP id ada2fe7eead31-5d7dd5ef58emr534800137.36.1760631407921;
        Thu, 16 Oct 2025 09:16:47 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c0128c9d8sm44068466d6.33.2025.10.16.09.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 09:16:46 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 16 Oct 2025 12:16:28 -0400
Subject: [PATCH RESEND 3/4] media: i2c: tc358746: convert from round_rate()
 to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-media-clk-round-rate-resend-v1-3-446c522fdaaf@redhat.com>
References: <20251016-media-clk-round-rate-resend-v1-0-446c522fdaaf@redhat.com>
In-Reply-To: <20251016-media-clk-round-rate-resend-v1-0-446c522fdaaf@redhat.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Julien Massot <julien.massot@collabora.com>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1651; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=d7JCO3O9dRkRACL9U8RXwExrEcRYnrOli37/5PdH+sg=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDI+SqUV6eUuleoqERM79OPjzd9RcgK/fF5w3qw4HKgyQ
 XHmMvnLHaUsDGJcDLJiiixLco0KIlJX2d67o8kCM4eVCWQIAxenAEwkrZLhr3xpqgXT9CNOTnZa
 d2Y9a1mt1uwTvYk3ZfXiNBVhsQqtBwz/7I7wXLEOMHEoLN//58oVxleB9asUvOaVPfA64OE1RXY
 LAwA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/media/i2c/tc358746.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/tc358746.c b/drivers/media/i2c/tc358746.c
index bcfc274cf891774b45797a8e51939232de2db2bf..86d9ba3ea4e5458412cc49d75bb9a1b4984984e9 100644
--- a/drivers/media/i2c/tc358746.c
+++ b/drivers/media/i2c/tc358746.c
@@ -1222,14 +1222,16 @@ tc358746_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	return tc358746->pll_rate / (prediv * postdiv);
 }
 
-static long tc358746_mclk_round_rate(struct clk_hw *hw, unsigned long rate,
-				     unsigned long *parent_rate)
+static int tc358746_mclk_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
 	struct tc358746 *tc358746 = clk_hw_to_tc358746(hw);
 
-	*parent_rate = tc358746->pll_rate;
+	req->best_parent_rate = tc358746->pll_rate;
 
-	return tc358746_find_mclk_settings(tc358746, rate);
+	req->rate = tc358746_find_mclk_settings(tc358746, req->rate);
+
+	return 0;
 }
 
 static int tc358746_mclk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -1246,7 +1248,7 @@ static const struct clk_ops tc358746_mclk_ops = {
 	.enable = tc358746_mclk_enable,
 	.disable = tc358746_mclk_disable,
 	.recalc_rate = tc358746_recalc_rate,
-	.round_rate = tc358746_mclk_round_rate,
+	.determine_rate = tc358746_mclk_determine_rate,
 	.set_rate = tc358746_mclk_set_rate,
 };
 

-- 
2.51.0


