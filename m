Return-Path: <linux-kernel+bounces-821610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B17AB81BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD2F468556
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FC22C21F5;
	Wed, 17 Sep 2025 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rx1zIIDP"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C182C11C6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139746; cv=none; b=NJHZFKlWTC4mTcsjfWqqPXpuIESKtpTAPqwUr31fjMIRwy9wMd2xnK9xyNd1v+SsC0xSxCCcOD+D2Vq5cGVK8dsj1qoLlUI+T2g8Q7cURp5rdG2ztb0HtMm7bqDGx5B9LqlxpYz1E0qPK4ruVvQEtdKEJz5ZiwOpPwe+OdftTtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139746; c=relaxed/simple;
	bh=QegIn/xIpMqvZ7j5QOaGIvD2uUiHbfcl1Y7O1OQ6RY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pxc5SXnahOtrw+zCPgklMR+4rKa3gu3Y8zRmZbRnsEdNXtyXd+5Nzrnx8INQLDwj5hSpdCamxImM/BEalbk6ISxwztFPpb8wY2CrKAAvIa81joSlMIAGmNOgGIaLAjkmoidHUm9HIuK2AjMU18rBuVML/aiCFEjHv3D4VsVAh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rx1zIIDP; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-81076e81aabso22189585a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758139743; x=1758744543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VprrwUyM52fjIWKNQUnRndbubnPQYNADGPvk3/EtEEE=;
        b=rx1zIIDPxYg7g1OXRSY3cuY9Ll1Jf/YnmMU5pXw17s2jrh1GfGd4GUFC6P2T7UEIlZ
         2u29l6ftIU5vWth+0o6bpzq7LsVNtJXDU911KMbZRN1bDbEy8twih7SnW9qbgUCEKHbZ
         1y9rtZ9uqsTbwWUt5ECtoIjrlZ13937frLa2Ne/DcpKzMVwfa8pmPCoAGkNwKhM8BXRj
         XZTjqU3yv1p/Xg18cnfJTD49p0HFplRyG/CSUwHNqVQR5+cc1doQFLXjzp5mmtpxmmd8
         B6vMKuefr4XDQz3UYaPBnhQ9ZtFo9wqUyrVcrZ7HguWFtI0rFU1QeEiHXvjwBrd/BEwy
         firQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139743; x=1758744543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VprrwUyM52fjIWKNQUnRndbubnPQYNADGPvk3/EtEEE=;
        b=ghN2+jsAnUiBk9tm34TknZ1oZCVahVh1ZpqgET4im18oZzAM+E0v78xRxjcUHT9JDe
         +7n5E/dkAL29urayY+UhuFGUQ2uXWlOPam3wMaCr5oxO3n9HUS3QalBI5RXDuH6Lxe0b
         G7TP5qpyAfKrwND3faD8Ggu3WTMWccE3tthQoLPqZJS9fYdpKj5jcK2kkgxt5ki9e5Gl
         SQg2C39qv5p6LuKVKsv5SR2BjHaTvG40RKUamXfHjNIVXsliH3eZpk6lvewN/t6smz2O
         aHUoGK+FJpi3+gBBvSceMFgIA2APaeKamcZ89f21lYxUk34J7FdW1mxKXBoiewLuJbnb
         kx8g==
X-Forwarded-Encrypted: i=1; AJvYcCUUnYx3VXws9SpjuJdejDm6U1qNl2TZn8VUfi2XTfcAWeF/7y2CFcDbb2MgUBz125iJMlNDStkf2fgsCXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvCPciqOlp06CaK2CLXtvmS4X8mzm+466n0k+p4aN5UfEvgL5S
	5rR9npNo3wvM+7cYLkMaTjeKY2Wat6JdKm6AVHGlbW4i0rO7DfEbJuVRHcKENE8mbUI=
X-Gm-Gg: ASbGncu94IfL8bGqHtseLBEwqs61ZQoeNQ23GIRF/ed+fmlTa539y4MhMuJhKtcG8JN
	PbgRxzaX+/zaSWhgGj386Hr2woTpnZvQNo08OKMqAa8HH+qJ6bu5GZvWS6IzKy6fCYJuYeV0+Lc
	YgV+v1ol6LJRim7tTh6h7lrvvxznp4podJX2VMI1RoA9LNkDYi8BvkxyF6IlDnUAdL/n198zyJ7
	ytLTfJC7gql/UwoKY9AY4Qsns4y00QeXcLi1pjJK5VYeWQBhNAnfL2UNBuLltg61gXiCQQw/Vnx
	AyBsAuLHMqDk+OUQLd6T/kdBkGAb4gevjqpqbLd1NvuFiWEIylL5ifEiiFJKyyTcZLOC/oXlryz
	L6N6n82hJPtwasnxmNRX+lLkYUdMORAcdnt30+wvs2+91XBka2B4a59OViprBrYalG+BHrJqwaa
	hQK0w=
X-Google-Smtp-Source: AGHT+IGUMr1Nkfy8mnqMrHeB30gSgrKq7LYSjOJLs2P4VZWfTc9K5c9FC/qhH4RsE7Urb/tyHmNviA==
X-Received: by 2002:a05:620a:46a3:b0:7e9:f120:de9e with SMTP id af79cd13be357-8310c4f09aamr351094785a.26.1758139743299;
        Wed, 17 Sep 2025 13:09:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83634a4f3e0sm35600785a.70.2025.09.17.13.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:09:02 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:09:01 -0400
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
Subject: Re: [PATCH v3 05/11] cxl/region: Add @range argument to function
 cxl_calc_interleave_pos()
Message-ID: <aMsVXS5z89HCFpb-@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-6-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-6-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:07PM +0200, Robert Richter wrote:
> cxl_calc_interleave_pos() uses the endpoint decoder's HPA range to
> determine its interleaving position. This requires the endpoint
> decoders to be an SPA, which is not the case for systems that need
> address translation.
> 
> Add a separate @range argument to function cxl_calc_interleave_pos()
> to specify the address range. Now it is possible to pass the SPA
> translated address range of an endpoint decoder to function
> cxl_calc_interleave_pos().
> 
> Patch is a prerequisite to implement address translation.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

As with patch 4, maybe worth noting that this is simply a refactor, but
otherwise

Reviewed-by: Gregory Price <gourry@gourry.net>

