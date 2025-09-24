Return-Path: <linux-kernel+bounces-830953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C5BB9AFC2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016994C7AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9F5314B62;
	Wed, 24 Sep 2025 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LStY4TSm"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CC302CB2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733793; cv=none; b=S5M5skIz1CYbqXrxKYXSTmbOPIwRs8ro1zckHEVBY6rmr1SzhTiHMSNlnry8t1aJSyzmShW86oQiaDHw243OGUZbgnj+MGA4P6MrEAooOVU9H0o4GhonB0cx2LVNqbVB8hJQB0nCVT+p8EkDKyQ0ygOVx2y1RyCVgLPbooHX53U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733793; c=relaxed/simple;
	bh=oyrAbyutMr1gRbHhzc8Y83fiuBCvcnjsrICPwfRA6O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ep9xiX2VPkqNPsUx6MqgogZfUE7ldy7KdQTCeJiwnjh81LOmRFlvRKaXPmd7BKTZxXXhZJYLvq1Kca6rjMWk5TXuWmMHcsSW1ynr1Mxlbfe4AoN8AxQnRG5oqSZlQxUhT5Nfwj0nghksTQrqLs2bcrUpSmrQuKHUBlgvINaVhoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LStY4TSm; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8c62e313847so4702939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758733790; x=1759338590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=26T7VUsEbTXS7ZWOF9xPs/3xJgAyNlS5cwtU+OCVVXU=;
        b=LStY4TSms9burCgYXfLlY75ooAeeDo1KfvLneAsb3sIiFB4Us9cMkA7l/kw7W6VYzQ
         DpzZYAb2on5Oa0ULqAOxDm/BGOLQh27nwsX7UycHjQELOCW60Xcf3cwEtMtUv86+Bwr6
         sHziSvXiZcfs2WIzG92cKVUZsjifqZhY3VhLSqELKY5Ep5zw4jZq0CF+NL1RJOIPQ6C3
         6Air6emJULzdBSzMM8nl3x164HvfGKVnAXTjvX5tsgJR8xuZEKilW2wxyWmnHVgPgXes
         cXPDVLQyXRBmS30yM8NL8RvbE/bV8fNkrOZkaeSR871Z56uaGyJx7VG2f2zA7YYrZst2
         lKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758733790; x=1759338590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26T7VUsEbTXS7ZWOF9xPs/3xJgAyNlS5cwtU+OCVVXU=;
        b=Ew89H3BauYf7c3qcXpnwUWYwsWMr9lE5+TLNZ4o5ctT7I9RArFFb689Dx7Y97wABGO
         V48p8lIPiq7aoyDRU07eulJZSxP6tcS8w0fLh5V30sHD9etcenZT9yYdiM0mrpVnxTFY
         0BJNGF+pxa+DLlQcxg2diVeiUNYTaA8X/Dh+N1dUDMlGq9t+Wa7uqwAe8f/fk2Xc5vHJ
         Aw4HDNziFjOWJGn8E3hdedPh+uoluC1V1QB0OPDsu2/dXZFB8RhVuMmO9hlxOrDwQbt+
         MTaBfeLTumEhxZSdBK6s3ycPhJtC0mQWKInGP6NggbbuFjsCuJQoJS93JN/TJ/1uCAcq
         aEPg==
X-Forwarded-Encrypted: i=1; AJvYcCVjSCpU88UNIG2KpiB1Zhr0ng7JPghNMv3LToQUQ+VUBLE9RSnYj7hd5cxOBwWw76JpQmVrtWVSSrYcjb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0YTi+NMEibzoktjw72iE06GyCkJUakmQ8AYJ7KLUsxxuq5ppR
	yqMA0hgbsxWiMvym+4puWRXVTj65u7Z8L362w2w8Mq/XGpOdBD//4LwIdHuz4tc6Fcg=
X-Gm-Gg: ASbGnctHWHLxit1W2I/xxDjGm26XGWP9C1yE7BQLEnMAdq1cgNZ0WZUW42kWsoAYypZ
	taUR0LrZKVNV8oQOUpvDAwX3+0HAHdQhLh6b7Qh9GJogJBdcdlid5MMEaDG52lLo1wAyPFecdLF
	8FlBjrQKTRuFM6UpdwtEb6pRFRB8hwhIeB9JvKJ4XCswGLbgvTs7E6CEHyfobpuUbWr3HND5snq
	JmKMigfJY74VBb7o/XgYO0QOeFsc/K1WfTJmIe6EYxefmJjvVEeqdHqIuj1cFUFIgv6PuRqTlYW
	uMeIIQ4yeVKEBsC/yOlBStbdJ2mmtYZOELz3CKGff0bHAlqOKW+vDhBj9gN/M/Fj/rP4qFNw0Gy
	tgggM3A4Hty/lZYJcCCIfSoT2AgYdgbNGtYyl9vgEVja1LPsCK2+e/bI6G3MZCMRQseEvPfhkw0
	Q=
X-Google-Smtp-Source: AGHT+IGNmvEkhMyWszEWjjDEsj7P599Wf7BkeW1PhMFYduB6UXhkk03TlxUuapEk8nPHgCVWDcW7MA==
X-Received: by 2002:a05:6e02:2193:b0:424:2d4:585e with SMTP id e9e14a558f8ab-425955cff8bmr5442645ab.1.1758733789523;
        Wed, 24 Sep 2025 10:09:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (50-32-2-77.vng01.dlls.pa.frontiernet.net. [50.32.2.77])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-556f892fe73sm4718446173.58.2025.09.24.10.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 10:09:49 -0700 (PDT)
Date: Wed, 24 Sep 2025 13:09:46 -0400
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
Subject: Re: [PATCH v3 11/11] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <aNQl2ogOPKid7yyp@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-12-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-12-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:13PM +0200, Robert Richter wrote:
> +static void cxl_prm_init(struct cxl_port *port)
> +{
> +	u64 spa;
> +	struct prm_cxl_dpa_spa_data data = { .out = &spa, };
> +	int rc;
> +
> +	if (!check_prm_address_translation(port))
> +		return;
> +
> +	/* Check kernel (-EOPNOTSUPP) and firmware support (-ENODEV) */
> +	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> +	if (rc == -EOPNOTSUPP || rc == -ENODEV)
> +		return;
> +
> +	port->to_hpa = cxl_prm_to_hpa;
> +
> +	dev_dbg(port->host_bridge, "PRM address translation enabled for %s.\n",
> +		dev_name(&port->dev));
> +}

Is it possible that the PRMT function is present but uninitialize?
For example if expanders are not in a normalized address mode.

This code would likely still add the to_hpa() function reference even
if the underlying PRMT function hasn't been set up for translation.

~Gregory

