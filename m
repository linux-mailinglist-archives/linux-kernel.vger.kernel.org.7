Return-Path: <linux-kernel+bounces-726523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B64ACB00E24
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0571C44E05
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FD02C15B2;
	Thu, 10 Jul 2025 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T34/lqL2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62812C08DF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183962; cv=none; b=eMIQNXDxrOyzpcfoB1NeLztC1NoKyoMheEfSG//oMBXCrH0HCQW1T4nqvjX3RsNlZGR/nXbuItQOwTEYuD3qok+vSeN7f6+0+jz7v3u4cdmoHCm6ioU/9z3wuko2Ukqa+bjFyDUIfHXPQ8ySpkusBTkhjybci1Xi6o5zPNZm350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183962; c=relaxed/simple;
	bh=I1wqJdRTlHmsA0JfGk/JJDZ1BDeSSBu3qnl9x/JMS/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GjxYoPv8FdX+xRQn3GvxJYoDzCcKUvIIvHI7Ao4CoVAO1bx8E+X85qieqFmn+sJkcBrm7xF9S8Y94r4fHRRGaI1jAwL6Edj0siOT4OzH75c0+KESdhm11Ox5jI4k+C6mu+a4zmH25OkOOWLzpImFech043uNX2nxxafjwHlPuho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T34/lqL2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752183959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nucAiqEHmLyRkEarV6UrpWZn+zxmDdNtayNZWpsFgMk=;
	b=T34/lqL2nydEF7Zf9aB5qXT7sx3zLCQopNB4sX1018qDg94540AoGJy4jFxDlASx9LIJce
	3qwsjDJVOp2n5baQXW6NpltThPhM9AxPAX34FzSplbf3tcIBJ6KHExKQ3jYswDI+GT7VI8
	X1qqzIdUquatjtKJGdgAr28AQ91Gfgg=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-04iEjgN6OmO44aBeyKMtJg-1; Thu, 10 Jul 2025 17:45:58 -0400
X-MC-Unique: 04iEjgN6OmO44aBeyKMtJg-1
X-Mimecast-MFC-AGG-ID: 04iEjgN6OmO44aBeyKMtJg_1752183958
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-406792ddc01so1313737b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752183957; x=1752788757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nucAiqEHmLyRkEarV6UrpWZn+zxmDdNtayNZWpsFgMk=;
        b=AFfflWjW3TArdC6ZPOwyALpwY4wAbx2KS00TkipnP4py8wdk/n52KlZyRkJW8X1KzW
         aIwteOHsw+/72xA0XkwNFQPrL7raVqsFFSqH0okaz2n4glFzI8ZM8auS1G+8/9tqbaKG
         EXiOZJmzQqkH3P7B3A4Qstjs7J57RkNUw/qXmKuYZar5xlMcbynVanXhkc2HKmlHhsM8
         7UXg1OnpXIbbLud6CKnf4m9hOf81NMHGe7VCCGAhrjqdNYdr3LfRcR9dVoVA814V82Xc
         g9QfRHZkjGd/zyrlUuLkeqO61pF5hqw5D6LuNDaAbvvtI7QZ26OEJx3+jAcBOHzZcDpz
         Mp9w==
X-Forwarded-Encrypted: i=1; AJvYcCULM2uSH5mSs+0co/BrOVQe2bRMAojfTwA2ieprL7wq0z7MaZI0hdHX5+e03tC+KqdEeuWWHqTuAPHZlaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8YXU1kextZmSfzkaVC/r+D9G6kHHrK1mVFYFoUF2spB3w5bK
	QMrW2f+7g8o15nZcfZ6o9vwWmCOOWfKG4VdxxZR/Uc2PvTWKaq3xov/s874rhOmMPWHeUH8emAP
	zFNo0bBz0LWQP+Ts5MY5wPhZremgZqRIZ7Iz+VIiHqncTXMOUQ1RjTf0GlwsG3kvAMWhDMKfRNE
	MoPmFFxysvoVv1DEad3fyFmCmFDYI+u3lmihaEuL5LFSs/VTEf0Ww=
