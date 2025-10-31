Return-Path: <linux-kernel+bounces-880500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07112C25E85
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE451A684CA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBFF2D47F6;
	Fri, 31 Oct 2025 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="iJv97F5U"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D34526B75C;
	Fri, 31 Oct 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926075; cv=pass; b=dA+7VlIypz5veIsp+JiJjaGjB13R1DdiAzhnlKvQnIORkjy26O54b7Bya+hlT6V2lMIryoNo25HfnRQr2H9ZidGwjVbAwy942/NQGro55pOdxAdL50WzoREyS1piFUxSwDnDkPPYAz5tpKUxiuYz6LZaL4nJaqfc00Q3568tDrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926075; c=relaxed/simple;
	bh=Bh80hp1KxBqDOxIO5wp0FbooHjaiYhnI3DlFVV7AU6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S4cLMI5ZQZCeZS88VWMoJkEyoAcqC3wqPQnXP91SFazgebmt5qPPGskUa2Q0AArOaHo8WaSD7iQrDx00y7M+9rJ6Agw8astEFw10K//nd4s+d5/KWul7lFcFeXRKZNRN/jbdZpknU2WtDbw3E5AbeMYs0x5MH/AkAiQgtb64mT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=iJv97F5U; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1761926050; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NlyK52CoGdrgNUZXM0cTOneKVIgWlMvSkf/7Yf6F20xYjNAWH2v6KIkQF7PJRBXh+Usc9gOjW5HCAATE5nYPhLRvryjSa2kTsT/1NDmunDSACyzD4UljEs+0SPDfX0E5O7m3I5VP8vN7XNzcIqi4U3hBRgH5ed04tB2W5yk0sDg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761926050; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OV7xVe0z0ftGF6DjXTmEXHFprHcq9WF5953lJNjTFGI=; 
	b=G1HP3nPxu2jemJpxauNCNAxhcCOsAjJUn8Ql9G9BLTuqTxDnckQqMFy2GzGKuYGcMbg7zH5oAQEp8Iyyh06aC/oxI8vXy76+dpRJY801xppAGYd5s8dnWvgQMUOtB+dgZ7hrVjSd2jIBEEXeUo3QMy5xQNdIEaJyR+qUrcC97B4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761926050;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=OV7xVe0z0ftGF6DjXTmEXHFprHcq9WF5953lJNjTFGI=;
	b=iJv97F5Ukbe3xMJiuxCezirMwuL28+tZ+4lLKJtvPLkJoHBHGmNrkaVY68rnswh/
	7fAJu2JzpFXVFvye8LgzASsX/7bh5vJcoe/C6dU75Pfx5drAni3PTk5ecLunM/hAIQE
	v+Bec5VAyq85k3km3/Lp4naZnZM4PwpBwvOcqgC4=
Received: by mx.zohomail.com with SMTPS id 1761926048704138.21137234509445;
	Fri, 31 Oct 2025 08:54:08 -0700 (PDT)
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
Subject: [PATCH v3 0/6] platform/x86: lenovo-wmi-{capdata,other}: Add HWMON for fan speed
Date: Fri, 31 Oct 2025 23:51:50 +0800
Message-ID: <20251031155349.24693-1-i@rong.moe>
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

Signed-off-by: Rong Zhang <i@rong.moe>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>

Changes in v2:
- Add a workaround for ACPI methods that return a 4B buffer for u32
  (thanks Armin Wolf)
- Fix function documentation (thanks kernel test bot)
- Reword documentation (thanks Derek J. Clark)
- Squash min/max reporting patch into the initial HWMON one (ditto)
- Query 0x04050000 for interface availability (ditto)
  - New parameter "expose_all_fans" to skip this check
- Enforce min/max RPM constraint on set (ditto)
  - New parameter "relax_fan_constraint" to disable this behavior
  - Drop parameter "ignore_fan_cap", superseded by the next one
  - New parameter "expose_all_fans" to expose fans w/o such data
- Assume auto mode on probe (ditto)
- Do not register HWMON device if no fan can be exposed
- fanX_target: Return -EBUSY instead of raw target value when fan stops
- Link to v1: https://lore.kernel.org/r/20251019210450.88830-1-i@rong.moe/

Changes in v3:
- Fix grammar (thanks Derek J. Clark)
- Link to v2: https://lore.kernel.org/r/20251030193955.107148-1-i@rong.moe/

Rong Zhang (6):
  platform/x86: lenovo-wmi-helpers: Convert returned 4B buffer into u32
  platform/x86: Rename lenovo-wmi-capdata01 to lenovo-wmi-capdata
  platform/x86: lenovo-wmi-{capdata,other}: Support multiple Capability
    Data
  platform/x86: lenovo-wmi-capdata: Add support for Capability Data 00
  platform/x86: lenovo-wmi-capdata: Add support for Fan Test Data
  platform/x86: lenovo-wmi-other: Add HWMON for fan speed RPM

 .../wmi/devices/lenovo-wmi-other.rst          |  43 +-
 drivers/platform/x86/lenovo/Kconfig           |   5 +-
 drivers/platform/x86/lenovo/Makefile          |   2 +-
 drivers/platform/x86/lenovo/wmi-capdata.c     | 545 ++++++++++++++++++
 drivers/platform/x86/lenovo/wmi-capdata.h     |  46 ++
 drivers/platform/x86/lenovo/wmi-capdata01.c   | 302 ----------
 drivers/platform/x86/lenovo/wmi-capdata01.h   |  25 -
 drivers/platform/x86/lenovo/wmi-helpers.c     |  21 +-
 drivers/platform/x86/lenovo/wmi-other.c       | 501 +++++++++++++++-
 9 files changed, 1134 insertions(+), 356 deletions(-)
 create mode 100644 drivers/platform/x86/lenovo/wmi-capdata.c
 create mode 100644 drivers/platform/x86/lenovo/wmi-capdata.h
 delete mode 100644 drivers/platform/x86/lenovo/wmi-capdata01.c
 delete mode 100644 drivers/platform/x86/lenovo/wmi-capdata01.h


base-commit: d127176862a93c4b3216bda533d2bee170af5e71
-- 
2.51.0


