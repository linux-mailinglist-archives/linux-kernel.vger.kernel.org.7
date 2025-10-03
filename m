Return-Path: <linux-kernel+bounces-840986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFDFBB5E63
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 06:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D5624E4DC8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 04:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C651E1E1C;
	Fri,  3 Oct 2025 04:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MlmSlt0h"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCEF1DE4E1
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 04:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465713; cv=none; b=NFtkkoJjcHtEh7njtvX9K5ytH570v/GgU/Dg9kuY0JqlsXacaqGGyPRhIG95/juspxPm+pdkiHxKQXKY6jO/qHGuDzNoOdjBiQAuGC7hqnV+O089gFqSGFxGVrM1ccPIrT858I4lJyQFDaADee7JZHkkmZh1c+DUZ7Ehs1o+wfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465713; c=relaxed/simple;
	bh=1x2paevEmWZL5BjszJy+ErjUTaRao5sLqmxxx5HKEOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pl/6dn5w4EPfklgEnxKIHd+NdFYV29Hq0NpJZf7VaNcgjwPVqzmrAG3Jy4BOWyX1p/kKyhiR7mM1DPI9sRZTAqhUshYbip5/ktRej713RnynTm+0vNVXnhrZzcZhCxQpb0wxj6SN4p0jb7dKOKuM6bBZI7vNbwmuxMW+fMkJHjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MlmSlt0h; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-854585036e8so185232985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 21:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759465711; x=1760070511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l7laoun6BLBv+J0t0ls+E/q64BCmeJXWHsIjdFyERJY=;
        b=MlmSlt0h2Skh5fh++xPO9IuU2DwteyxJPTbKrzRiQ7aLF0y9qiS30+VU9SCy8rpCc4
         AViBXO/DbGFwyQFiwlL/Crm6fNx3eFmUEv3q3EywmFNaXaN84ak7PRloFQgjemoh+6V/
         RaKWW9oU/n56F20bXln6SO+J8Ee7RJjVv6ZX8ZLtFxyOXpN788EujbuHchTOpkInMMS6
         PA2iGwTVYcJPEq+ZRJ3FXrT69JwLxkX+qc9tXqoxx+OJhn8VqJSET6YeKZtVUJco2grj
         CePc/O5w7NVsYYu/tGRkbjTVVOiBC1G7bliNgNJbEyyo0NF5GOvSCxSAebF6JNI1EUWd
         zCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465711; x=1760070511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7laoun6BLBv+J0t0ls+E/q64BCmeJXWHsIjdFyERJY=;
        b=luaCDwihPQAlLJKdtD1idRvKxP3MbaQ8UyuJjNSdWqRIecN9nnbnSmRZb+Vig3/eBg
         L172GBa0KGshr9nZyQY6NQPKBymgt0t002t5Vv93fkWfFWyDZCQAJRnoVZKie4v0abN1
         UMcQg0H7XJW8Lld+R/NtT8xqInAb/j72d347TK+FNzICVnowNIKk5RYtYaNTRnxoio9J
         jZXMIZaDysUQw1ozb5VSrL2Sd5PzU6d2gW0N06dDR2Ojq9XTMNw95mbLiUDDzhYuaoJB
         54ndwG0YCribikm3gi4U8VCw6HyJHaFDoHwqPb7viGEGHVURClPODzY0XA/X/VPZq9th
         J9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCX0ojtkWLIgGDhcMP/zjPm8VCCznMOqe9Ay+2xcQWsqbK3xseJaGHTrHLzPWNTGvaD7stFHVIri9saEPWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwipRD9LJY5B3gjNbSBLc51hYKIPfI8bbUnDLZr2RfRwHQvwYYu
	h/W1VDEINiTsUWvWUkED0MSPewahm+V4sNq/woHH+vKGui+64bKS5ZZUIdHn/z68DIs=
X-Gm-Gg: ASbGncsQbOxiGUGKvk3k9FbeP/FOrNdLrIPubMOukl3ozNFUyhoEazIhbJEByUnHb7F
	XjVR+ejXcWb0AdsEJwGkxo33iYjT80MI0D2ZZSfiP35kndBr+iINkAo2kb/DlOeKeNeNwfVY9fP
	S0GIk4f+9OCuMzUVwmRMSu4vqE8hl6wpYpkepBPj28tPxM+gbaZerdT4jG8YJSDSI5KEAl44kPv
	778gUxCbIzKWt78eTkdWiY3sRdl6kq9KemcRo/JBy0joBYGTH9Z05akoCHsUukqcuUH/u5JbOdR
	N92ZqXJ557wzhAFq6mJYT6VjoLKS2080iUF0EuUqG7PNYpnzMjS1uBtIfO+E2WV1cYoal0n/L/M
	CzBz8o2am3pOmGe7CTtM5omyJ4XZuqNuAgb1NvLHV3GeF52hwZnDQ+sb6i56IOi04GUABMWNJhb
	BJ+pBoJlaHO5nwwb2LavjJGCdsmlj7HWMgGozC4z8K
X-Google-Smtp-Source: AGHT+IGoBfg687Zb0RivQYwvewlvLSVf4PUprK6kWqW3uH6tsrVVwD5VkG2ol+cbWe6+E0nQGqpCyg==
X-Received: by 2002:a05:620a:40cb:b0:81f:eb9f:8564 with SMTP id af79cd13be357-87a3a258232mr249702485a.47.1759465710899;
        Thu, 02 Oct 2025 21:28:30 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87772740ef4sm335463485a.27.2025.10.02.21.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:28:30 -0700 (PDT)
Date: Fri, 3 Oct 2025 00:28:28 -0400
From: Gregory Price <gourry@gourry.net>
To: Vishal Aslot <vaslot@nvidia.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/hdm: allow zero sized committed decoders
Message-ID: <aN9Q7BxpPOSYBVU5@gourry-fedora-PF4VCD3F>
References: <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <cb300580-1297-4d4b-9a3a-2cf7445b739b@intel.com>
 <SN7PR12MB8131FBDB82D2A3A539FA09D0BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <70a2ea96-0a4b-4185-8f37-ea77ed757b64@intel.com>
 <SN7PR12MB81319CD146CC8B4CFD45E62FBBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <SN7PR12MB8131F796BAE8B6243E088879BBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB8131F796BAE8B6243E088879BBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>

On Fri, Oct 03, 2025 at 12:59:07AM +0000, Vishal Aslot wrote:
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index e9e1d555cec6..50164fd1b434 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1047,10 +1047,10 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>                 }
> 
> +               port->commit_end = cxld->id;
> +

Went looking to understand what commit_end actually does here, can you
help explain?

>                 if (size == 0) {
> -                       dev_warn(&port->dev,
> +                       dev_dbg(&port->dev,
>                                  "decoder%d.%d: Committed with zero size\n",
>                                  port->id, cxld->id);
> -                       return -ENXIO;
> +                       return -ENOSPC;
>                 }
> -               port->commit_end = cxld->id;
>         } else {
> @@ -1210,6 +1210,9 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>                 rc = init_hdm_decoder(port, cxld, target_map, hdm, i,
>                                       &dpa_base, info);
>                 if (rc) {
> +                       if (rc == -ENOSPC) {
> +                               continue;
> +                       }

Don't need brackets here

>                         dev_warn(&port->dev,
>                                  "Failed to initialize decoder%d.%d\n",
>                                  port->id, i);
> --
> 2.34.1

