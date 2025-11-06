Return-Path: <linux-kernel+bounces-889249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DE4C3D114
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 980774E307A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E185348895;
	Thu,  6 Nov 2025 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QVQHL3Wx"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468E230F931
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762453457; cv=none; b=U0dl7x6qZawLuu27lFaNFKg5wvn9YUAUwUCzM/rC1rhk6NAquE/6oBGCKX89nI/pHKfL4ZC/DiDdBsK1yJS+UrR3KeAb3u6TMebkdZl6Wll1Ijy+PFShrsERqSo2PBr+aMUtkud600g4jJyqqgyZn4TUekjV6xnwFBp6z28AC38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762453457; c=relaxed/simple;
	bh=I+PMnAnId/4alYkZ2SH222g5oD7TTN8EQAKDuQUrfGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFOKaBNMFNMrxV0biGPILPEwheB0dW+gAbQPrMHxLe+6VPY76lAccCaE3KBdMzSGBFOyttYPLr0zYS20MYWJVMg8L5+XQefy5ISDkjrjyDWP0Z7Tu0JypXuw2PLGQwIUmE2nS0daktXPwU0cPCQUsgkDu4TxQBkDq67x7bkoul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QVQHL3Wx; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88059c28da1so15154126d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762453455; x=1763058255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+DhYqio1jPiAJ5YPea6WrbT/ecqDZeUIacRpFP6YnUE=;
        b=QVQHL3Wx9FflcHjGKPQ6GEldmfygZI7gZjm2RBoxNH1/5HroRA4qTedo8Ub7hRqUps
         7dPW1sQtXbGICkoF+VdLzh+ofEtXXxm7y4hohdzlWlhqHwMNJpiivmskD8ugq/nlknMy
         lCIX+8I7sfxU1pO/yKOGvRgemWXAs9BJP1taV3UdwrIWj+wsysPTzabjQdj9DMx6tMrW
         gN/Exh6+jAIekeXZSKpv8q7Qx9PvKdPpvaPmYPn1pz++ieBSexw9Weya+pAGsBdiP4tL
         Z78CxQTtRio4FWemCY+u1LF1lBoZ3aakC0zkjpmWsaqlra7ZKpnVYlufrN5zCxuDGVYD
         sKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762453455; x=1763058255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DhYqio1jPiAJ5YPea6WrbT/ecqDZeUIacRpFP6YnUE=;
        b=KLuxHu+24HYrLCy7+DyCDx/vgLP7WtfTHREbxA34kNyUDEW3CmEErvvAhwG/yG/VQv
         7fpak04+Fu6y3rglPn4kXcDNrbaIuGlJSwXWXfvqLR88kRIojMorC+fSW0H/QswM4ovP
         jbO5wPWFMDSqaIzfp6fwwO9DKlr4fwSBayYK6aq8qI9Hf0VRHWSGYgDgr3rfjOGsoDUQ
         Ygi32w0K5DGGj/v3pP7LodnHRXI2YjMZLiUJUt4BcKPYR/6/UV2W0Of9wtN1KpCHhZcU
         c3977FTCa4Aw4n/4/FUgGKDYMO7FHvrkxyzpzyhJQbiXEQJsPtzHmJPg9STDTEilfEcU
         zC+w==
X-Forwarded-Encrypted: i=1; AJvYcCX0ZTP2C1fA1Lv87KgszuTjk277WScxmr5iN4P4youQyLi6i7Jt4UiVCJm9eLepHbL2lsMYWy1wnTWQeK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUCxft8LlrLR0MsbJhVJZmG5N6hPnfd5P6jQo3O0tfn2Bkr9Tu
	A0n42GmkXzqLg7cfnTmE2CxdPvhcm4tM+jC+5yXjUW+Omf8kzvO09M3jHF3CvvzFcEY=
X-Gm-Gg: ASbGnctC2cr756jiUNm5ykQ6alV2tQ/b61CeqXCFoca8tclIBqaGoqZxP98S39iqkwW
	QMldjWRro4LW+xmLvWxe9xByFNkH7C5FulS9/eXmM6zN54uNLUAXa+u2Z/bhBWq+b+XK0yczcXQ
	ldE8g6oRjEFaugfeQRl3EDj7vxm+0yh1sa0dECY3o67hhmGDTBAufFctR8qz87kiQQstS8YI+2I
	9ZHuqNvRGsaAB4En1TTSZs8H+96P8d6iBE4vAUP6wHpbEESQ7y0t9gkeJpJotd+ZE0mj1n+LHAf
	7iwaZuE4mfN+CRoswZh3OrbriVibjH7FvHrMXr8FlKkORSnJxOSuam85k171INs3poThZd+ubSl
	9swGKu/2MmXGpF8NTeLN7MiDhkE+8Oi6rF9mqVBtLLbQ96eI9/eg8n1lWbuC/2x1Gqtlk+TXspp
	jN0+HZltKEqefYsbqweLl/vrVHkt3BN8pcRgdBRoc9fMyKNg7Mt3oehPC0aYM=
X-Google-Smtp-Source: AGHT+IEJbh7T8K3ZC6AAJXZQCu8MCrm6YwZlCjie8EYnkSpY9hGIyoAmakIzFplNDN08Jy63W9bbyg==
X-Received: by 2002:a05:6214:2469:b0:880:58ac:be6f with SMTP id 6a1803df08f44-8817673f54emr8035816d6.35.1762453455139;
        Thu, 06 Nov 2025 10:24:15 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828c4570sm25286656d6.10.2025.11.06.10.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:24:14 -0800 (PST)
Date: Thu, 6 Nov 2025 13:24:12 -0500
From: Gregory Price <gourry@gourry.net>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Nathan Fontenot <nathan.fontenot@amd.com>,
	"Koralahalli Channabasappa, Smita" <Smita.KoralahalliChannabasappa@amd.com>,
	"Bowman, Terry" <terry.bowman@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	Robert Richter <rrichter@amd.com>, Fan Ni <fan.ni@samsung.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] CXL/ACPI: Remove overlapping Soft Reserved regions before
 adding CFMW resources
Message-ID: <aQznzIP6h5NibJM6@gourry-fedora-PF4VCD3F>
References: <ad410c59-bf0f-47ae-aa65-c0d845e6f264@fujitsu.com>
 <2296acdf-de5d-4591-a165-d59f9f432dee@amd.com>
 <e545b630-1a89-40b1-996c-c843a9e8fad7@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e545b630-1a89-40b1-996c-c843a9e8fad7@fujitsu.com>

On Fri, Jul 11, 2025 at 05:34:27AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 11/07/2025 05:15, Nathan Fontenot wrote:
> In this case(with your V4 patch), we would see:
> ```
> 5d0000000-6cfffffff : CXL Window 0
>    5d0000000-6cfffffff : region0
> ```
> Actually, it cannot be consumed by the hmem/dax_hmem neither.
> 
> This made me realize that my current idea ignores the case of CXL_ACPI=y && CXL_REGION=n. I quickly tested it(I will take a deeper look later):
> 
> After the OS boots, we can see this resource. Can anyone tell me how to create the corresponding dax_region? Because I tried using dax create-device without success.
> ```
> 5d0000000-6cfffffff : CXL Window 0
>    5d0000000-6cfffffff : Soft Reserved
> ```
> 

with CXL_REGION=n you cannot create the dax region.

region0 --creates-> dax_region0 --creates-> dax0

all you've done here by setting CXL_REGION=N is break the probe chain
but otherwise successfully attributed the memory to the CXL driver.

~Gregory

