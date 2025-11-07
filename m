Return-Path: <linux-kernel+bounces-889985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D16C3EFEE
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17874188D830
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E257311975;
	Fri,  7 Nov 2025 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AkRtcC+C"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A0E31196F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504962; cv=none; b=BnDLWNoHprHId1YlPTg/Rq0JVOfLfOufQVMU5M8NCd2LGS9w6w1UsCTigRB18Lu4LCoxiiPoVvU0Dd/KniNsnI1edmNb9yZys78TLqzit16IQkCPc5gWUGAGEr0wJUvVQSyI4fTFFhziB/gti/MsQ9k3/w1Z1LrHHb5LfR0kl8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504962; c=relaxed/simple;
	bh=kqamqyto+rWtCBanEW+Zo89Cyr5s5tTDlPQfXTLevFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzCPYpSnAJZ+UQQRXKneXkQ3F9f11Em0b674IMcx8gsc9Gh/7aMtY7+1v/3tVkBYHZ1Ql7q3PdPS8e3UHBJaBdsYZAYjGkgaZ/DWV7aY7jt02I1pBOyJERSakVnh/4uwlP8BWK3MbH2glVVmeN8jjjzhtgsp49Js2aZxWFqCWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AkRtcC+C; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5943b7bdc37so466663e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762504958; x=1763109758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqamqyto+rWtCBanEW+Zo89Cyr5s5tTDlPQfXTLevFc=;
        b=AkRtcC+Ctacr084esL4zjiT5f93AwA6tGYdQL1V1pOBaokpJQHNWbMOElZCCCj4r7/
         66FLDK2soFQzirHlYVkAh4zmLDKYiuoPO5ZiKXjrNXnU/jFAVjQ0UYybSrfRO1XXHUDb
         Lk9MTnXsp4IXyBuGzeODxeGfe8LsW3RmCxmuqWg0Jx04a847El03PZXIn7q6aNGiV2HB
         FoueGgCdP6z6sV2rrnQAUI11caFMXBVz3yudj08C4opnM/M9AHKqJeu0Myn3t598tnLc
         kbfChDUt/nJPfT3kHklJIUmaTA//2v5kvp+ORrBnstOmegJ5XvPX01/AB8V0CKEYYD18
         S+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762504958; x=1763109758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kqamqyto+rWtCBanEW+Zo89Cyr5s5tTDlPQfXTLevFc=;
        b=NgZNW1RbEM73P3oI0aarzOlQxmbiZZkcxafATVya0BIJ9sMFa9olXPQrf3osjX93OS
         iTX7e8HoG1g7UnrDZPwADR1r5x4F1Dm0VLbyp2IdxuMyuMve2TIVEIr5g4VVUCetu3Vy
         SKHX1f5V/sQzmTs8IL386Qqaj0bGwzb6+R06HR0mBrOisJvVYjxkotg0wAVvoiRKDQM3
         o/xvrvII82F7au4yQHGKH+/0KRcXyWjhD7mRHOyLMH+RkCVQMPMoR64FSj+rsEXHsqwp
         NUR4G06wpbsZhLMBJftuyfYoIH8wlfGMfrATcS4u+KxuXppMNxtjQYb3mEqAxrNNA5YM
         BmxA==
X-Gm-Message-State: AOJu0YzRYRsr1VbLjxlBtymHp4YtirxtU+zgW/lw1H5YrcqC5V8mkw0Z
	kq0MVsiaOvX/NlRkXncDUwJeCeiAqx+L9fvRgRqp057+D3a5nlKOIguo5ZAO/yVT6aB8HGibY67
	2munijxRLsXo6tYhb6RDEuMU5AylhHDb7q2Vg7aPQMw==
X-Gm-Gg: ASbGncsfJQXZhT5o4Cxl0dwCwwkFWhOVJoV33hdaVojblIt3QOLkQIz2VG+UbMABSsl
	UXkB2ezdIVtQTjNL0DECMggplUAUivC2zpybNnT3nusCSokbeXmpwY95/d6z8Il7qNx0/xHWbdn
	C1kHssjVHUMK3VNGa7/p4Ihs0vygLPPo+xbM4rrV71ouLE1JxnWR0fG6RVFWbTP7jQ88PjFTRuQ
	KkTNcckdZuIcQJkAF14R2HKM2n5Nvwt9u1Vq0Ym+gxDEVfgpyRXoYAEQQ8AVkVk3Nl6SFkS6Eh8
	FyswMwRr8k3ab/tRWQ==
X-Google-Smtp-Source: AGHT+IGgc2i8bQ7u19MvigP/q3gPcpuBFTeTqC+K0vl9YiMYmp+zGdwDP/FiKsJi3vVr4c9RAg/8EQXISlZlRyZjvcA=
X-Received: by 2002:a05:6512:6ce:b0:594:2c42:aba9 with SMTP id
 2adb3069b0e04-594599e3ec8mr353498e87.25.1762504958185; Fri, 07 Nov 2025
 00:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106150121.256367-1-marco.crivellari@suse.com> <3b6c211d4da50273ac5441bc939dfadb537c655d.camel@mailbox.org>
In-Reply-To: <3b6c211d4da50273ac5441bc939dfadb537c655d.camel@mailbox.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 7 Nov 2025 09:42:27 +0100
X-Gm-Features: AWmQ_bkFmB0zBJan-HPavmLwsc276unrA6EXfHMDRSvl0M5pxqhYnaw7YFUfYnE
Message-ID: <CAAofZF5ohD6=izoUrzOCab0euOT5hkx9faJSgwZF_zn+EsRAhg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/sched: Replace use of system_wq with system_percpu_wq
To: phasta@kernel.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Matthew Brost <matthew.brost@intel.com>, 
	Danilo Krummrich <dakr@kernel.org>, Christian Konig <ckoenig.leichtzumerken@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 9:28=E2=80=AFAM Philipp Stanner <phasta@mailbox.org>=
 wrote:
>[...]
> Applied to drm-misc-next.
>
> Thanks a lot
> P.

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

