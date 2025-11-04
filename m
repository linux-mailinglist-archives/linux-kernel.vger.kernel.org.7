Return-Path: <linux-kernel+bounces-884886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C195CC316C4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66C718978DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6003932C33E;
	Tue,  4 Nov 2025 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFdYFdVg"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF8C32C318
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265209; cv=none; b=oJV2Xf+qezPx7rFSum47K2ENWuD23HKVOjnosgkxK4hVNe2cXR/8LcpTDb2pL0djbVMEeFu9StgwfLCMmJBRcQvkyJq/Bk1Fp+rH0I3cHGq3zGN8KqTJW3rI72kiQSw0yj3T0NU99Oi0qxoQLLbOEfkuuJuKEZozGf/k/Ei3f2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265209; c=relaxed/simple;
	bh=r8ZaJI6BkiaamKZiw/nt98SY/yLk2GfAiTnSKou1nxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CVKzPomNm6p8Dp6IW7/W4bMoWXiXODcGGaR+OSiFgywAydt6i9LbxFC8WJ2AGdh4G/PUjXUv/WDINS5qnBld8NNGX9wVfLaGRHGWp+85+UpiuYzF0ZyXW0PM7d6AY8nG5XgAVucFz50t3JLo1i/9EoTVaHZw7C7plfZTcXWCqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFdYFdVg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47754b9b050so7007845e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762265205; x=1762870005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jggE3W0Hv8sJtJDyKDC+MYoM1lxEF9SIqkGx01U6ZJk=;
        b=XFdYFdVgcB7XY9NLBlhgIy3ojEda/jQ4vpbTHIalN1jkUp2QmFGKJYauRFSEU+Q080
         07E8fuB6Vu7tLlkMoniMil6LOD8o2hmXA38S3rfS1S0YA7Qn4TgVy+Npge06bYSY+T4t
         g8HXtQ2K8zzJB2gTKFitWahfKvew90zDzxueeo2ay50vAt0A4oUnRPbTLrYLiqYYVLiK
         Fs42Z5TC1GVkP1PAifImElmNbs20YsFmdvo3/TlehFLmQDyDmfUX/AUi7G5Dk1/13Qox
         sNWBfy6wdxsoo454Qqj1gyEAm+frBjXcvhT6m2T40oawJO+qZ8IArnzS3Ol/0h0hm+2+
         E4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762265205; x=1762870005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jggE3W0Hv8sJtJDyKDC+MYoM1lxEF9SIqkGx01U6ZJk=;
        b=XpUr/bHfH1SFLcyg+EueDio36WbIew3ycMKVvWKrPRKqqcGdhFsmIR72eqAmZBm0ed
         muMfh+0sKzBJ1jTCJV3RTFR5zK7Tbegs1iLglWszfbbToccdPpSv3DAv2Q7tMY3Pn2el
         jxRI22KPfqpjDsjdz9olzX3/Qd6vsiZaaMqO2Jx/taYkPqC8t6mPBe5sZ6mSNJk1Oe9e
         E8anBDsKNlx+iqpF26o1+peWJJ+2WHcXnBE3Kbk5DDcDCxsKKMhEtWsNjkFZB/sF2cz6
         /COkmOkWNS+pqUnj7Nt/nXZJzY5Ag3lqqWEmUsSM2GOxjBeMx25+g7DnDugnoSDrJr4m
         PhgA==
X-Forwarded-Encrypted: i=1; AJvYcCVm3pih3TPLeJp/2pA8VaRzNxoU3xWZVIFDXvc1dqIC1oCzgqAu7x28xJzYital7ANYxIlXMUGadAP+hVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGdMa/eyFF/Z+IrkxCUA/wTQjd+07b5K7O853d9VqhZGNmJkTb
	RUAxe3Jbzg4aExlhlwcrrfEZRvwqaLOy9IDm0BeGX9+bh5Bu1B9KXbnE
X-Gm-Gg: ASbGncv6MqWePWMcleqL0vHwiJw+GouHYBeH2cZqLB0xrIWZ3Yqjx6Q9qp4tsq4/rH7
	6FA4d5Ydqi0vsyHtk4K+2dMMhJEx/unPcLOy0Fn/ehWnPgzNpoUawoxBs1TFK4LwB7lE4/9Znea
	cFBETyCYBdXNxcNtOu6WHMgPTNeO/4sczRFJUlVCtuIAXqDNR5082uqwMfVhOKMWy9UUU/hG28I
	n2PZAyrJpGBpPhCrPeyitkKjAvz2XFtgudVYdNF6WU3QTORJPSK0M1u3oxWTuTniZyoQOUwx7XM
	KUWYrqQX/VHqGg3G8bhrc2QYLgfkENpo1trGV9Ca9hon+iPYPQX5eQv258lpt9DqllFI9N+2VLY
	fPYejqpWk19vEGPwgUSAD6t1wf8/ffidTfgtHB9yWCHJLE4VaO4iQCzBszabXGyp3hpFZIhzfZi
	DHaDq6d34hZ4AoUm+SIUQvWbdi1Y1cUg==
X-Google-Smtp-Source: AGHT+IHsNLmv0MXPqVJXEKP05hHhFlO/+G8am2HvW7myoY1c6ojUSIh+/0N7JlnwOU/BddGjYdbzcw==
X-Received: by 2002:a05:600c:8b8c:b0:471:b5d:2db9 with SMTP id 5b1f17b1804b1-477308ab095mr153289115e9.21.1762265204067;
        Tue, 04 Nov 2025 06:06:44 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47754adcd08sm52511205e9.5.2025.11.04.06.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:06:43 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 0/1] cpufreq: qcom: handle ipq806x with no SMEM
Date: Tue,  4 Nov 2025 15:06:29 +0100
Message-ID: <20251104140635.25965-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series handle a small device family of ipq806x
devices (Google OnHub) that doesn't have SMEM init.

We improve the SMEM driver and apply a workaround in
the cpufreq driver.

(I didn't add the review tag as the patch changed
 with the new implementation)

Changes v3:
- Drop first 2 patch as they got merged
- Use of_match_node
Changes v2:
- Rename error macro to INIT_ERR_PTR
- Return -ENODEV from smem probe
- Restructure if condition in cpufreq driver

Christian Marangi (1):
  cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM

 drivers/cpufreq/qcom-cpufreq-nvmem.c | 35 ++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

-- 
2.51.0


