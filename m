Return-Path: <linux-kernel+bounces-735235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0730DB08C88
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 033277BEBCF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7535C29DB71;
	Thu, 17 Jul 2025 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5YKgxwb"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D26A288C12
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754153; cv=none; b=hHg9IhDt6EOn3cyN+W9xzReq3ivSAflCgyB7ESXLnk19v3330sTtpdBwUzDkldZSNcWk2Imh13NUGrvOE6BjBfyd72RPGFyhUlCnfK0lwdwol0GVgCZK8b/iIdjBsTonuIu4uiT0f2Suq8MDusLe7tLyVLWbpTOWrjlTDskuI7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754153; c=relaxed/simple;
	bh=HzDrn/96Xz3SfWS8K6ZUG3MWbdMRmxWynifm9plRBB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxZhpkFgJbFsj2g75Shfigh4l7eProBlDvarcykXZtF0KzlLlbTU2L3CD5SQRbcO5yYoQYDFvARCdo0feOmAnP/Uk/PXyU6/E7nlVvK8re1IzsDUf6f/fjPOwJLZnxmlsJ1aog3+2BYozuFNXrREiBOjEtLP0AF1C6ghqqJvZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5YKgxwb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-748fe69a7baso842461b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752754152; x=1753358952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzDrn/96Xz3SfWS8K6ZUG3MWbdMRmxWynifm9plRBB4=;
        b=e5YKgxwbsKQd7z3VKA/rrWcuHs+MmhZJWMaEKSvhX8kFaH1QDwk4PprwgU4/cyYE8Q
         txsYaJVez/3FCtA6+ll5GTr4+ozRZRHxlgc5/xO6s7S39UbXvJC6fqdptKqCo9Ux1K3A
         t8A8WF2aJwZsd/SksB71drVQ2UniBBV9SCcgjvn0/dNqPLY5EYrexHB330qw9ZcoXtHn
         cCupybvOtGc8AHMopWReLwZ1bcoOu8LJ9zsk7RTMPVTe0wgaLina9hxQAHWLyRrGYzEC
         vZ4FXyDnggpQl5DOndluuXJ017pkSLUGiJKdsmFWqRHosFBtujnPKprsg/mFHBIwtGKm
         tbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752754152; x=1753358952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzDrn/96Xz3SfWS8K6ZUG3MWbdMRmxWynifm9plRBB4=;
        b=jUDvSKTs0vTEuR1My0piUzE8umZJ8qxX+rqB1VxsUH8wFVA0Mb5U+xRHp3ZW94kVAV
         +rghcwBETv6tJ0oWlNE/0fof3p8XWpgcVblLq4GS35NyXrVfMnAkIb3fR6w4tysT6uZS
         FRT0NfnxEOq/rBZmGDoCNqCkb/3qKhk7HUFJ53ngihV2Ok/lmPID9fI0sJgrMldwGf1M
         Zwjat8DK5yC/k3Btv/xH3euH3j73ZQMHilTV6gl+/ownfNc7E3ntEUYZtZzKVPt7CQv0
         zkK7bCtNNAAviIBabcfQmoKLNRk51mEmWZMPIryyZcrCweSbi76reXMQzff2oBJ17khC
         dr1g==
X-Forwarded-Encrypted: i=1; AJvYcCXLaR/8EWntEa4VZlLKroDfsQ5PsatJjhnwZ7lmX3G3HGvzkOGNDFE13+TahlaaX8dNg5NjOYopFH1kCvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfYF2MD05+UjJ/uVr5C7OtoCRGTYKEOlCz00mr5QFIX5c4D8/x
	jeba0JJ1ComcGE39SHsGd5HTkeeLqVFadBjBNd3phrZ3RhL6/BpBSwrk
X-Gm-Gg: ASbGncvRODPZSSilLCVjrBbRLOCTmvJgx04Hg5EO2FH6InYcvLF6RUYZIOOWo2lG9bF
	xaUmaiQXd+8RSjTnmPJYj/hBbZULppEFxewsXu/aZ3l3V2HcnE1LhliiVkDrcAOoYH5E91/8MBb
	qS29K4tiyT/OWtblTT9WVRwOL4U1zKU9BKdpLm467lRzW/CtjOFO3EZ4qhpvh1+3uDX9mUWlU4u
	GtlYZKcQQajSYMXg3CGdrPHOWhRq0DSTFdptmcs5s5qYRejWK00DHp4f7i3pFL6nTg7TZwiEwz3
	gvyiEx5sL+4SGOR1bsu96xCUI0RGNTPbVx9vWl59d/TWkTBk+OTLW41orzglVQpdDWphz+RkzxT
	UzlTiVggfI6cp/EtDSxWIc2ynLUvez/FDeVQnFO8n5iAf
X-Google-Smtp-Source: AGHT+IFdZ2hsHTLbyceNFpEc/eEDYpok2P9OHubrByEp/yHUTbBTjmpm8kuunn4A3Hnaghr8D+C9GA==
X-Received: by 2002:a05:6a20:938c:b0:21f:7430:148a with SMTP id adf61e73a8af0-2390dc2f772mr3608055637.28.1752754151647;
        Thu, 17 Jul 2025 05:09:11 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f46a57sm15353011b3a.112.2025.07.17.05.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:09:11 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: david@redhat.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	broonie@kernel.org,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	ludovico.zy.wu@gmail.com,
	p1ucky0923@gmail.com,
	richard.weiyang@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me,
	ziy@nvidia.com
Subject: Re: [PATCH 1/2] selftests/mm: refactor common code and improve test skipping in guard_region
Date: Thu, 17 Jul 2025 20:09:02 +0800
Message-ID: <20250717120902.23840-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2fdacd57-2314-47c7-9eeb-6928221ce516@redhat.com>
References: <2fdacd57-2314-47c7-9eeb-6928221ce516@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The FORCE_READ() stuff belongs into patch #2.

Hi David,

I will adjust it and resend v2, thank you David.


Best regards,
wang lian

