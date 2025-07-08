Return-Path: <linux-kernel+bounces-722031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49637AFD2AD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940F754206F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F652E5B07;
	Tue,  8 Jul 2025 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjbVX+zZ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E32DC34C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993157; cv=none; b=PY5GHPtIj1YIwN2EvNUlgJlyGc/gteN71I2wXRBY2Z3L8hU4yUNwbdJgb7nju3hxWISHEZfPdfwysUbEZPQ1wnPvjOuLYSrEtxB0S7SnNB5mKmEjN5ufT0mPL8r/yq4M9OSqqSzlSID4Hw7aJwBgK907LxdgWpdM1TtinIAvjtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993157; c=relaxed/simple;
	bh=g9RWtZm9EheQU1N3SVXWbh7ah4lMf4zYtckksmpNZsg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtoGJaaLU+WnOxU3aDPyAxQlcv958Z4F+gseHTEKUMiqwsnh6R0cNG9HbD5/5jQvvTUK4w0B0TxZObvzdypQiRM6dMc1vI2OOELF8mxcsBiZCmXicOc2nc2L9aSmYNhgJzulbqEbJiOu1LipctS+l3HoaAENGgpGj2TLvn0F0q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjbVX+zZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-553b165c80cso4563579e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751993154; x=1752597954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lX1gzCWtyg1PlSnHbltefFM/GnghA9lvZztlnvTvemM=;
        b=hjbVX+zZL/BhObceZLHKyqcz5vSwrnlUdHPUEC4hV7bBig1RdaBJL6JHMlOWadeiah
         5dIhs2nahQiDODKXCRcLE14iokUlpP3ZHzdX6hQqV3tygMdWL8DUMHfjM4PzTjEahQ3j
         LdHeyBokozNtOLFzvhT/zGSTK3cWNrGwTdOTWTIJHhdE5znWpZkLGNFrTLPdYnxFPGRU
         2ZW8MCuno0mbcAaenrMDNmaLlK2GcmoBpfku52elS5D7433BvwDmD2afP9w7wOGeK60G
         UWpNaGZ/TFhN0pRzD5eoxPqQ4AdHsmOFMi/mwciq/y7db4MHerfcDQTTy3gCjgz1s/dv
         gDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751993154; x=1752597954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lX1gzCWtyg1PlSnHbltefFM/GnghA9lvZztlnvTvemM=;
        b=lP87OdY/Y1Q4NiIUoKAceDyz7IYse1XY7gPWqiS+oK1LsdItMRybtv1cPF1/mVV++e
         X6MOjw/bmWVDJ5WfqZIfqtBGEYAzQBeBJxrmpYMTd+xkZ0WZJlBKowZIwFu7cUbE9osk
         nQmTnuRBHmDDAXZvgGjWix4Zk6ydBmhY1SfP+BavCJzHgBCGlNr29KmtARscBmGJmTPE
         JmkCdn+IOl3Rl1DBa47P7mc5ddjpSpLmLk2qww9iw8wDxBDDj9/1tSDT2loCw0Bj6hrr
         eBZTdmtd8Q8fJFxuAg7WS2eGcLp6MbIK9XYVikB9BUkztM3SCZP8LIn2bXNtFC8MTNIx
         uwZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMaxubqQBnYIxVsMrlQs3qIH8ghDOohNrwHfilw8RDPmZqnHdcNr+8+MeEY/9u4w82UnMRinoXKITGsEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoftyUxvdTh61LLzLWZ/H4b8Y2A7UCaEOkSAUikxUFJoWhHKgd
	rjGgSt6DfAmLR1xk12x5XU8SG0CS8e3amnHEB1D5XedroxwbhaBj1pJzmZYfZw==
X-Gm-Gg: ASbGncstUzLlzcoQ3TLMjFEi1MQLv/1+5+D7m0QAe/kVNm56ASAtSgWRkPIjD4QKSeE
	dE3k2NtMAAFVjvxZVL5OJIodnhx98Dkp1ue9cC+8i/6a4I/MhWEVGBa4HXXQWSejiBz4YOztRgJ
	FkItKLIg+89xae9tAB14vXzdle3Ak8L+JcbZSETwgQRDIJGqZCPtdNRnbM5wYIZg7NXU2XmDT0y
	ffZwFnY7VkvVkehpM4JgGfh3gDAbJJapxFYCGz3YN6/OF/novjrWl5rmmpkvR5D4FtPiNbaeDIN
	2oVSwJpUoWpRTqNExllZnATpqUkCwx0RtY++ZesEGFJSto9qtudASAgullqt3b1+FU0z8OPnF5g
	iaqo+6ahJUIE=
X-Google-Smtp-Source: AGHT+IGCjdMJ5CMc67BoyEjOlZ8XUsf8KIL2wMijv1phyIZo79nlY3bly62H5XIB9wPVnZfokgsx3A==
X-Received: by 2002:a05:6512:3b91:b0:553:ccef:e2f4 with SMTP id 2adb3069b0e04-557f8353236mr1369280e87.35.1751993153671;
        Tue, 08 Jul 2025 09:45:53 -0700 (PDT)
Received: from pc636 (host-95-203-1-180.mobileonline.telia.com. [95.203.1.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384c638csm1709225e87.235.2025.07.08.09.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 09:45:52 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 8 Jul 2025 18:45:50 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>
Subject: Re: [RFC 2/7] mm/vmalloc: Support non-blocking GFP flags in
 alloc_vmap_area()
Message-ID: <aG1LPktW1l3IKjEb@pc636>
References: <20250704152537.55724-1-urezki@gmail.com>
 <20250704152537.55724-3-urezki@gmail.com>
 <aGtzJyYPKA7Hn6kQ@tiehlicka>
 <aG0QVClTHrP0oPLm@pc636>
 <aG02jeuCSPUFBx7C@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG02jeuCSPUFBx7C@tiehlicka>

On Tue, Jul 08, 2025 at 05:17:33PM +0200, Michal Hocko wrote:
> On Tue 08-07-25 14:34:28, Uladzislau Rezki wrote:
> > On Mon, Jul 07, 2025 at 09:11:35AM +0200, Michal Hocko wrote:
> > > On Fri 04-07-25 17:25:32, Uladzislau Rezki wrote:
> > > [...]
> > > > @@ -2030,7 +2033,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> > > >  	 */
> > > >  	va = node_alloc(size, align, vstart, vend, &addr, &vn_id);
> > > >  	if (!va) {
> > > > -		gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
> > > > +		if (allow_block)
> > > > +			gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
> > > 
> > > I don't follow here and is this even correct?
> > > 
> > Allow nested flags to follow a user request if there is a request
> > to not block. For example if we apply GFP_RECLAIM_MASK to GFP_ATOMIC
> > GFP_ATOMIC is converted to zero, thus to GFP_NOWAIT.
> 
> I still do not follow. The aim of this code is to filter out all
> non-reclaim related flags. Why that should work differently for
> non-waiting allocations?
> Btw. if you had GPP_ATOMIC the resulting mask will be still GFP_ATOMIC
> as both __GFP_HIGH|__GFP_KSWAPD_RECLAIM are part of GFP_RECLAIM_MASK.
> 
Right. I misread the GFP_RECLAIM_MASK, i thought that GFP_ATOMIC and
GFP_NOWAIT are not part of it. They allow reclaim, but not direct,
i.e. it is OK to wake-up a kswapd.

So, they should not work differently. Thank you for the comment! 

--
Uladzislau Rezki

