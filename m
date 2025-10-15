Return-Path: <linux-kernel+bounces-854405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D10BDE49B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF3B64FAC64
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8033218BA;
	Wed, 15 Oct 2025 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="uXInOcrX"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B1C3218A2
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760528272; cv=none; b=vA6HZ8lHdK872hz2vHq50Gy8rFGP/PR4bo7gCbaGnqnoV+Ur03gn6l5ZJ4EvndbYHHwJOUrBsD4CHa/7arTJnT+mPn2xrsMv7wtKV/PkHTIeGmg463WFhHcx3peNQQnV3CxzK1ksk3wI/z+jdiN+m0iJvo743MIlL/zE23/ooG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760528272; c=relaxed/simple;
	bh=8Ued4uub8HVIf2O9AoBK4dsArsa3cVF/09oq40u5Yo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kG+XuzDCh4r2ZjtGlP2YSqX7/hkE25WbwV7V3P/wXkuwK+53IQRWJbsLS7Kz6f6ayfu9+Bkft+2WWPlJI1x2uswGfGdg8QhmHvI91Bqw3Yto97H4n+jk8HyZugHJQa7NEsdp3wWGIy1Nr9xipT9vvBYrcofxD6Ev9HSYU8RSWfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=uXInOcrX; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-43f5dbebf02so1294299b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1760528270; x=1761133070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyADvYjKnQqyX4oYA1nEg/1fwJhYN8XvPFT/8EJ6yc4=;
        b=uXInOcrXY8QJE+XBQKS9zpv+isATgj2S+mxHnDTp/QuyKq0Fk84pqDOyuaruC8zuUg
         Rx8qYGTh8BNaQ45VCj0qicTP+fKGv7x8c27t5u+vkeXkH+ec75HiIAmf6dWX82YVmHo1
         xIHr9fPQq7UP/Kcw3YB+9YA/FhGHVqb++h3vpbsrVHweZ21J1gnBI9gvdzxx1Oa00MeB
         kzWDxipYE1lj1GqyA5OpuqD+z/e6d1z5k+ZAIe+BUxOWl0Ef6XJMuLsTbfkQKCR6Tn0N
         BdK7dNikZsUPbFqCOjqQ2Ah2gItTxNFm4IumuCv80jvoNtjCpVG3TBuG3oPZfyToBl3i
         BpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760528270; x=1761133070;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyADvYjKnQqyX4oYA1nEg/1fwJhYN8XvPFT/8EJ6yc4=;
        b=woDt3WxxNbWAkeBqm7MLuroyni0Eu5E7evkWNhcAEBr0lTjAuymG5QHC+roboZ7ukr
         hgA2QlmeQ1x6gZ4dujZOxSdXKOEACAwyPhOJJWx+y+Gqz1x9tUTc0pT1ePG8AM87jINx
         9aVDlgm4tMZH4hzZDrKPJDhye0yoqegeuoWPEmxIrrEVBSF7PmQheIQhSvRNbeDnXnqs
         XtMa3KNcjW7UU7nk2Xip5/oUO5PksvR/SV0wARZTpxS0qNj7mPBYgiMKT9JWms/dbObB
         VZoT9QvJd7wJA1ZdE8SnvghPUOtojLJKjxBP0/OLhSeWhzRwYyWirEQqfHdB79a5uiWX
         PR3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdegCSZb6jZnKx9RGAlplKh8QAmpp205QNhkh3rC/NBivfhS1DlcKuNT3cZgJH4BBasRYNqJp+RBaG2oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKVLCy6LeLn4tSneLbFeo6R50jSARkaRl83zILxC+EJILGgG4d
	drbrZtNoJvNA2q97/sZ8wPMj6Uce/xkP3bVUo3eAqlCt4yO5LTlAkzfCcg0B2KGZcSGdIpdpAYV
	mL9LM
X-Gm-Gg: ASbGncvh1w1GTQ/m/EvADzq3DvAS5NWr/TaFh7mSUG4ZSM8fT0wsGNHTu5e6ofpTXm+
	/E1ees1c6FbiiziH9LqjHVE1rCkAmSiin08aLQ0QrOFo8oOf/dSk+6YhvOcm7VqOClYW+JwwGZO
	PXeuU75D0agKyy+kacLMtc3X/a9KN5L0MLXJ1ksDUeQpu4XmRLnwoZju7xJ4Kw65uu6ZkHtxaqH
	lGCKj5RP7Aev3mBi8dWKm/C80+zfPEtmZBZEcxfFtJqztw6CKvEAgXBmPXZ4eGSeznUgHhzzuBK
	dEN+U3dcIZ2WRAvXwXcGnRQU2d2ilwPPOc6BnnuGki4ex1Z8h+FIP3wV7MQUujKXk/R2sNY09aq
	i7dYEI1v7Aq1eHw0I8PD7CTM84o8p19bsUFsF+BwkARmP
X-Google-Smtp-Source: AGHT+IF8ikLsunnofVE7oR/wbYs0vteDdLFTVIEJJlab2tBfktgzDPUgm0kamWs++bBcUapugbYm5Q==
X-Received: by 2002:a05:6808:e83:b0:441:8f74:f31 with SMTP id 5614622812f47-4418f74263dmr9403478b6e.59.1760528269821;
        Wed, 15 Oct 2025 04:37:49 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:ad63:63fb:ee1c:2ee9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f915efddsm5245179a34.34.2025.10.15.04.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 04:37:48 -0700 (PDT)
Date: Wed, 15 Oct 2025 06:37:43 -0500
From: Corey Minyard <corey@minyard.net>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Lee Jones <lee@kernel.org>,
	Corey Minyard <minyard@acm.org>,
	Huacai Chen <chenhuacai@kernel.org>, linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH] MAINTAINERS: Add entry on Loongson-2K IPMI driver
Message-ID: <aO-Hh4i_NAh1O_Mm@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20251015095556.3736330-1-zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015095556.3736330-1-zhoubinbin@loongson.cn>

On Wed, Oct 15, 2025 at 05:55:56PM +0800, Binbin Zhou wrote:
> When merging the Loongson-2K BMC driver, temporarily removed the
> addition of the IPMI driver entry in MAINTAINERS to avoid conflicts.
> This needs to be fixed as soon as possible.
> 
> Now, adding myself as maintainer for the Loongson-2K IPMI driver.

Got it for next release, thanks.

-corey

> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46126ce2f968..053295599785 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14660,6 +14660,7 @@ LOONGSON-2K Board Management Controller (BMC) DRIVER
>  M:	Binbin Zhou <zhoubinbin@loongson.cn>
>  M:	Chong Qiao <qiaochong@loongson.cn>
>  S:	Maintained
> +F:	drivers/char/ipmi/ipmi_si_ls2k.c
>  F:	drivers/mfd/ls2k-bmc-core.c
>  
>  LOONGSON EDAC DRIVER
> 
> base-commit: d27fea27a307656f0b55d6b9ac24caa40c7e4181
> -- 
> 2.47.3
> 

