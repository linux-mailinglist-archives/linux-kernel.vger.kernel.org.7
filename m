Return-Path: <linux-kernel+bounces-759661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C2AB1E0CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 05:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2ABC18A64FE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937951A316E;
	Fri,  8 Aug 2025 03:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ceq9Z37m"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BB617A317
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 03:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754622319; cv=none; b=phnxflibZtimKIRWMki7zjvPZqn3UtXaYdNP5olDqYZp5dXlfT0tLiIguILz0UZ39QEl/BaiDf3ZO17rrLCzRCHDYiDBCk6wxAOX2NDIMNGTShEjsc+axRU0sXZLKrVEIqjh7qoWOJ2Yf0iWlPduUN1GiAG8jz9FMsQIwqJNWMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754622319; c=relaxed/simple;
	bh=YufMFNebB+ffC/W8Y13/+/2xtkKfnm3tVZn1lnJUtN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eUsBv2HqFTaAryXrpVpjH2MwsSQUfFc3Tb++LaKc7nWjUGX4iqkw7Moes+vbq3SvG1qwtrk8uzbnblR8S8gvehZse0w2xCf9NnheEHd0joMlFXtIPJjJf2jp6M5/u/Wq68FCm2VUKcZSAHt+9kfA9GslXO8wNq1HcBMJxZfhiHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=ceq9Z37m; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 8234B2C0536;
	Fri,  8 Aug 2025 15:05:13 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1754622313;
	bh=ewU04OYaps6nUewboJXJMDglhzziWDcVe/WKKXGnHK4=;
	h=From:To:Cc:Subject:Date:From;
	b=ceq9Z37msIfml9Toi53DnBJ+yEYoYEsr1FiLpV7c+IVDCT8vh8X8KVrHtHmjQqYH2
	 riYfTP3SCTychv1QEehmJ41Qnr0ZvdJiJAtT15Ui/HBilrOYWv8LjLwj7bOAZHbB/c
	 5wXCwMbTl2kenxj9St/piJyk9NrgtG9UOtNZWaoaqclBXBIZqo4DwGNwTQLTTADUaD
	 ca3YrjNWGFMW4WfnCEABuKAeWTGcOZuW22Q3Jb9nb/PwKuG4uv/V/YwvzTJGwutRwA
	 kULeoNI60xGNusYvUzy/1AcKuTKvl68sSL+XxcfXCtSP1bBzOusJZwD+6g1fr8A06s
	 ZZXt7uTwMyAxg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B689569690000>; Fri, 08 Aug 2025 15:05:13 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 64BB213EE2B;
	Fri,  8 Aug 2025 15:05:13 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 6116D280A41; Fri,  8 Aug 2025 15:05:13 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 0/2] hwmon: Add support for INA780
Date: Fri,  8 Aug 2025 15:05:08 +1200
Message-ID: <20250808030510.552724-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dtt4CEg4 c=1 sm=1 tr=0 ts=68956969 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=vD8M-rq02-v07qFL8-YA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

This is an alternate approach to the v1[1] I sent earlier. I've added the
INA780 to the existing ina238.c driver. INA780 can mostly be thought of a=
s a
variant of the INA238 that doesn't require an external shunt. This is pro=
bably
a little messier than the separate driver but there is about half the amo=
unt of
code compared to v1 so perhaps the messiness is worth it.

[1] - https://lore.kernel.org/linux-hwmon/20250806005127.542298-1-chris.p=
ackham@alliedtelesis.co.nz/

Chris Packham (2):
  dt-bindings: hwmon: ti,ina2xx: Add INA780 device
  hwmon: (ina238) Add support for INA780

 .../devicetree/bindings/hwmon/ti,ina2xx.yaml  |   1 +
 Documentation/hwmon/ina238.rst                |  20 ++
 drivers/hwmon/ina238.c                        | 255 ++++++++++++++----
 3 files changed, 224 insertions(+), 52 deletions(-)

--=20
2.50.1


