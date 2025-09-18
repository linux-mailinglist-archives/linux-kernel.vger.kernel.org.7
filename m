Return-Path: <linux-kernel+bounces-822606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2848B844C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1C44A14E7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A1C2FB603;
	Thu, 18 Sep 2025 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpNxGUYb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F7223ABA0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193646; cv=none; b=oH9VuQ8K2mJy7eFeT+qQoFe1510LYozY1loqXHOLHeXcojGtOPosF6xk36k14sjadXoRHUGBCD8Ut4j5RMFkHSJW8lIEliCRJ+FzZSqQTEHBzyBCXRRmeQmtrf/IcbZ+8wQFawcGjnMsbhvV4BoTSVOMY19ODdhAqzuuxAdfv7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193646; c=relaxed/simple;
	bh=XztkHdS98svrhsx5cLouN49AuD4jUfkopT8A8gknrUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oGHTsG93Kfekh9zAU/o+KyoWHhJECZfcBzLnCsS4jUKFF7jKeeohv2CjuP40s9Qw6urx8dhoMPCMNkHB0fQPRghnvZ4mXB9GU0x3ZOCLkDgXq6PggRQkV1233iCZkLaPOU1C3B5LsQNtJok6+cNIJPn9nwJaEU8A7ACCXkzxOLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpNxGUYb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758193644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tcqSxb5DeL1TyWKfiM0gpz33Rbm3v1LUwku+6t5SVpg=;
	b=KpNxGUYbFbKB2J4FusQGXi1vCsL1lt2jBe+vl59oneIzTYm2apnFZJQ5nddKqve8AzJGKp
	CGBNSfNVAZ2I+DDrolvlZ9a0f/lWANpAOM1ZaqohGtV80M2qjS2Q3fScVLp7Jf9EAVZPe7
	vnLybMBYifS0fa7ohgTB+PieUgo26Vg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-jr2Z3MlCNfmBr6--59Tmeg-1; Thu, 18 Sep 2025 07:07:22 -0400
X-MC-Unique: jr2Z3MlCNfmBr6--59Tmeg-1
X-Mimecast-MFC-AGG-ID: jr2Z3MlCNfmBr6--59Tmeg_1758193642
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3eb8e43d556so864535f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758193642; x=1758798442;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcqSxb5DeL1TyWKfiM0gpz33Rbm3v1LUwku+6t5SVpg=;
        b=F9EB8qHSEgd3sfg5TfM/l7ocCXoqf0ceagslDN7GKedfsAaEdmFd0WSoJw7R3amzqY
         veGwrjkpf15mr76lOzjtOI6gCl2fx0JrU/zCVjOtaFZv8EheSlW9EdJbhzO45FO7wEJe
         1JT7ObIIsnp/x9uSWBBjF06Zd0bHc5lffKmWosYdX6y5D4WudJHSU8eXkt2LMn4rUrVF
         2qUcDCZn/3+/8F5Nv4R1Xvyc8t4xz0a7Yp3Xk9B3tL6yippTpO/OxL7voiLipdcQYb1t
         cshmTZzj4y8pwBGpxhV0Q8XtJHGiobH8wz99ugtETu8Rqv4RuXv4glaUX4CnD1MIRZKT
         ntPA==
X-Forwarded-Encrypted: i=1; AJvYcCVVS/WDfExWR6WY6AEMxA4wokoqRojro7fMR3riOR/IIwzXSK8fPIMuRbhchlPbz2VblOFm5AQAFqp0djA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYXTeiAeRK7By5SgD1tuUgqsmLn4R+Wqr5Vy/7hSG8kQSIA+Zo
	4yB4DCxbmzYK+YhDjm2YLZP6j6NSo6NFVCBBjXmbRxreZwjJvEGDq1YoVh3P1qdbfSOUYMaQ2cf
	22OLWUszzQCWW8r9wPEh312XCljGfbwzmybwE563NZ7hmnzMfigQHRVg0ZhBZ8Qpsbw==
X-Gm-Gg: ASbGncvAVXB3wIbau4zs8MGoN1DCVcDAVGCv8W1bz0+Ck9E3hed5kS0JrBKGsVpY3xI
	8uJR6/ittNoaZXEIfcs8UW8k+lq+Wi3J0mO226w1ihc1McUrTwoaJKoxHUUeiwHgnOITd4IYkcE
	oqyjQkjVF/G8BZfxJI5ZGJflbnfxVCregrW88bfUO9BnHqh8mS3iWFOvZP7cZV+daJoRLzduxFv
	Uo2Rhh2R730CisPRpwFTaLSXQA8KQgXtGYAU7DxRq6+NpeaSJ02drR6gNzD6jQP/gx8ldpWBOU2
	pA4I/PAjSg8B9MDKDvl38lWsKPY8l6Kw7hgaAOCdJho/+Z2wzYIF1Bef9GB07vko+fEvbTuQmbU
	Qtzdr0W2WzBCGTIstV7H4pg==
X-Received: by 2002:a05:6000:430d:b0:3e2:2215:6238 with SMTP id ffacd0b85a97d-3ede1b732eemr2273284f8f.19.1758193641738;
        Thu, 18 Sep 2025 04:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS9VtB73nB23rIhd1n5gh+mA1OvFubwzSrnnkrrVPB3AI4Ra3mnWTj29dtHNfYx/sCPJ/ARA==
X-Received: by 2002:a05:6000:430d:b0:3e2:2215:6238 with SMTP id ffacd0b85a97d-3ede1b732eemr2273267f8f.19.1758193641385;
        Thu, 18 Sep 2025 04:07:21 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613dccb5e2sm76004665e9.17.2025.09.18.04.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 04:07:20 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sitronix/st7571-i2c: reset position before clearing
 display
In-Reply-To: <aMvIyOJkXE39sp8T@gmail.com>
References: <20250913-st7571-reset-v1-1-ae5f58acdf8d@gmail.com>
 <87o6r9o25m.fsf@minerva.mail-host-address-is-not-set>
 <aMvIyOJkXE39sp8T@gmail.com>
Date: Thu, 18 Sep 2025 13:07:18 +0200
Message-ID: <87a52saujd.fsf@minerva.mail-host-address-is-not-set>
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
> On Wed, Sep 17, 2025 at 11:32:05AM +0200, Javier Martinez Canillas wrote:
>> Marcus Folkesson <marcus.folkesson@gmail.com> writes:
>> 
>> > We cannot know where the write pointer is, always reset position to
>> > (0,0) before clearing display.
>> >
>> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>> > ---
>> 
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>> 
>> Marcus, do you already have commit rights in drm-misc or do you want me to
>> apply this patch ?
>
> I sent a request for commit rights yesterday, once it is approved I will
> apply this patch myself :-)
>

Sounds good. Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


