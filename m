Return-Path: <linux-kernel+bounces-766819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90223B24B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA2388558E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B882ED14F;
	Wed, 13 Aug 2025 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="raUqL9dK"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CB12EAB9D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093551; cv=none; b=sWBR2AXWsfAI2b49mHmgNZIqegxQluCWyp+aOB+985vCZe59hIVN9x+gDy2/pljGvzAP5PqOmT2Y1aU1e/oIRszf8XQrn57+XeejOqucUXKWdBMzqCnRI+DlmI1j8BapHoA13KO1a0QKrD96IVRDvl/908SAKY4L//WcdRDHgIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093551; c=relaxed/simple;
	bh=UyArUCBuEEvIlRYadHqWiP7PFZhXMSulHrQ4/NqC21g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdXvBWMilR3LQmcTJRxcs+qlYPvnHzOWVxvzs6jupo+oKUPRlGO1TrhuZWkB8UXRSVD/huHvub+2D+787HzzkIQd7nSzKUc07xsSQ1z2i8gmFqJx+O5hn36RKvdDl4Q2LKjY6paoPQYjwRrlMTcaf+4BtTTqRBXBqwS93GFFO9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=raUqL9dK; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4af12ba9800so76761241cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755093549; x=1755698349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0B5+KCwTYeMl+r7+gOvY6gHETkIvCqXubWBUjPQk9aQ=;
        b=raUqL9dKs9BKd8h0G+8u07sFAXtUu19sSJ+UA0xYZowIJ32NkW0S6fqvQEYGi6gwtX
         C07OhuD0HvSyksOS/dgTFupGU7gG+6IltVtiFQY84Oiggik5Z4Ek8NLka0PkdmOXbO36
         K0x4GOo0GYl8jcH18vBFUwrsfcwxh9AbQtM1t+/tpkGcSHcStD3Ct1KeJE4hLp9tZzOa
         9xURkMgHgW++7yUR13blLVeYVkzKyfnTBEni++3oLlgLTrlr/ExSyXXO0LjLqtSEri60
         gGgaaSLofXzXvZeLR4xbGWo7wZFxyNn+bK4hL6UW2hSbSQStH4QJboVDL9e/EuswerDF
         QZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755093549; x=1755698349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0B5+KCwTYeMl+r7+gOvY6gHETkIvCqXubWBUjPQk9aQ=;
        b=H8nHNmUPHqCh0rlphZ6IPUvTnLvRHuV/8gfu6FTyezhDKwcH8J0/iF5S6dbOpi458e
         1790cOX3rMvYxpzJ/NasItoZ3o2Q9LnfLBlT22LJXX99fwP1il1V7EgQ1bMy8oZ7p/QA
         Lxb34XsvCIz+35VGbnqkXfieil6hMLDAlIIFhS9XBRzXYtYgjeNtNfYByacJHil8K+o8
         SQNwPZQl2/pv/XXoUrYLssChV4vxhTG7AlXcvwC6tBBQMvyCDmeAOullKMiE2Hc9RErD
         pzbHL4cnLpGEMywnwPEtjbuFb6QigjiQDEcphIYKmryOngmhF+6vVMuA6kKvntvU9Pa3
         Fh+g==
X-Forwarded-Encrypted: i=1; AJvYcCWKljwqVjGkmBpKbkl58/uE2poiRx5ZXMIehyxBL008LE3VVr7puNmJGxz1YbpMAruIA/H4BPRcsaD1a7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ksTtJutcluVvimy+v43UkAFW43a2z9coFSdEL94JSkKKhF1c
	LXqz1+cQMDOX4djW7XkVBC7URyxfg5tbW4OcJOzazhDHirf6sG3isyEpbumveKAUUg==
X-Gm-Gg: ASbGncsIhlUdGom8+wrRf84HeFEX46ay+9SJJBKa1D1JuVeG84/CQVTfrcPAxfP6Aau
	2MWK251HA8uioVh4t/sSRUTfZIb4+pJz7yOoZsb71mdy58E2cqc3331ikTEtIoPU0cVnPwq28Jp
	k0S/a8cgDwODbHhMdhoI7UVQ42pRfBdFMG/77BhYo3KxCUs5dIcvlRStsousxDqyHPlxf35pWli
	LgOZCHuPgqqP8kBQmktB+tfBXjd6zVq50iZ6vJqyMJ2LWtzMv2+TSXJOun3Aa4ocSbQhRdG38oU
	45ZJFEBfW5PYfKwWqnhIZxvK0ta9AprThdEC906JNv8pUUsmzIgO2AAEpSGfR26+eP6isPdSrTZ
	L8J89yHShCHYDy9pNpz/BbETx2tLNPzkLRsWpWT2M
X-Google-Smtp-Source: AGHT+IHZODkc4jzSWrqtqZtNxnDMwJERZ/GvfOq+a9y3R1/suPMIsQbPisFwEAObfdCNGLSA18i/vg==
X-Received: by 2002:a05:622a:4107:b0:4b0:6703:db95 with SMTP id d75a77b69052e-4b0fc687c82mr34072551cf.9.1755093548792;
        Wed, 13 Aug 2025 06:59:08 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0a41a2ab2sm95720401cf.18.2025.08.13.06.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:59:08 -0700 (PDT)
Date: Wed, 13 Aug 2025 09:59:05 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: Re: [usb-storage] [PATCH 1/3] usb: storage: realtek_cr: Improve
 function parameter data types
Message-ID: <a6deb8d0-dc8e-4d4a-94d2-ed2617091eef@rowland.harvard.edu>
References: <20250813101249.158270-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813101249.158270-2-thorsten.blum@linux.dev>

On Wed, Aug 13, 2025 at 12:12:47PM +0200, Thorsten Blum wrote:
> In rts51x_bulk_transport() and rts51x_read_status(), change the function
> parameters 'buf_len' and 'len' from 'int' to 'unsigned int' because
> their values cannot be negative.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/usb/storage/realtek_cr.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
> index 7dea28c2b8ee..d2c3e3a39693 100644
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
> @@ -417,7 +418,7 @@ static int rts51x_write_mem(struct us_data *us, u16 addr, u8 *data, u16 len)
>  }
>  
>  static int rts51x_read_status(struct us_data *us,
> -			      u8 lun, u8 *status, int len, int *actlen)
> +			      u8 lun, u8 *status, unsigned int len, int *actlen)
>  {
>  	int retval;
>  	u8 cmnd[12] = { 0 };

I just looked through the original source file.  What about 
rts51x_bulk_transport_special()?  Shouldn't its buf_len parameter also 
be unsigned?

For that matter, what about cmd_len in both routines?

And have you checked the corresponding values in all the other 
usb-storage subdrivers?

As you can see, worrying about the difference between signed and 
unsigned values, when it doesn't really matter, quickly leads to a 
morass.

Alan Stern

