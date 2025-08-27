Return-Path: <linux-kernel+bounces-788113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC8BB37FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3BA91BA5312
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BA6346A19;
	Wed, 27 Aug 2025 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YU1cDRda"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063D323D7EC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756290241; cv=none; b=PxKsCuqUeD6ZPVDn/nVIMY0+keH2sfQWHyXi559C7FDjoPS4n+2AFIJuDkRGU7lRk6mVjGsyqlg9AritE2ZLeg1oNe53nzHxNt7K4vF5oEe6NGZCoE4hjZ+tON5amSCTUE/kYj/p1TDL9xVJn+m6OktVIPqe0YnbpYM0mOWgiqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756290241; c=relaxed/simple;
	bh=fhHeQECtsMPogCHlxKASHLbxYpLR81Rjlh4nHtxZrIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa1NXGAQ0OenOBW3CJstSb3ZmrB0aN4J6DjgAQ8MJE08pdSFagge3xqAun30zSVsgJ0GJXpfTOK4HpUdJ78WLsEPsD/wwKSxX9NJdtLC8GAtMGDHAzoOgg21WVYUUjzwmg3dSVtBTx2QGd47a4y36GOaWEVsU3JP/APC8O5Zij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YU1cDRda; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756290238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5mmeUW6MPoGpFuDnaAdEqf7QqySNZXWiteR+71+RR74=;
	b=YU1cDRdathF00VxuUsb2H7JR/kXsKY+vntiyIjAu3l2kxuEb4U/pTX/3xwRjE/7weQ+tIZ
	7Iljc/+6LCzkbzZUYEHOYJyPZfYRjuD5b4fvSG0rGZQiHvF/GRZMoGBngA84MsbAkLboVW
	TQJUoWhlQdMFj+TsxUzHcZJ6izLthsQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-bwr10bXSPJWGUjXQb0Zp2g-1; Wed, 27 Aug 2025 06:23:57 -0400
X-MC-Unique: bwr10bXSPJWGUjXQb0Zp2g-1
X-Mimecast-MFC-AGG-ID: bwr10bXSPJWGUjXQb0Zp2g_1756290236
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0cb0aaso50400575e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756290236; x=1756895036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mmeUW6MPoGpFuDnaAdEqf7QqySNZXWiteR+71+RR74=;
        b=T7xMF7XBiPEUCZZB3AzV6+Mnt2lzUGVLn8QctBygPEKT9VtD6A49Vt2RKTT9yXPbLT
         ughpPzc1l+qxYF/ISWCruDOLQwFJQLcqG9zm43Q4ggLmof1uFCHAVj4TWOUUhaggDVyy
         1/c7jO37i4Zy4jfw3wcdImT2FPNroRTK9oodZ30YqFpCf3hUgkAYXNHNGpvOMT1vyeXp
         26tAgJrJzILtA544FBut/8Mp4REutC4tVfqZ2trL6JPm15ktXA8XfixPUqnXIe0YijqW
         FrbjEY/85llCKNFVNU68K1wergCxkTbCzPsHvtLUsYyxTS5DZLlY5CcMTq3O+7RH5Svf
         ANuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZtZVt/Wty+O8ZivyfpDrbgQ/b80BePqObFY17MSZRWC5Q6WctrQHg1UoBPcCO1S4EDDsLFQu6feyP2ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoa4zENnaAcPc+fCmUmpGjlOfCSoj1sxY0xonop4Idou9cMLzT
	lJfOYrK2V5FPkEmXBGBzApnj7LBgE/dkEd8W9FNSxABP5nm7p+UOM5aOirqO1uHiJHwkiMYFpNO
	7pXfgBKLpCABtYTSL+qWzWgnXZUfStVrteKbAT1XvqFzkMW8Y7iZDDyKcI3kDF+sBRQ==
X-Gm-Gg: ASbGncvGwgDbydDikw3kBNpqDWAUBK8xv43IwDmRyMdM5JJFkdG4h5c19nM2vpa8fRy
	gRtagot7F9wQnZRpn84umXQ0L3Qj8lzrbq5cMeKJaRjqNRVlnQLxS6h6Jig1kD8lA/pTLJ7Ypf2
	9jZsvZ5iCuCfk67rhv5x64HU7vFR3iyEPMFCZCm9lCE8FVtfbzxs4jy4B8eQrkTbNedZddDz5SF
	h+C7rfvaYwNsZp+m6WUlAONNlGh1jrjdMl8XhcDDrZ2QBWeK0DzUAcIOmTqYyY4v/PVOajXCDRa
	7hiGim81K1Te0DgSOYI2HgDa4TZPFBc=
X-Received: by 2002:a05:6000:430b:b0:3c6:df53:6971 with SMTP id ffacd0b85a97d-3c6df536ad8mr15063681f8f.35.1756290236330;
        Wed, 27 Aug 2025 03:23:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4Nf+4Mo9HTabLnQaq/cSzHPY5dDuVqIH0WRyNbqohTKTkgiA74asOOu5SZuhO41pKebR7Kw==
X-Received: by 2002:a05:6000:430b:b0:3c6:df53:6971 with SMTP id ffacd0b85a97d-3c6df536ad8mr15063633f8f.35.1756290235529;
        Wed, 27 Aug 2025 03:23:55 -0700 (PDT)
Received: from redhat.com ([185.137.39.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211bd7sm20480046f8f.38.2025.08.27.03.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:23:55 -0700 (PDT)
Date: Wed, 27 Aug 2025 06:23:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the vhost tree
Message-ID: <20250827062218-mutt-send-email-mst@kernel.org>
References: <20250827124654.78881028@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827124654.78881028@canb.auug.org.au>

On Wed, Aug 27, 2025 at 12:46:54PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the perf-current tree as a different
> commit (but the same patch):
> 
>   c67e16d30dca ("tools headers: Sync uapi/linux/vhost.h with the kernel source"
> )
> 
> This is commit
> 
>   f79a62f4b3c7 ("tools headers: Sync uapi/linux/vhost.h with the kernel source")
> 
> in the perf-current tree.


Hmm.  I could drop mine I guess, but it only really makes sense after:

    vhost: Fix ioctl # for VHOST_[GS]ET_FORK_FROM_OWNER
    

which is not in the perf tree.


> -- 
> Cheers,
> Stephen Rothwell



