Return-Path: <linux-kernel+bounces-807237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4B8B4A1E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA3F3BCF8A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153DA302151;
	Tue,  9 Sep 2025 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HKvrXipu"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4CF301480
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398635; cv=none; b=Z+AHZT36ePkfJEFqoyQeBJOfTmVdneAMmNv5wWv3WQ4mK2RQUekUdD7eL7Bdz7GxMzNT2n2YprhCUjDbuSerDtA3CZxWE0znwa+qA18sUatzZS0ng35WwClWVeVNMYDb1MRsrse1YhnlstMkHkdm7jQqCTX/azpRC4NTEJjO9EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398635; c=relaxed/simple;
	bh=uKqRJO9EbDA0M/n+nL4XIpp5IkXUSByhRgmgadN0f9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieTpYGfpNN/SueSMrQ8sIWKdEa/QwjZ8gfcfvd4XCBugAMfMCzITqnMmcZe3vdS3GjvVBNMitNDKuNlLNFQu5GqjSGPs7jdgFUNn9qBaQy1QSBiS0LfigeJYaiQZlbWn0EOwCJLv/pwQtNlL7qfCZ+8tg9dcrnpmcPMe/eIEZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HKvrXipu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b04163fe08dso887678466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 23:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757398631; x=1758003431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUIpY/hUwvUpbS15H++8ZR5q5CpymLW4Dqai3m6j5P8=;
        b=HKvrXipuU0gNBn9f5V9FU3l91/k/Je6YxfvYglChjQmYRx0YlSRG7zXGqqBh6RXxA2
         Ye/pxW9PWqeBB9uUsVmATHz7nXZW3zOM+5OgFp0EBWzIc4I3Dl9qIi/caHV5LvDdAUS/
         jCJI4eUITkwHXzX4n8O5KQJ08CzhBRLBix7w+sZlS2PtFcCzeeSjWVmKtJYd9sMXGiiV
         4U+gx9D/pbvqb1omG26RzJVxQd2JBMKXMcpvcH1BnzQogjnsxgh8Il1JKfmOOlWpBNo4
         eopOwLDiauZgCIHCcIIb9MjaLFtwb04izCJPUdKtEsVVn9dhwLOZ6SvQv1AtbKbUIv7b
         sdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757398631; x=1758003431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUIpY/hUwvUpbS15H++8ZR5q5CpymLW4Dqai3m6j5P8=;
        b=NGI/E/dSKg/+iLc0c3u+s0145lcg53U71rdR2Jwj/2ozkBkUQtiEh5PqIUhZ0GKVAM
         WBcKqnEkHYx/6idLjdDwod5nc5KhBleQNpb8n3ybN+Y+4ycNL2fo7s/LP2t8T61NB5kC
         OVOZ1zYBnHJzrlXOuNWYyKFoBHO4Wsk3dUUyHPRVjU6nc8WRK2etv4OyXGydwhSaE8Ry
         coEOB3s4WaPaRdIqz15siFVFIbnRqQcVt5mK7mnJiO21BGCgveDtY1epwvogrgUu2pea
         6fk3pBJuZbcejozLLl2g/HC9VwLtpg4y4P9fpvFqVoC4TJyDGjwsbIw1FuLbJxsQehWY
         8n5A==
X-Forwarded-Encrypted: i=1; AJvYcCUac5I/QeDLRmvnhm0MEEcjy05zhtc8S6n7bvFHC/+oTtiV9KcxDRl8mVzNyM/zXh3Wi+9YcW7TQVho5EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyRy9nuVsWEgrDsUE6eUqKLBpyVbmlw1//utzlrW5Q51dpaC0G
	RYBft2zmTo5RbFOdUM/thVQ7ENzs4fXJIUYgQhkfiTnafJ/oSVF3yVvD3pjtFbTky9E=
X-Gm-Gg: ASbGncvSbzD+4oYpBNEqq4eiStis+1tadtL7nDv7IVKyrCkj50cjuuZzZlHuMWSJpN/
	uogXBvRgllnFAIeNNu7gIRrfYvabZ1lGnUI9ytzN4L/z3710wcSqk6WzfVPjHJwGbUIZEzXMl8n
	8d04n4lGHWo1yrzSu2w25SUMWIkITtJlpuNvnIXoGEi72+ln38o6gzQS/b1Q1ZNhSlxZIbKddo9
	w3mCDEDvn2lTgOLTMIrVkRlisFER4cOEAJjTtGqSKeLxqpTNKu4alisW2nUlOxJlz4+i35bgzax
	wtEzbYCLeeYs4x+5+LcrvVtl2yXJ4wlPt4fRL1TGSn+rB1Ipdnnzfa/erwKk5oil5ky+wd4GkGs
	8+NwHB4gl4MB4+PTQUifuIUXW58V+b7yY+IQv+2S3Vp0zs0MVNNH856E=
X-Google-Smtp-Source: AGHT+IGLA0K5P73dswsNYikfMMmpLlFqC26fbLtRsRpLv9nuaLU8vXgG0Id9f1eI3msFaa2JG7mMMA==
X-Received: by 2002:a17:907:c14:b0:b04:3513:5138 with SMTP id a640c23a62f3a-b04b154786bmr1150331666b.41.1757398631137;
        Mon, 08 Sep 2025 23:17:11 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b047041dddasm1412028266b.72.2025.09.08.23.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 23:17:10 -0700 (PDT)
Date: Tue, 9 Sep 2025 08:17:08 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Yueyang Pan <pyyjason@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Sourav Panda <souravpanda@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
Message-ID: <aL_GZFkPp525rsfu@tiehlicka>
References: <cover.1755190013.git.pyyjason@gmail.com>
 <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
 <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com>
 <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
 <aK2/Vesgr9Xcl5gy@devbig569.cln6.facebook.com>
 <CAJuCfpHJMSd16j3ANrtJGVfLieHdeO_Epq=U9OKty3TV362ckQ@mail.gmail.com>
 <aLFKHGe2loD657fu@tiehlicka>
 <zerazodfo2uu5az4s6vuwsgnk7esgjptygh5kdgxnb74o2lzjm@fkziy4ggxrxc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zerazodfo2uu5az4s6vuwsgnk7esgjptygh5kdgxnb74o2lzjm@fkziy4ggxrxc>

On Mon 08-09-25 13:34:17, Kent Overstreet wrote:
[...]
> I'm not sure we do that very well at all now, I'm looking at
> __show_mem() ad it's not even passed a memcg. !?

__show_mem is not called from memcg oom path. There is
mem_cgroup_print_oom_meminfo for that purpose as memcg stats are
sufficiently different to have their own thing.

Now, what mem_cgroup_print_oom_meminfo prints is missing more detailed
slab memory usage break down. This might be useful in some situations.
If we had memcg aware memory profiling then it could be added to that
path as well. 

-- 
Michal Hocko
SUSE Labs

