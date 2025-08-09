Return-Path: <linux-kernel+bounces-761181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5674FB1F563
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF45062613F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 16:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB39D2BEC52;
	Sat,  9 Aug 2025 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxmhfCJA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBA4AD51;
	Sat,  9 Aug 2025 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754756305; cv=none; b=WviPob4mCMsC/wMZN8ZR+AaMO7sYLHIxOVaoLf8T7E0AxnFgke8CJ30r82yRzc9uZEGB9QqTGm+hm89nZkomeh76WDK7ldHyiAnAqJqgdmH15NvvcIIWYBluklxUPJJRH68uWT2Lqtq4QSGs4+1DMIf8HGHGHh2e/jdzsSWSOhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754756305; c=relaxed/simple;
	bh=Bwb6t2YuRUfjH9rtbL/iknXzFlmnm4YAv6kHXJJPfCc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q5dfpD5qBBm5Y8/l49bs4mREy+hIWEVLUlB47DR+sqbSi75GAaFkKPOswCDbFNDE8qkZ+2ZcljCBcFfWMXXc3K1mjx2iE7/5QbLmyvDMLEtVv4kofIJHsm6fTbyShWh9TmFNRDx3FJxXNc0hj4B9H6d+KtMPdKhiyoNPvxOoIKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxmhfCJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94A83C4CEE7;
	Sat,  9 Aug 2025 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754756304;
	bh=Bwb6t2YuRUfjH9rtbL/iknXzFlmnm4YAv6kHXJJPfCc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=WxmhfCJANyNDVkwjSJprunldKaEGS8PyJKlbE+ylFclnnxnKfQD/pPhr3rmyYryDW
	 KcvFI5BjMbU9D/xwFGwFIUUjMzhtlqoJXvmWJaQ2jyBwct9C4zLo6nPEASitzbaelv
	 mLNE1UMe+QHlDtTkoidxwNAZvZGUJBXbzM/KZL2jmwW6jMoefOizgph2qE9g1EPk41
	 4n5Sxxb0EB6t/0b4IlIQ8L3Wg6jD1RYzauDnIOakSk0f5/jabeu/FR2snbnyIT3Ogq
	 wzCCkj84Abu47SW8fkVXxBUVLxNVr3ut4fRvdkEpMzqX4yzpyrzW9hsSknqh9AyF2h
	 iBiDL3o2muC8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF1AC87FD2;
	Sat,  9 Aug 2025 16:18:24 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH v2 0/3] Audio and other peripherals on Orange Pi Zero
Date: Sat, 09 Aug 2025 18:18:05 +0200
Message-Id: <20250809-opz-audio-v2-0-f4fd15552a82@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAL10l2gC/03MQQ7CIBCF4as0sxYDSC3tynuYLgod7WyAQCVqw
 93FJiYu/5eXb4OEkTDB0GwQMVMi72rIQwN2mdwdGc21QXLZciU65sObTY+ZPNM916q32hiJUP8
 h4o2eu3Uday+UVh9fO53Fd/0p+k/JggmmUJ+NaY3tTuoSfFrRHx2uMJZSPpkBRDSjAAAA
X-Change-ID: 20250417-opz-audio-890849c8bb2e
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754756302; l=1005;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=Bwb6t2YuRUfjH9rtbL/iknXzFlmnm4YAv6kHXJJPfCc=;
 b=M7EvQXq4AITTYxKXjvWKmbdYsFY8YmBweMFkH+7/uCjZJtk5oXQhfg7cjblavaI1YXjCEMJfv
 7Qn+cYdiikoA1sq1BfTl9mPzw6SGataXmHp07VPaQvx189eg50rM062
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
Changes in v2:
- Rebase on (almost) 6.17-rc1
- Disable audio pins by default
- Provide separate DT overlay for the Orange Pi Zero Interface Board
- Link to v1: https://lore.kernel.org/r/20250418-opz-audio-v1-1-4e86bb5bc734@posteo.net

---
J. Neuschäfer (3):
      ARM: dts: allwinner: orangepi-zero: Add default audio routing
      ARM: dts: allwinner: orangepi-zero2: Add default audio routing
      ARM: dts: allwinner: Add Orange Pi Zero Interface Board overlay

 arch/arm/boot/dts/allwinner/Makefile               |  7 ++++
 .../dts/allwinner/sun8i-h2-plus-orangepi-zero.dts  | 14 +++++++
 .../dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts | 14 +++++++
 .../sun8i-orangepi-zero-interface-board.dtso       | 46 ++++++++++++++++++++++
 4 files changed, 81 insertions(+)
---
base-commit: 36c31984cca32c5d9720c8c1eb5bd17fa915419f
change-id: 20250417-opz-audio-890849c8bb2e

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



