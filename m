Return-Path: <linux-kernel+bounces-810040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656A3B51511
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30D1546AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAC531B82F;
	Wed, 10 Sep 2025 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5FYc8ld"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B179231A550
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502570; cv=none; b=V79pZ3VV5JiJHnj5erpMcaLEZfC/6pMfi7sGPRm86qmhmwJjJqyEOomvdMD7LtHEeWIGA5Nk+9Lrr5+oz+bcUYZGhrWA7XES2F/pwBQQZAa+i2phtJnZ5ZzldCr+LO25FgjitSNOrewaNk7mc+K/Xkt5j9PSRQA1jiISmyTQuGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502570; c=relaxed/simple;
	bh=BQ2XtYRwei+F/8LMUKBdKEm+z8pxUaNiGAkH40rNEKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BDFymAN28NP85Wn3FyCjKBhPxUoU5+2t8fWUPTjBIJn6nGBLAjTrA8iy+XuiB/hCUaNBXOSOW2wouIaZZwaY6zkiaC4dVuPxkk9obPVSEHbMKDa0g6XvUKkRkEIs7WOGr3wYwT8BF9GVQTtmzhAaREXdp4RXUOUzQAIIY+YdV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5FYc8ld; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757502567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EEfKAAgF77B0N35cHlVCZR8H3qoPVBq2FQNy2mJIamk=;
	b=e5FYc8ldR7PPsH5vOcJ5DT3Ww9LNNW9YV4bar2Rql4ltUim3s+ALQGexwwKQmLYhaS4512
	0m9Q5uT8uYpGsgSf2WT9/C79qG88J1a0UWJcRO/OUMXdQXRxet3IEg+hSj5EwXJpZ1dZQF
	5mArQFaLfyIv5ttnfBHtw2/Fc8iKNLI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-_KbLgDXxOf2TV1oC3L-i0g-1; Wed, 10 Sep 2025 07:09:26 -0400
X-MC-Unique: _KbLgDXxOf2TV1oC3L-i0g-1
X-Mimecast-MFC-AGG-ID: _KbLgDXxOf2TV1oC3L-i0g_1757502564
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b467f5173so47610075e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757502563; x=1758107363;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEfKAAgF77B0N35cHlVCZR8H3qoPVBq2FQNy2mJIamk=;
        b=B0Kv4kUabVMs8FbRn4LaMkQLRyK0OMaOjXCdi0jSd+SOslC2KG2ez//Afu/p6QEJNt
         xfVMT0mYpv2bNNb8E4uJflNgsOegoOE8EoGHjgxzIwaBd7MlBJxaHpXaCyuR2Lun1OLt
         XqVQVyVxA4ECpsIMO/X4bpUQtie9hc7m5UouZ75hH8IZXtnKk68xklZcUbdemyE0PmPO
         kIZiOzVfLZAfWBv2f68XsReKFuS8a/9wGKYU95KxWu2KPKpi9Eelj/F1jPrxF88Sc0Yk
         V9mIpH1+ur2chijDao9P6jv9M+UciR7EBLiZCX5FqTwiNN1IhXiIkMQ7NcJNJEkzgbsK
         ZOaQ==
X-Forwarded-Encrypted: i=1; AJvYcCURH+f/OsIqVGslYt1JcpseFLRn/niiJ0/h6bFHsMg9ewTYiyIObs3E/zJ281ZevVy6hRc9gw3WtIwyDdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYLfevXCUd60KoK6PBF/VriCJ/G8rG9Y+pPeaOVTybSNjbFfHW
	AYQgc1v812Ki1RIE4ZiOjg9QDCV5V9c/egju9Ka87NnnKHzVBzUK+55xLTs8NDv915JySXq0zvC
	OnK+1Zt1C9Bolbkeeip6wcsjOijhVB2rzQY+3EEzfxGJybYTDJLL5LKzEr4T2K4HSyA==
