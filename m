Return-Path: <linux-kernel+bounces-876318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 927ABC1B68E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 950CD5C742C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434A824DD17;
	Wed, 29 Oct 2025 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FL9ub4xw"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA95335BA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747110; cv=none; b=aHTb7wR9nmj6BgP7liygltvUss8CHTjiuWaUUHGM4dDtVY1wYwLWeuIxTCfutqQyiWvtXyT/DDIuf6rpsY0J85HhJ0KPR0IQl8Z0LeCF2SrWLbxx5H+GVdidodbaPNNlhS2RRobez07ip7Dh2tTYUE6vaUfUFlKPerYWAkfGSPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747110; c=relaxed/simple;
	bh=YxKCqDpzLn5hW98Qchc7Gw3CFI1BEe5qc1Eq+8M8wuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FFSVhWKNf4rDUnuQuzF8f+z22bqmGPuJid+vaYIz857E2iHogAXfxsaOhHv+M7JKoGiLc605liTpEEkRjDw3FuB89HKrAfTcgmyFzxy0v63mGtwnCKWgruNVPlXpaVB4V6dmyMp6wyRe/HG78ZeMEvUi/APoD/RjNVzSzpugPeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FL9ub4xw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-471b80b994bso100172615e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761747106; x=1762351906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wps8Tclr//0cxda7/H585r6cl0r8XAUnNbHG7akvxZ0=;
        b=FL9ub4xw81uT7bxpRXQVouShbiViS6sfkFZcGKhnpHsSUKiaN66nDQtGkF63/W9/oK
         BgIZd/qGpqXTYGLR7LDMWDpzdwi4rhrjVol2T0e940tZ9psNX2KuEVi2UvRESX8fxxEk
         XREfUZ00eh2zaChw8CCEEbdatydCdC2G+zX5DnFFllQqxcNINNf/2o1vpR3gUbwlpQiw
         lzsswkgDphumpqd2ypZXb+12St7CLQJaXXe4kkN8TqHgp620q/FM/MyKWrzLoJJp4QP9
         j2IKwIBgOe+BlbDKwET3UV/qih7mqJHnf5fWE/DS00CBtFhEQg8VaOXZsOnMPcXgtjsU
         OqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747106; x=1762351906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wps8Tclr//0cxda7/H585r6cl0r8XAUnNbHG7akvxZ0=;
        b=cawPLTC7alElMh8M0brR5VteOBNW6s7FTzTNVEWv7qO31YFPySsh5ThwLowsnCv69i
         bdg7vjVz6Z25sJ2pM06D6f/cfF7+EgYu0afe6+C0PK0oAC/brXdA08EKnW2e9wKABvIN
         ecALlUzwCRmnG4MKGOOu3SQ9zYTM1wEh8wNRW2bw/Nkt+gOaPv54uvdimLriR2R7RL7i
         qCdkZ3pGvkj3X/f+u5kd8aQDPoLazNxJJ5pP7n1SkQmrFn849K25vNfJ3JXM3yq+fBIB
         68Zke0wV3LcC8yccJMAM3NvDMRBrdhgCTBsBp3d3U0j0PHnzEHWVeVxVIfXwdL1PJ8Vz
         z5FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO7eOgmyhfcyi2k9bFaIAsemYn3N6EyIHEYC6NZHGH5f8oxi10cOoP1xP3rF9vAoQxs+2b3YinO3TtGJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhh40kEWB00O25vhnVKsVXlTaBG7P7P3Dp9dQIXMx+3x5kbniU
	/0DJPzh22yIWgxF/Jp9ynSaDGoDumFLLYgDXzUVC7pQy9A3JAlG9bou3YU49iMGH8lI=
X-Gm-Gg: ASbGncuZXvg1jbf4wfLxpY7Kp66ddQzyloRkEQ+Rb7jbPq30BN8xGo7h4Q/Uwu722r0
	+GJMhUe29qgXkPBCfmNDkQVe0Nk1WTQ27xc6PnnmY1z7Oy+Oi0jbx1qbWblqL+PWBrBheXbJaQw
	Wizm4HGXVdR0NZF+vt5bsznRjCt1w7rgCKXeqn/gHW4VHbOv/Bq0gWUf0swJ+TbCRRhKHZoHiVL
	Jbb8/84pb0R+RRgksqN+9rWYuqV3p4bbtX3vYwqRRfOPjE2k2hliBYl78bHr3AYBHDYGb6hPT1b
	On6d4+rMqI8lJg1kXjkiJg2MmKwnQkyAFv50ASNYOo7YXOeSaVtpKtqwg47plTYvL16+jYLxN9U
	varhxnMhmFyp2hyhuDMMeTJqJ4oz9+k9O9KNSfqt/sMbCGN2G7r5TMFS9xW2ssxYJz40OO+fp8H
	oKRi1M5SjjT7G080of0Vc5VlO0AGIrWivRD6LwaBNWvqrkMR563PyQ+eVPGFFEMfHKpxlhpeU=
X-Google-Smtp-Source: AGHT+IEzlAZE9hRTmYR0/hE0kh5mGYt4Uwp8142hjLL8F6L5G9iVPPBs/x3dk7Iz3ZYqyRcAHD45KQ==
X-Received: by 2002:a05:600c:828d:b0:475:faaa:8620 with SMTP id 5b1f17b1804b1-4771e1ca0c9mr26073805e9.20.1761747105903;
        Wed, 29 Oct 2025 07:11:45 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6302:7900:aafe:5712:6974:4a42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db9c6sm27076286f8f.36.2025.10.29.07.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:11:45 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: support.opensource@diasemi.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 0/2] ASoC: renesas: Fix clip sounds
Date: Wed, 29 Oct 2025 16:11:32 +0200
Message-ID: <20251029141134.2556926-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series fixes clip sounds that are reproduced on suspend/resume, from time
to time, on the Renesas RZ/G3S SMARC Module + Renesas RZ Carrier II board.

Thank you,
Claudiu

Claudiu Beznea (2):
  ASoC: codecs: Use component driver suspend/resume
  ASoC: renesas: rz-ssi: Use proper dma_buffer_pos after resume

 sound/soc/codecs/da7213.c  | 38 +++++++++++++++++++++++++-------------
 sound/soc/renesas/rz-ssi.c | 25 ++++++++++++-------------
 2 files changed, 37 insertions(+), 26 deletions(-)

-- 
2.43.0


