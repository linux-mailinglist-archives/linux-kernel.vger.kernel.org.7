Return-Path: <linux-kernel+bounces-751456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CED56B169C8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCFC5636EF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A1B2CCC1;
	Thu, 31 Jul 2025 00:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="TLpF/+5I"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3860F10785
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753922988; cv=none; b=dXtFJH0QzXW2UNYDITDQzyqylWwRPar7Eutkcgpxy8Pj8GFVZPF4vlQybqwqPMCNtbMK0jWyCI+oiojIRzbv7FZt5g8ossFoI91UxXvFDVpH91ek+1/N2jWZSL4NRZeMcHplxRnCb3k6dQPfe63Grs47P+JnvJqDB/WBk312wbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753922988; c=relaxed/simple;
	bh=vJDt2FYYLu2qEDdCbjucML8LgrSLjpCS+v7eTHCd5u4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=TzMtSYWms6T74q6XrROfd2yPOIeE6P3reKZNO2PJK9PynsXeLRsCi7qtNwx6Oi89r7C9+q6OdmmlbDDiTvt8Anc0NNCO0fpUuE+rmF09Gqk97tABUz2pIxeCftp4FcfXb7NwfvdVi6Qaf5XceYwC/WtxiIp9BM6pD1i2pj2MGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=TLpF/+5I; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23c8f179e1bso5591285ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753922985; x=1754527785; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJDt2FYYLu2qEDdCbjucML8LgrSLjpCS+v7eTHCd5u4=;
        b=TLpF/+5IC1lRW1b8l6fLX6wkSbd09Twl0cVOjpU0CXczcY/b3V7xzQ/9C2qE89fqGm
         0zg7vRhqdw0VL7pmOqVsy/7nw0myWrfCwGe1Vbf2+N+O26u2pmu7a81X53MYWONfpfza
         uaR5uQgRTiIq/7hKjnm/CY5P/ls9SbAonrnXvvUHSaPBBmAuJEJnIkJGgjY4YePE7L3s
         YwIququjRqOGG6nMV/7KApO4nGmxbigLysbT1xd+nGy0SclUAs/UjjjPqP9c2flW+0vI
         8fWSQuHzY+ow3b6C37MWLKNZqIvH0HUDghR3OJ9pANgXaiAzpzxaqfx6ITRhoekv0Vuj
         cavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753922985; x=1754527785;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vJDt2FYYLu2qEDdCbjucML8LgrSLjpCS+v7eTHCd5u4=;
        b=efh4ZHSB4Ub2qlX+iXKeOjJ0XBeuTMPPaCY8m0Z8+kB7RsXpFt77yW3ViJ3THno1Qd
         N6Rr8kBGBC0rnEFhSPaOYTrvLque+H4JGGxUmMwFkm9MrAEO37ejxuQ1wFxLf+H/TDXR
         UzrLa16nLPK8NjO8BTG4NKkNLd2Bv2zWWIBvtLc8aR2CKHKYGXqfq8i4Z5Y2tB7jnDSy
         /LgHclwUca4FTeWlSw1ilJh29Jcp88tJt+/SS7etIQe+MspkG098wULkQ8BvfUGXkCQM
         5frC5ad1KT+SM7kRj0cQVjZqlXzio5XqAnBIiYAculZB5PV883q7TsESIYXk31PYMd3u
         MyNA==
X-Forwarded-Encrypted: i=1; AJvYcCWvbUyDrosX+xF+nH+iTtrrkBQAJuy7yUd5F5SO1U0ulxb4b8ZCdvumCkM6hWYwaeQrVhHdW6Kbgq3mj9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmy77S6uTrupF9iYPx/gTj/2mcL5EecXV9gN7TR8uHsGf9BI+
	stSpLCfOOw6hpHaJ0xqx8mjwn0aZdq6oyz92UukUOkL0BMU//6KLHi0Iz1A4n4PuDw0=
X-Gm-Gg: ASbGncsQ1W1ijDd1o9HV6vkEqgJuKvqC2JOmN9JZ8Hy22NKk1tG1sF/7O7zV+4S/2kv
	OdAgcYD9K5Q7NCjbgjOF/M3q7UEoZ6MQCEuTJRkbYHbCfo3SMETwyrLXpxUjYFcjegr/iIeZbyn
	AyB7y5C4zPuvaD+K7+muZzeCjoZwiOnHRFad/CF6AEyva3qYYmM8/785bptCaQznB2hrCkEtvzF
	Ro0k0++IMO4nNtNVWtEKVwc3CcER1OBn9kwfM3wOMKNhOWrUJ4f/mZMaRe3b8cw7YFXO5DgqAOo
	NfCh1ILeA3MGcIhiPkAjJAVfPXklC0XBzZLQvc4zrrNiaFTAJsspV84XtxqrLoqjNic8UxdQcKH
	nlnFMqYC0qs0Hj35ZlNQ=
X-Google-Smtp-Source: AGHT+IFRg4d14fwyDbWfm6s1XgJ9O3YqeFegbjebAyJ4PNp/hfmIOJ7UPSuIb8lsRamTPF40s9y5Jg==
X-Received: by 2002:a17:903:238c:b0:240:150e:57ba with SMTP id d9443c01a7336-24096a72ffcmr57849285ad.3.1753922985361;
        Wed, 30 Jul 2025 17:49:45 -0700 (PDT)
Received: from localhost ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e81dsm2897185ad.46.2025.07.30.17.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 17:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Jul 2025 18:49:42 -0600
Message-Id: <DBPTT2WUK2CH.1V1KX11EJPIFB@brighamcampbell.com>
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Doug Anderson" <dianders@chromium.org>
Cc: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <linus.walleij@linaro.org>, <neil.armstrong@linaro.org>,
 <jessica.zhang@oss.qualcomm.com>, <sam@ravnborg.org>,
 <skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] drm: Add MIPI read_multi func and two write
 macros
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250730061748.1227643-1-me@brighamcampbell.com>
 <20250730061748.1227643-3-me@brighamcampbell.com>
 <CAD=FV=WpbU-iuEDVRuMm87H48PKQ3pz5aBwTRyedguFQA3dvTQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WpbU-iuEDVRuMm87H48PKQ3pz5aBwTRyedguFQA3dvTQ@mail.gmail.com>

On Wed Jul 30, 2025 at 9:56 AM MDT, Doug Anderson wrote:
>> +/**
>> + * mipi_dsi_dcs_write_var_seq_multi - transmit a DCS command with non-s=
tatic
>> + * payload
>
> I should have been explicit, but the above "non-static" should also be
> "non-constant". ;-)
>
> I could probably fix that when applying, or you could send a v4. Up to yo=
u.

Oops. This obviously needed to change as well, but I tunnel-visioned
hard. I'll go ahead and fix it in v4.

Naturally, I wouldn't be at all opposed to you or any other maintainer
making such a small change to one of my patches as it heads upstream,
but I'd rather not ask you to remember to make that change after a long
vacation and a busy merge window. There's no need for me to add even a
little more cognitive load to your job than what's necessary.

> Speaking of applying this, I'll be on vacation next week, so I won't
> be able to apply the patches until the week after. That will also give
> anyone else on the list a chance to comment if they want...

Awesome! I'll plan to sit tight and act on whatever feedback I get on
v4.

If you happen to be flying over northern Utah to get to your
destination, look out the window. I'll wave as you go by.

Cheers,
Brigham

