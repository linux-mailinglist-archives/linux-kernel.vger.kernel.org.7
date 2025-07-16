Return-Path: <linux-kernel+bounces-734182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C06B07E18
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41323A9A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBD32D836C;
	Wed, 16 Jul 2025 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BC00FyiW"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59092BEC53
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694661; cv=none; b=dx2wJSuex4gwIYK55DC/7z4+gCDkOjAxvGJu8zpNNEKEKUO2PRi8HQQAYOTFmVzkEvlD2K1Ugqu8zPlT/8HgkRYRrIPAlrYJ4d2pe6qfU0Fd25kHSYieE0Zh4Q/P1SDc0Nrm73eG1UHbxcjcZBfjc0ZBkITxkLykQi+gUTKDdN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694661; c=relaxed/simple;
	bh=sFydI4KSi4GkXE4N81KdPIaVNgMAnvkjtb1o6O8DESw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSjWUQyYfXo1yAAOdb40IrMHIZbobpWaoWuvOK7Od/tQJSP0TxIUdtmyomV5pXQCMraaoY38xaEMON8idA8XOpNdXPtmxM5Ms7HrXcHupoR3tfBieKvAjJQ7t4/m//2041Oe7SwLjK8JAiAazLPywoH6ulu0D6FBeiEC2T7MM2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BC00FyiW; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-41b4bf6ead9so201431b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752694658; x=1753299458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2oMCTnT+32IM9esGcJfKCDgJ9Xsu2sOgKYa59IiET8A=;
        b=BC00FyiWUICfbEvAhVfyc8/qj1GIQ6aBGQNFCzqy32t2OaLOXs3tIqwWtg1TfeAvbo
         et5SueUpZkl6UfWOwNGpjoQd02XjIpAUR9qC10e117noyeLpjx4zZpdH7FVcBcnYiPzB
         oyzvaiwpEdZ8LUottzXEE6PsgGKGhiKf3u7K+uMQgUgCEh3RrhxsVVdG+6IKxaMUP72o
         2k/C5oYu+Hlq5fpBOI2lmM0FgYsx9cVqPqi0u9D7QgzudUfLzTRLgzquGrmiFNPyegbb
         VPAoGjRxagUKGDVwgZmEXlAaeschZtJlTo84ZwjIflGBP+VhshtVsreM+SeygStdsicp
         aDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752694658; x=1753299458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oMCTnT+32IM9esGcJfKCDgJ9Xsu2sOgKYa59IiET8A=;
        b=VPXpAsycH3QNXhVPCa0lPCjCBbQS1c+xJ9xJ2gGzzEPKTpiNdYxf2L7QJT3s8lg+/4
         n533Lq10j8Drz/XCQeb/IFPEIQCrkP6pw+HWYSkn/dP06x8JqCZr3lCw/Mn42N+sdI5f
         QIhJ3GAdro66QWl7Dec9kQ7kF0pwU9qvtk3EIUJDqXXzg236u6pnKHho0NwcqHbu+9Bl
         B6InhSIHoJk2jm7xLUChDLMqgSLzV91iOXKOftKo24QTGtfBs/16sF8x62L/2noPA3aJ
         qfDh3d1rtgUsgDAa1gu31oUcCXrEL5f8bUHxB1r8lUqc9n+DvXDyXt34g510UQN5QM+o
         P9nA==
X-Forwarded-Encrypted: i=1; AJvYcCUPu0nJtrDKiAbnJBwGwl62JoWZq+pdKpPQxJpmUqfckoJjnRljhFxfLh6bLH29QUjleuoSpRr+go8IvDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLzdiZKwi3/EqiJUo1b/a2FlW/lIOGuChPPHqZbMsMKfzy6tMw
	1ouwBmbeceKCTF58Y4RIn8dTw78CjpngEcgzRW/cbdzTDIaMHpkbKZsOUoKTf0LiNWoRk1zremI
	oERXI
X-Gm-Gg: ASbGncsFXaLHizvCPFYJBKfqtsSAHgeTlFQBoxhbFZm5IqRF2IVKET1SW9u9oPMLQLk
	lh0nkEPZivvvzdtAWqbCRipm1+6Bk/sl6ooA2xYBl2zhJ4kd+d7Qtvxx0Dbr4eMdmJ10gjr8gbl
	zJlxi5j5oq28yZ59iAfJDXIAXJqii2vkP/x0jYlAR/LCpWSXionrXJiBSUB/ujWhZ/Tdlwc0trg
	GEgYQ8TiR8GCAdp47yElPCxX5KyD7BmJ6dbODj8lYx0Jr66xsFAKDh+r+J+JRRT5EHvJ9Pw7upQ
	zfE7TBVib8C++Ff/W4bEyV4i3G/NzH6T+hFtVbaQUFnSsB3vdV6c6KCpwl/Wy7wZ0Zfs+tx3gIR
	vEsor5cCmVPQKiYPhfNf2Hk6fUvXbug==
X-Google-Smtp-Source: AGHT+IFLqHzqE9RAjaUQtmkmTyBsanwDkOziNViHSci5VEacsSRMTXfSAsTY+/VKxminqoHkU8HVdQ==
X-Received: by 2002:a05:6808:4494:b0:40b:441e:3a5f with SMTP id 5614622812f47-41d04d8a574mr2528349b6e.25.1752694657838;
        Wed, 16 Jul 2025 12:37:37 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3f28:4161:2162:7ea2])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-4141c1ac4f9sm2992626b6e.37.2025.07.16.12.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 12:37:37 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:37:36 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] irqchip/gic-v5: Delete a stray tab
Message-ID: <3f4e6446-6a5c-46dc-ba87-90e1d6968008@sabinyo.mountain>
References: <cover.1752693640.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752693640.git.dan.carpenter@linaro.org>

This line is indented one tab too far.  Delete the tab.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/irqchip/irq-gic-v5-irs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
index f845415f9143..ad1435a858a4 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -568,7 +568,7 @@ static void __init gicv5_irs_init_bases(struct gicv5_irs_chip_data *irs_data,
 			FIELD_PREP(GICV5_IRS_CR1_IST_RA, GICV5_NO_READ_ALLOC)	|
 			FIELD_PREP(GICV5_IRS_CR1_IC, GICV5_NON_CACHE)		|
 			FIELD_PREP(GICV5_IRS_CR1_OC, GICV5_NON_CACHE);
-			irs_data->flags |= IRS_FLAGS_NON_COHERENT;
+		irs_data->flags |= IRS_FLAGS_NON_COHERENT;
 	} else {
 		cr1 = FIELD_PREP(GICV5_IRS_CR1_VPED_WA, GICV5_WRITE_ALLOC)	|
 			FIELD_PREP(GICV5_IRS_CR1_VPED_RA, GICV5_READ_ALLOC)	|
-- 
2.47.2


