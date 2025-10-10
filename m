Return-Path: <linux-kernel+bounces-847665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCEABCB612
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA62C405D59
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC4D22126D;
	Fri, 10 Oct 2025 01:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="IP3p6Q1e"
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76BC1DFE09;
	Fri, 10 Oct 2025 01:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760061419; cv=none; b=acZ/udiOu3S7ovkZ/GIW/2iknqkNFUmH4yOBeCUr2n6PuogVR1ZvS0hLJ+EMHr9+ZGfYUNnZNFJ+s+kpqsQozK9PnXfuaCvz5lb2VFrGs/TnVP4KWvdS1e+PsEwnDZMgHtcFT7JA6ueUlevKGArHYzJIHTo5Xw17iV6RXKkDaPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760061419; c=relaxed/simple;
	bh=8JRImo+QHxwUhWzjvIREcd7a0LJS2+I0PAcbb7327jE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SUnOx3tZQecj4b0un+z18HZjKQ6Q00gMITpSnXFpT/VQwLOUVO47aArNxl4DrapIps3zatupWFcKnM2BlMlAizSouGhPLUO9GAcquBEoB1fO3kev3F0jLX4nGi/YcCPDGJXocESsibgNBReS1Qp3c25r0QXrTmPPVHI2jqX85JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=IP3p6Q1e; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760061407;
	bh=ZVmyHGZ5/a4VGE9Sqr8Y7J7QfKmQk/JgxVkPEgUWgqI=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=IP3p6Q1ePR3yVCj2lvAu09GW8lkoLacNbIx72TgnK+cb3dMZCgOEn7jk1ldbEnrIE
	 xw8VKVdB17CNbSlZUi/9KvAbpjgZdCS84QAvqPBYorBcll7WIRfFi5ahlg6TvPlYFx
	 xHEEdJRISJrKeSl5GlsWmkX97oHLz32IbQ7EEOtg=
X-QQ-mid: esmtpgz12t1760061401t772b4fb9
X-QQ-Originating-IP: 9yUPyFi0REviDgtQdUjqnqSZf3F9sx1EUu7TcumO3Ng=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Oct 2025 09:56:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9320719454535500342
EX-QQ-RecipientCnt: 14
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v2 0/5] riscv: dts: spacemit: add initial support for
 MusePi Pro
Date: Fri, 10 Oct 2025 09:56:29 +0800
Message-Id: <20251010-k1-musepi-pro-dts-v2-0-6e1b491f6f3e@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM1n6GgC/x3MwQpAQBCA4VfRnE2taQmvIgfsYBK2HaTk3W2O3
 +H/H1AOwgp18kDgS1T2LYLSBIa52yZGcdFAhnJTUYlLhuup7AV92NEdirktHJnBWup6iJ0PPMr
 9P5v2fT/a0LQ8YwAAAA==
X-Change-ID: 20250928-k1-musepi-pro-dts-546d20c442ab
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760061399; l=1172;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=8JRImo+QHxwUhWzjvIREcd7a0LJS2+I0PAcbb7327jE=;
 b=llDOybGRdR+Use70f2OI4PX2IRWKaiO6FREv3lo9kGDdwztbKKu9xmNZ46V5jVJsbXlK4dy0O
 Qry8+7u1VBLCgRFK29ldBkXXa2U3rUCODamaadHEvObqkorp3bT2Tfq
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: Nc/ZqqWhd0QKmPZBaaKsdrvx+HzGGSqIg1TnXnDHh06w8IuRr+R2+bUX
	DAZF7aKYxLhJLu3L0eFS3aDhYzBTQoIvDDnoWmJd6a7L4wJJDBY/6pNKje9aytyzNrXU7Ov
	NyU8K+y/e4vdBKNeDXVkmm8lOeMwd+mZw8Tbov+vO0qET4ii4i2Su7Vq5RUXqEQFrXMXv1s
	SyM3NNt7sh9bc1JMT9ryhTC81hsoM6jm63LaqoDJvN/P/ujx8dWf4nNbFTopMq2Ez9EYfta
	xs0+6v27ncqLQuwuhFYeWXZFka0aSKtz+yZwGTQ2q5K8sh+6EjC5p5TJg52aOApIQN1Fs5D
	wcZ2IBXK9nk7yTi3uiyxUzseT1kAcH8Ny5J5bcl1ygcwCjXEWcTEhKtCMT86JdENPTsoYIi
	h0PfODPpodN1fFldahOicDMwL830nwC6BrNQlTuAMTvJae+hVOX7j5GFAdhOecsIw5Or0i1
	qY/kj/g/GUZ+rJ9ZcxDO+tYmdkNsZElRv0F0EyS87M4Dv5OzqKEYXCSfdFOoMgAYo7ggZ3o
	gz6tsm0WHZADBQ3WkwBgNT/zF5FOAoiALRr6Wbb0dFIwuAHc1P5yMXk1HfrRJOXfFvfa+IG
	O5RnqtvaYSVxYxqyP1MUsu/9MeNqAWyA5jomUZsEGDRDb+oCjOenfqhOHS27IqeZRAo9J1N
	UHgweLJRH736FSwF7mhWeZtLtO86k4xpqvo1MZk+EwxzR03TjIMPIIxjLerige4HqoFz3P+
	ZFi+g0dOmvwQmRM93xKD5TciSY7wtdeUOCoK2qSmSHj79a0N93k+NuK5LPCGG0I1R+mqzn8
	WI8xKwmN5JD1FVguK9z8smsuWRdQuwOxfg2IDCIb/tMCnPqEq8no9Mb5DNA5W/LwKEgfcUo
	G2FowHEWP9hfz+zd+zi8B0d3HgNFg75weYQbH+2LDJbpW+8t/UEiHiCkUpCWQiJbuQvhOHP
	Uq2oos22vd9PtA/QwM1hRCtm3mLAfrqCifB4Qv7aJ6XCMlst4ZC777XvOFun0eQJnLJ8219
	D4aKIDB34ZZxN54V+Uni4CB8g+a4D0a1SZngJfw3E2OYPsX1pCrVTukgVXTSYFYPWhbyl0N
	Wi46iJwjqeDTqSjLgi8oANd6FrOKE0HlZGg8zLPIATDlDOdPyDzEpjYwV52chygCPqVS8VU
	7+wB
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
Troy Mitchell (5):
      dt-bindings: riscv: spacemit: add MusePi Pro board
      riscv: dts: spacemit: add MusePi Pro board device tree
      riscv: dts: spacemit: enable PDMA on MusePi Pro
      riscv: dts: spacemit: enable eMMC on MusePi Pro
      riscv: dts: spacemit: add Ethernet support for MusePi Pro

 .../devicetree/bindings/riscv/spacemit.yaml        |  1 +
 arch/riscv/boot/dts/spacemit/Makefile              |  1 +
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts     | 77 ++++++++++++++++++++++
 3 files changed, 79 insertions(+)
---
base-commit: 93e3e1281b369a386a4942bb50111def06902e1f
change-id: 20250928-k1-musepi-pro-dts-546d20c442ab

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


