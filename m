Return-Path: <linux-kernel+bounces-857020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F19BE5AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF08E4EE6B8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0202E1F01;
	Thu, 16 Oct 2025 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oZTMVaCH"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AE72DFA21
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760653383; cv=none; b=e03IfGLrOLPm7warK9L6Y5fEPov0raSLcaXZEQV6gIcd6wsAdz/FiU5p9x+WTH8gwJWfuVGIxNNWGLC9zgA4HC8qNxxVI2H0nVAs5poyztMoIRhOO08Bbbmh7NMxR5WH9b/8iQ2mZUECjWV1ga6KsMn3ThXZZsEYKsyZFQw7rfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760653383; c=relaxed/simple;
	bh=3ekii4Padoo4vLo5RlCV8aomTzPPeL5/QviVnlsRBu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeSR/vsjuFyLEoBe91+emheN9bJC8mQmnkzJcL0igKQNwBrOES+WVCiAQ5MXyj/Pa+QSV5HWnggCYYgqQXL1wZip2drC7EWPXstC+RT5fbN5nd35NF9sUP/udPbHIRvFur4FIgyFvdUT+k9jLb/jzVqwc+lSCWQU1AbLvDATriI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oZTMVaCH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-269639879c3so12109725ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760653381; x=1761258181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rkSN+UnBTkzCG3PwDHFkCHOX5m2YbVVWNnREzEnFMow=;
        b=oZTMVaCHq/k0tx3yiSzxJBt/n2F6POmsgUBNRgGUTwpbiuSjPYj0kDam07TY+m9U1L
         3MOyijOH4WZe/MFS6ZMdRJbgZ9pX4h/vohe9K3EB9mUKAc9c5AKQmyBLTZy0nxNWshmt
         Oar3glofJ7e3eRxfjDE/kFEE9TktjK/o8F9JJzLbcCl8/bU8aN/ANIpP7rfWRnwqu0Or
         2w4Jh8p/GU86eBKLffTZBWRSzl37PrhU5/9rd24zpjrInpFupQ2/2hZbH/bHYnSkaEpG
         x5EaBspLDoq+pvMxV+6X9Z2qcJNSiHJPo98+lzgQHl8oYyI1XUn4Uh2k82tM6HXOHlpG
         wJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760653381; x=1761258181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkSN+UnBTkzCG3PwDHFkCHOX5m2YbVVWNnREzEnFMow=;
        b=vcgINeyh/03xITRfti8Gs49q91nlNOAnfrT6yAv8DZJfgLMGj2EGAlUVmkXcEMyiog
         jPJX9SVDe3CwKaHbGuqUARIupTt5N0Wv2D43Npoy0DJnj1YSoEubbfdPBKsDKm7s7Wdn
         J/D1L0kAxs3KMqWkxJDy8zBpSzLtc6h04XoV88nLkNRAh6/xFWScFt0qQx2ErZd4y6JU
         S0sGWI3zOCmacUfjKDVKRuYdfbOZGr8vFK5tVkZythLQ31/nj0WTe5zRmgcqWlezCfLo
         vyUyqahpdSz/nZgOkK3TYaj2W1+ye2sEbAZD6qcfzUdItActzZNvnRvOqFZu97siNtJT
         fGMw==
X-Forwarded-Encrypted: i=1; AJvYcCXYMBhKLvTN1YpgYpWzt7XqAyx/2Wjzjb/jgAqHrKpIAns2mI0ULlQ18Zp/iA19reoFAXwVZCquQBBSf1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9GDO9/C14oLYUrLXXTxUQXMwbae6FhZqphzlKHW/bad+pjWs7
	a/A3ZXY/Iv59LdG4cVMuReCSgaNOUZQHNZ6PaRoTLnp8akEWClV5zlfn5MBTEFOuCsqH3yZJpUn
	z6EAx
X-Gm-Gg: ASbGnctOL08CHXVUMf1X1zsGuv3vzACN1FOfzb9uWIpzhRAMTbsCgP7tP3vS8XCH/VH
	DPeH4b/3lCVRbG/yp3+Cgjb53ChF+fWvL3XG9+JgphzGOHCLQaWOrkpobBx72G5zPB2jXya3dvw
	I6vtnBaaOLpvAZtNmTmzDZREUDjiWpOx1Mgm2QHxjyZ9dF5LDLrSdCOhWkeuykQrF/lyVeLWr7e
	kRLtNaJvsXXxFExnbJLKoafEa4njuFfy/lXiw+DsCmlOSZcajXhoU2i0Bc18P8kJdXVioN1ZuP/
	z9Tc0tOSH4UFYN+XlNxhcBw1QjqnNYUauJVu0uDwHhN3T4p7jk482dGKoaBDueVLN5EKB2jtje+
	7xZW4u/Z6pUp3ktOMaW9sDY+/Wb0SBUhwc8OZro5PSIXtjHkw/TajLSiBOnZzQ7lmxvXWPWPlqJ
	/z533e3g==
X-Google-Smtp-Source: AGHT+IG6Ed2MBjmz0upGafcO94uC04MsCaD920R4+63rtx35D385DHJTV6ADNuxL5fUjZODV+u2KRA==
X-Received: by 2002:a17:902:ea01:b0:267:d2f9:2327 with SMTP id d9443c01a7336-290c9cf2d88mr20529015ad.27.1760653380873;
        Thu, 16 Oct 2025 15:23:00 -0700 (PDT)
Received: from sunil-laptop ([106.51.195.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909934b0b5sm41627735ad.38.2025.10.16.15.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 15:23:00 -0700 (PDT)
Date: Fri, 17 Oct 2025 03:52:53 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: rafael@kernel.org, regressions@lists.linux.dev, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	apatel@ventanamicro.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Daniele Cleri <DanieleCleri@aaeon.eu>
Subject: Re: [REGRESSION] in 6.18-rc1, failed to query a GPIO using a name in
 ACPI
Message-ID: <aPFwPR2A0CN6k1Vl@sunil-laptop>
References: <c321423b-3cdb-41a5-9939-dc5c846cfcd4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c321423b-3cdb-41a5-9939-dc5c846cfcd4@bootlin.com>

On Thu, Oct 16, 2025 at 02:47:40PM +0200, Thomas Richard wrote:
> Hello,
> 
> While testing the AAEON UpBoard MFD driver with the v6.18-rc1 release, I
> noticed a regression. The driver does not probe anymore and I get the
> following error:
> 
> [    1.977831] upboard-fpga AANT0F01:00: error -ENOENT: Failed to
> initialize FPGA common GPIOs
> [    1.977854] upboard-fpga AANT0F01:00: probe with driver upboard-fpga
> failed with error -2
> 
> The driver fails to get some GPIOs using a name [1] in the ACPI tables [2].
> 
> I did a bisect and I found the commit which introduced the regression:
> e121be784d35 ("ACPI: property: Refactor acpi_fwnode_get_reference_args()
> to support nargs_prop")
> 
Hi Thomas,

Could you please try with below change and see if it resolves the issue?

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 1b997a5497e7..43d5e457814e 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1107,7 +1107,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
                                       size_t num_args,
                                       struct fwnode_reference_args *args)
 {
-       return acpi_fwnode_get_reference_args(fwnode, propname, NULL, index, num_args, args);
+       return acpi_fwnode_get_reference_args(fwnode, propname, NULL, num_args, index, args);
 }

Thanks,
Sunil

