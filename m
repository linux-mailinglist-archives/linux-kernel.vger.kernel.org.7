Return-Path: <linux-kernel+bounces-821585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63617B81B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 380587B4919
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67C0279789;
	Wed, 17 Sep 2025 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="JKSjebNC"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69726261B97
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758138987; cv=none; b=LJoyAU1aCGunsK5X1MmInWXwnySde49AQFIfzDd/gI5r2ZAKmYKrFpqJAybbFsDyWDEd7/NEN9948giezhch6a+0qcwXjn/Mv0Z93a7xQB925tm9QsDSxr+byXFlipSghjJPsNTWcxOJ2h8V+6U/Z1UOLtFCVB99Tf8r5tmBxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758138987; c=relaxed/simple;
	bh=U+xzvg0+p8YRBwVjJW5ad4ZRAtixrH50H3CYwD66PRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7773n7r3Wxgw9CHVhYxX37CvkSid3wG369skahSs/wGeotTsf1Lssnj8jVfnmuTVKdvaANNZ+5sXrtb5JJp7IrdNT0b5FqVVTikIu7i4nGW6bHDw1mhIw84+jfoiDYbHBy3X8FL3D+Q5AHY4kFziVE66xvX11bBiHaJZZ+4voE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=JKSjebNC; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b7a8ceace8so2103491cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758138984; x=1758743784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TWHRbE+2RwfEiSllz0UZDyGmNU78opvT0w9mXRiIjrQ=;
        b=JKSjebNCeuvZec/sew0HOq5nhdjUYTGNTSBdF7eHxVOGjK7UxiBXf35dEqaUxpdNVm
         eYlcx6Lq3Svfb/N7RUavziAQkIiFqivDehH657gD355So2wY1enjBpNwE7t9y7BYJfkg
         ks9xqirKwnPJE7i/lx0rpyBiE9qqz3hN8bcvXfLe8NOmLjAXmefrfgarVLOFx4zEnBbZ
         3AUs5Qqpyrhc3n41jwCro44X8TaVnQZFZDjtvcOR4iVP7MnHgJ6cs8BH7sl0R9sG+lx9
         Lhw0pPeBOuXDLssv/qzkJImhtgUl8iFIaW8HaAd3DjL8uzWSxhBP0JPSsGd2DK2a+2ca
         WYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758138984; x=1758743784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWHRbE+2RwfEiSllz0UZDyGmNU78opvT0w9mXRiIjrQ=;
        b=tilJf1WhoWz0gwIHz23B4kjH4FMhAJ9AFgVbh40QrIm80gOE1/8mLN115X5poQdeCE
         iZc4iN0KEjAix8obHEIZihTGerg+tjPM1KCRO1pPqy3jWpzmSBYo61qfX8ALZs8TRxMh
         CReVuwrgJJV3l+aP39ih9Gl0VWHcIBXgiri9T2jaZDhLjQgJLuv1QHbcXEnygKj/1TRz
         eqgPsWxEAYFkyiMWhBe9dkJg/vqgEDfPzvDJCkTtXDokfoT4W833z2tA+TQBAE96W+De
         InTeUpFrFnbJYLeMJi4BngG0SBj4fmx+FNpjjx4fiQWEt2XLzsN85ZFzks11W9jnTZiX
         Iglw==
X-Forwarded-Encrypted: i=1; AJvYcCVXqNENUPdgsN1CiP0rKtEE/PJEiZ/24RjOkeX9FvKf7kn2ivmT1xPRHAvSIrViK/Lw25+7CiCcOsCh9lY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4CbTEKmCVqMpY+qwJz8lO2JaNbf/63bPqKAuliWvW1ILfvlrT
	umZOK4ySDjVmNN3G1s8zQQnV8aJu09G/p8wBb3SyOj/a0ObfFP2pe2HkCj5wVRagVcA=
X-Gm-Gg: ASbGnct1eXP+nQQJpsHokPFCmvFjhzZ/0Lz155cCrhVKa2wmaOvj5UQfNqceH5bb8B/
	J+wgSYbL9U840TW1Ri8NyDqA3FefhpydYamoowB6F8GoHIXVYoz+LNg1Qip7daprvGJHl+G8uqf
	LbI9q0l2YKZzmnRWFRlqixIKG3qGaQryIGfZqs5S+PRwLVEg6x4NiJpB4OE1cdWkZqiiLgfIx4B
	6E00mmkhIXlZll0mJbBzlYS9x7hgOB6fO2ENYXrMjq1pidvNeVRv7XgQ8/p6QdEAgUmSV0+yZHU
	MNmQYxebasVn6eZxnRZLIF/3kwscaxBc22WXAZaBpohD/5pjgHUVKaj27eAaZbPda1lx3wvDxva
	DDYDAdOSV7KYQLx/h1BSN3TrJPq5gE9VMMTsU4PY66AgD43JCvSo6+qBguS6dyZ3iTkQ0Ryuz0s
	eezPr/2iSs8k6m5piwQHClGg==
X-Google-Smtp-Source: AGHT+IGZY5onFfbJ/Ady5+OG7UsSraIKd+u3udvBLrGG06Nf882Q/uxkOvG1zGx4Y0t9b1FKmtIqRA==
X-Received: by 2002:a05:622a:1cc3:b0:4b7:8235:1eaf with SMTP id d75a77b69052e-4ba6a5d6732mr45153491cf.39.1758138984189;
        Wed, 17 Sep 2025 12:56:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda15f577esm3184571cf.7.2025.09.17.12.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 12:56:23 -0700 (PDT)
Date: Wed, 17 Sep 2025 15:56:21 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 01/11] cxl/region: Store root decoder in struct
 cxl_region
Message-ID: <aMsSZZVNwH3LP_Ur@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-2-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-2-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:03PM +0200, Robert Richter wrote:
> A region is always bound to a root decoder. The region's associated
> root decoder is often needed. Add it to struct cxl_region.
> 
> This simplifies code by removing dynamic lookups and removing the root
> decoder argument from the function argument list where possible.
> 
> Patch is a prerequisite to implement address translation which uses
> struct cxl_region to store all relevant region and interleaving
> parameters.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Nice

Reviewed-by: Gregory Price <gourry@gourry.net>


