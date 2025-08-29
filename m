Return-Path: <linux-kernel+bounces-792448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A10E2B3C410
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF7A1BA5C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404672882A9;
	Fri, 29 Aug 2025 21:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+cLPY0o"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E927A131
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756501622; cv=none; b=KDBYjdCZ4jDY3pjweqTp1lUmUwhA+RePW0Qua5DUyC6tsXmeYohzXOAQX+pCiJKOFoLC1lhi1bOYe/DGfTPZZ1pV2X+olWdcBKEv1j2kOuJocrB8EbZWSjfW7SmlXTDdktF8+0Mn4dCuLvVJriGxsB9s3A66gjXZ7VJClDEik+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756501622; c=relaxed/simple;
	bh=/0rai2byvDOWFH1XZaEpAVgSAWVS2LnNItZ7xlZkr94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H39HFx5YrAQ6U5hAVOpxrG5FiW0HPs9ch3QOorUQeQThM2+nMRE6FqGyKxhCTXeR1V2G1q80gQ8jjT+R8M/e7s8lu7CIbdpzcuEsNvAL8fq9vCst3rJcLeFxgJJpm6K2pm39dW1iavXfwZ4yxcOT0ruLxdfzgEVoYpHV5+d1faI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+cLPY0o; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afe9f6caf9eso374416866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756501619; x=1757106419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FNcEdygy0CWacLJjTJErfBlVOBzD7yOoe643gT3i8mM=;
        b=A+cLPY0oNsNjfDDKcOgBhWbsDXuLafbV4ciCi40ri7yp1xk/mkvyv9AIzkBuCjy75X
         1FFZQOFLTS9M6hhbPOHGZvsQ8vs+0r2sZQ/0V2aCdgQhamP1fACHeTevX+4xgPdczUZc
         lEAwDlzcYlAUX2/diu9tgdltDYzazvCFMIxALZubohIUdK5HN4d321aHCG67i8n890l7
         +89oZZJ1uKCS4lPkf81c3yZhSat3HF1Mi7+LAjcJsPnALDB1ZVpnvdned/rWRMVHQ0Lp
         nQAd6nX/CdoFXBJ/YAECf2Bu/lFbvtH/dNYkJSYjabZe5trcYkOio/K85HO1snRFL5JD
         4Y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756501619; x=1757106419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNcEdygy0CWacLJjTJErfBlVOBzD7yOoe643gT3i8mM=;
        b=fU45MgsPKou1U5gRKYGYcOxSKhD13FxgMySSnNRgL+xCAxikbXSkCbqITQrFvGIBnm
         gsjefimpcvLOmxzVR1S3oLzWmlS4GqL6EBCX6l9TGepwVTwse3bXI+/GB+O9CC3hk+dh
         bzbAydeeut83LXfS+jZDlvRN6dzsvi0ZzwZoQUl6HMpOrQ9JZFbopfwipjCr55KI0qcH
         n89k6xGPXc6aR99E2geghFcevwish4Eut+tzFKX63BF/A+ubQvLdUJIGl5+DJsSpkIgT
         28XT2nt3uOtWJ+z62jsUz/fGOsKUVYgQeR+s0pQz2ktlORI9cQSuu+RPpJWWJqdlU403
         TrlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo2muTl7XWMMYyzCGtWglQsGXvvH2XVO0TWB8L0Ja4Qjeq1YDf61q5C91KHFr+xmSMcAnkEa5h5zurDto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPQdjHxxVdUHcxE15iHokQmGqAlKF9WQJNMEENVSj6xgmcJRT1
	r+3xLmw6NboIGum4iDzdNN69qRhvw3R4wvvur9cUV85vWBG40Qoc8Q+2
X-Gm-Gg: ASbGncvCSrypmhj1UOtvI5ovqIi1ihkc8Ksw79KBGdS0bCaXHSW2q3+T0/AsIaVnLH5
	tAtPPHErFacjWAVcXOumbLM/WGAhthv+3+W+qpOGWRBiAsVKo6LemoDbHfdcUT7XeUV+COI4qrQ
	OsslF4xVLG8htTj8Hd4+89FJWxrn4e6Q8BHkQELC/AtyjRmX9jxweg84L+0sTv+Kr7iS2EBZJxw
	QFREywQ4OChjs0voq2VuC+L9Eu7CUcsTTa1vJeUay8uQ+PAXH4sI1tAif8QmaSXU576as3V7a+0
	UqQxp4AGXOINsZVCPbShD7pPD8DaX1xSeDf1AY7Gg8zHuhJCSQu9+YKkX8jHknmuXavoKQbTdlU
	fS9gZYGdzAVIUhZuXX3IwUiMp9s93YHcGPobINbXwt9EpY49Wv7cgx0xNEQXFwitTBkcapX4=
X-Google-Smtp-Source: AGHT+IGgWe0FyC8zcZgJTdl4Svw1qbqKmDGcyAwEXcA5/m/jHxsg4BlSThvn4DEk2IG6pnEQxtDyGg==
X-Received: by 2002:a17:907:86a3:b0:afe:d3b2:8b2c with SMTP id a640c23a62f3a-b01d979e9b2mr1094866b.52.1756501619010;
        Fri, 29 Aug 2025 14:06:59 -0700 (PDT)
Received: from kernel-710 (p5793502e.dip0.t-ipconnect.de. [87.147.80.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff104fcdd5sm146505566b.55.2025.08.29.14.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 14:06:58 -0700 (PDT)
Date: Fri, 29 Aug 2025 23:06:57 +0200
From: philipp hortmann <philipp.g.hortmann@gmail.com>
To: Michael Straube <straube.linux@gmail.com>
Cc: gregkh@linuxfoundation.org, hdegoede@redhat.com,
	Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] staging: rtl8723bs: more efuse cleanups
Message-ID: <aLIWccuFa_gHqcaL@kernel-710>
References: <20250824095830.79233-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824095830.79233-1-straube.linux@gmail.com>

On Sun, Aug 24, 2025 at 11:58:26AM +0200, Michael Straube wrote:
> This series removes some more efuse related dead code on top of
> [PATCH 00/14] staging: rtl8723bs: clean up efuse related code
> 
> Patch 4/4 removes an empty function I stumbled upon while working
> on the other patches.
> 
> All patches have been compile-tested only due to lack of hardware.
> 
> Michael Straube (4):
>   staging: rtl8723bs: remove wrapper Efuse_PowerSwitch
>   staging: rtl8723bs: remove bWrite from Hal_EfusePowerSwitch
>   staging: rtl8723bs: remove REG_EFUSE_ACCESS_8723 and
>     EFUSE_ACCESS_ON_8723
>   staging: rtl8723bs: Hal_EfuseParseAntennaDiversity_8723B is empty
> 
>  drivers/staging/rtl8723bs/core/rtw_efuse.c    | 31 +-------------
>  .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 42 ++-----------------
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  1 -
>  drivers/staging/rtl8723bs/include/hal_intf.h  |  2 +-
>  .../staging/rtl8723bs/include/rtl8723b_hal.h  |  2 -
>  drivers/staging/rtl8723bs/include/rtw_efuse.h |  2 -
>  6 files changed, 7 insertions(+), 73 deletions(-)
> 
> -- 
> 2.51.0
>

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Trendbook Next 14

