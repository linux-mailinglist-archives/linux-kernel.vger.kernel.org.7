Return-Path: <linux-kernel+bounces-826680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE60DB8F1B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FD9E4E1B25
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4112246BB9;
	Mon, 22 Sep 2025 06:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RThwFNDG"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4BC221299
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522103; cv=none; b=YUaZ1RKoO55yL9xHqOWWWfkwJNLNt0R4V65KCZmMTGNrZsBW6xsGYpHXWzELTxPYDdYSm330Rhd3/BlM9npyn33EHnde5jqZn4Z7fkkLt4USYGEIlt6ZEUki7zFGSujmcQF4Ht0TQu35S/8IIYS4HzsgVRAxNCDZlKLEwQkL0cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522103; c=relaxed/simple;
	bh=zFtLVcaN8AVG5mTTYVcmEefIdazqWW51ehPhjn82GYg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nNG1843EKe/QMRRzp+zqm6xkNMaf+cEWSoXGJaVH0rB7Ll+JJgx3mPkK0uRtQQNqV69DZXqrAre8D1XV6yrPe4o+P2biTBE6RZ5l5kJ6H2EXOcuqfeOY63W5ke3VzApLSYuMzwK99W6+1QMroUnwYqjYS2BeVeTT6+JZIa/FdCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RThwFNDG; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-362acd22c78so33419251fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 23:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758522099; x=1759126899; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h5lLrTEPfjBEE6+72ClqjipyByMm2X0eEE6L7Qy2HzE=;
        b=RThwFNDGMbwvG4s6aDTW9uFtAEcMS/mqfx9x7fAnbb92saQ0H3xfWDwYdiE1V8lY6e
         9IhKmQ1IIn0E8CFHT2XxxTgz1oVe2MAsuap0En4igp++rTf+1YB3Y2wQ7hmd7FP28y5p
         HrPqX3Z95B7nj4Oee2upPwj6Ee6skQnV/Q3vLaznAdqChmt7OfuNImle3NiPJD8OiYW8
         5e+3vnjdhRkpgofDkJt4DXGJK3ELRW5te7xQYk1o2XoGwaKp+pbtq4sVUAkx7VCsWX15
         U1Cx1AfXSIDBslmEYiiWUAOmOloPBCfL4u5vNH0i/2ZzBTD9ZrzH+wnlhSVPfgjN+cxc
         l4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758522099; x=1759126899;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5lLrTEPfjBEE6+72ClqjipyByMm2X0eEE6L7Qy2HzE=;
        b=CV8YMksZUkRLa6cqiJKkdxT40QNnPe0px+reNGVEw6KCMJfB55ClWPNe+bqcTtM4/6
         1sfvmwEEa6opIGsL3/T4N6Ilam2EfMMg3uhfAaaCveq1wwg9clAaEnSJZdgJDUIRKWHM
         2BsLeumn8Q2H+LYSd7PYNnWeObMtL61dBWJ69e4e8inqW5SB2omN/74bwgNB5korRwwH
         oPh+FK0R9BrBcs/qqA35aaKgMqC816AlexIuwyWgP/SdURerjq4t3mFdDXl+qIAa3sP/
         TroH60SVsG/VV1mb1DOIhYf0TI4IHOYywTXwu43JHgGEkCvS8fDXZJJpLTWemDQLGH6+
         ga2w==
X-Forwarded-Encrypted: i=1; AJvYcCX4LDrqRdOmeIgcmo9J7dXrIbgm+0uo95Kiew2UXYRbjbO/w4Q4zx9viE3ZVyIdpZFF+i9ylELwh4HFSlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzig+hxh5RnThfWMSdf7xdQFqIUFLkfVFpa8GNE2Xlg4JHAXOcr
	bCcWZW/LiFCZ9RGwffssHqCihqSlEfnVjB7V6fLQwiK9zr1m8sN5aDzRWlweukFN
X-Gm-Gg: ASbGncv3pLdu1TYnYVtozlmjTU+S9y9u5ScjsHGXdkaJp4OvR1+ymYACJ01XLX5izlg
	SMUCMFoTgDOahIHm7QJwnmS5nYCmqZKX5asd8bkbspzEmHC96nxdF1+zIAgtAvdxY+mQ0z3tlcK
	JfKr2eWno6+paC/9/e5wduGnf0BaHSZICTBGgJeru0flqnrRqW1x/K0OsJNyrpIR8UaopSyavd6
	IPn0bP22SAER61Qf16EY1Qtpt+M08wcWh7Wbd+gopVEy0i8gXVxy2EDs1xKu/PW2Uxh+VDkiJDK
	IL6lMFYmbjMZfD/K/Fu0iR/K92N/vV2Sn3bHRvEUq1VXmHeMx42OlnsyvfpoN/BeSNhYAFKW0Ry
	IoEYfTqn3GIKoHh0YE7499ozBblaUPi3maXNnZ/vmSCIC/nU/ztNc72YOPvTGNFrWt2s=
X-Google-Smtp-Source: AGHT+IHF5DNe3flJ6FiaAnZ0MCzodBxytK9lAnP/8PhSe4SRX4JUFirBe6Je3qK5XyJdksPNiUzhLw==
X-Received: by 2002:a05:651c:556:b0:36a:1e4a:a3b9 with SMTP id 38308e7fff4ca-36a1e4aac34mr17785091fa.43.1758522098976;
        Sun, 21 Sep 2025 23:21:38 -0700 (PDT)
