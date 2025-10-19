Return-Path: <linux-kernel+bounces-859860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F44BEECAE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 23:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF383E44B1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 21:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E657322F14D;
	Sun, 19 Oct 2025 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="3EfDGUcJ"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45141FDE31;
	Sun, 19 Oct 2025 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760907926; cv=pass; b=aGRutF68w3mKZvzGZw6JiAu1Nm5iB+D2u4ohqHic/8d+6IsuxtAR35OTRZ/2u2C51AaIQMnGCdj6PFP8MXY5IZ8LL+UVHcqjh8hG4P6Pa2f323/7kkx1JLvicx7R7BUnJOJNiE1hN4/0zupvsRXYaztPVe0n//tWts7ImWAXDTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760907926; c=relaxed/simple;
	bh=txACjwaUzBVY3wLm9CvZT7NkXrqceAPHbh2LMaKOu/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X61r26ZFKSt8KM/Qud6Pze9i88gCgb1JqyQbpBQnlKLpxKQO03zEiZD4SLMWsMnrOvhpl9JZi+RYTWFxhuh3qjaso+XPCwQjhHgTalHYrdBn1Z9zx9fPMkmDPWoVKc5NCOA7EFABh5vIPFF7HhNwmWvjl3WcUF6plH+CPD0M0DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=3EfDGUcJ; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1760907900; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lrhlo+kGo7oby/Z5wDSTUMc1YHSz3Ark/HwP4xuk4VFX6UbeP3zygYTC+HVyYN1NZkf0beDjCwrMk94PNhCiJGH3aMvJwK1NR6LE8D0RNC2Z5APBDb5s6Zh1q/cEPxvS/8ROs10GzT0MFVvgJ9FcyLd5BK7LmJ51mD9Aru+i9Mg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760907900; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6Njnw7G8Orn4l/ZWInCB405wGlDyGLm/gxg0rgtVJ2E=; 
	b=MmhBMEMGfDLGn7/PLrCjQBuL/k+fGRfBl/WCf1StbqCd9zZ7iu5GnOyEjrIzWv6k3bDhGbkOP8Cuao8kJB7RMLf9qp4Ap1UIy7WM7mjEZMH2TMum1sZkmJhNmadUtjRqGJc0ybaZxRhM8M1bng3ezD+7HmY7FZGQRbzQHavT9ts=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760907900;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6Njnw7G8Orn4l/ZWInCB405wGlDyGLm/gxg0rgtVJ2E=;
	b=3EfDGUcJEXu3NcF5F5tZ/B7jRTq0Qs99q//mMQDxOSkV0DayjJcqkcZ4xRDRoQkq
	xN9nh7pHylk3xoCoHNPM2w5Dloymy/S66+QWflbHx82IIr9J8rLMa/GOd5NtHlCwAXv
	lc22eZeBqQGbmh9t7qwWSWYjJ/9cZOj0B9r0C5WE=
Received: by mx.zohomail.com with SMTPS id 1760907895751125.9137726191351;
	Sun, 19 Oct 2025 14:04:55 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Rong Zhang <i@rong.moe>,
	Guenter Roeck <linux@roeck-us.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH 0/6] platform/x86: lenovo-wmi-{capdata,other}: Add HWMON for fan speed
Date: Mon, 20 Oct 2025 05:04:43 +0800
Message-ID: <20251019210450.88830-1-i@rong.moe>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Lenovo WMI Other Mode interface also supports querying or setting fan
speed RPM. This capability is decribed by LENOVO_CAPABILITY_DATA_00.
Besides, LENOVO_FAN_TEST_DATA provides reference data for self-test of
cooling fans, including minimum and maximum fan speed RPM.

This patchset turns lenovo-wmi-capdata01 into a unified driver (now
named lenovo-wmi-capdata) for LENOVO_CAPABILITY_DATA_{00,01} and
LENOVO_FAN_TEST_DATA; then adds HWMON support for lenovo-wmi-other:

 - fanX_enable: enable/disable the fan (tunable)
 - fanX_input: current RPM
 - fanX_max: maximum RPM
 - fanX_min: minimum RPM
 - fanX_target: target RPM (tunable)

This implementation doesn't require all capability data to be available,
and is capable to expose interfaces accordingly:

 - Having LENOVO_CAPABILITY_DATA_00: exposes fanX_{enable,input,target}
 - Having LENOVO_CAPABILITY_DATA_01: exposes firmware_attributes
 - Having LENOVO_FAN_TEST_DATA: exposes fanX_{max,min}

Rong Zhang (6):
  platform/x86: Rename lenovo-wmi-capdata01 to lenovo-wmi-capdata
  platform/x86: lenovo-wmi-{capdata,other}: Support multiple Capability
    Data
  platform/x86: lenovo-wmi-capdata: Add support for Capability Data 00
  platform/x86: lenovo-wmi-other: Add HWMON for fan speed RPM
  platform/x86: lenovo-wmi-capdata: Add support for Fan Test Data
  platform/x86: lenovo-wmi-other: Report min/max RPM and hide dummy fans

 .../wmi/devices/lenovo-wmi-other.rst          |  32 +
 drivers/platform/x86/lenovo/Kconfig           |   5 +-
 drivers/platform/x86/lenovo/Makefile          |   2 +-
 drivers/platform/x86/lenovo/wmi-capdata.c     | 545 ++++++++++++++++++
 drivers/platform/x86/lenovo/wmi-capdata.h     |  46 ++
 drivers/platform/x86/lenovo/wmi-capdata01.c   | 302 ----------
 drivers/platform/x86/lenovo/wmi-capdata01.h   |  25 -
 drivers/platform/x86/lenovo/wmi-other.c       | 422 +++++++++++++-
 8 files changed, 1028 insertions(+), 351 deletions(-)
 create mode 100644 drivers/platform/x86/lenovo/wmi-capdata.c
 create mode 100644 drivers/platform/x86/lenovo/wmi-capdata.h
 delete mode 100644 drivers/platform/x86/lenovo/wmi-capdata01.c
 delete mode 100644 drivers/platform/x86/lenovo/wmi-capdata01.h


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.51.0


