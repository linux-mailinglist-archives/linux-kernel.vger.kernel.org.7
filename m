Return-Path: <linux-kernel+bounces-852960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D539BDA4D1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7352189A58F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D11B2C027A;
	Tue, 14 Oct 2025 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sgl1/vzL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A40821ABD0;
	Tue, 14 Oct 2025 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455061; cv=none; b=YB/fjnO+TYjEPk1/E6sC871KocxzwSrL8eEkFk/lbB59rh/iADiezafLYpm5R3PbYTOsNuAgx4jUGwHLwiHGCZx1ASObLtY+LVwECUZLigQKz9yKQqUWMHCqciIJDoVk+wTvIc+FOg/98pQlm7WOzLiLuFp/1iNQgfmBBmqJ4d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455061; c=relaxed/simple;
	bh=e/+3S+ElEy16pfzh6ZG7xSFnFeIBpdkAnFAVrQb10CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKe7nwZGTBqrArZrf5Y+2xBzlhuUwZKBwgOuWYNT4IkCHV9BNFguWJ7ZpwzoG+y+e6q3WFaQcR1t0QcbZyUlrYEdj13TGmJuUTj/2gSxP0ORbAw2ccP2PKvQVPkkSM8twXU1P3i0/HSK2jSq+D2Gu94nmNlhEzVDZyJko0BTGcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sgl1/vzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF1AC4CEE7;
	Tue, 14 Oct 2025 15:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760455060;
	bh=e/+3S+ElEy16pfzh6ZG7xSFnFeIBpdkAnFAVrQb10CE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sgl1/vzLeGTwl4CXmEeHBqb8Ux0YflbgFdQnGcvcTEycf00De2309mrbvf+gKF9M0
	 p9RWld1M3dKyVwfxoZjD3wMNV7Bah7Hhv+de4T7EKtAVVwCeuoPieRv04vJEdhjtm8
	 Pi0P1SpbGPSD2Tv/g7E+zvJiB6e47ZXyP3LL9pnLZYfFrDJFumaI5utgVFnDKAf5Va
	 HSbvDkw5YjUOy6JQCw+la+RIY1Q4AQ88dSU+B5+ia+wJ0153NGROuLvpoGiqsUNTGt
	 wCH7HIgp94OJRg3EJZ4rm9oeRc4u9ysKrlKCbPLiH3ZX+bQ0/F+tcQrCE/+qn0ymM8
	 EGG4qk5447kvA==
