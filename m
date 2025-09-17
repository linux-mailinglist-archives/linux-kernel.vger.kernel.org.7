Return-Path: <linux-kernel+bounces-821465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C1DB81501
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D9D5252DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C2D30149C;
	Wed, 17 Sep 2025 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="XhXWpcTD"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4192FFDDA;
	Wed, 17 Sep 2025 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132670; cv=none; b=IYi7eemU0WUBIwaJJOQf/CV+ZzsdJF4p/cjw+C/efNnmzzt0vhyotSmA07i4ETlWCQM8rsZb1+N0ElbZuChYYS0wq0PBthWjkvsyNQYnkYx+Sbfh/aVmKsDn7qTYra//VFkyhUD+qHbT3Ud08gG1pYSuXB4wY0hCfFu+FB1iWg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132670; c=relaxed/simple;
	bh=MAdWsOy6N7LSPzbEuJLznpiAQXYpmqt+m9M8GD2QeKo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HAQPa76RH+O65N8Z5ZSpYsEQbe7XYdmqCcjiRH2CpSahhp8efnh93coIr1iY+ZBk/RB0BiPn16Eyn++QHW49jniMjZfV0gaB6o+cNoK6hmn6s4t8HU/CsjJMPSPYTCBMO3feWdepYTeELal0TvXa6x6y5caaE/fA8UednwiH880=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=XhXWpcTD; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758132648; x=1758737448; i=w_armin@gmx.de;
	bh=dbFpNN3EzW9eoFqSCLHSwxKIYRcMtoGVmYM70oOZsMQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XhXWpcTDfaZMtxQe44I9hncirY+xkvbCAq1KYt/g4Ii0Xv2z4UzIUoQxIUyqzBjJ
	 n1i8vGEko1bdjbCpbWxoij9utUpsZ+tFCBnymDh8aFdwud/Q4fVGEEr9HSn8zTL5T
	 JuAk2UaMYEj6NaLUZxTxV44QWHV7KFMDawUDbVeWTNBkMWfbGxbZc2+15cxgIofdb
	 ioAUDe9BMT4kMloAD/TXoM5hdwe71nKqhbySKf/GbHu7hITmzlfhi69sypsYm4Hbg
	 G/dsl8xrAaxhMesb9P3EhzQU4jfUwubgEAJT4CzbOrTSgeqdB+u6kz5HhH2l8VB1F
	 6hj4iWE8e5K4i3g+DA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MYNNo-1utsQE30V8-00RN9h; Wed, 17 Sep 2025 20:10:48 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: pali@kernel.org
Cc: linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] hwmon: (dell-smm) Add support for automatic fan mode
Date: Wed, 17 Sep 2025 20:10:32 +0200
Message-Id: <20250917181036.10972-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c/YVLSZfe24FRDWOug6JWTSFsF0Z4q6wLEGs/HYSaN7E2OQiskM
 NeWYxZDNm+THAI78+V8gq87XlHMEw2ku/NmPQq4plzUF8QRXc5WUgwhIdVqag98tTmQhkFY
 iMtrzGGvjOLXqXcYhTRf0xwuCMjvD+tMkHmKbMZ2RUgIN+72nDgm42i+p5Mz94ZWqojRLki
 EDtkNiiAT8EQkGSvkphDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XJnsuZLbkEE=;otvrJEBrAtxe4TkeRLErrBa08jf
 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
 QlEg0eGGXP6QIMJ3TQT

This patch series adds support for individually enabling and disabling
automatic fan control for each fan on most Dell machines. This works
by using fan state 3 that does not act like an ordinary fan state on
most devices. Instead of increasing the speed, said fan state usually
enables automatic fan control for the associated fan.

The first patch removes the custom config data for the Precision 490
that turned out to be incorrect, see the link inside the patch
description for details.

The second patch enables i8k_set_fan() to accept fan states larger
than i8k_fan_max to prepare for the following patch.

The third patch finally adds support for this special fan state. It
should be noted that after applying this patch, the "pwmX" and
"fanX_target" sysfs attributes will return -ENODATA when automatic fan
control has been enabled for fan X using the special fan state.

The last patch adds the OptiPlex 7040 to the device whitelist so that
the driver automatically loads on those machine.

All patches have been tested on a Dell Inspiron 3505 and appear to
work.

Armin Wolf (4):
  hwmon: (dell-smm) Remove Dell Precision 490 custom config data
  hwmon: (dell-smm) Move clamping of fan speed out of i8k_set_fan()
  hwmon: (dell-smm) Add support for automatic fan mode
  hwmon: (dell-smm) Add support for Dell OptiPlex 7040

 Documentation/hwmon/dell-smm-hwmon.rst | 56 +++++++++------
 drivers/hwmon/dell-smm-hwmon.c         | 99 ++++++++++++++++++--------
 include/uapi/linux/i8k.h               |  2 +
 3 files changed, 108 insertions(+), 49 deletions(-)

=2D-=20
2.39.5


