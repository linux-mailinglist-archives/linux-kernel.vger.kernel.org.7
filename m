Return-Path: <linux-kernel+bounces-857314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EB9BE67ED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6045C4F8CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096CB30F539;
	Fri, 17 Oct 2025 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="IRrqQSW9"
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044C51C84BC;
	Fri, 17 Oct 2025 05:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680414; cv=none; b=hxVkTdqDkTovm9ZSd8M+886R7FPxmweVrZviMEBo2WnfR9WUeIyTBDrYFDic2NPh/WhTpuUpME3bdM7srfQVco+6QA8GpwTkNpzSARFQAwY7xz9pPgYSQafxlNDl2o+ZZzgFrizwp31OzGesGCSgBnsL7O3LCu/3Z39vyk5OHcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680414; c=relaxed/simple;
	bh=ZTb0R1SYkjTNuWQ9FV7qBLfNn8delC/2yfO9jejOBe8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EWb0YWNzP7Bl88HGUGlskJLSDU4Am7H0mv6CBdVhsceodCnnjeLQBUWZ9/hZI9y2Stv0LiMcNd+dVuDksQAgQfiqSryZBDdDYOF6SLtGYHzxJZ5fageecRlP9gyglUCI6AmwGob6/SHPzSAwT6gliF0MNIEwpkfWFnaYaRTwVyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=IRrqQSW9; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760680392;
	bh=9Llik9TC8xsVJr4sY/DZm85aDCV1XohD3eSIWPKun1k=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=IRrqQSW9Dr15FJ9Y3g80gzbSAwfmF4sdcV31zm3xtVc808s/DvetYtNOaFziehNC0
	 bk8hns/qKEiWpBruNCrTBAshBpMgNQIXkKeJD29qv9L8wmhdPYZvjGMLpWCU4y/BuR
	 Ok1oiJFwcecr7uVXUeJAbUN0HsJfZxs3gOadRVkw=
X-QQ-mid: esmtpgz11t1760680390t7159569f
X-QQ-Originating-IP: 7lBdRt8TZM+XnRQa4An81zQDgcIZsKi2YskrOXxwnMc=
Received: from = ( [14.123.253.52])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 17 Oct 2025 13:53:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 608102386777863130
EX-QQ-RecipientCnt: 15
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v3 0/2] riscv: dts: spacemit: add initial support for
 MusePi Pro
Date: Fri, 17 Oct 2025 13:52:24 +0800
Message-Id: <20251017-k1-musepi-pro-dts-v3-0-40b05491699f@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJjZ8WgC/22NQQ6CMBBFr0K6dkhbChFX3sOwgDLIRKFNpxAM4
 e5W1i7fS/77u2AMhCxu2S4CrsTk5gTFJRN2bOcnAvWJhZa6lLW+wkvBtDB6Ah8c9JGhNFWvpTV
 Gt51IOx9woO1sPprEI3F04XNerPpnz5qSSv6prRokVKg6U6uhGgq8v2letpx9a3GimFs3ieY4j
 i+38EwjuwAAAA==
X-Change-ID: 20250928-k1-musepi-pro-dts-546d20c442ab
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760680388; l=997;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=ZTb0R1SYkjTNuWQ9FV7qBLfNn8delC/2yfO9jejOBe8=;
 b=Ein+MMLXwWUJxWUumo5ZKfwDfJeKWx7mJ0PcHtbcJ7hXWgv8rrLmEdaMGnmyVx76bHLIW9+eI
 ONJ6wboGNmEACoJNzWv1PkiKc4z1ZaIis74QKP8l63ZtL+Ka5f926uP
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MzJUY0xoko+MtE4irksyTIHtRnB1IDJ18SdqQfISxL19B5NEq812G/2n
	YHQ7YtXHmL/0YIRM7Z658qCDGnqgYqHCYqwkUPkUI5XACF80SvNIQAa0fyiqy7TSAHvsfqi
	AwNVfpqRBbiixJhiNfdYFYwzE6us44J4WtZzFyVo07XnSTVm4yl34a5OkdhpG5w2UmmbSKN
	vwAi7ngfi+z87Dbw+KmFJXoDpQf0cOqlBC/R6H3bGBtMJoq4/WCBPzSRNX+rcuf6I4p/fQ/
	kmwLyEV/UecOBWafcWInNgWmvDasGRQCq9eMHyPlrp2i9oDV+aCJBU1TdhInTlAmUGAEO9A
	hzrmQtYSLVJaty+qo7k/W7x1JgVp+htbI9tsP9NQeBu0UuTnl/T+gYoN0t7PgfMaCtdVaG1
	tguA3WvjUJkswTdBqj5bjMrmt25Mdwlm3OaVS+vBFgWiLFScignnNVIokOLLhHVw8hSfclE
	8mYfB+xYQD42GSbCQFOFinQbwhaa5VWoTlyRkadoMAxKGBSm8Bg7vtOkERz3vHpx9RhvK4M
	b2LTvbG4V3/duzE9ac9HUpdBdI/XgHi+nyG5naeqYylNAQ2G2HHelF/n8gqVdp+2SHjTILG
	bddbmN1yfHYJJYfpNDQTvCHBiWcpKoG75q9RxDsynh87CBGA++1hqg7fagV3V6KoT6NklDn
	bUS51Dg4NvXq78AUBo42PHEqM6z4V8xHqnx+IKdxpypymFaI8Mrg0PM83qF4TYCJHAGsCw1
	pfMj0Xo1sbFMsPdEivJItBd1VlwYKLyCouUecGcQnlvvJ/xWQCAt1C1fS9dBf8Y/E6yigkl
	lhmiCG5jU7rWS/64//nUZ6yILkKmXmJZjQkOkZRN127qDXvtx+JQMlsd7Sh7EBqz44vQ1Z8
	rRaXjcCls/uQbWZ5W+k5gRvmuSJUzV9ZfpghZzM9TZY/i8bUWm8zjkAhFW88UOYuZToCEUH
	tvxtZ+dWPn0OZ6sBdQoNCSd7cf8BLInOCOEWVseiuvte3tmch5Qyf6tBKzk/39AZiw6BKKM
	COUIeoQQNja33btr2WjsG7f2NTQvy6mW+wIntBxhElhsSlN92iEoijlqwmKtIg/eWYNy2UU
	5PQCVp2JQop/K6JDy2Lj6Wc3n3ofowkOT1Rz7vWppTstoEpGsX1qmeUOWp5tlgK5w==
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
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts     | 78 ++++++++++++++++++++++
 3 files changed, 80 insertions(+)
---
base-commit: 93e3e1281b369a386a4942bb50111def06902e1f
change-id: 20250928-k1-musepi-pro-dts-546d20c442ab

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