Message-ID: <d88696c7-4ea9-445b-82ac-f5379f952bd8@kernel.org>
Date: Tue, 14 Oct 2025 09:17:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] lib/xz: remove dead IA-64 (Itanium) support code
To: Ankan Biswas <spyjetfayed@gmail.com>, akpm@linux-foundation.org
Cc: lasse.collin@tukaani.org, visitorckw@gmail.com,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20251014052738.31185-1-spyjetfayed@gmail.com>
Content-Language: en-US
From: Khalid Aziz <khalid@kernel.org>
In-Reply-To: <20251014052738.31185-1-spyjetfayed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 11:24 PM, Ankan Biswas wrote:
> Support for the IA-64 (Itanium) architecture was removed in
> commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture").
> 
> This patch drops the IA-64 specific decompression code from
> lib/xz, which was conditionally compiled with the now-obsolete
> CONFIG_XZ_DEC_IA64 option.
> 
> Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
> Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Acked-by: Lasse Collin <lasse.collin@tukaani.org>
> ---
> Changes in v3:
> - Removed log about IA-64 support in upstream
> 
> Changes in v2:
> - Added second hunk to diff of xz_private.h
> 
>   lib/xz/xz_dec_bcj.c | 95 ---------------------------------------------
>   lib/xz/xz_private.h |  4 --
>   2 files changed, 99 deletions(-)
> 
> diff --git a/lib/xz/xz_dec_bcj.c b/lib/xz/xz_dec_bcj.c
> index 8237db17eee3..610d58d947ab 100644
> --- a/lib/xz/xz_dec_bcj.c
> +++ b/lib/xz/xz_dec_bcj.c
> @@ -20,7 +20,6 @@ struct xz_dec_bcj {
>   	enum {
>   		BCJ_X86 = 4,        /* x86 or x86-64 */
>   		BCJ_POWERPC = 5,    /* Big endian only */
> -		BCJ_IA64 = 6,       /* Big or little endian */
>   		BCJ_ARM = 7,        /* Little endian only */
>   		BCJ_ARMTHUMB = 8,   /* Little endian only */
>   		BCJ_SPARC = 9,      /* Big or little endian */
> @@ -180,92 +179,6 @@ static size_t bcj_powerpc(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
>   }
>   #endif
>   
> -#ifdef XZ_DEC_IA64
> -static size_t bcj_ia64(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
> -{
> -	static const uint8_t branch_table[32] = {
> -		0, 0, 0, 0, 0, 0, 0, 0,
> -		0, 0, 0, 0, 0, 0, 0, 0,
> -		4, 4, 6, 6, 0, 0, 7, 7,
> -		4, 4, 0, 0, 4, 4, 0, 0
> -	};
> -
> -	/*
> -	 * The local variables take a little bit stack space, but it's less
> -	 * than what LZMA2 decoder takes, so it doesn't make sense to reduce
> -	 * stack usage here without doing that for the LZMA2 decoder too.
> -	 */
> -
> -	/* Loop counters */
> -	size_t i;
> -	size_t j;
> -
> -	/* Instruction slot (0, 1, or 2) in the 128-bit instruction word */
> -	uint32_t slot;
> -
> -	/* Bitwise offset of the instruction indicated by slot */
> -	uint32_t bit_pos;
> -
> -	/* bit_pos split into byte and bit parts */
> -	uint32_t byte_pos;
> -	uint32_t bit_res;
> -
> -	/* Address part of an instruction */
> -	uint32_t addr;
> -
> -	/* Mask used to detect which instructions to convert */
> -	uint32_t mask;
> -
> -	/* 41-bit instruction stored somewhere in the lowest 48 bits */
> -	uint64_t instr;
> -
> -	/* Instruction normalized with bit_res for easier manipulation */
> -	uint64_t norm;
> -
> -	size &= ~(size_t)15;
> -
> -	for (i = 0; i < size; i += 16) {
> -		mask = branch_table[buf[i] & 0x1F];
> -		for (slot = 0, bit_pos = 5; slot < 3; ++slot, bit_pos += 41) {
> -			if (((mask >> slot) & 1) == 0)
> -				continue;
> -
> -			byte_pos = bit_pos >> 3;
> -			bit_res = bit_pos & 7;
> -			instr = 0;
> -			for (j = 0; j < 6; ++j)
> -				instr |= (uint64_t)(buf[i + j + byte_pos])
> -						<< (8 * j);
> -
> -			norm = instr >> bit_res;
> -
> -			if (((norm >> 37) & 0x0F) == 0x05
> -					&& ((norm >> 9) & 0x07) == 0) {
> -				addr = (norm >> 13) & 0x0FFFFF;
> -				addr |= ((uint32_t)(norm >> 36) & 1) << 20;
> -				addr <<= 4;
> -				addr -= s->pos + (uint32_t)i;
> -				addr >>= 4;
> -
> -				norm &= ~((uint64_t)0x8FFFFF << 13);
> -				norm |= (uint64_t)(addr & 0x0FFFFF) << 13;
> -				norm |= (uint64_t)(addr & 0x100000)
> -						<< (36 - 20);
> -
> -				instr &= (1 << bit_res) - 1;
> -				instr |= norm << bit_res;
> -
> -				for (j = 0; j < 6; j++)
> -					buf[i + j + byte_pos]
> -						= (uint8_t)(instr >> (8 * j));
> -			}
> -		}
> -	}
> -
> -	return i;
> -}
> -#endif
> -
>   #ifdef XZ_DEC_ARM
>   static size_t bcj_arm(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
>   {
> @@ -509,11 +422,6 @@ static void bcj_apply(struct xz_dec_bcj *s,
>   		filtered = bcj_powerpc(s, buf, size);
>   		break;
>   #endif
> -#ifdef XZ_DEC_IA64
> -	case BCJ_IA64:
> -		filtered = bcj_ia64(s, buf, size);
> -		break;
> -#endif
>   #ifdef XZ_DEC_ARM
>   	case BCJ_ARM:
>   		filtered = bcj_arm(s, buf, size);
> @@ -699,9 +607,6 @@ enum xz_ret xz_dec_bcj_reset(struct xz_dec_bcj *s, uint8_t id)
>   #ifdef XZ_DEC_POWERPC
>   	case BCJ_POWERPC:
>   #endif
> -#ifdef XZ_DEC_IA64
> -	case BCJ_IA64:
> -#endif
>   #ifdef XZ_DEC_ARM
>   	case BCJ_ARM:
>   #endif
> diff --git a/lib/xz/xz_private.h b/lib/xz/xz_private.h
> index 8409784b1639..6775078f3cce 100644
> --- a/lib/xz/xz_private.h
> +++ b/lib/xz/xz_private.h
> @@ -24,9 +24,6 @@
>   #		ifdef CONFIG_XZ_DEC_POWERPC
>   #			define XZ_DEC_POWERPC
>   #		endif
> -#		ifdef CONFIG_XZ_DEC_IA64
> -#			define XZ_DEC_IA64
> -#		endif
>   #		ifdef CONFIG_XZ_DEC_ARM
>   #			define XZ_DEC_ARM
>   #		endif
> @@ -103,7 +100,6 @@
>    */
>   #ifndef XZ_DEC_BCJ
>   #	if defined(XZ_DEC_X86) || defined(XZ_DEC_POWERPC) \
> -			|| defined(XZ_DEC_IA64) \
>   			|| defined(XZ_DEC_ARM) || defined(XZ_DEC_ARMTHUMB) \
>   			|| defined(XZ_DEC_SPARC) || defined(XZ_DEC_ARM64) \
>   			|| defined(XZ_DEC_RISCV)

Looks good.

Reviewed-by: Khalid Aziz <khalid@kernel.org>

--
Khalid

