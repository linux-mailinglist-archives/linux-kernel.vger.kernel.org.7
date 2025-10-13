Return-Path: <linux-kernel+bounces-850679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71361BD380F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C1074F8DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7951D1EF36E;
	Mon, 13 Oct 2025 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="r/s3eL7Z"
Received: from mx-relay50-hz3.antispameurope.com (mx-relay50-hz3.antispameurope.com [94.100.134.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB483146588
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.239
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760365108; cv=pass; b=JxbqpmtqbFshr0ujoJoQcBb8GILvdw4DUfNRkLxUOWvaTV6/BkU8Qv+NQ0iUyo7OX+o6UgCKTPwuaChQBjtMuGjkUNSFN2DVWgh74E6TzgsMKDtjJEeUCSifLxRNEwwjliaE5MxBjKpJpxSDQcA3FmyqENPPdVBQCBNoemAQhkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760365108; c=relaxed/simple;
	bh=5ufhlfvjUyDT/EvvG3BasNRmVjK3W5wb5ZuUARDs7LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAFGERi6+XyCbFzu8l7zVqkvObFaV5WDgWkrgyacyLcm5hWzY+bZ+hW7Tkz46yuIZnTZOiW7WlrsbtS4hDyyA9Rsae4PjzQvKOZQUBvulYZO6UdLOuvfc/mIAaU5gPncLhqX5irjypcSFCO2PF1rNIkv62labD6LOr16MSKmBWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=r/s3eL7Z; arc=pass smtp.client-ip=94.100.134.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate50-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=vyXrVVygqMhn5Bif81+tF99rIVbrn5Q3omrjq9+Xlzs=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760365088;
 b=ADv+6w2OUTRW+ccitpo243pOzpd9H/E32ZmbORcSlXo0utTAjdSve7pgOlvxpGArQ5BuGebG
 yBjk/A3C06wk4Bufknp+1vMN5b+FC1s31zkBmD0izjid2VbuWbSymfsskzh61pQTN7Lj6glSRt/
 TN+3sZ7rfumBivXvMn3IcAnA1nKNU+va3Wx2o4mZ/Cf0adi6ZXyxE6TGlfbNa//kk2d1n3XLqEy
 cUntRNgNt+5HcEP/9tDL2//nKDuSvNRbrzROnS1zSIaOtGWPKbZD5qisHEJbZttEHEVpUtm//22
 2fcPKl5eSOOVKuQ3slNyIOgwAgmtRqBUammMrfjHOWRBA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760365088;
 b=CC0RRzkl7zN51iGlfjFbcAAzjASgWYFdMHiwPILLPS8XEumFOIEc8jceTYqS3HYH070tn2L5
 2Vr5inLixz8iH+GzWaGcQdGyDq6XbE9ooZwDRWIee5WfPqddVMDK50cPN3+Hb68Rl2px2YhNolX
 XD0ldCqmeAWcInpzhNjuPKyJwDTz+47bKs730kXEWMlOSORFl7Zus1jeWDrtYgEK38zVKF8KbRi
 TbUtxIYBO1szhQZWbEJUG0wfW7/lpK3YnZyTTQChNkBA7B3GW9Y8AhIMT8S/wYboorPbL1Guwgp
 vE5n8nHh9N17xoSuXu3+wSnS+gCzO8KKSw+KpDVKW+IfQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay50-hz3.antispameurope.com;
 Mon, 13 Oct 2025 16:18:08 +0200
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 43C43220CFE;
	Mon, 13 Oct 2025 16:17:57 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
 Vinod Koul <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>,
 anthony@amarulasolutions.com
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Anthony Brandon <anthony@amarulasolutions.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH v4] dmaengine: xilinx: xdma: Fix regmap max_register
Date: Mon, 13 Oct 2025 16:17:56 +0200
Message-ID: <2389383.ElGaqSPkdT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250903-xdma-max-reg-v4-1-894721175025@amarulasolutions.com>
References: <20250903-xdma-max-reg-v4-1-894721175025@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay50-hz3.antispameurope.com with 4clfZY5vRpz2nH1K
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:ce6e0c546d8b9a92df42d712c97e6124
X-cloud-security:scantime:2.191
DKIM-Signature: a=rsa-sha256;
 bh=vyXrVVygqMhn5Bif81+tF99rIVbrn5Q3omrjq9+Xlzs=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760365087; v=1;
 b=r/s3eL7Zj9oM+4LwFSI3a3fEc+UeOJ/c6/VJch/8oT/eacfgwIJCA/Chv8YoBAQVVYT0rXzJ
 XTfnXLbvSj5MECwP3ohS5dNAX5xKWJXJgR+JZ+oeE1nUdbj7/n8IsU9a3Kc5IUVUVNEn5C5Rf36
 l3x2F5dKcvCpkqbxBxxIn0xBHg9lN6Z4ipTH7931KH/kZ9znUVCWYvH7r6B6mBFletvZWE7J/kK
 FxE4z7OSRSUT4I0XgT8BKInN86M/RFwU+u/522/wE+2hezZ/H4NTr1Pxa6feDhTBYVcy+O7+ANh
 LgIy1cKPZ16QBlb+oV5KiqzomLYMGFTbeZZmjQ0ctDg0Q==

Am Mittwoch, 3. September 2025, 10:56:13 CEST schrieb Anthony Brandon via B4 Relay:
> From: Anthony Brandon <anthony@amarulasolutions.com>
> 
> The max_register field is assigned the size of the register memory
> region instead of the offset of the last register.
> The result is that reading from the regmap via debugfs can cause
> a segmentation fault:
> 
> tail /sys/kernel/debug/regmap/xdma.1.auto/registers
> Unable to handle kernel paging request at virtual address ffff800082f70000
> Mem abort info:
>   ESR = 0x0000000096000007
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x07: level 3 translation fault
> [...]
> Call trace:
>  regmap_mmio_read32le+0x10/0x30
>  _regmap_bus_reg_read+0x74/0xc0
>  _regmap_read+0x68/0x198
>  regmap_read+0x54/0x88
>  regmap_read_debugfs+0x140/0x380
>  regmap_map_read_file+0x30/0x48
>  full_proxy_read+0x68/0xc8
>  vfs_read+0xcc/0x310
>  ksys_read+0x7c/0x120
>  __arm64_sys_read+0x24/0x40
>  invoke_syscall.constprop.0+0x64/0x108
>  do_el0_svc+0xb0/0xd8
>  el0_svc+0x38/0x130
>  el0t_64_sync_handler+0x120/0x138
>  el0t_64_sync+0x194/0x198
> Code: aa1e03e9 d503201f f9400000 8b214000 (b9400000)
> ---[ end trace 0000000000000000 ]---
> note: tail[1217] exited with irqs disabled
> note: tail[1217] exited with preempt_count 1
> Segmentation fault
> 
> Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
> Signed-off-by: Anthony Brandon <anthony@amarulasolutions.com>
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
> Changes in v4:
> - Reorder Reviewed-by
> - Link to v3: https://lore.kernel.org/r/20250902-xdma-max-reg-v3-1-5fa37b8d2b15@amarulasolutions.com
> 
> Changes in v3:
> - Add Fixes tag
> - Link to v2: https://lore.kernel.org/r/20250901-xdma-max-reg-v2-1-fa3723a718cd@amarulasolutions.com
> 
> Changes in v2:
> - Define new constant XDMA_MAX_REG_OFFSET and use that.
> - Link to v1: https://lore.kernel.org/r/20250901-xdma-max-reg-v1-1-b6a04561edb1@amarulasolutions.com
> ---
>  drivers/dma/xilinx/xdma-regs.h | 1 +
>  drivers/dma/xilinx/xdma.c      | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-regs.h
> index 6ad08878e93862b770febb71b8bc85e66813428e..70bca92621aa41b0367d1e236b3e276344a26320 100644
> --- a/drivers/dma/xilinx/xdma-regs.h
> +++ b/drivers/dma/xilinx/xdma-regs.h
> @@ -9,6 +9,7 @@
>  
>  /* The length of register space exposed to host */
>  #define XDMA_REG_SPACE_LEN	65536
> +#define XDMA_MAX_REG_OFFSET	(XDMA_REG_SPACE_LEN - 4)
>  
>  /*
>   * maximum number of DMA channels for each direction:
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 0d88b1a670e142dac90d09c515809faa2476a816..5ecf8223c112e468c79ce635398ba393a535b9e0 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -38,7 +38,7 @@ static const struct regmap_config xdma_regmap_config = {
>  	.reg_bits = 32,
>  	.val_bits = 32,
>  	.reg_stride = 4,
> -	.max_register = XDMA_REG_SPACE_LEN,
> +	.max_register = XDMA_MAX_REG_OFFSET,
>  };
>  
>  /**
> 
> ---
> base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
> change-id: 20250901-xdma-max-reg-1649c6459358
> 
> Best regards,
> 





