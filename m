Return-Path: <linux-kernel+bounces-834941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DEBBA5E23
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DD93AAF3F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8627D2DF134;
	Sat, 27 Sep 2025 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8DBl0JA"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356832DEA72
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758970998; cv=none; b=Z3uUNEcHx42igaRS30XSp7C1IgXAUkZ5dobcthbM0TXEw+ZsouREcOyy6ZfqkjbMEwDHTpPIq1Si/HDWQcw71xa47Govos2ocHwW7SO6xH0WpnZNLnGSWkaivbL6am6jIN40OizQlEZeFBqS2apVtrOimKVP3zPMYICHxNj0vlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758970998; c=relaxed/simple;
	bh=MEPk8mF0XWJhaPBW8X4rO7lqawwu25cscAs0P6vTG3s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sjrNFBNeXWpkvmNA97tWgnfhQQxpdCSzFz9qI2d+QWTWAjaDA1T16R5WVQtlkgDSu8Ux3fuAoFJL2MRqnqxxm6/W99bQppL+1tTK7GyYFsT9CqCsa4oBwrWpXij+4/Hq+G0v+PppVCxbshXbtxhXGbNd14Mus9cxo69tg2sEPHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8DBl0JA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46b7bf21fceso23319715e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 04:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758970994; x=1759575794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkNWDYlAClljJacvPFHJT9/32vyeFE8E70qgHvwmkb8=;
        b=B8DBl0JAKft7KS0mBXk4ZY/ok6mJDWMh2p+a5mIpvq0gcIDr/nrOcKqyZZpb4sEwsn
         0JvCxISZgsr2Y6Com5U6VjlE8zGBC0ir58SwzAVi+kaOBqi0LcziH3q8uwCxP2kfY2jf
         oZ7zw1MKqyWSqsxH3xCjcxxgYRAiEEsYTDw9E1YXLmvMm3u+NRE7s3Xw4mrNsX3oBMD9
         YEVlT/0fJil/YiUuHHGONX2ymzrPDhHDbfn5rPwaPpLZxwx+TuBR2hFju6qEKe2uTsgY
         aCeRYI6sqWOcBkoVzVMeQh3k/9rZGfxTxFOETegROEUGv6k6i0PKaJEC58q2hRISmilt
         mzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758970994; x=1759575794;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkNWDYlAClljJacvPFHJT9/32vyeFE8E70qgHvwmkb8=;
        b=vuiFROMuONi3xYnp+/pmc3s4KBfDp1DZOQsZnpT85asfBfWlKqUot2hgxhXDj1lbkm
         A6N3GUxd7kQdApqiw7RM4zmLmIcvc5D580LVjLEVJGE5gUHUwagwOWR8Uo9pCQd23MOZ
         5M0U1idlE0xUKhc79sy0Pdloq9Q4S5J+K0w9fAkRknSqrdW4WcqPgigiOPgUizPQaei9
         5y0nnjCss74Afb486pFBlc6a2WWgwY5J9JE1hK/CgaBDYoZ6v5jIuTtQBhyz8L/8bW3M
         /aBB16OQdliO87NeU9ugzx4rwPS6fRIgZzwjCCzxTtzUEgY6hHWSSvtftOCBQlsTW+K+
         M94g==
X-Forwarded-Encrypted: i=1; AJvYcCXhsSyGo57FbDXQulBAbbHyNu77PU7C66eUfOFb4DYp3NDkJVUTSe+d7L0RseMIhY5xzYzxjEvEvu6I+8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqPQuzRYxbNfN7N8RHckbLgPMGnHDAHKS2hAyTAsAtT1ohEJyO
	PbyhtOfroFcIiwr1kJSgV8OK93iZeAGNJvxObRNc5facOg5yCNM1CQWI
X-Gm-Gg: ASbGnctPz9EN4QUK0cBN6TaFQLLxVSRC2srS9T7c2Wv/nnx7hhbFocQgPjJDo5azLPn
	B4QXfhzSDsgemrCBoyVg3eNsZkmwMqGayQdEsO/KYu9ayaAGG3HNA3MuqXzb6jaKWrlciyOz2o1
	FkbZWjAttYmCBIgd2tZTUv3KmITz4GCLo/RmH7bkr+2Qjg9itgikxZovqlooOQcyd5+rOi2GD6G
	hC4uew758q46Ly0oqTvoD5BcUoGlMd3PaLR2mvZGggFRl+l9yp6/Q9/4NapEHHdEl7ajgU2G9R8
	fvHXqWpjOAlynSPJhZZtOFIu25yh3MRyOH/WfVLMr+BxiXbU7Vbpzq5Bl2moGN1+ZDbrc+KlVwc
	7lBveTqSNYlD0TMiD7APATLcm8s8J0kR7KnqctAIooNPgEO6rOMqft8WKaUW17FCqW8mQMwS5OJ
	nrdKmr9IGB6PwCyA==
X-Google-Smtp-Source: AGHT+IF79XdU3MiveCiJWHuSLef1NIT2fZqNrN2anDonGJumcYidxmAS11xssMvpXUUEBE8RsYnPGQ==
X-Received: by 2002:a05:600c:3e86:b0:46e:4784:cdf5 with SMTP id 5b1f17b1804b1-46e4784d03cmr11911565e9.15.1758970994270;
        Sat, 27 Sep 2025 04:03:14 -0700 (PDT)
Received: from Radijator.localdomain (93-140-175-232.adsl.net.t-com.hr. [93.140.175.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bf70b5sm106190035e9.21.2025.09.27.04.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 04:03:13 -0700 (PDT)
From: "=?utf-8?q?Duje_Mihanovi=C4=87?=" <dujemihanovic32@gmail.com>
X-Google-Original-From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org
In-Reply-To: <20250913-pxa1908-genpd-v4-0-55e4cf32f619@dujemihanovic.xyz>
References: <20250913-pxa1908-genpd-v4-0-55e4cf32f619@dujemihanovic.xyz>
Subject: Re: (subset) [PATCH v4 0/4] Marvell PXA1908 power domains
Message-Id: <175897099249.11004.17270115916151643401.b4-ty@dujemihanovic.xyz>
Date: Sat, 27 Sep 2025 13:03:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Sat, 13 Sep 2025 23:12:47 +0200, Duje Mihanović wrote:
> This series implements support for the power domains found in Marvell's
> PXA1908 SoC. The domains control power for the graphics, video and image
> processors along with the DSI PHY.
> 
> 

Applied, thanks!

[4/4] arm64: dts: marvell: pxa1908: Add power domains
      commit: 1ee5305033c227610c072f32c4ac8ba0adbd42bd

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>