Received: from [192.168.1.166] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a99e99e6sm26982661fa.56.2025.09.21.23.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 23:21:38 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH RFC 0/7] I2C Mux per channel bus speed
Date: Mon, 22 Sep 2025 08:20:55 +0200
Message-Id: <20250922-i2c-mux-v1-0-28c94a610930@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMfq0GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0Nj3UyjZN3c0grdJAMDM+OUVKPEVJMUJaDqgqLUtMwKsEnRSkFuzkq
 xtbUAhmqzYl4AAAA=
X-Change-ID: 20250913-i2c-mux-b0063de2ae4d
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Peter Rosin <peda@axentia.se>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2735;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=zFtLVcaN8AVG5mTTYVcmEefIdazqWW51ehPhjn82GYg=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo0OrJIlZZ5BbpTRin9vUd3CQ+TLwiZ5wiSDt2E
 r30mcyo96KJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaNDqyQAKCRCIgE5vWV1S
 MiE+D/4wpCm8XHYdhhQW/Eo8ZkK3Vdr1X5BvcE16VcIGRV2FLr3/l+XDmI/uY4TIlS4cgGRjHuS
 okNslUvKkkygOo4BPHMyOniCKYNSD7oXNZc5vM3mQeA9m28FqtTbj/SK3i186jLocWMGUihvYeO
 0yBO/vwjr4TNlI1Az7/uGDt8XkjSq9JQ3zQwxyNvHIorC69OKn+9SD2AY1PS/rGv0frcea3NB5p
 DBpeIpyf7z5tHTvWvb5RObq1alrjyrWfmGy7YJrQMyXCARkjwXLWtPiR896E4w5ssujKKdYNoFd
 O016DHhA9ocy1jJ4HgEm/5oA94InzRv8srqwHLx+x3r8zpXgiRahYlfhDUDASuO82tTAZunVi2/
 KBGADBc5YV7xrhomCybSlcFWoSMJFaTVo6/vUEP18RQhJErmC5uzZBa0UrU1MMkVHRXo/MT3MCf
 lfsBDD6AtcXesXv6qECU2mSGdIofeTE5Eo5claApOaj8JmH0/TTYfmgMiibuPcIVjDDsDesMecH
 eA0o238/65NuLOBqynNUkjSDf3Eo8QdhvxtayiWrGdS+MP5dZbYRfkMkqVtgVOHbH6fVdFLDGXC
 nG3TY0ZF/T5pheNMtswoldHL4LYOL9UCsdmk08F1m52KyL7jj+WGL3qMGA96GtSJepMhWaso6JO
 ryv685KOSmLJrcQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

This is an RFC on how to implement a feature to have different bus
speeds on different channels with an I2C multiplexer/switch.

The benefit with this approach is that you may group devices after
the fastest bus speed they can handle.
A real-world example is that you could have e.g. a display running @400kHz
and a smart battery running @100kHz using the same I2C controller.

There are many corner cases where this may cause a problem for some
hardware topologies. I've tried to describe those I could think of
in the documentation, see Patch #7.

E.g. one risk is that if the mux driver does not disconnect channels
when Idle, this may cause a higher frequency to "leak" through to
devices that are supposed to run at lower bus speed.
This is not only a "problem" for changing bus speed but could also be
an issue for potential address conflicts.

The implementation is split up into several patches:

Patch #1 Introduce a callback for the i2c controller to set bus speed
Patch #2 Introduce idle state to the mux core.
Patch #3 Introduce functionality to adjust bus speed depending on mux
         channel.
Patch #4 Set idle state for an example mux driver
Patch #5 Cleanup i2c-davinci driver a bit to prepare it for set_clk_freq
Parch #6 Implement set_clk_freq for the i2c-davinci driver
Parch #7 Update documentation with this feature

[1] https://elixir.bootlin.com/linux/v6.16.7/source/Documentation/i2c/i2c-topology.rst#L240
[2] https://elixir.bootlin.com/linux/v6.16.7/source/Documentation/i2c/i2c-topology.rst#L298
[3] https://elixir.bootlin.com/linux/v6.16.7/source/Documentation/i2c/i2c-topology.rst#L322

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Marcus Folkesson (7):
      i2c: core: add callback to change bus frequency
      i2c: mux: add idle_state property to i2c_mux_core
      i2c: mux: add support for per channel bus frequency
      i2c: mux: ltc4306: set correct idle_state in i2c_mux_core
      i2c: davinci: calculate bus freq from Hz instead of kHz
      i2c: davinci: add support for setting bus frequency
      docs: i2c: i2c-topology: add section about bus speed

 Documentation/i2c/i2c-topology.rst  | 176 ++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-davinci.c    |  37 ++++++--
 drivers/i2c/i2c-mux.c               | 127 +++++++++++++++++++++++---
 drivers/i2c/muxes/i2c-mux-ltc4306.c |   3 +
 include/linux/i2c-mux.h             |  21 +++++
 include/linux/i2c.h                 |  13 +++
 6 files changed, 357 insertions(+), 20 deletions(-)
---
base-commit: 22f20375f5b71f30c0d6896583b93b6e4bba7279
change-id: 20250913-i2c-mux-b0063de2ae4d

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


