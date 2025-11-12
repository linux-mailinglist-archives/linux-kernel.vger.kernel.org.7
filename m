Return-Path: <linux-kernel+bounces-897595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B179C532E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7DFC355836
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD5E339B2F;
	Wed, 12 Nov 2025 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V804Wny5"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8E32D7DD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962088; cv=none; b=t+y9pK1bRkK54jWhfQTvyurrFIzq8khf1U/XnlnxEeWvdWJMNN7tooje+CdaRT0JMj1EyPsEp84RIGqnXyE3z5N+o6upwQEFE7toARI2ICBTetXAEAeQB7ClbSCBtZq9J8Y0Ty+K0NL8140vJ0JQK9Fb1FajkEr3quv/R/vLBdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962088; c=relaxed/simple;
	bh=P70ux5XoL4sP7XKBF8mt9nEhNWg2Y0bKzzy2WXyp+MA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C7m83FhYo0m1FeJUtavpgdWQxP4FhOaDhaml8tChAiuUgfP5IJ5oOITFMOsZeIq+ugjjEU58+dB/O4NEaW3YGFSdkQT33pPB9W0H384xXaE//tusk1UayQXm9ioW1TbUdfH0tFz/iqdgG2KrHQEknD4l0Hz/ybRkdMR+QXjb07Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V804Wny5; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so1394941a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762962085; x=1763566885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EcqGRuJDH5DuPAeW4wBjcQ/B5B6evG4AWgj1C7n+4kU=;
        b=V804Wny53F8rsoC0D2aHjH3g007OZpczWy9EsPNIadKYAww8Y8cJy0gMWtiyigO7EF
         ufLqCRVh/dAU0gvUeIsZq+Oz0TNRumgNEDnzdjcvd+9IsJr4O8q9nrKazJh8CS4HCvLF
         kcdlLpsV3fXSgH9z9e74m+FOBbfSECchh87NXSim7QqqQiWuc0z2sjq2nYjVFUf3MWqx
         qCm4kg6kSCwL7Q+HYonTH5oTUKRBOk1HBGVougmD56vv2FJqKTG7QI14eYD2dlxsnqxu
         LICNUx7WzbvFwBuQ/YWBSrXenMSRKrERAZw/l6bo4oFuSZHEoqc8Z1JJDqN66SKMZGKD
         hJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762962085; x=1763566885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcqGRuJDH5DuPAeW4wBjcQ/B5B6evG4AWgj1C7n+4kU=;
        b=ivxp6BrLnAl4RlNG291YkuedPO9x/BPnZSolIwDdkTS6d6Adkj4bYUfGWwm9tzlBAu
         sKoD/AMzlClnB14Pg095oqBb12FVvzWaAcaN+3nfwfjnSAGtumrsFNhqs7VHh2C1Txat
         U6ehk4UDCjB1iHNrzB7U0dKEP6o2Hi81zr/nZ2bh+gVP7l5cMmRlV0/oD4nUTtdWHW94
         kfu02oWlTl1d/eLWVYiXFviGbqgIwOulNSeOCv86/iB2RksUbuyAMHxWxOtqAjVM3mUE
         FZeesZlHT043NbIkQPvXTuQAZNF7lM1F0TsE+p8Oc1vEi11ntGe5ewEhFaVIAjmrsH+h
         yXew==
X-Forwarded-Encrypted: i=1; AJvYcCWOOG2NgZN0QfG6CxmDW6HATNeqCs2fgVaIP6yzrS3dJiL9x2TqBsdv5nhbJ3UBoR0hWSOk0678j2FW71M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+ZLkYHRDUzmJlKMBaqfEs71hExWvIw1T5zPvm9K+OjqO7jYw
	fHl6Ji8Z7NLOMgoOpDlx4RQZDBAWVUlS22fzO4E8KahujA+VzAfmDLpl
X-Gm-Gg: ASbGncsRxl59fakaxt4mnhmqW8rnDaE8/psIj6Z3M07zJWhp5xxe/wxyvXdDXXBmpS6
	RSnDzRyLjwdz6fP0zUYbu+p82WmaXBRlBIHjjg7JQxewKtHYUoYOorWw/EV3SuqD8TwzfymQgYz
	WiIgSA/fWDp812+7a56J3l4A9+2ImiIR/O5RKBTmOvN0LEgWpHmyOB+RPEQAsbaF4REqCXLcywS
	0a4DYUtFy6mlEIW9yy4op7LBTq9qrvIlWbe2OTppIO+3W0KlZee89PSAo1qb6zN7RCQ3xEBLDyR
	FYCTKekKAnlreCoxNpXb0XEJAKe+HZEIylczXjp/W3slGQzz6XKc7Q76xRpHDLeyC/OfnmhR7Ia
	OunwGaDuIHwHRuZMLAgf3k9sVOIsugMTW2nNea1XsyxKn++sS8BrDi4xfYtj//LavoXoNhEzow6
	N4z7a+cXP1HgdzBFEW3ixtgt9TBb4BWcblJnlicB0CcUMkmqM9BIPRnaL/G1WYSJ+EG/hm4elD+
	7YTGw==
X-Google-Smtp-Source: AGHT+IHX3eOJnJ6b2ckYQuN9nF0Y5Rkb79t/DFxTrsKsHI+zlzbswhY4DwsGngMKF9S9FWP+40tSmg==
X-Received: by 2002:a17:907:6092:b0:b70:bc2e:a6f0 with SMTP id a640c23a62f3a-b7331a054camr337287566b.5.1762962085303;
        Wed, 12 Nov 2025 07:41:25 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d456sm1670023566b.39.2025.11.12.07.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:41:25 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 0/7] RZ/G2L SSI Improvements
Date: Wed, 12 Nov 2025 15:41:01 +0000
Message-ID: <20251112154115.1048298-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The first patch in this series fixes audio channel swap issue because of
half duplex to full duplex switching during the streaming that involves
FIFO reset which drops the word leading to audio channel swap issue. The
second patch fixes sample width value in the hw_params_cache::sample_width
Apart from this, support 24 and 32 bit sample format width.

Biju Das (7):
  ASoC: renesas: rz-ssi: Fix channel swap issue in full duplex mode
  ASoC: renesas: rz-ssi: Fix rz_ssi_priv::hw_params_cache::sample_width
  ASoC: renesas: rz-ssi: Use dev variable in probe()
  ASoC: renesas: rz-ssi: Remove trailing comma in the terminator entry
  ASoC: renesas: rz-ssi: Move DMA configuration
  ASoC: renesas: rz-ssi: Add support for 24 bits sample width
  ASoC: renesas: rz-ssi: Add support for 32 bits sample width

 sound/soc/renesas/rz-ssi.c | 193 +++++++++++++++++++++++++------------
 1 file changed, 132 insertions(+), 61 deletions(-)

-- 
2.43.0


