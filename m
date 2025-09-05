Return-Path: <linux-kernel+bounces-803920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB82B4674B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 01:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1951BC19B6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A09B29B8E6;
	Fri,  5 Sep 2025 23:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kxf4CfGG"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0929528D8ED;
	Fri,  5 Sep 2025 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757115902; cv=none; b=MWDOwG6AmAUPI+Ij4alLgdd4ToaXKaq1VaXug5off2+TveASWSzsQn8j1lGLD+7bPjCkkeuGAdbrwHuTqN0expPgh3DjDICQzkM9TEmHt4rsr33LLMvhhBLP3ee1ERPhlo3NDIUgMU4WOXXfXcdpw6guddrJvrbi/wfPIs5DXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757115902; c=relaxed/simple;
	bh=jm64Gs8i7Q18G/MS8gvYPRujEDuv50d60Vqsk7Bxo+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbwjwQHSiWVme+PkaKQmKT7pWnW53n1HvZHQRkB5Wx4I6/mlVghPiFdr82k7miReRiZ86bzdtwKFoC7fMgK2zbm/ibd1CS5/LUienoP8jId3GhV2uH2FSsdpkOy+0MAKTWqneU8Mc2lUsGLKUEF62pTN/XB7T98+ExZppwBDBHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kxf4CfGG; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f98e7782bso3187913e87.0;
        Fri, 05 Sep 2025 16:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757115899; x=1757720699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jm64Gs8i7Q18G/MS8gvYPRujEDuv50d60Vqsk7Bxo+M=;
        b=Kxf4CfGGEBFEM4EgSE59pp8+0doiKiIEGjabnrWk7hKKNKUV/wQ0MtcABvjXOxLMEj
         303vua3X3xoTv9K88uzkMsixgaxSlKjOsM1bet8Egy7WHdwN3YsHXh3eMqhCbnJhJ6Ql
         F1OcxAnWXxjbJvCHeJjmh+6/PjcBiLvdnh/ptnKiPInxO8mg6874aaMaNyfzJIIRqHuN
         ysYKJlP4w0QZTcq2Bled3GSeePZw7d9VgCc5n0D/4HFUPPJmCtiXyOOhatnL+9X/2ceM
         X/ySvWEJdViM0rKl26WOk49J3BT6K4JUAbj4TygCW04X8qpYcOyrNllqALqkedyycByH
         lz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757115899; x=1757720699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jm64Gs8i7Q18G/MS8gvYPRujEDuv50d60Vqsk7Bxo+M=;
        b=prJa3hrTtKD7DOjPjCciXejYKyJvGRKdIA88JbT5b9J1qjIBoKtsLck9DUBLaB6j+N
         oB9QMcT+1mgvQnphYwrhTDAO6XoaBjY26e9ze9vsbQw5p2DE9096R2kGyjg88Ss6pdeo
         feX0QpuX8v1xeVtxgqwuP4AHABe9R6zvFFIxhr5mg0VhMvqf/t1+OXbThtFZmJTtb2U6
         IN+SDPB3BYQoQ2k/ZwbxpIiN+CMpLL6+c54ZQY4svUXN+Y/csY5H+WD+SP1i/OtDpQA3
         /JLnIjdPYBSNRXbRo2hNRZIhi0N0fjDbDek2ZPTkt/SGFOLU9pLkYTihsQCKjOJjSEIM
         l5Gw==
X-Forwarded-Encrypted: i=1; AJvYcCW5yM9Q29m/JOGNHjIaHMlDU/coj4s9BnCw1IjlJj+GlE+hu3gWuckFQWUbfHGwdmKppoZwqS2HiIMaYGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP+Fx7G2Gzb32p/RjA47+F4j1bYlF8nJK+zvChX5gt+v1DjO84
	WAUglAZJukKWJw5y3jD+gXsgKTi0mxH2wP8jmgyWi1aSCAqu+VDJx5Pl
X-Gm-Gg: ASbGnctsp2zWTyV8/yAOLo2xX8CD1P/c862JJLXm+oWeZTu3TX6lHUV5Acx4lDU0hMy
	SK6AfGLsXa5UYU8/kxu/toc2aJZxjFZ93WP4xuGclFZwiEaFhbkVPf8rGjkR07dKX1IknbKRih/
	UXtt4j2w9wTZUOfzUzOo431Sd6DWR6hk0ReJ0uSDS4rKH2uh05xj3+ihCoOnbs1OSCbSGA2JTSq
	g8LoDhpWBlr8NQ+zlcObvSsRMjY0+/JmcSYcvlg0MpJ/KL+KkAANviODzY4EQ082pGfaUC886Kv
	jUb28m1iXX4iofq/1jkIaN1rSst07ByH3PsRP9xGVZPTYDBWFknQ6O6KpMRSAReBcHVJCvxV652
	IkqLF0TxSoW+Ya4ioTTpwMo+dXGrRpmPlGdNf7qVvi5PPVZjyqSI=
X-Google-Smtp-Source: AGHT+IEy2HVJRwuLhOsABFo1qDBfSM/TKVDGjg8IAHoxKlc+T8NPkxVoGiBJwUzPv/hKdp9pNUXsrA==
X-Received: by 2002:ac2:57c7:0:b0:55f:5c1d:6cc4 with SMTP id 2adb3069b0e04-560995d6aaamr1172200e87.20.1757115898906;
        Fri, 05 Sep 2025 16:44:58 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([88.201.206.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad4dec5sm2046765e87.140.2025.09.05.16.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 16:44:58 -0700 (PDT)
From: Artem Shimko <artyom.shimko@gmail.com>
To: sudeep.holla@arm.com
Cc: arm-scmi@vger.kernel.org,
	artyom.shimko@gmail.com,
	cristian.marussi@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] firmware: arm_scmi: add missing spinlock documentation
Date: Sat,  6 Sep 2025 02:44:58 +0300
Message-ID: <20250905234458.3788783-1-artyom.shimko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902-daft-pompous-angelfish-459c6e@sudeepholla>
References: <20250902-daft-pompous-angelfish-459c6e@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sudeep,

Thank you for the review and your feedback on my SCMI patch!
I really appreciate you taking the time to look at it.

Best regards,
Artem Shimko

