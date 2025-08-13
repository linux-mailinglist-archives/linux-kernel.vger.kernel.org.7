Return-Path: <linux-kernel+bounces-766657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97304B2498B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B63189AE36
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE9722259F;
	Wed, 13 Aug 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TBburqiv"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1DB17F4F6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755088340; cv=none; b=rbHkRdTqyzCk+h7jOLWl6LWBWMkLfAFiZ/xD2UaXkh3a4E0noQ8PiV1xXEnzHi2fDMuUMFJ/8Z1fNrcLlAVgGrMpQHndsRf3R8hd9xGI45/8/qhAbldM1OMsCBO3ooCbsjaZjg2uuW5re8KrfKyMnM6ucFMmvBjfcps2K1YNc3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755088340; c=relaxed/simple;
	bh=78VP5p10Jg8NcnMtDmrrGCJeg8umSedtsXpZInRySm8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b3k9C3AJorU6p54cxZuPkfxh6ajp/9ze9GaiqEDM5J87Rxx8JQC7UCns/lo/wMROF9Ip2w0CQLw4CX5RVm18SDylJxMD2rWSzR6sm2HRyfbTJ3VbGodFbN25kKob/HP86MV4psPlMxpclBI1hocpgsG6z9eZ0ORflJ+PmjnexKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TBburqiv; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b34a8f69862so4898420a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755088339; x=1755693139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNG3CwDZnVq+LlYCqJlDgz0JDJC7ub+N0Uk1MeSzHuI=;
        b=TBburqivT3KjGd0sx1ZE6gaEt9UKi92w5ljhr5HpeOgmGTfeV00sTQqV6m+oQc1rCB
         7SI1lcCNGSVz+igOdgKYUClWd8J03WLMVFB4WjtUFeNgj5EZSmlkTMYIXaAw5yfgF15y
         uDUzhqE0hDyZ0ZMeTXouW1i4VvZlaa5rZaMqQm1ubEIMaqfANh24AbH8yoXTZDW8vMxG
         2wI8i0YpypuV8oo3KUyAufbN/k9Ir64dB7/S8b7I1Lbc7UcSXv+gOdWyciMvbzcXvEbW
         PaM4Wj8p+8cuNF6PjHcD7Wd8XJslZoj0HxBuq1lSYLaEsUnYA2VMo8Ni9MyivVrZE+F7
         Xmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755088339; x=1755693139;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNG3CwDZnVq+LlYCqJlDgz0JDJC7ub+N0Uk1MeSzHuI=;
        b=A39Zmnjh+bDCJ7J522xC+Ous6nt6nBYOD63vfW4/EC550TpnuDur+8f/K+Ncp39Tfo
         LpxrkvVkG1g/DkJSCQmlitUnYYZXtJvXfioZZC+KrnqPwY3IyZe5bkULPmBiPyxfwFin
         Bx8wNpuasKEzne5uoOuMHnE1BtzZH1EqZbKCNas/+i2czYFBgBIpirtCwDuSQJu0Pr57
         yi8Xxi0iYELn6O3GYQWPLycj9hvngg3n7sZ9WuuNC1geH/pe9KXxmAjZuaB045r8LI88
         cuUzZTf4b1fmYxb7BPYAoFxDoavjf3AjfM4zRO3m4KLx75aseBU/QAJMBwqYbxcxmQ6o
         Uo9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2Owe5yVXjP/kGFKzyMPhSKdviMx7nPVqp6I2TnoWRk4TsXUfCLIE2w7rgBUYKkEqS+zWfK/OcgL2+Vns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpUPO2UfawmzhMA7J4871/envRrTAOqDTHmY01WpkElvPVMzm/
	EPI08m6N6mwXAgYdsiBthsxYFhBJr8nyNcROW6lW8LaH6fil57u+OjcKHL4isWM933c=
X-Gm-Gg: ASbGncs4HIBpdJQAXPdL6+6ipGx173foA1r9UAhdJkFdj5zWJtBXHrmlAfXGYPA4KqX
	uFSTtTtO9T8YAaQpFMCVMpKA7nj6n7cNZKBnrfWGpxi3sRkfQs2mhsVInv2tx2qp11b8grg1EvV
	aO4Nj+rrhKkqhazsnhwzx2jZRfDrTHy6Y3DnOPNcaxzSXCS6SwZIEFWbKR+2OyqMGkDVWvLsPXt
	PhT5f4bUaJosDTjVYZ++hDVAfRn+tEoWXLTgGHpMvTLaSUJY6EP9Z6gIKnd6XWfp0hnKIu6riOI
	yygt+CFxQX15qrqrureKguewoItQa77Y4enRgPp4zGBSTiTSiT4PcSO9X5vnY4TnYT9EhMlNEKJ
	2DaSFxZ6uJJD124Q=
X-Google-Smtp-Source: AGHT+IH45G27XmEuq78X8gxw6G2P5IIWEUKaJJDkJWCvlT9IOAHkUHlLvMF5cfFKCUbmxNPSZShPMA==
X-Received: by 2002:a17:90b:5211:b0:31e:fe18:c6df with SMTP id 98e67ed59e1d1-321d0e5cdc3mr4379625a91.16.1755088338731;
        Wed, 13 Aug 2025 05:32:18 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232553e4a2sm82418a91.4.2025.08.13.05.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 05:32:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Jonathan Corbet <corbet@lwn.net>, Erick Karanja <karanja99erick@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, 
 =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
 linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
In-Reply-To: <20250813071837.668613-1-karanja99erick@gmail.com>
References: <20250813071837.668613-1-karanja99erick@gmail.com>
Subject: Re: [PATCH] Docs: admin-guide: Correct spelling mistake
Message-Id: <175508833758.953995.10420055026430792302.b4-ty@kernel.dk>
Date: Wed, 13 Aug 2025 06:32:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 13 Aug 2025 10:18:36 +0300, Erick Karanja wrote:
> Fix spelling mistake directoy to directory
> 
> Reported-by: codespell
> 
> 

Applied, thanks!

[1/1] Docs: admin-guide: Correct spelling mistake
      commit: f7a2e1c08727384cde1c686dd57172f99b5f2e6e

Best regards,
-- 
Jens Axboe




