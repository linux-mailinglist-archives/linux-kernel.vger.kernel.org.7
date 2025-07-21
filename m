Return-Path: <linux-kernel+bounces-738526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB0CB0B9A3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA96418926F9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 00:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197BF146D6A;
	Mon, 21 Jul 2025 00:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Wuki6RHE"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB3D7260A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753059080; cv=none; b=mJ388ZpJbGaf5cNiA1WVXNSvkk+hmJ/PurETwOVfT+Z5qkYOiLuzyLBXi5ppIGUvGMPBWxKJiTPPTfbkoQY6rfGmWV9loJF+G+lO3bwiHc6Pp8Ikd53GnQXeborx9fQnpTLjiR82jhQbThoSKX6UyEBXKq6AhzsgDPb0tvLxqf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753059080; c=relaxed/simple;
	bh=flz3KI+pObSKl6+JdCtMWPSPqM5U/a/duvHNej2nPwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=if/AAS5XPZbO1QH3b4CdCZbr+U/MAzJcPDQhQ8d4ArfAp1K4mYZ2WsJrO/foJicAVKX+60ll2vNR3aWbRjEfEb6BGiuhINRSdV7vkcGrNxVZ4OzGUtAOVBBlxB5Z+TuRpi9B+oqgsEXpK3yYsxfxBHzf4VYEABl8XGfEpniCgeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Wuki6RHE; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ab93f24dc3so70506611cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 17:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1753059077; x=1753663877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpYWz0hHkJ5czp6E2Ogh66jdWDkJrXo9PJQzqqTm/Fc=;
        b=Wuki6RHEfJTxiD+F6P9VAA1AmczSE7s1E/nTpYm5wXMo6RQaI/dAfBZclKatIhRU/e
         PaQUKdUzNB1sANwHNJc8vHB7Be3RN+BQf2NlQf6fiYTF2s+PM8UkFDgyFXqHF9N1GMOR
         ygIRhfnElJbHTvjFpEv/WE57CNYAaX2Qqvd2+yX+JEi7B8DqM7cZZW/FGUZuQJa3UDXG
         6ojn3XG84PX8fxjFLVJD+eWQXai8HrhrGUmiUA+SqpVANz2vzJugJgH6seHfYEoC7mhe
         cGToFNoETlcPnr0jqufQpODB9nfFSf5WXF61TCh6ZGKnT5IXGlMreHfUykz8lAkhYObz
         AYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753059077; x=1753663877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpYWz0hHkJ5czp6E2Ogh66jdWDkJrXo9PJQzqqTm/Fc=;
        b=UOiQ2xgEgK3VsdWT73fjG1QYisTeoIshBehScEBevqZiJnSfYUQZ81FBiQk7K5jPD/
         by7B6rI9oIwC1UEhJ3tke0nJGBC1W6S1s1KH6qwIhGFFZmovq5PAMyfwvneUQBXfYilm
         FgGMiRzxdSDbFAzvE+Q3h1p9qC9C+NnoGSfhGSFv3V6j63S7jGAATti84cuaRZHAzX8O
         UF1k1zhYn+4j5Vl0Lsa18gB7JS18b8aruBrH2pwMy8V2agEUz89DGv4sNMmRKUrmtDXt
         aEA/FVY8DYErmUzqpIoPT/Nf5ZJKY1QNxDDGIkScwwSg8ivOUsYelVK5enRycA1HQ/yt
         ZwBA==
X-Forwarded-Encrypted: i=1; AJvYcCXodZADET868uhLTW59B+c++XgUIVIyJmI6OpTv7aVcOqmA6FkFEDEVW+TBhnRth1FEa30JUylXQDpdz2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdnzal5WJXDi1hSU3JIWS7KLTDRh39Eznkko0LCCnoT/j1NES1
	BHaCRQ7CKJBv2IGeG1wZ/H4FKPRfR+UVGjNCBCtBrYhQ0E+I0Q4o1oOWvmhTCKezYSs=
