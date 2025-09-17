Return-Path: <linux-kernel+bounces-821603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D78E5B81B71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953224A26B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E122278779;
	Wed, 17 Sep 2025 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EdPtg6/J"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E84263F4A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139519; cv=none; b=pkgRGIK1RUc3VFZT1Gs7gexctwrJOMlCCdJQItCLSDGgMBGihU4vROA4y61FWpR5MyImXepLFW7tafdQ4aZ08b/6UHBqwgzzT+fdKtumFil6dAXxj17Lb6+sLJPsG46KK7Au3NS3LTRMBisSD0DbCN0WPkto75h0FR9LJz03slg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139519; c=relaxed/simple;
	bh=yfIfL+POLiJ30NxgYv7j+jnpGlALZIt6NFQ9Ps7CrdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUALzXjdiQd+Ux7/VBy1OdUutMSvSTGaWu9uyeJRmtwhS1bLKW26eSIZN8m9B833LyVKhbnAHTiNjP7U0tvE9Vo6Ir31jXIiMOTAwtUJANdfT69u8/LKbss8/I2j/rQ1tYb9AbjYI0DvblGiJqFHXTkzALj4XUnvB66DMaalxN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EdPtg6/J; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b61161dd37so1456171cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758139516; x=1758744316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wJOsiB1bpVW5O3ppXUgWRDtm86RikS6Y+yhj+zAkaVw=;
        b=EdPtg6/JwGcibacmGlPGIWO8PqDby/mP7FZRP+qXZinCUrheES/7Ju9XjJPZpUlJrz
         +yvvgv4bWR46xowVDM/QaAwqG/bFtSUuZ89h8kpEpHo/bkfbHHzwINYQLWy2MT0zSRdU
         7kUAoLc0c9hHav17qrZ7DkVWBtztfPA9CeOB8ESp3bwtOiBLZoPn7DnhDhmJXplmKgDo
         qQOi1JJ9ark9a9I83yYU0fSpvsSvvEHsUT8drOauet5vLeJutM4bQHp6h9ohrtOi+aN2
         9EUg8S8psjUbgq3qftIJ/TWV+J3KVyJlsFtcZLU74RM9+LqBdKU0oLfL/ydooPoczQR7
         A/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139516; x=1758744316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJOsiB1bpVW5O3ppXUgWRDtm86RikS6Y+yhj+zAkaVw=;
        b=eLnJ/GYR+zsVykM6eF1Qh75+fODUg8zdtvmd2t0vYuzbPnnNvHGiUZ3lh6RtW3Zu0n
         Jo9e0bmfBkDyDUWOP88QUwHvb7Vn4ZFhofHJNMlRlFy9wYSydbyVxTkiNhlS6Ppqbqix
         cyO3zaGwasWn+t5EywoKM3+A7t61m+FRCNnE6qgAnow6BO0xDufOoI9Bq0wA27hIMjqN
         j1wiSZqQhalUmg6BLscgSL0+JEvvjt6mQ9HD+AJRPVVW1h1u6OzG7LQGACXTC4iUKfU0
         twpuROms/mwWEKFMIqkynt5PkB7qD4ZI9eBRCK/MyPQy2oGA7mw6Kzc7PwHqeT91Ujzx
         HSMg==
X-Forwarded-Encrypted: i=1; AJvYcCUrWnTB7OIYkslquVicBg2WREtNPT51hKfavEc4fxxcRCJM5iAYaPnoNATFzm3O2DVPLxfoEHVQVBPGT1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5P7qwqfgbXtetVsw5lhOpX3AToKIYUXwb0uS5bC6mEryywZGE
	BDZc4a+/7DgVarIRXna6+yBPYOIyNAK96K+fVxifM1OqDD9MFMGrPLYSRtUPqMJ/L5M=
X-Gm-Gg: ASbGncv0DspDnu601x/9fx206JRhcsrCfdq/0UtCVwPg6dDj/T1qewxqgh6Wgdi9uo1
	8G4yAgB1HFUL5Snr/Jk6CBWDrfPGLYw0nku2E4Y7OehwhmXPazbW7dvuNYLEPXpMVdmelkipyrJ
	P07fbxuk19SnBhAItWHWXHK2EZuDqX8M82shuu0wKDwpx8QWgWfAvUk6jXUz/tTaUaVFHTixG6F
	iHyqpr7AuXO6BmUn8KLILUSj1zVoYOoradrSCyDZ4SCjJLqEobkn+tAUIHWoI0GRS2kz3Oe3TUZ
	r+EBxZts/Tu9wXRrFeJWP4/Uuc8GvT5fJTpvJt3MrP/Au+BG/MHw/Gfq5DwiJNWA+5HR0pxhYHM
	0ihxmUCNpR9ThGfAJld3kREgEWYGcfDUD7jCF9KGsSVUWDb9sYO2jBj0H3hi072BHOEdm1dgu5U
	cgOCc=
X-Google-Smtp-Source: AGHT+IHkspUc1p8HZXKoRsdqMt3Uynx+jmY/D5qq0kQlFo+6agSywrHnZywaLkDz7glbxTmttKdAYQ==
X-Received: by 2002:a05:622a:580e:b0:4b7:7ed2:c3f0 with SMTP id d75a77b69052e-4ba66d141b2mr39682451cf.32.1758139516308;
        Wed, 17 Sep 2025 13:05:16 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda86b279fsm2914211cf.33.2025.09.17.13.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:05:15 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:05:13 -0400
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
Subject: Re: [PATCH v3 04/11] cxl/region: Add @range argument to function
 cxl_find_root_decoder()
Message-ID: <aMsUeUME_6wkhfp1@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-5-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-5-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:06PM +0200, Robert Richter wrote:
> cxl_find_root_decoder() uses the endpoint decoder's HPA range to find
> the root decoder. This requires endpoints and root decoders to be in
> the same memory domain, which is not the case for systems that need
> address translation.
> 
> Add a separate @range argument to function cxl_find_root_decoder() to
> specify the root decoder's address range. Now it is possible to pass a
> translated address range of an endpoint decoder to function
> cxl_find_root_decoder().
> 
> Patch is a prerequisite to implement address translation.
>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Maybe worth noting that this patch is just a refactor (i.e. no-op).

Reviewed-by: Gregory Price <gourry@gourry.net>

