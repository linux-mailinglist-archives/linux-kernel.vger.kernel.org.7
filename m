Return-Path: <linux-kernel+bounces-790925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26B5B3AFD4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6D43A2005
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988EC20D4FC;
	Fri, 29 Aug 2025 00:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MeGgwKpQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6543920010A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427929; cv=none; b=uP8vACwUtQCY8fiZylaF+sYdo29fk1U0lp7hFM0M1h6A86dQCamTh74381shIGfmev+RAi+ci8/3WQePEDODF0q3CSef1MaikYUFt/PgPNptK+aRxq9Arg4EXWTD4amnyTUiE6NQn2BkvTdfo4Dt08IdUDtLfQGUXT8kzXx+ApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427929; c=relaxed/simple;
	bh=lRErUXfhlVyOjMePggfg3EacyZAvSvm+w3vZGvHjG+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i1sonFrZlKIzJAOLKXfKIIt3KaLt4DwSTWfYL1arjwMZkcTV3bFsHXfjFwwxzrZ2U7QLt2VWxyMSOBCIGwTlMhWxdWGX04nZMssWcZKz7kfHVF+k9HJA4fPeqBh3Ax5IAmbZWenXnMPsY0olKmnWR35Hycv6rCNf+lCCwEjuWl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MeGgwKpQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756427927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQVjNKRtGeYd79k9EsHTPhO8iq2mtofexnH8gr3Lua8=;
	b=MeGgwKpQP21PZsdWaN6D4jpcm6dfE5nqwlb54zjGvXv4A9udiMP8hgnZVjYdy/fyHV9ScV
	ixetOv8JQ5HC7jVyFen9wO2Zrwq22Hb49sGRm/MT+uFc8MtehsmMKCkRk0pd7Ld58AnHrM
	fquESkcqppgE1kmjvZqxrbZ06SmG3mY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-fbHcLwkoOG2O1m64KUl6lA-1; Thu, 28 Aug 2025 20:38:46 -0400
X-MC-Unique: fbHcLwkoOG2O1m64KUl6lA-1
X-Mimecast-MFC-AGG-ID: fbHcLwkoOG2O1m64KUl6lA_1756427925
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70ba7aa13c3so49194466d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756427925; x=1757032725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQVjNKRtGeYd79k9EsHTPhO8iq2mtofexnH8gr3Lua8=;
        b=bPCmdYkvxSVGXpyojgX/6+gu1XRrEbYiE7rn5SKCyqHPw73JPMVBqtM1mFPClZzEvW
         kTrIUBAJZB4CMr3Yq86wgbK70eGUiCgu4H6+gnRGxvVwjIGafY0ZP4frN0AEUUEdShSL
         6lamC0Ff10VKe8Q2+1ujh64rks/l+H5qZCn6y2WtjZS0GfS7/Sw+rtRsgItqPOjvDapS
         ZeJybJyNf5tvcbt+XPEAfmf3mdXK6bjIYNQ+L5e1ncClPRyY9F/ARcKuePX9pl4OSxo6
         oysiTXh7z5aRZZNpErQFbVWczNeF5mlmNld1wxsEfCXqW1dk2LntkFE7rFbZZHP2QI0b
         Pj9A==
X-Forwarded-Encrypted: i=1; AJvYcCUyHWX09vd+X/JYwKGYj8rRjBu0fZM3fTI73aNQ+tsmyh9eHzg6EpB4JakKWcv1MKdOxP7vGB5vVQjQhOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOOARHHyhDUc5+wuxartZA1CtfxdCsqSxrXSAuJeW+xfaV4It/
	kcLdj9AaBlP1Jt++KpWdKBd6iKUSB4ihaoaaqgxqHa1WANvS39fbx5Og0N1Uklh8nVTBR2PQcIx
	B6SfEDdT1jRI1GN/OfkJknFmi0BJvgJjpnbOQWryBA8ODwPPu9Iee1RpteBJEhp8omQ==
