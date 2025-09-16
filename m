Return-Path: <linux-kernel+bounces-819509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E0CB5A1CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE004830C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1A02C21F7;
	Tue, 16 Sep 2025 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWIeYjJf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8E27A46A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053140; cv=none; b=ZszftruKftA6UI9NuoQIag7c4xmFCzGGdsBOKZX92U3RubCd62GRB4F2JrmpyGpt7llLD0TZM2NVaQoQUNMxe8jcHgLFT8Teb4lxrB6aLM/JPATWKhbNxMp8pT1hCpYLtgrPBjCV8t78ara2WUoyfXefyBH8aMMYK7hgokV7xQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053140; c=relaxed/simple;
	bh=y/6eUBEaYSo/SX73Jy1+Z/mMaSBXfm0oxSPTbXRy6w4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjQYJ+TkXmF1h+U2fdW2a4bk6BR0Ceb6gBFU4UgnXDeFcw+QivYDe2vhEY3su6019YkTbpPSVU1X1gel483gbOUbFLc4ZBbGkoC83uPLUmxcRihmBCG2iKTdzRW6GiKneqvD+nfd97MCmpPBHWZObgG4Ka9PlQ/96yhBpaibwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWIeYjJf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758053137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RpCQ4fVtk0nJ15mgeceVmsFUTpPDIkoZsDCSqJpWkuY=;
	b=hWIeYjJftxA2QpMfICXEaIhZEs9GgPfwGdDQIYPJ7bp8x+6BSDEj6MRoHUPnIsWrxWSYLx
	9eTRvyHWHgH+4oawWbH+87ym+xWYgQ3DIPnZMhu73+7/D+Zn833fnmv2H3CFjW9OgO0WJX
	zi2CIzJVnpv3yG+PlJsPnzq63fLZVpE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-vSrTFfFDNA-B46LLSKUARg-1; Tue, 16 Sep 2025 16:05:36 -0400
X-MC-Unique: vSrTFfFDNA-B46LLSKUARg-1
X-Mimecast-MFC-AGG-ID: vSrTFfFDNA-B46LLSKUARg_1758053135
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-783f069a122so62588446d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758053135; x=1758657935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpCQ4fVtk0nJ15mgeceVmsFUTpPDIkoZsDCSqJpWkuY=;
        b=sBhlIS0U3gaUjjF835fHlm1YWiVEzrNMPUNUaJ7+iwR/cVUHWdUUJfn+NCITTR4NZh
         Q0lbyhfYowUciEftKNMN8STuqSt79Hd1xZBZ7sSS+9Xdsq/L69UNMto4mws4/IB5Wfd/
         ixAcdHwHCQoY2c9csmXXBNdykKKVOHctCtogbJJ0x3rg5rk4mKJoJZgx7uRRyPdpszWp
         4hhhY0dU+81LRTdfu8WpZlHeqWqe6TglH0s5xHk9FSIFjEGLNu3s9s1LPxvQOSK11i0O
         6ZVzemXs0GhnFFAspKyhWkiu0m3AuHoXIpqg/dSOtSIefuqVZGPQuAAeO40l4xUh6MhG
         sgOg==
X-Forwarded-Encrypted: i=1; AJvYcCU/WUeMeRV/T8BmKo8rFyUSTPrKIvhNsolrrdohfisuFDBNU286X+OSzAMtiMp1vnkS9QU8Xi4FZZ8z88g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjQcFsTcBv1TYSim6dSHEhhnqIgfGSFXrGChA4R3D6aZHauv+I
	dbnKeDcyQ3yUH70plZVANjHbbe0u1aXCjcyx6BmVp838UZzB2B9mpVfXmB2FfaguDhhb3DMK5I9
	9okS5HvTZrlpufECIIgoGRyyONDB4h8kutTCoD3YznWxP7QzFWGV5sMhtWw/qWDhoZw==
X-Gm-Gg: ASbGncsFzTYbMqeL6NUs6GxiLAxzfqkA3bxy5TKUuTLNpu8Kzwl2WYR4W5rydbGrrO0
	ihkEBttCvXaF1442XC2BMzYp/yVxUCfhHDLc6QVc3tCCe6WAMiUkGIawCxmrETZWqM5Ofv1llVe
	sE/3hIlYcMIgHXbA498HMss7VbAJ97SznSbxnAWvfc8Ww1yR190Yfau+zO6QOTKnd+kmt8VTxO6
	tXYWAKbb1zK0C9Yl7/YtC/cDwTaXnuziLXXyOmGRmlNI/dcH709Kx+o9d2Wwj6d0qaO4wSBTGOb
	Bpe9c+9I0FSgmYO72T7X7+ixY3JWSfiR
X-Received: by 2002:a05:6214:202e:b0:756:a4cf:b1df with SMTP id 6a1803df08f44-767be6d5f03mr247719536d6.18.1758053135314;
        Tue, 16 Sep 2025 13:05:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfhupWWrTG8VxMqGQsU8BHddz1vAyCePst6r9UyWiXycB0vta1N1jEpGL7eOj4d2fvDA4mqw==
X-Received: by 2002:a05:6214:202e:b0:756:a4cf:b1df with SMTP id 6a1803df08f44-767be6d5f03mr247719026d6.18.1758053134748;
        Tue, 16 Sep 2025 13:05:34 -0700 (PDT)
Received: from x1.local ([174.89.135.121])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-773292c6357sm67482916d6.67.2025.09.16.13.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 13:05:34 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:05:21 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <aMnDAdMyuatKth3w@x1.local>
References: <982f4f94-f0bf-45dd-9003-081b76e57027@lucifer.local>
 <cda7c46b-c474-48f4-b703-e2f988470f3b@amazon.com>
 <aGVu1Isy-R9RszxW@kernel.org>
 <aGWMsfbayEco0j4R@x1.local>
 <aGbCbW7hUf3a2do2@kernel.org>
 <289eede1-d47d-49a2-b9b6-ff8050d84893@redhat.com>
 <aGfsaIIzHWfjcNFd@x1.local>
 <e7vr62s73dftijeveyg6lfgivctijz4qcar3teswjbuv6gog3k@4sbpuj35nbbh>
 <930d8830-3d5d-496d-80d8-b716ea6446bb@amazon.com>
 <jxekhkhbn7uk23oe24svxrs3vfuhseae57sqagndqgh2e7h33o@kfkygmrvjb5n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jxekhkhbn7uk23oe24svxrs3vfuhseae57sqagndqgh2e7h33o@kfkygmrvjb5n>

On Mon, Sep 08, 2025 at 12:53:37PM -0400, Liam R. Howlett wrote:
> What we don't want is non-mm code specifying values for the function
> pointer and doing what they want, or a function pointer that returns a
> core mm resource (in the old example this was a vma, here it is a
> folio).
> 
> From this patch set:
> +        * Return: zero if succeeded, negative for errors.
> +        */
> +       int (*uffd_get_folio)(struct inode *inode, pgoff_t pgoff,
> +                             struct folio **folio);
> 
> This is one of the contention points in the current scenario as the
> folio would be returned.

OK I didn't see this one previously, it partly answers one of my question
in the other reply, in a way I wished not.

Could you elaborate why an API returning an folio pointer would be
dangerous?

OTOH, would you think alloc_pages() or folio_alloc() be dangerous too?

They return a folio from the mm core to drivers, hence it's not the same
direction of folio sharing, however it also means at least the driver can
manipulate the folio / memmap as much as it wants, sabotaging everything is
similarly possible.  Why we worry about that?

Are we going to unexport alloc_pages() someday?

Thanks,

-- 
Peter Xu


