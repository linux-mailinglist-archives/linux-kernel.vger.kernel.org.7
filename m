Return-Path: <linux-kernel+bounces-818129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DA7B58D07
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19F432192C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553E8242910;
	Tue, 16 Sep 2025 04:48:09 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF94C226D1E;
	Tue, 16 Sep 2025 04:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998088; cv=none; b=lvMrJZW8SN6FE3DsbIqWqaKLYfC+In8uyEuCNEzIBt1m3+LvmyAWA8WqOoTWTBdRt3Nsvsyte9nGJznTvyTXTkpBbx6DemeKeOPzbn5YvoVEBNpZkLJDrDmyqK7imIIyIoOrys1RuzpFbruvGu7HT095ibxLyRUlgSfSZwDDGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998088; c=relaxed/simple;
	bh=ohSe0LBv/ZfwI0Trhej2IkrpHhNFT2IbP7HTp7GcMag=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gL+SL+/hWlQPxf1WbtvtkobdqIHEMiDNBp1/fD9l0FfAoZDjChNFmHxjRSE8wUVFHjvfeu6nrz2PPUSdPEI245P4XUJkh8oBScoMLLnxdfSHEDgO6VLVid0kAkim7FJOxVpPK/KZXiUif+bMl/Ra+vJiailopSneyVMvmMoxeE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=linux.spacemit.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
X-QQ-mid: zesmtpgz9t1757998021tc8a7eeeb
X-QQ-Originating-IP: MnSHpl6i8tG0ESJoWqhVxNInKQRx7KiX/ErgMayAmkk=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Sep 2025 12:46:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11306589696659165830
X-QQ-CSender: troy.mitchell@linux.spacemit.com
Sender: troy.mitchell@linux.spacemit.com
From: Troy Mitchell <troy.mitchell@linux.dev>
Subject: [PATCH 0/3] hwmon: (ctf2301) Add support for CTF2301
Date: Tue, 16 Sep 2025 12:46:43 +0800
Message-Id: <20250916-ctl2301-v1-0-97e7c84f2c47@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALPryGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0Mz3eSSHCNjA0NdAxNDsyQDc+NkIwsDJaDqgqLUtMwKsEnRsbW1AIh
 Je8dZAAAA
X-Change-ID: 20250916-ctl2301-0416b073c280
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, Troy Mitchell <troy.mitchell@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757998019; l=1578;
 i=troy.mitchell@linux.dev; s=20250710; h=from:subject:message-id;
 bh=ohSe0LBv/ZfwI0Trhej2IkrpHhNFT2IbP7HTp7GcMag=;
 b=fBHh0LsDUpNtptiv0hf0HLwcrk280SqDUvqWa354i4Px7ZudBO/6ecLNe+C80DDt22OtGMGqs
 wXHWVeLCUN3AcOD5viC5WUAxwV+meSy/WnbQ1NJFZnv/pz7H7DISg6Z
X-Developer-Key: i=troy.mitchell@linux.dev; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OLsBWtCIHsg6TeJXuJy3v+1fPZNqJ6QP/qpsmQH6SVHVLBud8vKkXmaC
	JGjSVCT2Nmye3b6oww+2MiUELXexk4rpf/wFY0FAyrFJO+qAFiLTxRdmlL8rurjpKsqfBJx
	TeaTPgH9GEKBdQYrZunkT4nJ6fyZnBu41+76A3c7Z5TYaaVBQ7qtGEXFIkjMpE0Rl5c2oQd
	0UYVz2icgnKzSnq+QGCp3Q4pn/YwHAKMk8GyUqmVDSsAjdbU+K6XKn+Fwj2YALDUz5uXqWi
	G0StOnp9nMp3FM3lAWy1xy9Xmw5L7a3x/mtT2BBDX+mV+OJJIWLVIRsQP+mK5kiHESY4Ejw
	ITCd4BoVVtvOg9vz8tRHuoc3qPmXNEgqe05j/3o1KYf1rDk8IhdL3HnnEYON3EuydcuUsgh
	m23RN3S20f5DWhnB/KrbvmWGllzR8Q6bClBncQZ5eLlNrdjcb4sP582VSCGaF9A91j+VBjw
	AahqPlZZW93VrbopKFyKsfGhaXkdBAxvi3EW9FFOAaVDroapqC0VCQb2/1Sn/TdABlJGRbS
	BU2u4YPZYqJZxny+SldsR2qBy4LByK/OE4KWv3k3eA1hqsvK+IlQ1XZNCv3CdcWzqIl/Vzw
	/FI8h5iMA9vIbr/XifjNXKgHhnGFg3f0Q6iOp/kJw16PvwOcI+rcIh9YX5G0Fv+vYmWVkgh
	jKBe+XqGXNKW7UhCKck62JnybLS8Y42iFlu35tRFmNjDdU641ubic0pFto3x/Q6xNS6LES9
	e29wgi2pXRXO0Pth25FK6GbTCvptBMYMCveTIC8EpiKiHCT9qhmjmQAu2UlmcOH100J9Fmi
	MoF5tJKhXOE/rB5X+ltNqpLeBnMm7iwfqSe5bfpksm+22C7TtkyMjpWkAYiTLU7/lk3sXsD
	Gum3q0HMR5yGGrScuhh8ojxiqYZNdTmQ1mI/MN5mBm79aUopQKN8j5r3Njd3np9AH+yLGJJ
	rX5w3tV594p5k/fnwNCluV0+UtcZxjbyirWpIm7L+3UfBQx4eKljpqJznrt3ykIr+bCCK0/
	JgFYndQ0srARYnaFUaQGelm5raj6e97ffbqnbVkAEr0rYFfs0ZqWZNSUvrJW6tcP0sgi+vF
	1GBAu6+Yx7xuzWHDQx5+Q0=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Sensylink CTF2301 is a system-level thermal management solution chip.

The CTF2301 is an I2C/SMBus compatible device featuring:
  - One local temperature sensor with ±0.5°C accuracy and 0.0625°C resolution.
  - One remote temperature sensor for external diode-connected transistors,
    offering ±1°C accuracy and 0.125°C resolution (temperature range: -40°C to +125°C).
  - An integrated PWM fan controller capable of operating in two modes:
      1. Direct-DCY: Open-loop direct duty cycle control.
      2. Auto-Temp: Closed-loop automatic fan speed control based on measured temperature.
  - A 1-channel fan speed monitor (TACH input) for RPM measurement.

Check CTF2301 datasheet for more details[1]

Link:
https://www.sensylink.com/upload/1/net.sensylink.portal/1689557281035.pdf[1]

Signed-off-by: Troy Mitchell <troy.mitchell@linux.dev>
---
Troy Mitchell (3):
      dt-bindings: vendor-prefixes: Add Sensylink
      dt-bindings: Add CTF2301 devicetree bindings
      hwmon: (ctf2301) Add support for CTF2301

 .../bindings/hwmon/sensylink,ctf2301.yaml          |  49 ++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/hwmon/Kconfig                              |  11 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/ctf2301.c                            | 326 +++++++++++++++++++++
 5 files changed, 389 insertions(+)
---
base-commit: 250a683466384b4d36f98b64f20412f3c26ca69e
change-id: 20250916-ctl2301-0416b073c280

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.dev>


