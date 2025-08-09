Return-Path: <linux-kernel+bounces-761165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A04B1F52C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 17:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 099227A9644
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FFA2BE62A;
	Sat,  9 Aug 2025 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYURKFLD"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9085B21FF2E;
	Sat,  9 Aug 2025 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754752796; cv=none; b=muH7/lozvrYasng0/B7QtHjskOajAXRqUkdpPaRcCSs+i7CTq5v5uTdiX7m4NQj+GOUovRInvpSWFkxLgQXcZIpl10Z/OpQ6VDVP7iZ+JqGKlvgVlkxNeNoib51Jzif/4ltLjbFdmZ72/s0Uzy8MqoqXCq+qKSq2o+BnVyAhQqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754752796; c=relaxed/simple;
	bh=u6dKOmS0WlR8KKhcald+i0ZODsFDEOUfATJdrVEv7kE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kdDXb+9n6Eebuk8AdOtoriJ87zqclSETxGUV0Ybw5xIg+7sLJ0X1d8FkuUksZanvi08mG3B661mMzwmrwfnTWhdUoUTZqJIApFpzxExBMwhn23jpU8xRnp0cxymXj3ZNbZmKZiw9WuNg4LJD9132C06ZXVjFXDfNairuxAWM4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYURKFLD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-454f428038eso27235565e9.2;
        Sat, 09 Aug 2025 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754752792; x=1755357592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cgVPGBexVpAq1RNaeWcIvfg3yCOnUFKb7p5jEFa0Hqk=;
        b=iYURKFLDkOrEXO9e50oqEiqe75DkurrPDwHgcm6aEDW0ETgjnW7jMooTS3e0GFvQM6
         a3c5UdXE0TIJkEfqapmgqfw1s7Mox2gzDpGHIgnCIS/rCavL+4PuzeKVQrheEZca7oa9
         gnRbGKhpxO9Ff5nQrYAhTMcMKwnKuJp0x82Skxr4d7brXilH+AAidLL53yEfFHgVes3i
         tOYjT2dXKGQfnyfLN+S160DJD2Li4CKxZgHh9KnH2xVQetRO77y63scqXp3OtzHs+wP6
         EqoBc8oDV8GRh8kNdifX9jF8dd6toW49EQaeF0NZpu5i1dy4twQjG5f/K40vh++WrBPX
         x+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754752792; x=1755357592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgVPGBexVpAq1RNaeWcIvfg3yCOnUFKb7p5jEFa0Hqk=;
        b=B5zOokrzhbffVWt/FPhj6Cb5b/++A+L+5Rhd5dusYJCUsiD72RxNW+aN7TYJGvUJFM
         bzXJwZwYCQP+YDjYkZEPVDaqUZkGEnHVOMEFYwSP0iHjdJRt5bHilp8exy+iqvwOQJL0
         h6SS9QWbdeKenBbf33I5eIRlRIwZjjPMKdoeA0LrhP+S3yz5Mn0IsFHNMcf/Ftke6Acj
         4DZLkiIIjCp3XK+gZiuCUrtJNuwKYTNHQ621pY8w849vivw5C997MeIkD20vVefMNSL1
         YH3g3oOqFuFpOIkY5hxZ+ssaUV6C4uB7CWxn3E2o/IRK1T22j0afLye4MidjlJ0pjVbY
         H4pw==
X-Forwarded-Encrypted: i=1; AJvYcCVbwD81Wq9fNWUqHZrrz+qC6/2K8+4hddJawE+cWveLBbAqTkBI/pUF48bDStbbTDSaToXQFZ5xPebip/SA@vger.kernel.org, AJvYcCWL1e3sVrhZrUZ7IuRCwMwmrBGfaIDoa6UXRPFnoO77mvzWiL0/rGAIHcDC/PFKcIUXEgy6S6AvHlup@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0oiv2Q0BV3GpcUHD1ibXeENGl52SvueR7yUygZiV85fNUSs7G
	2XLNwp4K1pw6+FtYq1yHeF9n/sv9AcEbgGGsrOGQID42DhxKq1ZXx5gcS8ap3cgtuA==
X-Gm-Gg: ASbGnctT4BnW6JVbtkEhR6ndRVhZXZApXeMOS5pznkV32ZU0HTLOMKuzMuCOclkA6Xl
	F3GsmRjmZyF6WBiC9nm+Tcy2qQnCN5FCd5Ow+1gvlrlDNhfwUrIGdqsi4Y/AxzGP4P1bLDKeyV0
	WDJSk547HneHmKD6JLRYNHs+sXPziay5MWHLIpekU1/x6NZHCZDUFQnLOlEgkmnZfsLPmKG4UgF
	wjq3jSME1IcC69TDPL/pkzkqWM+glFFM9uEOrNGgqBp5l1rll/R2is80fK7TAISCj0q28TQsHQZ
	ThH9dwCj2Phj+c7e73qb4TIXdlL2YVFN8QOKmEjo8l+w56SBZRCtzep8BN0iQ7XnGWwgdGlWNgv
	Y8ZGDYhNRHW1fleMuKFYZv8Hws2i2T2uFW9iYUqzMVO/7SfM=
X-Google-Smtp-Source: AGHT+IF+KMFbPWGC7/t68m8nOlYARiiV8k95tRaBb8MzdMAeTooJ4qCzRTrZOnj/BXlIABME9H3zQg==
X-Received: by 2002:a05:600c:3111:b0:459:e20e:be2f with SMTP id 5b1f17b1804b1-459f4eb6543mr68077055e9.14.1754752792226;
        Sat, 09 Aug 2025 08:19:52 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:156f:b6b0:b8c7:9296:47d7:b0cc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e583ff76sm178748185e9.5.2025.08.09.08.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 08:19:51 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: linux-sound@vger.kernel.org
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	drake@endlessm.com,
	katsuhiro@katsuster.net,
	matteomartelli3@gmail.com,
	zhoubinbin@loongson.cn,
	KCHSU0@nuvoton.com,
	patches@opensource.cirrus.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH 0/3] ASoC: dt-bindings: Document routing strings for various codecs
Date: Sat,  9 Aug 2025 17:18:50 +0200
Message-Id: <20250809151853.47562-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses a challenge for developers configuring ASoC
audio cards in the device tree. Discovering the valid routing strings for
a codec often requires reading the C driver source, which is inefficient,
error-prone, and creates a high barrier to entry.

To improve this, this series adds the lists of these strings (which
correspond to the driver's DAPM widget names) to the descriptions of
three popular audio codec bindings. This makes the documentation more
self-contained and improves the user experience for anyone doing board
bring-up.

While this series adds the documentation as plain text, a potential
future enhancement could be defining these strings as a formal enum
in the binding. This would allow for automated checking and further
improve robustness.

Jihed Chaibi (3):
  ASoC: dt-bindings: everest,es8316: Document routing strings
  ASoC: dt-bindings: nau8825: Document routing strings
  ASoC: dt-bindings: wlf,wm8960: Document routing strings (pin names)

 .../bindings/sound/everest,es8316.yaml        | 14 ++++++++++++
 .../bindings/sound/nuvoton,nau8825.yaml       | 12 ++++++++++
 .../devicetree/bindings/sound/wlf,wm8960.yaml | 22 +++++++++++++++++++
 3 files changed, 48 insertions(+)

-- 
2.39.5


