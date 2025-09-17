Return-Path: <linux-kernel+bounces-821452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A6BB814AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E932A06E4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E292F99BC;
	Wed, 17 Sep 2025 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AlZHjY5p"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE5C34BA24
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132232; cv=none; b=V/mfzNhgbI6yRJwHxj2zzf5ruaB7lyooSh4S1Opw7IpxUdtNszwtAgU8sQin6fT/uVdVygFbmvlxr6AUlsq7HRPfeR8V3Ej42vXeClei6MqGjMW91L+i94jhPVttDnohQksy1Jt09xDpXqtS8yCUv/TTSAIxpa0QGDwzs5pW+pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132232; c=relaxed/simple;
	bh=Dl8/1xbvll9SNNPORV5wD3aLW8Yo2wXdT32MfHewHgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dqnup94ZP7EdhCP+Cga3oOmw211MfbRauQurQS5xd/d9FnljQoCJa8KqYhE+rNcZgsWb8s8p9tVpMq6L4Fpm6ZF2TwhB9SCmqEhv4DDgjlBr0td2530EQ+GP238OVoi1z6Q4DTKoeNt/N0V5z0Uz81Zd8qSNm/IFWhD1i5Bd464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AlZHjY5p; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-78e9f48da30so881286d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758132229; x=1758737029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dl8/1xbvll9SNNPORV5wD3aLW8Yo2wXdT32MfHewHgw=;
        b=AlZHjY5pLbNMOLakalGc92MW5ePib8g7OHqRT2sEY33nSgBFhY8X7mpVm29Uum3FvS
         Rt3CjHUzM0yRxa9wRBDa2dRvvk4EObjiDQNPwSkvxCeJN0/Ww1xjBACMVLvkZG5hRpGN
         YuRbBSPbTuO7AWeEph1h+d1a0m3lQY9Y9BtzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132229; x=1758737029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dl8/1xbvll9SNNPORV5wD3aLW8Yo2wXdT32MfHewHgw=;
        b=qR8BW9PWSOhQNQQqKvy1K13pol4LfpdFKdIXac9fXOz9H1n6jCxRXAWhnN7QhDddOp
         RUjCI02Q5yIRAHRNCLWo0Byd0+Kodrnzt136AqfV5dpGRb187kmPeZGgzbGV0+CGVBX8
         IGMMeIZxjAl5eVvvXi8G6b3rTDeG0tSAsp5b5iG9gqE2PF4b0VPCdg41ZrcMnWwdLo+E
         DX/IovWE7uX63kW326XtijXuhDmv73Wh3ldOaGtnWeZ/v5m8jevep95tg8xoP4AK4oBD
         uGnMeDlV9S3ilEFzxusM6Y1X7JyRl7Adc4xAET6ZslPErEzgb07YPf+JBrSJE1ODyh5l
         mmsA==
X-Forwarded-Encrypted: i=1; AJvYcCWtirB7clZJMkJip1ngeQ3YfRuxAkXUNhPdBiat7EiEyXHbuNXfpCah5VB3HDt2JQjYks3vRgHU38cA8gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFFKh9+KmA6aZRKMXZPkpwvruh4qiphFdBgBaLd7LVfkpJSbMn
	aHseN7bkYlYtQz8bWVH834fgrwiae1CWBkgNjDprw2IHWg/j001Jq0myAL/2loDr531aRqlSpAC
	GWho7ow==
X-Gm-Gg: ASbGncukVwCIDe+MBCUnTcjw79RVriaXaZAGiWh3rXny2DcGCkYavBEZRC9YF8mmT5H
	1hkawNhq0xd4aS5mN51h/H2WNFM30gWUYA3BHEavSWj2fDsdNsYPR6ufyCa1KsgQHQSTMV+87Rd
	ZIBnyYqQlmcOmJNYKYvmhYnewpnR6DSI1A4uh0b8LxxWRtr5QudeRb+awg+yPX5bRr9YXNAY7GO
	jcCIO86S5g4z8+r7W3SbkG/lpG/CfvxW31rlnaTpocgdPWquADMaMTx1jvK9eTYS9pbDxF7thAF
	wQoS6BCkId39SFnuM/q87DuugZZjiLCbXMd0voXqHF/7Zr+CjNOMjQTYd+6mvQmmlnEhCFLKCji
	nZlB3+N6w2JOU5zaOfEk9DZQ7quyJcz8pBLglO1aHJbUbmnjOncrVxd3zI5dE+H01jljNrBmU8Q
	==
X-Google-Smtp-Source: AGHT+IHwQuq1P0w4jPRut7OxKhGjL5IpRk+b2/Hdq3y57O8RMEjQGGR+DBK4+G2CGJP8WoeaW0/tcg==
X-Received: by 2002:a05:6214:2aa7:b0:792:f4be:2432 with SMTP id 6a1803df08f44-792f4be38bamr3686656d6.28.1758132229120;
        Wed, 17 Sep 2025 11:03:49 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-78e6a1bf6d9sm18011816d6.48.2025.09.17.11.03.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 11:03:48 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b78657a35aso41311cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:03:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8/vJKU1FoG9zVZ3474LZM+01NOpQYy1+7FcPmw4jZkYQI8f5K1h7Xw51d1qE90K8AxkAd40zQdhrEroI=@vger.kernel.org
X-Received: by 2002:ac8:7f91:0:b0:4b4:9863:5d76 with SMTP id
 d75a77b69052e-4b9dd3c17d4mr9004781cf.8.1758132227600; Wed, 17 Sep 2025
 11:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
 <87zfat19i7.fsf@yellow.woof> <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
 <CAGudoHE=iaZp66pTBYTpgcqis25rU--wFJecJP-fq78hmPViCg@mail.gmail.com>
In-Reply-To: <CAGudoHE=iaZp66pTBYTpgcqis25rU--wFJecJP-fq78hmPViCg@mail.gmail.com>
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Wed, 17 Sep 2025 11:03:35 -0700
X-Gmail-Original-Message-ID: <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com>
X-Gm-Features: AS18NWBTH_B8R-w_buHc5fkH54TOh_tt5uj3eXyk2xndepoDoKd89R4ajv-MBKE
Message-ID: <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I think the justification for the original comment is: epoll_wait
returns either when events are available, or the timeout is hit -> and
if the timeout is hit, "event is available" is undefined (or another
way: it would be incorrect to interpret a timeout being hit as "no
events available"). So one could justify this missed event that way,
but it does feel against the spirit of the API, especially since the
event may have existed for an infinite amount of time, and still be
missed.

Glancing again at this code, ep_events_available() should return true
if rdllist is not empty, is actively being modified, or if ovflist is
not EP_UNACTIVE_PTR.

One ordering thing that sticks out to me is ep_start_scan first
splices out rdllist, *then* clears ovflist (from EP_UNACTIVE_PTR ->
NULL). This creates a short condition where rdllist is empty, not
being modified, but ovflist is still EP_UNACTIVE_PTR -> which we
interpret as "no events available" - even though a local txlist may
have some events. It seems like, for this lockless check to remain
accurate, we should need to reverse the order of these two operations,
*and* ensure the order remains observable. (and for users using the
lock, there should be no observable difference with this change)

