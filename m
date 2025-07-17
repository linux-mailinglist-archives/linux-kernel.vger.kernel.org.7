Return-Path: <linux-kernel+bounces-735838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF165B0944E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93831754A5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9308020F091;
	Thu, 17 Jul 2025 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8m1qlnG"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773202116E7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777939; cv=none; b=Qv7zEiWM/1lhKQUvExZ3mCwMUr3M9nlT46ub+BrC5A1tvoF9TaJWZj7l35F3Ys9Q6NK+tJTN8pxmTXGYaIiMhDyu7c5s7cp0rB1MtIEfp89wsP8VPzyWy3LXN33kXY21oRYiEF1kgfyfEIZen24kjLbX8Rx2yQEJbTY95wVJHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777939; c=relaxed/simple;
	bh=Ibo52oECnFkf6tlvH/3Xz521TNwbSC6FSssXcYYn8Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAfrgEAmVe/AMTLtKut1LeXRLVomRFTgCXgPAHQA85R4LussjxPipCx4KdMp3WkPNNlbS/2ko9SHu6LvZm7PqXZeRn263Tj0Mjx0V3HTDGBOGUv+xESEDpAMthJh+IbxHgb06dLU55gzfvgB+7vAyk9XF1BEIzfcHpRUyWZ0kKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e8m1qlnG; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-73e57751cd9so387602a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752777936; x=1753382736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lq2qXRTV07ZyxJO3VWSgjG7vTWGiG8uJDpTR4dmthYg=;
        b=e8m1qlnGhqIs3jimeAzV2m0NcvNEiJlVB4+mH7NNgewUygsaY2/BjaAxpsOpS4S7kf
         vTkBal5pMegSK+WnLkYh53if/StQtKdrL2IjY11SZPQ1HZFp37elTMj4cUY1C8JOPoeh
         wHgAPTbwe/NHuh9Di9S21B822Psl2MNcgeiexD3AoUIDW4pieLfYJ3AQiZaEymcwxTfy
         IfwaxCq9NnWgK89NLCJ/T1BL+Ngyali4CntzX27PqQl61hnWS5IUWy1j0eXirgZUie4p
         w7LWWR3ylA4IX4a5RX98rGAWLVZY/t1UjZrva6kS60U/O+zlcGGDZuAL7hHh/jAmvibk
         9Ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752777936; x=1753382736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lq2qXRTV07ZyxJO3VWSgjG7vTWGiG8uJDpTR4dmthYg=;
        b=NIa3/Cn20BTj49ok4AQfgMt/r1AfmMAs03oVDcKLKTD6o3nEifLHI2oHBqk+rhPE05
         dHmkAvET2ZjzG1+pmmXWrqAKCisUJPMtWRqCGJ+LQ+KpZVtk0tvX/5gW74PDIjUvgdwk
         nMmMWZneq3clgl1cLfxgw78C13LnaYdSxu5PYamoBrFfabj7oe+d4bR5ZSl60e9nHFqC
         0+QBXC406P/CNFJmKHtzN2h9tjO7kmOwpSpFWae9tPonm5rBkSqL1UfpoZxdXMEdZRys
         XrYmTK9WNKlTbQ0hTd4fVnJfIfoZb+Lz3+8j0/ziCdqIgA4JshBYz0ORFFgAelmtAsDJ
         WgxA==
X-Forwarded-Encrypted: i=1; AJvYcCVHbpz9UizLP+tdDqJNqmfpNAG81AW93A0YxQBO70KrLzjLD+30Bw4FlBfTFfscpiEu9+xXWGIsVvFyYGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSesNVB8Gh3Ay/72dbXQXpseHxDnmGk5WkuYpNpyTLH6YqiFOn
	R1lJm4K5PTyU4VREwBpPK5V+D8tI+GzNFCeuJjWEGhUCyPJVZvMqcobIxYMD/mw/knzNJ66fCEC
	0MEqA
X-Gm-Gg: ASbGncuUqQnpE0CzBPdRoRHOwwfSYwg7ptibc6um9XcLw7X3syfvd6YtO6BlI4oHKYv
	p18uHr4FCmC3U4Ius0Qt9YkfVRP0Saf3IL3htA0fqE4vyL0kxaW4QvUH0x+n4C3fyLQatnWgX3/
	KQryVEZeF1tne46D+v6NQCRNZgmozuZA2g7qHPt6zOM07K/8xy0x6t0mK5MUoI+iW81Paqgee/6
	bJJRAk0hZs6KpYIATPZ8YqDuazSGeqiP3CzofAnPHdSzO0UlfMHrQVLyxja+30qyUgIzIYpHV8q
	ONX1DOwRrtzhePsxy5BaJpijOKyknmB/nTQR7ZO0Co347ceGE+h6JQ5XquAOfUdMwNS/CkaOdoH
	BI/NiR7zaEqJUb6QjREE/prPJJwNXww==
X-Google-Smtp-Source: AGHT+IF1kxsKho7uNfC6NyyIk0SBA2f3pmyOLP/AFuxSfjIZkOdeUcU8zmuAMfH4k8S2Dr4K3Gc4KQ==
X-Received: by 2002:a05:6830:43a7:b0:73e:54cb:1ddf with SMTP id 46e09a7af769-73e8337798cmr6187a34.8.1752777936530;
        Thu, 17 Jul 2025 11:45:36 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1982:bb13:46f1:2e60])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73cf12b62e8sm4068736a34.60.2025.07.17.11.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 11:45:35 -0700 (PDT)
Date: Thu, 17 Jul 2025 13:45:34 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] irqchip/gic-v5: Fix forever loop in
 gicv5_its_create_itt_two_level() error handling
Message-ID: <a6dd885a-5a1b-41b5-9673-0d42f7fa929d@sabinyo.mountain>
References: <cover.1752777667.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752777667.git.dan.carpenter@linaro.org>

The "i" variable needs to be signed otherwise there is a forever loop
in the cleanup code.

Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: no change

 drivers/irqchip/irq-gic-v5-its.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
index 340640fdbdf6..55360ae9f1f6 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -191,9 +191,9 @@ static int gicv5_its_create_itt_two_level(struct gicv5_its_chip_data *its,
 					  unsigned int num_events)
 {
 	unsigned int l1_bits, l2_bits, span, events_per_l2_table;
-	unsigned int i, complete_tables, final_span, num_ents;
+	unsigned int complete_tables, final_span, num_ents;
 	__le64 *itt_l1, *itt_l2, **l2ptrs;
-	int ret;
+	int i, ret;
 	u64 val;
 
 	ret = gicv5_its_l2sz_to_l2_bits(itt_l2sz);
-- 
2.47.2


