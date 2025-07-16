Return-Path: <linux-kernel+bounces-732833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A8EB06C93
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA6C176BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 04:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B128B27700B;
	Wed, 16 Jul 2025 04:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HwR1GsOb"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9481B1C84DF
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 04:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752639510; cv=none; b=C6PLIxWaDuQ/R9MAp9tGd+6mTSIp8BoIXmKvlRdX51y+IGsMsd6RPfkRPiVKW1XSENyrCS0DSk4ZFqycKzQJIjBgXnmafNFSZneBBEIwArx7B5SEG8goYzPR7MuU/tNrQCNC3RrF2123MKtLCi/sJkrVVwVC2DUAJi5d2PMxQH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752639510; c=relaxed/simple;
	bh=oto/n6TCbchQzSB703btk16cJiplLhgQ7zW4XX5nZ4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3xTtWAlNrZbGQWswJ3GqvchoKxMPU2DPbpL6eHEXFuWRnQyW9Nu61crPg7IXc6RubjzsHeftuvluvDp+RlEAzLlf1Dx4g+mK9d3/DMsEtdgp+525hkxALPGuRughJ9UAF815Z3WgnJzvaqb/NnoCPrDC7mBIvsxHh47nG82Si4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HwR1GsOb; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-73e65d29fe9so155250a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 21:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752639507; x=1753244307; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5H4HdKrcQEwabRwfwGJyrWRCmxFyWkQ7fRmOg4zE7oA=;
        b=HwR1GsOb6XnIFTIzWkEgIudl3S55gotvPqp4XRRbpiRMiqjrWj5m3aXqhFqdMAM6mt
         /+Sys6Nb2+702qHc/6sX/vTmehSLPyhpF/DCugDn5RTMK0iP5x/muKg9QwShqT+m44zr
         1Ku1dJ1oOLUdZrCENqpQrxmv3cM5be5mZe3XYiAX87332r4HAsuna/R/a+sgRn9ONJVn
         HrUIT4m7etNNFMPGQcqxIkod21KH9b1ioe/UAPUtrWLg8DjNedwwFt7smlMywjLyBFsz
         oEHfheVcO6CBOAFLxTHgkvVuw2sBrPNHNsuCqBI/ISo/9MsF3Q/TXIn9YkJOshRqa2xf
         HqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752639507; x=1753244307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5H4HdKrcQEwabRwfwGJyrWRCmxFyWkQ7fRmOg4zE7oA=;
        b=OaywrZmgIAfi3Ku43ol4W7GFmrDmYxt1NU00PdcT0pc5sof5TfrM3yoGCqlrhgf+2Q
         Q7oqZPhj00g3jgv/ZE1IMQV/qI4hPetrAgA7ezdk+RCIx93CVv6uV1f3nY5ShmDQr238
         HEVDVxyGHzMBng0bKyU7qJWeuiOlLQGOQURP/BLbFSmh93SFrQkIGPHgN1FcxS1Q7Sjb
         swXL3z2/1oJBhDxQ7Rcwz4t4/Xbg2s3DqXQ9b19IZO6jp4bZY0ICeSKy2QKYyXu14fsL
         URYXaP/aTxB2yt2CLKtKaqWrbOHjOF1kNAeWyi3mjdpKrtT2ryCkr7RxfQMJ9zD7i7vk
         1VTg==
X-Forwarded-Encrypted: i=1; AJvYcCWc0vXIsrqHotGa/wLmuZ7GqGwScV4nu34FGSwDFzowcAGmujwtkIMaksNFzYVKbY9sSIdZH7x93cHwQOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfPSHD/XWUpwAI4OwhxIku0CUzlxJeBpwa2+zm5cds2IJe3y0E
	JZFP//vw9So1xueZZRwFJpKc25LgJjXviLqN8EFghc51Q6cYgpyd9Iv+SdI/dLcea20=
X-Gm-Gg: ASbGncuYpwHpRVaS+x5K71/UPxQnxTCImw0omSYXKKZy2Kr6jzHEyaA3SscVPIzgx6q
	6Bt+QzcXq+2pN1BsH5mLt9XbanTJty4f9kt2iVstZ9R+7pblnV8jd0AvdRlnSaN6TzQrGk9N9jG
	F7qDZw7yEBchwV7dmqK2G/N065vTLinxGXAQxPQtsLNAyrChZWKVfzSBwbUZCGpTtrE2BTIxl2J
	197UPhEBm3kPuIGvwyVB0ncbJVGxf6vDb5il0r9iy6aPI9dZ5+L8XhS5MdBQlSH/f7Y4ahoKNM1
	ucSt4X8xUwrpZI87ZJaJGMV4599mSqauNErP0BlRK/7fYxB6dLKSx4wj392wXlhRk05DB5ngDoO
	lGbfGJyCHQzqYLPQeTkgk1m+R0Js3zCzIIn4Z7dQ=
X-Google-Smtp-Source: AGHT+IFhLjhnOeo46E/SOKl3OzTueSgMQlM58Zb0eK9UOOWBXR9DisA8ORH00rRKCtUrLi/toP8HcA==
X-Received: by 2002:a05:6808:1512:b0:40b:2f3e:5f55 with SMTP id 5614622812f47-41d004038eemr1085693b6e.0.1752639507467;
        Tue, 15 Jul 2025 21:18:27 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2564:68a3:7d6:cb7d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-414197c52a6sm2482751b6e.19.2025.07.15.21.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 21:18:26 -0700 (PDT)
Date: Wed, 16 Jul 2025 07:18:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ignacio =?iso-8859-1?Q?Pe=F1a?= <ignacio.pena87@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: sm750fb: Fix const declaration for g_fbmode
 array
Message-ID: <d7f17f72-d086-4ab2-a22d-33f0ea125f54@suswa.mountain>
References: <20250716005553.52369-1-ignacio.pena87@gmail.com>
 <20250716005553.52369-2-ignacio.pena87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250716005553.52369-2-ignacio.pena87@gmail.com>

On Tue, Jul 15, 2025 at 08:55:51PM -0400, Ignacio Peña wrote:
> The g_fbmode array should be declared as const pointer to const
> string as its contents never change.

Try compiling this code.  The contents do change.

There are a few other issues as well.  Try running checkpatch on your
patch.  Also there is a specific format for v2 patches
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter


