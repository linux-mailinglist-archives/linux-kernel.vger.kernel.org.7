Return-Path: <linux-kernel+bounces-882548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 122EBC2AB4A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F9064EE415
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EF62E8B97;
	Mon,  3 Nov 2025 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A4XDX3no"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA792E8B67
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762161554; cv=none; b=FBu5ARZXcm70KT7LrO1dhsDAsXtgjyCggss40FplGRVAsAJxKGt4EKbw0IW5rxknCmilogyNT67rC4NUG+rkIPvVwjU1mVn2686Thqv4xRrzG05DrYabawJJIk1KV3ucWJf8rJbQlAGOFJabe/fLUCqBhFAO2fgI1d9dy7qHJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762161554; c=relaxed/simple;
	bh=0Y9caYOqSW11yivpiI46fzV2GqLE4ZF0InC9uXM8/Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsjBzJM5N+OQVqX53T+4KzXUnoAcNgk8AuvZgTwzR6tabcS6ejWzHzUZUMy3eCYZ17Kfi+qxsre8m93BwJhQ7RZtNOB7CPkJ3KIaYcfBdTDfPd9ERKwT8dvGbbGNQD74AYYAD6QaW0g6pvVTHgJ065DCBubto3ld/wlISzIk/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A4XDX3no; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47721293fd3so22262515e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762161551; x=1762766351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ynz4s33e0TLs0d6hGvRQqkDSiZ1njMSQRICWUdMFEU=;
        b=A4XDX3noApDwzL1MuaWiwkzukhdKkVkO3pb3TyJc0whbOiiYMgnE2/F4HG/IcE3JQK
         kW4Pt3bSbpiLDgRaCJmRVcersuoR5hYRlam7pqJ9Tf7xij0Yk8E8M4FuwgjIC4O9aZxP
         8WD2Q9H+HufJj14gT66qpDnmYuVGN9VYvf7KxA3/uy0N5jXM6oM+VJDDW+GvuQSjrDAO
         CB4Ymfyt/5gJfhmOq7HH73uWpPUVRkaCAX/C4nM/pozv4peaUiQlumVs1UXsVDo2htm/
         M5ZufSct6XdrodB6I0yX/J0SCLgYUYq0cx6LEaGPXMXfFKtrXafW7S/Zc76WmbqIK5qi
         Geqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762161551; x=1762766351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ynz4s33e0TLs0d6hGvRQqkDSiZ1njMSQRICWUdMFEU=;
        b=A7+VxoPWT2UPDes4DPUxNOoIzyHNHR4n7Spie4GxVUAhO+kR2mP8+skj6gbh9x3+/8
         6K5z72S4xmZTtv7Zz0pRumMHPnU2f4YRRtyhbbkCH/ykB4hUKjjQhuSMdK6V58yx8w6f
         VNGQdFW41JBFWZR97/DRZtPI8qCeUT0Engm+h/E04LLele/U1C9rVC7YRCiInk//0LRH
         bmeBtBJm8q4EyqAb3jfeFEpBz/y5sAvYVYx8TyPtjnh2Fvfj8u/GAPJvV5JE/JX0LouT
         pVtULs1zQqRPxO4muTiIqmdDP9+w35SkFqgWIuzrLk9T0Sy+l6vg4dQerXDO8evJxpG/
         Bssg==
X-Forwarded-Encrypted: i=1; AJvYcCUytFKr+RipEJH32LCSZfoCqEsTxInwk6vKF/YlNlrx1+Q2s3ZMnkHc5fkxpORTpHw+x5qahphk4wnE6eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWY6RV+24+KquOGirNa2CqtJxbHB2+j1n5qJgGFuoUgY22tQMh
	ZIhmSxh990pMieSQ2ZX1w6j9SYAPIqaw9Qz4UeS1fWWXbS0AHjnhqDs38Iw8QYKl7+9Nrmjo8ku
	QVbNm
X-Gm-Gg: ASbGncsetxJEpClAVWA4kOdnEN+G90PcEbYjYEEs215p+H10J8OJWm+GuBWJGf0kBJz
	BQK/3QD72Q/MaaxQN3LugRFV/fT+4GhnYcm8zn6wbetFOnyvQLjYeLq/M7VA4lqnsj5yVDjWT38
	0YceilSYn+uGWV8DtLS7npNWAIsNxGi5GGlNdxLtB1pJA4GWdMv3YJYiH9EUp5TVs0dlBErFyQZ
	T5yRuJsvFJJqsd5tXkk9BVxtQ9s5vVZJWul1lgiGBWrYNAPCkkiJCMopwSQ3KK7uDujSpXeOiXQ
	fjEnRRW9mogOZoo3LNB7LGX8okFvwfySs4IqUmb4dMzbLG/kCZziNiESyXuTVzxsaWumvHS/lji
	LC+dZ0jr9wi6TS+OZEXsiSuPqEITBh/RECc5B5/DJr9y/q5cQcpdB8hYKIdqt9uKzI9ul4XQ2p5
	5jgXsjJueNUIUp0oMqHRnF1w==
X-Google-Smtp-Source: AGHT+IEWfWVVzQFxN3DAZRcF5k08MxsMc9ZYeQ4H54jSP0UkuFE80X1DOa7SdsC7jiBDXkya412Xcg==
X-Received: by 2002:a05:600c:64c3:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-477301041d1mr109894515e9.10.1762161551158;
        Mon, 03 Nov 2025 01:19:11 -0800 (PST)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429d1061efasm7626939f8f.24.2025.11.03.01.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 01:19:10 -0800 (PST)
Message-ID: <7301b0fa-5463-498f-82a0-f40bfee462ba@suse.com>
Date: Mon, 3 Nov 2025 10:19:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: ABI: sysfs-module: update modules taint flags
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251102060458.517911-1-rdunlap@infradead.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251102060458.517911-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/25 7:04 AM, Randy Dunlap wrote:
> Add missing taint flags for loadable modules, as pointed out by
> Petr Pavlu [1].
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> [1] https://lore.kernel.org/all/c58152f1-0fbe-4f50-bb61-e2f4c0584025@suse.com/
> ---

Looks ok to me. I would only move the "[1]" line before the
"Signed-off-by" tag in the commit message and separate them by an empty
line. Some tooling might rely on the tags being separately at the end.
I guess this can be directly adjusted by a maintainer that picks up the
patch and there is no need to resend it.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Daniel Gomez <da.gomez@kernel.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: linux-modules@vger.kernel.org
> ---
>  Documentation/ABI/testing/sysfs-module |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- linux-next-20251031.orig/Documentation/ABI/testing/sysfs-module
> +++ linux-next-20251031/Documentation/ABI/testing/sysfs-module
> @@ -59,6 +59,8 @@ Description:	Module taint flags:
>  			F   force-loaded module
>  			C   staging driver module
>  			E   unsigned module
> +			K   livepatch module
> +			N   in-kernel test module
>  			==  =====================
>  
>  What:		/sys/module/grant_table/parameters/free_per_iteration


