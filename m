Return-Path: <linux-kernel+bounces-860787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F18BF0F28
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D0B18A3903
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB6B3019C1;
	Mon, 20 Oct 2025 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="MWppHG0s"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EF32D5930
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961346; cv=none; b=BjaPsitUqlxXDWcTpVLP2ZyhxcKNo8JjcwplJfkEML8YIkcP/hgbK+/wXUVFSX1Q/7opR4ojR8e0soCd4X+6l4NLwX+zz0Se5BfDfpG0UoIup4aqaK1gdt2jNjCJc5q/TcdRjyzl1xfQ2UOhlGPgd++4UtFLUQ2ymp/K6Ngcb/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961346; c=relaxed/simple;
	bh=rdnEIDk7vTfocUFpBgD7HnZbhxvO/Uq5dPbmEHU7nvw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DnrGRdlrMUTyS3lSDNvZ4ulsnbQQi3oOH/rCsG8Y8vj3n+aZw8i8Td925AkjDcPBMgULWEC5km76rIkQbnzcT6GXQyIo+mggLJqnYCaN/eie6muUuxiyJBfQZUMC9gkIsIGOK4+yHumszOJCYHk//Uj6uKlPDwAtg3uDAvN7QVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=MWppHG0s; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=F7SQR9eNbNCAD7rLP+Q07KyKtgqbnj/0w+1/RkqAeVo=;
  b=MWppHG0sMYJytcT3VbERB3kUJybAwFbwoYXn3G9lTbsvKoKpkyVGBOxk
   4f0m/ZMwqD/GBUvRuyHmssjz/OEhXSc8DNdT4gu3LbztOvMeeQG0YXAsP
   ZRxhK00cGK4E2x1ELwehyYq+w/bpeYDnFjsxuX8quLl86F3zxZTR7UwgU
   M=;
X-CSE-ConnectionGUID: D2WPmbZFTu6YbDHuIt62Lw==
X-CSE-MsgGUID: Ml/iJ/hFSkWfJJFQpo8FMg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.19,242,1754949600"; 
   d="scan'208";a="245230437"
Received: from unknown (HELO hadrien) ([202.187.235.241])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 13:55:33 +0200
Date: Mon, 20 Oct 2025 19:55:31 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: Geert Uytterhoeven <geert+renesas@glider.be>
cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
    Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    Andrew Morton <akpm@linux-foundation.org>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
Subject: Re: [cocci] [PATCH] coccinelle: of_table: Update Keywords for SPI
 device ID tables
In-Reply-To: <843cb14b08b201a1b35b690d4602ac7912a0f8fd.1760454689.git.geert+renesas@glider.be>
Message-ID: <a6974374-f24f-e677-74b-201de69862e1@inria.fr>
References: <843cb14b08b201a1b35b690d4602ac7912a0f8fd.1760454689.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 14 Oct 2025, Geert Uytterhoeven wrote:

> When adding support for SPI device ID tables, the keywords in the header
> were not updated.
>
> Fixes: 347b564599fb01d8 ("coccinelle: of_table: handle SPI device ID tables")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Julia Lawall <julia.lawall@inria.fr>


> ---
>  scripts/coccinelle/misc/of_table.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/misc/of_table.cocci b/scripts/coccinelle/misc/of_table.cocci
> index 7ade9766dee89c70..9de406b692a590ba 100644
> --- a/scripts/coccinelle/misc/of_table.cocci
> +++ b/scripts/coccinelle/misc/of_table.cocci
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /// Make sure (of/i2c/platform)_device_id tables are NULL terminated
>  //
> -// Keywords: of_table i2c_table platform_table
> +// Keywords: of_table i2c_table platform_table spi_table
>  // Confidence: Medium
>  // Options: --include-headers
>
> --
> 2.43.0
>
>

