Return-Path: <linux-kernel+bounces-760068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4BAB1E61F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D991AA1264
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96252741CB;
	Fri,  8 Aug 2025 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjOv9L9N"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9919E272E68
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754647162; cv=none; b=OGquHukLYN3bUzC9sDtKp4QBpGMrXwJHHJ14x26K5oYCEzDxMsxkBbZXpHP0TwZJ3qLhK4XUPvMsv0X9/5k9ncUUmavkbr61ufhZXaiMyIb9Sb71rsC17j3Gl5v0qtdlPKjpvUERu+W17exz9nx/HR6XNLkCxwrJ3ELi/suOIHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754647162; c=relaxed/simple;
	bh=febFU7y+Ltwab2my2l+Df9mWpKHgjOl70h19NMeI71w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpeOsY8uHo+df9XjInnuEPiIOpMfb3RdumUEENl6BaR/HGbyI0AmHL14ryuGJ1+sNEYxUpOMh8K9z0et1IBTTQNwap9hD0Ih9ph2qVavxijvDueQ+T/xA5ldY5YYTJ2nDQ5sUMBkK3fTDILSPE0ZSdbVSZH6VbfoMfUEtUB7N3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjOv9L9N; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-556fd896c99so1696811e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 02:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754647156; x=1755251956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/GD+1uoxSRmqY3LoCmFQ1CrmMk/JQcPEzGxpw35N/9I=;
        b=AjOv9L9NEKZboQy39ixedeMEQnh0oWIfgvCd8hynqAgD+SVFDtwdArGMta+4JjK0jL
         6s2wY184DieFmR2JPBfw3U/xq8PoztP4PfWQXfL2IsEUYIf8Gc6mXGJhvkbEnC8sUbUY
         37XF6MKkUzWGzL2wmx2mEuCxCY09L7h7xHD+zw7ajnRhqP9MzLz8agFfWObBHrrGEly0
         EhgcbA+QdAnhbKTZ3GrQ3KIPnpy/puawGrHOEuc98B3EgaR68rWsAl+dpHerhnBUa1+H
         VYhMs6rNaZs1GOYM1/nnXIlcY/h8Yu8NmuyCSS8Gj2PO0dcpUEugzQ9oFw6AUTmdb6a8
         fb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754647156; x=1755251956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GD+1uoxSRmqY3LoCmFQ1CrmMk/JQcPEzGxpw35N/9I=;
        b=KpVBcQ6lljvoJAALZ+O3eFaUWhXBp9vXuTAMZ8ZLIQPE6MHtRcSU1xvfCWYBargkQ+
         dULm2TySV0rTpaWeS0/UjYZW/x5e9DfoMKiuayQlnxjh3DMzlmql966+2Dhw+QNe8Su0
         avus9KfmDwQ/VKKG7s7W+p2QM0pAqnXnq72rWHJp6SZKM80NyQFDCsLfYcRHwz/wSBDN
         RP0xwiQewtFRFSiynVVLH2V6SwZkuqt+iO9ael8oP8Gsv8gCf+gvp/Coin9uSO+Fc1pg
         +9qYKi9N7q6aXiv6WhHIQI+/i9h/6LIhqM+1lTYb5crd2vg0m6JiLydupMnAowNTvdMi
         RfrA==
X-Forwarded-Encrypted: i=1; AJvYcCUTpD47FtmDJ7rRpKYIUGutB1ZbY2s/EWHwPhxsAp+DaSKUqjh64efbMYePLza3bdxdjbk1Y9N9UBETJ4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4yowwfeZLQfGEXP7tyeyeCp8r5YpIkog7It7lzQY+m7OmbYWF
	9Gnes14bgB5wrk11oxxgftN8e7iyXVeLAv3pUdq3RyEljN1LRkRrJxBr
X-Gm-Gg: ASbGncuiSoScghpRdT5Mdp0hkSUnBXVKH2o5oixKQemOMeBe4WhhcVposbDBoQSV5XM
	Am+JQ1pfKYe6OGIzVW1zmCywskF80kt2yRBMn26aiLiHcWDqfKPMnAEqLgDmMk/TPpTCmSWFMgA
	2RbDMMS8Z1ldchD+PNf0T8BwHm+E3cqL11IkuDKuV2B8QiOdhcTOplDpynuNwqnudCg9GHNRDj/
	huPHV2AMHz/fPwEIjZsl8A7TN8pkFwXUjrFb3IzNZWNh2bETbFSpLqN5C82YunMrb3pksa8TLoI
	6KZzjKTFOCKgAB2uj/dWikgZUwOJ6KQ/f7FtQkC7+ZAR9B1Zu5iIDrv9gatnmbiaP3OLHkA+i/r
	AYZ5+0syuJ7FcD0p6oT6vxb+eUtato0jvazFpjigsN3k3oTaUiA==
X-Google-Smtp-Source: AGHT+IHRHsDsTXzZgAshxJsbKmsUggOsFkvCkS3GFd3Ifj9I0+C477rZaqlzarHB17wtGKvoXU8TwA==
X-Received: by 2002:a05:6512:2386:b0:55b:8f02:c9ec with SMTP id 2adb3069b0e04-55cc011893dmr523062e87.42.1754647155348;
        Fri, 08 Aug 2025 02:59:15 -0700 (PDT)
Received: from pc636 (host-90-233-217-11.mobileonline.telia.com. [90.233.217.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898c0e9sm2917640e87.13.2025.08.08.02.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 02:59:14 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 8 Aug 2025 11:59:12 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] mm/vmalloc: Support non-blocking GFP flags in
 alloc_vmap_area()
Message-ID: <aJXKcEJq4EbIlON-@pc636>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-4-urezki@gmail.com>
 <aJSMFgvrLEN-nwdT@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJSMFgvrLEN-nwdT@tiehlicka>

On Thu, Aug 07, 2025 at 01:20:54PM +0200, Michal Hocko wrote:
> On Thu 07-08-25 09:58:05, Uladzislau Rezki wrote:
> > alloc_vmap_area() currently assumes that sleeping is allowed during
> > allocation. This is not true for callers which pass non-blocking
> > GFP flags, such as GFP_ATOMIC or GFP_NOWAIT.
> 
> Those are currently not allowed so it would be better to mention this is
> a preparation for those to _be_ supported later in the series.
>  
> > This patch adds logic to detect whether the given gfp_mask permits
> > blocking. It avoids invoking might_sleep() or falling back to reclaim
> > path if blocking is not allowed.
> > 
> > This makes alloc_vmap_area() safer for use in non-sleeping contexts,
> > where previously it could hit unexpected sleeps, trigger warnings.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> With the changelog clarified
> Acked-by: Michal Hocko <mhocko@suse.com>
> Thanks!
> 
Thank you! Added in the end:

It is a preparation and adjustment step to later allow both GFP_ATOMIC
and GFP_NOWAIT allocations in this series.

--
Uladzislau Rezki

