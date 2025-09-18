Return-Path: <linux-kernel+bounces-823431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C230B86678
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A63586705
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96E52D374D;
	Thu, 18 Sep 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkcOwI84"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEAC296BA2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758219659; cv=none; b=GTxqhiQ45DLSGV7/nIT5mpB6/2LoDFIahlLfhz+3fTQYOPrYcubvPvWuZSojI5gV0I5XENIOA8RPpBFHDczRiNP4PW5DH0BrZ/AMZglFnI+r0ixnZxYFA+nbDOok6frRJXr3euCH3DWmaPGpj1en9WPxZQKCbeoPdmLbfTaAIAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758219659; c=relaxed/simple;
	bh=uaQ7IUiabtQ8rryBkHuq/otVzFqIinmr1r+b93eVX68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UY7D7qn3Ju9EUuol7kainlpayf9ByowH3fPlcWeuxaLgy/+JG6wL6NZ5rHi7b2V2zhw+uSN2KlGgN5CqgzOlViQDZ6izf+4eTWTVsyMbq+cffXl2djSoVQBk482ZWJdCdr6JjcqVzAREZgkVb9IvSGgbpYYNPAPvHec/Q09me/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkcOwI84; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758219656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5VA3ijQYKv27DV4SLvZvWkSfaGW+8Q5F0B6zn7IdzE=;
	b=SkcOwI84tgspsSo3WidAP2hjPtRea7m1mbsnTnyAuBrvNloOND90OwDQN2IcUVXjyx8PMU
	NY16dvTTkmHpVKRwgYFkzuG6HfWpn6ZbnpHycCwJ4casK+AuMhEWU23ETZ/3uKZqlHu61x
	oELW4lQFVhGpplvbyYMVrgLfjlQbgaI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-STVO34naNMS2nshhftddVw-1; Thu, 18 Sep 2025 14:20:55 -0400
X-MC-Unique: STVO34naNMS2nshhftddVw-1
X-Mimecast-MFC-AGG-ID: STVO34naNMS2nshhftddVw_1758219654
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-82968fe9e8cso371983185a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758219654; x=1758824454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5VA3ijQYKv27DV4SLvZvWkSfaGW+8Q5F0B6zn7IdzE=;
        b=AW/0ANsT7TMj7C6NW5dbRcHV83wKW94J3bkPoGSenbrjqncvSB7knI5eDppr7VyUxG
         +Rr5s2zNng2CmSS99SYr4APTysXRZQ7Offq6gdvQXv3CosPCAOcJrnOl+eLsdY+p18Ob
         1NM33qsiFnrwvhBj6dVxCSOICSoZf24U5v70LTy1DkWgKmwNw1QbrdIU+B1JxPEVxL/y
         B5IVKzH7Q1MBtBmnwx266p/6VCtSeNsvrleg1IhNZD09rQlhOctk7Wuch5PL+6gkfGQq
         njnwDyqUsExjbHezd2d7RZ02bERpLUrJogPFz9bCrX0vT8KsXMz+IkAfNMRpXdEop8gK
         qFvg==
X-Forwarded-Encrypted: i=1; AJvYcCUYKKDmsCi27KHIlNtqptRmCZbySoYcnkw/lUe76+XN2C/DlGOTP1TXoVfOHvrpQgOzopye6cAiajCO7f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBIf549esCLqy2ujhkGSEB2UFeAjlfmBCyc/j0ZGGY1bW0bKI8
	mAD19uIONIw/IjgAjDfQOj8X1XLz5mWCHCkd92A8itS7G3/0uAIVG/xV7y+KtLwsQH67Iy2D93W
	jy6334QVh+xWb7GCiXd7+3deWnEOsbNIppSCUllD5EJp3slPfVFWXilc5GwPAdpIcew==
