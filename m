Return-Path: <linux-kernel+bounces-834041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B71BA3A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838EE171CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6312EBBB5;
	Fri, 26 Sep 2025 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JmtkoTuM"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E3283CB5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758890612; cv=none; b=bJOJ7jj2yWvLQEDu6VoKM84L6ZzYRSH9YLbJGah4a9Kify/jYKhujXM+2pVWomRYGIh0grXYJgh02CmQH7jCZiFTI2IeY7NxdyZpm2Nbh6W3zIgQLxTKWzAEwxX6u3RJQ1eV+6LgU/8FuPijkbTiHvBAMMEFHuaMmeDibdi5mNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758890612; c=relaxed/simple;
	bh=WwwCAulaw0W5eNIPLrL7FCFXtw/5faEavn2inNn9x+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LoxsQteoQ88qR8AUpQv0Xrj3thnrKnnpzzizKKsBgDm37637dFoL7EroByIY7c0MXFs7MdgiyudvRazFybGMi5rplQHJJVhJoazuLA4UiH9XO5cKMez1j5CRJ80tbdSaUWhwul5Dlr0Iv5UpJuQUtAArvDbrt6qIyo1fq/sdcZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JmtkoTuM; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57afc648b7dso2609046e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 05:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758890609; x=1759495409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m3TrlPJojLwz8IDO7vEe8n5bv1r1AjxKFd90MIa952c=;
        b=JmtkoTuM2+FTraahVrcbpWK8lAMLgU6rSy2onKbA00DrsxMm1CTWlrypMRPlgZLZod
         uHQHV5Rk7lovxKanm7v1RieW7pHABQlNf5awZCS5kEut0/k0zM+gR60sWz5KmK+fM4nK
         GFy/Mv+3Xb5jHiaggfGZjdPkJo/WODMTB0AWw/EMuBrvpC83cjG4woz3fcv1Omk5Wa1D
         sw/NDd4zgOTPYIxnBbYH/VTDUl1PitNF0rAFPH7RsXDWulO9QVh0c/VQMDTcd9ELyu3H
         trdMoLYeeD37zvje+t4hh8aggHf2OuevZ3YOLrqLypc1GNZRTfIltpHAUHIMS8mhhceK
         VB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758890609; x=1759495409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3TrlPJojLwz8IDO7vEe8n5bv1r1AjxKFd90MIa952c=;
        b=rfink+vhVcqoRQ6UOgxvURzLqUv5UJVFqMoS/fTUfuTDoaqZKW4QzNVAKu/KzB3gBf
         uNithen7rtQnjnRIy7Z7Pqy3OJpxWuta6OcbkrgthP+hKRCG7zwWy58qA7jFuORxLSud
         UQhn/UBK5LdVD1gmKcj2vxJ2BRwjKGXEpkXxK9BrAGFFAKQ34L6BamQjFtwuWdIhHwnj
         YySshXlcVZcbjsqIrmLRSTJvnynIPpzAKOSci3ogFJgkR05o07datMXTBSQOkXWvpBn7
         IZ2J8alzfRkP8zMIdDiIWpEmMfpzG5T8tTKnqpSSm8RqMGrbeS6E8jUyCG/SyPPrRjHa
         bpcA==
X-Forwarded-Encrypted: i=1; AJvYcCX+5wJcQB7YkaIYwIWEfHDC07kFMTvtdKHXm8w03MKj76mCVWzYdHylcIbw3X8mWncgv636rLwB5QCsGFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10QbSTumcOorz10xAf0e5vO52ZEj94oHQMr7uBmEEU7l4ae8U
	TtVOIe6Sb5wLgf1UHAlXvHQNo/xYa9zRER6t8IWuyCpIuqdJefqxSrgwlLXG7PCUgCc=
X-Gm-Gg: ASbGnctj2Gtm1Adq/e7HqTJs5lJq3C4vKOzx7/vd63+Xujyfx8UB1dpoHQFj3vouZpT
	RDyhN9k6WhHWif29y2HZOnuR9uMcnRPPI0+7TPvoVamKf6YK2hh4ZpYLmM+Wr64/SfyjuCWbmJt
	OnXAosW9V7GU6s6FHw+zLdA2vnLntUuzNceZv7UiQYCdeOSPhUQWNmYpe+2k6wipDzvbBUA/l+3
	7RtaKWWKE1n37E0FmlA7brlp+sbhMC/y22A6Grxi9mG5V8PZM8wZ6WlVcEiPgy5caTIEgWmFibm
	ZQ/a08xKUdMezTn8ZXRPw2aD2NIu7QK3F7DYBSXjg/mRHrhNEwFfC7aI8g1Ip73ZuQf1cmc8rsC
	rib9cpZlRvTROaOizwinPdx3WGeWIqMxs7NqgRN6cjGmP6dn0JnfFchE1XjtpbLmhQgmdTlSj
X-Google-Smtp-Source: AGHT+IFSMUZyGErx/ATx84tcpejpRIj9agjrcxBG83lEZJRIvJ1l/sc/CKJcJP/p3DJDSM8naP+IrA==
X-Received: by 2002:a05:6512:3b20:b0:579:c694:fbd1 with SMTP id 2adb3069b0e04-582d2f27ee6mr1917262e87.29.1758890608833;
        Fri, 26 Sep 2025 05:43:28 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5831665671csm1724276e87.75.2025.09.26.05.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 05:43:28 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.17-rc8
Date: Fri, 26 Sep 2025 14:43:27 +0200
Message-ID: <20250926124327.212581-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with a pmdomain fix intended for v6.17-rc8.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 303010f4658cb134eb27cee88026fb5d065a48cd:

  pmdomain: renesas: rmobile-sysc: Don't keep unused PM domains powered-on (2025-09-11 12:36:55 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.17-rc2-2

for you to fetch changes up to 5fc4ab3269dea6a0b00c7256cb6f6c0101b6a44b:

  pmdomain: mediatek: set default off flag for MT8195 AUDIO power domain (2025-09-23 16:33:34 +0200)

----------------------------------------------------------------
pmdomain providers:
 - mediatek: Make sure MT8195 AUDIO power domain isn't left powered-on

----------------------------------------------------------------
Louis-Alexis Eyraud (1):
      pmdomain: mediatek: set default off flag for MT8195 AUDIO power domain

 drivers/pmdomain/mediatek/mt8195-pm-domains.h | 1 +
 1 file changed, 1 insertion(+)

