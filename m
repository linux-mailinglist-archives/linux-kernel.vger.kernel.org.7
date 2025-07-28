Return-Path: <linux-kernel+bounces-747469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41000B13433
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6F83A622F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AAB21E0BE;
	Mon, 28 Jul 2025 05:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck8GFCVM"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A6638F9C;
	Mon, 28 Jul 2025 05:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753680881; cv=none; b=RrpetjM97xKZNSOF2xzCXPAkRHdpAkiF/fYCwSdkYsHPs7sCWWRa9okNO+EY+Ha5wx6t/ZGLi2ndETOTqGiwbVIKWjW3EmYzExj2LuQwQyeRv57tLVkM9bm5Gqi636shGQfZsx4mAheVvlgyYDi7dBIP5g6p5Is8uO0HrAHmaag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753680881; c=relaxed/simple;
	bh=ZSm1t26GjMcsSV/MuQ8/Z8Au+Sw4b+4wxR8Bn0JDJnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oM4hIwNEXAwMh3qCC+FN7S/sppo+eYLrfkR3eM5c2Rm112LmlIzy1mpPkSwcPixzmKAAk8YRlnmyyxzeDgf4q99Xd3fJ3tBJj2bt/Ca2yHO2udANiasdM6uy4PqsjTXeb6EOqfMwzV3kIPHoJFCf9pMk+qXC6uiFkAXL8Wj9OIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck8GFCVM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31ecdf5faaeso790522a91.0;
        Sun, 27 Jul 2025 22:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753680879; x=1754285679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k6qTA6cHT7QQtMvCxkLbKuRSVS9SJ8QTSZ6o1ZHsFO0=;
        b=ck8GFCVMDV6OkZ5aBDW/EjLIeX/V2SdYFmjrwy6giWJYKY20Po/G+ht/oFYvdjQbcJ
         jGNHenEerezga1tQOnmWrv6o8nbyLDIazKIo1Q63w3ca3JOoP7vpo5/5tFoCXv8Q+kat
         ar23ZYT/aONkWCJXERrTpQUn3D1xHb0hUaQWeoCH4FVws4vPQNbIFm0GdKBAjlca6sgV
         yyqRfc0sV/sWMlOmZyr6aK2vbzh/aWOYjahxgTJN8XHVEtaD5/ZBoF1X5UmHJvRrfdn2
         56kSQacHTmPCBGMcKP6h/RIODGLTpDDFJuBok3OWGtFqGJLsnlSbjvvWnUrEOxsphFzM
         1kQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753680879; x=1754285679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6qTA6cHT7QQtMvCxkLbKuRSVS9SJ8QTSZ6o1ZHsFO0=;
        b=Hh90XDU/+lpkY5Q0kIjsagOotpkce3pZC0DQmRmW22C8F6h2ZTOZNTematYYaz8FPz
         fIiTuTL65n+BgTOPnCP4fu67ocr0BXysJxoC7PwQfxre23ZBHfwMqoFlnHid+O4k8Tus
         wgO0YcWVrM73suETeEfEeRkSQIP/r0Zc6Dc29c8E805GtX0GVKSqyjaGjzImu5VxaFxt
         bqxxz+WguczOYghuhPZpSqShRn6T7/5pYjWfb3DCabverwwsA95a6GDGiuPPcTdoQ4sl
         NOpVCx84Nqhgqd+b15fOjzTE+HJ9K0HCt/q0FUNCFUmYSTsxC/DmmMBsnX11gtsKI/nw
         lofw==
X-Forwarded-Encrypted: i=1; AJvYcCVB+l2xrZpxiy3OBT9ewMRyCE+ZQsqW8GhFJBG9Ie4TQpv0/AUSPCBwobVapzSl5iJh1Uzd2hZe4zSMUX5m@vger.kernel.org, AJvYcCWTfG1PttMzgzq4dzU1M1HAT4HlXy7p3sjils3RndUW2z2/GmO3UTW2WigzBYzMSdlUnpVl8ysDue/z@vger.kernel.org
X-Gm-Message-State: AOJu0YzyUrnJzcTQWB7eE2HQg3pSlWyt+wTTUoEsuQgQia0d0kX/h2Os
	unbsuPLodimTy6e2uLJ+29aAfMAq3Z6Sth3RJuRbDa6mdc4CVLq3saBi
