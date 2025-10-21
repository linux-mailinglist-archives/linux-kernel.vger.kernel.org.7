Return-Path: <linux-kernel+bounces-862527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E56BF587D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B1D40246B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE402E54DB;
	Tue, 21 Oct 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeANKKqw"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419242580FF
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039317; cv=none; b=qUfcr2dhdSpqIR+udbq0SsFQImDXTzBZ7Y/WE9p4nHGj3bFzHy8C2hv+H252vu8ssBk6DuMjeVm6abvIWWE/mskV6vL/ihjGskmhHEuXCsDJOJUeYNf6J88cNeEYG82WGXK03+uFwNbXyZfJ1LZestAPuUmgxoxbXciHgdt3ox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039317; c=relaxed/simple;
	bh=bcpL8irMMM+I6nfVnxAplLJBqbQTjzwjMcmHCIsz5gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3d18priNdp07TqkwaKRz+74+my/yE9hfQ2Zrgr7dsuq1lsq4ZxGbMaSV9IfYw8z6bgT6XkWpjTGXmklypgWfCpDCGITnwf5qtErK8nLdqqLQ4sFiuAV/6mNVs9oBf6GrLwu+F7yrSyKbqIVoCkSIAuJkOVevw6EbMZ5B8UDQCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeANKKqw; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-780fc3b181aso3009564b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761039316; x=1761644116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xdLn1ynyVPZ4dxUpr8ekiQALFxRstWPAZs5IYw4es7s=;
        b=jeANKKqwyH/aCH+y7EL0NjMWQg7wZwMmDu5kYZBYPSXHo170Xpevbq8OppdFAyhuGV
         +l+vgjAaG+0tMUsip0A+iu5ZMywWpWaI4gfTxmfz5ZaQX4VcWC8qazsLQ7YlzQQnHf+J
         F/rnKHA7yVY2AO0XRi0UyAO1nBCRa2GJ5CfHnPamxWqEV4z2L691lVg7UwukSYfSJkyx
         /5jIb7b5YSqZvlw3hn8VBBiQT1n8LSi+ToGArxDwciBxBc5rQZbp+s+thH5XYeIe9FqL
         91sLYaVEsjIj0OVpk6ux+ecYZe/A45IK6VYkdGWYpYEVE57CTjCmv6JjcN66Sygt9e1+
         MN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761039316; x=1761644116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdLn1ynyVPZ4dxUpr8ekiQALFxRstWPAZs5IYw4es7s=;
        b=LSEXvuAFJI5uYIEB/5rA21fkfunetbipopQVswTZ5dNvaPwk/yeYdzi7SQHknb4QsX
         JEtZhPMT64NnDPUx6YW3QEegoFDhy+A+CVtW0eAr/1Y1dbFW041SN3WjTxaZcIVYlsqz
         icwreMERqW36Ezmxg3dS8UvHI7Xf6ean/pyf7I2+wT+J/h63isxPJOJzgYHoqj+7ROrq
         8swFHyr8vNCHNuTLz801LCru25GldhR2TKkwsm/pIh6PHrmaICDhLZfqpubvc0jTxv9h
         Id/Q+XiMU8JJahCjLLbZvGmtcvTmiTquswhFuaH35VPcyHnYQrPpMMkQ7UsiTWlB0ChM
         IAdg==
X-Forwarded-Encrypted: i=1; AJvYcCWCI+08xrlp/i1oNFj0o1qn0XF3Hzl1dfY/+s5A7rNs0jxbdUN0hABRpCwKXSUwuipXQ6sUI5C4OGrbqL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDZfX0bTDO9h53S06CYD+XJMySeEBHZE0I0vK+czWnHIuavy9M
	j267kDZwFal+fdMuclODrdWuI7im6xXQ7s1SdMHxNBbntBVTlTMnZFwm
X-Gm-Gg: ASbGnctYyNkAk1T7e81jaWBOaUXKL56RzMfp+nee2ZNxAeb8l6bz0lTjO/SGrIQ2N9G
	wSPXghWDOKjaHdizfgQetbnMrlS4GjHbBOlOZXXS2Mn59AbBOdwi4Sj1RYm3Zq1gAEk4fWKuaFt
	4u5RMaxj1gN7ITzGGcjRCz/X+Ci7FdRcar2OWef84Mv8qaRnWkr1dzTE4BA2jfVs+RN1mvLMKSj
	zOYTY/arsecog3k25jvusTanVfU0ke1mgmcpjnlQjW0ib5EImRSlkrAsbv3+teNmkfDq8vAKl79
	iB2AoYZ6MlqPXbZWzVV+QOg82+Adqdkqlt5qWqi1mh9AgwpdlZyyAFm6OB1eLWRUPBXDFyOkxcB
	2OIJWjA8QXstY19XQKqlkqcv0GbMX+22rUMxzB5RrW2p0AoKksMBSdxrNjJT5XKwk80ifouqnK5
	SCmzS3/s7MoF4=
X-Google-Smtp-Source: AGHT+IGFkWwUhKlvX3wjqRF8Ewtzj69yE0Ksx7a5SqOmni4nW94Y4t7Udab8ZYZ89rvlIzREH0Iieg==
X-Received: by 2002:a05:6a21:328a:b0:334:a1bb:5898 with SMTP id adf61e73a8af0-334a8621674mr21770370637.40.1761039315601;
        Tue, 21 Oct 2025 02:35:15 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a764508b0sm9918642a12.0.2025.10.21.02.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:35:14 -0700 (PDT)
Date: Tue, 21 Oct 2025 17:35:12 +0800
From: Longbin Li <looong.bin@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Ze Huang <huangze@whut.edu.cn>, devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/3] riscv: sophgo: add top syscon device for cv18xx
Message-ID: <c2b4zfjfqqorku2oznpwhvk4mwfwv4sypv5qxi2pk4xsxknhnz@o6euptpneeqk>
References: <20251020083838.67522-1-looong.bin@gmail.com>
 <62bb4f8d-ffbb-4529-ab0a-70fd8c77078d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62bb4f8d-ffbb-4529-ab0a-70fd8c77078d@kernel.org>

On Mon, Oct 20, 2025 at 12:04:06PM +0200, Krzysztof Kozlowski wrote:
> On 20/10/2025 10:38, Longbin Li wrote:
> > Add top syscon device bindings related DTS change for CV1800.
> > 
> > ---
> > 
> > Changes in v2:
> > 
> >   - Add ranges property.
> >   - Use proper regex in patternProperties.
> >   - Add complete example including child nodes.
> > 
> > Changes in v1:
> > 
> >   - https://lore.kernel.org/all/20251012022555.6240-1-looong.bin@gmail.com/
> > 
> > Changed by RFC:
> > 
> >   - https://lore.kernel.org/all/20250611082452.1218817-1-inochiama@gmail.com/
> 
> 
> So this is v3, not v2. We do not count from 0, -1 or -2 (of you have
> three RFCs). Please start using b4, so you will get it right. Otherwise
> how can we compare versions between v1 and RFC? Try yourself with `b4 diff`.
> 
> Best regards,
> Krzysztof

Sorry about that, I will fix it next commit. Thanks!

