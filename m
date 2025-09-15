Return-Path: <linux-kernel+bounces-817890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF7DB58827
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE13916775C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368C12D7DE2;
	Mon, 15 Sep 2025 23:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D7h5B75/"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBA928031D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757978479; cv=none; b=Gq/sb6D1a3LxrTz9e77SXtf6MERtvudynhIzn91GzGNlAKALvzsTsjmyNHFd7D6zrMsUFdpEzseNtsh2LS4TqY2YyZ07D0tjVRKsreJHtdVkxn//foo5p0q8nW3D7eRv9Uuv+0HTyR2oZFGmN3Mrjrv5dOS3SVGzpmNWVD8f27E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757978479; c=relaxed/simple;
	bh=QjptKauox/zh/yVRJgItfD+1SMNcMuOHhIn0e1+Z9Mc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BLnx/JR7llDMDuOu7za+81ft7kFLvCBIVe04JnPBRZj2r4DntdcHYPrPIWgdIhqGTrSKSORmwgJvxxi8xuzsK2/D/LRsp1ysJ8H8K1Z/3KcmPULY2EZil+6TanIW8f2ADMvyr+PBeTHIQ4jSHiTy1bfeIIsS/5HSnrqZlhMWRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D7h5B75/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-25669596921so48716355ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757978477; x=1758583277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgsUeyln5jHJQtg6nGIuuJa3omU5ijeYPDC8tIR2gz0=;
        b=D7h5B75/JCdJbzyIf9m3bofYjEMIvzT38rcyTG2tKOWMIB829e5ldJZMKo8cizLcul
         okswZh/T+GMZ1IeMF0Gs+S2yQ6M/zMI5AXe5tlLAE6D+Jfm3Qz+mZkL7PwOvNUD0zbwg
         1xKmiTdN4EZIY0cooT+st3eRNp568XFIVFtAjvWapjh1yGFlHSkEcJBm5jNPuD46DK7C
         JaOm9QJH7vLQB1bsRFa8Lqx/ZV54LxTKERel0yTI+L2wHU+2+wk8U6b9ty+Sytx0lxZt
         l2RPuOyPsn4EOQAZ0usjyGrmfOarWsLUX0KeSE8Rfx4XbRUx6umdgkT9k8RHnjX2z31Q
         A9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757978477; x=1758583277;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgsUeyln5jHJQtg6nGIuuJa3omU5ijeYPDC8tIR2gz0=;
        b=W46ir7ytU3atSaeBm1lHmHnS5L1HzLVcPh4qdfm1t2eINGYdUPy1OYxFpSEOOwTKs3
         rjrtSxZYOyXJlEYDCO5wDdihb9ei6e5dl6H0OeIm+EmQk+8XzajmWi4AOw2yf/qPEje4
         1n6HEEJkxzzjbYMznn3ByvveTC0Edlswm3J4kYZtCZx2FGb37T5EkVNygQ/8rQTEch2x
         PjoBPqJIb/298a5BvEdKotQsmCOMm48F6Tt6pt9JDi73x+JPeN/Njq3fAiN9HIHZTunJ
         nUZv78sKWdmn8VVcirxRtgPRQgeZyk0Hbv4Y208s6xvF+fO431g0ZXpk7sFmtyxsziex
         QhZw==
X-Forwarded-Encrypted: i=1; AJvYcCWUiD8bjJ/5ruZwcD8+Kkk23qPoF8UPySuiCmB2dsOpcpOG7q8o2EupkkdXqXHEPI2uCKBhnUHXBukxpr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa0dQpZuqQF8bSd8yKxZzeir+qalV1meWkc9Lb8p1lZURniptS
	cTSMzt3dPScNh9eEXmBzIE1+ObClyl/jErpXNRsReZEJZSmVJBDrRstI59DSN18yyUQ=
X-Gm-Gg: ASbGncsjrnhQxcFLSGCca3uF0PraTg8l7JS919uHEDF1KAvCEgEpCf0fFs07Y2uK6kM
	nfppTyQpvtw81bfZuxDa46oRb94Vx5Q9T8NLbuI3xvUKOdqUF7xvPURZAopKG0Z6jSH1behnJId
	pbX7fk1FEyd91DElIsLXb7oGIWeJN+zJb0ca7qYfle1iRmf2Cr+4WeAUolfz/4UcCpE/+VNiiX3
	O5EtkJg/+X06GG1LvI7go5emSHjoNR8ody5f4X53i5pOJgzQgxZTUGWwTmgvY+ARp2YjY64Lfz1
	CG9KUjr08ZYHLonpCQcuwSLNH6UdjKox8ONWcYf7PU83IBCkXnRorzkR07Xz11fzn86bUWX4guX
	19yxcxK0iLVENe+e4tLDtrS8bIxrG1no=
X-Google-Smtp-Source: AGHT+IEMv8jBnfBFpzOj2tDIE4OBC2iZqPmVd1ibS2mAaD25rPyFSdy7EKxeRUd8V1wYJ+kr0edLjQ==
X-Received: by 2002:a17:903:3888:b0:24c:cc32:788b with SMTP id d9443c01a7336-25d243e7b4cmr166970205ad.3.1757978476693;
        Mon, 15 Sep 2025 16:21:16 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b17c78sm14543629b3a.50.2025.09.15.16.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 16:21:16 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Liviu Dudau <liviu.dudau@arm.com>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney@redhat.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250710-arm32-clk-round-rate-v1-0-a9146b77aca9@redhat.com>
References: <20250710-arm32-clk-round-rate-v1-0-a9146b77aca9@redhat.com>
Subject: Re: (subset) [PATCH 0/3] ARM: convert from clk round_rate() to
 determine_rate()
Message-Id: <175797847576.2104956.7606973558357095186.b4-ty@baylibre.com>
Date: Mon, 15 Sep 2025 16:21:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Thu, 10 Jul 2025 19:42:15 -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated in the clk framework in favor
> of the determine_rate() clk ops, so let's go ahead and convert the
> drivers in the arm32 subsystem using the Coccinelle semantic patch
> posted below. I did a few minor cosmetic cleanups of the code in a
> few cases.
> 
> Coccinelle semantic patch:
> 
> [...]

Applied, thanks!

[1/3] ARM: OMAP1: clock: convert from round_rate() to determine_rate()
      commit: e2c0510935c5485a2dacfd13af3958536b9d138b
[2/3] ARM: OMAP2+: clock: convert from round_rate() to determine_rate()
      commit: bb676996ed583464504123721195e98a708fbba9

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


