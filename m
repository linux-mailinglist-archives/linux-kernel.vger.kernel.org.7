Return-Path: <linux-kernel+bounces-798935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64FAB424D8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B6A3A2F0A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B00B230BDB;
	Wed,  3 Sep 2025 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SI7jxgjY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA7F22B8C5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912540; cv=none; b=nPyCpeSr7BYkFrH9sjoRzIswhP+OwqFeqbdtH4Kk3NORRwO2bHl7fIS9qZaRp6GipSIsl/q2UQoTjEiFzC66vKZso5vruBt/WQGP8XvjrU+hbwaNxYS1NNCju4xr++CpObPcF3lr6DaaRWqfLOuvWQpYDJmM8qH66rfqYMLxhG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912540; c=relaxed/simple;
	bh=AjcEhiucMili9sf/wwjT6T4E9qy5apL2Ir5PIpobHoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bNizkNkp/NEFuyqNm+QX5Tr5r6+X4KMuavb8V8TE6jBn2hCIOjvJu0q6nGUaM3oWveIV+igZBrfWq3cT02hTYV44uFztBEgNXOPI2Gscby/8LL5fMV0SD8iD/CLmqtQHqOQL5VCwJax2bAcCLaAeFgUENLrYz4zUqKZS1bWx8+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SI7jxgjY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756912536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+0vXFzhSxSwj3v2mrFQi86NSXUL4ZDppFXq+HtAwjk=;
	b=SI7jxgjY9PZY/of1KI5W7yU4fHEyW5bop9oZgg8L7T/JTMKIM9VQcgOB7FALVmnCIA8lCV
	ktb9mcFeovNPkg3rPUUzd1cAgQOcrFgNcm7IiPsJFjIYF1A/GXkWvzVGsJ97wDJ2PxZEQy
	J+jv1Vrr03tOuPD2i7YgZUckhTFumzw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-Wcf6dW0DMpKwv4c4U2YGKQ-1; Wed, 03 Sep 2025 11:15:34 -0400
X-MC-Unique: Wcf6dW0DMpKwv4c4U2YGKQ-1
X-Mimecast-MFC-AGG-ID: Wcf6dW0DMpKwv4c4U2YGKQ_1756912534
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70dfd87a763so76528416d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912534; x=1757517334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+0vXFzhSxSwj3v2mrFQi86NSXUL4ZDppFXq+HtAwjk=;
        b=caMwQHQq6yiRBoPiWU729GdXVJQcJM9o6epnyTD0lZMTwS88XNP5T5nlKCuLgLgL96
         xrXcvemo0+AvKaxyR0o883u3azUsNPC4keXN/wYKVVCS4YTBhVf2QAag9VIodTKY335Y
         mpmJ0oIqnOxYd3CY9lttAcYYuV/iHA1tAmu5QFQnizU7LnDD02jdaTDk9XAKuHfTdR3f
         hqg819PdeMUkYVzU5Y6aN+4BKgJkqE6TdtYk+xM2XXn0Qj7qa+oxzQZrdHmILK6+otbA
         4NHWy10YbF6pc99UluY8ZYnxag+Oq7+hjv0i8Kw0b9FA2pafasP4NW2M94j/crWtNz80
         10TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVapGQvcc/RM5qs91HzYwabqYSotFEpbUcOeuU0vCeVQEKt6w5wKYn7bJjub1e6lti3PRgCZVl6B/JT5w0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1K7ZOUZahsfSXDlVxXeJmL219Y8Pkr6XfAl36Sgq4C7fFkFro
	oZj5zK6QYkFulRHJZl27uGSVzrwcqCdVeZz4XGDolMwXQUzE1sgkzs1gY8ZhUHlb9x9Cc6cmk9/
	h521J4SQdaAGxnl9RvZgAHWC1+YtSplk7yc3oM4JUsexmFPQwe48V4qTL3LP7uIqCWQ==
