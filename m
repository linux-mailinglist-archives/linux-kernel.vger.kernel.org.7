Return-Path: <linux-kernel+bounces-880669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A861FC264B1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70CE2188FCB3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA1130171A;
	Fri, 31 Oct 2025 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AC+KR0IZ"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC62E4254
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930539; cv=none; b=fgB9ElTMrGzYmC9C9sjVAOCP/dWwF7B9657V2B8sOZZKY5Um8Tu+Tn8243InKGcGy9phnwrhcc+U508R0HU6HPUCHZw2Sl7pHFb96zbBiHdH2KF3IOfDpKWYOGnScYD1rY/DmHfI3nFe2yxxwCbbo/ojg+QZQsv+uZ+sddsEMeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930539; c=relaxed/simple;
	bh=+i8ZQoycELSQ103UOhO+mdZBcfAiIIrnA4J6dDV9Rf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqEGphNGdjik7oYFqNPAFfMwcfYhsA9HnyTIb3b9o7BRjBKnjQcOfe/6WFCgKOweerAtfaYO0KZXYvbIJhnJ/IFfVy6RTv0HbLxrOPeJRuzM15TRb1TFxaipWPuy9kreCuXHAlIAgLIvyLYmpRbLGSmwF4Tidr2CkbONaRTZ5hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AC+KR0IZ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-87fc4d29301so38093276d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761930536; x=1762535336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RBTAuVS/sQ3VXQZHeQmZFPYxDEAuSifyHPnjgyaRJZ8=;
        b=AC+KR0IZfRGme+akB6A0fwMMIQFg4vdjSSOMlJbqdk89PL/G7m1abGKO7O/6hIwq2J
         ApoJ4nvNKi+7RiC8ivdrQmFmf1UIG5GKipNYB2rRdynzkZTiwHfMQc11KCvmGM8Bf4He
         9uDU3pVbWOqDYu2TGuii3C8aEo9/VxlIRDkwTFlQYxvbs4jXeU2rY4sh1FdDb7xJrZTM
         CHj3XQqRBsAPplzoGnUO3HovhH3Igw7CMCGZ4H7hCZ2zDpfVEVVNefvEUkNUZekneX8A
         SxpGEraPvKN7JaO7GWIhi5dAIkEX6or2y8OjNFViWkx0yU7wK8o04uQN6p/yI2qGOVWS
         BIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761930536; x=1762535336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBTAuVS/sQ3VXQZHeQmZFPYxDEAuSifyHPnjgyaRJZ8=;
        b=HXHHxVUUshY12U8VGEFGfa68ttfp9CVYZiT63+eGJj4GMLJo/VXd9MJOzbsZJNv5p+
         A62lnglgl8drUgL6iVwmdeuh//lq0NPTlTaG7z+kbkDhhbcjjZ0H7qZmaMDSLo9ATNbq
         8iOJikbiCq5tj67AYeRkjo8A4TecuFy27SgSMvHLUFdUtTNhzAQ9Lk1BOjTJluEueUYT
         Jz4puBhrnEYc9R+yA7II08zgcQJTan4V87gd0XL6HWZjBse2I4HJLajkyLG23HFlyquD
         uI1DsGN4B3i1v3N1/Xux0+hpjt7s8gk++/ZriwJTCxhJtpRyYMfhX/JFJkU8AVkTMdjm
         uRzA==
X-Forwarded-Encrypted: i=1; AJvYcCUWlhWg6YF/RctJODXEuKyaudpirco7tXBXQqrUEu8w0E/p+lVVM5tR7ykecanqURToEmTNkVSDdwjtmck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeA6AVa5gXHgQdE5QVP2gIsIAmhKwhn3AvE3v1yrwChAHBKUc4
	ltcCrwCVMTpavPdN1V+3htL3myawRSXkVSE/6+YxJxjWmQjoOgMbCxPgc4iH2PUf/0U=
X-Gm-Gg: ASbGncvA9ErhD7zlNt7/XF0KbjbV4ByLwjavpIwQlBbZNn48TeCNimeDtYti5sF9JNq
	FlLquKpVSkbQJfT4yM17ixl4o5orbYbBD3LqZDaPJQ1GXiTR5j93St/c7Gh9vfnOyB+lCn82GAP
	elOXGOfDq0xeOPUkBDKoxtZ/2vTfWQr0xedJsxNPEdcsHpWL5tP1ZMPmePrSRXKa0IGZdVal+TA
	1qv6qcf8FYruIAFUKHIGUIGFgk4/OIEato7Y8n6fXCVXvgsM3k+3JB4Gl4OFyhd1L9iKTtcAgeT
	GENZZ//Nknx2WjlqcD9DLRECDNL/e9Dgb3aFlP15y/tPz9wwoGdxJXWIMxt9QNd9lCiBfMpIRSy
	TIBUp/eKUzxOjzb1t+tvOxsj3p875W5d5YgfyMo9qELhV4/ujSBFnzhfdDJkCLWcwHPdwcBAb83
	0bPBJ5Dn3Jt0UG1RNss7HXPogHPp6zDNejly86wOtOGz/beQ==
X-Google-Smtp-Source: AGHT+IGG5ZGx6z+RQHh9WYWUaZzZke4tiLtpbh29MnMDJ7MHc4q2Mxi4KBypDwpLY9ZKti48DkZCFQ==
X-Received: by 2002:a05:6214:246d:b0:87c:16e7:892e with SMTP id 6a1803df08f44-8802f4ea951mr56300486d6.62.1761930536323;
        Fri, 31 Oct 2025 10:08:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88044879326sm2392456d6.32.2025.10.31.10.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:08:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vEscR-00000005mGA-0THn;
	Fri, 31 Oct 2025 14:08:55 -0300
Date: Fri, 31 Oct 2025 14:08:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Longfang Liu <liulongfang@huawei.com>,
	David Matlack <dmatlack@google.com>,
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hisi_acc_vfio_pci: Add .match_token_uuid callback
 in hisi_acc_vfio_pci_migrn_ops
Message-ID: <20251031170855.GE1204670@ziepe.ca>
References: <20251031170603.2260022-1-rananta@google.com>
 <20251031170603.2260022-3-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031170603.2260022-3-rananta@google.com>

On Fri, Oct 31, 2025 at 05:06:03PM +0000, Raghavendra Rao Ananta wrote:
> The commit, <86624ba3b522> ("vfio/pci: Do vf_token checks for
> VFIO_DEVICE_BIND_IOMMUFD") accidentally ignored including the
> .match_token_uuid callback in the hisi_acc_vfio_pci_migrn_ops struct.
> Introduce the missed callback here.
> 
> Fixes: 86624ba3b522 ("vfio/pci: Do vf_token checks for VFIO_DEVICE_BIND_IOMMUFD")
> Cc: stable@vger.kernel.org
> Suggested-by: Longfang Liu <liulongfang@huawei.com>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

