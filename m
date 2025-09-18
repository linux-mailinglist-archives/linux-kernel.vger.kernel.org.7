Return-Path: <linux-kernel+bounces-822446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0382CB83E76
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882D21C00919
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAC029B8EF;
	Thu, 18 Sep 2025 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nmXz/eGo"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55531280A5A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188926; cv=none; b=WisUJ0Mbig31Exhgya2vu8bise31cyl2wFwWwBPkYgPElB+GBM+Wm2aJtR3awMl06smeTVh+jb09MI2SOuxiJESkMt4BUNO4NGYha9PJS7JNkqJveC0If4AXz3U4H6lz42T82wQkrs4RP5wxSiJBCIl507nZT1/6xcnbmPbUUac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188926; c=relaxed/simple;
	bh=0C7LmroulnQm3ejlkogQJtKgQjdt7LnVORSSrGcSY6M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pde6t7TXUDctpqowl8pta9ia+uERsh0SqySig6bICSDQcsQEVcpekf6KYjn6SyEKkVjnswI1xB7H/znjRZ6LxeOs5UAva569wO3oJdxMWlE4c8XeRpi3RJvrFu10wVBcMtCNCSynR2jL1mIrK0CYcYtGSAKCU0GBXBIpThWZOKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nmXz/eGo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3eb3f05c35bso515628f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758188923; x=1758793723; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06wbCj7T4/WJAogV/vIy3oYzYPcgpMS/viJuMyneRkM=;
        b=nmXz/eGoYf3IJ/4rN7s3G3sW12bGAzTbpcSGkRw8glQ20aBAtOgn+M/X7YWFNsEljw
         t0Pd+jDKk48mWknMzslmUpvLrvQoxtfj8f2Q1E1QobHASJ9FdcomGkYFy5e6hDKH1LEE
         AzX1IccPZhXPgmtQxLld3c7NvNhbhc137LdQsVfxsNUiZEAplxpMrgi2G/DTAQElqJ1w
         AcZVL+D5IFSmkc3vyeWAyfhq4R8WVxoSEFyH/1HQN5qwqCgA3hVjp9/K9brGjkdzQEcb
         TwC4U5SxuzivjVIydlOemRzjkzuOto8SsNkax5iHog+4iXcxIkIsG8uoR6PBFgPz/ONW
         uVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758188923; x=1758793723;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06wbCj7T4/WJAogV/vIy3oYzYPcgpMS/viJuMyneRkM=;
        b=ozJYiyJDgNK5NhvV0VDuDB4hz7bSdIMMZKLdbIgjsAeihUobCcO5apTYokzX/Ip0aq
         z1Br113kg5DDqO0cY/OyIxBjw+77b+lX3SjERUIgzrwo3208Y1GRadNWlHWPe57LUPS1
         rjfHFyH3CGIwcDkpdKRjLfd+gP0D2yrQfA5KNXJX4IiQGhOxD+cZgFDYni/kFW6oTbzp
         S3FI8nwFU0iI2m7FacfFBzkqiSIw+5NX5VNQr3HnjIYggVVLpAcPwx+YDQ0BHIcW+6TI
         HWUWYvXko6U17kFt7fmFg4P2Kvaz5XLIlBwPRliTy//m8zHWXpO9Uik36tZcUbKAR1JI
         t/vA==
X-Forwarded-Encrypted: i=1; AJvYcCWcvjKcHwUagYasL714BgJ6FM0VEu5lDrIjkL4T1TslZQWzQM79WS4SLcVs00iAdLjZYdNu6z1nTgXSUh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3T3UnBm9iZbCulAPoNSdktF9Fl8Blx6+fy3ohrHSFZsbIK/Fw
	fglqaT/GCYUmJ3bA4ByI51XrYiN8wMTjyNLPeLY5DRZWHMnKt2l6wa5Y88YvslSmz9acFuoKahq
	ZmnxJ
X-Gm-Gg: ASbGncsK7DMJtZgPoH/tkNR7EsVbch5EYDzsWdRjNXw2iafWoTeLKTbuy7E7luuBGgQ
	OxbIYqJKoaVSWCk2apLPAfSYOsnZ7R1kxrX/dxrpVMwYpPHA7rWP/ALAsVgdsPKcACcSrfb9sro
	Ss9Os5dXOVV7302Ue2e5TYj7emeXzG/lQe0qXkO3/1e2UdgaGsZzdub838cyTM7E3AETUB6mxNt
	u6sn7fRJDl9gA2p/U/OpogkBavoj0jDtafIor68WyG4LaltPeY7l9xOvBuPvKaW+rkOQZgfjV6m
	GSZp61DNq9BuNCJBi3GUIL241XlU3SvDntFvnAqIaP9NpD+c9rWbUZxxJd73qJACicQFf7yB/AZ
	8UXqquDRHrhbWqJLvbftCRib3cLHnh27bJOozyABe4bnQGQ==
X-Google-Smtp-Source: AGHT+IHsyTQToKrNv/Eu1x4jWbOyj18f48ucisBaG0sk965vANcxGhm40GwNlwjKITJGgWyx59hCAw==
X-Received: by 2002:a5d:508f:0:b0:3ec:e226:d458 with SMTP id ffacd0b85a97d-3ece226d48dmr3029498f8f.0.1758188922699;
        Thu, 18 Sep 2025 02:48:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-464f5a281f1sm33543215e9.17.2025.09.18.02.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:48:42 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:48:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH 0/2] rtc: optee: Fix a couple error codes
Message-ID: <cover.1758182509.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix a couple error codes detected by Smatch.

Dan Carpenter (2):
  rtc: optee: fix error code in probe()
  rtc: optee: Fix error code in optee_rtc_read_alarm()

 drivers/rtc/rtc-optee.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.51.0


