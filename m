Return-Path: <linux-kernel+bounces-762636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DF2B20931
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7D844E2B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FF02BDC38;
	Mon, 11 Aug 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKaVTRNv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5172D2D6632
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916513; cv=none; b=BoyxpgJFoiSms65kO14E0Y28USjX1WpbVyqcQuijCclmm7Vnjhn2tSZ4YeqUdr06XcP1OvlOyZwCPquW1CrFqt7iEooaw0iv4uYCgVHuoHniU2G8UXIWBTVz5XffFXo+zLo2Og286o2lylXLGCMlSEdOWdYuHffcNH0QvRN7Irk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916513; c=relaxed/simple;
	bh=797B/i7zAYqS3C3fUwjFhBm7v2UlPo/3f5vR7+9WseU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NwM5SWi2aMpHGGw63xX+IOpJssRyaxvXIg7Nq/bIBUJFLDDLgKzP2u15GbW+yx9QNmSPNtFKZjoNYGmAt9afetroglZ7rzWZbmWdglBnzawjekK0WebjgZqG/5t4roTv+8sW9u0a8bz3frGczPYGWMD2Ys+vdBnvPB+Fd2qKYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKaVTRNv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754916510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KjrMZnWuasomCOeyOdrJf6baH8sgZvlHk16pzYaYGG4=;
	b=DKaVTRNvXCzrZ+rfPqMa2LtjykOeqOSfisXBl3Joo0nqfNiNlA6xhZ5YkOHjq89gYovPtu
	TCnAyKVAdX+/7HQNwqqByytO53AscIMPwFcfR49pV0J6xWsWMmumW9EeC2/xfqjGQP3C7S
	kqTctt+5Mf6gTqhiBbIzjHNqDUawV/0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-l4XGF-9iPvmeAPBMUQ-RhQ-1; Mon, 11 Aug 2025 08:48:29 -0400
X-MC-Unique: l4XGF-9iPvmeAPBMUQ-RhQ-1
X-Mimecast-MFC-AGG-ID: l4XGF-9iPvmeAPBMUQ-RhQ_1754916508
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4af199d0facso137300641cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754916508; x=1755521308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjrMZnWuasomCOeyOdrJf6baH8sgZvlHk16pzYaYGG4=;
        b=hquNBXqS+IN+Q9o2RFR1Ud+7R34GDwoKSfOVBx8DRLFtGZOH3SHajW4FA/zOGOT3+2
         V3vSWNoUopUdWGirijPeMcrev5mEbM3Oqzc/46RD+bZW4QakzjnAMLyWv4HiOWkla44A
         36xtVNgqKxYUG+00ArRkJCVeFErGQFYbFxC2zI1Z+Nh2HSYoq5RIeyMdpCiNGiCx3A+5
         wTpZ51cpc+AMyK3AdVosS6REX2UlQws6aIeRk9alyAbfuyK11vXcMgP5/MLsBoXBs4AD
         7fMqavGqlFJ6h0+IK+eeDR1fZk42ErfWabl+vt8QM5o4msOYLqEV3FJz9GlvZGD49unH
         aErA==
X-Forwarded-Encrypted: i=1; AJvYcCW+NqyQ7IgBkhYJxfr0Bze+iJR0wnOlLbYWuq3YI3aInb+3meGrjt2Dzmsf5m6p2HwpE1KnML+32j83L/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVh9W3X4iRJaDTnxmvypfwmOTPGhvH/R7qmecKtOeXgV8lTO2H
	SGWMxmlS0gyRMxTeKhnswA3PkeTN6nkK9IuEBKKssFRFlw0EcCZYPObRsSg8uy0J+1XUJI6fwmK
	6EADGAtZ0mWoMRk6e6FTeApMB1nThL2BfG/uIA5wF2KB9YATfx8ug5cx9AzpSvTCdfA==
X-Gm-Gg: ASbGncsdqP6/whMbGgd4VjZazx9Tslo7bYCi0eKI72NjwRSRCxhCThWF8P9WWSUfV8A
	k9pBWvE1Ee4Ee/xOj1xfSfIJMdNHeJPl3MOE3HJeYhh/ERWmpgBTCooWUgAU9T/0razwZ3Myw0T
	jUHEfO3YuofV4qBD9XZunBPxUG3ONlNL4My2/788MjyCVWMNqJjqBlH6kf7xMsQE146aKDPqE9F
	4wJaMTzLkHhMnEcR/AzCquGIQWO6Qop/X0cPqUwHQNjwj5ejjCGoBu1n3g+VSsNRvdbazttyn1n
	+mKOj+CUsAcmrT9FWkfngYqCFRVVmcd+KoQ6qyLVkwDRYTQwmnLnN2HHLSerVM7Yht/ELQZ8+r4
	JzAk=
