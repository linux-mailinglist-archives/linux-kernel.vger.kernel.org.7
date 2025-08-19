Return-Path: <linux-kernel+bounces-774943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA38B2B96F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFD156027F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0A52698AF;
	Tue, 19 Aug 2025 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xbk92i5A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B00266565
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585055; cv=none; b=CHlG+wE02KPHGhMAcSBHh12Ny+P4vnfVN81iwqNPmynxdcHEiKqUIf8fT/3XFZ9mGS3ZVVm+2zpEWtxQcyHoIJZu04xeOLB1pCD8c3zC5VssXJYTc8qVOajjcCz+gJ7S3iG+6ZEyaXs0HIgSQXsky/nlCZ1OKWPUvT5mFEAXf5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585055; c=relaxed/simple;
	bh=8BGkXAg/cYyaOt9ZXSqAWIYIeP5RwAQroBA7qi3xxK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qn8RVY6i6iJchINOE4ZYarIiDooZVJtm8urxWbuv5kyu3kwU7xbanhYNxdPynbmRT34uerM0FgT55SbByQsuaeDf6XitgWzmbfRFLwmB21ULFF8wvXlXFaY3R2dbDkjXapsBz9oubs5RdslZ4wR8HSU7O27ns05tNZ5KOL1eGNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xbk92i5A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755585053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BGkXAg/cYyaOt9ZXSqAWIYIeP5RwAQroBA7qi3xxK8=;
	b=Xbk92i5ASqaCpl1SBGlt6WVhcnpJWwRRGd4fcW1mn5HRJ2Owhc9825gWhgQxIQay6588i2
	1YO3SeUIi97NkGJYvFZpPmA8HNXW9RYBM18Xbk4OaOeqMciqPSSVOnaeXSKs9JxFwejrWC
	KpSOIfFYCi0tnJ5n9BSmQtPQIXcAoY0=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-BuZDVgFRM-Wfr6aOTOt28w-1; Tue, 19 Aug 2025 02:30:51 -0400
X-MC-Unique: BuZDVgFRM-Wfr6aOTOt28w-1
X-Mimecast-MFC-AGG-ID: BuZDVgFRM-Wfr6aOTOt28w_1755585051
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-30ccebce606so2593885fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585051; x=1756189851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BGkXAg/cYyaOt9ZXSqAWIYIeP5RwAQroBA7qi3xxK8=;
        b=V4w9KbXcMI4BdEJ0I5LTJn4vD68cCQyo7ll533AQU8eHcjomMrOZRO5NQqFKcr/aed
         hVsAWKf8pc+i0FyPKrZOmB/GL0ZTJxug83q3Y/PFraESS7C+fSNJQcrk3dsKnt9Zy7XC
         tO/ljnxo//tHq9DgpnZMRSwqD5K2Ieth1dBWH1uXFzZdjfRd4gZ9b0bf78o5MPC5dbZ5
         9YCVwdr6XCyNbNJxsREqFdleZc7nOqO59blEfAISN6XL2KwDeKPDl3lhXPgqdyG/AihQ
         mBK1+1IXJT3nTloxrsGMi3Zd54RfOV2RH+eDlFueIQwZNvZaviYk8AhUCrl7sSoQAIha
         b9xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUW+v0o25zMmGbujU5D1a51vpFbCcYQRB1XH0SBIxGeTQ5X8ZzPcwl7Njg6qB6isZjY9c5J6s2PjnLe9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2yBUfqWGZ5ft7tnjxNS5VZvR07lvzPSp9GPc7VI6nVF8aYfKf
	15j/uSlRDKyTIx+S2FVZHflF/uiVKMz7KcMU/Gp3thzt/Z0Fvc7xlxArznYqK2o6Gp6PEAIHhWb
	riUpodBZLwlNKUZsxLr06TUeeg0ALvMNvIUtFZJQMzenGYzqyptZJsaXlUtp/Rl2OBXlOy1NhP4
	BW2l3li3G5zAmLahJpXHCOZzkPK9xtpppiibRdQ0KH
X-Gm-Gg: ASbGnctHac9XuBCYlINMY7oczpgZHQP/nvz4KkruwwrxWLLig5H0GT9t9++eE0Y5MM9
	qQSl5MNyy6igTW8G88vhChmk5n9j4jlrE5RhgDztGjqxSwTPgNpqwsjlM39KCShwp+E0KD7eziT
	YJjPBPeUudKq97JBTh7AW8
X-Received: by 2002:a05:6820:1e8b:b0:619:b57d:6673 with SMTP id 006d021491bc7-61d919e9f83mr444118eaf.2.1755585050885;
        Mon, 18 Aug 2025 23:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2NruEB0PpTboIZlO1R+deeNOAfR6szAOH8EjGkxNqMd5bxJ1wqDFHy3nGmYHV3yaIaLn+9Z6/t+ostF1mqZI=
X-Received: by 2002:a05:6820:1e8b:b0:619:b57d:6673 with SMTP id
 006d021491bc7-61d919e9f83mr444109eaf.2.1755585050578; Mon, 18 Aug 2025
 23:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818153903.189079-1-mschmidt@redhat.com> <aKNU1YnfNbXYhUyj@opensource>
In-Reply-To: <aKNU1YnfNbXYhUyj@opensource>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Tue, 19 Aug 2025 08:30:38 +0200
X-Gm-Features: Ac12FXzQ5_CEpGP7NZNYa6OiUyYr-nwrNxzE9x55g1guU5BoPDYablJy0CT5lZc
Message-ID: <CADEbmW1ayx8dKUmE=ueYTVwBme=m1E9WGOmpcv1MCquZ1yBgHQ@mail.gmail.com>
Subject: Re: [PATCH net] i40e: fix IRQ freeing in i40e_vsi_request_irq_msix
 error path
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 8:05=E2=80=AFAM Subbaraya Sundeep <sbhatta@marvell.=
com> wrote:
> Hi Michal,
> On 2025-08-18 at 15:39:03, Michal Schmidt (mschmidt@redhat.com) wrote:
> > Use the same dev_id for free_irq() as for request_irq().
> >
> > I tested this with inserting code to fail intentionally.
> >
> Nice. Looks like changing this in i40e_vsi_request_irq_msix was missed
> during 493fb30011b3. Just a question isn't this not throwing any
> compilation warning all these days?

No warnings, because the type of the dev_id parameter is a void pointer.
Michal


