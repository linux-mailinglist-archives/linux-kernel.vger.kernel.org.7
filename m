Return-Path: <linux-kernel+bounces-867058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CC5C017FB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC241A646A9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD947319870;
	Thu, 23 Oct 2025 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sNraloUD"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBE4314D15
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226453; cv=none; b=mew7Otk79jzZV2FSh7zKtvVFoq+vKIsaJG1MKECZarxeKneTFkIrWsBScsGfTEpmLxcAs21gkqpIQAqMJdhSrGD8K2RXRsD/WPpBTGdRIDmyi6oNx7ttOwHjhkx2QjK2Wbyv2q9HqYIMkDL+w6r4Eo99Cqih6vIyewznRe8KRlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226453; c=relaxed/simple;
	bh=bSW7rfgtDQGPDS4VUfy3VAbqzFM7dWBO3YRWYHobxFc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xm8R403TlmOyNYuDXU6y+ABPODXlhuMqGZApKVIUgZsVSHmeZY86NsdGOg3f79FjkTF87HoHg0BKo+q66Y5OYC5TLx51y8XK35PbIM4MRm1vUSkunslEPO9PGMdjUWfiE0DTA2Urqpu+obIT4UaOnoQBdvPaxaDKiPNb/h6Qf84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sNraloUD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-471d83da4d1so365465e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761226448; x=1761831248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kn0n93gjogjSKpUc9SVWlrCOjCRjVkd4BQ8C0NGtc/U=;
        b=sNraloUDRIzWKp8sxjib3o25Il9pF5s2T6luMBW0HkSEQO9LYLKQe6J/rPkchDMZVF
         /Q8yutidAOZIvJoQJQdfqk5EsgV2sGcnikR34ydDoOwZf+lHQwnwAOsda+0yTM/x4WS3
         wfblT56+vjC85mPcRecZJRDGurNkawgeKu/eO7tUej1smVHuVBKl9OGjtpyYZK+zAuvr
         D6QFyI+J+TYDUL5YkhejmyAAmFsgVBHOHz61dkIH0xkIlxkpqlX7xdAaGq+6jeCLg7ZM
         EIFNhQbyGewxiXieYw59xhvJx7Eky1ZcF5fpfyJMBuZmubu/sdDBlMYyprnc3BLnURp1
         Ktyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761226448; x=1761831248;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kn0n93gjogjSKpUc9SVWlrCOjCRjVkd4BQ8C0NGtc/U=;
        b=oV7F1YLndKtRx7dF+Tf8Enh7QX8+YmKz49hQogEicBX6jMIYN8dOK4WV0q0idA5V9U
         gq0Ppaye5bXHopDM3weBcNlfvbixAeHgLmO1UKu9xIKXDgNgSfPQk0MVV7UfuxAWeJ1c
         0Ds+RS9GHPAeOsBr6RKc8kAGL9Pmm69SJVFePuzsxy+DBvJUEEQGnzTKVdZ3WnqWHm9Z
         agv6qXmvsvjrIN0rh/oWPaf7m/ttL7TbQZ2+Pz066A1f522atbsduy7orOS/F5+ObyFX
         0zoU8U3euSIqh3r3saxVciTM+LNnZcjPzDGJoA8z7kIrw2jokuhOb1OOo9kFDyfhDv/z
         Fwwg==
X-Gm-Message-State: AOJu0YyfJtGvgaKraxUl15DwsUOA+oGN64Nt33Tvo26IBGd8ito1JMoH
	FXX+9m3CKl8kl+hE7EyNv5OmIi0PUXWYbCKW1Pbu9tt/bgeDGHILjb7gm7pzW/Q9BZ0=
X-Gm-Gg: ASbGnctAZPJdU3CjlE1ddtHuptPgGvSzOr5ByX6So8arRNSfJRuTiYmEMLIjpXY//LZ
	fszNWr59VmMS3LsmJ9HYhkRGYXR9seMszLdN6yJm2jpZerQWTDktiCje9PUi0Oig4lMEIqWW4oL
	5s7uzvDTFclpy0pjanoQMRnJ82lXHt4T5WSpLypzJ1mqKEGJ1jp6ZVgkjFrGoxC/c3BFc5DbFEE
	duq8XXlnBPGE/fNMkvtST2hFcV5PNjbKyDiiMcI7CuSv2FBuOhg+DaTorwfbEh3eeGNyrREV+gG
	DFkb2RWuccmqInMyYs7bDRWBmmDBoCS6XyxptesoT8kkdOnL4hjjwwj3F2gwC76K60UKvAVQBXK
	DKtFZard2DwViYt0+Xr2uPbQzosXPahGShjXUr/dvxs4PrcujemN007G98njVDzDDKHFcynn/v9
	sp0NFh8SVlY0PuSgA+5JrY3dHFUTo=
X-Google-Smtp-Source: AGHT+IFsde65CJFTvtkSZupSMvUZM0RX7wQDUIPA6gojMigbtbuO0hwv7Ss3zHX5Cl6STVOTHym5aw==
X-Received: by 2002:a05:600c:350d:b0:471:3b6:e24 with SMTP id 5b1f17b1804b1-474944c2050mr39159615e9.8.1761226448360;
        Thu, 23 Oct 2025 06:34:08 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897e75a0sm4037198f8f.5.2025.10.23.06.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:34:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-kernel@vger.kernel.org, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20251019180940.157088-1-biju.das.jz@bp.renesas.com>
References: <20251019180940.157088-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v3] memory: renesas-rpc-if: Add suspend/resume support
Message-Id: <176122644698.70962.12759967875481339805.b4-ty@linaro.org>
Date: Thu, 23 Oct 2025 15:34:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 19 Oct 2025 19:09:38 +0100, Biju Das wrote:
> On RZ/G3E using PSCI, s2ram powers down the SoC. Add suspend/resume
> callbacks to control spi/spix2 clocks.
> 
> 

Applied, thanks!

[1/1] memory: renesas-rpc-if: Add suspend/resume support
      https://git.kernel.org/krzk/linux-mem-ctrl/c/42ec0bc61f052beb0d9a6a889fe746591de74508

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


