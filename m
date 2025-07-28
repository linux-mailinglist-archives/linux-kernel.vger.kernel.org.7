Return-Path: <linux-kernel+bounces-747971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D57DCB13AD1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B82A1888644
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00275265CC5;
	Mon, 28 Jul 2025 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MRDolRgw"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C7925178C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753707247; cv=none; b=WRyjZgNpDNBjl3AWwzHcba0j8p5FJXD/M4xjXCo1SORqvDSzqNFFIGvPZB35vQ94Zek3vWkiK5x0pQN4k+D7eLgcnaL1lItjFRRkiFG020IAFChKErsnlGhO0wO0MmpR7E6UDFPDU8yqPDY3X6VV+3vbDyq+mpqbZSJpbV0xzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753707247; c=relaxed/simple;
	bh=+8M9jRzZx+M910vE7ZMZvlWTpkaPlqVwLAe3zwyk41U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krm9z6zFE4gRpRddj/5PJWHXXgiK2dKn0IiXLmoooh2zjjVTiDqUwfEIoYKscOMg7S915EheippipamSxsWOBDucoIyh7iqTL3UGwrqU23HlBBFYjQvu5UzRm38vjITpPDPX2x+cgTcib4ujvVwK7e4kNaroPF5w09o2NKn1GLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MRDolRgw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af0dc229478so619297566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 05:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753707244; x=1754312044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AFe49a4vrehhtu11WrBTtnSIZQtct5R2DgXZ+umFAog=;
        b=MRDolRgwmUy03siaDaiK3Wj3H8ztSb6ZLN+uvOhGgNsDWR4MCbIHahCd1VQnhgP7wo
         SNOSTEnLLzpGnRErfxbvJKssKe9Be5FbgZv+fXnMXQf1uSIKi1sNcJEFqhfyFzpw3Lyn
         74tQeLWFBBYCsIsSUYvZMoqijUnkxIdkT6y7hljYmH7bz1ymXYxPL83pl//SDUMFPgGi
         sNQDeRyInAQpzgVp38Pt7tlgF5xtxhlyeBi1hC7tIy7t2UKTBd3olicBIFFFZetWFBQ5
         dkshFVNTNRw/+qsjHKYCOMPWSBjJ3tjpYEAnfZcAhkBGI1Um9soJgiaJbzIv7K84coQ3
         iEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753707244; x=1754312044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFe49a4vrehhtu11WrBTtnSIZQtct5R2DgXZ+umFAog=;
        b=Aa4BY2OiDW+TZaiWdVuk2K2ASo2C0he/+GaLESAEYYYhwOYYK6shQkxbk4vGVJMlxb
         1kQSvH9QaU3xLFhC0QKhC8tscqoJpAU2zSvSHM+aicLf/1tpxpGunTACw70V174ZZpTF
         TKbYKhSqpn48IY5N4WXYyO6h97jdVRYNWbJGRXpR4lKkc5ZHU7RK89MXMOKxN+athPU4
         qLVoBzSbbaGvjuks9AHlPkThHfTqonIEXD+YgQtmjZXntiP2G31uyTsLcCuIzMpBDE2P
         +mfsU4xTsmR7++pZegHZF3r+kEivrXdVCfnmjVqgloRKdkLuirXfl/gJS2PK2XNsIjJ0
         UP5A==
X-Forwarded-Encrypted: i=1; AJvYcCX086+WXaTI/OiAA8WtJLxNDfgXNVmefQUWppLiDwIvI9uBIbcGcqTrn4w9If7KyZGUY6HnklYw10/JoQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVk1RcBD5DiM/Dm2Cw5oIZqpEry0yxIKuN9MMDgo8N70RbM9NK
	X44xf7VhfhxUWcjK9pWye+RO9DeVtGx/7RB1Z986HBoNAtAgUKYKX8xT2yKtPBxWZ5w=
X-Gm-Gg: ASbGncuVZMYQ13Kn+zlzXVX4Vj8xG07TKGSiOMe9ImyYVRqOMkXdLIXQZ/J+is72LwQ
	lZXnHVaV4YqPRtLewI/gAltN2PRcoo/EnQgihNcO6faBftVh4+LtvRkvowawAQ403worVFCxEtG
	7AYV9Lznxk18j6JyuWwjWPXuOobrLVXbzsaD+mXUcnj+xBFEXHdiPr/hhe8DwLLHBCIYHawmfg9
	Peb1lloyY0FTNcA121To4lQsW/jc6qQXn98A6nSrpRhqRJtBGe3Z0RTxi7rouvkDJ8lrAR4HWz4
	boEPlATa4SA4yxYQdk68Pj5w/Ex3NahdAqblVhA6mCUB+TkYzc8/CUSwpepnrhbSuTlfl0XXkU/
	aQhq4fpTTvIUe9JT03basiTlGZOGxuU+tlCc=
X-Google-Smtp-Source: AGHT+IFFThKk1ZreCJF9jzTixRdz4e//89EMTAFaSoI7nWzzvHCr57vBuWSmLUpBCNfSVWSCdtgoLA==
X-Received: by 2002:a17:906:9fc8:b0:ade:405:9e38 with SMTP id a640c23a62f3a-af61c8a54a2mr1094958966b.24.1753707243632;
        Mon, 28 Jul 2025 05:54:03 -0700 (PDT)
Received: from localhost (109-81-20-172.rct.o2.cz. [109.81.20.172])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af635b42027sm422277066b.143.2025.07.28.05.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 05:54:03 -0700 (PDT)
Date: Mon, 28 Jul 2025 14:54:02 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
Message-ID: <aIdy6tzlrZhrXw3t@tiehlicka>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <aIc5XxgkbAwF6wqE@tiehlicka>
 <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
 <aIc9DQ1PwsbiOQwc@tiehlicka>
 <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>
 <aIdqVNCY-XMNICng@tiehlicka>
 <1f8d924d-3554-43a6-a75e-66a08d1ce7b9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f8d924d-3554-43a6-a75e-66a08d1ce7b9@redhat.com>

On Mon 28-07-25 14:27:01, David Hildenbrand wrote:
> On 28.07.25 14:17, Michal Hocko wrote:
[...]
> > In other words what would break if we didn't expose CXL memory through
> > memory blocks in sysfs?
> 
> I think the whole libdaxctl handling for onlining memory is based on that.

I am not familiar with libdaxctl so bear with me. What exactly from the
existing sysfs interface does it need?
-- 
Michal Hocko
SUSE Labs

