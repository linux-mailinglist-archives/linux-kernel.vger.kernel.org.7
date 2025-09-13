Return-Path: <linux-kernel+bounces-815097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF02B55FAB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93891C27DDE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBDB2E973C;
	Sat, 13 Sep 2025 08:59:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0E2E88AA;
	Sat, 13 Sep 2025 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757753965; cv=none; b=m6Va2HTkts5c3izUrHUOofOscCmVvmF4vkwk0nVt5Ip9X9Dh968c8308LVYBQTw6aPuofX5LYhXS/BCSn8ubfWC/5eHCGrqmvcFpL/UG4b3GYJXyx0SulRBYmvrTcO08n7Pm7/RH2oENmiusC1jJoeVQGitwaE7jxm830ZsEaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757753965; c=relaxed/simple;
	bh=jWB2GqmGUMZZQL98Ra2BRA9oHDlw8v2daG3Wt5fn8F4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y05AW91k45sP/biRTF5Xt33e9B1ODeswZI7QAdUNUUkq6oFLuqNkaSUATDggeG0A9dT9kLocCb4qVDD0d/XMsY+tq1ZHB+2FD6vyfg39z6J59S5y+6WRiVk/8eEaUXCAf7+SPWygBdOYkspPhQWZDYAwAEbrpB4aFRSH3+4EACc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26727C4CEEB;
	Sat, 13 Sep 2025 08:59:25 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id C5A065F846;
	Sat, 13 Sep 2025 16:59:22 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20250911-opz-audio-v3-0-9dfd317a8163@posteo.net>
References: <20250911-opz-audio-v3-0-9dfd317a8163@posteo.net>
Subject: Re: [PATCH v3 0/3] Audio and other peripherals on Orange Pi Zero
Message-Id: <175775396278.3880749.17054923060896114061.b4-ty@csie.org>
Date: Sat, 13 Sep 2025 16:59:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Thu, 11 Sep 2025 22:23:54 +0200, J. Neuschäfer wrote:
> 


Applied to sunxi/dt-for-6.18 in local tree, thanks!

[1/3] ARM: dts: allwinner: orangepi-zero: Add default audio routing
      commit: 3173a760021b9340923831aa5edc5530d61a6b9b
[2/3] ARM: dts: allwinner: orangepi-zero-plus2: Add default audio routing
      commit: fd5c7bf8ddb51373a6c9456865b3af99f53642a2
[3/3] ARM: dts: allwinner: Add Orange Pi Zero Interface Board overlay
      commit: b65ee02e77cb14486cf30709e978430e91f74d2e

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


