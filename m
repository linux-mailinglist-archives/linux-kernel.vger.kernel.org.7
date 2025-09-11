Return-Path: <linux-kernel+bounces-812818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78768B53D24
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC74F7B2250
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC0D28B4FE;
	Thu, 11 Sep 2025 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpjYmvhV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9152D2877CA;
	Thu, 11 Sep 2025 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757622236; cv=none; b=SJI27cWLJ3/evzbZimmu7LktNqCE1qfjYmfgxcHDgItUEW8p6PSeGLMjP5Fh170rRqUNnBIbLfLm9M6ZvrEn2ZbNaHBlXWnOVgmf22s1U/vf2FJztVfvyZLBH+6ku4WV3kSY6GHgFSyjHd5Vgxqa7O/geFjW104MVePpQh61Ii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757622236; c=relaxed/simple;
	bh=EbMD20lOlZxBydAK7zCQataQpHJmiIQr5rbqpG7Zzpc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NI9+q8XsVlNTMwMoUGrIa8nKpD00rAUU4Byfht2ZO0DExnXilISvNUfGMcY5a51AAKReKib1eg3OswfZZcW71+IUZ/HB5GuAEbbCv89E8d2qfHMK1aihLos7xuM34T3SC1W6K4aajxAbHN50Q26f5A6WI0t2R6ELRzRzyUe9j+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpjYmvhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25865C4CEF0;
	Thu, 11 Sep 2025 20:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757622236;
	bh=EbMD20lOlZxBydAK7zCQataQpHJmiIQr5rbqpG7Zzpc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DpjYmvhVHH2069jY8Xk+ovmziVk63trTPnxw8lWwh//40wIZFF7azO8G3FOVbmNDU
	 YV7wb/ATHm5u60ySQGT9TIqxg6S3vLMPDPI4z7H/ibGwMC/HVU8NWsvDe5Oqyh/Bit
	 5YV/pdA26H4veimr2BEaCKET2DAP9RkzNPh3qsaq/HkuWBba08d+RDr/IIlNe7jCEd
	 w+mjgtz+ggbQgdfPpYqIiO0JiJHyBskWnuOCDoAyoCk/ZemsliCKUAa6twB8oMHUcX
	 3cSeKMTDQBZaT+gVaPU3CZ9iGX8utS+AWn7EPZ6SShv+wHA7JIAzBto/wGXDPBumDn
	 JN5yUxIH0+eNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EF3CAC58F;
	Thu, 11 Sep 2025 20:23:56 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH v3 0/3] Audio and other peripherals on Orange Pi Zero
Date: Thu, 11 Sep 2025 22:23:54 +0200
Message-Id: <20250911-opz-audio-v3-0-9dfd317a8163@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANovw2gC/1WMwQ6CMBAFf4X07Jq2tLJ48j+MBwqL9EJJWxuV8
 O8WEiMe5+XNzCyQtxTYuZiZp2SDdWOG8lCwdmjGO4HtMjPJpeZKVOCmNzSPzjrAmqOqWzRGEsv
 /yVNvn1vress82BCdf23pJNb1W8FdJQkQoAhPxmjTVqW6TC5EcseRIlszSf5U5PVelcChV30nt
 NayQfmnLsvyAewWE7DeAAAA
X-Change-ID: 20250417-opz-audio-890849c8bb2e
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757622235; l=1167;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=EbMD20lOlZxBydAK7zCQataQpHJmiIQr5rbqpG7Zzpc=;
 b=wrDUZIaMhF3qOeFIsCo2Hiqq6KZy/a7n1QcgKTmhRJX9sBv2YeeyfbFOsg1KkbXU4p7XXCuuU
 /H5tiRvvRcXB2dd2l6Syk5t8My1EdZRf2a9hUdq3dBNHUuRh8m4r6LV
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
Changes in v3:
- Fix name of orangepi-zero-plus2 in patch title
- Link to v2: https://lore.kernel.org/r/20250809-opz-audio-v2-0-f4fd15552a82@posteo.net

Changes in v2:
- Rebase on (almost) 6.17-rc1
- Disable audio pins by default
- Provide separate DT overlay for the Orange Pi Zero Interface Board
- Link to v1: https://lore.kernel.org/r/20250418-opz-audio-v1-1-4e86bb5bc734@posteo.net

---
J. Neuschäfer (3):
      ARM: dts: allwinner: orangepi-zero: Add default audio routing
      ARM: dts: allwinner: orangepi-zero-plus2: Add default audio routing
      ARM: dts: allwinner: Add Orange Pi Zero Interface Board overlay

 arch/arm/boot/dts/allwinner/Makefile               |  7 ++++
 .../dts/allwinner/sun8i-h2-plus-orangepi-zero.dts  | 14 +++++++
 .../dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts | 14 +++++++
 .../sun8i-orangepi-zero-interface-board.dtso       | 46 ++++++++++++++++++++++
 4 files changed, 81 insertions(+)
---
base-commit: 29fdda97f8d5797b160aa8ad1c7248710bb8ffda
change-id: 20250417-opz-audio-890849c8bb2e

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