X-Gm-Gg: ASbGnctmnuOHTeZ5zjM5TsF8Xuck2PyssMLFPwQGR/tv9wPO8NAOqWBNXUXGtj3YBWy
	vvtX2QtUlLK1I7AMuV1OVS/sGVKl6XRWqgHY+lPqr/3LSVO4ITAAVs//N3xqcMXIQ9dg/7dgNqE
	rrganX35tlNrrVWXnKtUuaQcpReru8wJ6/TyZzY3At+9tA3p+2zlpxBgs0dAp7/1n8sdt5ksJHK
	fjLz+dQD97gdqN+oiNz02Vc/nqzJYXhbjPCjvNzI1sN9IChZyFcnoLR7UfSeB3osNKYA7HlgHIX
	4Yjvew7gydv2N0XKa/T5X+VePVQB1WeWnwJpf5D+PfNgUnGo2D7g9EmymfeXZIib/Kz0sCCNB0I
	=
X-Received: by 2002:a05:6214:e43:b0:726:c288:a666 with SMTP id 6a1803df08f44-726c288aa54mr17036326d6.59.1756912533598;
        Wed, 03 Sep 2025 08:15:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3IlMKWWgNAO7Q6WOeecM/0SWSXq5cZbNHqhjh9Ns5zZcD414eMglOR+F+Y+S6eyNAlpLYGQ==
X-Received: by 2002:a05:6214:e43:b0:726:c288:a666 with SMTP id 6a1803df08f44-726c288aa54mr17035696d6.59.1756912533116;
        Wed, 03 Sep 2025 08:15:33 -0700 (PDT)
Received: from [10.12.114.224] ([2600:382:850c:786a:ff8e:13a:e47c:3472])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16de16sm30827706d6.3.2025.09.03.08.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:15:30 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Wed, 03 Sep 2025 11:15:04 -0400
Subject: [PATCH v2 3/6] clk: tegra: periph: divider: convert from
 round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-clk-tegra-round-rate-v2-v2-3-3126d321d4e4@redhat.com>
References: <20250903-clk-tegra-round-rate-v2-v2-0-3126d321d4e4@redhat.com>
In-Reply-To: <20250903-clk-tegra-round-rate-v2-v2-0-3126d321d4e4@redhat.com>
To: Peter De Schrijver <pdeschrijver@nvidia.com>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756912523; l=1192;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=AjcEhiucMili9sf/wwjT6T4E9qy5apL2Ir5PIpobHoI=;
 b=70I3Mq4ZlKGkt6RonBDIV0MOdusccrx3oFKMRyi6Oj3qJe6anIuKkXklg2G3L0mxPS9RSXztK
 VIj/MFE74U1B/LMA9OcxnqvYJNn8ONfhSkWtW74K+w2SQ3VpCWSv8y0
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate().

Note that this change also requires the same migration to
drivers/clk/tegra/clk-divider.c.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/tegra/clk-periph.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/clk/tegra/clk-periph.c b/drivers/clk/tegra/clk-periph.c
index fa0cd7bb8ee67801dde3c65eababe30c96a176ef..6ebeaa7cb65648e77f11f2c676aa3428bc490a73 100644
--- a/drivers/clk/tegra/clk-periph.c
+++ b/drivers/clk/tegra/clk-periph.c
@@ -51,16 +51,10 @@ static int clk_periph_determine_rate(struct clk_hw *hw,
 	struct tegra_clk_periph *periph = to_clk_periph(hw);
 	const struct clk_ops *div_ops = periph->div_ops;
 	struct clk_hw *div_hw = &periph->divider.hw;
-	long rate;
 
 	__clk_hw_set_clk(div_hw, hw);
 
-	rate = div_ops->round_rate(div_hw, req->rate, &req->best_parent_rate);
-	if (rate < 0)
-		return rate;
-
-	req->rate = (unsigned long)rate;
-	return 0;
+	return div_ops->determine_rate(div_hw, req);
 }
 
 static int clk_periph_set_rate(struct clk_hw *hw, unsigned long rate,

-- 
2.50.1


