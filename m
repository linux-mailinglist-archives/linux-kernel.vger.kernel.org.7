Return-Path: <linux-kernel+bounces-894993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 534E4C4CAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C62754F04FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396582F1FEE;
	Tue, 11 Nov 2025 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUbRgCnl"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8E02DAFD2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853234; cv=none; b=lUY6uPz/8kYdp1EsTK9kNYYluWUjW9xAxToTZi4o4t+BdPpHJZ6NQ2nlOvI1bQWHjRKBy008611yMNv7kCQijnAAdydMykKE0TZTGE+xLyJMSoyP7oZqNt13AMm8hNOdbbTNEJd1ht5ZrZS98/shWV26ZG8JdjDsxZIvHwd3yLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853234; c=relaxed/simple;
	bh=x2mBDMux/AaiCh3l+GZWu7YKVPsV3u/nqmQpnSpU5YU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oXXAlkTf7d0sUlafzVcRERPzq6L+XRsVdcsyh7Tc3nDwRv2bwdBLl97x4uDHXSfI45Gz0B2QequPGWG4ipIWdPQeYzcwwjbt8VVo57oftWqldp+nUR9yJHIDsvwaAGhxyWiUW7snef6s5c/bB8wkDuAghiGqxQ4nSYX/Of+lViw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUbRgCnl; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3c965ca9so868068f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762853230; x=1763458030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=965DQT/PyyVJ3v5YvU5/4R6vOQw0LY3sBFscMPBdOC0=;
        b=iUbRgCnlObdqSEmMjiFBjaWh8qJRn98/yHfnCXWZYH68FaANVGeYigiR9jW09frII5
         zlA7Rbs9WnO6WeGdMWdlnTNFh0wCei6mlCoPZGHY4lfChQyFRjpV+yn16H0J3aWAryTD
         KgVAyTccb+4gaoIgbki82wBEm4VKnHTIFHStxMiLXdTksoWeiWOsYlLBC8RTnAO89qi2
         XSTzlF5tGSVMpk4mgh4NsCmJqByS+Y5h+vfN3Nk2HIGTZGGmW8trTxS0eDeksFFeDGi6
         d/C90z/EXFYGFP2huVLzvQl5/VdBOVTUZekxXJXUHtXxKGN+b2urDt9Hq72Y4cB6VgEX
         MZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853230; x=1763458030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=965DQT/PyyVJ3v5YvU5/4R6vOQw0LY3sBFscMPBdOC0=;
        b=DssSuI8lHkL5yhrWC15AzrZrdU06ZknAQssGiDCoqcTOeAGQvT0H8EIliRGRmi6wQn
         rAqBZj2/KDDt4a1gcXwBgUNuZfcNmsXlQhk2NVZlCOpA1QRSugs8/kBfq55UGSscEjhj
         ENeh5q9vL7yeCErcXM2mJY10jT1lpH5Z70OR3k8AiyRNSSCtXMSP9Tayqmd49Qz7vyjE
         3gCFttkUgXko2P1yCwixHs8jaIygi8YQkAJqMLbljRg9aDerjRC52ZkyLPe/974BXJKs
         FBNV5L6xEShETxaDsIpd77rFNpBI40rWSF5pDTu1o7Tgt5IkYE2AXRztwIqEqb9Yp1qm
         e6EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmYrjxQ6FAUD8cxBbL3ZSGZtsEOc/MW6DddmhK0XsaYIUfXxfyl7qakoq0wXwecaMNyAGG6mE8bkxLcBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW9xcLC4vcmK5EUZCo77hDjlG0nsU2F9u+MoqHuIY7a//95UL6
	aW5Zpvf9Rk0lre//80AkUus/P9TeVpfr+cQP+b7kzgTpIeTfQGnW7pGX
X-Gm-Gg: ASbGncuva35KGrvEdNJASnxrqLXgCL+zRWpUiq1Bl8mx69W21WadM2vmDjJzWvTVK3r
	IYwnxi2qg0ph5ebYRGFx+gRv6njXq2b9SLJvcdPcwBKPqsYrimIE5p93JYL47c1ob8Pl2mYp+rE
	iL1tREmvSvJi+od8OxDuYxVsIzjgxUMvrWGwk+z9q8BZYlg7KscSy6WkQCI9LGxDbgNhPllWpCC
	jIw1tdlQvM10QLaHG6XEMeQi8toWE/enzjAxzOtsZJ+2GhL7G6WISzxerYrrnDebAXPRwqHip4c
	4ly6LywD0/DCuJHcAd48bnp9f5qDHTKl/qbZDFbF1aux3z3KnV6z3AOXis1iN1+Vl2J+gxwASR6
	0y67oYFE6YvRUqJKBbaO83BdqgNC0nDsTn94kM1Vaof8sq8c4eCBV6cg0Gwo979qKmfgTj2IksP
	3QiAycpi5Bzi2nHg==
X-Google-Smtp-Source: AGHT+IEUA2IpN/WkwsSOLcf02ER97kCgSm0MwimC2t0vdkHKEwwI1OLBDVxrKPkk1jVUZMa6lcqsLw==
X-Received: by 2002:a5d:5f86:0:b0:42b:3e20:f1b3 with SMTP id ffacd0b85a97d-42b3e20f52bmr3709589f8f.9.1762853229978;
        Tue, 11 Nov 2025 01:27:09 -0800 (PST)
