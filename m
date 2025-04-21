Return-Path: <linux-kernel+bounces-612767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C8CA953A7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 17:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5049D172653
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 15:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D0C1DF98B;
	Mon, 21 Apr 2025 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VBManInV"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FAF1DEFE0
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745250043; cv=none; b=EK6Imbby35zL/tY0eR9GAbyysUX+Af4lXAy6de9GOzzIBi/M1b3isC/c7FOrMQgh9RSSQMsyl65XnsfZ8lyPXyQbzLRjqSe56nwjOgg+daipvQChN9VOctDUki6MQoMYr/6UZlHNxqQlZOlYTkUN0JRCUz7EQ4EjHEeAPvpy7LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745250043; c=relaxed/simple;
	bh=IiLvJJ37OTQQUEiR3EROW1nZchaoEUdT0B+nDMa1kMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFKcvLEIKU+4QE2sH9YYV3hTy0AmfmO8VeLVRanNNujWiI9Bj3T+7iLfvI3hHCaQQPdz+c4I8BKkgojkTIG/CIqcmo1fl2aQblugVUpe6MxUXo1rwPTEfk+l3yCIvSwDof0Aa7e2Ujhj3EV7uDlu+pIKTJMKkhCG12RU45SPpis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VBManInV; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47ae894e9b7so67046821cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 08:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745250040; x=1745854840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TvgLfiKKsaR0lvedRaSvPBJ6EaaTxZxcc606nli4GKY=;
        b=VBManInVGgjS9RJf0VPXK9x5oqG47AKKu2FjsYGYrdTUuiL7ETexopi/yK6WDwkHOu
         IjMELVEhevkcsRSqxYkoDj1/UwAMqv7dLWESKP+a+HwBQOdknhHHieiWqMHJYuEl7/Cb
         qsJfR6KoIVLZ4KULHww+f/T4+EADGSuYpe50l3dIxxKm0IUSi/yWHsxY/z/SpT+2b+XI
         Nd1Rv99KotFedSlz4Yle+aIDdj1eu2o2Ugi99+fsKSXwp27IM5xQ9rCJMRBTb+veHfFG
         JN4XRfhKNS/rgenO44U29egdQLOTxpZpHD0REtJ6RXMgiSpbS7ODy/+PUjUDawp3v49R
         K/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745250040; x=1745854840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvgLfiKKsaR0lvedRaSvPBJ6EaaTxZxcc606nli4GKY=;
        b=wSLVeeKSXjY7ni9S7D2TllY122zlG9+qkXOGRONnQoB5k0y02gk15y23IdFmbwe5XO
         7t1uPev7VarkmGJGu8ZtN+W+H0T/D+yp/XD546YUlzjH11xrZh8dncAGFj7C9ad9swRr
         t8eF612tw62Azf3STmCQ3PETySpUW3yq1TTaeknPaXfDrLB5Ub/9UXiNK/0iMtI7cKtg
         1PbSIWo5ose/1ro1JFnOaEv7mv0ZXPCrrxUXWvxLNxkH/rQtGKzDEQ8Do2PDLZ3dvvOf
         HUb/gy8OfoLAEyl2Ce7/8AeOzRWEQrtjq6m12mOLzOuxTVSUdBtzy4KVQT8dDEFAwPkY
         Q/4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYkR2ITZsrwtUf1i9exjEnmWreg0xUfhelbYb4arUxUKemyDrZOn4VSCJq4OK5VturTluGM0//CEZWLoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYwRpjjgBe2/lgc0dhoCFw62v/u+b66JnzxBqogHhxwA7DAnma
	T3ARPyOLfK4H1J4mxPGuyrqnTr2I4qDq4FwIm8VQBaQndi1wxFknDiG2iwd0gSw=
X-Gm-Gg: ASbGnctXMn4rg3zLUwukYjTGR5/j/UZBf31AkJkUiWW5hqKQh/1yC3nWcVfXpPtxa3C
	Rx/gxa1NPSTHziX14qtUDjL51W1FqP+P8gIq3MEXh2JX2x9OiBpPCwBBhTnzrwVWuyxLUVNVyT8
	tU1iz3ZLeQ85/VNzJpsAztxvQhFeMD1+7HAgF/ENIjHSyHu9b3LeXKQ6vxZPaxhRptnrkm6H+9q
	5iDybHAYlApG6nspVnsWYHBd4hdWx+QSRfjxkDcm1eiVgFqMOX47pjNlvjd187zZk110ePoyw0d
	cIwK+6OJOChw8DIzjNpRCTUyWW6wejemyY8NeoFNe0v19nzmcjGGwDTKCAxYzaNM0Eh0Cnlaigq
	aXdFJe5CHacG8/25pZcym7+s=
X-Google-Smtp-Source: AGHT+IEriEJEZS0gOlBzm+PXLfyxKYQEYEx/1ljqMJSy+Pa69NFaoSuShDtmGBW3KaG5XQ9x3mdyhg==
X-Received: by 2002:a05:622a:589:b0:476:8e88:6632 with SMTP id d75a77b69052e-47aec3cc09amr192130171cf.29.1745250040134;
        Mon, 21 Apr 2025 08:40:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c3b4b9sm43366401cf.18.2025.04.21.08.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 08:40:39 -0700 (PDT)
Date: Mon, 21 Apr 2025 11:40:37 -0400
From: Gregory Price <gourry@gourry.net>
To: Li Ming <ming.li@zohomail.com>
Cc: Purva Yeshi <purvayeshi550@gmail.com>, huang.ying.caritas@gmail.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH] cxl: core: Initialize eiw and eig to fix potential
 uninitialized use
Message-ID: <aAZm9eVsEnQvDvrD@gourry-fedora-PF4VCD3F>
References: <20250419203530.45594-1-purvayeshi550@gmail.com>
 <3b412741-4fda-4285-b1bb-80c89f0fcf38@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b412741-4fda-4285-b1bb-80c89f0fcf38@zohomail.com>

On Sun, Apr 20, 2025 at 06:43:37PM +0800, Li Ming wrote:
> On 4/20/2025 4:35 AM, Purva Yeshi wrote:
> > Fix Smatch-detected issue:
> >
> > drivers/cxl/core/region.c:1292 check_interleave_cap()
> > error: uninitialized symbol 'eiw'.
> > drivers/cxl/core/region.c:1297 check_interleave_cap()
> > error: uninitialized symbol 'eig'.
> > drivers/cxl/core/region.c:1299 check_interleave_cap()
> > error: uninitialized symbol 'eig'.
> >
> > Smatch reports possible uninitialized usage of these variables if
> > the helper functions ways_to_eiw() or granularity_to_eig() fail to
> > assign values under certain conditions.
> >
> > Initialize the eiw and eig variables to zero when they are declared
> > in check_interleave_cap() to prevent potential use of uninitialized
> > values.
> 
> I also met them during checking cxl drivers code with code inspection tools. But they are not real issues, because both iw and ig are checked before calling check_interleave_cap(). That means check_interleave_cap() will always get a eiw and a eig correctly.
> 
> they are checked in cxl_port_setup_targets() in auto-assembly case, otherwise checked in interleave_ways_store() and interleave_guranularity_store().
>

unlikely, but things can change and if we know about this now we should
just fix it to avoid someone tripping over it in the future

~Gregory

