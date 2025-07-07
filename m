Return-Path: <linux-kernel+bounces-720548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BD6AFBD32
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 23:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31198480D22
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E38A285C8C;
	Mon,  7 Jul 2025 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WT62MW0i"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06940219A6B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751922381; cv=none; b=YzvXJlzPVxOqEo/ehoDSy9MuHw6gPFJyO0qHHzNBM/hgWYn5q+WYoimEKpjInYC0afFPwBRLKXHJKvad+ek7h/yTmN/ybEo+18msKiWxZNemeYQHDp64RL36KJhoMRdLfOEZMm6atWy5d57LbTl9Ou6B31UaiT/n3kMYkXlt3aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751922381; c=relaxed/simple;
	bh=27bHZ/4eKvwAUCagjp6sf6uz6xVWNuE4Dw+QOys8IA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdkSq5vRR4ODJMG7BDXfQPw7vsptVOqSQ5g4tXnhTaRnMsEE/AHxDCBvSBClBoVBB2/8JAGIknnO4PPUsR9ZkHDzYd+uA7ffO/rN6m0Ni5Q/Cc1jc3PlWE56yV1qU+RDod3Ew5WvF8bayMnw+FAZxGhNdjjBMp0qnKbJbWAWM80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WT62MW0i; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so7571089a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 14:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1751922377; x=1752527177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10PSMDzHwVgV/mqQhAfZ9cWCULE5QFj3JDa6enCguHg=;
        b=WT62MW0ies0kcBDB0PTRpFCEoAwXBIjTTWx8qhR9SsnpUaIke1MxEjReXhdVq9o+dR
         Bl5t6mkaWFPPO+iKTqf3lPddMm4vxXBDeAKwHUwygpfnLoe4u3uJt5CnHV1GPF9q6lRB
         Nv4CDykOrmkWrWXonoTq4K87G0LzjOz7xLv+dFhVUUBRwwOLeTpyZ1kUSUby0TbpnSMG
         KlJXulJvqrfFfWhb5zl//5fQo2REHLDpB88Tux9taz24LS9G8bu0n76j0KrbI6bS4KDV
         YTpN66yBss5t3mQJ0HMbzSHDwW+GeyRKES9a+xWfXMthGRVXtHp+ODUl5ldEX+ynv8dI
         a1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751922377; x=1752527177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10PSMDzHwVgV/mqQhAfZ9cWCULE5QFj3JDa6enCguHg=;
        b=hC5bp/e4CeDk1Tgd7jiyUnpWpj0JhF8gwCH2BzSZKyiuEP5kur4Jg76d8U47Ct48bD
         JuBw4j//Tn3CNAJIJL1LGLHCz0ZmooeP3pHF8sDX6kHjkqC9cbBKwNuTwFdFIEdPtD/z
         0iUwo+vquSol/5VrynXv0uhfeg58YiSA8fIdySTStr/tpsSMv6z7IMUsRbB8PxkOxOtk
         tQDVYfK+R89Cwz/+2/YXxu3Rf5q9nxUunB38G4LWHAzk3EkBnBDpRY1UVkUjAiYydiBM
         SBGkF7RmF0IAQdE23uukgIQX8ebY5U/tPzWND+ybn1mQ9k/ZPYt2oyiGENQCJ5Iz9pW6
         nDPg==
X-Forwarded-Encrypted: i=1; AJvYcCXJXWv4cU+WyXJwGRE1IKVohfkzT3zaP54VM7IV1wUxMNl/Vai0sAUY3cTVx0VNWy88DwOVD9uY7ismGrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0LQONVc/OiQ0pi/vswkgDkW6L2ByTyJOrjzOGo4+HKgwuYw3j
	SRImAcWC/AW8w2JgEFzijFaVmcaHxwM/cFvavXcuW+HiVeqkLf8WiZaQ8ldh7oNt53o4i63h2Xd
	8V28YYfbapK5M6+LIFergxc5IDQbj5P0KS4kCusVvPNTS6UE8Ei/DSQg=
X-Gm-Gg: ASbGnctjoE3Nvd6qtByw4VGL6tgHenZ1vMGJBAa6n7FCta1nycbHw+CKyBQhWU/yXgP
	ogG+73SWNGT++39R2WRcOXCRgL355BAu71nrYsCQKF7JXlYOmay6RA6aQW4qYEebXz9CvpFDD7U
	0QKx1VHB5BjpNw2VwcDxQtAi6pvPWVgAt6XqPMOzVwJvDCyhXvZcvr1JD2/fat5Sp3sMUY534=
X-Google-Smtp-Source: AGHT+IE43oRWvMb64GujIJJWzdPLDEMjenv4v0Jum7a6AMAGjdiKsKVlgDSBcomtOCCjl6Gzq3fmh8OM1iG4AkHi16w=
X-Received: by 2002:a17:907:d583:b0:ae0:bf55:5c48 with SMTP id
 a640c23a62f3a-ae6b0048ef1mr71288366b.7.1751922377307; Mon, 07 Jul 2025
 14:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707172956.GF1880847@ZenIV> <CAKPOu+87UytVk_7S4L-y9We710j4Gh8HcacffwG99xUA5eGh7A@mail.gmail.com>
 <20250707180026.GG1880847@ZenIV> <CAKPOu+-QzSzUw4q18FsZFR74OJp90rs9X08gDxWnsphfwfwxoQ@mail.gmail.com>
 <20250707193115.GH1880847@ZenIV> <CAKPOu+_q7--Yfoko2F2B1WD=rnq94AduevZD1MeFW+ib94-Pxg@mail.gmail.com>
 <20250707203104.GJ1880847@ZenIV> <CAKPOu+8kLwwG4aKiArX2pKq-jroTgq0MSWW2AC1SjO-G9O_Aog@mail.gmail.com>
 <20250707204918.GK1880847@ZenIV> <CAKPOu+9qpqSSr300ZDduXRbj6dwQo8Cp2bskdS=gfehcVx-=ug@mail.gmail.com>
 <20250707205952.GL1880847@ZenIV>
In-Reply-To: <20250707205952.GL1880847@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 7 Jul 2025 23:06:06 +0200
X-Gm-Features: Ac12FXy6F50P4NXWOvvKplRVqEF2pMhcw6bU6vdK48DU3ApJChGmWA58w4Y44CU
Message-ID: <CAKPOu+8zjtLkjYzCCVyyC80YgekMws4vGOvnPLjvUiQ6zWaqaA@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 10:59=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> Umm...  Note that further in that loop we'll be actively stealing the stu=
ff from that
> shrink list that hasn't gotten to __dentry_kill().  Does your busy loop g=
o into
> if (data.victim) after the second d_walk()?  IOW, does it manage to pull =
anything out
> of that shrink list?

No, I traced this, there is never a "data.victim" because none of the
dentries has DCACHE_SHRINK_LIST. "data.found" is only ever incremented
once (per loop iteration) because a "dead" lockref was found. The
second d_walk() doesn't find anything because it doesn't look for dead
(dying) dentries. You added that check only to the first call (only to
select_collect(), but not to select_collect2()).

I think we're getting closer to the point I was trying to make :-)

