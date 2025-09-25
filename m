Return-Path: <linux-kernel+bounces-832843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D89C8BA08CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB4A189DC2F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C372F2611;
	Thu, 25 Sep 2025 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lpvx67fB"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3663255240
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816539; cv=none; b=U+5+dkmAPJ9Shxtce/hxdnyETCS+hl/5QqzSLf3KUX86YtfDqonXjLJ9y/bM9ZugW1HL4vLBCwexCi1qDl8C1mB8ObnSBu0Lyi4EuIm8vKDvNmUBjjXdChZrs0UpoTQR8XKyjH1UWMypdwPud7ePQX1TWufNAt3P+KlCDNqdfHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816539; c=relaxed/simple;
	bh=D5YIqj/TaHyYvTLrQtKzgY+bo8ZhZ9tjiErQjSCOUAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/oDTAioM4ltzu3khRntyOpMV02mh84VNEMRE2dSlz2Qm+jvDG0wDFI83ws6i2yIDldK9axWxO9WhNmDORafA/paDdSCS/BkMpYiD2s5Fe8SxWEciWTNCxaTHMoVREfpZoS2Nl4wrKk1wy8M9FMbcWKPYw0SUFLQeTCYiswL0N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lpvx67fB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62faeed4371so1559378a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758816536; x=1759421336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lwx7tJRH2BwQj2+dcBbdXE5rd5qpyy7rUF/2X1K6wOM=;
        b=Lpvx67fBQZZTgZRmfJbJB2RgcZT7LPguuETElkr0OQYYeseTYSqRMMW4NrTAD9BIMs
         GfzU8DEAzyMfEHvDI5lx1ieIyas/ug0wTh30/NIhUMJAFoOvzHPxpYRyTjaC+C9dikQa
         T6mpFADNjGaTYcTZ6Ks7n/FtEudDm4O8lb/9HA4K9KnU/bCqZgyqL/mTgSSnuVi67bK8
         ngoX21MKpPd5IqRV9gSOuXMeEVR4JV6l88b6A3Eg8ZJ+ClEFu9Gw0FntE3Lz+513rNcy
         snN9oErTIWR8M5dfbQd2NTCdgsgvKYr6Y020S+yo35Ipw2DT/X3iQgW2IxLQQtEEY8ec
         wJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758816536; x=1759421336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lwx7tJRH2BwQj2+dcBbdXE5rd5qpyy7rUF/2X1K6wOM=;
        b=LvKH586+SXbrDbsadh8l6ofGmkBXyFd6u1V5skFuYuYC7ex6uy+6VIS+LVZ5nJ3Ljs
         Af4zNWGGZ6qP+w6jmhvPkNWWZ8lIlNPwQOskd19holoIdjvN6iw6c1ELVoK5ydvjOm7U
         vD/mMwsZb3dmHdIaTJnJ+W1i2xLERiSXNZMo1+37PKIQHJXlo9rHoAgY1m87o5ssmGQB
         JoVZCbIdWjo87Hyxyeu83b8rj9HZ2QlhY/3nGi/PUw6BKbTI0W191RhUEKPn8CVZaBmf
         MWhgqEvhNZ5Utf9SaEtQ8hMlsy313F+0HQEdXyAtfpQUtMfsnKa7NFM9/MyTf7UN7oXx
         1F9g==
X-Forwarded-Encrypted: i=1; AJvYcCXfeZx4cKfTOZ/cr5pXWAd6PzAXYh7b7J+Gz7M56V3YV9QA68Zl60+HDVA2lxb/w6jfaW8vc6ERHwFEXTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPSwJPwEB4OguRgthbs1scIw4Tduti/wQSGMfcJUHOq1/c2DVv
	xhw1xM4Uujt6ThJrIM5rlT78CIDn0Dc3Vx5+Vs9TkyaSoHvv2IjdlMwVGZzhOWnqU+s=
X-Gm-Gg: ASbGncvsdSsHgTEgPu7yR3VXEw19EI1o2XIvOqo0WGashlfbCIlX6U11euPXjq+boAF
	IuXzVISTLxerZsJml34UGfPqifsG3MlRM4zH0idLgRY325NRlye9o6uz7mBsFq5ErjhcOrFbWIX
	9IRUF+MiPG7onvJZR/jaJzg2FO9acBHsgoObZz+CEvam2Jpa1EluMeLlBiu7HPuVdrghYJ0o/3O
	G8bpOP3ZwZfdMhTV68UW6dM1XWb8BshVy2/EDXIpTL2+jEV6QUb/nXSgbOoqdMjEhGQ9cWu8B6e
	/9pkLqVl7hII23IdGvUAGNuN158ENrDMnWNhVqkRT0OxXY3k0cD5jmNztCguf6Oz7l5TdqCBh7N
	TKdU/w45jezw3bMXvzlAIPu4pg9BQdKAf3A==
X-Google-Smtp-Source: AGHT+IFC62tlvjqFU+XcU3GgHFR2n6XJpqVbmQQYk+YQUy0S/Bg7lv6RWH30baCARU+QWGfyzUC0DA==
X-Received: by 2002:a05:6402:23d4:b0:632:7c38:b9d8 with SMTP id 4fb4d7f45d1cf-6349fa930ffmr3197056a12.30.1758816535992;
        Thu, 25 Sep 2025 09:08:55 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-634a3ae3227sm1424845a12.28.2025.09.25.09.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:08:55 -0700 (PDT)
Date: Thu, 25 Sep 2025 18:08:54 +0200
From: Michal Hocko <mhocko@suse.com>
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH 0/3] mm/page_owner: add options 'print_handle' and
 'print_stack' for 'show_stacks'
Message-ID: <aNVpFn9W0jYYr9vs@tiehlicka>
References: <20250924174023.261125-1-mfo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924174023.261125-1-mfo@igalia.com>

On Wed 24-09-25 14:40:20, Mauricio Faria de Oliveira wrote:
> Problem:
> 
> The use case of monitoring the memory usage per stack trace (or tracking
> a particular stack trace) requires uniquely identifying each stack trace.
> 
> This has to be done for every stack trace on every sample of monitoring,
> even if tracking only one stack trace (to identify it among all others).
> 
> Therefore, an approach like, for example, hashing the stack traces from
> 'show_stacks' for calculating unique identifiers can become expensive.
> 
> Solution:
> 
> Fortunately, the kernel can provide a unique identifier for stack traces
> in page_owner, which is the handle number in stackdepot.
> 
> Additionally, with that information, the stack traces themselves are not
> needed until the time when the memory usage should be associated with a
> stack trace (say, to look at a few top consumers), using handle numbers.
> 
> This eliminates hashing and reduces filtering related to stack traces in
> userspace, and reduces text emitted/copied by the kernel.

Let's see if I understand this correctly. You are suggesting trimming
down the output to effectivelly key, value pair and only resolve the key 
once per debugging session because keys do not change and you do not
need the full stack traces that maps to the key. Correct?

Could you elaborate some more on why the performance really matters here?
-- 
Michal Hocko
SUSE Labs

