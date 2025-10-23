Return-Path: <linux-kernel+bounces-866406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A640BFFAB9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F23189D070
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F412BF011;
	Thu, 23 Oct 2025 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bAcNQcjM"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDC728489B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761205416; cv=none; b=teTTlcGiJHlsC3EpEOgiIXp8+oCw92qQSQolin2itk7ZZbE2Y2F2ojcXlMmKC6nVOZTuNkfaCreA+xrjnplYeB0Bmwwiwc5jnlAjp1OChepn9DedYchsDMmECY351/VQPsMKw+vUUI1SuJpJJ+0X/71TywOKlTS2MCjZvjFuz78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761205416; c=relaxed/simple;
	bh=cn8khU1wdF6XCG3ct9I46ZQE3ibIrw+IuNrKzmLvA14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIxdVzg1xNDa6p8KBrEXWK44fP3FeMM3nx1rGDvqoWh1a0GiR7PDyEIKiCLRDn5AdNvU2INeqh+IHVkxD3HtmaehV8lvdsuNZaKytbEflmvKGl7GXQI9sdz/ZS2t4tMPaXnZfIIXAOPTICL7otA18gHFuJspqemQGdahQ+WuFKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bAcNQcjM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so110038066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761205412; x=1761810212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OnSo7UV2l+foi4Xmv3GwoRrN7FNUDfia8DEbde1ITA=;
        b=bAcNQcjMtZahcV31NqZ+nvaEtHiLGASYNpaJdFs9S+62/wFO3U1fDcVZc8jEZ9WNZt
         55cGIfy6M5H7cITlWg0la9oB6vIFbXSTMq49bolAVcl3DPKM9wvQu4uxgrWZ7LMi5sbh
         Im85XRkCq0fcm2AIjs0lajh4plJYHJm0rywV8MDfLYHCO4ThKffJL1jEuwg6D4q88mU9
         FHC6iHp356qWhbt8DWs/69k8mhW0dzU4wxLJH/alfqyW04xe/GGXZ0to2wEPEHSd31kQ
         SNadBklDYbjBVk5SCvpoDib15dw4NSRtSkkhHwqdpR22m+foxn6f70U99U2SwqK16e2K
         u7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761205412; x=1761810212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OnSo7UV2l+foi4Xmv3GwoRrN7FNUDfia8DEbde1ITA=;
        b=Buk/fenUooBFGH5WpirI90xPfMV2Hpg8MvV2MOg7TBKeLphaBHYAvoOVoEdwsKgVI1
         PzfLX0m47x2FFJLpTycBsyAamiwS9tCc7wWiyYhe8/OqwYrEmZzHfekffPhvM0aXLkAv
         tmkV+xVbEOiZUjEXh5Vbk8mykDbM11CCvxbESBT54TNV9E+p1Vc7EbBExvEd8CndeSxr
         1afcAXIqqmhlejHV9x4qEdJBWX3m7KPpYzc0J4hEXlqO9a7IjIXXLH46e9R00FJOHg39
         NiLt3WChB9Ij/kL7ddC9yrdOeqndBH+TxkVd5Ns5DBT0eL7wx0ZgmQXINgwwqZFYIx4H
         wxlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTSrnw0PQ9Bby3kiKC7X/n9YA/zQ5RZREkgnfd6QIJVoETCY6NfzA/QDMXxIquM/BIM3iy6/39h7su4As=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVvoqvcQaxZGVmhzrT2SAEF92lWXj4YhewbvvjOb2jFDS32fjo
	4n9aQCvdQmfRWKmHrA/o1nChAUyNViQt5o3CDVo8lWKEN6+uxJBuauQXzXfAAaitbkE=
X-Gm-Gg: ASbGncvbJ2AerURB4OsukkfE0K3/nnK3EpcHA+ylZPwzOWYouhSAu2tlPlyBjWqKE/E
	eFa+82cjevJYkVuYaPChIbLD+OaF8dq1dpfVtMiO4553enX7pBKPtCw9LHkWbriRs+I+92s4c52
	tMCA/VHzjj9dKq4/1ZcbvKyJYsjcUy6rH/J4mmFUCOgOl94MtIHnHf7QNcv98OpsOUlshqvSUDd
	ewRuIw60krfME5tEJf7hD9vzwbrmPEWMHCxqTEIV/lQUoMUfRUGoEGSUCsxkjfghOOlseQDGyU6
	3HLYg1ZbT0UuEY37b5CQVUsQtYYUviYiYilGF3+WTWONqkei7wH0td02eC5WAsm96Cs6rDbP6Lc
	AOKzoKcymNaQe0OGoSp5nkGQFpkcYNxIvStHbztpebTJBgWI87RRKfTG7i+/CPydhGDy82+N76I
	upxT3g0tyrr65vAKEgW28=