X-Gm-Gg: ASbGncu/IAighsR7SVijUTH+ji1a31tmzlyU+ZOjVlK6tHwc95ZIgKlvSwsO1WBpak+
	VmPOuzQuzSYnJKejcYh41BH8Dr4Bch8G3+5mLVAg9mAeXXvx/SFslPtq1mQPaGSxyxYnk3nLqwb
	ypbafarLu1PVdmeATXwPGV3C62Sqpu5iLBzF1kWLtXHemWtpuaf2z8v2jt/0Qdi7Z/tBrvc4qwa
	LN67NPfVH9kxswE+oL4YcIxYEpOJiJUc9+Sdn3Xw+Ll7FG1oBRgS2oXL5SxddmH69pEHwoLznZI
	KBcK9lmgdYmXwPCATN78zang8sjNFXu1CpXSFZoRF9QATCoYqWc4LCt4bFFmMtYQcp7bpXUUAPl
	sraEibOw4qyaNq5IYhryE5A==
X-Received: by 2002:a05:620a:4504:b0:7e8:147a:73c5 with SMTP id af79cd13be357-83ba29b5d3dmr70207885a.3.1758219654553;
        Thu, 18 Sep 2025 11:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdSaJyu1WpitpTyrKCmwN5bGuXeY9Sw55Xa8528h1i3flXXvY6EQCqbcm6IpoYNJwYjC2hug==
X-Received: by 2002:a05:620a:4504:b0:7e8:147a:73c5 with SMTP id af79cd13be357-83ba29b5d3dmr70204785a.3.1758219654129;
        Thu, 18 Sep 2025 11:20:54 -0700 (PDT)
Received: from x1.local (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83631a7fc2fsm195959385a.54.2025.09.18.11.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:20:53 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:20:51 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Message-ID: <aMxNgyVRuiFq2Sms@x1.local>
References: <e7vr62s73dftijeveyg6lfgivctijz4qcar3teswjbuv6gog3k@4sbpuj35nbbh>
 <930d8830-3d5d-496d-80d8-b716ea6446bb@amazon.com>
 <jxekhkhbn7uk23oe24svxrs3vfuhseae57sqagndqgh2e7h33o@kfkygmrvjb5n>
 <aMp-kW3OLqtZs8sh@kernel.org>
 <du5pzxmfk6lile3ykpaloylwz4eni6disj2oe25eq6ipzqemiw@ybcouflfnlev>
 <aMvEu9m7fJLnj862@kernel.org>
 <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>
 <a1a48a0e-62d3-48d0-b9c2-492eb190b99f@amazon.com>
 <7cccbceb-b833-4a21-bdc4-1ff9d1d6c14f@lucifer.local>
 <74b92ce3-9e0e-4361-8117-7abda27f2dd4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <74b92ce3-9e0e-4361-8117-7abda27f2dd4@redhat.com>

On Thu, Sep 18, 2025 at 07:53:46PM +0200, David Hildenbrand wrote:
> Re Nikita: If we could just reuse fault() for userfaultfd purposes, that
> might actually be pretty nice.

I commented on that.

https://lore.kernel.org/all/aEiwHjl4tsUt98sh@x1.local/

That'll need to leak FAULT_FLAG_USERFAULT_CONTINUE which isn't necessary,
make it extremely hard to know when to set the flag, and comlicates the
fault path which isn't necessary.

I think Mike's comment was spot on, that the new API is literally
do_fault() for shmem, but only used in userfaultfd context so it's even an
oneliner.

I do not maintain mm, so above is only my two cents, so I don't make
decisions.  Personally I still prefer the current approach of keep the mm
main fault path clean.

Besides, this series also cleans up other places all over the places, the
vm_uffd_ops is a most simplified version of description for a memory type.
So IMHO it's beneficial in other aspects as well.  If uffd_copy() is a
concern, fine, we drop it.  We don't plan to have more use of UFFDIO_COPY
outside of the known three memory types after all.

Thanks,

-- 
Peter Xu


