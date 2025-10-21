Return-Path: <linux-kernel+bounces-863014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A10BF6CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97E54504F67
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BA1336EFF;
	Tue, 21 Oct 2025 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cil8iBtA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05436169AD2;
	Tue, 21 Oct 2025 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053525; cv=none; b=KsU97Dl606SArTe0GQtvZMUvZdkCU+NPDOdNT+LUolFKFgfulVhT9WOB/y6VlSZ+PnoDf4gFMFymTynmvGYtWha8cL0HNsbdSB3QudEajKaNO/TecM0d/q/R12HTelCwU7LNkBAH5hzdt992v2MHPyUoD/Pw7yZLJjQBIuzxHnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053525; c=relaxed/simple;
	bh=nyuiyacr165FLqxyWKt1B4gvgh4RzY/Ij1hXstDErIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rput1g+eTDkR/uDkO3E2wjNF4p5BVsx5LJBW/Y02J2jiYMetBIG3MMi3SNgq0VQOXqnqGHPgeb6FHr69wXLrnkAGlGw0iygQQmJrZP2GwxQojz3WooJi5Af90QAq4Gi3olI3mopdyJsAA7YeMQZk5h2Ni6JsCK4LxxUvNpWvZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cil8iBtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8D1C4CEF1;
	Tue, 21 Oct 2025 13:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761053524;
	bh=nyuiyacr165FLqxyWKt1B4gvgh4RzY/Ij1hXstDErIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cil8iBtA/atoolDBeOsa4U9BKo1ptHWOAXfTcEX6czp1OYcyYe3FnYKwM4/oxkR2R
	 dSLthkOzJaOdujRm2PUgDWgMFkOUiQqQ8fK9apV8sf/ae00SHABN2XIlK8MDNk+1bD
	 5lKJ7sIi6pMd0+oMBVfvuhkmGT4oGxIP59P2jD1Q93wbZHx8HjnIDatzhsoJ9EW56z
	 HzXW5VLv0n5Nbat7KvmLT74fqrR33YWgmiCqAePyIc9IiwGxzC6uSilvrN6wmRqNdw
	 ORe2T5RsCIZLmK31YgJiu/AjUlpPY8R5WMQm0bt4JcYjydmzKELDLmHT5OIFkFk+qH
	 8QtMEigusE5Hw==
From: Conor Dooley <conor@kernel.org>
To: claudiu.beznea@tuxon.dev,
	Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/9] Redo PolarFire SoC's mailbox/clock devicestrees and related code
Date: Tue, 21 Oct 2025 14:31:29 +0100
Message-ID: <20251021-ranked-attendee-8caed80461b2@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013-album-bovine-faf9f5ebc5d4@spud>
References: <20251013-album-bovine-faf9f5ebc5d4@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=zvlQ9UDW5VIJo68sV6XLu9TdJq0uO5RaIpr0pIhrGlg=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBnfuw06L5at+38rrWfu8afsV76WCMUoX4lrm9jUtfqY2 6uLW7qmd5SyMIhxMciKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAimfoM/z37vjSa3JwhXCId rvtJ63+VqiCLSra9U2mIo0f7hc7wUwz/y9qblsk3b7iqXppjsnVu/Kvo7cukfl9XcrQ9udS7PGw uFwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 13 Oct 2025 18:45:32 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> In v5 the only real change is that I removed the attempt at a common
> implementation of regmap-based divider/gate clocks. The series hasn't
> managed to receive feedback on my approach in 2025, despite sending
> several revisions and bumps, and it is blocking support for both new
> drivers (gpio interrupt support, pinctrl and hwmon off the top of my
> head) and a new platform so I have decided to strip out the attempt at
> making something common in exchange for something that can be merged
> through the clk-microchip tree without relying on feedback from the
> clock maintainers.
> 
> [...]

Applied to riscv-soc-drivers-for-next, because the pinctrl series that
I am working on needs them.

[1/9] dt-bindings: soc: microchip: document the simple-mfd syscon on PolarFire SoC
      https://git.kernel.org/conor/c/feaa716adc51
[2/9] soc: microchip: add mfd drivers for two syscon regions on PolarFire SoC
      https://git.kernel.org/conor/c/5b59e62532fc

Thanks,
Conor.