X-Gm-Gg: ASbGncs3b4kmjAxIPtUznzWPC7pkIafxLk/nF3mQEAyfbKyxkq5LRuCsEP6RoJLx7Dx
	L2OUVCYDwFJ4Uj7jAW+rXe/An3YwknNU19pEkaXDpcT9MCJ1UdOGeVs0d3aVV5fvamdPnySrpYB
	K+XWVzFF251M5RzYr/fpM33LPRXyZI1qERZdK2vjUT0VIbd1zwptmD7BWKBXo2nujGGXRAmEOCe
	50jqmGfOQ1Xr14BTtU7/UCZ7v76dczc2JAxMHHTuPwz4iQlxDz7o19e/i8/MyEQQ0vMCsDSiTCD
	ttzd3td9O9TaWHcLU8z5tq61vEFZ47CRQgQ/G0XyLDxuHdUPCOCK9YG50fTgF16cEXYpKVDmB8J
	cBigO3EEdBrP+FUNbT/GjM3D7BngcIw1CPogrgPI0/egUgyIIGJed+RCJHcMF9AYsPzs10H7F9a
	RzvA==
X-Google-Smtp-Source: AGHT+IHJ8BDCuM0ht9jJt2VhuA48Qsrq7u0dKStcaY7gkl2qUWPyhDCmG32ZpnKotK9wXF3jPQv7ew==
X-Received: by 2002:a05:622a:1a25:b0:4ab:95a7:cf9f with SMTP id d75a77b69052e-4abb2db8e1cmr169676251cf.54.1753059076774;
        Sun, 20 Jul 2025 17:51:16 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b204cdsm35378211cf.56.2025.07.20.17.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 17:51:16 -0700 (PDT)
Date: Sun, 20 Jul 2025 20:51:14 -0400
From: Gregory Price <gourry@gourry.net>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cxl: docs/driver-api/conventions resolve conflicts
 btw CFMWS, LMH, ED
Message-ID: <aH2PAju1rLxIbXXk@gourry-fedora-PF4VCD3F>
References: <20250623152923.1048525-1-fabio.m.de.francesco@linux.intel.com>
 <1985851.b9uPGUboIS@fdefranc-mobl3>
 <aGwmFwGNmw8n9zGR@gourry-fedora-PF4VCD3F>
 <17128669.tgchFWduMW@fdefranc-mobl3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17128669.tgchFWduMW@fdefranc-mobl3>

On Thu, Jul 17, 2025 at 04:14:13PM +0200, Fabio M. De Francesco wrote:
> The table above shows a real configuration copied from an x86 platform 
> where the Low Memory Hole (LMH) starts at 2GB. 
> 
> The"HDM Decoder Base/Size" refers specifically to the CXL Endpoint 
> Decoders HPA range Base/Size. The first row of the table describes the 
> first window (CFMWS[0]), whose HPA rage base/size is 0/2GB, and the 
> Endpoint Decoder that the CXL driver should match with that CFMWS, 
> whose HPA range base/size is 0/3GB.

The only thing i ask is being more precise with decoder references.

HDM Decoder can refer to any of: root, switch, hb, or endpoint decoders.

Below you make this distinct in the explanation, but in the table it's
simply general "HDM Decoder".  All I ask is for a bit more clarity on
what decoder will contain what values to avoid further ambiguity.

> The driver expects that the Endpoint Decoders HPA ranges to be contained 
> into their corresponding Root Decoders. Furthermore, Linux fails to 
> attach Endpoint decoders to already constructed CXL Regions because of 
> the same size discrepancy issue. 
> > 
> > I think you need to describe what the expected behavior is for what linux
> > will produce in terms of the decoder objects given the above.
> >
> The expected behavior is that Linux should be able to match the Endpoint 
> Decoder with the Root Decoder range even if the CFMWS size is smaller 
> than the Decoder's, as long as the latter adheres to the 256MB * interleave 
> ways rule. Furthermore, Linux should be able to match the Endpoint decoders 
> with already constructed CXL Regions and allow the attachment process to 
> succeed. 
> 

You may also need to describe more than just the contents of the
endpoint decoder.  What would the content of any intermediate decoders
be (matching the root or matching the endpoint?).

> If this explanation suffices, I will incorporate it into the next version
> of this patch and also explain that "HDM Decoder" stands for Endpoint Decoder 
> and that the CFMWS HPA base/size describes the System Physical Address (SPA) 
> which the CXL driver uses to make Root Decoders HPA range base/size. 
> 

This explanation is better, just need a few more bits of data and I
think you're good to go.

~Gregory

