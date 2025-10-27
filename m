Return-Path: <linux-kernel+bounces-870843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E9CC0BD1D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A062189FE9A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1DD2D63EF;
	Mon, 27 Oct 2025 05:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvM0PHbF"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFBE2D5C83
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761542877; cv=none; b=ZFBb8OT6w7CsFIjVKUZ2rlRRSl5datUbt7xQ18w379D3AVsP/VsX2SR3jCoFwCac8piv0L5GjlCMD63blfVW8w86op1KKbfKq8LnYuaMATIGN8nc4nUhz/ad512lmeK36Ivj4OZxwOer3zBWpHSr54Aof4Sq0Fv0CmUBtiCu6wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761542877; c=relaxed/simple;
	bh=inJww/Ob/vbUK/5lqAm9xN5xYDYWYeHnIJvj2WLxyEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTwYZVgp4OkkEVNuA0I+/JQKWgyxfnUEtRye5FxDPf1unAL554Gc5LM8VtygFDn3ZEIBkWaluSFmVJ6qGAFeoYZWLHo8jntdFLmGHAH21sY4eUd32iYSjJV3nejIgcuY/WfGPlfSS0lDnS7Yl56Cqt9zjYQLiAJHoBLJQ1MQWTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvM0PHbF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a27c67cdc4so3063012b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 22:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761542875; x=1762147675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/RAYqHmH1h4sjp1gNfQ9pppA/esaFm9GV+1pQeVlcQ=;
        b=DvM0PHbFMTjqnUsL8+H1k6xdPpEpf3qrCeZCus9XI+2Erew75ylAmIQPL+R7WNiwtk
         o19eqXvJ4j0clrSeLSrgxMHq/IRk6XVLRoCh9XCZ22WrGNH/e++6Xaj4xxp3d2SIiju1
         0r/5v47b/RGVJaVk3yT12nDFS3ODFIAEoTxBHY9tn/YHsGdfoYGdxsVVdo1R3JaqrnFH
         QcRgADRi9NogflcD10uKq2mx+zIgpISFaj5EsoSdrBr1swa9gE0Z2JvoguyvDch6q0w0
         7Kyjsx/Rpx6prYhl+oEnKVkCPc+XVnI7gs9y7rMXT2o0PlXFPvfIaDACbjOBTgaw4RYh
         HzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761542875; x=1762147675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/RAYqHmH1h4sjp1gNfQ9pppA/esaFm9GV+1pQeVlcQ=;
        b=FCCXeO20yLX+VyfBZkzZy4JYPdLg4BZMoFvWhHbts9Yf2lGZpeOHVvRnDR8CZbPiJ+
         0EvTD3LLsqQftt9abRX6wWJL5cHkjOkkG+YXX63zRcp5SV3ZRQqC0yX3xq4nuA7jP/N3
         IedDMw9UAb21LtSN/q6AfnU1FDZQcjroJwZ+h3TJ2uaJLSbIRkLDMDL+07upeI3piKTt
         tetRStbzbnmmncIpfpPeUKSGWO8FLFVl8g6jk2HivyZhxBirKAAqCG+nIIQOvGm+sO6a
         ujEKxxJDYzYVOlId4tqDKhSX486OfBTB/oVVbyyyCJw4DlRBaQczoyk6KTlj99sIZMlE
         hlRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa4uu6JE9y+TcmYWgRLjTYo7Dk988y5W83CvsMTC3XiWBTvNEvUCvLs1NEhYpCAbsI3NqlDKJouopLg2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKDXIStL0RNYZQbdBECfOT1UA0E8fm4zKlW0x9HRLDa1rdexlu
	SJjTK2yHZZfQ7MP6NH6+bxze+LvRnxKxkS8E09L3W63jyEl7XE+d4dDM
X-Gm-Gg: ASbGncudtQL9ecUvsxm8B9qCAZYmN7zxkk5TFeGT3jRWkz6xSg1t9EvCXfDkp71A761
	4wdMHSUGraLp7EcHMdcPDRHku+V5JX8al7dkA+xZeBkssC54vdPvZoyrJOswhJAHZajUQanD8OT
	AFKk5jrDjBXNi5JCerLpV4cIZ5px1mbGK0jSHqag0iB0TNS0kr6K5nQJQ8XPBxgwOnHwpGC3zfQ
	gMqpX+o31qqp3wDeCX/q8l5a1bZFda3b+uN6h5ragiaTCd9cxxUSTvI1/sLQgiqPYsqyf7I1gMz
	Qr6OUvo24V1R/9iImRLLikWj/lyXFX8WoM5N2KD9kPc4HeNnaI8FytnVTRP9M/twCLu+h/CspJ7
	p+f/7+yUs6MVmweN3Ff2PfrQnH89GrS2+2EVLUbig7rISR1vHggcoKgSPWvFzjMVJ8b8hdFHcoo
	39FaVWMOWTryAvxDwDMH1brPariHnUwys=
X-Google-Smtp-Source: AGHT+IEMUesQIHcuQu4FxPZyWoemXbk+ksDyGhqzHexxaBE/vxFXq0kjagvpHbM0Q/C8rA9lLvDSWQ==
X-Received: by 2002:a05:6a00:27a0:b0:7a2:7f87:7ae7 with SMTP id d2e1a72fcca58-7a27f877cdfmr12402808b3a.19.1761542875391;
        Sun, 26 Oct 2025 22:27:55 -0700 (PDT)
Received: from [10.0.2.15] ([14.98.178.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414072487sm6601511b3a.52.2025.10.26.22.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 22:27:55 -0700 (PDT)
Message-ID: <47844424-302b-4a99-9cce-82924c7b7ebb@gmail.com>
Date: Mon, 27 Oct 2025 10:57:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Makefile: Sort Documentation targets
 case-insensitively in make help
To: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com
References: <20251015012922.19467-1-bhanuseshukumar@gmail.com>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <20251015012922.19467-1-bhanuseshukumar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/10/25 06:59, Bhanu Seshu Kumar Valluri wrote:
> Avoid case-sensitive sorting when listing Documentation targets in make help.
> Previously, targets like PCI and RCU appeared ahead of others due to uppercase
> names.
> 
> Normalize casing during _SPHINXDIRS generation to ensure consistent and
> intuitive ordering.
> 
> Fixes: 965fc39f7393 ("Documentation: sort _SPHINXDIRS for 'make help'")
> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
> ---
>  Notes
>  - Patch is tested with make help command.
>  - Verified case-insensitive sorting.
> 
>  Documentation/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 3609cb86137b..00c81e7947a9 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -23,7 +23,7 @@ SPHINXOPTS    =
>  SPHINXDIRS    = .
>  DOCS_THEME    =
>  DOCS_CSS      =
> -_SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
> +_SPHINXDIRS   = $(shell printf "%s\n" $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)) | sort -f)
>  SPHINX_CONF   = conf.py
>  PAPER         =
>  BUILDDIR      = $(obj)/output
Hi,

I just wanted to check if you had a chance to review the patch or if any changes are needed from my side.

Regards,
Bhanu Seshu Kumar Valluri

