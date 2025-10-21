Return-Path: <linux-kernel+bounces-863504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B24ABF8008
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A8A04E8112
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878BD34E747;
	Tue, 21 Oct 2025 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0wtJmlO"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9479734E750
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761069520; cv=none; b=Udu/Y+9BPrFMxr0NQVBQ5evdltNgabwmizaZC3hQ1QzGM7iCtTjxZ6ufU1U1/BnPDP0iXaF+PtFuBuC633I7hLhzZ5coy19SsXaK63VlWX+R1de/NQOyZ6sMI1HtjaM6km6dCOmY3M81GCmM+VV8mvjvZgd6xyjmjrmEmxthJeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761069520; c=relaxed/simple;
	bh=oVng6fWpL6+zAcowBglyuHt/XIthmz+mN+6mXhWfgns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAfeMUTAUa3SUx5svpH5+YfHHhlQQyOBiWZDJ1233cJH77BACA6oRWrIho3/38rX1kQMVBUSKFRnHbLr4DaMpT6eB+ujK+42G3JlXnwo3pNIChdCLX6+fhXLwwfkyCLiON9CDdtAe0OXLyvbWZxFugNHZ4/nyLLPYIhOHauFRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0wtJmlO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781010ff051so4395344b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761069519; x=1761674319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WrSVEkanyR2raSWr6Z5enbATkDaqZXlpz9bzA6mqOvo=;
        b=W0wtJmlOUkEuSXcABm36IicjC1uVQ23JTFm/RJUGDAd+cr2T21rMwbOkNdmrWPz02r
         nnEL/iN3hvdehB9QTvdP5C6MgYlIn5iyR9qB2MYoZVz40T9UxT/zEeSMFwRYWQaQUZU5
         +7mskIfCrigsGeYVJeuyAOqBweWRfGtvXtQ94jemhPt65DY/AErpNYX+HN7Ad72pZwRD
         /YhJXdtuekO6vUIGkJdBI+kMW0gkS0But1ZEEnCv2+rYwah7jTIGksSAD49KBw1W5dzI
         l+nMowBhFQkw78pYzicRvC6gODSU1/UCN+G5Jh3hNSqUzlffTLEyuK5KRwrQmfLm26Gg
         TZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761069519; x=1761674319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrSVEkanyR2raSWr6Z5enbATkDaqZXlpz9bzA6mqOvo=;
        b=XC04AH3Sv0lrn7ijjC+xhb1xe3HyHtOimR1nj5vGY4E0lPPzFRPRdvxvd3ICHn7OFj
         kuuzXi8EUjBOhGmX42wXDmeFcTtSopl4ikRiw7reyf7bOp+J5a9uWfKGsibagumK2WZb
         4D+7kzFpZPeqwlNCIzwqPgyIZn7EORfOl3c5tsdoF/Facw5UNvtE6zQGLcOogymcDBB7
         hUzDvstD4ETbtsydqgCJeCoXxj+Z1PMysZ7PHwG1OhzaGmxeZEqgfy77C4kiE3pEftWp
         fNeptaKFbBSbyaP+dJKHMhnookMPkAzKZXINO34Xw9tyaXH7ilmFxAt9rK85aHQrME2j
         vZSg==
X-Forwarded-Encrypted: i=1; AJvYcCVkl2e23VsRpJyw7I2o9R6cZ9gCkStOzA4IAAhps+QxHroxIARnOzCDCNcPlrVkMtweiRktQA7SKNrNc8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YynVFuwM5VYRixsb8UZyYOSwPBYfbQdFHtl0STM2g6lLU+ZXnvM
	KK79Q3XCUM9VJcbr5hIAJ9Tjm31WSGOrrFgSyXM2ttZVBSWgEKbXjDLP
X-Gm-Gg: ASbGncsq6aP6vvACQNX9b43pg/v0fsZzUfdZmxkMNnjoh7EZDFEeDhUiCGhRmflHhb6
	Fk179FBakOegUuPqz/PPyL/R4a3yJexc5m2eAcOQTsTqTIDjFyZTNiHWsj1gRryOhci3Gi8aEn7
	RoPfzPHc0ONKu1jygXiAD2MQe8+IWYV7QxZwHeC6buHevbM7IPD+Ttu6cJ8F/GOMNom+8GvRMi7
	AwTqxMIV+jrTLMqbT/5c8pwjx54U1/SeCSpljEGvKe3TpvIsCRp21LZhRjXinPXnDe4U1W4QT5Y
	p5+0fl+Sy7jn/wKt6D2RvFBx7HJjT4eOqXN9JEwfQW8ZIvnLdY6bNrh69MX5YKcLSCD7S54tsN8
	9OXCHQ0F6VBY/6SCwbRiJtgq8uNBdCT2bvNvJgw19f6WWkELGZ0fpI6vg9z5xnkhgsd158XIw/H
	+iQS3jvpAQGP5qvYttVfHI3K4vaBE/kmb/2mWgem6U
X-Google-Smtp-Source: AGHT+IG1/8RQi0Z/qvWdJQ+g6q3+RnnFcN/xD+n+8yNjkNb6lOorDEZJv4LXW+vDN+NpEpk2xHxl0Q==
X-Received: by 2002:a05:6a20:9392:b0:334:942a:daa8 with SMTP id adf61e73a8af0-334a8622b2emr21456240637.50.1761069518621;
        Tue, 21 Oct 2025 10:58:38 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:bf44:8af2:4f63:3654])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010df2asm11941146b3a.64.2025.10.21.10.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 10:58:38 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:58:35 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: akemnade@kernel.org
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andreas Kemnade <andreas@kemnade.info>, Tony Lindgren <tony@atomide.com>, 
	Kevin Hilman <khilman@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: add TWL603x power button
Message-ID: <aalnnbzeajxgnq33go5b2gi72yjzeeun5f2pkbdulu2hwuz663@b65xssnkse7l>
References: <20251020-twl6030-button-v1-0-93e4644ac974@kernel.org>
 <20251020-twl6030-button-v1-2-93e4644ac974@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-twl6030-button-v1-2-93e4644ac974@kernel.org>

On Mon, Oct 20, 2025 at 02:31:59PM +0200, akemnade@kernel.org wrote:
> From: Andreas Kemnade <andreas@kemnade.info>
> 
> Like the TWL4030, these PMICs also have a power button feature, so add
> a driver for it.

Could it be integrated into twl4030-pwrbutton.c? I think the differences
can be accounted for via a "chip" structure attached to a compatible...

Thanks.

-- 
Dmitry

