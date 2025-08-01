Return-Path: <linux-kernel+bounces-753134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ACEB17F16
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDBA18860F4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93744220685;
	Fri,  1 Aug 2025 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKCcccot"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492BE3C38;
	Fri,  1 Aug 2025 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039923; cv=none; b=PiEW0HtVjgs3PreCCiJEu2o1+fF0WYLknAxr1z2Qm5V0yO6p0cRacqO4ePbYXZZgVq5LqmRLERg17mC1sPB73UARb+mKvf5hQKRnB00Sk2zKRoDxFy2M7m+1TmjKNChkv2Qx9eHJF03OHioGyeRXFlVeOC3Xoa8J/ysq+Qwbq2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039923; c=relaxed/simple;
	bh=DM2zbqGlMpxPbk5bYPaJq/q4J4+lOoVy3pNl9ij3ByU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eP1eJ5lhAyCptveQD4NgI0JyTrcUKSopxnNMJ/XMRPl1G7k1gL6Hm6p2Sb4lJEN4yL3CUSlo5Wf2KuX20xcwnkxUJ2/Mu2WrpNRDmV7kFAwxdfx5lDDwUNgpVIv8HGKuy8xXXTcKtm4ybPWhO5C4RR95Sx2AIOCDTvjkrjxxwDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKCcccot; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45555e3317aso3338035e9.3;
        Fri, 01 Aug 2025 02:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754039919; x=1754644719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9OXzHZvZFg/7OiUCWnuamIDUXt4QwG2aw48t2rlvoPE=;
        b=VKCcccot4nqi4oh3joJUduJtAZ5h6PxWimPwxnxYtOzC6NYO2G0lMOO3De8T1nworE
         DvWfXOMdKuu24jnbuKL/YDJi/rDzp/2eqb4eqXrq8PabrEPxItGGQ9WNzTZJncKVGy4G
         1eXNMIlK73lgdCivJ9mb6rRPFnv4a+y4Y76bRNirsKhbNwnJtdtYTvuc0wnv+kP9UjZg
         OVZ/pXoGhOBPZpym9kVNxs0z8TwjJJWyLTr97waTIWF9o6A5nonqIVcn5uPk7RBsG0nP
         eOT7DSM+LFFLJlreHOUGQX4zRMfu5HSN3ZWtgeB9eU8VGE4z2VIpxhtCg9pWZ9XljmFa
         vhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754039919; x=1754644719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9OXzHZvZFg/7OiUCWnuamIDUXt4QwG2aw48t2rlvoPE=;
        b=ScfCqYKekxjntsp1kbmbJYB2mG0ma3mHerTOWAPzX9Iblo4c6Lq4yDpw1ht+VVzUI9
         UBBf1gVjwFRZzQi/O9mWEz1YSE72NscKoUvzWua9Ti72ru/aL3sP/cCdu0KUpADWVA0H
         ezEfDJHjR+IqMASFzra13E0UOWoW0SfASZdE/F5IHZ5TKcrGi4VREGQpkdlROBRO0jUd
         2sFe4dWOQU1czTBoUZKItfeRu9sUfY46YF5zfySNg0Hidw1/AaQKWOi5wa0SD4x+dDFc
         WTK9UVhNkOjmMQvQk54aAIGiG2o8Mv/RdUTIjVLbLbqHWNf8xVxLKzw0GhEruyv/oKGI
         Hwsg==
X-Forwarded-Encrypted: i=1; AJvYcCVBn8oi38xel/D6Ux/8aidJmKkufyLRhqneMfxeg+bq+BKZ78OnnBvOmaTRc9Cr7es6g4/W/pF8N/Eut1Y=@vger.kernel.org, AJvYcCWxf35nsql26eKZ7au3E0H5FjPG82I0zaFLYDvHUAV0rMROSC2Xiu63jL2g3X1gvbzi87oVVjbi2X8es8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+JbXl+q7ML6epvp1bb8bvKh9W6Mb1dTtWEDjxcrQ5VfYMnP/n
	v7JS1CjZ45Kb8I26FFpLgmBRpZnwsBob87olvGsVOdctbAb61cnLKNXx
X-Gm-Gg: ASbGncvtanxPv79FLMUGMFPd9u+qVD67sw0DRxkQVen6igN5VOltwP+Znu6PbBcSlkw
	6/eX/YaWj+Sjl47BmahrtV1UqAvvPWxJwY9CPx54EO77HtNFIJv+Gp6d1jDdecoOQTOQrqbdQUy
	6T2RyFeix/1yLUkIT/RC7GJd02MtpvXjAcWo1o5IF+D/Fp3fCcYi+0L85mM2W/OoeukpV+1I3Zl
	mwN2JpjvhVKSJ01a2Awn36YSyXOg6AaeJupDWcbHLM2Esxga0QkzcB0wQoAJyIOKGLGfiie6fD9
	k++JTqYp6BHK01hpX/Ncg9w668i8fIwqRs/emjkLZy5HI4vKOoQSap1ZucaISjhIvd+M+Rr5bUI
	zB/R0ieWmPyd+LI66g/qlo9oFDGkV2TSKaisTetc6ENDdg3E7/P5pWO/bfoY3N1+hkhvuVo6tgg
	eZYQ==
