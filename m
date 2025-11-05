Return-Path: <linux-kernel+bounces-887396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE77C381F0
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 22:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECCB18C7E4C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 21:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561DF2E0922;
	Wed,  5 Nov 2025 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F90MitTy"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4124C2E0406
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379749; cv=none; b=GaSYv4BbRY/eWXvGsZl3XugKiRGuEPoH7XX/v4RO2IgZPCe9xHW5LAeOI0U4+Q9I0uGF8M88UubJlQ5cJVyFEmAVsMAhUsYQWV+o7LORSGhs3RFkShEbuFFyyAPFRMC5mAEoyA9YW+WwbvFaremXW/SsiLLXgfXrzwQsqcSO45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379749; c=relaxed/simple;
	bh=Ug8g2DLbLzCBhTyUF2XNbgVzYRLldq/aEXkueFP9qMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQg+doaptOeCNfjv1s8CFtkCDcrVZfjnEeirVp76+FU5CFYw3mZmmD4FpHP+kC0N1fC+omuHUx+05BTdhoYIt4O99Va3zkYawvszZJEy1Vyks4cR0rYXcBfTnzSXsi777DoFxB5SW3z8bM/GttGXOYKBRnDWY6s3I0QXyOOLDvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F90MitTy; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so324036b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 13:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762379747; x=1762984547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kjKBlbkJn1l/yS/I86rXkepoNl3ZyASZqL4WwU1YYNU=;
        b=F90MitTyyDnwswKnzepPPRHicqC+1wDX0B84pYxZjy5567EKTK1fT2gXMAS3umVjw5
         cg4n3Cx3dHLxw9rWVWLAajSNmk7ipr1F91lZTtXMFHMwaDFTwuTBOUJbpki7ibFYKHpk
         wdQ3uMk5CtYTf5bAmbTLsgmu805AN09YUIDJ/O6pBPzVSG8bYbBdsn8/uGNNRky56Ruy
         dAkxcaejSKeC+7T9UVPY/5MHc9a3RzUarLcnA//2b7scFBODF6spNqZ582JLnUXUl+HP
         HDd7rcbkI2YQGM0Lu6b9qLk/wa6PFglYWKNsbTRm8zOC5BakLovjQJCPtsRITONxTiQC
         vSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762379747; x=1762984547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjKBlbkJn1l/yS/I86rXkepoNl3ZyASZqL4WwU1YYNU=;
        b=Pk7MIrSXqVe6mUonRej7JkxGOyWnM9hz5gO2VTGA2NyVJsT9TrF7gAbkkLqXM4lFOq
         RYQbzJtVymhmWN+1rX53Cbd77J7DeVDpUQK5l7o/GCgWd83fgHcQgNwLqpBHkhv6PLL6
         7FAG2NifVL5sUFcWmAEDUahnWhf9u/EHHRHUm2PT6f98wBknU75bqLaCET+gAazRJP+x
         Kuz+Hb4nI/040OQI1slDzYuryLsbh0ZYRmIPB8AbjMpgo/bXaAg8XhHy7rzwwv/w9DA3
         FGMsIZqkbQmXBzgCU0GMPOjBNJu8xnuZk0poR66NPacKwQcVMxl4H5sgyre7ybY54JtH
         FQSA==
X-Forwarded-Encrypted: i=1; AJvYcCV/tJHw7hFYCBgwUh/WS82GBf75xZ/hSKZNR0hvC24OA9ajXRdqgWWuw7raOAi5q5mOpDtHe08bdmbolfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Id4eJrqOz4QNbfiHdaSN6DYl4yGjINkMnuVsJzeb0FAapK8V
	m4b6Z24+qSFKSbsjqRDcd9V4lZqBfDqICNDr5IFVuaAHP9I2MC2dEaHj
