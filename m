Return-Path: <linux-kernel+bounces-798932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96797B424D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3509B18851F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1416226CEB;
	Wed,  3 Sep 2025 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2Pe8HTv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F132264C9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912535; cv=none; b=ZJJpBwuzsg+TTIJrY4qxQ50pUyqqiQ3zNo796QnzVGW8wa7I5Pt8HS3uFVt8nGPhwlhzexN058Dmv+NoMOXCxRxhS884MFeySmgDKdSLlSl3ZexuX8wyNofh9+l+KQ3cpvu5BraTQrdhv3L3FY5dBkHUsAM8Hy7BXQKreuFkw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912535; c=relaxed/simple;
	bh=PJVq4/87gTFJLoaD4HfGqwXTByrz5pGbdwRq3T0o3FM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mZ7F6DLZH9XuqRDVCHj5u/m/QVVSIM1zHNASAVEcJqU/YGV0IXxZ1ZRSmiixtvSjnlEwnlQMBOp7rly/BQOpAP1S//pXngWDWgWE5aX2gjBU4z7IFL8HcM0Yr2xKuJQQwyfsXX3zkouIcfmq67gJM81aJcLRpviJAhUyDW09Dx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2Pe8HTv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756912533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0AC2DCErmz+n/xWKWMBVqT/GGNRgWxc5CPFdstVaL8=;
	b=J2Pe8HTvQFN6DOGd72cTfsjnOHdr44ipRSTx2TuIp3UMrgioY6PQlrnRNrMuSGaM0ebVTk
	Ek3J0sFCFmQKeayvZ0CKL8sSeMTF3eMvT98rklRZwD8w+7+j3QRZ8dNBAgIjlAa+xKIwcU
	zJ1eLVESRWgT1kWaAoC6uPy4gBt9EtA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-VbCmbsblPxqqW2F8770PFw-1; Wed, 03 Sep 2025 11:15:32 -0400
X-MC-Unique: VbCmbsblPxqqW2F8770PFw-1
X-Mimecast-MFC-AGG-ID: VbCmbsblPxqqW2F8770PFw_1756912531
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70dfd87a763so76527806d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912530; x=1757517330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0AC2DCErmz+n/xWKWMBVqT/GGNRgWxc5CPFdstVaL8=;
        b=rsRLS0jlFANCixSpVnt562LsZbpkMNjo7AK/8fZmQZKWPd2gskEhd3CidNNnSrABeV
         b18xGWO4rEKKSu+ZUsdpTmoSnR0DwxbVud5EWboXyeztT4Zr8J6ZKToLZxVlMRO5BMXw
         KWVpVFZv4xnDJPM3TimbLEH5IyJtt3LkqfYgttU+obTABl8O04Q/7KOimmKMUrf3di1b
         rfnMJ/mOKIPzBtUvsHXxkCvIsQjESqYipcfcoxGKZlm359EKh4xV1aifOqvlaEYGFVJq
         AJt+KWU/1g6qUclFbZ/PKJDRIr+spP/LZBMW6CcdVPPNPOlttBckYbw9PkXJ0Rl2M+TG
         2LGA==
X-Forwarded-Encrypted: i=1; AJvYcCWZBvFSzV6wrQBQ+o3RVLO5eU9uW3jlg2wJFPxshMfgJNdy2ulujoeius8YW20PANP5jZgqyvmFPWHBAAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/sMGsNzQg6rWmR8ZuWldfoIT+swr4HRyaz5ny5g47kaaK9man
	7RaNCbjx0BO1VqoRUYtzWIHkSZEsKrp8oro+i899YkpR5KcKcMett/3/MMQ5jaYi4/6DYcuFvbT
	WKgnRZPf6L+nb3j5eT68xFYBXhQmt1d5BHr+LpO2YnJxpW8BUPoDDKSmh58fmiPBiGz1ZbRQadg
	==
