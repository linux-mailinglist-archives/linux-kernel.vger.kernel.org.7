Return-Path: <linux-kernel+bounces-894926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F29FC4C759
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69EA74E027F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2982737E8;
	Tue, 11 Nov 2025 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tqL0h8i4"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9653757EA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851048; cv=none; b=NUO0wcO4hD24oLpuw47+NDjYpGF7aqNKhMNt5YYXUx9cEERt8wQ1OGqHXuf0jmpkg5paQe+HSvLEldV7cNGtVgoGfEje0OB9csC1DLCYJYotpk33DSXQeC52Alhm6AGRtMZdabLHpWCWp46FjV2trEUPExkkR/94MR0PcxEgAEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851048; c=relaxed/simple;
	bh=8oJn+F4gp9gQnMSYljsNjq92hs5GdiNacc4G8cz3Ttc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgYWWm16ROn4WtJiM5sabQRVrMTJo6DhEV3bB7/RThucMKVoO7r8lyYyTlToflvt4Qh3FADt9Y33X8YivwGzv5H2nMwvWYetWnI2P0t+kFqRrChlJ6SqaOPKrngqV9Kin9yabJT1zUY8lPMr9Lxu3Gsu0Qko2f9PuRNbLnrHz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tqL0h8i4; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d71bcac45so36378977b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762851046; x=1763455846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y46zxO1C4o8WUqtj07jqBENmFGWJWEsozuquXurmpj0=;
        b=tqL0h8i47+3vNbr4bq5tJ31fevP/CsLBYDF8QPX//Iim+eY3KEoU8YJTl9vTjt3K2Y
         9yOa9dsob875C3OYFS5OtTtYC0tYuH+nubgloz4kdPpi/DyF6DGjR1hf9e06gz59Imfb
         mu9iYtvmxZw/iQJMHk7VPRwAByZgu9QaAvnVsUKVOjhRBBqJX9Xr8i5vSQ4ijibHYAIj
         +6CxyOC0e8OoZOLh487Nxno6ftvK9WIsQZzTwwgtP6kyPU5/kYAVm9UBM72YTbqq3hkZ
         wXNIqZtM5hxoiSzR6tbzbhcQyPkpfAEBgq2/aRXCghHjnMCnCDFCoBYFomxtGh+P+gWl
         kRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762851046; x=1763455846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y46zxO1C4o8WUqtj07jqBENmFGWJWEsozuquXurmpj0=;
        b=PtC5UdQ7ueDokAhuCdTTRNLZyrq2w1QvRBqkF8ANLBcMQYuNkm6vGodagm8+mdZX2B
         /va53u4TUGT/sBf2RBHGUTkOXaCN3nvMYqN7XEwqDQHcdGEJsEyF81pEJbdCyGNJ+w4E
         GyJLscBtli2chhNghYOzPCrUUq7aLCDrcxdbN/cuI9beUNwIUk/8GQmfXXU0NQLq8rx5
         IDL+1zKCDbTkKTOjw629zvt4bHvwUrqUP7nQdw/JQHlu99f9aGUzrZGWDTDSQwSWHRxV
         2XUXdGZfCWeXqihamUN1gXGdBxwOKDWlTIc6PrBearUezMRaZcvSeDnVuhySO/laERpH
         dzCA==
X-Gm-Message-State: AOJu0Yz5hP7KLTQZod405gNM7LXKfRnVgIG1ZFnXm3EEQNZMAEllRU8U
	TDz/rIhmhFajJ9iLJohpPnpGHubldNOyoA5t0G8elGYE9ydL/js/uoMrtBApUCoEjGeww6GSSwX
	vLkYGsZvjIowMvE/ir9yMupBn4cBF1nj9F5iJuSowrg==
X-Gm-Gg: ASbGnctbRpeTfnInYBZ4j7JsUtSJ1zjyAnrq6WviGqyGzzj3EKBHumXMCsRvECn6jEg
	0vuR6eFxT5yMhADdnyIznjRNG3gEr8g9xv6Wj8i5NQSlzR6cePt0LnfRXoMPlV1wkgvIpnZum7X
	6WR35USnyL9TVHxbdl3bPvJnN3w+zxNO40Wk98RBMLGVnjD8c9moR6YHFFqwFOKyjd/+a0ggxPp
	9+foYRHe1dFVjIeT1S7GcsMe0xyVgVjE6s4CYWhU05GnTNENpAxNtHvPh73hf3of+TPlRpMmACC
	mfEqhAdMf1POqQoRrFz3C+gBwq9faPwWy/LMIyWj
X-Google-Smtp-Source: AGHT+IFW04NMmm/DmGXKuNoocNXOW1P5E9RSrXkBfL6e/iKOHrJptvsyGLLUH1wJ5OdOEoN0Uvp2X+BW0+RpDBRk76Y=
X-Received: by 2002:a05:690c:688b:b0:788:c74:d038 with SMTP id
 00721157ae682-7880c74da71mr3427737b3.39.1762851045790; Tue, 11 Nov 2025
 00:50:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111060212.1963608-1-rdunlap@infradead.org>
In-Reply-To: <20251111060212.1963608-1-rdunlap@infradead.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Nov 2025 10:50:09 +0200
X-Gm-Features: AWmQ_bl9LggH2BnIOi8b_6HMwtRDi2PxmqidNChtL-tYmJN-Isc3DYSw2FH9LTs
Message-ID: <CAC_iWjKYBgjG=C7NgAFwn6uBSMS0t_WepazvcTQb-gPewL9ckw@mail.gmail.com>
Subject: Re: [PATCH] efi: stmm: fix kernel-doc "bad line" warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"

Hi Randy

On Tue, 11 Nov 2025 at 08:02, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Add a beginning " *" to each line to avoid kernel-doc warnings:
>
> Warning: drivers/firmware/efi/stmm/mm_communication.h:34 bad line:
> Warning: drivers/firmware/efi/stmm/mm_communication.h:113 bad line:
> Warning: drivers/firmware/efi/stmm/mm_communication.h:130 bad line:
>
> Fixes: c44b6be62e8d ("efi: Add tee-based EFI variable driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Is the fixes tag necessary here?
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks
/Ilias
> ---
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> ---
>  drivers/firmware/efi/stmm/mm_communication.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- linux-next-20251107.orig/drivers/firmware/efi/stmm/mm_communication.h
> +++ linux-next-20251107/drivers/firmware/efi/stmm/mm_communication.h
> @@ -32,7 +32,7 @@
>
>  /**
>   * struct efi_mm_communicate_header - Header used for SMM variable communication
> -
> + *
>   * @header_guid:  header use for disambiguation of content
>   * @message_len:  length of the message. Does not include the size of the
>   *                header
> @@ -111,7 +111,7 @@ struct efi_mm_communicate_header {
>
>  /**
>   * struct smm_variable_communicate_header - Used for SMM variable communication
> -
> + *
>   * @function:     function to call in Smm.
>   * @ret_status:   return status
>   * @data:         payload
> @@ -128,7 +128,7 @@ struct smm_variable_communicate_header {
>  /**
>   * struct smm_variable_access - Used to communicate with StMM by
>   *                              SetVariable and GetVariable.
> -
> + *
>   * @guid:         vendor GUID
>   * @data_size:    size of EFI variable data
>   * @name_size:    size of EFI name
>

