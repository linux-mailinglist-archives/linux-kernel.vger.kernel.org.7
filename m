Return-Path: <linux-kernel+bounces-849839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 206BDBD10D7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6633BF93F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F0D1DED42;
	Mon, 13 Oct 2025 01:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCefJiE4"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01EC34BA2C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317400; cv=none; b=RX8HLS6eNvu7zWkdtkaVhSJ5+dHPON7th2wgD/vj2Y8QhfITWYB1M00Nx+sjhdPzmd/li4NsmOLwlMMQQ7L1KTNeygYonvlHQ7BvFlBbEYyUsuokAzixFG2OR06rk352RgpE39Wf+j7A7KhoI+PQKSt9rUnq5LCr0OvGzsdzhiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317400; c=relaxed/simple;
	bh=w6mk1UvfdM0MpecNbOUW/t9n0VWCYpN7ONTwfEDu5Nc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PQ+mP2duQSs+pGvrYKk3vCr1Y+kIzPB69ZMAwLmL/QLK6a0zzeQp9038xfk+sra3qUXL1Sx3ZrKRRUjZPCTkyYRWhBdzgpx+TlQDE8I5Niye95iAklN9qAkc/srbTdADUdqiGlMr4TCQo3y8faRChh7R3UfZcGWxM3QsELecO7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UCefJiE4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77f68dfe7d9so365662b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760317398; x=1760922198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Q3CP5zn7Y6cNQVbKaOF7ZpsB9KeE22S/HHDAZmbRxI=;
        b=UCefJiE4fXjDmyhLoqECEpx+zyortNzLptySF2BOb/YF/xA+aT4TVtw5sM+9gYJ6wV
         ZMKwHKTJjQ6/ulSkw0Noy7uD0gYCdja5IvJZpcmIDqfEVeJCJncww1/xQYeC2UTS5eTu
         UhXUYYhvY7mFQpjwuCiGIsH7sSaKC9JVJ+5UkQdfr84ubSFDToE7hvwXpOluR9CM4Wld
         VOjHZasCBmSNw31I1HaUt0TwR9AmVC2OS0i+gJCEnACxg6JxfVWHXTWixMPSTyJoQyZx
         saV27K9doGouiGlmD89+3N+pB5rkGXLmFpIVJ6IRTvi3QCM2t/MLmyPnFjp/M9PKEYQY
         Lg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760317398; x=1760922198;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Q3CP5zn7Y6cNQVbKaOF7ZpsB9KeE22S/HHDAZmbRxI=;
        b=rq2wufc9BM9fX/31FFVE26rtmbqYHOc5bJsDBPGCVaWDZgXnHWS9q5n6XCyf2laBTC
         DO+GAPSZptPmniRf8b5ETvBio6T7ixOjf57QK4vgHxn1zoETPU782525C02qEFRAwUjg
         ukKRa2vjZ0droaFbatP7xifr8zjAcf1I3IQWwIV3CxOT5XMkW/R5r4wyH6WM8gN5gE/q
         7Yv897RsmnXOYOLKoWMqPnHy1oDYa/Z5lUUrYwIAmf7vWXB1ECKG9yy0yHZuM8xBwwHn
         1xmIBfvN0Czznsi69iWkrhLsS4T2sa/bMApHnFoCgX3P+MTgGi/1AHotFJnOalkOeshP
         dAwg==
X-Forwarded-Encrypted: i=1; AJvYcCXmLyh2Pganwes2zsS7TUE0xd045qAjBDOfcfc5CV7cRC0TFJzQtbtGEjV72ITq0E3kp8lp6+w02REtdBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtPdO4x2B2QfkW0I5ouM6TsQRa42NKD7Q0xxD87U/oUuVkZEbW
	1wecm+S69/8z2gnzIb0aHhcTEk2Pe9jF0gBwIiexGQgURzUbT74vLPTt9seso/NuXNw=
X-Gm-Gg: ASbGncsJ7GVjA4FYltMClsw/zRjpHoW5wxA8X+fquGdDotaQiDqBdSieHp0uIjdSZqi
	PhfpqXa9Z+9M4LTgvvPsd/tA8szZwEF3fiZyz7bsdEzSW/wzezAKS2KlVxORbyNqK6Pvq7pM0ZQ
	qAJCGfc/8RfjLifZDPwjs8vWGveD6ef8F4IOMpjArisZgVGp4CiflqlVBYTIBQskZqHlSV8ZYXh
	7i/ahSk3vFcpPN3CqjQgxlHTtreyVOYpwuTkWGX9pNMjwPXOhl2xi1QS8KF9IVEUNlWGsT/EGeV
	XHhHMQ3DlC17ki/GUDsh2wV4VyUeAWeZSZMhnaNT6FnLmcCcRngXM8DHQae6Uq+EjnkNSJzNw6u
	s3hR2z6fS6YaT8xFUTF1JbYtw6k9fSobbV/fPvbJevOfliIrQ/OnDWRqZST3itVt0bW/3gFM=
X-Google-Smtp-Source: AGHT+IE6WFNgYRTp3UFY/txkg6RFy8uxO6N+s/y3b8z3DaRZJqgiRHHOA6mC60ci9MWpIr704MGPKQ==
X-Received: by 2002:a05:6a00:a589:b0:781:21db:4e06 with SMTP id d2e1a72fcca58-79382794da2mr11784375b3a.0.1760317398255;
        Sun, 12 Oct 2025 18:03:18 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d096527sm9543527b3a.44.2025.10.12.18.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:03:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, s.nawrocki@samsung.com, alim.akhtar@samsung.com, 
 linus.walleij@linaro.org, robh@kernel.org, conor+dt@kernel.org, 
 Ravi Patel <ravi.patel@samsung.com>
Cc: tomasz.figa@gmail.com, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ksk4725@coasia.com, pjsin865@coasia.com, gwk1013@coasia.com, 
 bread@coasia.com, jspark@coasia.com, limjh0823@coasia.com, 
 lightwise@coasia.com, hgkim05@coasia.com, mingyoungbo@coasia.com, 
 smn1196@coasia.com, shradha.t@samsung.com, swathi.ks@samsung.com, 
 kenkim@coasia.com
In-Reply-To: <20250917070004.87872-1-ravi.patel@samsung.com>
References: <CGME20250917070036epcas5p15db06286fc187651574b68ea4ebe5edb@epcas5p1.samsung.com>
 <20250917070004.87872-1-ravi.patel@samsung.com>
Subject: Re: [PATCH 0/2] Add pinctrl support for the Axis ARTPEC-9 SoC
Message-Id: <176031739107.32851.16814214532966258235.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 03:03:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 17 Sep 2025 12:30:02 +0530, Ravi Patel wrote:
> Add pinctrl bindings and driver data for the Axis ARTPEC-9 SoC.
> 
> Axis ARTPEC-9 SoC contains 6-core Cortex-A55 CPU and other several IPs.
> This SoC is an Axis-designed chipset used in surveillance camera products.
> 
> This ARTPEC-9 SoC has a variety of Samsung-specific IP blocks and
> Axis-specific IP blocks and SoC is manufactured by Samsung Foundry.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: pinctrl: samsung: Add compatible for ARTPEC-9 SoC
      https://git.kernel.org/pinctrl/samsung/c/e671a1bb5d1cf9ca4dbab61b9a3e1e77579f99ba
[2/2] pinctrl: samsung: Add ARTPEC-9 SoC specific configuration
      https://git.kernel.org/pinctrl/samsung/c/3cfc60e09bdc95483875f0b63cfdc23aea67135b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


