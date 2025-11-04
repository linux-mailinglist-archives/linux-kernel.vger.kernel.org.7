Return-Path: <linux-kernel+bounces-885014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8497C31BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2748D3A7E0E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFDC32F770;
	Tue,  4 Nov 2025 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViyCtEUl"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A469C335576
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268316; cv=none; b=kgI8/u4yZvA9Ly3X72v4lp6WLDtagxvSciqw231IjHU8wMDg85tHLCGhLi82eDLNz951Y87iHFByDaG4K6EUYcUUA4H8d+uxRAW4w9r0MNmkRgNqtV2DGh6NoNDpldsL90eeEFRA4lftNhAkW39Ouj9ifYXrh+utjJqc2kJnOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268316; c=relaxed/simple;
	bh=3S3vLJQnHmvWilF8Wd90CB2vFImWZrThbfrv7SlfrKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JbtRuwnqI/kjJV2ftRSp7+1equEgUvvmK78DIZPpHdd7qh8O7odzc3C1oLGdD7pksGP32JLQSEaPFxfFTQABgt4C80w2jAL4Fbu3yfNsixuCpai6vmXeL9ZvZ4h/72ZautsQ9C+iK2Z5mB8RdJfOO95oyh5PTWGpaY2ZYCZviuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViyCtEUl; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7042e50899so982887966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268312; x=1762873112; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XO+PI+vctgydxy3u8Ax9wXF6KiNkHmEcDhtdnRtl9xw=;
        b=ViyCtEUlI+YHMmqLGMp7Gl2BnevI3Vm8IPWAfvFj2wsWNr/SP6lXX8tUoItE990eJ9
         SKJI5SSP0WRhHBCkZsISjqsKHWND6m/Dwxg3Q929SVjXBtJKwcWHTdhDVyjlK1vqwgsV
         Q5QWz3zARpTM3T+GD3aFc+er/BEZN466dN4uLfm2JVTZWZnwvRE8D5/+A2WIRFCJunE+
         jDQmLcd3TXrCld4i/U+6umQEMSobBlHmVsdjGx0AoP469XTw1JXtIdx3lWwU91CZwY7P
         RK3FY+fV/U+cpR6Ps1YjYmU4AUw1piSHP22p91jV1ki4z60CcI41EUGXrSCWHt8TRL3F
         2p0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268312; x=1762873112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XO+PI+vctgydxy3u8Ax9wXF6KiNkHmEcDhtdnRtl9xw=;
        b=jLUYaG4yBYhV1rcpLClfY0X+y0MVOyXb+EycMGLUiBsKaOSFz/9ZWBOdicPdH9CUlz
         LoXipmHplcAYDronBOXXwypHy5mllaQP1cf8m9vxA3nZk5cxHQMCYsL27PQuOiW1gIR/
         o4rRGdpBaCSm2OPl9ccOxYnJVoC77OmNifar6BOMn/jJ5XdvTk51kcJ5y8e83NifTiuI
         hxQMbqg35xkLfFDghS1tRrdISlOg5JgJ9xohYn17XIzvPd6xCBYGj3zFtTbzxS/TwExY
         To71Dasl37Riiecgnxnm+eIi1hyb0L+HRFDdTymz14HsFKPJgfJa2VSILIXtc5PVP4KW
         WX1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIHq0GBxb2nffVzD013cd4Qh3JZavDIdyQ5n7eveGfKT/j0YxCERPTj7X33nkZ6GShVOp0BAaEScypEpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbse/TlTQW9XEHJI5Xr6YC9IfaQ0JeiPKcTDpm0FNsKpF+GteP
	w8O/PXaEs91CaABSYBaEnaC7geIJpOBiAEKIhNBUA/jxEit7T/UbdYJW
X-Gm-Gg: ASbGncs2VEcXmtiAMOP0XhyTxSZu3K89fLTFsERYMPVVbvLYW34wtUDrA3v3unMto8w
	h2TIg6kHaxf2ELYamDoaQg+y0d9mUJkaW+cmL+P1tROr8C3xJz7roa/8SUgDX+ne9FPac5YrPVA
	UJdTLf7WOHdAYDnyA9N307CCtQzLp/HE3O3bhuD39KUeI8mIQQbStqgoNcAsXW0umdOagLLT6yt
	txNlKsT48sJ9muS32Y4w/jPWQ7n7eBdSKNYjOwVYbe4wgSMMlp+RlYGsEPFQ2O+KebLvWccF9t6
	N3yvG3zM97YbNgnsW+G8SN+PwwIqsUqhxqYhOmW1gOmrYZMg0na/zns3xpAvpYtjjRoWBlI24YV
	ycoki3XkxF6/8E91BF9lo+NIN1csEv32VRVjSzOLegab6lggytIuk0A0Nvp9OHfcsHJEDxaKgFw
	LBVlPO+tf/p1pJ46oFhmb6L9MGSldUZVwUxZzXgn3nsNDming=
