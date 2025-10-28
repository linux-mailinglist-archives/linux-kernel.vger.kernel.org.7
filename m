Return-Path: <linux-kernel+bounces-874265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AE7C15E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 277574F207B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A68522173D;
	Tue, 28 Oct 2025 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="PB/ldTLC"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5325316188
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669535; cv=none; b=nFaA/X0faMiUJZtXaUAL+kV0TpC92iUN25pUKibTaawgQYpYEiyNCtx3SZaPkpX+LRdUouaGLFLlkFxd0e0BcSDo+3iItOpWkF2cyGNikvLd1H08OTnZd6n1OyvY85q7kNE0oRe9I/+TSlyXXpeQKIkzLDYM0zUIP3GH6Ztz+ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669535; c=relaxed/simple;
	bh=vyhmROQN7MnkqpkByX+OptwXuIIkUPsDYsUeiDzsYxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM8bCZ4CzUB/cQZiEDJjZLAKAkYStbQM7H8UvwpTcUNr/tR3dKWJCbawm6HDBUn/wJFDJ29d4zzArGCAmmEnriMOPbBwNTX5uImGXLFCeBQZU0Xl5/jp0e1Hh8yQ+YmGLWP9vAhYSZYuGq4cqzlJcnnUUNqNo0GfiS9NWkt4d6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=PB/ldTLC; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6a225b7e9eso4486689a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761669531; x=1762274331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BqDKbmFJDAKCoAXMXG6eFztAtsR6ukXq3V60BKqwXHg=;
        b=PB/ldTLCTkYYS98HnXloQ8Eqh/aWkr84s/egDGFMvZ5DHZa3JV9XehvhWp2ki8erfN
         xYWMu5l1SAmAKteMS3KF/0gWR98HKvbcQyrlOzZXJ3olH5XAjjO6/YXuJUsl41AqHT/I
         8VbAKc073Vw+cNDYeLREIOk5HG3VRVaipuf6BWblI2+XL6P1ZNa/Y20x2IGImQhRyRaS
         UPpJuUCvb5HuSa4SbGiZW50hdQyES+bMbvYJedgz1dvVswvWCbADmQ+xoKR2AuVD8epM
         oIS8EROujWZBFBubgpSArjN1di5ZuOKEueSLNaIhHUEB4Up2hEMErTL3ZpUzGlMdScue
         74GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761669531; x=1762274331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqDKbmFJDAKCoAXMXG6eFztAtsR6ukXq3V60BKqwXHg=;
        b=V6hyhyBfkll3LIwE7cPf5aUmH3NjIfC9xB3fYMALS6KZckC5E6oU3HxPO6HRnoXZq/
         sOeL8IDjyRkqbOx2MQ6WsiopSbo3kE5oGfpZpsw9EzmMzSukPzu/bf95MPTmE97wjOkB
         QfaVwCMzERvABk/htYCpZ5KsbiMJEduX3qODuMLtmElM7UrMht83fAUpyiJdqzVdNu0C
         E2cvzKdLCmx5mNys/8IRHXMuo45E2mMegu/lq2FXivAuwPmKRj6OJtbbJT8UPSySPgx4
         PnTSObaMY7UwdBuoYZZTiHIWKk9qqWQ5aEC/uspDpo55MZw/Bbhn0ImVmrbTNYuduYTX
         majA==
X-Forwarded-Encrypted: i=1; AJvYcCUPrabH+9elBRObZPoAUstbyvwbuzlimBWQ52DzDg8TchXG85qIzQ0Gp/U6j5q5Pv04+1EsGzDAIBqsb1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/zUGaYze/+6l15CzKL0C0fEsJigJGmt/TOZpCz6ugXdsSt+vp
	n4ICX14TeBK7AQ6ar2Um2VwmuGlOzguFOUbVyBu/ctMCsaOKBnXyq5AhndA/+fKXh5U=
