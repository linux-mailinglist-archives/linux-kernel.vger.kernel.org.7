Return-Path: <linux-kernel+bounces-858902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B78BEC2F3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82281AA5C14
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A8719F41C;
	Sat, 18 Oct 2025 00:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQxJ6I25"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906EA27462
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748179; cv=none; b=oHSJ0lwent8/xM9c6KF5H0Gb/hhuwxc++aowTXdwtymUkXN7+0J3YOUWZG/a6ZORIRjIlFGCWGpLX/L1uE/s8uwNh5+ZWcWx0k7abOF6f0OPFP81NG0hZ8TFpJvOey2UHGHU+vLXSkcPPFQPTvs5YG2vN49E88X2qYahoJoIwkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748179; c=relaxed/simple;
	bh=s243szStB9pBK3RcKWUDI2cHVqPoJDVQfeeUTlKRVJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2kv7BZBdKV7zXBLfynxGqBAqngPvmlM3yWlv5bVbhat/4STvE4GWl/um8QRV3ApgZCKEfYEv3h1/16WMNK5DLC7FlatGL4qov2/3BIgSo0Qf+pzfWgIGClW5jCC0thBQHhMgWclhnF+8aRBw7ul5f+xam5/8+E8Q7JHPDs5PUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQxJ6I25; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6a0a7f3a47so2213294a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760748178; x=1761352978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1PWNtFrwP/oSzLfkwsnt+/gfiH1RiWv5c2UepBm6CR8=;
        b=WQxJ6I25DGOUh4V+b3IPhLQX6bTDH3fpPiasJd58lEW8xM8Jk34p24qEKeMFoV9h/e
         3pgXqTSUKAWaMX69fAMhIk+g3yGfTAQI1VZCwnjUmXbmWAMnTpTbk9Kb7wNrYEFRCXLa
         6kcobJX25r4NJOEh14MUCpViMUOJd1tWpCEDxHoCoCUhN79swf5ylKWOkEzhkXCNsPfP
         J4lYWoF1v1AnqpDZT0rIqHZRt2ZWcM4L/PLtTTKJyG9pA02dbO6J8sIUXv8XxlRGFHbJ
         R/mZKkE37mLMxx7U99z/D5BQsO11pkUCUMp9plBUD6FHnHGIHfxbe2VXyCRndKwU7/Tx
         3Cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760748178; x=1761352978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PWNtFrwP/oSzLfkwsnt+/gfiH1RiWv5c2UepBm6CR8=;
        b=tKAaBt6mFF2tyMJvqErY9OILLAubYKw7AATZTOImxZ+03u2N58VtLcEK/x2GLVtpDm
         gromR3Gl8ZCXZeKAa7z6cEjHwbQlijGh6+dmcsD+Y0NWgoyKHpJKjMyMHlZxiu5xbfCS
         akAhXaOWASNuPoppbiNgUgc0ffX2jGeH6XLhSPdI4qnsRlGkIf9TZ1/feS8p50TPsKSF
         a6crn74lUr3VKjUeFjQb9G2jTiCAw2ZF12HiVT0cRzhkeI3iby5Wi4OMlI0vYlsu/98j
         WZiQfOxap/7MJt2ecjHhdhE+LQDjmqiUq2Vc3Dwt13/fHUOsJklK7fTcnbEyX7bFaOHv
         YNZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJiyiNdQvrzU1USUAjcZ2Wye/H0ddeO8yQMLRiwIH6b8k2TuguNuSeVDv9AVYzHX12sWWVM4sj3mcNMp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+A7KDb+4JjCRfN11YNskNabLJSOgc0a45o43edBtfuwMKKioE
	243BG55bCtJEQxzbTSbNFYp3WReAxQVEbnFGc35H+QnkcDx9DpF3nBn8
X-Gm-Gg: ASbGncv2CdXLSNAPUs4zHGq2kH/5yrQqSvlCbYEeDYrs8PgJvIvFzGfOSq1TwugRffQ
	GM/miP+TxwrnfORaRdhyE+k/Rsg052/8StmZOObt4gpDFFXl1HdIOd/YxvKA72l8Ia8vCl41z1M
	5BVCnAt/iy0wE2FDg0Wf9d63hm0tTM1tCAZIoluKC2lB/HPbHAkSorUPGvOy6TpStoTtGakUfdQ
	mhzkuZrNQ9tr5SG8X1u4SJL/SjlGKmkKNFG8lcBfX4X+kMM4nYJsQuHWg/HvLyBEmYCuHuZpAvy
	SYFL50q+8WNzYpo7IblnLQDjeKLB6hzQrn/HR34OpWqlmMX+FxOwgxOowUildR8oCJMke4hx4Aa
	wjYEbPDkL/2opNcYQZL8tUuGGw4sKlmjVLVZvzgXFVauMFyPZapdd/ZARUBsBAyI1k1QdmQFcID
	k=
X-Google-Smtp-Source: AGHT+IHk6GRhreHj//S6E+ILpNLEY2kapbyNg9O/WZnXJ0JV/NPB8zjD9Ghulw354rOmUlzfDrJAcA==
X-Received: by 2002:a17:903:1746:b0:269:a4ed:13c9 with SMTP id d9443c01a7336-290caf85146mr63860745ad.30.1760748177829;
        Fri, 17 Oct 2025 17:42:57 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5874sm7975275ad.54.2025.10.17.17.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 17:42:57 -0700 (PDT)
Date: Sat, 18 Oct 2025 08:42:07 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>, netdev@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] net: stmmac: dwmac-sophgo: Add phy interface filter
Message-ID: <i5prc7y4fxt3krghgvs7buyfkwwulxnsc2oagbwdjx4tbqjqls@fx4nkkyz6tdt>
References: <20251017011802.523140-1-inochiama@gmail.com>
 <34fcc4cd-cd3d-418a-8d06-7426d2514dee@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34fcc4cd-cd3d-418a-8d06-7426d2514dee@lunn.ch>

On Fri, Oct 17, 2025 at 08:16:17PM +0200, Andrew Lunn wrote:
> On Fri, Oct 17, 2025 at 09:18:01AM +0800, Inochi Amaoto wrote:
> > As the SG2042 has an internal rx delay, the delay should be remove
> > when init the mac, otherwise the phy will be misconfigurated.
> 
> Are there any in tree DT blobs using invalid phy-modes? In theory,
> they should not work, but sometimes there is other magic going on. I
> just want to make sure this is not going to cause a regression.
> 

I see no SG2042 board using invalid phy-modes. Only rgmii-id is used,
which is vaild.

> Also, does the DT binding document list the valid phy-modes?
> 

It does not list. Is it better for me to add a list for it?

Regards,
Inochi

