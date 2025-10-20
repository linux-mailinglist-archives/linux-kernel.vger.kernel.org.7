Return-Path: <linux-kernel+bounces-861309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D9BF2563
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AFF74F6B25
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1B2286425;
	Mon, 20 Oct 2025 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ixb2ZTXm"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD9A283682
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976858; cv=none; b=iT7e3vq+YJja3lQyJ+UDvQH9sychghr25sLwfa1URhp6Mm/d70J4oV9Y3Lpn0UQumevKtRdeV5TI1A7omUrtAD19RHPx2u1ABiMu6dBBk1gKLEZjaBzf4TEN9hP+U4W/f6rxN6LSB9zLId7VLgwr+Zxa922xEllsxhZ4UedbPbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976858; c=relaxed/simple;
	bh=WS52j+nARIQivdKIiJ6ZjGEiAMPv19+XJeo+JRpwLF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMp+4Oe3KjeL8cP5wNLKQSU2hYeQQu9pwLWKbHaHvot2hhgN9ARRp4WKFDPA2jUkR9zXv0dS75h9SIUgNfSK+B6kfi51N2YVzoOcgtMnegrR5PPSymq+h6/HEG4by9KgO5BR44yd/7dSjBZ3Fw49e1DONuoMqKuZvbt1nvpUmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ixb2ZTXm; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-87c21c5d3eeso64384826d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760976855; x=1761581655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovFN/fCbIduQYs6aLAjGNuo1sjBICaBJVjQ0giTZsZA=;
        b=ixb2ZTXmjoc1S9dZN1Mo6YPO9Z4MhDb9GeAVX+B7q7PNDrtU9zu1hyiNDgc9hpVoU6
         WbfWPZFfNDLD6sE7J+DWEuRloGRabZLg4G2x2WCzX1n6XDb6gUlJnfoaTWyOk+DkkqoF
         2bv7pQ5Azcpvljr+aNvZhoyvOMftS9Ka2zO0ZEps2ZRbWMNYTVbJJvKWwM1u7ys5HcXF
         4t79Wrv2Y16kyZo4i4r5aRlkeHPgNwG2bZ6mHfvhDx7BkBIumfL5LRgDMV4GbkP8Z1vC
         u5gWbTKq/fIKbiRr/uR+hfpLsklhiOq5g/Fk/K9UhziE3OZSvr/9lkQW1qotFbMnYe1T
         T5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976855; x=1761581655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovFN/fCbIduQYs6aLAjGNuo1sjBICaBJVjQ0giTZsZA=;
        b=uDIHkfSi4jfo6hhjagCB4fd4wtgee1pKPXHzw5v62FxWd0y5fLNywavLvcJ38ZKsWs
         Crkge46eydUuUU5Q9Y+iCBW1o3ojPAq6Nvq5HmgBJ13kWZDReT6WEiYLY2m8z80lbSp/
         cBsAj51BptMHyJX3B0kTTxnUXk7QtyiBZ89dOdpY2F7xR12UwSr/0Z1mhW7qD0pw5u7/
         8Kv1ILoKlpDzUca72Z+XSz7ql6YUTnrVPtAeriqUOd7OwwQH+dnVKpHFGBdqjmSvjksX
         oU+K3rlW9BvQgf5MnIaPyoFoQZDvCSL5mHQIngdC7pSYJAROVHCVoCfNMqV3jeb1euYX
         Vo3A==
X-Forwarded-Encrypted: i=1; AJvYcCX5BopV76i0ZHOGmYAsCeNvVBAWYxjyqSDBbEksHdyhWAdDcCyYRxK/ZpCjVgm7qHPvFF3z6JLgNLMDo4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4trhhCgIA8cLBl+ge7NIq/siuiChrQnOJOehELOEwee7a6ztG
	03ZB5DYN8bdUv+GaYvB11E3cWBLQWii8mvQNLBSYuZQP8k3vvMWrgcc4IR+vMvxnZFI=
X-Gm-Gg: ASbGncsT5NOr4H/R03yOrIgT7qTac8LpD+ie7zRZ2XLaLNAlWUc719ZvZzyTMMciEWb
	o3zwtE2UQA/+NTLr8+oCYI71LLjG6SZibtRM2b2GwKumHg/O3STuepUsCEDffLAfyo1nkxY17u9
	EWzs4N9qLH+/+mjrZiWb7JJYyE2pyoo8fO7/KoLTSHP661n90IMOnQcii0cYi3Br9nIlYpHOsoI
	j3Jo1h4pr7tohMBWXJeTOuU4xxtHV9U/a0XLBhR0ljXECdLIMnQP5Xh1uPdkMN0MDjcKarQZKFZ
	ZLhVeZ8LD6OniVuHYgVbuL3ZEFvVBVp7fAK/cQDry5ZgrQOpfx6jJyUn+hxuF95AXEREP15iC+N
	Lgc3XM9ePq0uqFoNwz+phCzSuvjmaldkW+mAi9x/XHWhn+/7/nIEyCR5CkXNhWATCaWqoLG1GDY
	IIVPFVMPTWlqNVybmEtzkIIf+Bqr9XR1/xPIxMzO5cnXy3kHa2EfXvjqCxwEhiokB3fDTeuh0QC
	roKDvPq
X-Google-Smtp-Source: AGHT+IH3czW3FFC2OSmXtjeaxvNwaarf66L+VtGACK8pE6fNuWKDq/oMJT6l6rutOkaSLLGkRsNYgw==
X-Received: by 2002:ad4:5c8d:0:b0:780:6e19:8ed with SMTP id 6a1803df08f44-87c20825260mr151746346d6.65.1760976855561;
        Mon, 20 Oct 2025 09:14:15 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028924f6sm53420566d6.38.2025.10.20.09.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:14:15 -0700 (PDT)
Date: Mon, 20 Oct 2025 12:14:13 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, osalvador@suse.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hugetlb.h: flatten logic in
 arch_hugetlb_migration_supported
Message-ID: <aPZf1aOyhVHVedok@gourry-fedora-PF4VCD3F>
References: <20251008212614.86495-1-gourry@gourry.net>
 <def56e60-42ae-4848-b0a0-91bd1c95d8d7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <def56e60-42ae-4848-b0a0-91bd1c95d8d7@redhat.com>

On Mon, Oct 13, 2025 at 10:10:05AM +0200, David Hildenbrand wrote:
> On 08.10.25 23:26, Gregory Price wrote:
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 526d27e88b3b..b030850975ef 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -876,12 +876,9 @@ static inline void folio_clear_hugetlb_hwpoison(struct folio *folio)
> >   #ifndef arch_hugetlb_migration_supported
> >   static inline bool arch_hugetlb_migration_supported(struct hstate *h)
> >   {
> > -	if ((huge_page_shift(h) == PMD_SHIFT) ||
> > +	return ((huge_page_shift(h) == PMD_SHIFT) ||
> >   		(huge_page_shift(h) == PUD_SHIFT) ||
> > -			(huge_page_shift(h) == PGDIR_SHIFT))
> > -		return true;
> > -	else
> > -		return false;
> > +		(huge_page_shift(h) == PGDIR_SHIFT));
> 
> switch (huge_page_shift(h)) {
> case PMD_SHIFT:
> case PUD_SHIFT:
> case PGDIR_SHIFT:

PGDIR_SHIFT is not a constant on x86.

~Gregory

