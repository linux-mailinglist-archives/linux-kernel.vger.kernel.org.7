Return-Path: <linux-kernel+bounces-866389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA6ABFFA1A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6025C3A9370
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A312C11D6;
	Thu, 23 Oct 2025 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="BfCslwB5"
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D4CDDC3;
	Thu, 23 Oct 2025 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204538; cv=none; b=qDFTPkl42VaUEi33AU9JpH91IOU1NW2EUCHvMAymOICwENqODnhMFapqt/9gjIx9YJIOqvJY9nuXRa0uVNZscpIFN7URl1Z2A2dKd06rz9hizJO+KiItWOQoOLK4gKohghNvHq8PaoyF/QEqijNYDUgVnquRxo3RJF1x9+YmKPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204538; c=relaxed/simple;
	bh=we4sHnwFr+kEr7cdfMQWHMdmOTTe6rd9dsI0K+cOpEs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rNkPwDQ/NlvPBKhcAZvsuyud6ujUsKxFVtcQ4U0Da0wq51NmJFpVyeJMIneJDVJ2sE6PejYO75LX2ezkWc0skD/u/wPc9/81L7DYvND/mXhA5qKdIIxfp4XxWobWdXt+8CV0HdhEvO1iorI6uM01iUxCX2+jpEAQFuD41WkXezE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=BfCslwB5; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761204516;
	bh=Z3g/Ci6Gk9u5rNQfKWFyfT6eJPSAgCXlQmbNL5h4HuE=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=BfCslwB5Y6/ThavJELS/Z3d2VN9DVkz8OqgAnX2wrrnqd4goF7d6hnDB/+gA4Dk75
	 voCzYPXaS9pJz0rhyMGR5B+A84WZM0s1lbetVz18YPf4iCIsI3DcH4EIavsnLZXkWF
	 XGh0T/CXE40zW0rcoMle4hwZ75rCwY6S1CSlvJJw=
X-QQ-mid: zesmtpsz3t1761204515ta40fe7d8
X-QQ-Originating-IP: 0tWTWnDeWGTQFbr43boTRKKu0iU8FLXKNlosicOA8tA=
Received: from = ( [221.4.210.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Oct 2025 15:28:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15823541480981438499
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v4 0/2] riscv: dts: spacemit: add initial support for
 MusePi Pro
Date: Thu, 23 Oct 2025 15:28:28 +0800
Message-Id: <20251023-k1-musepi-pro-dts-v4-0-01836303e10f@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABzZ+WgC/23NQQ6DIBCF4as0rIsBRFq66j2aLhSHOmkVAkpsj
 HcvuurC5f+S+WYhEQJCJLfTQgIkjOiGHPJ8IqarhxdQbHMTwUTFtLjSN6f9FMEj9cHRdoy0kqo
 VzEgp6obkOx/A4rybj2fuDuPownd/kcS27hpnnB1oSVBGFfBGam6VLeH+wWGai+hrAz2OhXE92
 dhU/lOXI6rMlGQNq7KltLaH1LquPxJdf2EGAQAA
X-Change-ID: 20250928-k1-musepi-pro-dts-546d20c442ab
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>, 
 Paul Walmsley <pjw@kernel.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761204512; l=997;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=we4sHnwFr+kEr7cdfMQWHMdmOTTe6rd9dsI0K+cOpEs=;
 b=MZi6zYj1R9pH/t4TPsGChjG6bkItXX307IXO3J8l2f9VLBhLWa7TRJZiZTqpOPUJTkm32WzPJ
 ZVF8Z4/JCxFArIGCLPBpPdVbCQJJaz/eRIif10g336myXw2BgCWxf+p
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M0yfee4XSTXKPO+6mqAUbIY5RsDIaqpLkU5TrcyzAdI7Phjf7b4Yef4q
	g0t9Z1gQD1SFuoenvzStlfOoVeiJ6qOd1X3Rie1zDe8hWU9eP1kWeOp1RDJlObe8YCHUHUY
	9IRUcgFOLDQwTL4rC7cAcx+8/SHnJV8DZDoyfTbA8SRGJs7lk3gLITInvZjomp2KBYQBJHh
	ORTezHb/A1XmzF4dYc2oQpc/M4wrmrjG9/ChARbpmiv76jEqJGbBEKPupK9NN8COo7MIver
	mbZSWp+e/zj+IRZIkne5EbNLivu1vg3FjW4+XW3GkvDpJr+/4auQZ93zXgfg8C8NbEykzCu
	KNbw2sTpdgkPwJViIGOir0cb7D93PlJgUfyKClvqlbWFGx63zPDSQ3Zg6x4a7r+4yk11uZN
	yrcv8dYvduSunJBBb8LIaaqqJlHbbMv2w22gfN5kqXgz82FgfpyaWc8ccx7/+IDcKtx2X2r
	FIK8TRD+X54vlsi5VZFWMMzk/Aqd4v0AEcyWhA/oBfwNDN9Hz2lAz/oHx0tSDNRA3Y7R9IU
	mqIi+GooLC06axBfau1xB9EcukDTP8ncdYz56runPOjFFsWJ0LRb0yFXbXkhZ9xeVvMg3iI
	VwwXtn/ydeEkOoEn2KmxX252HhE9XtSg8E/xyel6D9B7pJDCbQ547KLXyu9zh2YYQzll23E
	tMArsST777m5oMTWsIUqvWrS6nDVMz7sNJ0U5kt775Y7T+o7qObqA3i2Z4s92qkMQmClftq
	6+GkAJ8LVq1HaWU3W3qenMQo/4xfiYkNRtAIps/Yfl+vb/tjMiOmmTXzWGAECNLcTzbtOqP
	VCaEbvs9jjsxFtWFdrfRjRFIp157IQ1PIx/o0NsUgMnKVcR3tUDQkYpCSeDUpuqhd8HN81l
	gXie8aKaB0/cLBD3lkEWf24xmAbc7WF4IFy4ONel2jfeKkzr6zQX/7tSiALSiqRZnFRQD7R
	rvAqk8DRh8kzUOrYQM99ONH8SsZhZuCGCmU99g+wdyG/0I3vYRxdfO5Cqr6pqyuXLfoPxzL
	Xhn366u1I8qMSbPS1pahWb1TpOo9aKokPXAf1XJ00ogx6SkJ64+EvVYyBT8O6f1ixo9bKkT
	dJ/5IBTSmns43/DjaU96fz7ffp58wrvKPGMXF8leUVxaJXEBT+Teij/nOJNy6O4aHGws/XX
	kgRacqLKuxhB9X0=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

This patchset adds initial device tree support for the MusePi Pro board.

Muse Pi Pro [1] is a single-board computer integrating a high-performance
RISC-V 8-core processor, storage, I/O and expansion capabilities into
a credit card-sized 1.8-inch board.

Link:
https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf
[1]

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Troy Mitchell (2):
      dt-bindings: riscv: spacemit: add MusePi Pro board
      riscv: dts: spacemit: add MusePi Pro board device tree

 .../devicetree/bindings/riscv/spacemit.yaml        |  1 +
 arch/riscv/boot/dts/spacemit/Makefile              |  1 +
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts     | 79 ++++++++++++++++++++++
 3 files changed, 81 insertions(+)
---
base-commit: 6296cd4c05cbcf06725777ded1ef44ab987a9cfd
change-id: 20250928-k1-musepi-pro-dts-546d20c442ab

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


