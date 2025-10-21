Return-Path: <linux-kernel+bounces-863640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95828BF8AF1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95733B29F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE77266584;
	Tue, 21 Oct 2025 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeN8c91Q"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62DB1DF72C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077718; cv=none; b=grCsKOjKx6doMc3eKRFqb6FHqW21RQe2SOyem5deY8HsAdtlzFjGrvVr39jFj+q+QaaszgUzZujjt4So3EnX1nzy0GobtnutTXV6qV/NEWrmL5HbRmizUAu1lpwuTbB+CFJcy2o59VyyIYM5yINWrkC+kNBhLR/KfU+do7q5ovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077718; c=relaxed/simple;
	bh=s6KFvWz4dcnrj0IpV/e2G/kngD71vm0HSGfdRsMmNZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/+1NTFkmHvapylhEHxnbTHIkRrvrTJPC4GXGEEWWyX+q+1jRB1PA0rRk9hycyNrWEjkW97e5LK7F8Dcktz22go054iewt28CA2+9wLKgwYVnDlK6jUGrn1vVpBbwzwJT6bJHaItzqYsfCmxPqi5CD8I1FJTkZNRyCTFuUr5Fng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeN8c91Q; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63bdfd73e6eso539259a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761077715; x=1761682515; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itkucRp1pipf810tivY17xNu+wE6i4kYgosg1cEyOFI=;
        b=ZeN8c91QCh0Nd/TLqW9lyHWQpekcYA2/e2DJ08ycqw/LR297YcvCG16FUhmVQjpfaY
         IF6qfWdCcoYQ2LznoBe8g3ZReqL8S99YaYEhuWVd+x00Foj4hBiMpXiAPV/GJqGQlSpO
         aqtXRxhCL0ZBPg4MSDmzYMIVp9cb+s5/WoH8YBkmViikVa3WOjEQWJfocnSA8IRBI5UV
         IPw4OvVdrYrwO9WcI8tr4FG1e2BpwuvnEwR8kthop96+nPgw5jJg5pfI3nkpSnDmegYO
         wbjXw7J4R+B6gamWYQYjB7ZnHpCbRZE5yoT3tFo2rhzViLu4LWd6w1xp7DevQGZDt1w1
         Oz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761077715; x=1761682515;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=itkucRp1pipf810tivY17xNu+wE6i4kYgosg1cEyOFI=;
        b=fd4pwb+fN/44we8ZHm62acTlhrQg3dtxinX6ryl8tvI//uB1waCGo1Tkmehr0Q2UeQ
         a3TbrNs8HDugiis8MYASOlTZgs0cOFZq3MBMXe5s6kSVM/oT48FeABbz9SJVNi0i/8j1
         qXJuLfzjRgMuWWugTF7PhpjP4V1mPszHYGqT44OT9ihRd6FXVqv0Biq9kxF5CQGu3WXK
         YFu20X6l44lVbwjWM0Ea8AO9jT2jxWJ98CnG1bhPpuiCWVhPjUnUVhBsJNaZQk1ZlQbp
         kg6jhCQb90hhgW93S7KjXutqesTDnP6c/z/05lXERUMBg5RsA/JVXaGzDIDZiRU0bmb3
         bP7w==
X-Forwarded-Encrypted: i=1; AJvYcCV1Kk8lJgraVF3ZrC6wsSZVaMa01ioQk/99oDkIKPXl5UIGmypX6vLhcfoklGsVV1kb20r2r5DqEPquPng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+CS6CTmCJPkVfVSsrzjKnMlKCGexQ5fI1LVyLU2Rgw8PCvKce
	P/Rb8VGcZofJ3g4ehCWgKbj/FiwGgJmStVMSXcGWM1EJIDJiE0JOJ7Ih
X-Gm-Gg: ASbGnctINCkK+GPqkIX+ESCGiCmEiNc6nb35y1yE1wM2+bExxg8TqQaCgIvbZ2vxnf2
	tguOpcJJSung04EiVBoDCu3p3tEfFxtI/LniuYisLiyZNMORkhaoFrNiYKg5M5OQNbbuy0Nn0RK
	QlktMzwMfYKobx68Z8jjGQlvudt+vaVMTvbo6wUI52t1r3H0JkfCL1NGLyFaZC4PupuGxgbaU2s
	PrMqlyvS7IWkBD+FzXUR349snE+et3FABZrrzjU1nx8l/cLyX2fP2Y6jY/OJszGWU8h/YdNKQMg
	aDiwAn+dE9UCivvS/RtNPooD0yPrGHfRLzDl6eID5w0y9J0VeuE+0BbqqBFqiGOSefsUxdvMhK0
	ZqvCzHrhnoCdtlgdeZ1Yy+FCpj16CtwShxIHw9HShCB+L99004r+wghHydSQXg0VWhAHWVFBH8g
	kEwa7e6azguQ==
X-Google-Smtp-Source: AGHT+IFi1ufP7ILiwl8iMiFNreQBWCrP98ESqvJun7o/v5UkyLrrz4yFim+gai0vG/VLaE84nLJxgg==
X-Received: by 2002:a17:907:7e9c:b0:b50:9f92:fde0 with SMTP id a640c23a62f3a-b6d2c79b133mr128406366b.29.1761077714698;
        Tue, 21 Oct 2025 13:15:14 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83914fasm1139647766b.20.2025.10.21.13.15.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Oct 2025 13:15:14 -0700 (PDT)
Date: Tue, 21 Oct 2025 20:15:13 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Gregory Price <gourry@gourry.net>
Cc: Wei Yang <richard.weiyang@gmail.com>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, akpm@linux-foundation.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH v2] page_alloc: allow migration of smaller hugepages
 during contig_alloc
Message-ID: <20251021201513.kxhjiirr4nmzaw7u@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251020210816.1089910-1-gourry@gourry.net>
 <20251021012533.56rdl6v76plkw4nl@master>
 <E787AD03-DC67-4B5C-8BF6-C79F3C583D00@nvidia.com>
 <20251021091443.5ggfmvl5jwyknjnv@master>
 <aPeu29qbxdn7dmjD@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPeu29qbxdn7dmjD@gourry-fedora-PF4VCD3F>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Oct 21, 2025 at 12:03:39PM -0400, Gregory Price wrote:
>On Tue, Oct 21, 2025 at 09:14:43AM +0000, Wei Yang wrote:
>> 
>> The above code is expanded to:
>> 
>>   page = _compound_head(page);
>>   order = compound_order(page);
>>       folio = page;
>>       test_bit(PG_head, &folio->flags.f);
>>       return folio_large_order(folio);
>> 
>> If we use
>> 
>>   order = folio_order(page_folio(page))
>> 
>> It is expanded to:
>> 
>>   folio = _compound_head(page);
>>   folio_test_large(folio)
>>       folio_test_head(folio)
>>           test_bit(PG_head, &folio->flags.f)
>>   return folio_large_order(folio);
>> 
>> These two seems expanded to the same code.
>> 
>
>folio_test_large drops into const_folio_flags which does
>a VM_BUG_ON_PGFLAGS, so not the same logic here.
>

Thanks, you are right.

>> Maybe we can use folio_order() here?
>> 

-- 
Wei Yang
Help you, Help me

