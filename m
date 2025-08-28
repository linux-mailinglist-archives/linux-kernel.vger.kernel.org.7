Return-Path: <linux-kernel+bounces-790356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 685C7B3A5DE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5779C18891D3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D682D9ED0;
	Thu, 28 Aug 2025 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLGzPffi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E3629993F;
	Thu, 28 Aug 2025 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397680; cv=none; b=X+/5KIvUq1kKbbfeILjKbBJ3JtoRSrd31nHEipbv1lg3MFgsnhcAGGB0Xj+C8imA/cQJc7kSuIqH1AnfoDXSS+RaGxbVAC4ioYtBtZJbC641TlXeySnyt/cC/i1PL84xwQqHrl5n/ND5xEv9ks/oEEjvrKg2IoM9oeygQzRbr/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397680; c=relaxed/simple;
	bh=w1rDoj1PZWDUXnkCbbX4505cj5XQXh3XYYhIua+JY4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WapDJxr5s6TqanHnoeh5tONrfW5FdiNI5JxjzA9FUh8LXoWX5Gr5Dn9yBUVbR3TlHteW/fx0XwClacryInZuAwIsi94eTilrhXZzNmtaCWFAjnbT7OEmK2Ips488gFlxu8Umjm8GpEeIhOUUaaL3WxhR5Sc+/Qtd9tCpuqECfJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLGzPffi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACB2C4CEEB;
	Thu, 28 Aug 2025 16:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756397679;
	bh=w1rDoj1PZWDUXnkCbbX4505cj5XQXh3XYYhIua+JY4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLGzPffijHgVDUxrwLW3/YlgYKmtAS76fai3FmrIUOmJuxBhM1zYVidYHpBrXh6ef
	 nf66HjF46Fv/Xh8SUY8ZcstGj3s4LQ4v5kIfc0KusD3DyhXREn5u0QurksfkVQXqtM
	 1MX81ByN9aG5ex/YkQwwbHKLnEz9GX3rJdv3dl0RArPhx80/1WgVP0oGMU73clpj8o
	 qi0LH+q0s75ukxZRF2WdrHDshUf4S7GynGuvvvNrKRIfvYKKmpbdWbdn0ht2v4uBQO
	 jAGuSC37hAOL9C66ICpMB4W1XomOUfPJ+geY5gjAFRxdS9FQpfKFLiKx8lCjEE3JNW
	 YxFPiczUB4FTA==
From: Conor Dooley <conor@kernel.org>
To: daire.mcnamara@microchip.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v1 0/5] Icicle Kit with prod device and Discovery Kit support
Date: Thu, 28 Aug 2025 17:14:30 +0100
Message-ID: <20250828-aloft-procurer-7316559f2e30@spud>
X-Mailer: git-send-email 2.47.2
In-Reply-To:  <20250825161952.3902672-1-valentina.fernandezalanis@microchip.com>
References: <20250825161952.3902672-1-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=NYXKvAfMqZtWqo/K3uDK7cV1jaCUvi3zYkj9bk8jQ2M=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBkbGtK/Rp5qVJzftyyi546iJt//vutOe59uSfjIxRfEN O/J8c+eHaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiIxklGhoV7vk70ujWlv+6C +KF9kSu6T+/eMqXBe9mc8htfu/9p9WUyMlx65dddU8AkMd+603Hzph9LVmQqdjZFdx28qp4YlrF tJgMA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 25 Aug 2025 17:19:47 +0100, Valentina Fernandez wrote:
> With the introduction of the Icicle Kit with the production device
> (MPFS250T) to the market, it's necessary to distinguish it from the
> engineering sample (-es) variant. This is because engineering samples
> cannot write to flash from the MSS, as noted in the PolarFire SoC
> FPGA ES errata.
> 
> This series adds a common board DTSI for the Icicle Kit, containing
> hardware shared by both the engineering sample and production
> versions, as well as a DTS for each Icicle Kit variant.
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/5] riscv: dts: microchip: add common board dtsi for icicle kit variants
      https://git.kernel.org/conor/c/2a95aaa34dfe
[2/5] dt-bindings: riscv: microchip: document icicle kit with production device
      https://git.kernel.org/conor/c/4b9e63bb6491
[3/5] riscv: dts: microchip: add icicle kit with production device
      https://git.kernel.org/conor/c/1ba401aae7a1
[4/5] dt-bindings: riscv: microchip: document Discovery Kit
      https://git.kernel.org/conor/c/0d880b095a19
[5/5] riscv: dts: microchip: add a device tree for Discovery Kit
      https://git.kernel.org/conor/c/f66eb149b876

Thanks,
Conor.

