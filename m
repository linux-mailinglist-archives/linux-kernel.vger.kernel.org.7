Return-Path: <linux-kernel+bounces-865287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F32BFCB30
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AE2E3583D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6C13491F8;
	Wed, 22 Oct 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="l2jvMTVr"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA6E280318
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144830; cv=none; b=cPbOp/MhyJJN90fTN8AcBnWnKfSIZafwzXkOdWD65rHhLN+sxdKNwKI5fdVJ4MQKpvTDhWqXCSlcS3331uATb+HyruOTJf0SMjbSwB8IfIxliKa8JPT3C5qnkPK8wIPMGNDzuxMuoLfuSbMBKoFHBu0k9f3Zgz4kDARH0a7bSyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144830; c=relaxed/simple;
	bh=ExaNIFvj/8bzzKJ6c9wlj2eTQ4v5G+JNU21O0NVuOMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soqQnIV4OfFuViJ10YXwhhuoMAIbhH3C584sa8sCWrgkMOeBrpTbnX+y5wJUK81t9JN4nOTdBocIwh7g1ROmy8+3xXhjOmuJQsOwmXtUvFUAUdH2nWDZOTkJsX1FBipetGvsEdpfXN6fikMge2K32H2LFyVK6wav8w3hE9mRTVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=l2jvMTVr; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87c1f3f4373so127794586d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761144827; x=1761749627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1cfXdO6iFVoG7HfA3ugtXk5YCzyB+I2gK/iAlyV/U2k=;
        b=l2jvMTVrZZlVLfWWyG6iwckiZaJI+mKc16Myp6ykXb24JYmgoeiOMtLkDQyyb8SCWN
         I5tbKnD6rHELA/iTr9Xh8vFyPkNBgcRqekdyZ8XWt40i/tMLMh3Y47uitoNyXdaGax4i
         hQif+ZNSclKhJqw5SRpGSpT2JRoHwDT6Nz71B7v7oA57SDaS92gLqCAC1Tw2CJIhC/HJ
         0mjKQHTLVwho+0P4slFI1tVnRbxG35ctmmK9LIYQTR75YY5YlP29fkyp2BF+L92jzwGR
         XfAuvcd2uSEUufpjrtphb3HiYo5lBaofwro3mabR6pS5wsv6hfsUC89S7JkD2vjgUsyc
         R5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761144827; x=1761749627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cfXdO6iFVoG7HfA3ugtXk5YCzyB+I2gK/iAlyV/U2k=;
        b=nRNp3OKNB6llhtOORTihNPgQlp06EdGjdexm8HRhxKhqYJDbt1uZXeL+mcUijU398D
         ghpyEVp/FR/hKCW8yQb04V5qHVQz96wZXhlAqpCJzLzOblRhRxQkQ8hT1KUyl3BZf5Mv
         Tid0muaJa0e83Qxozvx8tcTpQkMpOJqBijDaH+wMeNTgSEUi1pZ8amMNqppT/QM4aYKZ
         agesiG3VQsF/jZqndjMLMmmv8/cWwPVfTbvwS3689F0qUvDFChgmgiXM+kNv4uIKW+0F
         pqzU5Vnc7vprDNxUC5hm3gJ4vWlei6aJRvDqggHAG4kkmUC1wVo2Kfkjw0kAphATMbkf
         v4VQ==
X-Forwarded-Encrypted: i=1; AJvYcCW53gnJuy0BTS/hLihHzwyAVj726HXCfqrpwYjronOAUP2yxwqJpx5rc5Cq1+Vp7XPevzGudPJVAxNtLUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzG211yDxQW4tKsRa+q3yw+k+7K4+gGG2hK29/sN0peocFNg1M
	GabxxQl9G1z2bXuKFOK62Eb1wuhjLv8vOw6xZNM7FEz1M1G+iUxKxj8eeq5VNSmodrM=
X-Gm-Gg: ASbGncsEEVSvsbHokZcj6Echu1nDJf6EEoJfITIkH9s1HWip7tghqiw+A6q0PAGYLEs
	1o5keNiyp7cWLRpHfWv3qheNMJdJ5zo+4IO0Yiel8i3wtUJnwS0vWEuImjUt7ZU1tEbJhjEOYZO
	LqcniahcNt2ZBycvC6/eQVXbqtnOVfxyfFZ4nh7phkKOdeBlK27i303+IH37wpt06JVkVn1b6wh
	Fb/PNCyyKpW2PVkmNn2npRtIdhA6fhRAimJROaLJ24H8pYBu1WfcbY1kl6bIGowakDdkEeWz+9m
	TcO7y3RY0mNyFYMyrs6iNGBrXctHwPOJAMRR8S21Z9IHBy91zjdcPNDe7c8rtBt0Bb3gSeU8vhO
	ctZP0OpbmnhUres7Q9z0baU5Szmz78DfAfwExqZS2Cef6mdW74oRZmFAXVIG53u/pjfTMmmQCCQ
	3h4VidinKuw831LjwlEXPE4eD/72hywh6YqZUmH5tYjtWqlrEmjgX+dFA242k=
X-Google-Smtp-Source: AGHT+IFHuMaMm9YG8UjNunKuIxLRJWBbIuuF0QSGwuVL9vRBN2OWA2gEWGQ8hVXwPZQWU1e1osSl+Q==
X-Received: by 2002:ad4:5d6f:0:b0:87c:2c0d:309e with SMTP id 6a1803df08f44-87c2c0d3796mr169678726d6.37.1761144827141;
        Wed, 22 Oct 2025 07:53:47 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf51ff3c9sm90532536d6.8.2025.10.22.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:53:46 -0700 (PDT)
Date: Wed, 22 Oct 2025 10:53:44 -0400
From: Gregory Price <gourry@gourry.net>
To: SeongJae Park <sj@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH v2] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
Message-ID: <aPjv-Kd2ZihLUqMS@gourry-fedora-PF4VCD3F>
References: <20251020210816.1089910-1-gourry@gourry.net>
 <20251022014057.128900-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022014057.128900-1-sj@kernel.org>

On Tue, Oct 21, 2025 at 06:40:57PM -0700, SeongJae Park wrote:
> On Mon, 20 Oct 2025 17:08:16 -0400 Gregory Price <gourry@gourry.net> wrote:
> > +
> > +			/* Don't consider moving same size/larger pages */
> > +			page = compound_head(page);
> > +			order = compound_order(page);
> > +			if ((order >= MAX_PAGE_ORDER) ||
> > +			    (nr_pages < (1 << order)))
> > +				return false;
> 
> Shouldn't the comparison of 'nr_pages' against '1 << order' use '<=' instead of
> '<', to match the commit description?
> 

Good catch, got lost in the shuffle.  Thank you!

~Gregory

