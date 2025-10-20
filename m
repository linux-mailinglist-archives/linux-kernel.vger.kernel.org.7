Return-Path: <linux-kernel+bounces-861099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9A1BF1CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6757A4F73FA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645A33233F4;
	Mon, 20 Oct 2025 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJN6+Wug"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4643233FA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969854; cv=none; b=mC6TLORrpOe7P2rF+7sXNB/rlqLEUxnrJ8JxJQvBl8SNsGvvLw6muFXDfOGRcPBp4MM1dLtsOZ03bYROMimFexIc5lJg4m9E2DRVmSMkzvxgJ8kj5rx1ahCiO/v4A/9NXoHkrwSVYVVzmwO3GrPlEv85Po0wvT8XF5m+SRIjgdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969854; c=relaxed/simple;
	bh=fFwvfRX1utthycDd8a7gB1S6E3bKuVWapgtPfi/xRjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HKT8WbtnM6j/LibvWe52MSTBxL318mxNiEOP8S9fCVkE29Bhb5oQvXDJJtG9Xwq2C3h99VRQI/l9f8P+JM7NAGDijk/K4pwSCMemT3saYIG5s776O1K8NvsSj7hHGEhHXz3bCl3X89L2UDHskMcpdA/5JR27WHEb/Czc2tBwRvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IJN6+Wug; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-375eff817a3so48697051fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760969851; x=1761574651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4CIb+mZ4TdXD2+XOrnH5Psl6jGU1lXy8Aan9HS+a3c=;
        b=IJN6+WugNKC6STxXAblbefFSzR4+3saljJPLL0jEaRaQMqDOiwCLGRTINS8TSmZ+1t
         BSe5qOQNhQnwZ83olBBOsLe4+flOEP1wFlA3GtskdiLQeT2qOouSGQJavTzD0+MAorn2
         Zpvf/TziVRv9yD78KvH58VGw5HTqBxw0f48QXFDpDV3sxoGH7+YOK7Lu8riIhfMqJhuH
         J2z4NSgUTKiAIrgqbMXpBNLX46TCivSv2UCWe87QFa6jjnU2FEQ4qHjcAl259UHW1jeb
         RMFZO2Dt54fTkot1Z206nN5t6qgjmTCTtYI4hyz/qER6/yfLHlkXryXBZ+q1eBGWHfAe
         tTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969851; x=1761574651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4CIb+mZ4TdXD2+XOrnH5Psl6jGU1lXy8Aan9HS+a3c=;
        b=j5rey0eiIYQFkS1TefDZIJFKADMN4KtFStUY7osDvxa1MGRERhdKqoBSW19jC/IjJQ
         1BPxmQ5RTY1CrPS4LdeKA0Ju9RMZfNgrCmbMw5+68lcRYlNBnDQ3oZWhYW3PGtdPKYoL
         30ZouFzS8Uy3LpcxkWS47wlMYH0pfevpyAqlSJxTrm8tBGc1C5uHuyJIZl7jGybq/WrS
         tvqiooGxDOWKGaEt79iJgG9Rpg8zHPSFgrNGheAzJB6ievOKCRCyaoFnPYWm8uOGiS4I
         BHoxn9+iM8ZWbzK2E2r+w2aNnwLcJAJt6wVyATitYjYA5z0/uroH47QElvvMKmkJJPdw
         eNdw==
X-Forwarded-Encrypted: i=1; AJvYcCVW/hvAWNJ9005K9K/lg8hqgvYEolXArGch+TpPyb2icSZQjkP/ZYKAEkln6Bw+AWOlVtHTX357WOsRIUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYuIIjG1TBzkyJZURa15AtQ2UvLJZMWZ4bUIZxXmTwp+fX0QBM
	M9mekZPsx9yuzR3g3Vl7+ob3ljFYQ5YoOz0qaANUGhcaRT8X/OJEEeFZ1duEEQE48O8=
X-Gm-Gg: ASbGncufyfjIwaFevcxrzgZ3YeMYwkuSo9S+Iq8mZQop53BD0Avq+KguFTDHrqWhQ8f
	tZDXpGDOhV1D+ybyv2mQR+rsxrOWf3YC/1eyl2xqoCtGlppiVNFt06dG6zSVd9sj988BGowT+2E
	vq8xO9h8wuRHBw4UacSi85KAxtwkGMYJK4AHa+eimhTVJC/pAT5gXqIfEYNCBaUlV69HIo+bt0h
	MDHZVHXPS37stbwMTmIJ3rhHhvvG2kXEQz30nOFBt17QtU8HZMKVuujosKNxZUMXHz0uG0EKAcs
	3VuwyzXxpJwXzctMS4HPf1YMozb+1nzxlQ9cffz4SIRSPzv4/vYb/4aleI+d5NNE15SLsdsDVwZ
	2GjEAfqF1sNn3DB+QGvYOH/ZhLwItGGhLN8Y3a9hQZadtVBE8enQbksRW+S8rTFa2Jo+/PQnxXB
	4hmz97+FdKeduRLuyVLMbo2xT1miP7NuYhE5F3sF3G9VCKU/membmGqbwtkIwB
X-Google-Smtp-Source: AGHT+IGaUa1A4Uzcr6IBjfTLgEHTVeFFWXgoQ0Z12nmLZQh/21hDjDxTbaAdxTiU3/Df8JDb3tz84w==
X-Received: by 2002:a05:651c:501:b0:376:46ba:864c with SMTP id 38308e7fff4ca-37797aca3femr42697361fa.46.1760969850852;
        Mon, 20 Oct 2025 07:17:30 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a950a284sm20797191fa.36.2025.10.20.07.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:17:30 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 0/2] pmdomain: Improve idlestate selection for CPUs
Date: Mon, 20 Oct 2025 16:17:10 +0200
Message-ID: <20251020141718.150919-1-ulf.hansson@linaro.org>
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


Ulf Hansson (2):
  smp: Introduce a helper function to check for pending IPIs
  pmdomain: Extend the genpd governor for CPUs to account for IPIs

 drivers/pmdomain/governor.c | 20 +++++++++++++-------
 include/linux/smp.h         |  5 +++++
 kernel/smp.c                | 24 ++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 7 deletions(-)

-- 
2.43.0


