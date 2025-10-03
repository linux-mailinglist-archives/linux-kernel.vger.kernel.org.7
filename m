Return-Path: <linux-kernel+bounces-841177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93928BB66B6
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE4D19E62E0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6308F29BDB3;
	Fri,  3 Oct 2025 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+3nXZZa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ABE2628D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759485866; cv=none; b=B9Cy3rU8GtlBAfQso8Y31xxrhae8pp30AUQMioJGLXiYBTrAHLoJpyh2p0V3YQaIIIlRleS5bCA+p+2f8FgA28e4xxPpBibOOQ09J1nGQtqtE084wT3TcL2FUVmEivELE4lPPmEcgd/xgHJv3a7eWXYnf5a9Dt4K+IeCGdWHhb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759485866; c=relaxed/simple;
	bh=lc9B8kqbaulDWIUyRekieM39st8ibNkfGksy0dmH9/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vCuo6Upd6ORYaPV1XgFISWRq64wEAXdYcF2biz+ccq83yPVKVry6h3mEAnbbu7OUB1/QNlTU3+O+Gkl+cXzQGN1Chetz5OlfCyYHB505UUNjGFaqGcHeommenzC5GI5zrlKl7WEBDztbQZSS11xoebCq3HO8FA+m1reXyq3cOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+3nXZZa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759485864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iSGZ7gPwgdEtxj/NHjR//qoE33TcMzmwlPlxRMThCME=;
	b=e+3nXZZaG+gi/WGxxNWiF6r41BS1MorNJbpXfgD3XlGVAKfS8rHsazvWkVnXC+8BbSQF2e
	JHiLI7WgCRvNKctudiAy6pUbpAlWwiqsIhRnYDXEXDQaQ1ua+cDFqAKqxtJagzUHIaE6Ao
	dhcco56EG1xhN80LkJxD4hJ5ylqu7Lk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-dDctOpf6M0-73iE3lzIzJg-1; Fri, 03 Oct 2025 06:04:21 -0400
X-MC-Unique: dDctOpf6M0-73iE3lzIzJg-1
X-Mimecast-MFC-AGG-ID: dDctOpf6M0-73iE3lzIzJg_1759485860
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e502a37cdso19512595e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 03:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759485860; x=1760090660;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSGZ7gPwgdEtxj/NHjR//qoE33TcMzmwlPlxRMThCME=;
        b=qnIlFAjDr/tKctDR6UEGVV+LBllZHqLAarvLp8UHyDIwgbLIhouHMYM1xxZs2ElvZL
         6yLW4UIF8gdH8zIs2q6I2JM3P5/sxbKAhfDbHV/ZR4eij8vOZR3OpOhTNyG7/KhU320Z
         7CRl9qetlhoa95vA93nh8jG20f3R2x4q5A5KWjRC9PVh1tqvOrWYacEgDpVUR9oTPu5f
         DddFG8XA02V2SEqL8QGi0pJxFkhOxRzB5o3npW2qjWK47Nf8efySHGFUgCrCTzpeGwuc
         aOF/dd4TkOCA0SKETH/8jWIzajTSXUUkSTLxoDGEpIBcLxA/S2Ftpe1kUACy48t+86Fv
         p1Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVU4h6mPWQVsqWLTmVPe0zUioVCoLyGjFLVr3VDYTpZnnlsNmUtAFeytZXWFhoCIgcOEKLKPf0pmFpfk3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh8nwHE8DXau11spxGMxQQGrZbImzyK/Tdee0XMRljLEnpPs/6
	dVQSGX93lNmK1KKGqZ75YrmJXD8NQETDDZ+jgB6scj+gwM4WpoZEZiHKxT1ICG+UtL7c51IO+qd
	KGEtSVVOyloQxLEjnxePPLTD1+AePQ5qF9ErdLeMfMQthUHBDM/Wh0c+w0StB22M7Ow==
X-Gm-Gg: ASbGncvkUmYYDPYXMLv4dXI4KJ9pZ+CLwlkfCIezJR8YBWfKu0OAUPSgCPsH2y6+er3
	KxLHkE0GG42mh+K9cUk6MkLWyzTKhqBGicP0g/UHl6JHSik8ZwEQ0xjkyAYfKG3cpGafJR1gsbZ
	aDhtQ0d5YEJ0l3a85mTdyM8v2vMXYMrG4R0XeDrJhW3BP+4vgl+u75/E/KfwF0g0eIqXzsyXzm8
	Rsf+ldSJfc3uWlgH8S9mziR5/RzoQryAtey962qSMaJnGdL6OVm4oGKFQ0NnJrcUO1ysAu+dUtq
	qV0QhVA203eD5TW+PZwaoDELRylE1wvgWahI7mbdIkz3p6MXLJpayzEdHLASqxbYbqJV4QPgPA/
	UyWqsaVxMkr2fWyNSxsAwvJCVIeHm
X-Received: by 2002:a05:600c:8b22:b0:46e:4937:dd1b with SMTP id 5b1f17b1804b1-46e7113f670mr20633925e9.17.1759485859848;
        Fri, 03 Oct 2025 03:04:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9orXhNUEBAdaYwahGtz9hvXNKvvnMSnZWQQcsFvq6YSx1MF8F3MVitfA2oYFkO/QzLz7VwQ==
X-Received: by 2002:a05:600c:8b22:b0:46e:4937:dd1b with SMTP id 5b1f17b1804b1-46e7113f670mr20633535e9.17.1759485859284;
        Fri, 03 Oct 2025 03:04:19 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723431f5sm23697055e9.2.2025.10.03.03.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 03:04:15 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sitronix/st7571-i2c: reset position before clearing
 display
In-Reply-To: <aN9z4pdh1aBZZLdz@gmail.com>
References: <20250913-st7571-reset-v1-1-ae5f58acdf8d@gmail.com>
 <87o6r9o25m.fsf@minerva.mail-host-address-is-not-set>
 <aMvIyOJkXE39sp8T@gmail.com>
 <87a52saujd.fsf@minerva.mail-host-address-is-not-set>
 <aN9z4pdh1aBZZLdz@gmail.com>
Date: Fri, 03 Oct 2025 12:04:12 +0200
Message-ID: <87wm5c47z7.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marcus Folkesson <marcus.folkesson@gmail.com> writes:

Hello Marcus,

> Hello Javier,
>
> On Thu, Sep 18, 2025 at 01:07:18PM +0200, Javier Martinez Canillas wrote:
>> Marcus Folkesson <marcus.folkesson@gmail.com> writes:
>> 
>> Hello Marcus,
>> 
>> > Hello Javier,
>> >
>> > On Wed, Sep 17, 2025 at 11:32:05AM +0200, Javier Martinez Canillas wrote:
>> >> Marcus Folkesson <marcus.folkesson@gmail.com> writes:
>> >> 
>> >> > We cannot know where the write pointer is, always reset position to
>> >> > (0,0) before clearing display.
>> >> >
>> >> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>> >> > ---
>> >> 
>> >> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>> >> 
>> >> Marcus, do you already have commit rights in drm-misc or do you want me to
>> >> apply this patch ?
>> >
>> > I sent a request for commit rights yesterday, once it is approved I will
>> > apply this patch myself :-)
>> >
>
> It took longer than expected to get commit rights.
>
> Could you please apply this patch so that I could get it of my TODO-list
> :-)
>

Sure, pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


