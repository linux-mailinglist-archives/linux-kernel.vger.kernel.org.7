Return-Path: <linux-kernel+bounces-889250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69033C3D120
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D036B1886B4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E6034A774;
	Thu,  6 Nov 2025 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ja7dRWoI"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB0276051
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762453551; cv=none; b=O7qxaXvSD/H+nyyAmzkXgj6IQGwWzX3XSkCN/PLDKqvO1dvgk3ZTlZT+k06kE56As7ioabfJXW2GvaN/TLR8y5XU5R03/zjuHqALxCn79hThIh+xYZMl80fiIAxI4EBaCRCbUkwl8JM6VUH5Kn5ciQ2w6LNjnfKjapwNdvoUVK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762453551; c=relaxed/simple;
	bh=d49GAtLiWQ+gY1EKaUZBNDB5hNzMmi3WaSSV6czVI5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CziALbXaS183+5Q5vmWwGdYYWEiIdJpzGKqBfXT7pVpOS/zUwBcPryUPHTUJeUjUd3PMS3qKq1BiJUpCtwsqtjlLY02loL4qPBhFXomUfHkRb/hDeNGZLtgNjMJognNpOg6xYuDikkmZRG7VZW2mq2ocav+9TcRqdKbGo4Z8FaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ja7dRWoI; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b23b68a41bso105328385a.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762453548; x=1763058348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/aqZMvGx3cDulG83zxrmi7nWBQJY3Wx4JVbaMSnDC7s=;
        b=Ja7dRWoI0cK6X9SIhwXec1MqPFgbCYOT/WSU0ShGgU4Ig6hDIMtq7ZAK9CQVAddiuj
         i7nPPiZHyCSNkVGn7Ff8zI2UowNZXX3bbhacVno1AbZOKlrIZ42RaSerK0JeaHcL1aFN
         duWCQ2RJDnmqr/FmXJQ5CKnbzD6d9Xw7ILzJreSxTb2PZxR8kO7pMqwgo2Etx+s7Sm1W
         cd0SjODCaSg7IXiwDm874L8iTXe6nT0Fxi/reIpaw2xiYHSq7TfuuNXfSJ6eNpi5Lxq4
         80he0pDqb8R3ZGWBVQLhIkWR1Bsxr25fiRofSetQt4af90XsobXWLBPu7jaNrGDgASYU
         S6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762453548; x=1763058348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aqZMvGx3cDulG83zxrmi7nWBQJY3Wx4JVbaMSnDC7s=;
        b=VKA6rGb3MQjQUp60Idum/k+fB+kcewPJYBMI8aro/CIQ90odkH6OhNjcWgKFDZB/96
         G+NvAKZ2OqTzslYh43mXA2lA6UapSOfwW57tNxrCpa2oCXyCo/eOsMkVT6RiKp8aOehh
         FJrDznMtt7XXJHffrkIjm1MucOh2VxRQyB+qBRik4v533LhTpP8+/iN1VCzZMFRBc3aI
         PFFaOblGwKXcor+2zLvnXsiEnOiXKab1nD3z+YS8chguv0IFQ+Z9TNk452j2aagsRjbT
         7n3pTKQi40oULyxJXi1yZZMtodaQvKUmXA4I8jPzfspO0SNl6Z8cVvLBx5yuKw7UggMP
         Ii9A==
X-Forwarded-Encrypted: i=1; AJvYcCUzi/I81Crg6isEQCTdKQ11RlcuEZm9bLtXBzGBL9mcij/cbKtKdLtUWX1Aj4q68fPdZUZdbmSGfijZbI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7C4dr1WQMYLvgcOEy2mzsBYAa9DlqdehfqpG8+kO6oVM5GIh5
	lWB8KzkwwczyMQqkygA/+qYywDiaEhQi/uL6Ca4nplbSL91wgP+Z0DgVfmSPB++E8xI=
X-Gm-Gg: ASbGncs4/9rozgTJS7cmO9/B7GmSMVImiL2/sGxIU+FfQf6OWofZf0SCtnp/IV+CZ8e
	XTdhEtnZfuMLDTIWPieC+fviz5aJ3B945kDEwxbQuWKQKmjx5fGNxlpB+mHeTu7Ery2dUeKw3UW
	YzP6aaoWJU/1c/CEDrBzZBRrMlE4BXQNHRwR5ZhSbnXvy1Dp/wyn/LS8u+g4U7nroMbEU0Y6rFH
	v7RIHLyR4zibgTrJJrdC3VEnDx+JayIL6wixqq39TGbjZNRMRPFbkxeOBC7ss2bf6jdp1QDyeiD
	miPOBOwxxAn+w9yTJrmC389ofXs/n8kRODTiR3L1aD0tvmgMkNPZ4XjKcXcWXTqZ6ZK/sdySIje
	bDiQybyQTBXLxy2z7Zaw9LMvfTs+gtVt37+uzBpQFWKZrVn8oC9PNEu3DpvLzwrX0QduSitewaA
	1am5eqGDIOVFLb+YaEni8Yc2Vu+nlIbc3yEmCDeX6UqlsSaDTsDy3jDZeMEYsVs9Vm+63tFA==
X-Google-Smtp-Source: AGHT+IGG88vgYrBYLoLwBIyOKJFlPURjqblZiHgoX+67U5H3JIp6YoUJbgYMMwMECaFVdN+v2cX85w==
X-Received: by 2002:a05:620a:1727:b0:89f:9693:2522 with SMTP id af79cd13be357-8b24533edd4mr86446585a.73.1762453548474;
        Thu, 06 Nov 2025 10:25:48 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2357dbebasm244367385a.31.2025.11.06.10.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:25:47 -0800 (PST)
Date: Thu, 6 Nov 2025 13:25:45 -0500
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
Message-ID: <aQzoKWqfw4vfpFrW@gourry-fedora-PF4VCD3F>
References: <ad410c59-bf0f-47ae-aa65-c0d845e6f264@fujitsu.com>
 <2296acdf-de5d-4591-a165-d59f9f432dee@amd.com>
 <e545b630-1a89-40b1-996c-c843a9e8fad7@fujitsu.com>
 <aQznzIP6h5NibJM6@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQznzIP6h5NibJM6@gourry-fedora-PF4VCD3F>

On Thu, Nov 06, 2025 at 01:24:12PM -0500, Gregory Price wrote:
> On Fri, Jul 11, 2025 at 05:34:27AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> with CXL_REGION=n you cannot create the dax region.
> 
> region0 --creates-> dax_region0 --creates-> dax0
> 
> all you've done here by setting CXL_REGION=N is break the probe chain
> but otherwise successfully attributed the memory to the CXL driver.
> 

apologies, disregard, this old email somehow managed to make its way to
the top of my queue.  This code has changed significantly since july
lol.  Sorry for the noise.

~Gregory

