Return-Path: <linux-kernel+bounces-806561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699FAB4987F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54894444E7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86C431B835;
	Mon,  8 Sep 2025 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+gWs6gG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6D831194E;
	Mon,  8 Sep 2025 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757356881; cv=none; b=STxQbW5gzKxTpJBaEAwOX2zu9hzBXnjSH3ns7JWUR1/8qAEgKp0g+cvd8XRGHuatr+EsDcnDu/Fr5wYeH/kpmgOQebXsx8M/ARmJYBaGUEz11HlPSFtL7ifeUk92GqBAP3pBIL08mLU6PgFgoxjjwrZda+9KxDUIiHqRJSSzslU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757356881; c=relaxed/simple;
	bh=9UbZIylSOOcUsfXTPHSeBMsVpKt2/NcF2RFEaeA8gJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4Q+YJO0qtTDXd0UUYq7eDN6BucfaBiIi+uYyOl1q1qiqgTurH4P4E9umjK+zAtup9yLsFYk8wwc8sUc8tbJKM+XnByLUwL3yNy4XrubGLlFzq05xjKNmcpdPVyyUOgSllLhutpixH0S3+4DJjBtEy3faZXOpWuAjnXUEhbq4M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+gWs6gG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBA5C4CEF5;
	Mon,  8 Sep 2025 18:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757356880;
	bh=9UbZIylSOOcUsfXTPHSeBMsVpKt2/NcF2RFEaeA8gJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+gWs6gGf79i18orC+mU8AvkWdoPthfUaBU+2bFOxO0HVt3UzaQReQ53BE2bF9cuL
	 JeQg5KzbsvLqoRQjI2jzGTzIfUvFk9/yYT32jDwg5XbgugolEmTdFO3Nq3TQ+YSnnc
	 hbGxLyRtB7UkFDf+xfrp0skGd5zuIxdJjCnE1A7jCL61z5/8j99GFFF9ryYY5UPSZb
	 uzGtPpDJ86YnKCkQCD5EFcwyWtLDAufWdX+LkQTxmIx4R8c8K8J1sKuhlztnJFD6tW
	 m8ICXKfvlUy4JNgiFtjUtE9I391scd69oWCJqLC61CJ9Pd9xOojTkE3nmfgRss6F21
	 FLsmhomIE3tUw==
From: Conor Dooley <conor@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	E Shattow <e@freeshell.de>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v1 0/2] riscv: dts: starfive: jh7110-common: drop no-mmc and power-on-delay-ms from mmc interfaces
Date: Mon,  8 Sep 2025 19:41:10 +0100
Message-ID: <20250908-prognosis-nimbly-3a10aa0bcb22@spud>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250903101346.861076-1-e@freeshell.de>
References: <20250903101346.861076-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=697; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=y1ANHXKExkpfH20vLWjNgJDo74JRGsK0QuAX3xqB3WU=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBn7ld3OtKrXN2sEW4YabGHI9u2QMVLlkbTw1jiXrf7Kx e+8akVHKQuDGBeDrJgiS+Ltvhap9X9cdjj3vIWZw8oEMoSBi1MAJsI1jZFhv7Poks5yPot/THyR p8VXdMgeTncxvBq2IFa2L4FXhu8TI8Nflwd3tXZP+qm4rH/mbqG6E6WxcUumcZ9b07woOuUiTzk nAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 03 Sep 2025 03:13:34 -0700, E Shattow wrote:
> Drop no-mmc and power-on-delay-ms properties.
> 
> The committer cannot be reached for comment and per discussion [1] and
> testing there is not any observable problem that is being solved by
> having these properties for the VisionFive 2 or similar variant boards
> through the jh7110-common.dtsi include.
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/2] riscv: dts: starfive: jh7110-common: drop no-mmc property from mmc1
      https://git.kernel.org/conor/c/08128670a931
[2/2] riscv: dts: starfive: jh7110-common: drop mmc post-power-on-delay-ms
      https://git.kernel.org/conor/c/b5a861a438d1

Thanks,
Conor.

