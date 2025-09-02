Return-Path: <linux-kernel+bounces-796990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D33A3B40A7C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F4CD7B12D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A2A32A815;
	Tue,  2 Sep 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GFmOrcpS"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C87E2877FC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830285; cv=none; b=OjiHG+fISSUF6rowyjK4VCiX/ZBCUKU03CsuVoR52S3zBPHTAfWwSyBH75YMQhmQGIjlYV0LydDIq2RLrNvAhJhDMcTrkCCK2jQslg9n3a+Ce3chYYZ/hy950bRYnZNSn5IiYw5h/tWNpfSbl20I7UwvJBnM/fvmEeGfY7apgc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830285; c=relaxed/simple;
	bh=pqF3A1jWAymNqoyZqZ1lyLwx5mWE7UM92rN5uoXyU28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTx1nkZmfAOM+Y5BHPrxAuwvAywtWc0kzRArdFuEfdpaGkdsgh9hQ364woxWMTDnw4AzZRjoFXLEJCxNP1nGjEPulgcR6Q85aA/Pfw9XACPAmSMSnR3HxBOF6uYHuwSExfhZ6NDolrYNU2Oh8P8bbbyAiNnrz+FAYEHH5xY7aG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GFmOrcpS; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7fac8fdea9fso509144285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1756830281; x=1757435081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fhd34ic8mzL1CnzuBvjvCTALN3sKLJ7EfG+67QvagDw=;
        b=GFmOrcpSMwOXPw0dfTTOrJKwgN5ofLJJ0zv1jY9K2qeQ+Mv/4lRbHhiHE7v1rxT1dd
         XZde0CFJrT4oSWP/rdrwwQsiGp9Nbxq5XHQ+se29RqFwsElFTQs6EFmCEDqIo4eD2oIo
         H3C8blwZaKPvKjTDl+//rJYvWWGHJgZN85nTvU49jt6RmdwxlnBCXhjde+1yE2nP9KwV
         K1GryzWDMTmPKy1Q6MfqeYFzMQ8AS23URlJTh8VRNWAJyL3q2WusqrwAez0eEcsqYKHI
         LKP2IXjbdMcjieAdtj3BUg1ytPWcaqLMv1MEuCwpCVKhajgIAK12MLO9SrixRRSx30XB
         CBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756830281; x=1757435081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fhd34ic8mzL1CnzuBvjvCTALN3sKLJ7EfG+67QvagDw=;
        b=joQIEEahd3RFPIOq/MK/h8h0Z97/mC8dyVziR/9v0ZwIJgZbReMwvcSvVIknefvYGi
         ysS1rGcXs+HKU+w54YfL57AqDej3PqfIOfaVGlla7//q+xMpPvDdFFzzB9SvPoNOM80v
         fUC6s5vPgEWaP0key9w5LWnSIVPZIj2wkXogTB4wdOscPzWG2Q9MrdunY0bPDbwSQl9d
         ioxeiU7buMxq4hoDVGjAqVGCkSAsgY/304S6dyh8sV180nTMK04g96kJTXEEp79h4Xb+
         jAlor59gtGG2HmFd+Traz9dgj+on3K731UAhydosigbUvHKZzDytRc1ONZK2gWd+PbTe
         QwgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwNPpeVfSlzmQTmsLoT3H2b3GyA9nF8FygYmq4XJHqtDzJHfLdA3A1KrM7f6u3lrYwIf2ewPg15nwa1Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNlspcScOUvqoaNAkOpLE0YAZZqEUms74zn++4tQhdPI3ac3vE
	lkBtHi3GOR6TPIXSoWgZO4N1aN2Z1p2rNOaToDscivK3EJWreuNga0z/SNYa/vewtj4=
X-Gm-Gg: ASbGncs7rUKP6bbzzOWMnIM30CTHn4Hv/9YqQtm+g8CAEy1kXBkBegvsekZCPUVYXut
	4q02P4DEZKWk1Og9ASDO3CIwuTGu3cTXagWZFUaubF9xcXV7virLLJT9S7+S8+2Pnx+4viNrKe3
	3HWBZyxCGs3ilXlzY/q+xTTf8mhusOcd43dCSIsbEipwBsFsp9LcKX8xJyQrjnTKXPE0Ve7whz/
	D6BPhHtd7TKBhV6Or71VEnwuqw/HV18Q4thsOg+fVq1Vli/3gpXX9ICHd17S8B1egphORNNoXPK
	9N54+Xtjxj9emaTNWtSiiRJE5cUS8yohMoDo1Czx/F3jEwCbi0y6MD6Sn0woxmOHBocPRU8va/D
	kcwi71GUnMZqP/gOgVYYBd0/JN88wCfBxQNBCGUuT27uLUzkcdkCOSX/hzpeAxMULtXC2GRqlYd
	2Bt9o=
X-Google-Smtp-Source: AGHT+IFCmoKGYPOzoDZD6ShSos2kBzyGiUpy55RzSfApuV0xE2xqkZvPVRQqUDWaI6ZQr/kUBpd2Ww==
X-Received: by 2002:a05:620a:28d2:b0:7fa:3951:1156 with SMTP id af79cd13be357-7ff2b0d986amr1327141085a.39.1756830280947;
        Tue, 02 Sep 2025 09:24:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-806bb61ab36sm150217585a.5.2025.09.02.09.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 09:24:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1utToF-00000001ZQD-3cFQ;
	Tue, 02 Sep 2025 13:24:39 -0300
Date: Tue, 2 Sep 2025 13:24:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/omap: Use int type to store negative error codes
Message-ID: <20250902162439.GD184112@ziepe.ca>
References: <20250829140219.121783-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829140219.121783-1-rongqianfeng@vivo.com>

On Fri, Aug 29, 2025 at 10:02:19PM +0800, Qianfeng Rong wrote:
> Change the 'ret' variable from u32 to int to store negative error codes
> or zero;
> 
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but it's ugly. Additionally, assigning negative error codes to
> unsigned type may trigger a GCC warning when the -Wsign-conversion flag
> is enabled.
> 
> No effect on runtime.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/iommu/omap-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

