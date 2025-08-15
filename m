Return-Path: <linux-kernel+bounces-770248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FC8B278F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593643B740F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E99F21FF58;
	Fri, 15 Aug 2025 06:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OirAeXRJ"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2265A31985B;
	Fri, 15 Aug 2025 06:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238636; cv=none; b=WvWbZWH2Gzgz5Ny2+BNsn2UFlufobTHyUe6OHuAO+a5C5+ovdLDraQXdcuqm38V1j8K8Nd7ta0gIhl3L3IK+O2AIjLp6LQyTBakx7UPHRulLaJlqULre4Ihxttn7EKzXEUe7gXcN+nDhp4nUCoYzpDMeAf1IBvfNlWlhif7saXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238636; c=relaxed/simple;
	bh=/KDEoxlZvjb0Z6uihzeAzpeqr0RhkGZsDZFZiSKbGcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5wbuw6hIO67W6RFIIsf4aQzoXn1hwT1zZKlzz1FV4GORaBCebs+oHPABzZRI2iPhB0SCF+5W9qJ4CiEZLXqd4wuLv2z0ITlOvdCD+YsKLOQVgfm0Y/6zZyP94WUJsV72fUg5hkeqLGXwUnrTtFWhSRVouJTVU9Zxc1Nl3PZo+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OirAeXRJ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326789e06so1527006a91.1;
        Thu, 14 Aug 2025 23:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755238634; x=1755843434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kGmhR3eE/KutZ5tTndwU0D7V2yrLWDVr0mRfiGse/PY=;
        b=OirAeXRJOAmySlXhv0fyxr3CNZtYz3E2/eKL6YmUy7DooNguRDSRAEp1OWqyIBWZyQ
         aQ1w7ntzJ7yVvQ1B+unmzFCB+d5/2K/ptXMLO0z6fLregbaMp6Z63HKpzYLbxnqSmMwd
         EwkK4SvGqMuZLkzYrCXqDGn1wmVt0tz1CB9LdBd032EUc2HxLdbbR8GHPe96S1dN6fhs
         DtNYPFB5NP0IJOJ7KbOny6tMOj9mo6bl9tnpbf9vCOhjq2rAI0L4/+bvsL9N0e3nnyTf
         IiNzsr9f8JGpDJRmmy6Zd+9ptwHzS0IhhZnf4IRrZzC/0HkJ/zRx/v9saenMk+fFTO4b
         HHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755238634; x=1755843434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGmhR3eE/KutZ5tTndwU0D7V2yrLWDVr0mRfiGse/PY=;
        b=IG1u0E6QTbMaeGTIs8hy9Gb2ei/TcsNItN5ZXJuhMu/bjloztg07X3LrxLolBKRGhI
         zqT1ajbAn2EKYt9Tr7MoQckh2jiqud8Stb01NOARAoAJipyppy9RXs1dCU+TtAw4jJjO
         N3bvDs7alux6xvvcXteTbfHLeWIny+KuB2Budh1df6jjtR2lpjlfK5VCiDQyN2xTzZ0a
         RKpFrEM7KwAynZRBoIP5wke+R1/B2YuKyc9kyCoKnapT5caZRkAIn29U5UAM5GhZfLPm
         MBXlpqmHsZgLm0OiWUMx78pAqTTgI7vwb2gVLVuOlnkn0d4uSOIkvGmxRpIVt2X6c1Gf
         vvHA==
X-Forwarded-Encrypted: i=1; AJvYcCWLXy74dz1bJ6ks0smYLrJZKZstER6Sed50Av/Vukk0dhxHe0q5NORrIW91IbeV4LZDQT6CJT1j8yA14r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRPbWYj+fmBhYYCC75wldBqpQhnO6vsMPkEQxGftiNY7NAILXO
	I3AfRQ1jGS619R6RnkVuca2w12dPq0yyRSmAPnVB2pNlspXztfiKryHH
