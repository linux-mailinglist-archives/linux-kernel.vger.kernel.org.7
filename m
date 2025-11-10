Return-Path: <linux-kernel+bounces-892579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BEAC45622
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13C5B346E7E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2338D25393B;
	Mon, 10 Nov 2025 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMRR5k5g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB2E230264
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763536; cv=none; b=MTEdYtohDNvLsqdyGfXcl9R3w0dwG11ltJkOJNnZA347uQUTlDFZ+CpZScMHCbMLIk8yYWSndtIZyawnd7KO8D8hDtwArdX2KU7WyrniMmMTTmOLw1K67tufcDS8MjMrfdX+ZfnFoZ326J471GwG2TEU/U1OXx7/TcxWlpiP+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763536; c=relaxed/simple;
	bh=LfDdgaN1+zrXpFbu5QvgKUFQAnKz6UNyo1XGdINPiI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3Jqbr6OQJr40GjQPbY2/BOeH6xKxG+PLP0xUsRFBeRk3OVWpjKJDoNQZhXoGlQAkIcEwFyhyRQSfPmCPcp6y+RkhimHeLV5/LYEk4BhtDeb1antZrOrrQLRpvJqx0dOjb99Te+vTy1qImZus+hn69HgaDiA3PDx52ONmvcp1Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMRR5k5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83221C4CEFB;
	Mon, 10 Nov 2025 08:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762763535;
	bh=LfDdgaN1+zrXpFbu5QvgKUFQAnKz6UNyo1XGdINPiI0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GMRR5k5gFb5F2tLeUO2m+6tbHzfYb40ry5FrWnqQtuz74m1Q+B0yjRFCZgZ05Jdey
	 eJteaIaua+hptdpcLDQrIHkGh0mwVoSKf5dHWGlR3Hr/6AY1XpKOukzt7+22U+cMK2
	 R0q8teD8REgBX7ewCs/m7x0KUAPLowLZo06zsbb8/ra27btFd1qDpVsZaoDJ+i/9/N
	 cI6gxRNfri2ZEzMcfpudnpa5kk+XPBnFl2GFcg/kfCesBNvVdK5c1AWviyAHXjG+uU
	 m9UgSqUihxMoawsj16qicq+s0bfCxN6Z9v+5oAAQ+rCM84oOF7yRqoT7bYe6KNbxsR
	 HTHKUIvIe6GPQ==
Message-ID: <3951551f-02e9-41a3-8212-ac1cbaecc69a@kernel.org>
Date: Mon, 10 Nov 2025 08:32:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] nvmem: core: update cell->bytes after shifting bits
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 linux-kernel@vger.kernel.org
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250930142212.521925-1-emil.renner.berthing@canonical.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20250930142212.521925-1-emil.renner.berthing@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/30/25 3:22 PM, Emil Renner Berthing wrote:
> When support for bit offsets of more than one byte was added it
> unfortunately left the cell->bytes value at the number of bytes read
> including the offset. Make sure to update it to the proper number of
> meaningful bytes in the returned data.
Sorry somehow I missed this patch.

If the number of bytes are different to the bytes that are part of cell
then the parsing code seems to have missed some cases, which is the
right place to fix.

Can you share more details on the values that you pass as part of the
cell definition.

> Fixes: 7a06ef751077 ("nvmem: core: fix bit offsets of more than one byte")

missing CC stable

> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
>  drivers/nvmem/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 387c88c55259..5f6d22545e39 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1640,6 +1640,8 @@ static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void
>  	/* clear msb bits if any leftover in the last byte */
>  	if (cell->nbits % BITS_PER_BYTE)
>  		*p &= GENMASK((cell->nbits % BITS_PER_BYTE) - 1, 0);
> +
> +	cell->bytes = (p - (u8 *)buf) + 1;
cell bytes can only be updated during parsing time not during every
access time.


--srini>  }
>  
>  static int __nvmem_cell_read(struct nvmem_device *nvmem,