X-Received: by 2002:a05:622a:1347:b0:4b0:62c6:74c3 with SMTP id d75a77b69052e-4b0a081698bmr223865781cf.22.1754916508379;
        Mon, 11 Aug 2025 05:48:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ6N8H2X/Bvn+Au+kqGnuF5oeyYWPX+3WMtIqSB8DTDsMJq8v6IX3eOUhsgPzL8VhHHDNq8g==
X-Received: by 2002:a05:622a:1347:b0:4b0:62c6:74c3 with SMTP id d75a77b69052e-4b0a081698bmr223865281cf.22.1754916507766;
        Mon, 11 Aug 2025 05:48:27 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aef746b6efsm138724001cf.15.2025.08.11.05.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 05:48:26 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Mon, 11 Aug 2025 08:48:06 -0400
Subject: [PATCH 1/7] clk: ti: dpll: remove round_rate() in favor of
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-b4-clk-ti-round-rate-v1-1-cc0840594a49@redhat.com>
References: <20250811-b4-clk-ti-round-rate-v1-0-cc0840594a49@redhat.com>
In-Reply-To: <20250811-b4-clk-ti-round-rate-v1-0-cc0840594a49@redhat.com>
To: Tero Kristo <kristo@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754916502; l=2854;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=797B/i7zAYqS3C3fUwjFhBm7v2UlPo/3f5vR7+9WseU=;
 b=f6AxDfpy+RCAm2k48bLMU6hHsZhiIhyDPP0Xu8DVBbm+SnUO1/phMmAPOVEmJhxdvCZ+PrTeV
 420mVDpwyjfC9nn3pdrhSYEiP3VtgDwWcEOhdEyNFp3IV+ZmVRFc1tT
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

This driver implements both the determine_rate() and round_rate() clk
ops, and the round_rate() clk ops is deprecated. When both are defined,
clk_core_determine_round_nolock() from the clk core will only use the
determine_rate() clk ops, so let's remove the round_rate() clk ops since
it's unused.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/ti/dpll.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 3386bd1903df6d6cc443c9e087497167682da8c4..1f55554e0d73ca0323459e8823125b22623ae4a9 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -25,7 +25,6 @@ static const struct clk_ops dpll_m4xen_ck_ops = {
 	.enable		= &omap3_noncore_dpll_enable,
 	.disable	= &omap3_noncore_dpll_disable,
 	.recalc_rate	= &omap4_dpll_regm4xen_recalc,
-	.round_rate	= &omap4_dpll_regm4xen_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
 	.set_parent	= &omap3_noncore_dpll_set_parent,
 	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
@@ -48,7 +47,6 @@ static const struct clk_ops dpll_ck_ops = {
 	.enable		= &omap3_noncore_dpll_enable,
 	.disable	= &omap3_noncore_dpll_disable,
 	.recalc_rate	= &omap3_dpll_recalc,
-	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
 	.set_parent	= &omap3_noncore_dpll_set_parent,
 	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
@@ -61,7 +59,6 @@ static const struct clk_ops dpll_ck_ops = {
 static const struct clk_ops dpll_no_gate_ck_ops = {
 	.recalc_rate	= &omap3_dpll_recalc,
 	.get_parent	= &omap2_init_dpll_parent,
-	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
 	.set_parent	= &omap3_noncore_dpll_set_parent,
 	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
@@ -103,7 +100,6 @@ static const struct clk_ops omap3_dpll_ck_ops = {
 	.set_parent	= &omap3_noncore_dpll_set_parent,
 	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
 	.determine_rate	= &omap3_noncore_dpll_determine_rate,
-	.round_rate	= &omap2_dpll_round_rate,
 };
 
 static const struct clk_ops omap3_dpll5_ck_ops = {
@@ -115,7 +111,6 @@ static const struct clk_ops omap3_dpll5_ck_ops = {
 	.set_parent	= &omap3_noncore_dpll_set_parent,
 	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
 	.determine_rate	= &omap3_noncore_dpll_determine_rate,
-	.round_rate	= &omap2_dpll_round_rate,
 };
 
 static const struct clk_ops omap3_dpll_per_ck_ops = {
@@ -127,7 +122,6 @@ static const struct clk_ops omap3_dpll_per_ck_ops = {
 	.set_parent	= &omap3_noncore_dpll_set_parent,
 	.set_rate_and_parent	= &omap3_dpll4_set_rate_and_parent,
 	.determine_rate	= &omap3_noncore_dpll_determine_rate,
-	.round_rate	= &omap2_dpll_round_rate,
 };
 #endif
 

-- 
2.50.1


