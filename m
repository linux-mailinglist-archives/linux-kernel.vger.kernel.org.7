Return-Path: <linux-kernel+bounces-842944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE0CBBE062
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4E71894205
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2DA27EFF7;
	Mon,  6 Oct 2025 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bbg4gWTe"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494122905
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759753725; cv=none; b=Pw2muv6KHMQMYTSMKk/xqhtHJhZnNcvumHDstn7QwRgGLJV5WCOiS+pPZWLRdJgkxjoWkoCvqCcS8KpLDfe1gQCjUxQeUNLNRIc/xKEY5cv7dWu5SsLanCxYddkTaNFbqsFy3RDVpMq/bjCdLC52vW5se3qcPInNZMbIVNGsMEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759753725; c=relaxed/simple;
	bh=bPX8VOTp1QfrXY7HdhLNzpQot3DGo5pIjjpBJLvaxCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZH1LUryJaOoCD009021OsdwoWyotHt3XiOo6ackILkVExbSTXJYLuW9c+tnyD63cXMmOolmJ+Kk0Q5B511iYHKeaiC1/RGxOaGUBf0onWzGHO+jKrMCboXZ470ZK9Dw3Nlb2GaCgbyZYJPrfnUBlIltFhD4gx+FVsWDepv9YvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bbg4gWTe; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-799572d92b0so47249916d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 05:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759753722; x=1760358522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vUbpXXQ4yyj3v4AWvLzyWTF3lr3DrlW7tjo7gZaO9kc=;
        b=bbg4gWTeRNsCKhSQ4eJZ6eCJkONS63vWQvuAO4vSLsqLsBaBLdwHiXQ3KceLi5UBrr
         x3uHEhiPt58j7YjedhvoaMu429fYSaeyB8cv+x0ksdrQLhO4LVGwW+G2kkX1/iu7QpUg
         K5f55MmoY+4UJHkj21b4MlkR6zNmNM8gQurQrqerfSrmMXmKuwjAqjJH1cgbjsMubVQr
         tEwZBfCkgFumAzsVRMO+vZeN0bMh85fJeoDOdhA8FNniPvKN1wdj52wPthXFV0raj3n1
         7/PPmjHcPMTIfi+9/exFpN49mcmLiG/EzWQIcjTtc1O1r4nGRquDHYzsrng+/FEMa9EE
         9+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759753722; x=1760358522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUbpXXQ4yyj3v4AWvLzyWTF3lr3DrlW7tjo7gZaO9kc=;
        b=YAgBYcaj6jwoB879si3kGzvrdKTa4JQzJ1dF9W8WjiEQDFggWrLcXPvJju2TyJh/RM
         7Ut7b37xiTUs5FqEmbzZ5uzVWgHqrB6tjuqlXJ4p15bFSp19KCb9lpbux3bY6JSXOGUn
         7uVlP5dOlYZpIyB2qSrnoCuJ6yBvP9JMvn3YrhO66p/k9qDPKxYATuWuz7Dq2nUrDvOk
         6ri8xMzmjWZ3mqx2sP8g0CZ6BpdS3pO1ZmLP+EmHWcgLKlSOWkbuiUpmnVOJkb1cu6la
         QCu3IVNxf6eF1xDUzMuUTGc5gur0FB9Mhqeth5ObOOP+gSWpQaX4HG6DMhkLDi+ful7t
         7AUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX+z4rmmX3yN2oKfLRCCVC17C1sz7F7kIx2Xd8FMi8E5MiQ15gWvuKM/MJdbgHqqaZ9kqHG4P4nmJLEWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLH6+G2wm6STdRi6W1ko39IRrfxONKj0IRY5TzEwitLWTmUBhV
	RXoGB+YbEkMPEB8a4qnuSXUDNPoz2atsakI+ZJtWc3fCmgsuOGuY44lFH/bNGaTSaERa2IwjawT
	yFOCOTfQ=
X-Gm-Gg: ASbGncskj+DaQqDNBO1m0lCwY2CimiM0VN/+TLxNr/gqc9oBt48ajT9aH3JqGVIwtTL
	jvgo5Qa38jjWl/5MnsVdU/C8QkJm6B8pvRRGhc0CNE3Zb6a3MwCuVuPKVS51yfs6GFDr3zdOsE3
	smo1ZuIvmtP8LPC2scLiMN2RQudi228rcb6YXJSnocILSHeZ+NYHcKLuiRuf2raZ+VKKKLt3MsQ
	M3F75ZhDlO/llC0SkAvTEXppuuRuiF6blw3xtt7ePJDH+C6r3h8nWuExfz5KBpQMJfzx+krjZ0C
	DBl15ar4uejtn4D0v4wKfDEB0cnS2atzQ0lNV3KRwivAwoIVhhqj6SxhhfgUOM9Ofo8b3sxtlCm
	ftQgS8FHN8uTdqM2/xSJW9liAoaJMInOg3sWKqzCtSJfJLGRcAmEhFazHvenJB58o2I4knwIbG7
	ViLr61eErsnC26q8An
X-Google-Smtp-Source: AGHT+IGZNLqfnr5O9iQKw3AGZpaVITwpLyAJ8L9qbJLvT8gNt+m55TMXIYqK3nE9Ei6s2lIpIel3tA==
X-Received: by 2002:a05:6214:194f:b0:7f1:62a9:ea2f with SMTP id 6a1803df08f44-879dc8829a6mr164160916d6.52.1759753722161;
        Mon, 06 Oct 2025 05:28:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60df0sm116491006d6.3.2025.10.06.05.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 05:28:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v5kKX-0000000EPrK-0UTN;
	Mon, 06 Oct 2025 09:28:41 -0300
Date: Mon, 6 Oct 2025 09:28:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/pages: use folio_nr_pages() instead of shift
 operation
Message-ID: <20251006122841.GC3365647@ziepe.ca>
References: <20251004032351.51150-1-pedrodemargomes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251004032351.51150-1-pedrodemargomes@gmail.com>

On Sat, Oct 04, 2025 at 12:23:51AM -0300, Pedro Demarchi Gomes wrote:
> folio_nr_pages() is a faster helper function to get the number of pages when
> NR_PAGES_IN_LARGE_FOLIO is enabled.
> 
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---
>  drivers/iommu/iommu-pages.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

