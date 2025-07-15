Return-Path: <linux-kernel+bounces-732575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7D7B068FF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6491AA76E9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247FB29B8E4;
	Tue, 15 Jul 2025 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnT6mzsv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209A45945
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752616866; cv=none; b=dVZZeIOYxq9GDVdO5LFEytE80n0VpPgqalMcIAejMWkI5LNDhk81Ta4FqmKAb5cLi2IhJrxBVoPaF34IK3KdZ1uT568Wani4BN8DvKaJxxDkpp61mfVwgIhTKgCe1+Z2+0G7s+5YR1y5TrhFBP1HLgt/3hP8tih5tB2gyeH1tVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752616866; c=relaxed/simple;
	bh=aw4VtfDqjuaCSCkMl9eKdyKesdQJxtCTX+BsCCEcx7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OyBgRkS4dLzYuyuCJuc3wcQLetE7z6dmbDBrxDUjYKrLmo/Tt3ECwI9bRDFBjMWfgyOXi55doIXp6Uu+2Tgi6HWTD9NGkqIifzlcdd0Jn1UTGyQIauLDVNWPfFroJbBFmlUJ0GV25EoHBasw/uuPEJusTfRzAbf64pX1AMBFv7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnT6mzsv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752616863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLAwa3dvkrMO6tqYCU+aUo3W6TsJmM1uaesMjUYNHF8=;
	b=fnT6mzsv34iKi5PckdhaSQUeIYqMDP4xF0Ya/qqoJ8KlFq0H5llioxa6PrLBUBayBO0uIS
	mTHCpgtwHgBTYqFPw5wksnBsgzHncKN8mdKhaLWYSAbcGSYZ1B8+a8qmcaOyzKuFtr2VMv
	YEKmxMW6/zI7/3PyCjar+QB0tKoNv40=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-QvepMp-zODmVls2qU0TnZw-1; Tue, 15 Jul 2025 18:01:02 -0400
X-MC-Unique: QvepMp-zODmVls2qU0TnZw-1
X-Mimecast-MFC-AGG-ID: QvepMp-zODmVls2qU0TnZw_1752616861
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a52bfda108so2878607f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752616861; x=1753221661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLAwa3dvkrMO6tqYCU+aUo3W6TsJmM1uaesMjUYNHF8=;
        b=D80a3hoGQYsTY3Hvijd5TpdnIymJjAUO7Ry15iklqSWPHqKxaR5nqI5EljPDIs7MVU
         c70W8CZwChliokmKQOUiwLFepqklC+vdRuEgmHEvNCWm80uC9WswJR1sSQeqkYnDjGtK
         u5AuA7ki0f2fV7cOo0aA0DKzaOx3CINjWXqokLqtOxNK/NCyRX+5LjQJcmLbMvVdAW80
         l51UDn4NmdZ0osZUoB9CxoiXtqwTYTRdjOCmSwSEHDy5bjggQi2gzq1iEbtFX167f2Kn
         qn7zMHYkTbWwpz9mEBLymVTFCearwQAUrNy6vhSj3C6kONVtiSt5l2Rv1WzNvKjtLFcx
         nI6w==
X-Forwarded-Encrypted: i=1; AJvYcCXX3HTIKTGbSN2Eot9nRCcsSBWn7rb8ikR3CZkYV3SX/5Hd87QNfm8hgQEkldTCdO5kzYZZtL/gYWNizp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVV6oKwIPTMskHzgX42zdrpCnPIOHKqyVced+MLFRcuR7736PQ
	YIrLbc9VpNaMwn0cA7AoWM0GTWuoxSATLaW92jH14+PdOUGpdNlq9Lqw0Kp5+cGG+X9WdLsAt5O
	4f2EeS1zG3RYZw5kD9A73TKp86SGlfuby96Unju8rgAkIxeEMZiO7YQcF6m12+7OuQw==
X-Gm-Gg: ASbGncvO6OD76ffQ6V5TqJOIjW/QmC9TFqEX7cC1fO73Hx68CGVaqDoAGf/silcy+au
	sai+Izjq6JsstkUmJFtz0zT53v4eeWyKbNpBhBa3FV4juovuvtqIE/yUOoXbCor3rebGLrCNIt+
	JC6URhQNQTsg1bKnJ22DzJ0vI5qgAg/BjeHCCL38fY36WL1NUr/VfdCvL/BqnIa2kqy65xSSr+l
	ia09ND+4gHsqQxhwxFKtl5ipex7S7dVR5zwALMgMotfjtMYJJsM+Lk7jIjQO/DXpgWMIQWhKnfz
	QPkvl9e7ez73gDao+0dl4mO0oharvuF25AxGJZrQuY+IlLiZ0Fn1wa/orUvtzGZG91Ry/69vp2y
	k
X-Received: by 2002:a5d:5d0c:0:b0:3a8:30b8:cb93 with SMTP id ffacd0b85a97d-3b60dd95a75mr555274f8f.32.1752616860699;
        Tue, 15 Jul 2025 15:01:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLDHsg8OR9x/gIzmibOJxTfaj3TRrHrpjR78a3np6L7t4fAQSv39mTDqr+YfaxcUEbilL4qw==
X-Received: by 2002:a5d:5d0c:0:b0:3a8:30b8:cb93 with SMTP id ffacd0b85a97d-3b60dd95a75mr555234f8f.32.1752616860168;
        Tue, 15 Jul 2025 15:01:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:5b4d:4594:545c:dd8? ([2a01:e0a:c:37e0:5b4d:4594:545c:dd8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26c97sm16368518f8f.90.2025.07.15.15.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 15:00:59 -0700 (PDT)
Message-ID: <05c40a0a-d2b0-4f55-981f-6da3765eebb2@redhat.com>
Date: Wed, 16 Jul 2025 00:00:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-next] drm/bochs: Add support for drm_panic
To: Askar Safin <safinaskar@zohomail.com>
Cc: ryasuoka <ryasuoka@redhat.com>, airlied <airlied@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, kraxel <kraxel@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "maarten.lankhorst" <maarten.lankhorst@linux.intel.com>,
 mripard <mripard@kernel.org>, simona <simona@ffwll.ch>,
 tzimmermann <tzimmermann@suse.de>,
 virtualization <virtualization@lists.linux.dev>
References: <20250613132023.106946-1-ryasuoka@redhat.com>
 <20250714000456.14-1-safinaskar@zohomail.com>
 <1961897d-cf42-4495-aec7-f4c20dfe7566@redhat.com>
 <1980fcccefe.10a7c92b36705.2744765212931179004@zohomail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <1980fcccefe.10a7c92b36705.2744765212931179004@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/07/2025 22:35, Askar Safin wrote:
>   ---- On Tue, 15 Jul 2025 12:57:04 +0400  Jocelyn Falempe <jfalempe@redhat.com> wrote ---
>   > "Normal panics", is just the console logs through fbcon. The problem is
> 
> Thank you for answer! Is this possible to configure system such that fbcon works normally,
> VTs work normally (i. e. via framebuffer), but when panic happens, it is displayed via drm_panic? This seems to
> be solution to the problem.

Yes, that's the default if you use a drm driver like bochs with fbdev 
emulation enabled. (Of course you can't have DRM panic on a pure fbdev 
driver).

There was a concurrency problem between fbcon and DRM panic, and I've 
solved it a year ago with:
https://patchwork.freedesktop.org/series/136182/

So make sure you have the following in your .config:

CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_PANIC=y
CONFIG_DRM_PANIC_SCREEN="kmsg"

Best regards,

-- 

Jocelyn

> 
> --
> Askar Safin
> https://types.pl/@safinaskar
> 


