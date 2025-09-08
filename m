Return-Path: <linux-kernel+bounces-806325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FD3B49512
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9482317B70F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8786330DD30;
	Mon,  8 Sep 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hwuwIUja"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3D2EACF7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348472; cv=none; b=LEViL0PhX8WdOWc1bTEjvW9hobdC1cserkeLRtSTvZIZ6Idf70dnEVnecG7AdWBiR9z4VHe15MjZrP1aSpd5+9SKTeKwbTjFuKabTeTbvuXTKBrx2Kw8Er8kflqv9hxQI2WbnR39ZaIC9yA/PVo3/nwCOVbloveCSdzBbthW+1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348472; c=relaxed/simple;
	bh=CxhtcWFOqB/3crGFNrb/zODeeqpMlXwf5hN3B4IO01E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nak5iNLFH9+0rT683ojUbl6CfkUlo5OTPNsfU7kgCNLZ6F5eqKx7/sefoBSKtPEd6x5z5DH4hhXRcPIjgenAmDWJtymn3Jt7f8l5wv0g7rYnvTWfq8oGUisGOo3TYZQQYbW4Gbe0Wn81mHCug7ArY2EK+PYj7Kz4nnGq7qVrZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hwuwIUja; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C1ECE4E40BFA;
	Mon,  8 Sep 2025 16:21:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 913806061A;
	Mon,  8 Sep 2025 16:21:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 079E7102F27D2;
	Mon,  8 Sep 2025 18:21:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757348467; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=enYDIFRj8AFyUbKEH7cvYkwYYEkfFE7ESezCSgRmQoA=;
	b=hwuwIUja7WXxA1EYGHujFywZ/jIqGDvtzPaH/dORR/l5I7lh2tO9e1OwzCO+rZB0QpwZKR
	YO2rSKCtG5GV4gDJ2Wpl0hCQdOxw85ISdtB2fcuWm0u3Umibvec7//GoIxrjotCrzJr4iB
	4F134K9jjgx4Yp2luLOFoBuFjFRdoQSdgI4JsvTjBZGRx2Bm2oanUwx+8PJNKgvbPCpgz1
	J1GjDVF66i/c7O1Fzv/Zqtvfg4Eraty5uBZjkziFsAtZOHCf7i9+T1/ZUjtrrsNHa+0RkZ
	zjSVEh9XNHBD2S7EnHALniOSDCWKjxTJri7Juj1cN7crTjQxDQHYsTb3J6NqcA==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Aswath Govindraju <a-govindraju@ti.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 0/2] ti,am62-usb: introduce ti,lane-reverse property
Date: Mon,  8 Sep 2025 18:20:50 +0200
Message-ID: <20250908162052.355341-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This mini series introduces and uses the ti,lane-reverse property.

dwc3-am62 USB PHY supports swapping D+ and D- lines which is quite
useful when a mistake as been made in the design, or even if the lines
were swapped on purpose, to facilitate routing for example.

The first patch adds the binding and the second one uses it.

This has been tested on a am625 Soc

Richard Genoud (2):
  dt-bindings: usb/ti,am62-usb.yaml: Add ti,lane-reverse property
  usb: dwc3-am62: support ti,lane-reverse property

 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml | 5 +++++
 drivers/usb/dwc3/dwc3-am62.c                           | 5 +++++
 2 files changed, 10 insertions(+)