X-Gm-Gg: ASbGnctwN+vbIr2mDib8w++3IQW7ZtuPiUAj7ehP1wk6hTzVZzzVOP8YyJHvhxpSrR8
	kV4nda8WyT4FnQaFSgMt5/jbd1lcBQRcgTnVkMyFQzGYRBLrLaSQiOrids1nN8ZuFP9snTyi5VM
	NyIkJBs1Ps7x3uQr2tNk17vHgqjHgFiuVt373jHG9+aVWhidjeR2oprd63cVpKdExfoSLi8rTeP
	5/57Vq8cPvs87K5jpJ0cujcmpSd/kEBd40CLHD91uAw0E6Q1mYzbFmvV1qo/62ptRHTg+P2ldr5
	Ono2QlKuDoHtQSHM/uj60H31y8cvKulSL1aV4USFt6j2jl0kEYZeXLim2epBL9lKc98poKijwjO
	SuglIjq2TL6gxoL8Q+aLYjQ==
X-Google-Smtp-Source: AGHT+IF70Lheb7c+uHnvLNkSjmCuMaFdEeN3otVkmRbjbDz4XiK8jFRLMEOf5LsZb4VaMWosSsczoA==
X-Received: by 2002:a17:90b:134f:b0:311:ed2:b758 with SMTP id 98e67ed59e1d1-32341ea22a7mr1402947a91.3.1755238634028;
        Thu, 14 Aug 2025 23:17:14 -0700 (PDT)
Received: from localhost ([2001:250:5800:1000::968a])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b472d5a6df6sm433532a12.1.2025.08.14.23.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:17:13 -0700 (PDT)
Date: Fri, 15 Aug 2025 14:17:10 +0800
From: Zixian Zeng <sycamoremoon376@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Han Gao <rabenda.cn@gmail.com>
Subject: Re: [PATCH 4/4] riscv: dts: sophgo: Enable SPI NOR node for
 SG2042_EVB_V2
Message-ID: <aJ7Q5tQ3oa8DBpfO@calculate>
References: <20250813-sfg-spidts-v1-0-99b7e2be89d9@gmail.com>
 <20250813-sfg-spidts-v1-4-99b7e2be89d9@gmail.com>
 <MAUPR01MB11072CB6BD1EC94B752AA1F8BFE34A@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MAUPR01MB11072CB6BD1EC94B752AA1F8BFE34A@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>

On Fri, Aug 15, 2025 at 11:56:22AM +0800, Chen Wang wrote:
> 
> On 8/13/2025 4:33 PM, Zixian Zeng wrote:
> > Enable SPI NOR node for SG2042_EVB_V2 device tree
> >
> > Signed-off-by: Han Gao <rabenda.cn@gmail.com>
> > Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> > ---
> >   arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts b/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
> > index 46980e41b886ce17dacce791fa5f2cef14cfa214..7001d8ffdc3e04c5a5cd5da85a4fb1c0351eb9a5 100644
> > --- a/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
> > +++ b/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
> > @@ -226,6 +226,18 @@ &sd {
> >   	status = "okay";
> >   };
> >   
> > +&spifmc1 {
> > +	status = "okay";
> > +
> > +	flash@0 {
> > +		compatible = "jedec,spi-nor";
> > +		reg = <0>;
> > +		spi-max-frequency = <100000000>;
> > +		spi-tx-bus-width = <4>;
> > +		spi-rx-bus-width = <4>;
> > +	};
> > +};
> > +
> 
> Only spifmc1 on EVB_V2? What about spifmc0?
> 
Yes, EVB_V2 has only one spifmc1.
I have checked schematics which can be opened by OrCAD:
https://github.com/sophgo/sophgo-hardware/blob/master/SG2042/SG2042-x4-EVB/sch/SG2042_EVB_V2_20230302A_BOM.DSN
https://github.com/sophgo/sophgo-hardware/blob/master/SG2042/SG2042-x8-EVB/SG2042_EVB_V11_20220902_BOM.DSN

For your convenience, I have exported them to PDF:
https://github.com/sycamoremoon/linux-riscv/tree/schematic
> Otherwise:
> 
> Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Thanks for your reviewing.

Best Regards,
Zixian

