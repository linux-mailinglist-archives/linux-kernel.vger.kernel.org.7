Return-Path: <linux-kernel+bounces-810735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DF4B51E92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743E61C878D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2692D1911;
	Wed, 10 Sep 2025 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="rhkC4LkV"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296A2C11C0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524052; cv=none; b=CXYm7yR0pxCmMe30z/QCtEdzZafs2CdVoTC9CeKvjKjzi/2g9qQ2tomWVZMQ9Pc7Do6FTeGFOf9ZjLDFlWaZAWTBHxmyx6Nd+GhuiAyaPFkH4CALH8Y7d4MkBOqicP8EDgZ1prP6sQ5lWoHRkamGCGMgqnZbG9wUm12rhvpRals=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524052; c=relaxed/simple;
	bh=N4gPPS/3dSviDV+nJ9aMHOkSB0mRiMcb3pe0ijxcYPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kxd8DyssVSPonQ5xsjqdydGNb+TAkSB0PnTVUpD2QOXQTh0K2Q4vhALkqCHyv6nyVdjBq+DYA3QFtBsyprQFi5FZpHislrv5tiIHNmJof1WXJyc+xMiAeTwQqn8Ma5ggwLL9PZQXOnjGDuoiDBmcqqSR+pGFmRSDGu0xRGqHB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=rhkC4LkV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso45281145e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1757524048; x=1758128848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gekjhcGuFAvCdvKdCIZQrxRikZ2Ctx9B6SPOTCwdqxo=;
        b=rhkC4LkV9HgSetgiQBBzpRSSpgSYZRb8GKm4It+rCmJMSWa0PpFISTr4dLKqlm6Xix
         HVp43ELa8ujo4gi3CNfEUdrPr+T/nwyKXGCJYqT8peaXgsKGnhRc0Jgiv54TKhAmK/0x
         bIi3ayuNEoIiQchKnFjzvLgdBeoQkp3BAN5iqner4Yjx7QQVFhZOD313LCcOOUSl/gE/
         0xE+9J0ItcTgn0ArHXRTmG7FKPEpaMOjfr9FxKAvr5NdJF3TdpAu6gh4pSlvWAtv9Wnf
         Y03MzoALIRhpDWpgzC9zmODMVQMI6z4Figwx71tgZYaklgDpkICVxIFJNY+Kt3HDdNBL
         I8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757524048; x=1758128848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gekjhcGuFAvCdvKdCIZQrxRikZ2Ctx9B6SPOTCwdqxo=;
        b=uP5ulSSEOZ2DlYcAyP7ORV2BDoNVOOmYpw2yNKKJW7N+2fS0cXTz2D5aayfF/9NOeT
         SsGOwREdKb5l3Uc0II0LlFvkuS4CPKJvazCkceBLXSbHxusHxWol/BBJZaYKgb6vhe2b
         5MXJGE2tVvBwIQFKjE2UqSJ/CxJiUZMvdItwxLCOlCcNK+XMZtZ5rS+0mAGILa4hXNUb
         YOhGhgj4UzgLBUu2EE4aC7T25Ot4oRfGP5lskNVkql8ZX5g84XJPYHaFcXkxe1MG7am9
         8BH9fHDXD5ytaQ0JoUVvYXMtAO0gFQ1RW++bYCBMmuhMqej019SvNLj40h+/wkeVTNt5
         988w==
X-Forwarded-Encrypted: i=1; AJvYcCWH1omxBSIfN+YGN4MpZnivrzz4+sP3GB7G19+nzmKY+tA20Jktr9YAkeI8h7UbgQJfUKY4AkN1uG6Lrvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKqhajYcziYQTJqm8e1kcrzCVyhppNdmlJBUEt85qeIZ9bsuNf
	6tvL/5Gol458m23u5rpxDlLx/KUar0wgcNgo4omZ3JrWpZ0SDfgtqyCv17hnt86P8Wg=
X-Gm-Gg: ASbGncsX/Otq9cFYpzKMrZUMM4Iv+Bvyd/ztYgT9nZKrE6+9X3wTmYNHgWumn5v35KV
	oQL342QCgnc8nfpOqoAuS6HZuRmN6y2X04/DPST+dhH7DoVGUqwarMnVNCnVpKUxiODhRVBg4EV
	5+o3hh3PTP4swCFBAQD7X1x0dIstdMkDvJcCBKzhnVXbWPXBRsctfx/eyil1R0GCg+wg0CukI4c
	8gcR5FiRxSPXi5PY7kVJeK/Bq90+uUuFTeq+oaG2Z0kU5UwZCG+NHmve6wNK6T89G34nBxXP/Gp
	FsgL51f94+lP6Uy4dOI1vYUZwVYJBeky2TR1n78k/2HgC5Bb59Phc6d0pOhWIU8bETNsuFmiN7S
	cN4uOnfImVFzBJlhBo2OS+17TD+6+3DZnlFna9fwx
X-Google-Smtp-Source: AGHT+IE8ICbq+Y0pNELl5MS1Ijotr4nvX+Ht9YB0UVmmnGjj1nmt8pLLDUc5Zs7zq66i3nLkc7Fh/g==
X-Received: by 2002:a05:6000:26d2:b0:3df:b9e7:35ba with SMTP id ffacd0b85a97d-3e6440f0674mr13101716f8f.57.1757524048387;
        Wed, 10 Sep 2025 10:07:28 -0700 (PDT)
Received: from hapmop ([2a02:c7c:8a3e:8c00:27ad:58c1:9156:5215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238755sm7374432f8f.32.2025.09.10.10.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 10:07:28 -0700 (PDT)
From: Harrison Carter <hcarter@thegoodpenguin.co.uk>
To: robh@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	hcarter@thegoodpenguin.co.uk,
	krzk+dt@kernel.org,
	lee@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	pavel@kernel.org,
	sakari.ailus@linux.intel.com
Subject: 
Date: Wed, 10 Sep 2025 18:07:27 +0100
Message-ID: <20250910170727.548880-1-hcarter@thegoodpenguin.co.uk>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250910150527.GA54174-robh@kernel.org>
References: <20250910150527.GA54174-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: Quick clarification

Hi Rob,

Thanks for looking it over. Just to clarify on your
comments:

1. Is this to stop duplicating things that are clearly 
    described in the variable names?
2. Should I keep the "Must be dvisible by X" parts of the 
    description?

Cheers,

HarryC

