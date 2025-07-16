Return-Path: <linux-kernel+bounces-734181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD61B07E14
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8607517B264
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7A42C15A4;
	Wed, 16 Jul 2025 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iy59Znwg"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA0C29C347
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694642; cv=none; b=EB0rqd9DfyHX65QQGmoIi8I9b14bgzqtBgM0nvOiXftUjJQkWdZ9PQQv80I71EloeSJUacNQufU+7h9bRY/L3jSgA7uyKkmhmSPL/97NsPVFeTgRqukdmTnzXicXuCeDreaBsJkP3U4AEL2ypnBcpC6vj24QdinXigTieKNFl5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694642; c=relaxed/simple;
	bh=VRNi1vBp6UXJSJXBflTSO3yVTnv/72etcpq1sfO4uAw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IKCFEfnqfk1Y1fuXooMZU85ZH2yRUTZ92BWleG6d8GqfW7sVs7ETXjGGQm9rylIERjMGYQIMSkGu+NMbpHPYbukjepUFKsMCg2QLuR2fX6JRkun1OonWRxGJcdBmiMUSRcrINhtxmZJ53hs/+UGsmJqWmVnUWq1NTX6hgL28ViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iy59Znwg; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-41b309ce7d5so97574b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752694638; x=1753299438; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qFkfRv2cl5hUFZspKL9XJMDg1bK7UnJhQtpquS418Do=;
        b=iy59ZnwgeBO09egBJOz2Kw2KLneTHyxGUI9HOPXqn2Vy/AAOwHYvQ5R1A7Vsfli8OJ
         CLBTHNP/Z1AyZhhDbbmtwvTZV8nsvMiE9R1R8nrgc35fwj9k0enVxuOLa6uBG+ymD6mX
         naO4Gz2WTHVVbHhrbv9FnpYBVoGAJZASV1ieBXJdaHQhA7dfciJ9Pl0B36UraIK9dztX
         xUgY2Vx0drQzaeG8aBaKuZA34Z2MD1NKTAw3FBpsWhhkE+fGzrQZ34TbVzR6j86byc1/
         y5LlJtUJJB8jujjnm/u3As2t/jB0cKA3KCy9txAUMVKJ0GeOwfao+gBNPQI3h4ei7iSA
         G7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752694638; x=1753299438;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFkfRv2cl5hUFZspKL9XJMDg1bK7UnJhQtpquS418Do=;
        b=XdeihGVANSWWPZfq3jLrFJ7D2gokbciu/nmjf29R4z5kjh8MRezIxxmAL9tkeBCOrb
         QxIooEm7/sCt2gKcOOkaDlvwFh2Tf+1iqmK+aIhMHExvwcc9a8+LkeBHLAcOGBXhfsKP
         qZQ4dqlA9OR8504wAl8EHnQCo4VyJA7BQQ45wLibETam1BN19DpjYCvRb8GOZS/xOIHM
         vLAo+/+8c75EWkSs5CEHMQ5a6Iwop/gArHhA1nsOY7TBOG99hvGE8eYKkEGTYfexd1m0
         2EK9JO89xdh5mtwtrm3QMSyeATJwY6B0x5TifUQ+W81aXOAZKNRDftk8s6yIGG00h7yG
         zwbw==
X-Forwarded-Encrypted: i=1; AJvYcCWrniUwzZxdWXBsRVyOCKh/gRbDNt1AZX9PdupCWWeL5N7SPwpwf0LkowEc4oPGvkYfGG3X0wPQxUdcmIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9yfCfHcSqSTQCsRjSGOBfM/a6HYPKcr1D0iiQXLTKVQQHgsfP
	m5WiiUszb0GQI3k2XcbIRoAjVE65KC5CnQrmuHPgC58Vw7mEnzInJSALplkrYrJChCY=
X-Gm-Gg: ASbGncuKj6mduJew1aO/co+GHK59mN5+vX7RD+UhjsgCtN8ViCgR9SLoOpn5+RCax4d
	uxZ1iopgRgqbxW2/omOigaovO2oFV3KuMTOvsm090L2ny1ciyIvNmktLPRWFQTy2V4USUVbMwTQ
	VolVnYIGwhIgFQFXDw439iUSnSaG+GLkAHNH+3mzbnvc//eMz590fPFgMdrZ1aZsDBpa6nW1fYC
	HfEX7eRrygVbM9ANpPZHr8x7EpoDnCyfymzNGFgdi7uW7sL7HbZ2qr/ARUILBXoNfNS2mEugUEg
	ayBK0NSf9deCCeZT993LUd8IOtrex+7fsw8Cd0YuzbWn8OYgyM8lMOnwRZUG5Ood+paKkClbi+n
	Z4uv4r5ruUkqQces34VFnZg0HLNxYvaJ/JKpopikF
X-Google-Smtp-Source: AGHT+IGVW/Hpd/xCktrXO7wHgnYK9QY115QI+GbTzeXpvTW6lSyiR1JIBdsoODH8tH97WLglzM6acg==
X-Received: by 2002:a05:6808:14cb:b0:40b:3816:6637 with SMTP id 5614622812f47-41d04996d5emr2622802b6e.24.1752694638543;
        Wed, 16 Jul 2025 12:37:18 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3f28:4161:2162:7ea2])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-61598384872sm995165eaf.9.2025.07.16.12.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 12:37:18 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:37:16 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Timothy Hayes <timothy.hayes@arm.com>
Subject: [PATCH 0/3] irqchip/gic-v5: Fix some static checker issues
Message-ID: <7feeb4d2-1033-47ba-8730-150993491ec2@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These are few things that Smatch complained about.  I have not tested
these patches.  Patch 3 in particular probably needs to be reviewed
more carefully.

Dan Carpenter (3):
  irqchip/gic-v5: Delete a stray tab
  irqchip/gic-v5: Fix forever loop in gicv5_its_create_itt_two_level()
    error handling
  irqchip/gic-v5: Fix error handling in gicv5_its_irq_domain_alloc()

 drivers/irqchip/irq-gic-v5-irs.c |  2 +-
 drivers/irqchip/irq-gic-v5-its.c | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.47.2


