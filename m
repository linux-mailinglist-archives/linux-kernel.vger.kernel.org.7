Return-Path: <linux-kernel+bounces-755486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F025EB1A6DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24771655A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB72F25A32C;
	Mon,  4 Aug 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGyskVcT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E0B221729
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323076; cv=none; b=LHN7GJqtGyxSt5GJofqBEEzOcTYJKvK3HkuHMnr1g2tkCmCRjtehok3Hhf8HdhFBN3240iJjA5ITLNV8d/H4I9HaDQbz9ASwnaG/osepMmz3jhIFrwkM/1ucE6wGdcoRTbHw3gifCXwEOmcbz6vU1TLpwgTX63bvwpLptFGfc1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323076; c=relaxed/simple;
	bh=pDVC7rFBszGbUr0AQQyyEXmDE6L9VQjbDNm8JyUEdWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1s3B36G6LQ6lcfPSkeEEjGNkWqz2wzjeEemSl/NAY0CUyNm1m9iz479/KzmbUKejEQKckws5KWNAlnCcnvjBxqjlvjsRQ0I/OUSDxHBBNP1meg3urSuYeDUg0CTmebWf+W8gW/CuuPnCa8gKbYd+7srWZZxim4qn2ddWfZSt8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGyskVcT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754323072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9mUgdLRs3w5PT298F337vFTebghvsVRguazdU4qoq0=;
	b=YGyskVcTwjsLHREB+QQt4AOZcGB+wlB2AW8wQdojvfL2Hucvdrhw8MC+lKGTwtb4J1UlD/
	urDWUMitm1HEotZRqqxehBFKTK15dacSA0CiMWvFCTBU+OQk91Vuquw1NbMkWCkbs45F+J
	nEKnPpmSkAWuOJr3zVEwIgrydIPpvsY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-O_slGUjFMzG0D5V4mHVu1A-1; Mon, 04 Aug 2025 11:57:51 -0400
X-MC-Unique: O_slGUjFMzG0D5V4mHVu1A-1
X-Mimecast-MFC-AGG-ID: O_slGUjFMzG0D5V4mHVu1A_1754323070
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451d30992bcso29143015e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754323070; x=1754927870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9mUgdLRs3w5PT298F337vFTebghvsVRguazdU4qoq0=;
        b=jWaevbtwr3IgV8Y7gRZI1LpVsJfUSBpZ6g+uVbwGMTsjnNGA+a27szMJVGc6p/1zSg
         4Qa/Uim+x729ey4cocUa8J8RDw4j+RQD1lS4YQdw6ph4fQBtnhWcUOD/Q2ias9ZDitlL
         crOA1ygINz3bK8XaGGTiQfGe9Rm5O1wwFp/EcUalmh/2AItZPl2nIU1aK+Iq8RBpJyKX
         3cZZRo0jsmppMUK95b52nrd1bcvM0mFVa2eXEkqW3AeHz5Ui1TgaM4jESHrIyesj34gX
         tpzsqjp2c/FKjc95spQ2XFuqvj3e88u1wcnlZwURV0li8SknJmyOASIe3bFfUQXHZetr
         Cb3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7E2fbXZwRTttX1R3JTawRMEM9GLWn4F/7ojTfQcbRYY25x4SspkqWXCmXYxuhfMq3nc7zntXLy6KNNe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZxwnGm0RiLooMFWhKYM/Rqs5zPllMOIbrHhrKj5C3HMWJ0rEl
	zpzFJrorh37wObM+jAmszlGuTCqEdsVoC8ArbkH0K4F0k07P/p+13m8v26pnEce3qg68dtA3CyS
	o7NzYjWONOJECG+iUreLkmQ7H77VPPE/NKgFVL23SH+bGEWh4zF4t5uKu92q+QWRCTXEoS9cUPA
	==
X-Gm-Gg: ASbGncus03UaCvUT76sEXF9w8X2dUEesgFKrr2VtNJGnE31QK65GVFgA1vp0rYC6ppE
	9lynExU1iTq9MaZk/2V1HCk+tdPES3X+N2BKmcLnCOLrGQ6BIq3mJ0272nFfSxTyen7o/oAXixc
	5B4tjy9JuTsrW3O4uS0ClBZCLsX+yVVe3Q3fNCxBvOcwRpw5kyJ+j1+Vuak9Tt2aI/HS9T9cdtP
	N3/gu+rNLjIm/lWlmTzhIh/3OSnXKyr48mteXelShioPcL6FUDxTpJTEwQsG6lFN5sCgEUgt394
	vNoYZ5TOdmaN77+xDeV533iKDVuztdVn
X-Received: by 2002:a05:600c:19d4:b0:458:c059:7d86 with SMTP id 5b1f17b1804b1-458c0597ec7mr60423645e9.10.1754323069731;
        Mon, 04 Aug 2025 08:57:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvZfiMjphP3x3l4zUqhsolAK9PHooH9Tsp0BlG/3TnfFNZ2tCNNeobV4uf7R2ru3mb+8//yA==
X-Received: by 2002:a05:600c:19d4:b0:458:c059:7d86 with SMTP id 5b1f17b1804b1-458c0597ec7mr60423395e9.10.1754323069333;
        Mon, 04 Aug 2025 08:57:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e054036bsm6166517f8f.31.2025.08.04.08.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:57:48 -0700 (PDT)
Date: Mon, 4 Aug 2025 11:57:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgarzare@redhat.com, will@kernel.org,
	JAEHOON KIM <jhkim@linux.ibm.com>, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] vhost: initialize vq->nheads properly
Message-ID: <20250804115728-mutt-send-email-mst@kernel.org>
References: <20250729073916.80647-1-jasowang@redhat.com>
 <CACGkMEuNx_7Q_Jq+xcE83fwbFa2uVZkrqr0Nx=1pxcZuFkO91w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuNx_7Q_Jq+xcE83fwbFa2uVZkrqr0Nx=1pxcZuFkO91w@mail.gmail.com>

On Mon, Aug 04, 2025 at 05:05:57PM +0800, Jason Wang wrote:
> Hi Michael:
> 
> On Tue, Jul 29, 2025 at 3:39 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > Commit 7918bb2d19c9 ("vhost: basic in order support") introduces
> > vq->nheads to store the number of batched used buffers per used elem
> > but it forgets to initialize the vq->nheads to NULL in
> > vhost_dev_init() this will cause kfree() that would try to free it
> > without be allocated if SET_OWNER is not called.
> >
> > Reported-by: JAEHOON KIM <jhkim@linux.ibm.com>
> > Reported-by: Breno Leitao <leitao@debian.org>
> > Fixes: 7918bb2d19c9 ("vhost: basic in order support")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> I didn't see this in your pull request.
> 
> Thanks

in next now. Will be in the next pull, thanks!

-- 
MST