X-Gm-Gg: ASbGncsl+rkQvpDYlg2dFetLvIaQT5e+thh2TWF72oLmF9Ok+tZ/5q9kxcd0KUgU6ck
	L5aX5N00qqfCGuDOI9XjXZvOBQmleRpBTnqcOCpCDQZWs4IHcFQfs8UBTydx4hcTBS+QqZdoY1s
	Tn/20rHR5karYbIKw9wAsyXIZvJmL4x6PDGWm4DzEHVzBi19KTIHRUS7wodyZobKa1LB7A9Z/hh
	3+YSAKmW99sIXpoNt2W3bO8jy1qxJTwfwwn+AMHxDLKm2iDQS4D6Kxo+M3sPZbdLE+yqeIqH+mz
	YEB1Uph5XVFIH5ZGn2INzI14P3YU0jZWOsglWA6f9IPxoxaCqDGMxZ1naT/99RRFmR+o5LsyJmT
	qFIZqlJsdAJc75r1kkqGV6+46glxw0gpyA8QYuOgQiMqEa9GTVj3JDJzw0yf73dPgE/Xpwo0Vhp
	6kFJfEMP2EoLPx2fGCKX1zcCBh1cOmkEogTxVM0TIDLw==
X-Google-Smtp-Source: AGHT+IGFbejyBOcn4RZwmD3wXv2LNlisJTYCv5zyjOc04Vk5Kz59pFVzGvRVcMK8fVssCmLN6xEfyw==
X-Received: by 2002:a05:6a00:2d12:b0:781:2291:1045 with SMTP id d2e1a72fcca58-7ae1d154f21mr5418434b3a.8.1762379747505;
        Wed, 05 Nov 2025 13:55:47 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:35dd:7def:e1d1:adfe])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af827f4c06sm417738b3a.61.2025.11.05.13.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:55:47 -0800 (PST)
Date: Wed, 5 Nov 2025 13:55:44 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Denose <jdenose@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: Create input notifier chain in input.c
Message-ID: <a4zd7uzo3aigyrhturbpgtcsm2slmtqefivky2bfhqiupcc5aj@iorbkwz6ief4>
References: <20251030-lid-switch-notifier-v1-0-c58dc9b1439d@google.com>
 <20251030-lid-switch-notifier-v1-1-c58dc9b1439d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030-lid-switch-notifier-v1-1-c58dc9b1439d@google.com>

Hi Jonathan,

On Thu, Oct 30, 2025 at 02:10:40PM +0000, Jonathan Denose wrote:
> To expose input events to other kernel modules, add a blocking notifier
> chain. Publish LID_SWITCH_OPEN/LID_SWITCH_CLOSE events through this
> notifier chain when input_handle_event detects events signaling the lid
> switch has opened or closed.
> 
> Additionally, export a function which allows other kernel modules to
> register notifier_block structs against this notifier chain.
> 
> Signed-off-by: Jonathan Denose <jdenose@google.com>
> ---
>  drivers/input/input.c | 13 +++++++++++++
>  include/linux/input.h |  7 +++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index a500e1e276c211d1146dbfea421a3402084007f8..b342b1ff138ccc58d4623edcf1152bd85d7054bf 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -26,6 +26,7 @@
>  #include <linux/kstrtox.h>
>  #include <linux/mutex.h>
>  #include <linux/rcupdate.h>
> +#include <linux/notifier.h>
>  #include "input-compat.h"
>  #include "input-core-private.h"
>  #include "input-poller.h"
> @@ -62,6 +63,8 @@ static const unsigned int input_max_code[EV_CNT] = {
>  	[EV_FF] = FF_MAX,
>  };
>  
> +static struct blocking_notifier_head input_notifier_head;
> +
>  static inline int is_event_supported(unsigned int code,
>  				     unsigned long *bm, unsigned int max)
>  {
> @@ -367,10 +370,20 @@ void input_handle_event(struct input_dev *dev,
>  		if (type != EV_SYN)
>  			add_input_randomness(type, code, value);
>  
> +		if (type == EV_SW && code == SW_LID && !value)
> +			blocking_notifier_call_chain(&input_notifier_head, value ?
> +				LID_SWITCH_CLOSE : LID_SWITCH_OPEN, dev);

I would prefer not having this directly in the input core but rather
have a lid handler that can then use notifier chain to forward the
events further.

Also, here you are running in atomic context, so you need atomic
notifier, not blocking (or you need to involve a workqueue). 

Thanks.

-- 
Dmitry