X-Gm-Gg: ASbGncuCJHfWIRnrKHGWiz5jk9masPBAklh6v7ziKGOWiWlybmy2peDWy6REnV7Cn+w
	0g86PnkO/QIzjl+zkfqm3LU+xS9btrToW3lLfvUwD2TKAPEjaTOVpB4WG5TUcQvUO39VFoX8jpJ
	/Ql13J8odq/57f8wA6xrHJq+eM5xQ9qklxeNlv20K3eu0kbWkmlfJ6f8TdfbxXecFr1NY/PgBfD
	In6KtjCWiVwY1sJe2j6gg980kDkN0bv1yLag6mP9VcF8QqLWvlt0NPue22Nn/LwBkXFqZwOxpZe
	9UPZlZu0fE/I4GLhlLAlxWFxo9KcDZ/Z2UrfVzkI3sRVOVF80x40s67bbOPgMzIN5M4PxxUTLeu
	XdCITgGAabhCfp2QQ12nZqQ==
X-Received: by 2002:a05:6000:2889:b0:3e5:50:e044 with SMTP id ffacd0b85a97d-3e643555859mr13543070f8f.45.1757502563451;
        Wed, 10 Sep 2025 04:09:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtsE6TP99LwCM9DefOr4NgVBIR7vSn0IU371t63+HnR3UaFYs5LDu32sAvz1H1Dto10pgN1g==
X-Received: by 2002:a05:6000:2889:b0:3e5:50:e044 with SMTP id ffacd0b85a97d-3e643555859mr13543046f8f.45.1757502563021;
        Wed, 10 Sep 2025 04:09:23 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df1ba282dsm26332925e9.5.2025.09.10.04.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:09:22 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Brett A C Sheffield <bacs@librecast.net>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>, Helge
 Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones
 <lee@kernel.org>, Murad Masimov <m.masimov@mt-integration.ru>, Yongzhen
 Zhang <zhangyongzhen@kylinos.cn>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/1] Revert "fbdev: Disable sysfb device registration
 when removing conflicting FBs"
In-Reply-To: <aMFYeV4UdD7NnrSC@karahi.gladserv.com>
References: <20250910095124.6213-3-bacs@librecast.net>
 <20250910095124.6213-5-bacs@librecast.net>
 <87frcuegb7.fsf@minerva.mail-host-address-is-not-set>
 <aMFYeV4UdD7NnrSC@karahi.gladserv.com>
Date: Wed, 10 Sep 2025 13:09:20 +0200
Message-ID: <87cy7yef8f.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brett A C Sheffield <bacs@librecast.net> writes:

> On 2025-09-10 12:46, Javier Martinez Canillas wrote:
>> Brett A C Sheffield <bacs@librecast.net> writes:
>> 
>> Hello Brett,
>> 
>> > This reverts commit 13d28e0c79cbf69fc6f145767af66905586c1249.
>> >
>> > Commit ee7a69aa38d8 ("fbdev: Disable sysfb device registration when
>> > removing conflicting FBs") was backported to 5.15.y LTS. This causes a
>> > regression where all virtual consoles stop responding during boot at:
>> >
>> > "Populating /dev with existing devices through uevents ..."
>> >
>> > Reverting the commit fixes the regression.
>> >
>> > Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
>> > ---
>> 
>> In the other email you said:
>> 
>> > Newer stable kernels with this
>> > patch (6.1.y, 6.6.y, 6.12,y, 6.15.y, 6.16.y) and mainline are unaffected.
>> 
>> But are you proposing to revert the mentioned commit in mainline too
>> or just in the 5.15.y LTS tree ?
>
> Only the 5.15.y tree. Sorry - that could have been clearer.  There's no
> regression anywhere else. Mainline and other stable kernels are all ok.
>

That's what I thought but just wanted to confirm that was the case. Thanks!

> Cheers,
>
>
> Brett
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


