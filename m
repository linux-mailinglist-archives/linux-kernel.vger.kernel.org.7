Return-Path: <linux-kernel+bounces-828859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C47B95AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6251C167F66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BFA321F3A;
	Tue, 23 Sep 2025 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="peVkHwHB"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9630DD0B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626926; cv=none; b=GoGwhmi87aPp/Yet6C0rBY/9Maxqf15GqGUHJIKVPpG9aitF0emkiQiuaIvddKNHIEC4jiyTeZJ+WMexrZdycSK/uu3BAbKywbsAC2BUIOXB9Klab+En9EvVdnQWwvPdCIlGQSX8axWYzPPQyMxdTOsHlNdG85m0Z0adanR7E9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626926; c=relaxed/simple;
	bh=Fg9loJYTcGYlx0MTZ4vFLQtkph2uQSlIxlL1lZRCrKo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t9yjRctDo73I1mnf6Czr/zPXBwO1TdoiWYYutI6N21auA+1ypTFy2LDdFLj+oQaSRDlGC6riiz3hW+kR687HjFHJOcvAA80ZFoalNEVY3lthmqtwAkCKb5cXDLvp+3DTkVtqHXHm7/6uktlyBA4OKxUQ8eo4iymB5hb05ikPv7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=peVkHwHB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3f1153f4254so1795364f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758626923; x=1759231723; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3nLbAifVjvlMsTe05tZfwI7NIrolTzFIj3PkRr+oLU=;
        b=peVkHwHBt0/q22w/jyzHTnWjgKqW6VyEPmt9TnZJT2ZaVvqMTS1bGhHPERAky601YQ
         f4U7VbynEit/PxiEEatHQw4eQmqfH+5BD1WJkFUEvCHpwBuRJISAa1lSIs/iPDGG9v0Z
         Z1QIsF7rhKfE1XwSPq9WHnpLjiju1D5s8XmtNeSC9iyAtGOiQRxNf/rcAltnOkhNo1y2
         S/6yXY2xOyLHLNVSL36ix1pDyxlWtcAfBzkFkJHoU/GqYE1VVot05WF03S7pNrQmrMrc
         Hz5CgelKN6OW2dkpgCnl+xEg877WipbPuAZ0UjGOzu1CmlZI90u7/iPhbSlGcZ1wBp+F
         nTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626923; x=1759231723;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3nLbAifVjvlMsTe05tZfwI7NIrolTzFIj3PkRr+oLU=;
        b=xSmAZ11+eQsLwunB0xGPhQNOt6J5MMtwcGO9tWLQYHsJfVstrEKxwdiRfcLnP6CHM/
         bqoIE00F4mVI8fpeRVNiPjQmPvitbwKXaaUr3OC5FnT79Gt/mN6JfI0CzOQhwdyqi2g1
         O/BDxVC3rfOS9VKAQcKwgiVp2Li2c2O3Bqyq1nz5U8VrZB31uuJ0baCREq05BI8i0UB+
         n2EfsMARSART2VlJ340ZFhE/O5xfd0dRKYGYZhnugYwm5DjUt3S3vJ64bjoC2xEQXIf+
         7WseNPMnAm0eloWULdaevVODGN8wEo7/E12uy7bv6b77aN1aA7WJHhTHUzIkgllORUeK
         hPog==
X-Forwarded-Encrypted: i=1; AJvYcCVRwhk4zBbFZM20NWy58DoYoEkTlcBa/DdiyQKcImFOm66Qt17aM17UPmHn1YlBvH9BpXajNfWjRrnW2HA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5DtJTa/YZpMbqve6vYeTYGVkOgenTqhMyTwWAU+kXAZYf5gkP
	etDOaPzMDTr3Xaq+nccNExwOjr6y8Bkjca/3XCQKsH06ZYmSaN4deTmqijhoSgNqWRQ=
X-Gm-Gg: ASbGncskWscG5d1STg3NiGoKO255MbK4qB7SewpPAKKhZ7znMvPwnR2BBnd17rYbV/Z
	U4OXjRA5AePsn1N+AqbC31PRntoWxaBAHeqGE1fhuE3+Xl7mZhqubZILy1ryjcHA4YSCx38Kafe
	Atpf528+Y3ejSxogzP+L9CJmkUFgl13qxdSCsL7Bg2kyVIlkgkxDKzV0pX8+wiSHrrqg9wUB+sG
	4lbdJuftxZ0Zl4pWY1LKsx/RyOdg9s3/GuNNG1H3BXhvRH9hFG9gF4u+WlYDbitFPWxZfUNP4FU
	1Q1mZRaZMHNz8stIAfWTElO0p4e7BXU1k50rm2t7aFbmjHkPMDlszBsv0BSZAlIghjAh5yUExJQ
	GjGd4gH9dQPhlYmHhKUyBGM5ZV2l1
X-Google-Smtp-Source: AGHT+IEreieYRZZVcV4W0b1/dif/w7q6qOys4eC2iEOI56szcrpHxrUi/D3jSCJ+aNlIHebwRh6vfA==
X-Received: by 2002:a5d:5f87:0:b0:3ff:d5c5:6b03 with SMTP id ffacd0b85a97d-405ca770ea6mr1817809f8f.35.1758626922991;
        Tue, 23 Sep 2025 04:28:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee0fbf1d35sm25228491f8f.55.2025.09.23.04.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:28:42 -0700 (PDT)
Date: Tue, 23 Sep 2025 14:28:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] ASoC: codecs: wcd-common: fix signedness bug in
 wcd_dt_parse_micbias_info()
Message-ID: <aNKEZ3VqJ8js208v@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The error handling does not work because common->micb_vout[] is an array
of u32.  We need a signed variable to store negative error codes.

Fixes: 4f16b6351bbf ("ASoC: codecs: wcd: add common helper for wcd codecs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/codecs/wcd-common.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wcd-common.c b/sound/soc/codecs/wcd-common.c
index 9bbfda828377..9016e974582f 100644
--- a/sound/soc/codecs/wcd-common.c
+++ b/sound/soc/codecs/wcd-common.c
@@ -62,12 +62,13 @@ static int wcd_get_micbias_val(struct device *dev, int micb_num, u32 *micb_mv)
 
 int wcd_dt_parse_micbias_info(struct wcd_common *common)
 {
-	int i;
+	int ret, i;
 
 	for (i = 0; i < common->max_bias; i++) {
-		common->micb_vout[i] = wcd_get_micbias_val(common->dev, i + 1, &common->micb_mv[i]);
-		if (common->micb_vout[i] < 0)
-			return -EINVAL;
+		ret = wcd_get_micbias_val(common->dev, i + 1, &common->micb_mv[i]);
+		if (ret < 0)
+			return ret;
+		common->micb_vout[i] = ret;
 	}
 
 	return 0;
-- 
2.51.0