X-Gm-Gg: ASbGncsxn9nbmhGkt6kPLHbVRwT+nSF67sHkOygyGmYJKXtSzWniQbn4VaUlUbhTTwr
	vrcHgn1bGcvxMnjWQGnvyr5+NxgUhzQ90+TDv2FOOUoX00WkgGmQIK1HsXMmyMdC2eZK/eq8SER
	tFoRGyLZdjoSTSf/PLDAXGtxAqx2PigLxzbLGORTxAdW/A5kEQHBOQ4nTEGCTkhQPssSTPpeLJo
	UA7679nhkQJow4Z78o2WGzThxjNE7D0QZymgB8jUuPSxKuFXwor2zA1AHAIfDNbI5ezkIKWizRm
	FBiJAzJqV/kRwf5MYSMERd9lVf5QHdeUTRruTx0gw47pI+hRmKwd9rEyTiFRv8C0j5+F2OFJYzz
	IbOa8Rqsmbu1oGbORGZPl60IXqBe7vBGYyw==
X-Received: by 2002:a05:6214:cae:b0:70e:782e:b23b with SMTP id 6a1803df08f44-70e782f22bamr10926796d6.3.1756427925289;
        Thu, 28 Aug 2025 17:38:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR8adeLmPp6i8NPj//2LYlvbZ2JGvJAUD70v2I2NLKTSUE6nmwskQ+vGH0x5SgjqCGSE+qBQ==
X-Received: by 2002:a05:6214:cae:b0:70e:782e:b23b with SMTP id 6a1803df08f44-70e782f22bamr10926366d6.3.1756427924487;
        Thu, 28 Aug 2025 17:38:44 -0700 (PDT)
Received: from [192.168.1.2] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70e6264141asm5588696d6.65.2025.08.28.17.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 17:38:43 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 28 Aug 2025 20:38:22 -0400
Subject: [PATCH 3/8] clk: rockchip: half-divider: convert from round_rate()
 to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-clk-round-rate-v2-v1-3-b97ec8ba6cc4@redhat.com>
References: <20250828-clk-round-rate-v2-v1-0-b97ec8ba6cc4@redhat.com>
In-Reply-To: <20250828-clk-round-rate-v2-v1-0-b97ec8ba6cc4@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Bjorn Andersson <andersson@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Andrea della Porta <andrea.porta@suse.com>, 
 Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756427914; l=1835;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=lRErUXfhlVyOjMePggfg3EacyZAvSvm+w3vZGvHjG+s=;
 b=77L/EGAGdRYd5Zfk7wMZPiUoUyEJ+wFGI5TKO4e9gl+bXy3dLwkQMeaRO1HRElJrc9TAOKFe/
 f1vZeXk72u/BkLnWKmAly+0tQG9J1VwJ/BPTEXNwrw7PqrQdgLjH3+M
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/rockchip/clk-half-divider.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/rockchip/clk-half-divider.c b/drivers/clk/rockchip/clk-half-divider.c
index 64f7faad2148f27099d1ace36da45207e2315a1c..fbc018e8afa44c87a5a7b53475fc98b318ce1ec8 100644
--- a/drivers/clk/rockchip/clk-half-divider.c
+++ b/drivers/clk/rockchip/clk-half-divider.c
@@ -92,17 +92,19 @@ static int clk_half_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 	return bestdiv;
 }
 
-static long clk_half_divider_round_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long *prate)
+static int clk_half_divider_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
 {
 	struct clk_divider *divider = to_clk_divider(hw);
 	int div;
 
-	div = clk_half_divider_bestdiv(hw, rate, prate,
+	div = clk_half_divider_bestdiv(hw, req->rate, &req->best_parent_rate,
 				       divider->width,
 				       divider->flags);
 
-	return DIV_ROUND_UP_ULL(((u64)*prate * 2), div * 2 + 3);
+	req->rate = DIV_ROUND_UP_ULL(((u64)req->best_parent_rate * 2), div * 2 + 3);
+
+	return 0;
 }
 
 static int clk_half_divider_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -141,7 +143,7 @@ static int clk_half_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops clk_half_divider_ops = {
 	.recalc_rate = clk_half_divider_recalc_rate,
-	.round_rate = clk_half_divider_round_rate,
+	.determine_rate = clk_half_divider_determine_rate,
 	.set_rate = clk_half_divider_set_rate,
 };
 

-- 
2.50.1


