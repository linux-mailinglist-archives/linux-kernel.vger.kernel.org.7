Return-Path: <linux-kernel+bounces-768389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86214B26066
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54FB84E478F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2ED2E7173;
	Thu, 14 Aug 2025 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9Cyj6W/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF9C25D55D;
	Thu, 14 Aug 2025 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162782; cv=none; b=E2XWLsxqo1kZ+b2vRJK0BHz/dgzZsTJz+/J/3nQlHHuyjMraEx3fzRA4zlh5tunjiJdwPuCZE1LVZ2RWFN5mueB0fOcZCQ2GSsvFNSVn1eX9ohkXTK6neJFcnUBoMedIIBgzv2XfZSqO6RuO8YlJFDB/21MyHOsaA0oTyAjUWro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162782; c=relaxed/simple;
	bh=zTnd/EQxH4FlH/lPSgFBoU+tEq21O8hLYgOIgxRyWdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WwZeqA32SK4gy2qt2yccoHikXzNmc87IlV3abG9rqo3cw29BVd/OAQS55mu2cb6xxxCEjWOeWIqN2Ron0mXwxpIuQ+onSy6jSS0f/2qQObCTvA53shhoPhz+O8zyFBjf9Zm72VwzCa5Y5sbKD3eoj/kVDUutEhC5Xlzme714rMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9Cyj6W/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43829C4CEED;
	Thu, 14 Aug 2025 09:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755162781;
	bh=zTnd/EQxH4FlH/lPSgFBoU+tEq21O8hLYgOIgxRyWdo=;
	h=From:To:Cc:Subject:Date:From;
	b=l9Cyj6W/l5xnKZ/l8qUh/GhfP1BtWD3PPlVfiWFzPGhVvrtQi+v9Ywos39a/nf2vT
	 v+it9Qa/zOhS2L0gjv/dctcCdkyUj5qFmZvNEsbuVbMTNoCS0TynzODt+gp/344BtF
	 uUodj8rqqf+DyIorcX8/O1//WGjvbbe5yzC/O7U9o5L3naMweahe4q9KnlcExGJAG5
	 s8CDu/0JYzUKdMR5YX8Sro6P4ILE9/um66yGutqTGZ3UyVyywsdZ8WCYoTl3bY7Vdw
	 raXRCtdnXDG/Ws1WomubTKgLkrEzON4Gs4toBZp0iuuyDX9DiF4fYu/iTw7lI9uQjK
	 5CswDJo+EoFOQ==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org
Cc: tzungbi@kernel.org,
	dawidn@google.com,
	chrome-platform@lists.linux.dev,
	akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/3] platform/chrome: Fix a possible UAF via ref_proxy
Date: Thu, 14 Aug 2025 09:10:17 +0000
Message-ID: <20250814091020.1302888-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up series of [1].  It tries to fix a possible UAF in the
fops of cros_ec_chardev after the underlying protocol device has gone by
using a newly introduced ref_proxy library.

The 1st patch introduces the ref_proxy which is an implementation of ideas
from the talk [2].

The 2nd patch converts existing protocol devices to resource providers
of cros_ec_device.

The 3rd patch converts cros_ec_chardev to a resource consumer of
cros_ec_device to fix the UAF.

[1] https://lore.kernel.org/chrome-platform/20250721044456.2736300-6-tzungbi@kernel.org/
[2] https://lpc.events/event/17/contributions/1627/

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tzung-Bi Shih (3):
  lib: Add ref_proxy module
  platform/chrome: Protect cros_ec_device lifecycle with ref_proxy
  platform/chrome: cros_ec_chardev: Consume cros_ec_device via ref_proxy

 drivers/platform/chrome/Kconfig             |   8 +-
 drivers/platform/chrome/cros_ec_chardev.c   | 125 ++++++++-----
 drivers/platform/chrome/cros_ec_i2c.c       |   5 +
 drivers/platform/chrome/cros_ec_ishtp.c     |   5 +
 drivers/platform/chrome/cros_ec_lpc.c       |   5 +
 drivers/platform/chrome/cros_ec_rpmsg.c     |   5 +
 drivers/platform/chrome/cros_ec_spi.c       |   4 +
 drivers/platform/chrome/cros_ec_uart.c      |   5 +
 include/linux/platform_data/cros_ec_proto.h |   3 +
 include/linux/ref_proxy.h                   |  37 ++++
 lib/Kconfig                                 |   3 +
 lib/Makefile                                |   1 +
 lib/ref_proxy.c                             | 184 ++++++++++++++++++++
 13 files changed, 348 insertions(+), 42 deletions(-)
 create mode 100644 include/linux/ref_proxy.h
 create mode 100644 lib/ref_proxy.c

-- 
2.51.0.rc1.163.g2494970778-goog


