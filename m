Return-Path: <linux-kernel+bounces-853755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAF6BDC898
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68CB54F9825
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E7F2FDC51;
	Wed, 15 Oct 2025 04:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJwLj6cX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F961DE3A4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503355; cv=none; b=CsjHYfPcqnrGI2U0YBnd5++YhgXLDV3AYVsZHhJ0N6DPYAk5WJtAoHm3H/PiaP7qwwl4UovNFHWSl3fS+QA4rXpFenDjKNlIwYeQ3Jf13PE4YSHFd6mtVhN9n6ezslJ8AP9pGCOnKeKPWfYGlJN3A0WPV1lTTsR+c46iV4SHDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503355; c=relaxed/simple;
	bh=XlrI6HhhtbWfgJbooDdHmqfLWjFtEhdvpyOBSP2EF2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MN2HnsWkt3KoB6dypigZQIkHc9NbdsUGck/niyqSSfN0x8+FB1twFPrh7bc3Xock6FFLuAGkSR52sui4FMbcPddeCXNZgmHCIoMvKE4bhetIpfHz2XCwuTyVrXwX9RBVAP85nBrGgTS8T+C6GiY2iylzFFAXKJzukJsw/BIWQ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJwLj6cX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760503352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlrI6HhhtbWfgJbooDdHmqfLWjFtEhdvpyOBSP2EF2o=;
	b=WJwLj6cXMmXNKif6u60sSwWsRM4fguDWwyqlUVCd6lQJfyPqdA9rOKniHiC5em6EDMhAEk
	P2s7zWVx6odjvwmx6rbnte0HtsoKwGtPBYry8zSEOpA+yYM8tJ28Sh5sCbdcjVJZo6LCC4
	BY7/k6j4gIE/ppg3Wtp8R5Q1aopEs8A=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-KBcBaTG2MMSsgele_cTIeg-1; Wed, 15 Oct 2025 00:42:30 -0400
X-MC-Unique: KBcBaTG2MMSsgele_cTIeg-1
X-Mimecast-MFC-AGG-ID: KBcBaTG2MMSsgele_cTIeg_1760503350
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-8f4596b764aso2503648241.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503350; x=1761108150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlrI6HhhtbWfgJbooDdHmqfLWjFtEhdvpyOBSP2EF2o=;
        b=JfTa/PpTMvPXUyF/SHEmnWyLPEk94ZKr0Cb0nJWZX+o8LsLhdZVkku192GC/BUjwT6
         nqofkuNTSZEu25ipTYfTdROlIsNbHNPCTBbge6JiayepVRdSXkPOpCn4b4yyQ4Xf4RGA
         koVWh18BkCc2E5JGd979I4ycy98gz1jxcrtUKDURhGBbsSGM0II29rR0IF2ISssrHeo2
         9KwxlV9DW4ZnGP+00dZFZ7nxcIqoC4QCqOKGcPzIH+86Ukv/j8cIdXaiifPWbjRzKWvV
         k2WOUX3+ZuD4hkLsEAmywLk9PBWRG1Fz5rUoT+TeJC0jb/Z82mkN8mVCqxgjvbrLH0oA
         pNzg==
X-Forwarded-Encrypted: i=1; AJvYcCWzu+wqERAbzkLlwNRdNgb14HM+/3sA9P1udn3Q6C+srbS1/8Lx2Q+Yfn/6W8fMXkAwFcfHhYgp1VsCHX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys2rS5ZJviulj96cDZ+cJyQJw8tZG6+xuTVW570vmDpOW3pBwD
	6SPFjqQB0Xz+MZnnoq0GdXbFXk7CW5xdNhptUuIFiHEhzUuupXLb38wbE/dsVhuQN3BnHHjN01F
	jis0L7rDonKJwP8JMBkIALM4/Kyi5r2ZK5DkQui/OntH8PHIGeYGh5l+8BFD7g6FqWMFaCei77f
	niW8v+vrKEjk41n/lkrFfr/8Ble4Ja21LtMsCSTk3ZD5PNhMOfW3Y=
X-Gm-Gg: ASbGnctHnoxgjiWmnVmuuTCkbjbC8UtHdIASXAy9EQ/cQmA1o32Fvlwll3yTh4ydtrL
	wWvMZvzaptUWov3OkPKqLKJZWJ+NV76NYmFd0KUbocg4hE8U4p2wPwBws6QrBXETYMdMm8ntPkJ
	QguZEc4xlpGd/wvFGvRfXVOA==
X-Received: by 2002:a05:6102:c09:b0:5a3:6a6f:21ad with SMTP id ada2fe7eead31-5d5e23c174amr10189039137.30.1760503349759;
        Tue, 14 Oct 2025 21:42:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4rjxBaTTEZrvj5fOO/WyoesgQ179mnAgeRxlqs1rJ5f0KtvHDy/D2hvLV24ZHbjLRkLcfHElafKu6I26lT2M=
X-Received: by 2002:a05:6102:c09:b0:5a3:6a6f:21ad with SMTP id
 ada2fe7eead31-5d5e23c174amr10189029137.30.1760503349462; Tue, 14 Oct 2025
 21:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015014827.2997591-1-yukuai3@huawei.com>
In-Reply-To: <20251015014827.2997591-1-yukuai3@huawei.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 15 Oct 2025 12:42:17 +0800
X-Gm-Features: AS18NWDMNfscsxWtef_AfIWEBNofmodLju4tSwf43IMYgd8sSyIfnLFrLBKq46Y
Message-ID: <CAFj5m9+gw4LpcZmKWntih=zZC0Tuo8jYqE_Z9bYcFM8apPfbBw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: fix stale tag depth for shared sched tags in blk_mq_update_nr_requests()
To: Yu Kuai <yukuai3@huawei.com>
Cc: axboe@kernel.dk, clm@meta.com, nilay@linux.ibm.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
	johnny.chenyi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 9:56=E2=80=AFAM Yu Kuai <yukuai3@huawei.com> wrote:
>
> Commit 7f2799c546db ("blk-mq: cleanup shared tags case in
> blk_mq_update_nr_requests()") moves blk_mq_tag_update_sched_shared_tags()
> before q->nr_requests is updated, however, it's still using the old
> q->nr_requests to resize tag depth.
>
> Fix this problem by passing in expected new tag depth.
>
> Fixes: 7f2799c546db ("blk-mq: cleanup shared tags case in blk_mq_update_n=
r_requests()")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


