Return-Path: <linux-kernel+bounces-852020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2562BD7F77
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D95A3A58D2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7616A30E0D0;
	Tue, 14 Oct 2025 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqYgx6DC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9242D12E7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427363; cv=none; b=dFqJ9MkIiI2PHsS3eWA8Z5WAVm4WuqwoXolol8yL9p3XrJhDf7H/56x8PrU8F39iZgWYAEVvv0fFzaeUtyTo++OFtW7psymDXAQXanSiokrLWx+N+xABU4A3YAAaKSQxjnttb96r3k7fodGYHN21venbc2pGVytCBFjqeVMRiF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427363; c=relaxed/simple;
	bh=XfX2nsV/d+yZ3Hk6qajB1hKvZGTfh/kspXwGH+T7Yv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WIWXJiuXBk6akhL8uuxE2iDSCxcmPv6f/ZQex2NG2cGyDwyAuTw8G6rpdqcAfwnSaKgeXpJj+Sy0E+nuzh8QKFGSVIxQGsv9JgVGEeYDjNHL22Vo97jXUDhmq2Iqlf9Qnbp9yxzD7KkietKU445iUR026ftXRHyXXlm8CYSAEmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqYgx6DC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760427361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rp2yi8Bcjq1dxm5BHjQD+Bw0UYm59cbcglHsDw8XOKA=;
	b=aqYgx6DCDAcNonMQd1UK7RYR/eAMr7Ah7I8GzNEqTjwsCnC4Wp+JMlcXL8BMAxhQkeFXYt
	aUETWkOfpq3O+CNN5iZVtDJX5qfsJS7vOn7/f/6DiC9go1dl6Cht4xdR3CJ3yTSlznTvh+
	WjOQaA3vn/p5jDacDtM+WEcdIfUYrwo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-SFG3Ahl-OKCpvQfBquKrXA-1; Tue, 14 Oct 2025 03:35:59 -0400
X-MC-Unique: SFG3Ahl-OKCpvQfBquKrXA-1
X-Mimecast-MFC-AGG-ID: SFG3Ahl-OKCpvQfBquKrXA_1760427358
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e25f5ed85so42160305e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427358; x=1761032158;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rp2yi8Bcjq1dxm5BHjQD+Bw0UYm59cbcglHsDw8XOKA=;
        b=ghg/Q152Bb7YLDz6gyabOb3i30Y5mOz3Ax/TeKBm5j82SYjZvQv11fVOjxysqXhjqv
         oYNgWOjI7EpKIpeEft/+Ommd2D8YYRLdkJ/XVJURLO8QdRoZmvHdQ3G+TDB6yKp62XDT
         XSErN9mf2VeIsIZ/x00XtYhsTTHk77X4mv99RfSbO4R9MSvpVaXpOYRMSfAOW278QXDj
         b5XnpYpoN4EjKiyHJIZsPLooNbk38RvshYz3kUAOaqf8fbcIE3YFOK3+xrctTLJM/8kl
         SPvJpBjmGpaNXjxQZeE17EcwGG7dhAd2qxckckIU0A++7BtKzIvK6DgMLqpcrc0aXKKI
         rqkw==
X-Forwarded-Encrypted: i=1; AJvYcCXqQCwwSB429lowHmIelaCM6bOtvzXKmkfrW/LCymoiYJSYbtmblvq/frsBruhyBdqyZRyNKeJQERYZBvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHXqSAHRaEcRaBAJ98fgdoATesP3jVAyJORAJHtCeFFhm9iP9b
	fgMaY8dImeiHFvXv+BmsJmqLepjHxK64j/FQd8AMbjve4gjrkBssnad/Bi62ruWevlLwPu0Z3qM
	JTMskW5u5H08ZkhDwziKgKQhs64VOigI6T59/ZoKG9XQeuMkXaLvLbYdiD84J2aTMEQ==
X-Gm-Gg: ASbGnctS9Fl0xdXq+iuiyoqUCkDOm4vbUfTRTn4R3UnENrK8e91BzgkRPeq0MSE23ag
	79jK3BqFUTzRcgiWhjI67tnCgRanqF/tnMn8bmDBMQkLAUQzB3Q1KgPC2ubJ8S4atd81PtEhBeA
	qRLXball6mVgDbTe3/aOPxqR37k9gpLlLQp0VXQLJq/Oknn8oysXEhQ0GA/wRMIgqUkAFKb0JLI
	hI1i64kBkjvGehXVen73ZyWvN4w7xB81WQkaTVuTcbAepUqZa7Dza8VLP01+v5xMFz1+NMR9Hb8
	kav8rUEGPaIn2O3STMiYmdfEcYpVYKqJTvUv+FtZo9HGnFsDkT7Rd3McC86Scog85J/fPuCmzjZ
	4XKiJm+8d3Q3WeceF83XwNRw=
X-Received: by 2002:a05:600c:198f:b0:46e:38cc:d3e2 with SMTP id 5b1f17b1804b1-46fa9af3125mr171576555e9.22.1760427358272;
        Tue, 14 Oct 2025 00:35:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWYlHv6WiUrgd9vj3CbYtPVGZ9RfLX5CoNkDJzKegevpgk8U/J3XAJpcTsFc+GvZf4Vvir4A==
X-Received: by 2002:a05:600c:198f:b0:46e:38cc:d3e2 with SMTP id 5b1f17b1804b1-46fa9af3125mr171576295e9.22.1760427357923;
        Tue, 14 Oct 2025 00:35:57 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb479c171sm224366945e9.0.2025.10.14.00.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:35:57 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jocelyn Falempe <jfalempe@redhat.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 4/6] drm/panic: Fix kmsg text drawing rectangle
In-Reply-To: <20251009122955.562888-5-jfalempe@redhat.com>
References: <20251009122955.562888-1-jfalempe@redhat.com>
 <20251009122955.562888-5-jfalempe@redhat.com>
Date: Tue, 14 Oct 2025 09:35:56 +0200
Message-ID: <87a51uq6jn.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

> The rectangle height was larger than the screen size. This has no
> real impact.
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


