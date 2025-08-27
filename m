Return-Path: <linux-kernel+bounces-788395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FBFB383C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FCE189DF2D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F66352FD0;
	Wed, 27 Aug 2025 13:38:42 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482535206D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756301921; cv=none; b=jA0DLymBDaOOMhlbyTuBs5c5GRTz1Ej2w2BxD9RiA6ZatKh+Aani1C7XsE3xkvz1QQdFWGmKK/DTxTjj7oAc1MTA9BTs5v2LU816Vpo+T1VPTNevTZ3QplhfKDlTTi8QKEPW4GU3JLJUoxdYiqWQHdShLsIO8V4J8xnoNcfh/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756301921; c=relaxed/simple;
	bh=tL4OiqhRkwSS3/sNwsrl8QhOR+C51yPZtRwxniuBm10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQTHIXbZ/lq6BXdr2tovO87VnI8C1abrymE9bL9AnmVxZyS528HMQ+cK6+D/zuDA5eO204niTP9vL4ISKIdWFfLMEH3DYT4fV0EJj3tRa7QYMiSyuP8hhRtC5Fo8EWcJcL1FOBvNO8ueBtM3bN4cCplLxDMxHKugVoasSJW0rdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61c266e81caso6218660a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756301918; x=1756906718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=co19M5oAe+ecTOIHIeJsLscsP51650xD3EtXlcmFl74=;
        b=TBjMrN7mi5S+VWE6wtfKp8rIhs/D5Sa89R+a70Ao5lRSBSDnVJx26BUgoW6Bo+MbQP
         oiN70hH3GQ2CnILBDH3SByTPCVwyNPscA4ZnpQCxvBAbmd5MVMkW7qrViuPEcyuYvoe2
         OMYHNxXWFGvEDiFjLndhdQICIPRig9Bl/W9Fs1stncVETJk3I01CnGkups9iHzWMdLam
         gceT8dOQPCr5667CQGG+4j6biqBvyFYE6unp+Nu+6sWVEgaVUGizs5mfWcCs+GJENC7e
         NqZc/Hm+ag1xYB5FC+shpyGAbAdJv263Rxh+vsMj7xlgsfdZcsx4k2U1TH1/YikO8NBb
         ujjw==
X-Forwarded-Encrypted: i=1; AJvYcCXixVdyR0q2YwkilHhWmBNoNUV8ju+Is8NUcBTHXSkBPXgKJk4hOQCchHLsGorsWXVI5WRbLR71NFHp6WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTQCqJ0sakwqidxE1k1fzkvQDQ24Ig1v2X+2TGsEIYqNcNc6KU
	eIqlyyUMCxk77dR3hK+8crneWermfVZj+QBdWLG9D2Lebw0nip3RdNzu
X-Gm-Gg: ASbGncughzQ/qxEgM54U8kzv9s/cYNycMCag7yKsAkket+UtCdLOwlIs4CThUkydN0K
	4xNVAnLGYzv9rtwEyBMSrg+TRnDBJmNfbMqVQaG6G1at9wZxRS+JCYrBJ4wIv1GhMJgsKcDqZ7/
	8aU2OYA3+nX6a5ZKIr/m5AiRubW+gut9N30Yl8gMDKlnsKLdomjRQIwDjaHjxwa4wTDopWZjSmY
	65BA3PB/jfYOZQE7sfQ4Rwf47BjtHtQA+ooMlPEBVcbY6zy+H2pVKmc9StKr5XkyeC0r6k+FWjZ
	mLWdSwpOSBwj5Tw1lX1yzBYe3G6zF+cvNrx0xx00l/zghzQ+DLmeYe4kBC7MW6/lwOocyzo/953
	gCVdX/H7Q0k+CXw==
X-Google-Smtp-Source: AGHT+IHtmXT0w3FPBkdO/ZHOIor+CkRnHyq8bQw6ohQR+7/AOkbO+b8BfyBX59eSb+JDIjRQ4lG5ZQ==
X-Received: by 2002:a05:6402:34d6:b0:61c:6ca1:1a8c with SMTP id 4fb4d7f45d1cf-61c6ca1237fmr8654931a12.20.1756301918201;
        Wed, 27 Aug 2025 06:38:38 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c45040d6fsm7905276a12.41.2025.08.27.06.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 06:38:37 -0700 (PDT)
Date: Wed, 27 Aug 2025 06:38:35 -0700
From: Breno Leitao <leitao@debian.org>
To: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Coiby Xu <coxu@redhat.com>, 
	kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 1/8] kexec_file: allow to place kexec_buf randomly
Message-ID: <enzwdtceeqzkb5twhp3lcslzwbfz2xvam2cxo76gnsljlh6cx3@2nzp7lm2hoo4>
References: <20250502011246.99238-1-coxu@redhat.com>
 <20250502011246.99238-2-coxu@redhat.com>
 <oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3>
 <yng55a2z25m5upehczerzhi6zawe3j4ka7amfu4vw4cu27bbg2@x2lgbuk3iqyf>
 <20250825180531.94bfb86a26a43127c0a1296f@linux-foundation.org>
 <aK7uNf8n67HQW+hh@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK7uNf8n67HQW+hh@MiWiFi-R3L-srv>

On Wed, Aug 27, 2025 at 07:38:29PM +0800, Baoquan He wrote:
> On 08/25/25 at 06:05pm, Andrew Morton wrote:
> > On Mon, 25 Aug 2025 09:18:53 +0800 Coiby Xu <coxu@redhat.com> wrote:
> > 
> > > >diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> > > >index 532d72ea42ee8..287b25e674d76 100644
> > > >--- a/arch/arm64/kernel/kexec_image.c
> > > >+++ b/arch/arm64/kernel/kexec_image.c
> > > >@@ -76,6 +76,7 @@ static void *image_load(struct kimage *image,
> > > > 	kbuf.buf_min = 0;
> > > > 	kbuf.buf_max = ULONG_MAX;
> > > > 	kbuf.top_down = false;
> > > >+	kbuf.random = 0;
> > > >
> > > > 	kbuf.buffer = kernel;
> > > > 	kbuf.bufsz = kernel_len;
> > > >
> > > 
> > > And also thanks for posing a fix! The patch LGTM. Can you add a Fixes
> > > tag 'Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf
> > > randomly")' and then send it to kexec@lists.infradead.org? Thanks!
> > 
> > I turned all this into a regular patch and queued it (see below),
> > thanks.  No additional actions are needed.
> > 
> > I'm really not liking that code.  I laboriously verified that all
> > fields of kexec_buf are now initialized, except for `cma'.  Is that a
> > bug?
> > 
> > This function has a call frequency of about 3x per week.  Can we please
> > just memset the whole thing so people don't have to worry about this
> > any more?
> 
> Yeah, adding these trivial patches to mute XXSAN warning is annoying.

The patchset is quite simple, tho:

https://lore.kernel.org/all/20250827-kbuf_all-v1-0-1df9882bb01a@debian.org/

