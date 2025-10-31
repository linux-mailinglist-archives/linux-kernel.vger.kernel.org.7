Return-Path: <linux-kernel+bounces-880335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C40C2587B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 494DE4F78AE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E0F34B667;
	Fri, 31 Oct 2025 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="fHBcc4jJ"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E097931A7E1
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920031; cv=none; b=KojpZlY/9pb9PSFp/tp3qhjzK3Ccn/qj8h1pr6OR3kJgTWoaJo5gpXsTSyWzolwLt6EIgCyTbIL5LnzkKfH+jduOVWIE8KHbTaQ/SmaJJ9UQPJnlYZaNKnS4IoOfinORD04hh1aM++UIimKsFH3+/VuMbDKj6+sDTVrCAYONLBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920031; c=relaxed/simple;
	bh=5IkfxjJZ4r9JL3RHKmEuNeI8JfBtFUokKvT9TMT3Zl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soe7gGtV9A8kR+gWiLzBwqQjNJeGyuAdhEWXHzkwbZroLpcHwiKbsso61KHT3LfWB7V+ZkQHLECSTuFQ1Ge7P9HxZDr6cR7eWsq0ajQRKTB80ABqwPc3BaZnoSRtUX8sX1eeCUDLi/JC3UMih82geCFC2ZcZmtHMJBLPbmcCevs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=fHBcc4jJ; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-932bf9d3deeso2402822241.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1761920029; x=1762524829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pDa5fR2h0z+rmz32KUZOMrbkoBXGhQsX0WYRDCHkFfs=;
        b=fHBcc4jJa7Wb+sEL6wly90c1odJUBgQPhSDO/YRTvEp35O3G9tO3x5Cokt1Q8CnarN
         HF3ZOrwUhpU6vt6atg/6kiTvTR1z+QqiknZY3lPeTsiH8jkOBlPJI9OpjenX6eun9QKA
         9VI1Lfa1KjijOeHXJuirSqmpyYbrv2rGgqwlcsahWh9bJzFPcOVo6yvStr6fExbCIh9p
         bY4lsd7ujRHid/XoPS0cpSas/SWEP0nc5wOIZzj8SSdcJbltyibjIk/2v3Ap0he7BVpP
         O2gCCqkCPBJc3r01rbVRT8NZ4x5BygMskx0AsoCR7EYvJ2bzLZ1GMGWUsZhXK7xMZZdj
         sCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761920029; x=1762524829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDa5fR2h0z+rmz32KUZOMrbkoBXGhQsX0WYRDCHkFfs=;
        b=F1myJ3D+IwKTu5PMd/v3VhyxhpBi852wfPI2yHAtjVTVBqZe7YaTHEKdgQfOPejIYA
         2+5W+ynrw6Vc/DhaNCE/FHQ0uuODZARcu+fUYQT/wLKTidP3HbYvRC5biRVqZ01TxXW3
         aw8/wd6/nYortfrN5ncmQaWGzCjB/p6J0y+Cg43q2xw2RVcrzP76cBIsky+dQkff3DEI
         RpfLyZCG+B5IxDZUkV74GHhnBCDS0eH73VX0s9DyVQRM5xeEvL0YhpODQbGWYItAInSF
         k2OunwGJBzNP5qRLGYUWRdf0uxuq+WPIqhvyBqcJ0AQoEHG/x3n+lhr8D1iuXIszd3a/
         q/WA==
X-Forwarded-Encrypted: i=1; AJvYcCVChPQWBY6Nt4HyWYuqrw2kzcpVoOEIKmGnq2m9sQemSgTpUgLfoUg0YRkNHu4dqr1+bjmoJzda2rWmSRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrV+MMqvJBamR3QJl0D1mpCCt5dGZQo2FU31MHuBEwoU3cFmFe
	9q2VwV3JF8ygnssMmH/1QJjVKtEt+1tZfUi1WP0jAFYxjK/fpNK5QWtQCExKusglxA==
X-Gm-Gg: ASbGncs98vVt3oNcRQVw9weLqJhwHV+7CxaUWwSlAtWDk+ynNR7rCq6PtOUEJy6gnSP
	rflcmGBuH74xpa5Vby+znLDerPKXhmoNOHxijhrv2mg7dRnandzceDbu3l1wMMGYmCKMpmE5mC/
	6WhnHfgb29ZXbd19qpqyDvlkTJeSmOt9OWflJk2loO/CnP6wnIqwsMiHhgwkm0suxouo2eMJlyM
	KB+7uZDu2XvBRFu1ZcxgryTOfvtLrP2PLud6uqMK27RONghNs8MlZRb9KW9BqWYIody0eqFCFFV
	y53uONykQhgn4VpTk+MmGY7AeCLGNgRrXmsqR+6Zb1NFbiM7ryJbhREqVC0moxL+F6CHSPpahT3
	tMMGO1M8AIjzuJYSWPLrrrb+LaWKmjsDrDD8Gug2aDklpXbiO9Us6fVIcopDWGNsFLdfVMx2o3Z
	kezw==
X-Google-Smtp-Source: AGHT+IGo4scF0aeVTx9EAY8LQ4pBPDZX0toR71iJZDoumY2K4E0RX07ncJjkg0VKEHLHrCsLSrejmQ==
X-Received: by 2002:a05:6102:e09:b0:5d7:de28:5618 with SMTP id ada2fe7eead31-5dbb11e0f91mr1298048137.5.1761920028703;
        Fri, 31 Oct 2025 07:13:48 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::db9a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88035fe28c8sm12037696d6.8.2025.10.31.07.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:13:48 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:13:45 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: vsshingne <vaibhavshingne66@gmail.com>, skhan@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: prevent double URB enqueue causing list
 corruption
Message-ID: <6c81d455-a4f2-4173-be72-9d77728378c1@rowland.harvard.edu>
References: <20251031134739.222555-1-vaibhavshingne66@gmail.com>
 <2025103118-smugness-estimator-d5be@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025103118-smugness-estimator-d5be@gregkh>

On Fri, Oct 31, 2025 at 02:59:07PM +0100, Greg KH wrote:
> On Fri, Oct 31, 2025 at 07:17:39PM +0530, vsshingne wrote:
> > Prevents the same URB from being enqueued twice on the same endpoint,
> > which could lead to list corruption detected by list_debug.c.
> > 
> > This was observed in syzbot reports where URBs were re-submitted
> > before completion, triggering 'list_add double add' errors.
> > 
> > Adding a check to return -EEXIST if the URB is already on a queue
> > prevents this corruption.
> 
> This text makes no sense at all, it does not describe what this patch
> does in any way.  Please do not use AI to generate patches.

In fact, the patch doesn't do _anything_ (except maybe change some 
whitespace).  And it does not apply to any recent kernel source.

Alan Stern

