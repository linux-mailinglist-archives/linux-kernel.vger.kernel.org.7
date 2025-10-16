Return-Path: <linux-kernel+bounces-856348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F0DBE3ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F871A64F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD78733EB1B;
	Thu, 16 Oct 2025 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AWv458Cb"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85735306B33
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625278; cv=none; b=LwO0rFYXQ3Lhbzt6TYtqPfamgtdz3yGqv411UbxEIvCYC/uvaNIKGvNTwWPaebEybBWpk+dl+Y+R5zX0BZIFGof6GM8ncZM/xvoBS4jIYEoNV8DBdWx7j2OSLTYtYu4WHg/UNyYA7LbNO0KIw7NzA4CLbLATOLStTk+ti4BE9HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625278; c=relaxed/simple;
	bh=JSthpwSFeIt4qjS3RetjbUcoI5Cc07pvY5ek65QVrc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KW1Fclao0z1+uXfEPlCTGHSJ3EumlYKbL+asXtwXLWu+pBHpfooBelMIlCbivIdWOr7o8xhHE3yVq54HU8a+/p/5jwhhnvkMMXCRer1mAlLL+dYGW8KtrlkTODcS81Q8/Nuk0LSLz34S3U1PBBCmy0+V0CQ5SMfzahuYNUyJyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AWv458Cb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47100eae3e5so8278495e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760625275; x=1761230075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8VSC6HDGAFC0rsKl6H0hRnSmQPRXnaQjH3ssPLdIg4=;
        b=AWv458CbmaSFhbVunBi3Qm0QI+eKZoA6tcLWJwVzkC7ecL+SG9sBONWEcIlf3TdU/u
         e1hKQuBDz5TkWmVO8dhJM8wSocP6TbnmuuNM5x86pq3nTjoxgBxmhCfaxeNk2nw5fRrU
         Q21Ake2fpBZFMLkzfolyIFatlNswwkd25+76lLDLWncFGhgxVU2+m7twGsB5AKukpn8t
         uwGLoMvgKo0n2JCmg03JN0NJPVjhHd4EwxP7hu0pC2B1A0qoTa9vBh3toSa+pDZSi/nH
         6OuC5dRUKQTK/eBJ2AgXNgH32kEpWYZ/FEAxlTOBUToDexe2nvP3XWUrJAFZJH+poA0G
         MNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760625275; x=1761230075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8VSC6HDGAFC0rsKl6H0hRnSmQPRXnaQjH3ssPLdIg4=;
        b=ncf17O0taVDjhFNub5tJGiUHzoQZ4/4pvCEmmdNpq5bJqqhgzDoFpjhMXJslqplvlk
         V7CVWxGQ2zJ9FCbVuFwbbz/F88dFc5U4sKvBL/4/c+oLXzqf8LwoBi4vnatpao+bTpqd
         /KbG30VEkuAJlkz/awzbeRWGvtPtpSekE65ZvvNMdq7sBF5Brk2TpfWZE6Xv3R4oqfG0
         2Ykvi0ihZYDVjFM5OZVjnc0NX+T0gs3lqShEb6K5d38xaw5pyS8qantp0evPHCdIs4ga
         Tu1SIYj5X7PZtrNpBd7UUklS/h2K23WLbCkrSfFJGsMVVnq0PNNO1g4J3uFJF8nSY8jg
         KMPg==
X-Forwarded-Encrypted: i=1; AJvYcCXpJdslhQG9GCdMCPtF9R5TSQzQXBgxuJiAUdjT1YVGYjX58ZA2KiUR0tL6ipXGNU9UhuhIwbMwBHYI/ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx84hEHXZ2CDWd4I39u4gV75zZ5ZtnrSCYKEtqG7oPS1p9RiXpH
	N6jFSFZvqQbcL2oo8zDftgGGXUxxhKXKsJAYbht+r1ty/VFPoSrv8KyFDia29I3OYnM=
X-Gm-Gg: ASbGncv1cRReqq+l8f1kM8uSZ6/ISgpErBRMqzYFv4ZNLkVlMcm36J2SCWVLN3hRKVH
	SRlvCCVn+a4rgLbRorZ1Ho4SBzDA6K+OYofjSH7zQeY+6i98WIYs8OZyzqicuK9uZnbpQ8ew3KH
	Vu2griOLakwGxKkEfG5ILGXNitlkWJxlq04BwE1+EuH0a/uAKgcmsG3NF2+1kRfyI1OgDn4PWiq
	rfrXAuArjmBXDQU4gdjt9xc/Deml9zWOMe803CH1gs+R45bOMBPnCKEAGm2CtQOia9emJR5KGYy
	4IJOES/W1ZM+LuFiTeHiY1xit+5FLN0MoIVac8Ft/3dl2MUSBf/03HQ4JaiGUstoW19JvoSVehP
	O0XfX4XSiK04noajfCIEcgrRQfQmH7GR2BBMhv+xeLiZ+yONg9UWWIXkutGkVILoeOybhYWtkTM
	tt
X-Google-Smtp-Source: AGHT+IEusEzaVicmxlY/Bc63Mh+VhAak/hlhi5KMymhMgpxHo61SLm5W0znXGnRmWrEOUVcPV6djjw==
X-Received: by 2002:a05:600c:548c:b0:46f:b42e:e39f with SMTP id 5b1f17b1804b1-4711791d96cmr1368045e9.40.1760625274796;
        Thu, 16 Oct 2025 07:34:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ef97:57cb:86cb:f7c4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e10e8sm35163314f8f.39.2025.10.16.07.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:34:33 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Kartik Rajput <kkartik@nvidia.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 1/2] gpio: tegra186: Use generic macro for port definitions
Date: Thu, 16 Oct 2025 16:34:31 +0200
Message-ID: <176062526760.121245.6881501236201475416.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251010101331.712553-1-kkartik@nvidia.com>
References: <20251010101331.712553-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 10 Oct 2025 15:43:30 +0530, Kartik Rajput wrote:
> Introduce a generic macro TEGRA_GPIO_PORT to define SoC specific
> ports macros. This simplifies the code and avoids unnecessary
> duplication.
> 
> 

Applied, thanks!

[1/2] gpio: tegra186: Use generic macro for port definitions
      https://git.kernel.org/brgl/linux/c/f75db6f7f907c10bf4d45a6cfdae03bb1b631841
[2/2] gpio: tegra186: Add support for Tegra410
      https://git.kernel.org/brgl/linux/c/9631a10083d843b57b371d406235e2f2a3e49285

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

