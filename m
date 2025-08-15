Return-Path: <linux-kernel+bounces-770264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59593B2791E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F009D3A9FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461A629614F;
	Fri, 15 Aug 2025 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bc8vX+gf"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201DD221270
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238858; cv=none; b=kR17BYdPyFZnoTLVdHefAZv00YG3goU4J5lcq19wPMx8ka+6ViQHPwfGbX6HTYbUx8ar9jqhnznV+Tcezfh47IpD5NGSdxIpXI0EMD/3BKoV31YmvhbTinQk5JIi9WXb/agyxDH5+yJu1LbF2HgK1RLIOfNYw0ikuujLQwYx04A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238858; c=relaxed/simple;
	bh=041w+1IhnFDaJVaRjwsuLLh+nH8S5mL/SJH/pbTpOas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFDBaOguknxp2fY+JpqONBiHcz1hGp9sZK1oULE61xum/a+UglI7pG6ZlcHh9EsIBNacJV2Fa8svEST16WsRTHf9EDAuq+ELEfdX41w5lyJrEn/DhEdL2jRUO8zHNHXJctMPawJZCaHO6AAwxWpMCxo+JCya3pDq1vlOcJFvp/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bc8vX+gf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24457f47000so15280545ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 23:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755238856; x=1755843656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rR24//5Cm6vPMiW1pUvuDPyIFf9QUDVrJzX55PqcQY=;
        b=bc8vX+gfZVnFS4OUFl9vRLVyvH2drIiJLHEMjIGAuoFKR+TVk4yUw6rUIKTdb7N/oj
         9tJ/5pb4qDalBnsGZjaOGv295cNtQmrAJEuRypqH4lXEfWVNUhAXAk0HkMRqX/Ys1frq
         J63kFcEi+4LxDdygczL6P9I7iXGP6EEckslwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755238856; x=1755843656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rR24//5Cm6vPMiW1pUvuDPyIFf9QUDVrJzX55PqcQY=;
        b=sucwX3Tkf7i5JmH3zYYaUqjyB0h7UDotLMA5HOkJWdqDuVey+hckgCNxSVfKxpogdr
         wrORrGpjQtpClOuW0yuaMkFGQjVXWRaY/aESfEfr4ww0DfEJwC/+JI7yZfh0R2on1AUo
         xihssdiw1JBJA6Mms2Xh3jPkno6To0hK1GlsSLzLmtyojGjXwn9cMst/aVi+wl1KAz2h
         EQ9APFyVFFiabDeryz0Ol1dowXxzMrDLudaI+0djyqmogJcYibB4HqeytMi+/2OIr9qr
         vROtJW439wMzykvTFZs7fZfUSSaHi3JjBZj3XLLCyM5YlcSaVMyJi4HRRY8+wSFEJYQM
         VHUw==
X-Forwarded-Encrypted: i=1; AJvYcCVWUVBKPK2hl8ILXHuNCd7ESuogqmCdbHcPgVkkttlEo4jq87vJPATbMYJuCZbUa0KMdhDCO5ABVKv3hLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNrLQvDqJpSJKbif5LU9MneNBSg6f8cMmNHwF9gVeUuQRxJcdE
	G60Pv5S5IrPUBO3pAy7KJN5AGkFAXcb8yjZzWoa8HkevjRMCPuX+iXLQII74fkSY/wp33nQJe+R
	6K8s=
X-Gm-Gg: ASbGnctGlOcKxBa2MR9HgLBq8UNqKntbA1hfd++SZQtQonjEd+53UXUwpK8ei6nOIs+
	6tNspsxvFBYFogFKbcGZlmXc3RkZ2C5KPm1t0UA4xltY2gY8MPt3vIi+XSzVDDbdK1Su0ppOGiB
	CTuZPwr1PJmhQCxnVFMTccWEYGK1lSZDuOyzX/85dWQYaPUemqmga/0gk/Lj2fEEcJPiU+hvkYB
	escL7mtByowgIJNiYD3jWoYhalvNcemw2mZkJgz1hYW3DSJYOUyCoK+HBCMA0iBkOl3LXPCSIyo
	2YUGFsdlxowPDJd2/dJzk6cvzy2K2moSS+ox3o2iRSaFYphEW1r3MOGyGxkNFcEdYMTzm629bm3
	srBlgsMQxrZ16oPAAODUTlABw
X-Google-Smtp-Source: AGHT+IEYKXi8lWkNB18A5d01PalWbEiDPkniHD9LNzszKhC3ppcK5xRYDEJqm3s1E8UkeX5BahX4Lg==
X-Received: by 2002:a17:903:b07:b0:23d:fa76:5c3b with SMTP id d9443c01a7336-2446d745130mr16515475ad.22.1755238856391;
        Thu, 14 Aug 2025 23:20:56 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:df07:bcb4:bd69:d61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f6f6sm6675165ad.92.2025.08.14.23.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:20:55 -0700 (PDT)
Date: Fri, 15 Aug 2025 15:20:50 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Suleiman Souhlal <suleiman@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: mm: swapin read-ahead and zram
Message-ID: <dr2ndbnav6ynrxjixfjjsbe4jr66a3niplzpxcbbt3ztjimwzh@l47amo3k5jt5>
References: <7ftwasufn2w3bgesfbp66vlchhpiuctxkhdxp24y5nzzgz2oip@pi4kdyqkl5ss>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ftwasufn2w3bgesfbp66vlchhpiuctxkhdxp24y5nzzgz2oip@pi4kdyqkl5ss>

On (25/08/15 14:51), Sergey Senozhatsky wrote:
[..]
> For instance, notice how entry 1615265 is read, decompressed, then
> presumably evicted from the memory, and read/decompressed again
> soon after, almost immediately.  Also notice how that entry 1615265
> has already went through this cycle 189 times.  It's not entirely
> clear why this happens.
> 
> As far as I can tell, it seems that these extra zram reads are coming from
> the swapin read-ahead:
>  handle_mm_fault
>   do_swap_page
>    swapin_readahead
>     swap_read_folio
>      submit_bio_wait
>       submit_bio_noacct_nocheck
>        __submit_bio
>         zram_submit_bio
>          zram_read_page
>           zram_read_from_zspool

Sorry, I need to correct myself here, it seems that read-ahead win is 1
pretty much all the time in swap_vma_readahead(), so that's probably not
read-ahead after all.