Received: from builder.. ([2001:9e8:f12a:4216:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67921c3sm27464641f8f.40.2025.11.11.01.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:27:09 -0800 (PST)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Rosin <peda@axentia.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Richard <thomas.richard@bootlin.com>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH v6 0/2] add gpio-line-mux
Date: Tue, 11 Nov 2025 09:27:02 +0000
Message-ID: <20251111092705.196465-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This proposes a new type of virtual GPIO controller and corresponding
driver to provide a 1-to-many mapping between virtual GPIOs and a single
real GPIO in combination with a multiplexer. Existing drivers apparently
do not serve the purpose for what I need.

I came across an issue with a switch device from Zyxel which has two
SFP+ cages. Most similar switches either wire up the SFP signals
(RX_LOS, MOD_ABS, TX_FAULT, TX_DISABLE) directly to the SoC (if it has
enough GPIOs) or two a GPIO expander (for which a driver usually
exists). However, Zyxel decided to do it differently in the following
way:
  The signals RX_LOS, MOD_ABS and TX_FAULT share a single GPIO line to
  the SoC. Which one is actually connected to that GPIO line at a time
  is controlled by a separate multiplexer, a GPIO multiplexer in this
  case (which uses two other GPIOs). Only the TX_DISABLE is separate.

The SFP core/driver doesn't seem to support such a usecase for now, for
each signal one needs to specify a separate GPIO like:

  los-gpio = <&gpio0 0 GPIO_ACTIVE_HIGH>;
  mod-def0-gpio = <&gpio0 1 GPIO_ACTIVE_LOW>;
  ...

But for my device, I actually need to directly specify multiplexing
behavior in the SFP node or provide a mux-controller with 'mux-controls'.

To fill this gap, I created a dt-schema and a working driver which
exactly does what is needed. It takes a phandle to a mux-controller and
the 'shared' gpio, and provides several virtual GPIOs based on the
gpio-line-mux-states property.

This virtual gpio-controller can then be referenced in the '-gpio'
properties of the SFP node (or other nodes depending on the usecase) as
usual and do not require any modification to the SFP core/driver.

---
Changelog:

v6: - added count member + __counted_by attribute for gpio_mux_states
    - included Reviewed-by tags

Link to v5:
https://lore.kernel.org/linux-gpio/20251105163610.610793-1-jelonek.jonas@gmail.com/

v5: - renamed "shared" to "muxed" to avoid confusion with Bartosz' work
    - dropped Reviewed-by of Krzysztof due to binding change
    - use GPIOD_IN in devm_gpiod_get instead of calling
      gpiod_direction_input explicitly afterwards

Link to v4:
https://lore.kernel.org/linux-gpio/20251105103607.393353-1-jelonek.jonas@gmail.com/

v4: - dropped useless cast (as suggested by Thomas)
    - dropped unneeded locking (as suggested by Peter)
    - fixed wording in commit message
    - included Reviewed-by of Krzysztof

Link to v3:
https://lore.kernel.org/linux-gpio/20251104210021.247476-1-jelonek.jonas@gmail.com/

v3: - fixed dt_binding_check errors in DT schema
    - as requested by Rob (for DT schema):
      - removed example from gpio-mux.yaml
      - added '|' to preserve formatting
      - 'shared-gpio' --> 'shared-gpios'
    - general fixes to DT schema
    - use mux_control_select_delay (as suggested by Peter) with
      hopefully reasonable delay of 100us
    - gpiochip ops implementation changes:
      - drop '.set' implementation (as suggested by Peter)
      - new '.set' implementation just returning -EOPNOTSUPP
      - '.direction_output' and '.direction_input' dropped
      - '.get_direction' returns fixed value for 'input'
    - direction of shared gpio set to input during probe
    - as suggested by Thomas
      - usage of dev_err_probe
      - further simplifications

    Since the consensus was that this should be input-only,
    '.direction_output' and '.direction_input' have been dropped
    completely, as suggested in the docs of struct gpio_chip. '.set' is
    kept but returns -ENOTSUPP.

    The shared GPIO is set to input during probe, thus '.direction_input'
    doesn't need to be implemented. '.get_direction' is kept (as
    suggested in docs of struct gpio_chip) but always returns
    GPIO_LINE_DIRECTION_IN.

Link to v2:
https://lore.kernel.org/linux-gpio/20251026231754.2368904-1-jelonek.jonas@gmail.com/

v2: - as requested by Linus:
      - renamed from 'gpio-split' to 'gpio-line-mux'
      - added better description and examples to DT bindings
    - simplified driver
    - added missing parts to DT bindings
    - dropped RFC tag
    - renamed patchset

Link to v1 (in case it isn't linked properly due to changed title):
https://lore.kernel.org/linux-gpio/20251009223501.570949-1-jelonek.jonas@gmail.com/

---
Jonas Jelonek (2):
  dt-bindings: gpio: add gpio-line-mux controller
  gpio: add gpio-line-mux driver

 .../bindings/gpio/gpio-line-mux.yaml          | 109 +++++++++++++++
 MAINTAINERS                                   |   6 +
 drivers/gpio/Kconfig                          |   9 ++
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-line-mux.c                  | 126 ++++++++++++++++++
 5 files changed, 251 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-line-mux.yaml
 create mode 100644 drivers/gpio/gpio-line-mux.c


base-commit: b6d31cd41814a33c1a22b8c676131820440cc44e
-- 
2.48.1