X-Google-Smtp-Source: AGHT+IE5Qln5QMXf50BzGX05VUxXjWArqf9f8lHP9J/SmMxbxc4eUgX8ErRxaOS+BtwFntzXMtiV0A==
X-Received: by 2002:a17:906:f5a1:b0:b57:2d81:41f with SMTP id a640c23a62f3a-b6474b3602bmr2991259466b.40.1761205412324;
        Thu, 23 Oct 2025 00:43:32 -0700 (PDT)
Received: from [10.11.12.107] ([79.115.63.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5130cbdasm140513266b.14.2025.10.23.00.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 00:43:31 -0700 (PDT)
Message-ID: <b8338932-de87-4328-9d33-d4a8268fb03d@linaro.org>
Date: Thu, 23 Oct 2025 08:43:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mtd: spi-nor: spansion: SMPT fixups for S25FS-S
To: Takahiro Kuwano <tkuw584924@gmail.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <20251022-s25fs-s-smpt-fixup-v1-0-ce26d4084b2d@infineon.com>
 <20251022-s25fs-s-smpt-fixup-v1-3-ce26d4084b2d@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251022-s25fs-s-smpt-fixup-v1-3-ce26d4084b2d@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/22/25 11:07 AM, Takahiro Kuwano wrote:
> S25FS-S family supports SMPT that helps to detect sector layout settings
> in configuration registers, but some of parameters in the table are
> wrong or undetermined so the fixups below are required.
> 
> Read Any Register op is used to read configuration registers that
> related to sector map. The op requires 8 cycles latency by default.
> Implement smpt_read_dummy() to set correct dummy cycles.
> 
> Map ID is structured by combination of CR3NV[3], CR1NV[2], and CR3NV[1].
> However, in S25FS512S, CR3NV[1] is RFU and always 0, while map IDs
> defined in the table assume it is always 1. Implement smpt_map_id() to
> fix map ID for S25FS512S. Other densities in S25FS-S family (256Mb and
> 128Mb) don't need this fix as CR3NV[1] in those chips is configurable
> and map IDs are correctly defined in SMPT.
> 
> Co-developed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---
>  drivers/mtd/spi-nor/spansion.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index a0296c871634678be509cb30d26e18debff3066d..89e85eba2c31a4d74dcbfeffdeff7139b6e0f6b1 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -785,8 +785,42 @@ s25fs_s_nor_post_bfpt_fixups(struct spi_nor *nor,
>  	return 0;
>  }
>  
> +static void s25fs_s_nor_smpt_read_dummy(const struct spi_nor *nor,
> +					u8 *read_dummy)
> +{
> +	/*
> +	 * The configuration detection dwords in S25FS-S SMPT has 65h as
> +	 * command instruction and 'variable' as configuration detection command
> +	 * latency. Set 8 dummy cycles as it is factory default for 65h (read
> +	 * any register) op.
> +	 */
> +	*read_dummy = 8;
> +}
> +
> +static void s25fs_s_nor_smpt_map_id_dummy(const struct spi_nor *nor, u8 *map_id)
> +{
> +	/*
> +	 * The S25FS512S chip datasheet rev.O Table 71 on page 153
> +	 * JEDEC Sector Map Parameter Dword-6 Config. Detect-3 does
> +	 * use CR3NV bit 1 to discern 64kiB/256kiB uniform sectors

you need to update the comment, there's no 64 Kib uniform sectors in
the flash, the comment is misleading. You have:
- Hybrid sector option
• Physical set of eight 4-KB sectors and one 224-KB sector at the top or bottom of address space with all
remaining sectors of 256-KB
- Uniform sector option
• Uniform 256-KB blocks> +	 * device configuration, however according to section 7.5.5.1
> +	 * Configuration Register 3 Non-volatile (CR3NV) page 61, the
> +	 * CR3NV bit 1 is RFU Reserved for Future Use, and is set to
> +	 * 0 on newly manufactured devices, which means 64kiB sectors.
here too> +	 * Since the device does not support 64kiB uniform sectors in
again> +	 * any configuration, parsing SMPT table cannot find a valid
> +	 * sector map entry and fails. Fix this up by setting SMPT

by overwriting the CR3NV[1] value to 1, as the table expects.


The patch looks good, with these minor things addressed. Please fix them
and add
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Thanks for taking care of this, Takahiro!
Cheers,
ta

> +	 * configuration index bit 0, which is populated exactly by
> +	 * the CR3NV bit 1 being 1.
> +	 */
> +	if (nor->params->size == SZ_64M)
> +		*map_id |= BIT(0);
> +}
> +
>  static const struct spi_nor_fixups s25fs_s_nor_fixups = {
>  	.post_bfpt = s25fs_s_nor_post_bfpt_fixups,
> +	.smpt_read_dummy = s25fs_s_nor_smpt_read_dummy,
> +	.smpt_map_id = s25fs_s_nor_smpt_map_id_dummy,
>  };
>  
>  static const struct flash_info spansion_nor_parts[] = {
> 


