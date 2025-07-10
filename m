Return-Path: <linux-kernel+bounces-725610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D955EB0016F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E941CA00AC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18AC24DCE1;
	Thu, 10 Jul 2025 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iuj26zcQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EF8226CFC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752149777; cv=none; b=bvzjf9zJotkG5Fn3Svax0mMGgXCFtMA8IYU5uRa0k2kT8GgLNkBEtBuXvkwKbyYmUrH61NctoRozfJV783VMPGBB9Zk/TYi9sIZMPMPP3LLpiTIhxUMp34jaf+58Jj5XYU/TGf6MD+cxcrRoTXTqZiC3jmx+NCVsKVshaYI06w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752149777; c=relaxed/simple;
	bh=vzilJF7yolDRaG+KsEOW26nCAiJZzjHCVFbw49K0gkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aPZdbZ2GHInH6J7G+eeQZ48whX/wpMgNoz/UJ2uEJTdSyQuAO7i8UOotuSXtAvmxwG/iBW1eUewk3j4Rhkf1zeqK4Xu65bw75TIoIrL8AClzvQI3/qPJOAN5Fw1fmR3sauJNgj+17AjF0NrbNeLDz9tI19t6sG65Eb6Q22p8i3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iuj26zcQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752149774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C7WSQAd/5bueG40yFS4I1dKflLN1KtjmBQN4YxAf4UI=;
	b=Iuj26zcQjsXdPKvf0rYynrEWEppQFRnhAVVjEuPH5MEx2H/tsbsnOebJ+zbWShGPUtnZVo
	zPlDn9QSNd9gahQ4011IojVU5Ve6dQuaGSYWTnlQVwO3oxEBymMjW+Sr6BBwNc+BJPrqwp
	eihQHTwJ5j3g0MVWUndK5V7+NSGOPSI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-9xMUsUQgOa-aN7NNihCAtA-1; Thu, 10 Jul 2025 08:16:13 -0400
X-MC-Unique: 9xMUsUQgOa-aN7NNihCAtA-1
X-Mimecast-MFC-AGG-ID: 9xMUsUQgOa-aN7NNihCAtA_1752149772
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4537f56ab74so5850465e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752149772; x=1752754572;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7WSQAd/5bueG40yFS4I1dKflLN1KtjmBQN4YxAf4UI=;
        b=IUrskdmZ2MAxerBfz67u40oyzjj1niottvECub/RTvjHILQts3IxHKbQ/wteytFDkz
         q4twRE9FHmfNQFLx+z99Ehj5j1cltk/3D9J2YLU3kom8+iBJjLUfJ9Jfb+4FqkQzOp64
         ObVVnc9BCvMaE6vQo6b/n9tSGGAK5Z6qv3L81ugr4Jpp/sqYeYaM6DRCGy08cigqbutT
         HOI3nBWUTyaQs8cg/39dBxElL7KNGQdWkLi4pGl7AXBa5e/d+TuPMlSVpLbFy47OHViX
         WDhoTkt+zLPnt5hdblQsG22+Oq8F7Ya+dXfdQKnVcQlFqTtwnyz3sEq1Y5UozjCpoLcd
         bK6g==
X-Forwarded-Encrypted: i=1; AJvYcCXVXuiGs5R0uXqJH2UQP9Cp5HrGxSJdBckd78y+rkkLSH9e7KbTgq0ByS2macRf/SAjMbfOnNHo19QTxw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB3vHdT3pdFgJxrlJOfcQl4YEydMLtYDUGUMlZaMuoTLUrpJev
	FPAcc9xHEKHV7AzXoyJ5ZEQ1mT/fJKBz9DsCyNBln4MdebtjInlg+TvsaQcCyfFtVk6YaaMgFfh
	agKz2p5PcDu30H83S/LDUE8xTAJWMyXu3NV4iraHSwVNQFOttOC+NQ18x3bouKvVb/w==
X-Gm-Gg: ASbGnct2XVdWFd9wGkScO4OU1gxLkTK1+13fk3kEevfmQp8cUmFmjb+XeLbP3hyNZs9
	ZiueX+XAzstrVnt+KJ9u4leTN0TSu8jgvs8bNGQ1rkN+37VDblYvE5YqTpt9QahenyEFJKt/JLI
	dMhx7iVqswukmzEtbb+nO9uJI4EgUEA0TChmqtA8az6PjjO6fJErW+OxFA73t18eTr8OXEqQ8Y8
	+ArDeHSIKMqPVlKa9vwl5bUyWb3Tui1zHdBPQDVPtlSHMPV5BQAvi6nX6v/z7x8qlfY3Bx1i1yJ
	zh+tAvCenoY2uo03+magtbfYeCTNTl5SoQKe1VU9cF1KVgqJ4e5KjENaCvvmiuNVwHYzH4OmOUC
	w6V/g
X-Received: by 2002:a05:600c:1c1d:b0:43d:4e9:27ff with SMTP id 5b1f17b1804b1-454dd1f55c9mr24102295e9.7.1752149771962;
        Thu, 10 Jul 2025 05:16:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFQ4fvBl5DvJwxut96PvmY2A7sXSV02kXUs1VCK8pud8vUbxTE4I9cda5ul5FCiRSxvpSrGw==
X-Received: by 2002:a05:600c:1c1d:b0:43d:4e9:27ff with SMTP id 5b1f17b1804b1-454dd1f55c9mr24101895e9.7.1752149771479;
        Thu, 10 Jul 2025 05:16:11 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d511b43csm54657885e9.37.2025.07.10.05.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 05:16:11 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 3/3] drm/tests: edid: Add edid-decode --check output
In-Reply-To: <20250625-drm-update-edid-v1-3-2d963743ab9e@kernel.org>
References: <20250625-drm-update-edid-v1-0-2d963743ab9e@kernel.org>
 <20250625-drm-update-edid-v1-3-2d963743ab9e@kernel.org>
Date: Thu, 10 Jul 2025 14:16:10 +0200
Message-ID: <878qkwfdh1.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maxime Ripard <mripard@kernel.org> writes:

> Some of our EDIDs are (rightfully) invalid, but most of them should be
> valid.
>
> Let's add the edid-decode --check of these EDIDs when they were
> generated, so we know what to expect going forward, and a comment to
> explicitly mention when we expect them to be broken.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

This seems to be much more robust indeed.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


