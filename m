Return-Path: <linux-kernel+bounces-879011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D74C22056
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6675A425497
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B6A304972;
	Thu, 30 Oct 2025 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="EhYA9uLo"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B954F1482F2;
	Thu, 30 Oct 2025 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853232; cv=pass; b=M4TpdAB0mYbdtTHqvUoFoxsKI1f3y30U7698x/dBykp6+Kt8F7BP+KHuhV/UZ98vaSySAZJOdj/AH4+o4VrH1V8SApvPVFczqMd6aGr9Ca0HztbNcNx2IGSNpevk/gygn+bvwZTmRsIW1jhItAVi7H/vtETQso7jIMdRdOz22R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853232; c=relaxed/simple;
	bh=7wLw7yl8rmJxjWVphNvol11i7UM/EQCncXGNn+g3ZlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rVzNMlOEXc6aZV6sCyh79Oc//KzBHZPwR6PbKhJj3rMIilnNj8Yooc5UCYwLBPsqJiNL/63wo0MCsae5NzWtdvylgpkEg49SLdQaeWffEBO/pw0a2tEYFZy8MRZMvd1NWFjw/xcV+kwehlqSb2t5dz5KHSXbxgstHkIXj6KoVSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=EhYA9uLo; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1761853205; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j9DgssJsyqR4sAyI+OlOWrKt/u3OEQM7J+EbDxLIeqBR7Ky+t5q9Vt7BaUNxOz4Fs1a2Syhnh8TMLSp/0J6l4naaDs5jRnoJUSQblHRRNGuLQKXhtEso4RU8540GKGSrtRpw6xRyfcRJiUS/gOgkbGMvb/wA9f0JVVRnqawSsEE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761853205; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Vf1+b7ZFrKHvQ9zYLjvBiyT8s38khTHCITEmiI6nY+I=; 
	b=FGYAJ1vb9KxY86hTY33W9ZMJF9xyzyK4bnMUwjKrmDsaSkA1Zs34qKfbqGf8QKaEhYnLP9phgHns2rXcK1d8YOfjLr/xA2eS8AJPFxF/vy+0gJArHoTsrZUxjVLugizzddBtaTFA28V5Rb2FtKuqL8Sh1vhOeZKbXYf1PZTQXVE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761853205;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Vf1+b7ZFrKHvQ9zYLjvBiyT8s38khTHCITEmiI6nY+I=;
	b=EhYA9uLozIRDr/e2Kj+mk58cokFjt9kPFcrQs+cWTNf0AYrzjY/ls6+HMx+ISx/l
	DFdILfSGQ0qCZ5vzDq9tzP8NA3dXWQp/F3JUwpngXz2f9f3/42qnfhg3hMqp64z9ihb
	1Knl7lphUQLS/duzs/mMSP3UxNTc40ti6X9fD7so=
Received: by mx.zohomail.com with SMTPS id 1761853203772271.72787016946097;
	Thu, 30 Oct 2025 12:40:03 -0700 (PDT)
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
Subject: [PATCH v2 0/6] platform/x86: lenovo-wmi-{capdata,other}: Add HWMON for fan speed
Date: Fri, 31 Oct 2025 03:39:38 +0800
Message-ID: <20251030193955.107148-1-i@rong.moe>
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

Rong Zhang (6):
  platform/x86: lenovo-wmi-helpers: convert returned 4B buffer into u32
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


base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
-- 
2.51.0