X-Gm-Gg: ASbGncuiecatTqCFGbW9+X3ivQysGqY4kZdbdhiWiRo6ESU4aQW6dkhZYH4NDxXKnxT
	bYbyd5IVIUd87FxkWspx/hS7SEWKyaWLP8k1XypIF3k10+CwabtmfmC+7nhmfzqhZNnOzzB+dMr
	+6jSEMq+lwtL++2y6C/XADtSO/utklSRr1rVlzp0ZcVldiizylgzxPwPeUW6C4jf+jmPAPvBont
	1voi37UR64StEtYMPK/2Tv8qRomku1lg2hWWnNe/6hhi5yC79qe1OMZ+2Zt+i6qtWNJdFBzP6zf
	FOdu3pMcYNSCXB8k8SVPv4oxYXpw7JV1nuGs323GaMYm495bJjf9Fg54YKfm4YvpwyiEKBZsVP9
	zMPHoLBl1FdBZLtZ6NR8fkr88GOu+PFff8vHq8mGiz7nUMRC6uE5T4IrKVWVJp2//aQ==
X-Google-Smtp-Source: AGHT+IHhgguP+6o2tx8aSKJb8FENYgmztPkblCCAgO4rRlqiNiK7uHrwdn+DR+NuioAHPbC3T4JinA==
X-Received: by 2002:a17:902:f693:b0:24d:1f99:713a with SMTP id d9443c01a7336-294cb522877mr60919495ad.31.1761669530828;
        Tue, 28 Oct 2025 09:38:50 -0700 (PDT)
Received: from essd ([49.37.217.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d23226sm123763155ad.49.2025.10.28.09.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:38:50 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:08:44 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Simon Horman <horms@kernel.org>
Cc: isdn@linux-pingi.de, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] isdn: mISDN: hfcsusb: fix memory leak in
 hfcsusb_probe()
Message-ID: <f2xnihnjrvh6qqqqtqev6zx47pjhxd5kpgdahibdsgtg7ran2d@z6yerx5rddsr>
References: <20251024173458.283837-1-nihaal@cse.iitm.ac.in>
 <aQC333bzOkMNOFAG@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQC333bzOkMNOFAG@horms.kernel.org>

On Tue, Oct 28, 2025 at 12:32:31PM +0000, Simon Horman wrote:
> I agree that this is a bug, and that it was introduced in the cited commit.

Thanks for reviewing the patch.

> I think it would be good to add something to the commit message
> regarding how the problem was found, e.g. which tool was used, or
> by inspection; and what testing has been done, e.g. compile tested only.

Sure I'll add that to future patches that I send.
This issue was reported by a prototype static analysis tool.
And it is compile tested only.

> I think it would be best to follow the idiomatic pattern and
> introduce a ladder of goto statements to handle unwind on error.
> 
> Something like this (compile tested only!):
> 
> diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
> @@ -1921,6 +1920,7 @@ hfcsusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  		probe_alt_setting, vend_idx, cfg_used, *vcf, attr, cfg_found,
>  		ep_addr, cmptbl[16], small_match, iso_packet_size, packet_size,
>  		alt_used = 0;
> +	int err;
>  
>  	vend_idx = 0xffff;
>  	for (i = 0; hfcsusb_idtab[i].idVendor; i++) {
> @@ -2101,20 +2101,28 @@ hfcsusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  	if (!hw->ctrl_urb) {
>  		pr_warn("%s: No memory for control urb\n",
>  			driver_info->vend_name);
> -		kfree(hw);
> -		return -ENOMEM;
> +		err = -ENOMEM;
> +		goto err_free_urb;
>  	}
>  
>  	pr_info("%s: %s: detected \"%s\" (%s, if=%d alt=%d)\n",
>  		hw->name, __func__, driver_info->vend_name,
>  		conf_str[small_match], ifnum, alt_used);
>  
> -	if (setup_instance(hw, dev->dev.parent))
> -		return -EIO;
> +	if (setup_instance(hw, dev->dev.parent)) {
> +		err = -EIO;
> +		goto err_free_hw;
> +	}
>  
>  	hw->intf = intf;
>  	usb_set_intfdata(hw->intf, hw);
>  	return 0;
> +
> +err_free_urb:
> +	usb_free_urb(hw->ctrl_urb);
> +err_free_hw:
> +	kfree(hw);
> +	return err;
>  }

In this case, since there are only two memory allocations and only two
error paths involved, I would prefer keeping the frees in place. But I
agree that for longer error paths the ladder of gotos would be better.

Let me know. I can send an updated patch in the goto-ladder style, if
you insist.

Regards,
Nihaal

