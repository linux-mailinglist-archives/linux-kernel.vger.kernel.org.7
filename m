Return-Path: <linux-kernel+bounces-877436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0BBC1E1B5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03B418839AB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1BF17B50A;
	Thu, 30 Oct 2025 02:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bovUsrHC"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6759E7E0FF
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761790593; cv=none; b=Xp9DmGxR8VVa+hOjJymIyqmXpW9KzJRnMzUjEnxzC61McT+0M9UTTM5PakQjOFo+vzOLzgeVuO3aX/dbg+jobEtT5oa7H3Q+kTdNBUXC0GhKOG4Tqy9XF9bQyIphvjewSdWDPf0FSQxMw0Fvj7Ia+5x0EyyjIQlCnMDP5ThXynQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761790593; c=relaxed/simple;
	bh=B3CAAoANZ8AdYUQ/vBMppNZHRyDpgu6a7ycm90jmpdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkGTvmMG6c7W6AqkoLPCrnqBLKd//1e1iy8QC++VMLn9wHh5hKlQ38E3rvJnM8Br0UmbVQg28z//AH4/diJWZSuHR8e+ZBVfVACGdGKk56510cp9S/oTUhCdJtRXY4sgTFFlodPpgJLEAxwAwmFI4rg2Vfv3rwfIREQ+0nOl1Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bovUsrHC; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so714839a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761790592; x=1762395392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=skyS+Cuyodx+9RItDMBTIU91z9/i7AQUnbc/OyIR+As=;
        b=bovUsrHCfGt7YGFaza8N393yO9/cWakiXQ1Q9kZ5EEo45hMl9HTWy3XRcoPlMxfL/M
         k1xDxNJAC5fZbRBAqn5VHnYlmaywN3lFR2xjyPpLDFbJOUYp4ZbEYkpZOY0J+ABlOb4o
         3aaFAWJq4e++8ayUmIZKmss8QWTdjAS/1Izxag2BJQ9fe1EoD/YZ6BKpt3PFg9qIhC+/
         syMadwLvJvgba5qk2pS1usH4JpKq2MK954XP1aVdkbmTeTNF3JPkdlRnoxHmw1WAvsZs
         zRYoc1cAAAtq+arqFC/k7p0lfbaMSVZ6lnm18UVhJKgyRnm12jfVCPD51rp4YrIQOutf
         tfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761790592; x=1762395392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skyS+Cuyodx+9RItDMBTIU91z9/i7AQUnbc/OyIR+As=;
        b=eUIxqr8TBjdXZYl7A9wEVQ83eEToxHev7OJvIDuxDAoLjojjNuGWF7AkaqkJMTpbb3
         pne5O6GScVsb1offb/am4Q0bv1mR6d36cEAdWPwcFFloXl/FRUEjsZ9X+wWBtGfwujJD
         HG+bR9n39nQ5d6vXFIo7fby7f3f1mPz5bRhtH8P9uMMD8Xg9YBdo0MgvrNb0HJigmMrt
         iJ9jAWozjYd02Up2Y8qJuUKr7RJJ5MOEBeyFODgl+/3T3agXC1KtDvkKGB9Qmjw01Noo
         wflbx2ZGw2WRlI8ILcpjdPwYUzMJuqvEJIkrz8q9136HetqnvEVfevtDJ4zg2eENGVeO
         J8mg==
X-Forwarded-Encrypted: i=1; AJvYcCWR1To4OJBSYLdlebz938IIneWgqNVojSIaoCxlw/bB7VT140InQuYK0zkA5D4E95imJMpqDmk9gMPNryE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrNSEhuhq9h7MGuGBd7sdvN80l4wfBS+qARwLQnvRzc1uVuJys
	fqCXokPFfPpMNqxmxBs4SIs28neqYzThGSO8To078xWkcbWHVSckIWWf
X-Gm-Gg: ASbGncu2WsTUMpDMhLGMkVFAuQsXiS4ik/pce4EiWaXdETFhcVASuVUBzjPzNgZaLlb
	5OlGh4Sm4ne4cNq/13CCD8q+tOHGHaX8Jlwqgrh74AnhQQNiE9RAvtjJYBJ+yJUSCfChnW+YE3p
	QJBW9w8R5F/hEklgXPy+KC9akz2xpZbO5vUQvpHruTc0jpIaen3RNx2nnAPcUafjvo03qaWHSTR
	b4CtSTF3jG1orF/pTVDmImTjkgIDeQfE7CpORJD+gVgUBOosNhPnLP1lk2mteU8DgXm7AkshxVf
	VAG6BPl3X+rMk7DHxn7MXMD7q+vJkwZF3T1+Yh9KNfyU33FyuN1gthci6yvSKtutq/oJp9kBP60
	Uehu6yh5G9CZihGvhXvDXQ9vGp7Yh1zuXsJqR647cKqSTsjukiLksCziXFEINBIqDLRWWTI3qYj
	o=
X-Google-Smtp-Source: AGHT+IFhl6dhnMtg2Ql5+VRs8APrxjowbgOu4JakifHuDRZCkhJocdr+tQp+x3ll8cCXsnDbLGKBuw==
X-Received: by 2002:a17:90b:2d8c:b0:339:ec9c:b26d with SMTP id 98e67ed59e1d1-3403a25bb3emr6580820a91.8.1761790591601;
        Wed, 29 Oct 2025 19:16:31 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34050ba1472sm580887a91.17.2025.10.29.19.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 19:16:31 -0700 (PDT)
Date: Thu, 30 Oct 2025 10:16:22 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Yixun Lan <dlan@gentoo.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4 3/3] net: stmmac: dwmac-sophgo: Add phy interface
 filter
Message-ID: <kvkmvw2a7n3zils6rx3casv7slgzvli5cwlukmixly2loju2aw@vsuigze4wgwu>
References: <20251028003858.267040-1-inochiama@gmail.com>
 <20251028003858.267040-4-inochiama@gmail.com>
 <20251030004948-GYB1549833@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030004948-GYB1549833@gentoo.org>

On Thu, Oct 30, 2025 at 08:49:48AM +0800, Yixun Lan wrote:
> Hi Inochi,
> 
> On 08:38 Tue 28 Oct     , Inochi Amaoto wrote:
> > As the SG2042 has an internal rx delay, the delay should be removed
> > when initializing the mac, otherwise the phy will be misconfigurated.
> > 
> > Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Tested-by: Han Gao <rabenda.cn@gmail.com>
> > ---
> ...
> > +static struct sophgo_dwmac_data sg2042_dwmac_data = {
> > +	.has_internal_rx_delay = true,
> > +};
> > +
> you forget to address in this version? see
> https://lore.kernel.org/all/ljyivijlhvrendlslvpo4b7rycclt5pheipegx3fwz3fksn4cn@fgpzyhr2j4gi/
> 

Yeah, that's right, it seems like I have forgot too much things.....

Regards,
Inochi

