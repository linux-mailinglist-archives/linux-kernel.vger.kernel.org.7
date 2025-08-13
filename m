Return-Path: <linux-kernel+bounces-766821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A764B24B93
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71FE3B6510
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715E32EBB95;
	Wed, 13 Aug 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="hX1tM0qX"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E31E2E611F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093651; cv=none; b=iTiIKkHfYqrOeRpAvxppDboXtHxkQV901vuZ2ygJIMrRVbq83pf5uRolPc1RivK9+2LaPvBkgEJOweUhfgaZCOqbig9P3UaPHv8AMJA5lWa6R4iZlyR7L7Fm9wTK6lW2s0UY2MZBQ1Z1A+8ftvW/k6sRie5FWzc3U4saGO9ihj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093651; c=relaxed/simple;
	bh=UsGW5uN88QfodskVKu0bk/zEoPGB6z7yLng9J3kJqoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRx2+89uq+VPGYR6gSSYBdEHul1d4sYs1pq4DqFsLtvvgHmcrFKeAzjDa5LEYuiFySpK6tWng68gPtgCSdsZsgyMEedVAkFF3n5HTMlodLrIvGDoKhXFpYFtZ41ygMoekmq6VkzJaKt0hCg30Czg8RSLgN1d8jSGTPYlenhZJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=hX1tM0qX; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b07d777d5bso74375561cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755093649; x=1755698449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lc31v2yJfn5lC70LsWzHpGyS8F15AJd43KPnoZNTig0=;
        b=hX1tM0qX1hpfCCM0ATyINtwaAKyg9z8ABBa1fyJQNUPuBTDUYVEbWTKjA4rwf2bji/
         elvxo47HWeTZOH+HoEjfOMDVfNhe1C4Am+3HnpAQp+7DcI4tD+2o8+Nc5lTuMY9bPeyR
         pdSleUu2Y3/zgYNClEQfKG1ZKlU1QnKne5FTrwk+GzqFES7j4XX484g/XVzOO3Rz2Vyl
         VAGwkfezdSaFmaFimZVAK0iEEF6vpLlEbNKfHjUQY3xQmkI18cjdfwZ2Ou7oJ55GZJYk
         bv/C7N8h1BCFxAxZiHvtvBOgcFwZk1Zl1FYe80QobZY8GzF9kELr6s+xn/fsO4jaYgAs
         waQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755093649; x=1755698449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lc31v2yJfn5lC70LsWzHpGyS8F15AJd43KPnoZNTig0=;
        b=hW+qO15n6RfetG6pv1lqNFF+VbCd0ziuhlpKzLI2H/KZm0fpu1nDHqHbMUDcGwgUM1
         GKKCv8TRmm4vY42eTihLoTSnV6aoQTNeJGRIxznLAGPy0J/4Ao8kUHcccChJxRuvS0F0
         k94ZchqBaxeRv7FG/0xVsEI0eh/5ANVWnX16drhDHdNR48FGTsxSNPqc/PAkG4tSeOZO
         i50L5MeywkmiPg9AFEsMFuNn3n9OyIqBI1wlXIe0cicuV5FNP98rzt3r7mBC532q334g
         kPDWzS7GU5BzoT+clTwFPbQAwB/I1aPdsOwu+oCinrA5GtKZjx4/Y1tOJAxnjcsbtDIT
         3CJg==
X-Forwarded-Encrypted: i=1; AJvYcCXoRG/r3MMcRKTKIG0PrXGTOUSBERptoWCTJgUJfdGRY4XyssHDb+vdrB3azfaZVhiiPv/L44RTDQMLK9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3oMIa4dIY4fAaMbNpJKRNxjwmFSyq6ncjahoSydmrg3qneb0V
	oPw7emvuKvybJK4tfyNS316z5+b/9Fihbap+xR11Phm1B9xJ6fOTyWg95VoZE2oSpQ==
X-Gm-Gg: ASbGncuO5FTFLJFAAqYsa281yOEsd+efy7FTfdniiqGDfMiNyTHlMgDh7ybSzL0N8yn
	3qTDMKzY5SIR48fdWfc227NPJ3XmUAio9cY4+1ytB3mvvPnAjaDuujMTDYOrOPcj9OCFmxu4jrk
	GamQjFjSFa5KBWvu1JrKnVoXa4uzna9K2PAAlKw/HNcQkOhxffzquIWyzuLK/oBGl3Ty42HYNzx
	fdH2zSl+7uo5Yy0HkoApP0kSB3WfmbG9hwNYksardsGPFqxfYpEvBRPaaAZ3+9P7V+NGtSaYBfZ
	FfpE+DoauO0yh8sW6/FybLs10+n6rfQROLEZSUUxmYZbiF7slTJsfbt7sygKoavKiUO2Iepan5r
	qs7tDKScyd7X5cH+1pwLCPxZGkU3CQ1+anC+RW7Js
X-Google-Smtp-Source: AGHT+IEfhlGUyZwjmFmc8w/5qnUy1OjJjl63ruLaNjye3n5HyB1AIXAaAwqg8IppikZVDelkkPlPTA==
X-Received: by 2002:a05:622a:4818:b0:4b0:be3b:d40 with SMTP id d75a77b69052e-4b0fc86fa65mr41526931cf.40.1755093648934;
        Wed, 13 Aug 2025 07:00:48 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b1080bbf35sm933301cf.15.2025.08.13.07.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 07:00:48 -0700 (PDT)
Date: Wed, 13 Aug 2025 10:00:46 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	wwang <wei_wang@realsil.com.cn>, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: storage: realtek_cr: Use correct byte order for
 bcs->Residue
Message-ID: <5c190936-7c9a-4577-87c2-f79975725787@rowland.harvard.edu>
References: <20250813101249.158270-2-thorsten.blum@linux.dev>
 <20250813101249.158270-6-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813101249.158270-6-thorsten.blum@linux.dev>

On Wed, Aug 13, 2025 at 12:12:51PM +0200, Thorsten Blum wrote:
> Since 'bcs->Residue' has the data type '__le32', we must convert it to
> the correct byte order of the CPU using this driver when assigning it to
> the local variable 'residue'.
> 
> Cc: stable@vger.kernel.org
> Fixes: 50a6cb932d5c ("USB: usb_storage: add ums-realtek driver")
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/usb/storage/realtek_cr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
> index 8a4d7c0f2662..758258a569a6 100644
> --- a/drivers/usb/storage/realtek_cr.c
> +++ b/drivers/usb/storage/realtek_cr.c
> @@ -253,7 +253,7 @@ static int rts51x_bulk_transport(struct us_data *us, u8 lun,
>  		return USB_STOR_TRANSPORT_ERROR;
>  	}
>  
> -	residue = bcs->Residue;
> +	residue = le32_to_cpu(bcs->Residue);
>  	if (bcs->Tag != us->tag)
>  		return USB_STOR_TRANSPORT_ERROR;
>  

Acked-by: Alan Stern <stern@rowland.harvard.edu>

