Return-Path: <linux-kernel+bounces-886660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5298C3631F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7B5E4FF12F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7155D32E6B4;
	Wed,  5 Nov 2025 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtPOEdY5"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE728308F25
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354465; cv=none; b=Q2JbEQi3d3jGBbx4VbsOsQUSTYmvhWyAsYma1PlyI+IzKIxCNi+zGAvouKV6mqhY5azRuwggsXLVv7uzcHgBKHNg1j8c5XHK4+otBQlZ0B/heqjysqhU1hO4d8WpzhXmruu5HqZKfqf1mij+t153MV0Vhj4xeHbYLfE3YlRDXsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354465; c=relaxed/simple;
	bh=9PR9Ui8ToTKXxDFeyWEbNhS/TV+0W0qENUAbZTNpHkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIhRBHID9MI+xpOt2YTDb+18K9KEU/dNftzm35YOhZ78aZiId2v4WhpjRIML0CrjNQppJDApzS1RHdkOP8Gtx8OuR4d/LLvf5//7YD2/XRKeMC/0hRcPtoYLPcdx0e3En9NgCK3v3NBssY1B4NwjYwlhWy8NMH9EzXEI0a0bx+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mtPOEdY5; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7277324054so83046766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762354462; x=1762959262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rso48ZLUTdUYb/Ey0UMY/9I863vsAkEssUt/OOSP5Kw=;
        b=mtPOEdY5WrA+l6F9pJVWZLxJYaYdcKJmW7ejXOLSsbQKdEZ8b8MvBZacDazpIREqn7
         eeAEJf0+kDBo08qmJD+dnw6ogkc4U8pph8GkPHwzRQj/CLbFyXn11p7RfgH5aBxTDUlu
         vEXp8VvGGQ+sa30j5uvkB5MtMMRUXhjU5EuLn+IE6NOCtw8JApJLfML6Zkp93rfyupiv
         Uo4h+bQE+qBcUFpTwChc3hTvp2KWT2OLtJklrV6n0TVvopS0F/hw2VwsvPNZU2U2drj/
         V5UUD9NPuN/1p/jFQHiwbRAXhR7mhcKSOPIEne+cbzmDZ9Ei8W2e0sUyL8kjjM3cJAkY
         L50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354462; x=1762959262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rso48ZLUTdUYb/Ey0UMY/9I863vsAkEssUt/OOSP5Kw=;
        b=QCxhP5Rgd7I96i/5e0dr2hjJQN5ZkzmmWhmQYkUp37YfK7knuX9aBisWYEwf04D9Ch
         aLFHSlyoFp9xZYOYxEoA+B0wHjSKSaIKrqXxgavM4n4KlOVYSjOs9/PGhR0Ny8KcFTcF
         ODBvlF3hGTkkJCqBBstqA5J4yrGbhTvwo7MMHnfaoAJx5TS9jYlTSkpHPxpL+ALTqDHy
         KC3CJVSW2eykVSmhNvBdRihvqZKgGDFQiVEpty2NagKf+Pq9soeiny088h9BCSnKBCP6
         1rcKIkWVQL2cCc/4AWkZYx++NfUFerG/c+zY+uVQQdwcf+CV5YwGjZTIWlatI/971h5R
         Rc1w==
X-Forwarded-Encrypted: i=1; AJvYcCVs7KAKXkTZ3JjabVJauvOFKyGQccoL3fjuVyGxe+D5X+hcE6cduRdy5wq3oYvn/weXrHc9ETrrON++uzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE9i2Qj7oZG00HgqheiyGm2ZrWlp3S1K8X/Rx0g9tF4vl0Fd4J
	Q5xNCN3LS+3eRqN3nqFN2MhrTAHslNVIjafhLXZqWCFCkRKd67K64oh+v/DN40Mn/JKH3HzE/oy
	dkIQ+
X-Gm-Gg: ASbGncsqLW/8Vdl1VYs4LiksNbQ2GpkWyknw0VT/C6P2mmVaZ3ZfxTARyZknKszJFX0
	Iq914yCz8cGH//oAR+hWRXn1fDR6ZpBJRy4r0wktOUpCVFlLDAnuhaN7rHWgnHIaAQsKr4HHRls
	M0tG+JRMAnn1mPe//Nia/YRWm/inILOQ211VKzn/dc9ldMQaeMh/43nHgsYxagqNZThuGK2eQDO
	kejgr3fCdFwaS5tcRxtNC9JtQqxeu5vSHViuGOSpJTnUxaNLXmuuuFfYJVQgshzgWXaS+CDR6Jl
	hEQCTKmxoSzTe4o6+xpC4aPdDQgL2OYDG9KrnrLsPoRB/kNONk4exm8lMMMVH03o/sLTfswfNfH
	aAw1t03K4yaBoE4KPIEETF6V/kShKJvbh+gsA8THSTEszh8mMf5rrPfSbD+idmngBhBkqXaAWfG
	Ev4fUXmL5gTNbRT/1zpMEJEoM=
X-Google-Smtp-Source: AGHT+IE9D6VKvyalRSJfPC3AIpQXjSXQIzyul0MgV+vBwHPjqR1hb6Z5sp0y8RViBXTUBYLh7S3xVw==
X-Received: by 2002:a17:907:d649:b0:b71:5079:9702 with SMTP id a640c23a62f3a-b7265298431mr364006466b.21.1762354462083;
        Wed, 05 Nov 2025 06:54:22 -0800 (PST)
Received: from localhost ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b724034ade7sm507488066b.69.2025.11.05.06.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:54:21 -0800 (PST)
Date: Wed, 5 Nov 2025 17:54:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] rtlwifi: rtl8188ee: remove an accidental '-' character
Message-ID: <5c992936-4e7b-4c0a-abfc-0ec0fb9ef9fd@suswa.mountain>
References: <aQSz3KnK4wFIJoe3@stanley.mountain>
 <8d6962531a9545fd8279fbc7cd04340c@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6962531a9545fd8279fbc7cd04340c@realtek.com>

On Mon, Nov 03, 2025 at 01:17:07AM +0000, Ping-Ke Shih wrote:
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > Sent: Friday, October 31, 2025 9:04 PM
> > The "->allstasleep" variable is a 1 bit bitfield.  It can only be
> > 0 or 1.  This "= -1" assignement was supposed to be "= 1".  This
> > doesn't change how the code works, it's just a cleanup.
> 
> Yes, this patch doesn't change logic at all. However, it looks like existing
> code is wrong, since other places in the same pattern in this driver set to 0.
> More, I check vendor driver which also sets this value to 0.
> 

Ah.  Good.  Thanks.

Could you send that patch and give me a Reported-by tag?

regards,
dan carpenter


