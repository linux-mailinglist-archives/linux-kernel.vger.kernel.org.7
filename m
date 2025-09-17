Return-Path: <linux-kernel+bounces-820350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C39B7C6CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB45165A18
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120202F746A;
	Wed, 17 Sep 2025 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VevU+bZ3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164A72DBF5B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101599; cv=none; b=Sj5XokTxVJ5YJdg4H6Iilz//ThOy6OSC5juocOv64VmrYLO+Id3s2sn6KRqGXQna15A74yazwuJ1pou0aSaRLHkhAoDlcrNpJBDVzYMsjHlZ/6jjblkAyBzShgKBZnqph99uwmyOM83AbqWefqsUq0SEinCuX96jK2/ltECAgVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101599; c=relaxed/simple;
	bh=oZ25358ZVrqeteNG0nPOUPm0hAC6b9/lBoQKa+CuvY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vGJYW9/pInyvAs6S0usZEMDSCorwfyMX0gcoWSusnQ1OhnDuOxLGfKAMx9YTPuuabRWBESCUxHrcmwwmlVaXee3H6nzjp3aa3e5friZGOFCDh1x1RBjzFDGBVhipwYkEIvtv+/5W62ciSK+DEqzfob4EHweo0mBbSkPb1jEqT+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VevU+bZ3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758101596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=89BDSPXQuFlvPv95q9QMB56awWQ5KCn+7gDQqVOL5IQ=;
	b=VevU+bZ3uYkpy/euu7s0MaAXbySXYjNV+ZwfjXzchYwEZiFI5yM38J2nsZMfT0eqfD6obR
	JJBBu39dc9m2V8Bo4hryGVeecS86zOaBlVwY93Yt/0dze++x/CoVJZicbPvKlKl4GVQWgt
	fvUqEywNOBnClK2DrLpJ2p4rXYygep8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-_YuqBNgNNjy1q9AoxIPSaA-1; Wed, 17 Sep 2025 05:33:14 -0400
X-MC-Unique: _YuqBNgNNjy1q9AoxIPSaA-1
X-Mimecast-MFC-AGG-ID: _YuqBNgNNjy1q9AoxIPSaA_1758101593
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45df7e734e0so39409625e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758101593; x=1758706393;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89BDSPXQuFlvPv95q9QMB56awWQ5KCn+7gDQqVOL5IQ=;
        b=wlFf1v7sHJFsXCR+ViXD4cmYvsK8XvnSSojB17NWik2IuTxcQhyzaE6BSHR79FH+1m
         oBdMva4VqRxCAmP1pWqOdMqgqtSyCH7wP4ysnlEfemE13fEaFSVjQ28jR9IiJCOtSvu0
         U7vr/ENADcIVbMdbQu8AFk0qM5KlKtQU+eet5Jj09vEmuMHcy1K8ZGE3rzXHHCu7+xV+
         fgnT08vMhVa1/Z/oHvyDCt4Ojd+j3s/It/hjA3whTTIQRcIBMuALZ120kSjkap51nG5X
         9Rxcat6p0/tX44H1lLfxMKWTeCyRmtATTMoY6MzIU7if8rCY95UACBL+j7vXOxLnMl4L
         OHoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrX9lqlV16keCl7DesxAnhWaCWp4IHJO5xzmXh0UdHElJd5M7ogABR2TCELK3VNra/w1KLRE0M3fdsXpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoEI7jZeDFAF+fAd07Y4+5ptLqZDvjN8AfEt8vfHauJriP9iRI
	IvhwQp3gscUHyCwiOJphCRI+9x4L91uMV6/tugwri7KVq01sVEGumzY3HD5ulntStqYgE63wWeD
	LaiGG3TAhYaeoxZ8rNfWPNX9B2MZKyPKQoZJudvJDJM5MyfyMLQ08KAi17MGyMPxlyw==
X-Gm-Gg: ASbGncslMFACo6UaPJyBZyJdCc+gzmoVsEtd4+75Uw0SVmQSKg5hq9BCObDBPSqqBf/
	cR8AXW8nfNbKEXqpUl0ejoZAOlKoODvAEHuryv6clj5zJovk92BAX3MLxaBiZSWvBHQKlDfvt0r
	zF+FcuvKAEL5j2ru1e4Ye0xiEnEW7k+Wg7pgGEP2BEmwYNYkCC+/d/4Uc7rSK6r8kE+JHHOXLU/
	cA81uUjXalBpx9/0NgrjwrVuquMGirf89gis18Mcjt0g/wtGZZ6d222T8C4PHIXzGDmbIcp4BKA
	DmvVR+9CCYEMH06Gvw+AFmFWo8wGxK1T6vxDOHih7vWdtsjB7bBpcmzfGmbEuB7czeWcO5NTe9W
	3r6NyFi1H4EbJiamEl1kTFQ==
X-Received: by 2002:a05:600c:1f8c:b0:45d:7d88:edcd with SMTP id 5b1f17b1804b1-46206b2e1admr16045785e9.30.1758101593144;
        Wed, 17 Sep 2025 02:33:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENXZ4rn06CVJu6gZ71Iaf2lGuFxnBG38Z3AWJjORTvoJCFn1PWRhC71R9PJs2NEILp/czqrA==
X-Received: by 2002:a05:600c:1f8c:b0:45d:7d88:edcd with SMTP id 5b1f17b1804b1-46206b2e1admr16045405e9.30.1758101592738;
        Wed, 17 Sep 2025 02:33:12 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613869528bsm29227745e9.14.2025.09.17.02.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:33:12 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: James Flowers <bold.zone2373@fastmail.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 skhan@linuxfoundation.com
Cc: James Flowers <bold.zone2373@fastmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] drm/ssd130x: Use kmalloc_array() instead of kmalloc()
In-Reply-To: <20250914073841.69582-1-bold.zone2373@fastmail.com>
References: <20250914073841.69582-1-bold.zone2373@fastmail.com>
Date: Wed, 17 Sep 2025 11:33:11 +0200
Message-ID: <87ldmdo23s.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

James Flowers <bold.zone2373@fastmail.com> writes:

Hello James,

Thanks for the patch.

> Documentation/process/deprecated.rst recommends against the use of
> kmalloc with dynamic size calculations due to the risk of overflow and
> smaller allocation being made than the caller was expecting.
> kmalloc_array avoids this issue.
>
> Signed-off-by: James Flowers <bold.zone2373@fastmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


