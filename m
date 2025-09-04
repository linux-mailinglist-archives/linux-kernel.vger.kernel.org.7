Return-Path: <linux-kernel+bounces-801430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E9FB444E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586B61CC3106
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04AC3218DD;
	Thu,  4 Sep 2025 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSwL9s7Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF2430499B;
	Thu,  4 Sep 2025 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008699; cv=none; b=G5Oes7MWUH38f3A2stWQWWSdbTl6xUsn9hia1Xq+Dm60Q2NF0tlTx3kTpcFfq8DQvtWEBTenYjJRzagzRqKhT2EprROjV57UUKDjCrrV042CdxVLvevicnAngo6BLdbBo/2TvRlM7MqWuBsfqjapiAA5nHO2ahjpc3uTSX0oN3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008699; c=relaxed/simple;
	bh=7elZHPtlC8l1IoBhLhG19SetZaPA34oBP89NcJL1vZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMKW8iwVuA46ijqjROtISJkKpKC/rHf/FZ3fwTC6ZrRCO80vSWJZkWKWAUWBi0Zp/n0Rq56/shJm4gY3yhS25XHFK2V92WkIVSMz+fry/WSBBgTjgDDSkJU8OMd0hbIHTI20DzJAXvngm1LT5pCiHIqKH/VnbHLpRjRGScYYdrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSwL9s7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DCCC4CEF0;
	Thu,  4 Sep 2025 17:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757008697;
	bh=7elZHPtlC8l1IoBhLhG19SetZaPA34oBP89NcJL1vZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSwL9s7Y4bphJ02iOcCICAt0fmm9wSRhKUHQtPF8wWT1kgZIA6nbpXgr9OP/mk7X6
	 UKxo3ceeO9UBqgT7UgI8EHwSiV8p8pEz4ROt0wNKhrBcCJn7Kp6PE5COvNBZisQSQX
	 fYLPnekQBa2mdR4NsRWZO4WFuL/DLk7iCBSgYaNGLyowAbDlkhzjBtL7AcTJLer+nQ
	 4rHOmXaGgIM6jtgf264SmOqcIE2PFdRPwfkFh55myqQJT2q9uv0k7/l+zDBRL0Mi3B
	 uPNzY9g/oFSSvuLmn3kJLRTPCzVh8/7tit8SXI3bGgYu4izi1E1Y8GwmW7KVBpdtRf
	 mGcUNexmUCCfw==
From: Conor Dooley <conor@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	E Shattow <e@freeshell.de>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: Re: [PATCH v3 RESEND 0/3] riscv: dts: starfive: jh7110: More U-Boot downstream changes for JH7110
Date: Thu,  4 Sep 2025 18:58:08 +0100
Message-ID: <20250904-grape-convent-8c36463138e2@spud>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250823100159.203925-1-e@freeshell.de>
References: <20250823100159.203925-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=DvqGObKk3A0+efhmDIZrcZyaCaRbYupeDJa2E7LAsUk=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBk7L+s3Snxw437T+XjHhfpo1+ZZyqa1CyYcUDCa73HDc K8Pu+GMjlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzkRwPDX8HiCjtDnrZgptXG O+N+/p7ye42ynqfAw6TIU77BZ7+q9DIytE1lc26Tvv/uYj+7u5SNzZdflfuPB7KFmlUeMz1g1dn FBQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Sat, 23 Aug 2025 03:01:40 -0700, E Shattow wrote:
> Bring in additional downstream U-Boot boot loader changes for StarFive
> VisionFive2 board target (and related JH7110 common boards). Create a
> basic dt-binding (and not any Linux driver) in support of the
> memory-controller dts node used in mainline U-Boot. Also add
> bootph-pre-ram hinting to jh7110.dtsi needed at SPL boot phase.
> 
> Changes since v2:
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/3] dt-bindings: memory-controllers: add StarFive JH7110 SoC DMC
      https://git.kernel.org/conor/c/f5e36ecc9e4a
[2/3] riscv: dts: starfive: jh7110: add DMC memory controller
      https://git.kernel.org/conor/c/7114969021ec
[3/3] riscv: dts: starfive: jh7110: bootph-pre-ram hinting needed by boot loader
      https://git.kernel.org/conor/c/8181cc2f3f21

Thanks,
Conor.

