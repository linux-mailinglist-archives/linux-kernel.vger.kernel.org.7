Return-Path: <linux-kernel+bounces-883532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DCDC2DB55
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501B218953A0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024F1304972;
	Mon,  3 Nov 2025 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="at/JOmYJ"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2627928A704
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195227; cv=none; b=pG9gRFbOl9vGY8A4U9uYSVfmJUpQX0LuRmrKP2Gv/ZNmp/GtIt9JD66jpe/vNhg+VS5Jui0XmKDVEFSxNO0EKtNrrZVbYvA366xk0bLN6OciiAp/2N5Zq4DcLo3NQfTRtoPIDgDlP9A2gMjP2eDcKasEc+Ihg/pt+sItuILAM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195227; c=relaxed/simple;
	bh=M6kSq7zhpxnw+0M5zL9/Kp1ZAyzM1iKpIk7f+nKH9yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oouBlTA2f6nWVAXQ3IFG0d1mzlc0pyc8aOcMwgvJv5xnMJjhulRWH9lTKxMOnrheJyurN9K4oGuHhed8uqhxwxiViUXXnnBk/JkskS9ThDjA/fRf+j0/ypBHCT8TCsvidmwuDcIAI/UeFZVXhu1sxdRxqruHrQrQwgCciQzRIAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=at/JOmYJ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8801e4da400so53625116d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762195224; x=1762800024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xdu9914nxmx9HVrzeaXCiD/M6gjOdAMYdjxCy9Nn1IE=;
        b=at/JOmYJsuhK5XT7PtsdmvLIL19fr1IjQTdsi/tTCE+atQgEyyauhPgYR3rDGt2vSH
         JDlbuLpWH51MaH+Ah9K+zhLTJWL8kAX9GgkzLLDyeBLKYw5Dpim2nszOYDG7d4oU2j1+
         i6cMOFWxn6B11hR5caq0kCmAJTmzQtH9HcuhX4cPCfCF6OO4fVB9AeaFPA3O7Ll5qqgj
         CGPuhJ0T8WhcHDgU/3Sp4hdwjefjl02M8+KCdtNJcsK8T4wP+X3ATdkV2tTFAx8AqdTF
         voUMgkxV18Uqv7Ig8sxWh3fKmn9pcFgqgrtG4jgRg/3Y3d3O46D7QPXvMuqfepf4S/LT
         3Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762195224; x=1762800024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xdu9914nxmx9HVrzeaXCiD/M6gjOdAMYdjxCy9Nn1IE=;
        b=FisTVwv24qWzPEsAmIL1PPGAN391NJzDDVL2PfeB4So7MtiVl6BzU8GUd0dVqd4VAR
         m5DXbhm5UUIYv3TdVSJMYB5EkwuGNd1N02MIuH5yev7ZWMRdgFe6OLLwMrlXYSLNlAi6
         /JtRgI9YFjrx4I7ZOY+8H7O/zs4KLNLEsT+YBBOZw/gqt1hDypwwOvy2U9SuvJFMIIDg
         6NEmifNIcQRYBL/Rf2gt1xnpaWNm/Z8m8nZ81ItKCYNP56b1C5kzsm/DxqRuRqHzyMMD
         W30/9UtM5aJ3fX+gbjxNciBYWdoTDE5SXNLiQ4Nt3GVW0OYIR6+pJJ3FuQ8ig6BqVJZt
         h96Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsPk2/FzsAGfDCLGI+b7r7Y5omoo+MZU9jguVV+MbeOE7348/NF9XfwQfpufe0nYVIri3O2NtnzimUN98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJZWhGY8y1za9Bpg22bx9PrYP6XjhguDyYs+b63qUsfGqfXrHO
	rbIrrF2iFLxwTxtZKxE/6k/L2OZN5liCeF9nRi+vdFDMkKGr6mKfMjHj5hR/uoaiDRI=
X-Gm-Gg: ASbGnctlUMdzrCxPnpjwfm8yhTmR8qQjGQPbjiGIcIxg1WbtCBoZPFdlyAejgFuo4BL
	+jljO5VyDQpvyJCKKXc86uIcyJ5Zuj6Kzmd2BhUhxyfLJFlAPCbVJishT3qPdmYLuU4+geaemqY
	ybXWTm1vhjEyEuyrdmqfE7++KBRvRvE89cbvRS42dd7pxZoaW4OtBYekphRsNTmp3aFdD4i1fGG
	jYvmUlXvyDoAkYOnzzXLxpRF8idZgZPgFDlQObIMsIZuSVkVHQmUr9jlj0PGQKX/DEWVAbN9FNa
	l4L6RaD+xkB5kMUnOExl8RlwLj7Zz/GKurQ5oIKF+9xYMd7JOnpl9JxMqC2Rzf4wbS6kboqXQA7
	GxyUe1Atv16oFaGUg16CMC2kyXe24EwvWWLMTN6oN6MxtSPqJbP8sQ3UmPLAeH6Xth++1vSQ4Wg
	m15H3ng/es02B4IwsGuzfIOnlSku9OHRLJ47Lua1EB/WlA08eGa/gerQqS
X-Google-Smtp-Source: AGHT+IGemSUm2ni8Ue1hNioLIE6R3qX4KpAYbxriXdHXzmoYn8PHCrwIpoEc+FJpyECmaBuxF5TAMA==
X-Received: by 2002:ad4:5f8a:0:b0:880:5042:e38c with SMTP id 6a1803df08f44-8805042e868mr88058206d6.2.1762195223911;
        Mon, 03 Nov 2025 10:40:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060db32acsm6812126d6.3.2025.11.03.10.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:40:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vFzTa-00000006S0U-2tWz;
	Mon, 03 Nov 2025 14:40:22 -0400
Date: Mon, 3 Nov 2025 14:40:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v6 1/4] iommu/io-pgtable-arm: Remove arm_lpae_dump_ops()
Message-ID: <20251103184022.GF1204670@ziepe.ca>
References: <20251103123355.1769093-1-smostafa@google.com>
 <20251103123355.1769093-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103123355.1769093-2-smostafa@google.com>

On Mon, Nov 03, 2025 at 12:33:49PM +0000, Mostafa Saleh wrote:
> At the moment, if the selftest fails it prints a lot of information
> about the page table (size, levels...) this requires access to many
> internals, which has to be exposed in the next patch moving the
> tests out.
> 
> Instead, we can simplify the print to only print the fmt and
> for each test ias, oas and pgsize_bitmap are already printed.
> That is enough to identify the failed case, and the rest can
> be deduced from the code.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 41 ++++++++++++----------------------
>  1 file changed, 14 insertions(+), 27 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

