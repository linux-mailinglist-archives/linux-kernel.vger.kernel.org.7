Return-Path: <linux-kernel+bounces-765547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA9DB239C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FA71BC0793
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EAA1FAC34;
	Tue, 12 Aug 2025 20:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="ONN9quwT"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045EA2F0666
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755029201; cv=none; b=qe/KgJu8lpBa+f7JKf9saW2xXjWmeyAVkDqPW03oy3RsVdAYw/cPa/RLwFc3GsL/5M42eEwdmWberXqgG664nb/HJW3MbPtrtImsZe6GvavrtwhmQgu4BS97L7k45Ha33GsYZCkW6AZffkRy3A3Ye2M5+qU4Y+6rrIIDEowfdTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755029201; c=relaxed/simple;
	bh=i8HY5u63XJP2plaosaDKuXc1itBLuDy+0U6FlcOWZ20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrZTeuFt94wZlhMNIL300nvlmcgxQE/b4QDgdB2lEhJRgnj7/UVhrZjvA5g8xUmAOBWIlOTAi8cHOj0fWULc5FChAsMWTlFXd+bUgX0SDs2d13qPwgKtP9E0qUxRk2wXbug16RD0t7Da46JoW9U2LQ3ahRuHQZM/ok/KBgAd7F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=ONN9quwT; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b0a0870791so80780221cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755029199; x=1755633999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eqkiQnb+v+DV7bwshJvcuqOvg6eI6sY8lksQaVEmngk=;
        b=ONN9quwT/wFuQ9Fihb4ymxfK5Qn+8rULdZmdvb12CWxefvol6wTSVidKp9x70Gaaqi
         0C/a6pC12WK2TGCFTNq62g6HcpjuedYAMRso+yGxyab2UlKJaVgxkwBRIl0m1siSo93H
         T70DKdE0qCimZ5GffpKDvKQze13IXoZfjYeMHDtJLa963v/6Pmjl1MwHuSXZCUj9IjNu
         nLUAnVwbyndewRH7M693cA+Jsfwm/aJVQU9j768uB5YqloVeHA+NKqHznZ1V1VzXHd0Z
         VWL79B0ipIYtTJLIJgwIUWWN/uUQaWpjeiRGwCYaHxnZwHuW3bLDQttYRKh9bHVMmr6p
         KVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755029199; x=1755633999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqkiQnb+v+DV7bwshJvcuqOvg6eI6sY8lksQaVEmngk=;
        b=JHkEh/Ixbakb/uhazE8R7+yAg+upU0mXhuK0nz1G4UiNlGHU1xnShPSOtzpoFM/a8x
         YQEveSl7SwJ9eM8YRLULpDQvbpQU0ztC2zPOdhveDSmta543AwLhKFC5mqcU3+SPCQbe
         Ztr4j7jWZyZ7coedgubccdgp5Jgs/XW20riyX8FdLk82SvDoMs9jjoOaEq8Mgr18F8dW
         Dvs6l630bhxDuUUqSW7lWjUkwykjyrdmNX9gBnthDJaMLgnMOC36JdUoAOXSZVQrqdDV
         9MzivYR2J7ikaR01A01lz8DQRolrldVJScY6O5LZzGMxSNGgLRjCiddwr+jDq2LQ8wBE
         XWuw==
X-Forwarded-Encrypted: i=1; AJvYcCUxYemTYTDatbqwyMnInSKkRNio6VJN7xQm+OACJVGn4hpmboAF4WHFumpZvc2IEqzgnsOtopc7dxhTT1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPrn1PmAxt8eGUxcEx+k/5YeuePXeWx+d6dB+k/w6UEjKwY19C
	8V+4XEJrHmzNQLbdOltCRULg2sH6aawN9lQ6s1kq+u3X0doCeV9ImGaypkHnuq6m9A==
X-Gm-Gg: ASbGncuYWrE8bQh31cExeq+7DyQABaWzWmcd/wsTQB3JRXlxGwzaPkfDV8dOudgv11O
	UV9XEndQMYtGharXEpJ+Hn+xVIX6+QCiv/RoHk6ugMlNWvFRLpFPytdGKFNT6Q1fZ7+Cb6PZ53h
	QXSMj6DHiONTN9S1NlnJVqLHTz+WcYunj3madO3Mz7moiPPb3VQKRKrRoW2PgGmT3/OEDgGd6O9
	WJiCl07RB1EZevb2Ls/mGF1FEMQWR0VsCHbzYL4Q1KRVO9lIGJdxgtGH4rGzFJcfqGZ+kFqQ3By
	w/yrCJ6KjycH8tuwGSGOE9Z+n5INPRbPvn6lQrZc7+yUYCWGBD60PQvtSPnvNmV/sERSgyLdFu4
	StyJRmWLd8GGFNn5I32i61v4=
X-Google-Smtp-Source: AGHT+IGGZlvv17fMp2WDnfMMFShmDsTlMM6IcnzKcbMc/Ggu/R7+9qwyKK0VohswEqNLATbAFPlTWg==
X-Received: by 2002:a05:6214:29e6:b0:707:51a6:184f with SMTP id 6a1803df08f44-709e89fd871mr5029606d6.48.1755029198601;
        Tue, 12 Aug 2025 13:06:38 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::e316])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca363fesm179978606d6.31.2025.08.12.13.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 13:06:38 -0700 (PDT)
Date: Tue, 12 Aug 2025 16:06:35 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: storage: realtek_cr: Simplify
 rts51x_bulk_transport()
Message-ID: <b11a19b6-9fb3-4fdc-b94e-33ff01a634b3@rowland.harvard.edu>
References: <20250812144358.122154-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812144358.122154-1-thorsten.blum@linux.dev>

On Tue, Aug 12, 2025 at 04:43:58PM +0200, Thorsten Blum wrote:
> Change the function parameter 'buf_len' from 'int' to 'unsigned int' and
> only update the local variable 'residue' if needed.
> 
> Update the rts51x_read_status() function signature accordingly.

That last part isn't really necessary, is it?  It doesn't make the code 
any clearer, less buggy, or quicker to execute.

> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/usb/storage/realtek_cr.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
> index 7dea28c2b8ee..8a4d7c0f2662 100644
> --- a/drivers/usb/storage/realtek_cr.c
> +++ b/drivers/usb/storage/realtek_cr.c
> @@ -199,7 +199,8 @@ static const struct us_unusual_dev realtek_cr_unusual_dev_list[] = {
>  #undef UNUSUAL_DEV
>  
>  static int rts51x_bulk_transport(struct us_data *us, u8 lun,
> -				 u8 *cmd, int cmd_len, u8 *buf, int buf_len,
> +				 u8 *cmd, int cmd_len, u8 *buf,
> +				 unsigned int buf_len,
>  				 enum dma_data_direction dir, int *act_len)
>  {
>  	struct bulk_cb_wrap *bcb = (struct bulk_cb_wrap *)us->iobuf;
> @@ -260,8 +261,8 @@ static int rts51x_bulk_transport(struct us_data *us, u8 lun,
>  	 * try to compute the actual residue, based on how much data
>  	 * was really transferred and what the device tells us
>  	 */
> -	if (residue)
> -		residue = residue < buf_len ? residue : buf_len;
> +	if (residue > buf_len)
> +		residue = buf_len;

This really has nothing at all to do with whether buf_len is a signed 
quantity -- it should never be negative.  (And I have no idea why the 
original code includes that test for residue being nonzero.)

Much more serious is something you didn't change: Just above these lines 
it says:

	residue = bcs->Residue;

It should say:

	residue = le32_to_cpu(bcs->Residue);

Alan Stern

