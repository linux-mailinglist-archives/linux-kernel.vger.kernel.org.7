Return-Path: <linux-kernel+bounces-841425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566C8BB7470
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 17:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E92E48576C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474A6169AE6;
	Fri,  3 Oct 2025 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/7ol5q/"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD7123A984
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503794; cv=none; b=WjgZek52icWI09jOFwOWRnLGOATA3zI4SJxeqJ7MwtH6GfBH0RfYcVp32LoJyY0GHQIJOpuyOrAKjT4avPBr+jdD8CuAE9ESR0LvKIHfQ2iIZ7UEUQI1sJ1DqYojtU18M6uWVlH45kuVWKvz+tAu1bfMr64C46Me/xhayNP8dOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503794; c=relaxed/simple;
	bh=owm4ds9OjyTLRq3vRT/eCnc2YctqsonLioVmqEaKn6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MyFvq5idsKc9pmY5fNszW16Sa6MyAz14pMqnxatZZIGZMp3gUcFmuKKw1cCP21ndaGRxU2eVNwiF6eAPFo6TcYfuhwA1SOxlOlMQMG6QFKs0slgGJUNjYMgb4CittwOChWtWrPGp4H87YuxxJP5WnYm+JkzrHZ5JAZOcUNE8p2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s/7ol5q/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57a604fecb4so2988091e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 08:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759503790; x=1760108590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6I1cp+HxhEc7B3vUrgn327X00KQrCoI8VrJ+oGMKDrk=;
        b=s/7ol5q/hBpGqECWeXUs8LB0+ZAYXXyuigLKkfQniPs02PYToa116o65EBP2Blsy0U
         IJftC+P2UoASHrpQGW6vpgdhkFdDo3jTx4p2wrNUrYOMyOw3Z/pyn8PtG7EKatfO8vK+
         uNIGA53SzluYlPtA3d3xXr2fmLhU8qQKHfCK7jXiSP4F44zJW8Xqzb8BhY8OzTv9877X
         LUEbM2fNfeCFRMOYmNeUKnsJ1L+I35W/iJAtE+hCgVVkg60cmdBvm6BBSWIvmNdgaOCh
         fiPt5q5WIwWe6Px6WI7OKGqjuOb1OuQEclaeDqzYxWXKuFa9YKCa8joH/nSLV98i+ZIY
         pF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759503790; x=1760108590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6I1cp+HxhEc7B3vUrgn327X00KQrCoI8VrJ+oGMKDrk=;
        b=xNdul5ZJaPyiElHXxw1Arvc4Nz5TTbTfD9wP/nq5LqDgrRkyjd7b/yKuO2di8okMDe
         Yhwn3VTE4LrZneoLQpiSMBPsw12XbHQkaQHvUAffBVQrsTOK/z8jQ7vSTdOte5nTuSRp
         9do0FNRPBIM2uxobMQ+EXorGy+2mFTF+/5nfwqxpFkRtzE6kIA1GHWBw9MzJJZLKfJj0
         SBJRDp5ewv427UuFyLVnGeEg6evUiSeBVEUusw6Tvs/UeJqjuKQnVuHXgDvfC1do+Myy
         AWUFpvUVFH5ajiy1M1icgwJPw78YM4i/Zp7lHWB2DtBr5yIqeHicP9WnVLwdIaI/XXYa
         nQ5g==
X-Forwarded-Encrypted: i=1; AJvYcCWem1eCLekIIIfcqQEf2dAv0UQK2Mf30G4qDcEmmd/EjpPbbjzcR5MkIbckIPgoNBqhdj6YLKcoaJOe/6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYxD0jyDqizhYWVgqlkkl082ItaV7JAU2eGPzuIA6zPcIsh7EA
	Xgsb1Wyi/H2ypkJ8hfQgwfx5Ua6X0AWWSo5tGcfIu5NwbqJ/Acwww2S2quroS4TE3a4=
X-Gm-Gg: ASbGnctR+BTjJ3AmCfbRy3Rs6kfprlWZb6Frpho0XvTUZOdXXjYlGDLnh0SdOL39odK
	1Bn+8YVa/aDqvFvQabL/KJV+Hqmlbv5qCOVWdrx3PDpfMdeplD23T3SF94bs3QL6ZD7O5W1NQ7Z
	DKLXVoYvJy0JPQ79DgbrQv9f7HLuroGP725JoLS8IC8JNyjkjTX6tH5V567UEvmYKUDcDvOVzUv
	V+GOv1T9mEk6u3QWjkKYtGN5L5RvpvyPjjTuqx6R5yGoQqIXiCE5BwPeMxE2f+vz64B0L+CIf5y
	Dr7xZffs6Q81BKep2RpvOmVszGzTjZn+nJ6NIPC8Fwhl7705bxUvIBvmZ95UdquWOr1Ecn4Jchn
	qVQaZUkATolJXf/GYHJ4MxWM77SsTFClUbM+pB15qCNcFLp2CDGrISDizgqJ7XfZINB12P/33+/
	VWK58EpastMeRBsEg5B2VIY108h8mEfLV6/UfiM0xiXJNaDQ==
X-Google-Smtp-Source: AGHT+IFDyf2CAvnV4x29ZpVZ+szdDhm4mElGlYbHAAsCPKVjg7GYU5VG2tOvCk368uOv15rIxkfSIA==
X-Received: by 2002:a05:6512:3f28:b0:579:ca71:2750 with SMTP id 2adb3069b0e04-58cb9f0b673mr982744e87.2.1759503788264;
        Fri, 03 Oct 2025 08:03:08 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011343b6sm1933369e87.35.2025.10.03.08.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:03:07 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Maulik Shah <quic_mkshah@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/3] pmdomain: Improve idlestate selection for CPUs
Date: Fri,  3 Oct 2025 17:02:42 +0200
Message-ID: <20251003150251.520624-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platforms using the genpd governor for CPUs are relying on it to find the most
optimal idlestate for a group of CPUs. Although, observations tells us that
there are some significant improvement that can be made around this.

These improvement are based upon allowing us to take pending IPIs into account
for the group of CPUs that the genpd governor is in control of. If there is
pending IPI for any of these CPUs, we should not request an idlestate that
affects the group, but rather pick a shallower state that affects only the CPU.

More details are available in the commit messages for each patch.

Kind regards
Ulf Hansson


Ulf Hansson (3):
  smp: Introduce a weak helper function to check for pending IPIs
  arm64: smp: Implement cpus_has_pending_ipi()
  pmdomain: Extend the genpd governor for CPUs to account for IPIs

 arch/arm64/kernel/smp.c     | 20 ++++++++++++++++++++
 drivers/pmdomain/governor.c | 20 +++++++++++++-------
 include/linux/smp.h         |  5 +++++
 kernel/smp.c                | 18 ++++++++++++++++++
 4 files changed, 56 insertions(+), 7 deletions(-)

-- 
2.43.0