X-Gm-Gg: ASbGnctQMiKe+2PN1Cx8ocoXXBCnaa7MK9a1WdQfHBAEc2lqb25ZECIPRU6srjaf7Cg
	vsf2fqfdm5YBLwAE1xC+bu4t0HwdshAXHD7w/OhvDlnYAuPRSv4qSW+8GrEyRwftzdB/bLcr6zg
	9lKUkMWhk40znqCm0X5VO4crr9v6BF9RXLa+uwfyzzqhK4YX0RCguA/flw0zJVE6jIVNuxAjjKV
	1diY4a/AUIENAnF0U/MJ9oLXx4rzjEB3v7x7ND3EcQ7C9MonLCfM7pRS7pLT4GoIADSHXOAd6Je
	rxNB7izhpUY2TmZdZhsMWO1UTGuVyMok5k+0DMqgTnSo7fyqia3Y/ct+Haz+yxpZXpoDzWEraT/
	WSTz/y5eLP3Cfz+pDlS142AfxXad2gXQDI+JqsqcYB4ekoBi/qqND4cLOJfo8PzAoD9FXuBRNSb
	c=
X-Google-Smtp-Source: AGHT+IHvKUeJgGPP2KuVZC7MV+slZ+Jy/0LanvshipPIkk1k/Fwjh/2vrhM3ta3T+sWIO3FTVGbo3g==
X-Received: by 2002:a17:90b:57c5:b0:313:1e60:584e with SMTP id 98e67ed59e1d1-31e7788cef0mr14119890a91.9.1753680878918;
        Sun, 27 Jul 2025 22:34:38 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e663a71fbsm8559351a91.35.2025.07.27.22.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:34:38 -0700 (PDT)
Date: Sun, 27 Jul 2025 22:34:35 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v3 10/13] ARM: dts: aspeed: Add Facebook Fuji-data64
 (AST2600) Board
Message-ID: <aIcL67c4VufhfVMY@localhost.localdomain>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
 <20250723233013.142337-11-rentao.bupt@gmail.com>
 <d09667e5-992e-4ced-ae30-7a4116a72c62@lunn.ch>
 <aIGGdbIX9HaV4dB/@localhost.localdomain>
 <769d6817-ee97-4a23-b013-29bc875a00cb@lunn.ch>
 <aIMTvUyHGd/ikKY9@localhost.localdomain>
 <aIW/xEfJX/UD1kje@localhost.localdomain>
 <9897e0a4-7c70-4e27-8591-09e9d6ef2263@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9897e0a4-7c70-4e27-8591-09e9d6ef2263@lunn.ch>

On Sun, Jul 27, 2025 at 05:45:51PM +0200, Andrew Lunn wrote:
> > As I'm not 100% sure where the RX clock delay is introduced, I will drop
> > mac3 entry in v4.
> 
> Many of the hyperscalers, or the supplies to the hyperscalers keep
> hitting this. The standard policy at the moment seems to be to drop
> Ethernet support. How useful is a BMC without Ethernet?
> 
> If you all got together and talked to aspeed, apply a bit of pressure,
> it should be possible to get this mess fixed pretty quickly. And then
> you could all have working Ethernet....

Hi Andrew,

I've already reached out to Ryan and Jacky from ASPEED regarding the
topic a few weeks ago. Originally I thought MAC-side clock delay was
only needed for fixed-linked (for example, in darwin dts), but looks
like it's also impacting platforms with PHY..

Anyways I will follow up with Jacky/Ryan after addressing all the
comments for this patch series.


Thanks,

Tao

