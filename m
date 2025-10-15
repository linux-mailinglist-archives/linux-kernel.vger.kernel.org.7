Return-Path: <linux-kernel+bounces-855228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C384EBE08FD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5F94206DF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B214A30749E;
	Wed, 15 Oct 2025 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mYb4vZj1"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5101DB13A
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558237; cv=none; b=nzi0AQ9I2G21vJ0EM/8Bre6DIYZ1vnDQE7PlYsMD1iGwbLuxg41nJRObjDInK0jCdX3Y1oy4WlORuO9jVx6skPdTYOqw4UzKmV9i6ost9fkgWOb/hS0c/wOoWMhtNsyAwBhMEL9ND7yR6oMJtuAS3MRs4guH1yfswzNcQTOO84w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558237; c=relaxed/simple;
	bh=MLXPF0QgxbIeETXLyqX3g4+Bs0uPMnPTEoY8SSMui54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaGVhVus8UVfW8SQzO9eiZPyEqjj74WDEXv2uOS77wooY7cKBCojyhYMrrPBhHKzliSmiXI9TI1k6fUEYIEF3efjuRTYaCfJMjRKT+Uopk19+1jCFeqxuH0fw2ofKr61Ig5PiDr7Enf890WciAhO8v63fbWJ4fRZSr29PLVBMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mYb4vZj1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a213c3c3f5so2559b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760558235; x=1761163035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VigWJ0s8yQhr+m/VwpfA3DOr5u41jNPv40KwlpsnDE4=;
        b=mYb4vZj1Ntt/7kOk/fwAdhgnDoqmElQW4EiBMlc1alUL4tkbhXbKo5by+wtzvWcdUK
         K1/Y9AcjPu13oPs09y9saN9uv4jwlr3sekV0J57wAdhur+2zjX3tFftQNrbdyHcmVn0E
         F7H5XxYH5wiAqr7OUQnSe97quk4DkJ65ugpUnD8FNWpQ+/EY6eCckQ0b7duiAgrbJhzL
         N0oIsfl1wR5gHYcxIo7aYILagn0x/0t5gmNQ7u+eQUVK5aL3ekvut+8Rx+cqFGjHjyVU
         IoXoah2vGJVaAMMs3inMLHxROobK9NzBiL8hhC7HCzojKvUrVW2x6RzKFnLPMI4NfZCt
         nJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760558235; x=1761163035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VigWJ0s8yQhr+m/VwpfA3DOr5u41jNPv40KwlpsnDE4=;
        b=DAoY6VV6p8x9V8Yy2RfajEt9AoIL+5awh2T4GpP5zQyT6fWY4RxVx+Hh2SNKokZIVz
         MGD7UzeAFwjFVUL5PhlCWoksNyVCOfGu0Kj7NtOqUezy28mh3Sng69t/Uoz9E+ey5kZX
         Snc5LrfYl6f9599g4jTH3bpI9mLkktcB7rrUJIzY87O+HALedlw+Y1sS9HC6TxJOmpFF
         /Nhj2PK6nXmz2Jq7vX8IipD/1zvAtyBGX5aoM/9kg4sFp1JRLlLF26CNOXTqMjzknxJA
         znat6WXaBJwzcx3jnEuod0gmhx6aIoCt/cACoQAYgk1vBUtOiDJwxY8IGf8Bw77oRsR3
         9MJw==
X-Forwarded-Encrypted: i=1; AJvYcCXlnFoU5p7/OcLQ48A9YXYCVvTMbWHfrNnHo7GPEahEYnDKwCAuPhOlldozNSbdEl/HoWlpnWx3pYHe+Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV94JY1HQVcwyqgOFBvrM1L23XWe/c7py8dUEqe0leDON1YmjE
	RDG4b5mQs5AfFzkG1T67wkjHzNbRa2VqnolTdCu/PpwQ0e73Ha8vd2mdFoDquwliTi0=
X-Gm-Gg: ASbGncsgf/cHc/qaPoU1O9ogzYQ/FBgKnwqlHMhsMJaFIq1Zi3TwIG0YzfnaJBRStJG
	7YHzpH2sqFTfkXGcaZQctAPGBDdTV4T1CIoQicWi/UnuERfkyfzlx9wZ/ufdqOi+irmtZzU0JTF
	3WzHcgGBNQO0cL3stsUw6Eatqbju0/QlVNk4TpjDTljt3CP5y/h9N9CpWMIssG76aW+dfeLQEUJ
	8Wf1RsOqGrSopPOyaFRnkkK/RUpkU6PBHfB5Yev4yNBcbXey2/jcbltTCdJKru9JXKamM+ZdXb/
	mwYYhPfHBBbp2xd+jEc8lVONu/b07sAEeEmABMowPjrCAkoNlcUcsO3nHsZdhJjs8UNvAWc1UIk
	8YGcZ3UXAXaP90uOY9+w/m356Nm9lo8uBabrx2AOSU+eXb5TKacmne0ijxAgAJORqs0A4+n7jpw
	==
X-Google-Smtp-Source: AGHT+IEyhAaC9z/YrPh8+QNDt58P5aYq0LIPPVePEvsYRW59ZLwjyZl10FeM552odxwsndFYq3etqg==
X-Received: by 2002:a05:6a00:3ccd:b0:771:fdd9:efa0 with SMTP id d2e1a72fcca58-7938723b3a3mr38560001b3a.15.1760558234951;
        Wed, 15 Oct 2025 12:57:14 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b06075fsm20151322b3a.17.2025.10.15.12.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:57:14 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 1/4] irqchip/riscv-imsic: Remove redundant irq_data lookups
Date: Wed, 15 Oct 2025 12:55:12 -0700
Message-ID: <20251015195712.3813004-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251015195712.3813004-1-samuel.holland@sifive.com>
References: <20251015195712.3813004-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imsic_irq_set_affinity() already takes the irq_data pointer as a
parameter, so it is pointless to look it up again from the IRQ number.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/irqchip/irq-riscv-imsic-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 643c8e459611..7228a33f6c37 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -158,11 +158,11 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 		tmp_vec.local_id = new_vec->local_id;
 
 		/* Point device to the temporary vector */
-		imsic_msi_update_msg(irq_get_irq_data(d->irq), &tmp_vec);
+		imsic_msi_update_msg(d, &tmp_vec);
 	}
 
 	/* Point device to the new vector */
-	imsic_msi_update_msg(irq_get_irq_data(d->irq), new_vec);
+	imsic_msi_update_msg(d, new_vec);
 
 	/* Update irq descriptors with the new vector */
 	d->chip_data = new_vec;
-- 
2.47.2


