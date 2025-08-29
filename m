Return-Path: <linux-kernel+bounces-792263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E856B3C1FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC27189C44B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFDB342C8A;
	Fri, 29 Aug 2025 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qet8Ahmk"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF753238C0A;
	Fri, 29 Aug 2025 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756489383; cv=none; b=rGg2c6iv1VpJnuNKdYwJyAiy7T4CrWZxnyFi/tFGd/8rejJkswlD2B7dN0BeURkt3CmRYBrNK4vAr5p1tjNYIq8Ht/5WCbnOSHrjqwHAKS3RbD5r0iwnfLlpjBOp83oH0U9RH21MfWntGKEC6aZsTB33o7WdDgYl+19aqw210tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756489383; c=relaxed/simple;
	bh=CVgM7Tyu00zzsMBseHOctXjMN0Os3f8IXfyGMpQmnqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4ElrvWR2KSS4+Crg1ovmARZUJFCfUh8AQqapja03ptcw3odfcWvGzmYaAyTg0UBaGlRICV2Rs8onCwAjmtpdRTSKBLGjH1bQUJfij4FAy8upNwK5EXo0z/1ynTyggSdZk4/aH9Ja1S8Y1xURmWwYXySSe1HrXf6/LaV1PH3Vvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qet8Ahmk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445826fd9dso28342325ad.3;
        Fri, 29 Aug 2025 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756489381; x=1757094181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVgM7Tyu00zzsMBseHOctXjMN0Os3f8IXfyGMpQmnqE=;
        b=Qet8Ahmk1rTLMyf5mZKm27IekxEfh/011F42a/lT1MIL9UmUIbOVH16gaUPqf1WaWi
         Lxd58EOWi2ZYqr7ZjptWx93VsJ8+FZKbPdOwtQRDuV1bduOrr1qqU9S7qPg2t5PydfoN
         TwxbRaR/SGXsLT10C9yeiM58tWVlOg0Msx9WQsD0q95dcTjpv5N7NXL3+Y5kgmUD/WFW
         9JVy62U9yA880LCDxDNz76L+Tw/XVyJeYNKTAVgeVP6yGbdfVIy8c4h5/KIVPqhJrWeJ
         wjoZS6nPusLStcOMmJnSA/0sOjYVVZx5ZKLqLAf8bC0B4xJ7CMNvUihOieUeger1yS2p
         esYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756489381; x=1757094181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVgM7Tyu00zzsMBseHOctXjMN0Os3f8IXfyGMpQmnqE=;
        b=fynYKc85km8wct0S/hpchIbg2+DEd8oNCUTQHgKzrq3G9raKRFTctd/gMcXx4BE2vK
         mzUi0BLvCE7vzuM0zhe8stQjntWdCHmUH0AwS5UHMNFuGm4GUB8eRyAaRHVmBkiJhiiF
         vAbSBI+6ouz8USvNwPrJS1Eh0Vip0K8av9ItOrmeniahgQ1Nzz8GNN2GKiXu9MOkYC2e
         LwERw5dGofxYl8uSDQfeGIHSr04ML6+kdOYm08GRZJ2FnVXGzW/PWEVsc3ACe+JC8vEW
         hf48z/a4jTuZp5yOM44lIeockSiO7T73SztAQRDGrpZam8DCZEDfsKEuQ/7C5MqBCfWy
         973Q==
X-Forwarded-Encrypted: i=1; AJvYcCVp6Ucej5w+RT5eaKL65NUsK4/YUY250vGFwbWnc+PtTQnqcCvzZsJWaNBhjZlGgD+gelq986dO5/qcsNHB@vger.kernel.org, AJvYcCVvaphjV6yxVdOdpJfYdt6weFnkEUVGRT9xDOwPPCvfJ9HXna4ZyPi3IUc47C5gTnDhTBNaQKJRX84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcn+1d10jhOdMYCLFRJ7tAg23oJ2dqHaZM6py7T/vhTGLXpIVI
	+GOrU8ofLZFzco2RCL3CI7nDMJFb6PZoBScudwwAv8SnEJ5KfnIE+Fo5
X-Gm-Gg: ASbGncsEi5u1m1cJ+7MIqwagOsjeWzSB8zxrlnfdCYKxSa8Zten3pHa8yEPqKAqWyam
	EQEUMDEPk1n0bKf/8nw/+FqTzbLz13tiwIjV9MsxKz402p8RqAuRqJ+I5bhWCFyi/Vf6kT58zZt
	TqMigRvEggNo7J0C7/vRbVkiGmqjMCMooxhxl1fpJ+4UPvf2X8lTTwlaiRXYBdCtei9Ry583BxX
	8GhrrzPrnWDCG/fFObhhibavbGumUB0BYyzlCbfuAs7wzj5udsbvqEa3/PhkVZAqAwd/L3tznqr
	M63UPBkEZqtWL77/2cEguNosrtAOLT6l4yOl3WPFBQavGE2zwujLMRjkhl5ySoWO/ScLv8E06rw
	Oxl8EnpbRsHfXdpxNXSNYXnsadn0JGkUjYhG2G3ZRBaxsVSzkYKe6zB2kVu8Ks4F5WHlgZovMuA
	==
X-Google-Smtp-Source: AGHT+IE23KRcGDR/kd3c4g0abkgFnf3oFZxhdeRn83CjGT1YO9Cgs7wU0MlSqxAutRWSDpZp8ltIBw==
X-Received: by 2002:a17:903:1205:b0:248:79d4:93b5 with SMTP id d9443c01a7336-24879d497a4mr160522795ad.33.1756489380684;
        Fri, 29 Aug 2025 10:43:00 -0700 (PDT)
Received: from lkmp.. ([157.51.63.166])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd347db1fsm2727833a12.47.2025.08.29.10.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 10:43:00 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: rakuram.e96@gmail.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de
Cc: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	christian.koenig@amd.com,
	corbet@lwn.net,
	dri-devel@lists.freedesktop.org,
	harry.wentland@amd.com,
	linux-doc@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	rdunlap@infradead.org,
	siqueira@igalia.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2 2/2] docs: gpu: Fix spelling in gpu documentation 
Date: Fri, 29 Aug 2025 23:12:43 +0530
Message-ID: <20250829174244.13864-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821025957.22546-3-rakuram.e96@gmail.com>
References: <20250821025957.22546-3-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is a gentle follow-up on this patch. Please let me know if any further
changes are required.

Regards

