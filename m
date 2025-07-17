Return-Path: <linux-kernel+bounces-735834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F72B09447
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC891761C6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED2D30115A;
	Thu, 17 Jul 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lKxDQpyC"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73E301137
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777923; cv=none; b=j/3U+QRna6rnCFbUE9OD9mXOMLFnqaQ+VAU6yNjIvAeOQ+0mt9YGqWgx63U79t74Xm+DgGBh80utiQOIW+Q0OnXb6W/j1rjrNdH4PBLfUIst6XSyq4/tUTAGYCa2+UkXy3dHJQasqnXmHSM2SAfl/6Mwnx6rqzb8/TyuJ2LhfJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777923; c=relaxed/simple;
	bh=XykAQori5OAgQnpnn4ReA9o5Ns7L2zcp7d557VyV3Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CJtcbKRC+CaB5/ePDPgUSdzWeHBXaWFagEnNrOPLuhWyw2yVhGj1AULtjpo+E58QnGJg5jeTGG4+FQ8tC6lNCnyCSMoHOieo4rAafd3qozaKzB7OIvQ6Ow9uFlKslrv7wFTX42MFF8fzfx0a/i3Dj6WNJjMVbp7HW7fjWn0fF1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lKxDQpyC; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-73e5c79784fso836285a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752777920; x=1753382720; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPUupjtmN1BYgZv9Z0cHZgSg9TrLMlKVjx5Ycx9HDDY=;
        b=lKxDQpyCBdVtzfFcL7oSff/SLVE+IJmDkri1zpdrfhE1JoB9JnFelGkcmRfhFJh7Vd
         59SJWVZCNp4ckkTeJQWeobiNNGqc/33R85tGY/sARn0NJC4gKvqBftEoGNyg9mesGAv9
         5SKDrajaOhkXg09O72+QQKyZPT7XiYPBlTz5iqEqquaibBDbbz/lzCWC9iY6jBj7L6ZJ
         yLi52Neu3Ii4SN3Dk3QbNGGoQEnKlmZZySmscmf2ie7Lp2lVTAScNYFYr2Hr7B/OjmJ0
         K/pHlNFSJyfpmilEXIC9L8ChBniYvhpE2qLxfUGvKXMSc/S/WOVHoeNFqBeVN3Vxs/RE
         u/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752777920; x=1753382720;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPUupjtmN1BYgZv9Z0cHZgSg9TrLMlKVjx5Ycx9HDDY=;
        b=M9iEcoO1CVWx8PHiiC+Jg8UNYVbI985zvNf/AGlOsonCjRCkJn2Z1IAKOgT1kXozUA
         BbJeRAM38ALHDqXypV5aKL/OX/n7sKh5MqTCmPosfAhgssGX0R4WBRHZqWvTxCIeVrZ1
         5XSGU0T8JdkbfpKhdk1+bvvvvFxohvrPkTHaS0UpOxCnqtMGrsILk0gOyTApRaq+D8MG
         CpHzNFA2QmKrj523+QNmDLQGXLR52Zxnv1ZRL2mBSypixVl5sGUK/aCUHRx+5/HpHpbW
         BuNqulRW5crmyWUiSGiZdcoyrdLkY5qyQo9FgWDdjZWYAXefs7egWuHDNMf/vI2geVrc
         936Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8cPWCd8O9yVXw/tNTUVsKUG26V0l0IEAVBA2/QMjjGinXudEBURbOnxLRAP6N/9S89iZ462pylTJ0jss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI+9wwge9kSe5qlksLcKJXA7l41aVxX7cJfv5QKxlV4A6818zn
	cjmH9cQqfdXw+DJQEH96b0O61kFEfkp17V8tgBBhX04UM6P2kZpskPOm7l9cdV9XsQU=
X-Gm-Gg: ASbGncu7INWQ1xh/kglDw6ZbjTNyY6RXgLjQhDBNMk9nqplc8e3AMM3b5maV7v9Dxzi
	cgdQPlhsJ7/Lkd+CqlBgsDonbz8P4TB8TUv9MUrWdWaauqsja8pmKC2TsKRJCx/JyBiiynVC8cw
	d6lB/gs7narnxItBm5cYU/vRazQefionaZhDnXG2CADrClDEk2V0BwKq/ABGv1AZh17EG/z51g5
	2uI+GT9blADiqAaTFHQAJ04Nt7HjM53o3x6JF4Re7uLJTO885j41waNjZrFmn+K8rC9M5Hv/8G+
	f0XcHygQynAfnCW3OwaATXAA9iVBtF4q1kLyKG8myyF272eXmYcKF4CVyIR0+ZAAQFC2Mf9yS3U
	Ul/b7TUwDsFPAby7cbBB1W+gG2iOJQw==
X-Google-Smtp-Source: AGHT+IEjspHuBNps2NHxdSiPij22BxAe6MdwMHe0tt+FGMOE42JOfPTIMn6x+KqgThhHWxwHBw51/g==
X-Received: by 2002:a9d:3e13:0:b0:73c:9589:2799 with SMTP id 46e09a7af769-73e66124b3bmr4563301a34.2.1752777920469;
        Thu, 17 Jul 2025 11:45:20 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1982:bb13:46f1:2e60])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73e68f62e61sm1424159a34.65.2025.07.17.11.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 11:45:19 -0700 (PDT)
Date: Thu, 17 Jul 2025 13:45:16 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Timothy Hayes <timothy.hayes@arm.com>
Subject: [PATCH v2 0/3] irqchip/gic-v5: Fix some static checker issues
Message-ID: <736d34e1-c72e-4176-becb-00f0b27be2bf@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These are few things that Smatch complained about.

v2:
I had a wrong goto in patch 3 so there was still a leak.
Improve the naming.

Dan Carpenter (3):
  irqchip/gic-v5: Delete a stray tab
  irqchip/gic-v5: Fix forever loop in gicv5_its_create_itt_two_level()
    error handling
  irqchip/gic-v5: Fix error handling in  gicv5_its_irq_domain_alloc()

 drivers/irqchip/irq-gic-v5-irs.c |  2 +-
 drivers/irqchip/irq-gic-v5-its.c | 24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.47.2


