Return-Path: <linux-kernel+bounces-849044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 567B9BCF122
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A13934E69FC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7603225A34;
	Sat, 11 Oct 2025 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EXXBkzLi"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5882045B7
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760167880; cv=none; b=effEmpvF/3/IHElcHmOEdq/05Mp0CamoWw/09Y7qDD93jOTNMUfDh//p82m6F6fDirlnDp3tr36r1ry3NE+6AY/Rm+++uzP9cq6I4J/tTKVFa939duG8sqh/qs465yTkqrvXwB5Lbt4zuOvZ7UT9WnH3VwyDYVsezHwbzfV3k2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760167880; c=relaxed/simple;
	bh=kwAxQUlN802lmBDor2RBzQNdUjw7pj1/rC6fhdOuhLw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WVzeRLdt7+Hq+b1GCvjUJqVAqOH/ybYiWz9+53xJvK2Ur4mjZxsuDwJRg1YoJn07EyMDmwjlmFMf+aWRSL0JSocT6mvuZ1NH5gvI/ANk1JUBGNuYsnSvxlnrcshYbSOosrd/6harbd8NGnc+autGUxaUPXeprFk06ubq1tV+QFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EXXBkzLi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-26983b5411aso18948085ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760167877; x=1760772677; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdMBJd+0NdYJNozjHx6sefiMrrVAOso8TPvp+4QY8d8=;
        b=EXXBkzLiItCn/8H4/aF5XReRgsH98jIxoNJvDeSrw/gmZIGfkAn92wsKGGjGRbP8dv
         24U56IQ8OensnyDJQV8lFU6znzlrSOV7EFcV64VfiYYUxQhj0nOJIY7hXE+ReJAoNWMA
         v8eMhTsZycisKdJMtOmjQ3B45D4DjSPi/xWbH8VC7zg+loxe6KTzIzNcP08iKW47NNWo
         0PhSPeq/BPlXaOUBlER63jmhE37KpxBzvAvFktoesYwt/rcUVWcXuQYRlJsZKhAquEox
         2mVcHBvXEmiE3dMVKuHM5yq1lkYJELc334/sNdI1V4qD/RAoXxtifasJk9KNEGcHly2C
         sTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760167877; x=1760772677;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdMBJd+0NdYJNozjHx6sefiMrrVAOso8TPvp+4QY8d8=;
        b=oGtSyaGyoGZ5UvXg2SmDxZNdwa4db04TN4muUY84NwT8dTtyzn/Ou/Mp2OLbzxhZTt
         QMaPSL87KjdMr2mZaboana7iSkcmbaOEG26ZzbX5dwr6SnQ5LYwm32bBhzBx1GisRyvR
         aW2oJtTzzxkRqwYlmfPlkM25Qvr3GSZH6IWtnAJObbUKQZgOiLQcALWNiuUfGZgjC3PE
         08AzaGYQEiXXt3EPrJol08YRvL6AiVk57k9Y0XjWZFHLI2+Fq35CNljH/qrwNZia4DBr
         gyli5hFUc35jtmHE/P6w5gPvU3W9OWNFOw7eyt7gaNwyet3G7J2RVGZvi46/co/xdZ2p
         Np6w==
X-Forwarded-Encrypted: i=1; AJvYcCVCiTA62eox807KMYEv1YxLtaS3eKqfcNm1SoALQLql0a39h37aJXWP0a3db/lBhJxgfDXyzy6Ow6TBS+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXxvpY0VjMdiSW2pfuqWDHbNv0AMi64JQLQpWI8MTcst93RExI
	OZzA76ho39efpeatm8MHOeWA81dRs0T9T4OZ8LqPIQ3T3eEoa+wHMAWgGYT5WU8ILIGhp3WmgC9
	Xf75v
X-Gm-Gg: ASbGncs0F85ZrO/X565ohy/BUT6DDPbfVrnu/82Zv3xRg2deKJEzA7vuKVRWBBdqgEH
	fKULqIT/TPJnwBwxM+3liaBV0BkSMQvEdRQIFFMd48lVA8I0bgQomu7veshV3YA0S82t+Ticdhf
	HVSRNtuQM5MS4N3lm5UaT/8beW2vYQRS5sVkiMB3CcoVL6+H7gS/4z0UaFBYpED/cwPrkSZfyD2
	6/IYibmC3frcwRJ8IzIhwHuYh1KqHjtNs1P0+3DJElRLY1TFAe2u6XMVRHFeo63ysSc5G4p2ltw
	siRVhxLFRVmd/R4qU/weqpYlFt7V7zmxM/M72VydFWkruSxr7QjLpUJcnLydTl4O7jiz9s4rTSb
	MG37aWPj7sNv7rRGCERONnfLa+yK5K9xhdeus2cSlPBbdg9F6MNjFLfd+AdKa8GPKb9gHKbnD3D
	JiwiAfUxM=
X-Google-Smtp-Source: AGHT+IHloA5eyjZBPMsfpezlHSFF1i9QnIBTBalmJfNg5htGoGlyWbYAhy8txTo6KnppNskqzm7pww==
X-Received: by 2002:a17:902:f641:b0:27e:edd9:576e with SMTP id d9443c01a7336-290273ef199mr173973045ad.30.1760167877504;
        Sat, 11 Oct 2025 00:31:17 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e20f8csm77020515ad.49.2025.10.11.00.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 00:31:16 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	jsd@semihalf.com,
	andi.shyti@kernel.org
Cc: guojinhui.liam@bytedance.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] i2c: designware: Fix SMBUS Master interrupts storms 
Date: Sat, 11 Oct 2025 15:30:56 +0800
Message-Id: <20251011073057.2959-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi all,

We hit interrupt storms on the SMBus master extend-clock timeout IRQ
because broken firmware left IC_SMBUS=1 while the driver IRQ handler
never services SMBus events.

Since we cannot disable IC_SMBUS directly, mask its interrupts to
prevent floods and make the driver more robust.

Thanks,
Jinhui

---
Jinhui Guo (1):
  i2c: designware: Disable SMBus interrupts to prevent storms from
    mis-configured firmware

 drivers/i2c/busses/i2c-designware-core.h   |  1 +
 drivers/i2c/busses/i2c-designware-master.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

-- 
2.20.1


