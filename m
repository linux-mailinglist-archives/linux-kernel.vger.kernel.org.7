Return-Path: <linux-kernel+bounces-736454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2DDB09D15
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8853BF1B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9611295536;
	Fri, 18 Jul 2025 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Sh/UfQU4"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43A9293C71
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825382; cv=none; b=Ln+KBJgy1BPINlScgmNpJdSU8a0eVpO1IZzJQ/Vexl48CcvaGGNH4jUskE9jqNCqya57c14CKnPqvFUvzlCM0GHZwZfYo8OCa2rVapCHeP2SvgiP0eJHv4TdQvrfo44AaFe3mRel84NO6KAVdRl1Ju2J7d9Q97XnRZkxYtomrDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825382; c=relaxed/simple;
	bh=ftRw5OTTN9pPVwHGIIkCV4t7mbPYyECa7PWEzFp3EUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqe5PbNWhvckviyZ3PP0FX1Zbj/eJoMLPU2u8BbqctjcfZ8zrUX178AnX6jrmhz/Jt9zQnXaewdX8alyetM+4c/YgG2e2+K0aX3jZeq7Wd1JW2eT8ub7IZl6IcQKIkNselcNGF/TPa1l2SLsFHm1evau+LjVgonNijYr9EVu63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Sh/UfQU4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45629703011so12742085e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752825378; x=1753430178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WG6llnBzWL3MBIZ4vJuqyDtZMdkbt5W1e9HnPWqk+0=;
        b=Sh/UfQU4a8MvDGz+54ZodRBksOHOBUT2CJMqHJn4jmScX7XTMuIG50vSTZO/K6uOej
         D/EWk13U/mlVo3k1gOdP/j7Dco3Wu7oVbas6lhBLEluI+3wlqmqWLNYRNm1Pt5yWS7Ki
         pM+AhF2bpCSSTAu43kHpXiMeAjJVIxzBZIQ9B43IZtjYbMtPRs2XL8AzQzl+nYC+K42g
         hEW7zcTrL/dMOd1vHX89aewTE4nwhlpWAE38L5m5M80Woysa+55IlYERtiGMla6eqQ4y
         Umip+dCztfyo6mz+Qz2VCGH6Wqzfcxp0cBFcsbMUJJKv0NfGbw5an6Ipon2iF4X6Ldtp
         eDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825378; x=1753430178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WG6llnBzWL3MBIZ4vJuqyDtZMdkbt5W1e9HnPWqk+0=;
        b=juvra2lo+TNJo/GSlL+5q64mBLF6SZY9obkzCsv4XKVAUNFZYytmLit91j0mgwVcvw
         Pf64RwzGtPMbzGY+a72ia+1+0ADeG2nHpqYBzn1UgFEUletAVCPE40RHMXfqAfZueao1
         DB1WoEROkmcz6xPZXbaM19VZnf4GSbVE2c5m+2IAeq4AkMlOPlP0A7DRy6OkwlLb0b83
         9OCmGbAC2yqN05bQf/8O7K0RJ9K601+cubxSkBfj6IBbC9uynHnUq52mfLtXzolytpsd
         R5vby0GXk5C8DsZ+ho63dQRNlWSrVCdAyb6zceXzlqNFue7cxa9Roywqy6TmYpbzW6hC
         tBTA==
X-Forwarded-Encrypted: i=1; AJvYcCU0Nn1vZp93rZnavTaekv+sHyjkIJeV6ek+28LkyE44nlPgcXfy4LXA5nuO3vpo7LCA8Tbikw9ZPlWfXjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt8tbT6/mvcD/kDXh9UJ10tHEjDMxVvXMg7cCnpfO8FivluKlf
	TSBoYn/0tC0YJpOoYaE9pwgy2JBiP168dHhxFwMv2ULBjqlgFc+ARrBSMAWD40jhEQ9GW1Gjvzd
	DMHvND5w=
X-Gm-Gg: ASbGncvD4dm3/2eRQix9CTGfCPtsy70RyROUmvvkx4wfiqkzD5OPg/E5ayjgfxAfBIF
	f/6WgQUSnAK16kH1hd/1WoVqcIlRlYJdMuXTkt6BXSkHqAZauSRlxVSVkGbp+a3rwjFJC8Nom3V
	ZC1dhvFM/VS+nmJ+V5okTlytx4h6qHIFp49M3tE+NdL2Yeob7Z58p4uD0eOtdPrVdsqjkD/Sor+
	mvSY5obY+V6k/fbZO9vbFVzQyFQPXmmC5jjUW0mqBWP4TMLCovKZ+Z4ciiOLWO1Q0HooIBE6SuF
	pAy08M1nJAN42MPZd2NlVHNNPeZ93hGIt6ft7CwabB6C5sUSPX9FpK6VaG1z5TsrnCWADvC/xtq
	PqZi7Sl+PafnGkrlakZGA
X-Google-Smtp-Source: AGHT+IFjvvtk0Gk4O4i1psaL5hF0WvEUOZLUp4xP7m1e2rW7bDd4F500xiEFX6IzV9sl9d9EjIZj+Q==
X-Received: by 2002:a05:600c:1d03:b0:442:f4a3:b5f2 with SMTP id 5b1f17b1804b1-4562f7c7596mr76814415e9.6.1752825377878;
        Fri, 18 Jul 2025 00:56:17 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:be63:a233:df8:a223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48a23sm1080851f8f.54.2025.07.18.00.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:56:17 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: Convert apm,xgene-gpio-sb to DT schema
Date: Fri, 18 Jul 2025 09:55:49 +0200
Message-ID: <175282531514.45055.3453969331255231197.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714202821.3011099-1-robh@kernel.org>
References: <20250714202821.3011099-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 14 Jul 2025 15:28:20 -0500, Rob Herring (Arm) wrote:
> Convert APM X-Gene Standby GPIO binding to DT schema format. It's a
> straight forward conversion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: Convert apm,xgene-gpio-sb to DT schema
      https://git.kernel.org/brgl/linux/c/9bfe54c511dbea9ae00db26abba1a084fb0bca59

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

