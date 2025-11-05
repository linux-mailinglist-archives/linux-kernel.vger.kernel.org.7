Return-Path: <linux-kernel+bounces-885770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1E5C33DA9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 04:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7AE54F603A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 03:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD3A280318;
	Wed,  5 Nov 2025 03:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="Md5J2gHu"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03926CE3A;
	Wed,  5 Nov 2025 03:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762313917; cv=none; b=BRsSaPfmmnDi71RuQ9kdvBU2B+2phMg1TyQUHnYb051n4LhRQs5kEzwYQypkBlOwFQTZ4sWmZFmb78NDkVGVR6zrn3I9zRVl25+afH6SGItgexYvoZ2gAsisHuEvZL/gl7g8G/42ABcBmE2p54CYEoh8XPNfdKyZiKN/+cs7Dq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762313917; c=relaxed/simple;
	bh=xiZjpDy3EAXqW0w4u5A4HJBPYdwJ/UmEUk25ogsrIqs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kN27x/jcjbzNTWixYuUYnMoNe1nRHqLI+T1nvWVo1LYug3x8+igi2pBPZk0Al6jl7Cgsxjdpj7ry7tJlZaTbbIF6MtvgwMe3uWdfQl26qYhwlxgtEWLNrWmEw3iHGEhZODr9h9dVmSZPF1zDmf4JlOR1sVrrSTW5JIOpiLJMKgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=Md5J2gHu; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1762313874;
	bh=dLRrQ1i7ZuvOR380K25xa+U2XNncx0jGHzRRhBIJiZw=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=Md5J2gHuaAUCZ7sjEgMYU27SvcJb0hRCKIRfURBKlRXNRizW/ccvkyAdjtbxHo/T3
	 7D8YfNOLMm3G1iQbp+nVyBlUO1YVfcTsyuYu/+mB5PrtFJ9cK/wZ029weQSdVU7Omo
	 9goLvWOkLPbCzO0kGiBnsTNzCEvTIfIJecF+kX9Q=
X-QQ-mid: esmtpsz10t1762313869t8b875169
X-QQ-Originating-IP: VTNhh+X1bUuazguRm/WjXFuDmMP9yaF6AZ6vdFDmMhY=
Received: from = ( [183.48.244.102])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 11:37:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13385157105176269560
EX-QQ-RecipientCnt: 14
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH 0/2] riscv: dts: spacemit: define all missing I2C
 controller nodes
Date: Wed, 05 Nov 2025 11:37:42 +0800
Message-Id: <20251105-k1-add-i2c-node-v1-0-d18dae246137@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIbGCmkC/x3MQQqAIBBA0avErBtQyYquEi20GWsINBQiiO6et
 HyL/x8onIULTM0DmS8pkmKFbhtYdxc3RqFqMMpYrZXFQ6MjQjErxkSMFEZvle87DgPU6swc5P6
 P8/K+H++XFuVhAAAA
X-Change-ID: 20251105-k1-add-i2c-node-df8b50b64ef7
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
 Encrow Thorne <jyc0019@gmail.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762313866; l=648;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=xiZjpDy3EAXqW0w4u5A4HJBPYdwJ/UmEUk25ogsrIqs=;
 b=vxtr0o72DIl8ORZBrMCYT6gEVCmnr934Hy5aIBBkYpcIOREfIIbk7+cs1nn295z7OPFLEqRNi
 8HCFtKkb4AGCIbdKRl9krO/wrZXGBEq4ldHVkOdDDA7NyJ24o4Atl1s
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NvDL1eqiYsCVtGrDjeZNV5ydHHueFs6Qm2Dto6JbQDORyERrasPfJbDK
	odchbFejJdL3UIhsMFuu3Dymnq6oLokK6bc0MtuieP6CsY1FBEmZOR6iVd0ML61aDxo6fyk
	sCFu0C+8Q7EZFQmsbnvbzrQgcro9pd+wpQpHcuAeHlHcxAIxtcV9Dl2YBDJEkph92mBm1kt
	tGbeRoDC8SG4/OrsDKZBWyhmgbfEgaOUK39Ab04JEIdpRtDzn5YhGFSi+ZryamAtzn7Zy3l
	wUm00WST0zyRtgDCf0JZgVG5dKpEzKIOz8zmusxJwvsie4xPismyTp/WkOaM8C24Z677bQm
	je+YuaX3xHJ54V0OZGJu36o62oaD20w+gP0kYedzyEhMP5PRHqoJ0iSpodxpKUzbWyPRvdO
	QPkH1k/uXpoAjcqYItDFuw18oKUrkPGogI4lRiPVdfM3x5X1KYoM6Iot4dBgKsyMlGpsBbc
	LeuD0oPMHiy2WzLF6kIJtK4Qmjj+u14nSV2IF5LRd82gZw20Uvpso9sPG/pd9/k5IFkWBJj
	d3ENsGHos929vS8EZEV6XHkKB/xKkDZ/LbqHGY+4jyqrNKk4c/iByENik1JCdsJQs1eZhNo
	lwbQiJbAbZQ8vX2SF48kQ2LKv9yxDGcAmw99Fc6ECZS2QDI5R4jjuCmUCb8pKIqfBeu17X4
	4aHyQ7YGDKbnOu96pKubAU66S4aK9v7F3Y2ycJ2oj7UT/MOIc1O+bxTEH1s/dDEjIfPsP9s
	PI7D6ZmQB3a9y+AjNFcT7CdBKH4UDG0ycVHdlxXaXa7E7ba/wfB9AuqFv/NmM5vy3g3Yd3W
	gt5L+iU44mTQjbU3cX+R6mFup7Yq3pQTCTJxyw5qBLphCYcb28VeWDENQpLoPpcPMmzcrSG
	RMrKyXF8OvnJBhaKLfnZZowr/nrpMpHeJ1U6YWRSunFijjzUnqsfP7ft/yM6g3fp4ijHZww
	NxMRa2sDpXEGTZzubQik7uLPAzXyA20ykDAuprXpSzrv+s9YD3CAvC0wF4teXiNJLofpPqi
	O1WyTmUlO2WA8DoomX9l60OSdiNwf3i6qKcrwKuQRnvIwOTqgS5YuF/KhRKkmXN/OgI3BUK
	ukojkV6xj7LmdjSIKhcvNjo8xOOJiPZeOF4dej0Fqi431hK3XPkEuIA2wruyjXfOA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Some I2C controllers exist in the hardware but are missing in the dtsi
file.

This series adds the corresponding nodes.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Troy Mitchell (2):
      riscv: dts: spacemit: reorder i2c2 node
      riscv: dts: spacemit: define all missing I2C controller nodes

 arch/riscv/boot/dts/spacemit/k1.dtsi | 90 ++++++++++++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 5 deletions(-)
---
base-commit: 17490bd0527f59d841168457b245581f314b5fa0
change-id: 20251105-k1-add-i2c-node-df8b50b64ef7

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