X-Google-Smtp-Source: AGHT+IHQM+ae/PtrcBYu/XEl+3c6meEt5NSkTaNxXmye33gFO7J/8CNzTF6Yj9O7hl9jP+R+gadKLQ==
X-Received: by 2002:a17:907:3d52:b0:b3b:4e6:46e6 with SMTP id a640c23a62f3a-b70700baa25mr1718403766b.1.1762268311405;
        Tue, 04 Nov 2025 06:58:31 -0800 (PST)
Received: from tablet.my.domain (83.21.17.47.ipv4.supernova.orange.pl. [83.21.17.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a7fcd7sm2288874a12.37.2025.11.04.06.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:58:31 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 04 Nov 2025 15:58:22 +0100
Subject: [PATCH RESEND v7 4/7] clk: bcm: kona: Make kona_peri_clk_ops const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-kona-bus-clock-v7-4-071002062659@gmail.com>
References: <20251104-kona-bus-clock-v7-0-071002062659@gmail.com>
In-Reply-To: <20251104-kona-bus-clock-v7-0-071002062659@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, 
 phone-devel@vger.kernel.org, Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=3S3vLJQnHmvWilF8Wd90CB2vFImWZrThbfrv7SlfrKc=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBpChSORxgQzf/ZL/gp2Ma8qyDv3uCNpyjt/zNPv
 EmKyvUGI4mJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaQoUjgAKCRCzu/ihE6BR
 aJ5zD/sHarUnmHEx9mOpGgkQj6JThv5bsoxJTyL7m9Lh425mb077Jhlo6Z/tsFSTtFt4iU6rRJd
 oZkGeqMN3R0V105KQrHLJU64qMwduP1y56Sj+Pw6GFRM+KEp6vGieizMW7Xx4iED3eIiRwhk7u6
 Q81J2e+mc3RJdm6uan1Zs7xq/4zZ3Svq+pnRbVRiBMVMKzMgEK7RfrxJctPIleJE2t7aFRrl/US
 zPEo+FghW5tLw/2lj4CQ71XlyMIo9ZcCDxvb4gH6qD542pBLb/omA275yOiyEYe/ORBY4i3WhLd
 G92AWkVJXxZ1E2/FCj7gu0l3NhfHEx4GO2k8dJu43Q/UkjGHfveQ9TcpJbIaOTRlPTBScfEKuFB
 bzslyURLmIOcK9/sjyQlVJgwj5StXbiqnJls/XI67aV43aPeC3VUTUzb9VRSQWvIh7dsu4faY5T
 3zgR+C8jVP8kUl4HY/mbCdRKFR5iEDeYIfe8+Migw3tVHBwQJ5L/hx5mQhv0Vm2sn5sy3KbOzyq
 xv4ghk6kB6IzmsiG8rJBpJpD/ZPWsBBwdq0g2u4sKc0tJsWP2CrhaO23jX8oUMSoPtpaDWhVaP6
 aSm01IaRqIYoscGsb3zk7Aqf4U7nPCO+YULFMQEdaxVa3i0peasQR3HVNbOORb01qog9otfXX3r
 IOsVFFcJT5jIelg==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Fix a warning raised by checkpatch about non-const clk_ops by making the
relevant struct const.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v6:
- Add this commit
---
 drivers/clk/bcm/clk-kona.c | 2 +-
 drivers/clk/bcm/clk-kona.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
index 0171e6b2bfca..2641eaa4ca52 100644
--- a/drivers/clk/bcm/clk-kona.c
+++ b/drivers/clk/bcm/clk-kona.c
@@ -1154,7 +1154,7 @@ static int kona_peri_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	return ret;
 }
 
-struct clk_ops kona_peri_clk_ops = {
+const struct clk_ops kona_peri_clk_ops = {
 	.enable = kona_peri_clk_enable,
 	.disable = kona_peri_clk_disable,
 	.is_enabled = kona_peri_clk_is_enabled,
diff --git a/drivers/clk/bcm/clk-kona.h b/drivers/clk/bcm/clk-kona.h
index d7cae437333c..7064ce316981 100644
--- a/drivers/clk/bcm/clk-kona.h
+++ b/drivers/clk/bcm/clk-kona.h
@@ -487,7 +487,7 @@ struct ccu_data {
 
 /* Exported globals */
 
-extern struct clk_ops kona_peri_clk_ops;
+extern const struct clk_ops kona_peri_clk_ops;
 
 /* Externally visible functions */
 

-- 
2.51.1