X-Gm-Gg: ASbGncvCSXiBvsBnv+qa14BvB/aW3Fn6qmQoONV5E7ZS307T36OjsCW3tFN43/0bZaL
	8iWP/udUAhk4fNT1smt0tNAPKifkPeiO5U6WEHEkVzJjl4q4KNAAAW2h/JJUEFCy5EiClxDkG+s
	hJvL6tAJH2HpTl3Y8vwGxNCSIgcFe7gid1St7TgEuaxjFLcDAci7DvSMhWQnYZkzdD6mYZslb2L
	KPs1vCVbfu5u9WvrvIydj16/Mzhbiw6NR9OhZPTB6hTIaPTEqPs86ndm/YhEJ1P0iIzXPhWPxiH
	Gsjgmf9eMjIvuxU8cpQ04xRzCK6jGSVdAzx6pedB/ARROuHn5xoUoMvpwCzo7lDE6+gtrz5fDk4
	=
X-Received: by 2002:a0c:f083:0:20b0:726:97c8:a6b1 with SMTP id 6a1803df08f44-72697c8a854mr18870776d6.54.1756912529842;
        Wed, 03 Sep 2025 08:15:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED8E16uAVeM+5vJ137ALVYC0Wh9vbBPAcITc26atyl6FkjgZTLRJMpDAJJZtvLcuHhPJ8whg==
X-Received: by 2002:a0c:f083:0:20b0:726:97c8:a6b1 with SMTP id 6a1803df08f44-72697c8a854mr18870126d6.54.1756912529305;
        Wed, 03 Sep 2025 08:15:29 -0700 (PDT)
Received: from [10.12.114.224] ([2600:382:850c:786a:ff8e:13a:e47c:3472])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16de16sm30827706d6.3.2025.09.03.08.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:15:28 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Wed, 03 Sep 2025 11:15:03 -0400
Subject: [PATCH v2 2/6] clk: tegra: divider: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-clk-tegra-round-rate-v2-v2-2-3126d321d4e4@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756912523; l=2145;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=PJVq4/87gTFJLoaD4HfGqwXTByrz5pGbdwRq3T0o3FM=;
 b=j1kIFJz9wqZzE3zyvQjx9E1DS9XfHi59LnAkJFgAkMN4jfnDPzUCTDEe/f0U42GNwYY8e/rpk
 4odgRZo7fFfA9qPfKqfNveGuLPoi7WmNRviBXe3OJ7PGswYotuYAW0k
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Link: https://lore.kernel.org/r/20250710-clk-tegra-round-rate-v1-2-e48ac3df4279@redhat.com
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/tegra/clk-divider.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
index 38daf483ddf171293666cea25179a9c8809d8c3f..37439fcb3ac0dd9ff672a9e9339ed6d5429dabaf 100644
--- a/drivers/clk/tegra/clk-divider.c
+++ b/drivers/clk/tegra/clk-divider.c
@@ -58,23 +58,31 @@ static unsigned long clk_frac_div_recalc_rate(struct clk_hw *hw,
 	return rate;
 }
 
-static long clk_frac_div_round_rate(struct clk_hw *hw, unsigned long rate,
-				   unsigned long *prate)
+static int clk_frac_div_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
 	struct tegra_clk_frac_div *divider = to_clk_frac_div(hw);
 	int div, mul;
-	unsigned long output_rate = *prate;
+	unsigned long output_rate = req->best_parent_rate;
 
-	if (!rate)
-		return output_rate;
+	if (!req->rate) {
+		req->rate = output_rate;
 
-	div = get_div(divider, rate, output_rate);
-	if (div < 0)
-		return *prate;
+		return 0;
+	}
+
+	div = get_div(divider, req->rate, output_rate);
+	if (div < 0) {
+		req->rate = req->best_parent_rate;
+
+		return 0;
+	}
 
 	mul = get_mul(divider);
 
-	return DIV_ROUND_UP(output_rate * mul, div + mul);
+	req->rate = DIV_ROUND_UP(output_rate * mul, div + mul);
+
+	return 0;
 }
 
 static int clk_frac_div_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -127,7 +135,7 @@ static void clk_divider_restore_context(struct clk_hw *hw)
 const struct clk_ops tegra_clk_frac_div_ops = {
 	.recalc_rate = clk_frac_div_recalc_rate,
 	.set_rate = clk_frac_div_set_rate,
-	.round_rate = clk_frac_div_round_rate,
+	.determine_rate = clk_frac_div_determine_rate,
 	.restore_context = clk_divider_restore_context,
 };
 

-- 
2.50.1


