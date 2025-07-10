Return-Path: <linux-kernel+bounces-726521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13949B00E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3265C3B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D3A2BEC45;
	Thu, 10 Jul 2025 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXb1I+A/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1B029E0E4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183955; cv=none; b=A4wIVCVfsCdYEjXLKVuGHRpAb1Dz4SO0fk72R/urbs3wO1UX6gySgmC5IfAZd9/lIFR08N/sQ2G5ow5x2CdGFKGBnsO2FkHEvKUk580n6PaPf0HalKI+uMis0OrCJCiilntfeYLkkJLzlBhsQ8gabZ2B/Sl9vzibXnRz9xTIM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183955; c=relaxed/simple;
	bh=g+Rr9YJF/IJHNNqn5Ts7X6CuYQgHeDHcghY0SbxnF7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fuhhVl1NtJvvhvkukr4Nmfav5RBrWZEG7MIAjM6ffz9PHVBS77+Xyve6tifqt3UwLefYrtULcjGvmxYgCUM7BV4wRa+2Vx9xCkBolq8emv3mzmRnxN2skYbOxpgVjY6GSr2fWl2+OHEX4mEKvNRZyiEdjr76AlKv5izsOUdEEHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eXb1I+A/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752183953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqPFMivkkxDCOaub9wGKuuvGzsTLzlki1gmCh/1JiW4=;
	b=eXb1I+A/xbeb3v/KmQTd/4+wbRt2C8YEzu3WUHhbGT+qEsLKct177cXStMcUHtY+/kr4Ic
	syRjGhwpzLKthcbMy+aThRutGe6cBABQrvh5w9BU1KCHoGfLpfnPhnA/ose/72xSUk8iyC
	M0LjgVowOBAErlpx1QBHXYEN0YpUEZI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-7gP25DCsPIOxZKO-cN9HEg-1; Thu, 10 Jul 2025 17:45:52 -0400
X-MC-Unique: 7gP25DCsPIOxZKO-cN9HEg-1
X-Mimecast-MFC-AGG-ID: 7gP25DCsPIOxZKO-cN9HEg_1752183951
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4139102c793so1367738b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752183950; x=1752788750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqPFMivkkxDCOaub9wGKuuvGzsTLzlki1gmCh/1JiW4=;
        b=lYVYZZ7eHzQg8G2j9NX2G7k3sBOH9HP77ab29d4lr5lD1HgvOB1x44dxwJucjpJhX/
         mP//vAM10QPfnDS8X/2ZZJgqevcc5WwC4BXmbAaHfMHKQpQhxXoRLRjOPHs7UqKqqwMj
         hOOSDahoI1v+FIxCbQJV6hcS0Oaknr5m7VJfe6IZfhONsZAVxuOV0TZV4SrqkiD/YIpM
         ZLo3sSQCFnnhg2vpDpkGVtsQ/C0y22j3IOuoz3oRgdLTCuo9t/8/lEMPRqa0S7nWk0I6
         t+VV5bCK7sFJdN8DXV+4n4bSWEVbT57L/4Kd1KRshS12IBlMGtyIPPmDJLwUTfp1KqiO
         VaTg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ/23lS1P8dsLnzfat/sCPOKwHf98l14PkB90jwVaZu/TnIN2310nAvNVSlBGIwDkjZ3WkuioLk1+f0Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtg6jnjUlTyotCpGa+l8NOBgdTltoKIxEQYT1d11cgS8o0jGR3
	C1Cxbc5Lt5AEVexcGf3ntauhjJn4ZunlsMApteC8nAth0CsV4SCCeVK0kRK0kgwFn7wP5ypg+kE
	lnS3tlzpUOUrvtJ1X1tZiKZcK6waKgct6FgHLPnFBr7sDfdgy9ZxFGmZmmKAzfD1oIHdfSUJijm
	faNGK2ju5zxOvHInrUaYPZls8/wlcK517HX69YkT6vWJgsN6c7ryk=
X-Gm-Gg: ASbGncufkzhZVyMmEuZ6kdPxjqAWRkoqVscgKwc91zqE9dxX2meqmcAT4dkbKZSm58D
	j2xnBUOKZ47Jlp4L4G4ow08+/Ijk9vHuKfjyncENUfgbuA9nHYVcbLxmpnU1fGj/SvAdW1EqIta
	CymUVx/a/uWZe0kGnky4A/B6jgcxVa3fJpgKkRbrEZFFbNoeYLovz0bEOKihGBcPm0PtA9GRIjL
	Fx/YwrP1pITNNg+eVRJI81eFdy+GxizdaQEFTU9yRb4YBHBuEm4JGJXCuFYWRFvYNuDMGjwoHTf
	YqNZpY7CDO1FFHM2UxAlpPwZZXXGzzxm2BX6gS/53wax
X-Received: by 2002:a05:6808:23d2:b0:40b:2d38:e8a4 with SMTP id 5614622812f47-41539d97367mr381832b6e.30.1752183950651;
        Thu, 10 Jul 2025 14:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWRtZWye+WvsiWpUjSD6HA2ojrPOsrb25EBqrMr3mmCi1XL3FXlFKuxXiCK8G3yi3fRSP7OQ==
X-Received: by 2002:a05:6808:23d2:b0:40b:2d38:e8a4 with SMTP id 5614622812f47-41539d97367mr381810b6e.30.1752183950275;
        Thu, 10 Jul 2025 14:45:50 -0700 (PDT)
Received: from [10.144.155.224] ([2600:382:8102:a87a:c1c4:9ad5:f0c:c0f7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41419baa00dsm345483b6e.22.2025.07.10.14.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:45:49 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 17:45:15 -0400
Subject: [PATCH 3/6] clk: tegra: periph: divider: convert from round_rate()
 to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-clk-tegra-round-rate-v1-3-e48ac3df4279@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752183937; l=1186;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=g+Rr9YJF/IJHNNqn5Ts7X6CuYQgHeDHcghY0SbxnF7Y=;
 b=25yPFhayTxvRCgxM2jMj5FL+ku9ZTaEWwWbBzThJCxpVzKtij7A6jKLX8tv/Kw9S7GDoOHRRw
 6t95b8gXYloCESNIeKYKrzuVZ/JyVWi4igz3p0a1pdChn58PFeX810J
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
index 0626650a7011cc877c084fd93ba961c6fbd311cc..5b81b3c34766a8d80ff2273ea2fc08e988ee14ff 100644
--- a/drivers/clk/tegra/clk-periph.c
+++ b/drivers/clk/tegra/clk-periph.c
@@ -51,16 +51,10 @@ static int clk_periph_determine_rate(struct clk_hw *hw,
 	struct tegra_clk_periph *periph = to_clk_periph(hw);
 	const struct clk_ops *div_ops = periph->div_ops;
 	struct clk_hw *div_hw = &periph->divider.hw;
-	unsigned long rate;
 
 	__clk_hw_set_clk(div_hw, hw);
 
-	rate = div_ops->round_rate(div_hw, req->rate, &req->best_parent_rate);
-	if (rate < 0)
-		return rate;
-
-	req->rate = rate;
-	return 0;
+	return div_ops->determine_rate(div_hw, req);
 }
 
 static int clk_periph_set_rate(struct clk_hw *hw, unsigned long rate,

-- 
2.50.0


