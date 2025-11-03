Return-Path: <linux-kernel+bounces-882318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB908C2A2DA
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84FC04E802D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8254E292B4B;
	Mon,  3 Nov 2025 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEQ1VRQg"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBAA288C08
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151210; cv=none; b=EMj8tojFgMp3C5rGgPLdfcLoMrYJ1CZ7M3D+FUwriz3YmVey2fFAPe5p2vQeIPEPG16DsTzcaJNHcDGjLiUJmzgVKe+ydaGp4m313JvHhXHeR48fB1qOqs40cSSutUroXgPBtUWj06EuG8rrbeLtzwBb8etZqzuzIdigctvzIGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151210; c=relaxed/simple;
	bh=B7Dys0O6nBI1SpNWYBQ9IszCBqiZCkRXAY8GXR39t74=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qk2DdJexlsRjMoOKeG/XPR8wK5cn71jl8L1ssVEk0qqNCcRp49u6Bo7oKcS8UAEgy13EQyRqDrFahFBcg2AS9urYabD9F30fgo9vT0MUB6ZqVDEE4JG9488M6EsXDnhB5lMS3qlw6vdsaizeTKdgN+vKuHkx7sC9f0gE3hE1LhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEQ1VRQg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29599f08202so10617235ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 22:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762151209; x=1762756009; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9n+VOC446iMLGSUtF1aVw7jOFyi8anlj6U7DHCW/jPs=;
        b=JEQ1VRQgupn1NMpuLRdeBoTi+6q8d6VjoGKYTxh551g1dX+HOS+Nwq8iJC2yaRE2EY
         DGKX7qZF+RfvJyA4EG2ib9iwQfoCJLVqZBlpHsJ6XT0ZzZwUN/gaCdtTtFoEonsF5Xtr
         j//ayLA5yiZ9cJegS75rrtOc6NWsfkxSj/2jzHYXgEzXUoGsvXS5O/ION6q6+bppAt7W
         VXrmNpV8dlXnsUMj8DMX1b9R8kmo3CndXEXnmebX2zXTvVtP+0Ro1U2hZXyFmMGylIx9
         VT2C/RLI5VSyQBhrheNC0eXA4D1jphQUx59EjohNe+gVTznPRxl5O5i61ZnnMzuWFx3A
         HQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762151209; x=1762756009;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9n+VOC446iMLGSUtF1aVw7jOFyi8anlj6U7DHCW/jPs=;
        b=kkoe8+/Yf908oPQMEKoA09lhyD9o4rpEYq7J9oNfDxUgL+7vEa0n8twNMDG4u1yxbM
         wDYlIwGuRx2YyPd/rBC7favLWbv5KTpzwVxKyAcM+4t6A4Wk6yz2FLxSmv9P9s0XGTBt
         bnMAx41LCmB7vsikf1zo9kND9TqjT/sEE5OamO4Nh4k6Fb5NkLWpTruyfBMmcjK/bInP
         Fbr09i2D2yi0fNLYoel4IIcoM68jtsddY/RuLpAr8874avLhFwcHv1tQkutS3r6wkizE
         kE8S8zdhfdOhEh2Egtlyz+93nqJNXADPurYHBsmZk46gtsXlVnfwmLHZRlS2I5dIBS2Z
         +Y4A==
X-Forwarded-Encrypted: i=1; AJvYcCXlIBrz7y8qfdblaXLcQEhOpVdWwo4mSzH4jH+7nMoYj0CB36Zer+eu1kysm+G3zEgxuW1Y0G3o809mDbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ1jQs4xEIvqbIWyENyZc59glRfR6g/aJW+pWgJumajKYg/3i9
	o5cw6c/DUQfQy8/sdR0jIdeIlzQUjbbX0xPjVC/B/OLNcMZ1oa6hPAYW
X-Gm-Gg: ASbGncvIs1J93rm/FBFKirY9IxT/AvNvw+2PLoMu5s+HVnPVG3MCvxNEjXYRCoCkR8J
	TTzg2a0HJ/EpYYHrUIA1ri+yaXqpIo9CSwwUzqHCsuA92AdVDo5GUeaWNjyw1JbYqY6fwA7+1Ph
	G/OfN2RU0aH8KPxK5ogCqDxVpFv0Gbw+3wbGSQvITBP5DwXmk9lQBEXpHIteUC5YovbjO3/ugAL
	uRrAUK2kqLmd1VNa8nf9TPOwUKBTOICQjJqBP6dB/db6f+4ibV6AK5JMlYoDA06VjzT7FpIUUEs
	ISwKefBjimUtEtaixmcC52T2n+WPJ4yRE9Y+WtUT975Xu2wW5V1y0sivcP4BCIaBxstSV7wguN+
	a7CCGO+0sSWJZV85OOAXEA4GQPsRUs9uaAqfm0aVDNMsGK/QceIp3ILhUoIIPLfdd5wh/C2cfeQ
	==
X-Google-Smtp-Source: AGHT+IHE85ZAE05MQ29tDiEe73xuX9q1kSirWYaSnQbdQ95U62fo8gMJxYb1mTHJbA73o23JvHBMaw==
X-Received: by 2002:a17:902:f705:b0:26c:2e56:ec27 with SMTP id d9443c01a7336-2951a3d5107mr152483975ad.19.1762151208773;
        Sun, 02 Nov 2025 22:26:48 -0800 (PST)
Received: from geday ([2804:7f2:800b:fff9::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699b603sm107777285ad.79.2025.11.02.22.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 22:26:48 -0800 (PST)
Date: Mon, 3 Nov 2025 03:26:35 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Geraldo Nascimento <geraldogabriel@gmail.com>
Subject: [RFC PATCH 0/2] PCI: rockchip-host: support quirky devices
Message-ID: <cover.1762150971.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With these two changes I'm able to work with a Samsung PM981a OEM SSD
that is known to be not-working with Rockchip-IP PCIe.

Previously I attempted a contrived solution that mostly worked for my
simple purposes but was rather inelegant and impractical.

Now I have isolated the behavior to the three lines in the two commits.
Omit those three lines and you get a working set with the kernel.

I have no idea how to actually implement this in a way that makes sense
and doesn't break the PCIe spec but it is my sincere wish that
interested RK3399 parties test the change and report any regressions
with already-working devices and specifically, successes or failures of
initial link-training with these changes.

Geraldo Nascimento (2):
  arm64: dts: rockchip: drop PCIe 3v3 always-on/boot-on
  PCI: rockchip-host: drop wait on PERST# toggle

 arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi | 2 --
 drivers/pci/controller/pcie-rockchip-host.c           | 1 -
 2 files changed, 3 deletions(-)

-- 
2.49.0