X-Gm-Gg: ASbGnctHrCghrxjXZVsTutroWTnSuX3CLveGtyagO1A/qw/+bIIPJvbtrxh79wybzfW
	Bn71xe6oYygjlssi4dv/4jeWcolgu5RcOvUmZ740abzBL6nULcfR5l0sOiBT6iVpxkbNUobtqyB
	YOEPSMtqGGihkihXLbi5mCC0lMTumvjk5NP8UVi9jEcFUJqKsA3PCvJesjIkcw1Iapw7pCEB433
	qQBm5ERTfIVLEK0kFAMLNJP5V1i9rFeJDcH3Tf8NVlJ3PlpUd2ThKQrPTXVjSjgjtT7151vDEbS
	aJfCm+VI/bL2VsOH/435lnZ1winQ/B5Xj5+5AR+HKa3m
X-Received: by 2002:a05:6808:2226:b0:404:f14a:1345 with SMTP id 5614622812f47-415397b8ebemr368530b6e.20.1752183957677;
        Thu, 10 Jul 2025 14:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWEP2MgO/8eqDff063pLtnLKOVnMsnlx9GHlQHKfB8kyjNWeAH1eCP83ViI1B7NZhjtnja7w==
X-Received: by 2002:a05:6808:2226:b0:404:f14a:1345 with SMTP id 5614622812f47-415397b8ebemr368506b6e.20.1752183957279;
        Thu, 10 Jul 2025 14:45:57 -0700 (PDT)
Received: from [10.144.155.224] ([2600:382:8102:a87a:c1c4:9ad5:f0c:c0f7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41419baa00dsm345483b6e.22.2025.07.10.14.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:45:56 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 17:45:17 -0400
Subject: [PATCH 5/6] clk: tegra: super: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-clk-tegra-round-rate-v1-5-e48ac3df4279@redhat.com>
References: <20250710-clk-tegra-round-rate-v1-0-e48ac3df4279@redhat.com>
In-Reply-To: <20250710-clk-tegra-round-rate-v1-0-e48ac3df4279@redhat.com>
To: Peter De Schrijver <pdeschrijver@nvidia.com>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752183937; l=1155;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=I1wqJdRTlHmsA0JfGk/JJDZ1BDeSSBu3qnl9x/JMS/0=;
 b=s5APECrNqiizBVwMlalLDtRZ3SpRDdcPiKfaj0y9VcfIFUCFyQZEhBT5BFX/kdGsIxOqzrrtJ
 Hkl52GAjk2dBJ84qohh+Oz5jt6wQrPKFHVA2ds6+s9SV+v9RKvTGQDM
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate().

Note that this change also requires the same migration to
drivers/clk/tegra/clk-divider.c.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/tegra/clk-super.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/clk/tegra/clk-super.c b/drivers/clk/tegra/clk-super.c
index 7ec47942720c5aa43f35107369b42804f4847b97..51fb356e770eeaea9d26ef48f298dbc00e164732 100644
--- a/drivers/clk/tegra/clk-super.c
+++ b/drivers/clk/tegra/clk-super.c
@@ -147,17 +147,10 @@ static int clk_super_determine_rate(struct clk_hw *hw,
 {
 	struct tegra_clk_super_mux *super = to_clk_super_mux(hw);
 	struct clk_hw *div_hw = &super->frac_div.hw;
-	unsigned long rate;
 
 	__clk_hw_set_clk(div_hw, hw);
 
-	rate = super->div_ops->round_rate(div_hw, req->rate,
-					  &req->best_parent_rate);
-	if (rate < 0)
-		return rate;
-
-	req->rate = rate;
-	return 0;
+	return super->div_ops->determine_rate(div_hw, req);
 }
 
 static unsigned long clk_super_recalc_rate(struct clk_hw *hw,

-- 
2.50.0


