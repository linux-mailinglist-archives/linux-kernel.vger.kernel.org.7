Return-Path: <linux-kernel+bounces-737360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90323B0AB54
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5DA1C81CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AF221ABAE;
	Fri, 18 Jul 2025 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dlhY95vR"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC3C2C9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873440; cv=none; b=Cl8VAwhLaulal/fHVLEz06e5G6Wq3+6DFmnhMLIxZ454cKsNUpHk7tY5wnhNAnznfjBK08I40hJz6FwgPddfScrMuEtaWbWzS4FAEFaK/35RPCiVvqX4lfulK7DiBrdW1mrB9BxghsdUEyRAHJbmypFo7Ii+uGzJxIEdC5P332M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873440; c=relaxed/simple;
	bh=1we4BNyZjm8RBRnwSxx4wo+G4NuxZiWnXz7k7WwGtK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvhkGl2eDZ5t2jVXXQjt7Hmm4yVFRe7TGxX08kAszKVl+QDT/5vclaE+CQV70oowJWfaB+WHmiRfo2vo34ws10ZQkdges39lIVIpfQMLldxW01U6PhiqvrkdZQ2yJi3M+FWS+Lid7klekS/tnCTGmEFowFqztb82BXfFAeL2DrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dlhY95vR; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72c47631b4cso1837572a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752873437; x=1753478237; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E2HU107DWxeJ8QpUWs+264JfniOxCt57NM2CKpeAioU=;
        b=dlhY95vRSJ/tdXLcH1ZFq2phOo5m91uD0yRX64tIDu90hpGgiB7MLxi0wSr76R7aRE
         U1ieSgl6sgzcc8c/H7D3OfikQut881VHPOREmYuG1dc4t3GQ9apItixTDCKqBl7yaQHd
         KORWwRUlP5oXdofHpL8rh3R6EYpPSrnnFQQpSoz/mOoD50ensUZ9iXaG1V/wNcK2qfYE
         CLhq7rLbof4VQLew32RLVIwA9RcvDHId6kBpj5U2ZhU4aZCtEClJAqiJiH7a4b0eR0pl
         p9E0+neOOznP2GMNWEs4cJEKm04HOyx3t8bHzKqgVR+V+ILruPTGJ+cxpGMUnO0f00wX
         O/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752873437; x=1753478237;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2HU107DWxeJ8QpUWs+264JfniOxCt57NM2CKpeAioU=;
        b=i1eWgHBe33QkAPCVnTKQwVEL/Jk9/9CvMt8H03PEIhIx4QERyXbCqPZytpQSgH2JM7
         MNxH2XlSR13+CyD7wE3ceQR9+t3SeYoHhEgIcRHx8pEuRlxAngjc0CR4fUrmSGOKfy2S
         eFoK0DHf/RmI/sWK12GY/NOnr/WPKwuV1kPCw0bb+GysvRcjh5fJpo1YH9RZiai92pXJ
         aSYrPML6X+TU48jcDCxAIbjiY+GidNDvrss/u+MdA9mS7qrEhhkaDnh2dMyL2rzkUcI0
         WHvYDzzuFnxq/IcY2s5WUwyPpzTAAdSit9W/aVHKNr5jvsrQmqI3BfljwwD7DfPm/Kpi
         L5AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt115BBYIYQyiFEyyib8fDO+B7R9wu/CdzDGLWF9VIkv0JysYe97pnTH5vkHaSe4OFAE/OmxRFVBHSqD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx16py44llpQXeqBGfZbN59I1tLVMIIIW4VWoNIv5ezKdAsXU3a
	/ZcQbyYANZ12IsiY/z1sDD/Tt64cFlA1VWhVjH0pvXmsinyYtT7Im/rXD9KmzN+mkz0=
X-Gm-Gg: ASbGncvHPr+djO/A1c2RmNOeWJro2XG9URMHnNjAya8+sAN6gQJsifNO5WTgKFYHXgL
	jDtLJTuY+rA218lZdgcUgmQmdNuQjPoVjBJb77MnMxI2hcVZE4A37iA1oACwX9CWK4RXa7YNh8J
	qafSFaXZsQuJIzhyHL0+TaXX4P7Ms4SGorKafFTSulWJC5lXk+h3WHYluLQJlpplkyFnAVBy8N4
	52oq7p+1wqymtEX+S7ClvvNr/+1gj446WkduNktzcHSrV8PBUbAS4ebCGRIkqgXb1rsG7IbrVfg
	uB8gDNwdAv3I/YNtL5225mWTPtDJ4ovc78t5g+XXEB/54GanCu1GZNQEXTEiao9CQKWV+N467Dw
	lkcRZiZ/J2I1mkmdt+qqgcaGdfLJrsQ==
X-Google-Smtp-Source: AGHT+IEMwkHe7o0rLxRDKlvWcR6s/GxZv/6d9WXPrLeB7lGEuJfR80OfhLY4uOCTY+sYBlZAg2ErZw==
X-Received: by 2002:a05:6830:40c5:b0:72b:8fd3:e2dc with SMTP id 46e09a7af769-73e662d80ffmr11860820a34.21.1752873437043;
        Fri, 18 Jul 2025 14:17:17 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:e5d3:a824:1a57:fcaf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e83636eb0sm942734a34.21.2025.07.18.14.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 14:17:16 -0700 (PDT)
Date: Sat, 19 Jul 2025 00:17:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ignacio =?iso-8859-1?Q?Pe=F1a?= <ignacio.pena87@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: sm750fb: make fixId array static const char
 * const
Message-ID: <a9cd4eed-841a-4d00-aba3-5ffa0c40c3a7@suswa.mountain>
References: <aHq33vXh0F481FB-@MacBook-Pro-de-Ignacio.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHq33vXh0F481FB-@MacBook-Pro-de-Ignacio.local>

On Fri, Jul 18, 2025 at 05:08:46PM -0400, Ignacio Peña wrote:
> Fix checkpatch warning for the fixId array only:
> "WARNING: static const char * array should probably be
>  static const char * const"
> 
> The g_fbmode array cannot be made const as it is modified at runtime
> in lynxfb_setup() and lynx_alloc().
> 
> Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
> ---
> v4: Sorry for the confusion. Previous versions had wrong line numbers
>     or included changes to g_fbmode. This version ONLY changes fixId
>     at the correct line number (734) against current mainline.

Please stop sending new versions of the patch...  At least wait a day
between sending new versions.  This one was fine already.

No one cares about the line numbers.  You had put that note about line
numbers under the --- cut off line so it's informational only and won't
be included in the final git log.  Also line numbers are constantly
changing so we just ignore it when people tell us they are changing
line 123.  It's not going to be line 123 on our end so it's not helpful.

regards,
dan carpenter


