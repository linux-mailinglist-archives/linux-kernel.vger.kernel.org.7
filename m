Return-Path: <linux-kernel+bounces-861116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D58BF1D23
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4544E460680
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCDF320A39;
	Mon, 20 Oct 2025 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="B3vxHAJY"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2472F8BCB
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970173; cv=none; b=HKCZPqjdaEXl7d77X3DNkVPZX5A4Q9syH9YxQB9FCRzBwgqplS6NfqPnS4EMlkbeKvh8nqz9EYeUf1nEppYP+Ah2cMSTwHGVFsuTHDr+tK3B3KAYVSNJn2sVCZ3D0Uc0xfv9NaY5dR7hYEIWbTU4LRQgs2vGmcTvVLx+zjorVz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970173; c=relaxed/simple;
	bh=UJJpmzAqJ4fNKtxAFBD6r6VHXs+/qK3P1QsraWv63QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2C5N+YwI/VTDyPgxrYQIJ0w1j9JuiyNn9NF24ayOL9/6Xb2jDUiWM6xFDZjjpV0nmmCdxWpajPX8oHBkILikSi3mfdid3Ft3pMA2iTC11VYubOt2gqNeeNzZfVL/VWnAffGXZfNfRCaJHfZOAxq/8Uf1PTO8+DhnzLGtkEB3Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=B3vxHAJY; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-78ed682e9d3so60773946d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760970170; x=1761574970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ome1K21U8OKmqIh6cxr7UpkIOBQ/Su9V9X20JROSYuM=;
        b=B3vxHAJYKEs/96pn/HUMQIY5sOQM7Yc6roOi8anQ8ev3wQP2b4sgumnLtf0Juo/0lQ
         mbArhcdwH8v6YcDL3hMyxusAbKZ26ugm49gWNj4jnAQ7lRJDVvGW45BgKkKvPfPLIp+u
         ua5B8DZ+n5dhlEbkom8vBytat3QmYCEGOJ/IvfnwoNuyyMTtzRmn46lppLfsINEOF7or
         ZAUKxiIIpu8mXNr9thhW2JFaNg4cFpkolrxJbPwa004sXQNbv641mSyiG4avZ45SYU27
         +KIE8YHK5t93F0ZZ/I8Ca4zviqMI1m8f/UARfvLWkaYUGF67cKfj55BOpwYkc+pXBYFc
         Kikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760970170; x=1761574970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ome1K21U8OKmqIh6cxr7UpkIOBQ/Su9V9X20JROSYuM=;
        b=ntuhS4+/KcW9z93NK8Ki/Aqm7/zHGLhLSr4MwQ4NMvwWWy5AwO45Enff4WMl/y3F3E
         GLHSGKMi+pCxJCBKkvYWMoIJUwcbjJKVEn5m3RYYw65OBqep4pWQIZPQB55vz4rOUDjw
         NB9geTEgx10XxrL3EKlryUagUsvGxZgtfEl6nXuV7/23YwMFC7j31B0j0DDzGeyFOeFv
         SZNJqFIsTCr4K+2ZIGUGUaxAj8cStSavW7bwSOC+KtQffM/bRwDPkIdYOWpxzMOzNKE2
         0qSGrDjdEVY0LLFtzk2xHLdbpG+ZxbpspjKjKI4zDqpWcA4+EC3fbgmm0HZyuGcHruEs
         QF6A==
X-Forwarded-Encrypted: i=1; AJvYcCV+DugaZFl0g8ZzWL5bfbnREgxnq/HhzlUK6lWWFyCaAZ90zYd6x7Ld+pjWUb/cYR+J4rSMsB5dZgJeHgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOrCRI30CDR64XG5h5Yqo+pNTF8/0vOj1wWnFlUPqvJAAwBiU5
	p9u6qTUZg5V9XTDTXfTQkD88yHsMHfh3/dxQCD7sAoznXyOG56daFiiSZoX9MUr1kmA=
X-Gm-Gg: ASbGncurfPlvX/FxMtBpC4zTnQBhWbkTVUoVsSD0toyGbWNNShv0QfBE6xwMS4nkCUx
	MXtSAgSqtYgW+OAj/EmM88+m1VfOElta8rsfhzpcb5r8QZJjXii2ecLp9JlHgLkZh8QPE0cYwUY
	j4r3HEl4k9ATG/6Jc31J9o/UlRQFteEcn1Vq4R7HEDg4l++NwXXGsLqSYqeYe0Vuf5gk51X0/jH
	qB+xTklVJD1+98SQLd8OYH0cS2an0w4neXQnxWHLKI8z3wU0n8lawk9i33Iq5bt+oFxrAHfk89W
	QHCiuQMccVGrNmk6yxfZTP9PxLC1YC0/dbLDOAwdhcNsQeukAMVCp25RkpZSb+Ixilw5j+iXa7P
	iCSjD2/1BjJZJ78WLUEXwEx1AAd1ocubYZ1lfrRvt6GyvtvJGLb/NkOn/NZEOk5Xmf6TC+nmqqn
	26w8mlNarqmVpRGpJur/UGDmSPMgnaFWqxNekcoXzAspdWpW01jAvP7bQ2ocLyr4LQwYYQPw==
X-Google-Smtp-Source: AGHT+IGL/jp9+4xUfY50jcRRy/t4MGHpw6jQ2O094KKD/LfcVRUdB+PlhBahj0B9OuP95IOnQE5uVw==
X-Received: by 2002:a05:622a:306:b0:4e8:a85f:e4a6 with SMTP id d75a77b69052e-4e8b7cdf3cbmr81951421cf.81.1760970170265;
        Mon, 20 Oct 2025 07:22:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf0af579sm568871285a.41.2025.10.20.07.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:22:49 -0700 (PDT)
Date: Mon, 20 Oct 2025 10:22:47 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, osalvador@suse.de, corbet@lwn.net,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	hannes@cmpxchg.org, laoar.shao@gmail.com, mclapinski@google.com,
	joel.granados@kernel.org, jack@suse.cz, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH] mm, hugetlb: implement movable_gigantic_pages sysctl
Message-ID: <aPZFt05GcyTkGNQ5@gourry-fedora-PF4VCD3F>
References: <20251009161515.422292-1-gourry@gourry.net>
 <6fe3562d-49b2-4975-aa86-e139c535ad00@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fe3562d-49b2-4975-aa86-e139c535ad00@redhat.com>

On Mon, Oct 20, 2025 at 04:17:06PM +0200, David Hildenbrand wrote:
> On 09.10.25 18:15, Gregory Price wrote:
> 
> However, it also means that we won't try moving 2MB folios to free up a 1GB
> folio.
>

This may actually explain some other behavior we've been seeing, re:
reliability of 1GB allocations.  Let me ask some folks to look at this.

Thanks David,
~Gregory


