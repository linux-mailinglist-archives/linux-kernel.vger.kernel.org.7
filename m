Return-Path: <linux-kernel+bounces-877457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75982C1E282
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7413AAFAF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F53832ABE8;
	Thu, 30 Oct 2025 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj/BVcaw"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27802EB859
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761792215; cv=none; b=slG7cwbZab0Qv5PPn4AzDmaiEhzjOEi2IiPJrvsMuQdHiDXRK+xe6f0pJvHLaUlB20IP4HAgcEChBC9aeKRMpBbAejQ/iPF+CvpKiJhZ1Icjvp9nIWrDbclIcllf+ZP8COrx8hFGvrJ+qzI4gE9/5Weczh5cAWu42V0HJYIFzd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761792215; c=relaxed/simple;
	bh=yMlK83sRn+VhWWIH2W0HcuZUd6ezZqUJ2SDuOnakwiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jero3iQMm8FCIyjxHTKprG8h6yZ2m/ObFFl1Nok3U4TPqRJezSUeXIMXRZ5uu2T71pO6JRbZYgc9GgOTstNUZGsb+R5xAV64iWWfUYPSkqfqwch6aaRLNfKa9kdrJ5Tv7j/weFDRUGk7ZsR6QOEM9bpqIiJgY34tbEvYFah5v3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kj/BVcaw; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33d463e79ddso671988a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761792213; x=1762397013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMlK83sRn+VhWWIH2W0HcuZUd6ezZqUJ2SDuOnakwiw=;
        b=Kj/BVcawSehyhmrzcNAQiDuW20c+KMwM2So/pWQg0iLfi28MT3m68+4zB66i2BsR+Q
         dOm4ezL+Q/Fdxj3FROK2JWbJe3mfL+eB/7i9bIv3DCzR8mV03YAW3ymjmPy+/eagDtcA
         vHzVa0B6nic9HubPoRmpBKAb8nY9Yklt+gTnZYaJOyMr+rJWtxfSHB5xDIOnl3VkQxeq
         nUE2wAtydEVHe1ftex7cwo1xvZAMyyxjB/gAmu4lbRPTLvtV/jnBbSJ2aYjruZ89f6MJ
         wrrSxHIrF/gCxpg/5y0nVD+rweuR/YvgnyGWNl4Ykzq92bTsw+fuYvTWDL7OY+FKvfxQ
         ihgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761792213; x=1762397013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMlK83sRn+VhWWIH2W0HcuZUd6ezZqUJ2SDuOnakwiw=;
        b=FcfrLYltYNyq34apto9QWl1CPtGx5pb5N2trCh0H8HBsk1/6y/Aty5FqlF/++kkJ09
         MUrh3HXu74DhKtJC0VXcOb6J6lJ/hBAQmmAg4vj7o03G1BHbpUhLFELMgcS0ev1nwShL
         35mURLzXwTqdiHLbGyIHByIqVHeHtc5D1rEfbJAQPF1eB7TjNX83ug1vKqXNVljdnT0F
         xYMtwnVlVQCIrCGZreuhyOOSzVow/qOptkIyF7rCrT620hRnPlWWKQveorR0l8xJhRjA
         kTa4o1urjln75+7nGxoABpUi6GOJprzFIMWXkr94okLbdXMiNbSLEWGtDmpllKoFfVbi
         Oafw==
X-Forwarded-Encrypted: i=1; AJvYcCWlhAy+lhDpBfCjR6x+y5GNDcdA1KVGczZHgKYvdRy1oWQaoYoCtYg4+p6grT1MksVSd6YBDG+6nI8Z7BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvZKFfzf5mc1A7dxK0VO3xnhgBhzihOJmWL5Y9+Hn+wJTntC+0
	I0rBaUTYxzKDHt0jLOVWHJXmc2mvE7lDp2fFHDNeN51IY+yhO1v9fB3fQJU8E7Dj
X-Gm-Gg: ASbGnctVHkpKz+z2XVNKZmzmpOLkt72Xt5xm5nFxpHwMz/A++EwCTPkmM2TnOcjDdMM
	AdbXkjuUqLk1yePWLKhYpgIFIAhRCKAt3L9Sc9fN1l4uz6e1C/B66X6gLwzjR+IVuTRzIIzxjfl
	/rT+vB4SFEVVpUqHZ+Z3KBBsp4ezughQ5GBzr5zovsYEN/O9c1olqUUB3xajxADZzr+KA/nRhiU
	kXnISr/5VnDBlx3AfhDLN9RiHa/whAVLy+DsH0mONmVWd2JbRCkOgWTYmysd+UGjXaH6n2542N7
	tHU2qUTg+nKOp1Sf0yaO7fM7tzWnRtqWv4j8du9WYOGJJ8z/q0C2fdEtDTrnWi/n3J848uSxTCG
	5R+y1xHRm1QfkkJakYTwCvYcDVNnqfmwuFchPc4+HpflAQkr17iWsZvnl0c77MXCHDe2Vfr59C0
	5X+c/TSC2DD7yV06JSuGmCRC7KAWt9h8rCM4Bm3fZzEPb5goZloEThZQ==
X-Google-Smtp-Source: AGHT+IExv/DfyFEe0/KnqocTMb0QEh7+FjTlnoU1+P9V8ugsonVuZLZLwQLITUfoXbaYEdE8xwJO/A==
X-Received: by 2002:a17:90b:57ee:b0:340:2a16:9b4a with SMTP id 98e67ed59e1d1-3403a25bc09mr5824732a91.6.1761792212976;
        Wed, 29 Oct 2025 19:43:32 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3405c363205sm143686a91.2.2025.10.29.19.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 19:43:32 -0700 (PDT)
From: lcwang <zaq14760@gmail.com>
X-Google-Original-From: lcwang <lcwang@ieiworld.com>
To: tzimmermann@suse.de
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tiny: pixpaper: add explicit dependency on MMU
Date: Thu, 30 Oct 2025 10:43:29 +0800
Message-Id: <20251030024329.482105-1-lcwang@ieiworld.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <bd93498e-749c-4e85-9c63-918aa8f2d6f3@suse.de>
References: <bd93498e-749c-4e85-9c63-918aa8f2d6f3@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas,

Thanks for the clarification.

Just to confirm my understanding — are you suggesting that this issue
should ideally be fixed in the RISC-V Kconfig (specifically the PORTABLE
logic that ensures MMU is selected), rather than adding a local
"depends on MMU" here in DRM_PIXPAPER?

If that’s the case and the root cause will be addressed in the RISC-V
side, I’m happy to drop this patch to avoid redundant dependencies.

Best regards,
LiangCheng

