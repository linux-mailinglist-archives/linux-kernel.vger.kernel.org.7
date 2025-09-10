Return-Path: <linux-kernel+bounces-809166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C98B5097A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9683F5605DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2020F1DA23;
	Wed, 10 Sep 2025 00:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OdPE2yhQ"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123FBEAC7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757462506; cv=none; b=Z8b9FPdwwqxkr05+W9yVDgPOTOgahidYP2/WkTWhGpgQRlW8+R/y6ms8rxnkVGSDOqPBj6OYI8gXeirnYtDUA6fXzqi+qMcJXiO8lPQ3lYP5W5pYre7+2aj5AjM7dwX1KJfwexNr+HgPwynYaU6kOhDWJb3VLS8jHpogXtGV1lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757462506; c=relaxed/simple;
	bh=TL0O/aTwAdiFLd7yMVW0LqdDNXOH2G4wx0LoXiEpTik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZpL+9VTwL3l7VtQ8mCDPGOUlkI+v07fcDigyvKXldhnokBqaqhlxnwA0Bhte0CbMqc34OSyvc0hXl2ljCCvX/+DkX+1DWnIXi2IH0wuwpkQucWCPYAN1DuPquu+kDXpAlB0aiMFjMJkfJtZyv+je1Df07WHEth7Zfhg2n4hoFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OdPE2yhQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-25221fa3c9bso990655ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 17:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757462504; x=1758067304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IqcDWqfJLwLOyJ5y56FcG8QSqOyBU74DK/OOgsSQXCI=;
        b=OdPE2yhQXDXlrbUspVRXZTLlV4kPw+bfce0c11dImHeWg3gE1QAWHCvZ3KgDx9zsjr
         JynDmIdHpb2VDIuiIBlXdn8lqW/xMcAdvPTe2Apl0eDSRfWq9sSpG7O2No7cjUrLtusg
         P1EzUxyjcAaXJeVIZs1yrXJvvPnN3kE84ZaEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757462504; x=1758067304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqcDWqfJLwLOyJ5y56FcG8QSqOyBU74DK/OOgsSQXCI=;
        b=KhnUlzqamePr7DbswaAdOhhjTN7xbr0wUwmQB9R1aEfTe/0MVRbnRhsuAGaE8BZ95Q
         kJN8HEYv9TcE8NcjE8KrRKOnFf6yawrH1286BNIIdDuZ/amexekY+n10EA82D2eIJ/nP
         fFRF/Y15u/6xHPIE+wlF11k0b9srqywP4jXLK9dde+m+4KuIz/o8a8+U6U2VWGRHh/ly
         a9jIwVUssTzcL+ICguFQ9PswgTGZuGA7BbRbuQEhjRPyzQQ9LSrD0RGnVagvOn+TFVL0
         d3RR9ktoDnIR9b7xANUsZJ+pGNXCJTb+bY6ZFD9VXIACQ+HQBOHgib00QX8lrb29MnAQ
         IC1w==
X-Forwarded-Encrypted: i=1; AJvYcCWTrOe5XEz1OM9UXvQsbZC61k8r1U8koMm3lW+CSTBSbRyYUkG909JkjpfEwAi+3aX67ZJ7HXLqVVBt8+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg7TdxLHv7NsLFVfZ8/FCh4Z4fgvBFSS2Oxh2eH1zdR9GSel8d
	RP6OJA14rl6OlEO3wPXuMLy2k2KGXoZPUggrOxzkIXTNsbucYvKMs2krEP+/jrzcBg==
X-Gm-Gg: ASbGnctXCROZ7eDn/JuNC54kg1Y7A5i+vOcDlK85QOH157BGz58Q9rTNKrH20SzUWQw
	qtYG+mUQJu+At+/B/sDPqBMDezjsWJr/ZDVEsE/kXUJXVt5mUvqbTA6Y/U7zjhBr3M65/3wsE+g
	/S4PsdI/xcmv6ve8OYybQPxJE7w5ses1+v4XOe/+7fwoUqUrDMpr+7nXF7ksHB796YO6UGVREaQ
	dQZyvvz7mwwlu/foYP7orvpNoMKq/wnHffSs9iTiUSgepKFrZ5Z/PRbbqilRYjCVK46tMsLisn0
	8aNeO+rmL+82f/XgeFcKRIFnihE67a9uGc6BaBT0dS9IpVc3E4stL/QkKd+O7gAjGzHsTEYzkA5
	RDZuaTuCw62sfQaCdwqBQivgPpGVqFzBxCflg8HNqXy+cCzNKFe20pqeLpdLFOULdYHAl74A=
X-Google-Smtp-Source: AGHT+IEWQd9UQ3bAAMXqR5jg79X2RViVbY9wPPCVw9/Jc8wLdWf1qklDEFie7CGAphB6W0gOvDthEw==
X-Received: by 2002:a17:902:e551:b0:24c:7bf0:6e68 with SMTP id d9443c01a7336-24cedc7aa79mr255602615ad.7.1757462504013;
        Tue, 09 Sep 2025 17:01:44 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e1f7:9c44:893a:3857])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25a27422d29sm9186895ad.27.2025.09.09.17.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 17:01:43 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:01:41 -0700
From: Brian Norris <briannorris@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH] mm: vm_event_item: Explicit #include for THREAD_SIZE
Message-ID: <aMC_5baavoll9pBM@google.com>
References: <20250909201419.827638-1-briannorris@chromium.org>
 <20250909165336.c9505e477461fd5e41e6cfe4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909165336.c9505e477461fd5e41e6cfe4@linux-foundation.org>

On Tue, Sep 09, 2025 at 04:53:36PM -0700, Andrew Morton wrote:
> On Tue,  9 Sep 2025 13:13:57 -0700 Brian Norris <briannorris@chromium.org> wrote:
> 
> > This header uses THREAD_SIZE, which is provided by the thread_info.h
> > header but is not included in this header. Depending on the #include
> > ordering in other files, this can produce preprocessor errors.
> > 
> > ...
> >
> > --- a/include/linux/vm_event_item.h
> > +++ b/include/linux/vm_event_item.h
> > @@ -2,6 +2,8 @@
> >  #ifndef VM_EVENT_ITEM_H_INCLUDED
> >  #define VM_EVENT_ITEM_H_INCLUDED
> >  
> > +#include <linux/thread_info.h>
> > +
> >  #ifdef CONFIG_ZONE_DMA
> >  #define DMA_ZONE(xx) xx##_DMA,
> >  #else
> 
> Is there a known configuraion which triggers this, or was this from
> inspection?

The original trigger was a non-upstream driver that includes this
header. Since the root cause lay here, I figured I might as well patch
it at the origin.

Brian