X-Google-Smtp-Source: AGHT+IEe0pNPbigzu96UgzYklOvX77/sciOzq5+IAwimo0FIOMEER5bpY4XblUXQDZ+bRyR0eBRXQw==
X-Received: by 2002:a05:600c:528a:b0:458:7005:2ac3 with SMTP id 5b1f17b1804b1-458a5858a2emr47023755e9.21.1754039919355;
        Fri, 01 Aug 2025 02:18:39 -0700 (PDT)
Received: from Ansuel-XPS24 (host-80-181-255-224.pool80181.interbusiness.it. [80.181.255.224])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458953787a8sm95789065e9.14.2025.08.01.02.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 02:18:38 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Tang Bin <tangbin@cmss.chinamobile.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	parkeryang <Parker.Yang@mediatek.com>,
	YR Yang <yr.yang@mediatek.com>,
	Zhang Yi <zhangyi@everest-semi.com>,
	Fei Shao <fshao@chromium.org>,
	Julien Massot <julien.massot@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RFC RESEND PATCH 0/2] ASoC: airoha: Add initial driver AN7581
Date: Fri,  1 Aug 2025 11:18:07 +0200
Message-ID: <20250801091812.4866-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an initial series to add the Sound system for Airoha AN7581.

It's based mainly on the Mediatek AFE system with some bigger
changes for additional Codec (that will be submitted later)

A small cleanup to make it possible to use the Mediatek AFE
header and API without having to use complex redirection to
reach the local header.

Posting as RFC to make sure these rework changes are happly
accepted.

Christian Marangi (2):
  ASoC: mediatek: move some header to global include
  ASoC: airoha: Add AFE driver for Airoha AN7581

 .../sound/mediatek}/mtk-afe-fe-dai.h          |   0
 .../sound/mediatek}/mtk-afe-platform-driver.h |   0
 sound/soc/Makefile                            |   1 +
 sound/soc/airoha/Kconfig                      |  10 +
 sound/soc/airoha/Makefile                     |   2 +
 sound/soc/airoha/an7581/Makefile              |   7 +
 sound/soc/airoha/an7581/an7581-afe-common.h   |  35 ++
 sound/soc/airoha/an7581/an7581-afe-pcm.c      | 455 ++++++++++++++++++
 sound/soc/airoha/an7581/an7581-reg.h          |  29 ++
 sound/soc/mediatek/common/mtk-afe-fe-dai.c    |   4 +-
 .../mediatek/common/mtk-afe-platform-driver.c |   2 +-
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c    |   4 +-
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c    |   4 +-
 sound/soc/mediatek/mt7986/mt7986-afe-pcm.c    |   4 +-
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c    |   4 +-
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c    |   4 +-
 .../mediatek/mt8183/mt8183-da7219-max98357.c  |   2 +-
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c   |   2 +-
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c    |   4 +-
 .../soc/mediatek/mt8186/mt8186-misc-control.c |   4 +-
 .../mediatek/mt8186/mt8186-mt6366-common.c    |   2 +-
 sound/soc/mediatek/mt8186/mt8186-mt6366.c     |   2 +-
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c    |   4 +-
 sound/soc/mediatek/mt8188/mt8188-mt6359.c     |   2 +-
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c    |   4 +-
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      |   2 +-
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c    |   4 +-
 sound/soc/mediatek/mt8195/mt8195-mt6359.c     |   2 +-
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c    |   4 +-
 29 files changed, 571 insertions(+), 32 deletions(-)
 rename {sound/soc/mediatek/common => include/sound/mediatek}/mtk-afe-fe-dai.h (100%)
 rename {sound/soc/mediatek/common => include/sound/mediatek}/mtk-afe-platform-driver.h (100%)
 create mode 100644 sound/soc/airoha/Kconfig
 create mode 100644 sound/soc/airoha/Makefile
 create mode 100644 sound/soc/airoha/an7581/Makefile
 create mode 100644 sound/soc/airoha/an7581/an7581-afe-common.h
 create mode 100644 sound/soc/airoha/an7581/an7581-afe-pcm.c
 create mode 100644 sound/soc/airoha/an7581/an7581-reg.h

-- 
2.50.0


