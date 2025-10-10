Return-Path: <linux-kernel+bounces-848091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC36BCC7FE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72384082DA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D499D2820DB;
	Fri, 10 Oct 2025 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SVFzGOsq"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3511D26CE22
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091413; cv=none; b=AdEiSXQAl93++RVhIEHmr6jyZtvTFP91qt4TDUHzpO4Aj2uWPOt3luvie1AQPdMpjr0l5jb9ZBNVngazdYLXAuL0biavNGAWblWEPPPiN1M2czN24O1DpbsBbCfRixf5/3m9ZJXa+UtX+NhgjKvxAqGZhGHMnAfOfzse665vY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091413; c=relaxed/simple;
	bh=TdmJ+2kI8+/RDkbpkVdAstKtFYS//nGmanP6zPsFxk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lr797ijvUICYooSeLKsqAUw9laaj8IYVCiNSsMmK+JbQ6lyHf62MWbxSqiTYa6mZFAuRyTpAgiSS8UXzQ0tqPNhuS+5AdvMuY8h6RPv4+2JxPAnVVzH9v4AMN6hfYWnE3vwU5EAknFhmytoZT7hkdmDKOIyC2vCDILKEzveTp7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SVFzGOsq; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3737d0920e6so19505631fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760091409; x=1760696209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RZH9pVVic2yrv+vJewn6WEN5CmY70TqVTWa15Zi6Jo=;
        b=SVFzGOsqlOI2TffWAHG8p6wQYtle47eB7QMDw/HfRV3Ms23k4GQmFX3gAvXoskLJ1Z
         0XaotkA9/R6CqBOtzH/EDlLlyNGnmAJM4zJs4IY0wThQ9n50BbDcf4s/qOTcRQgh5Ya4
         gfiIADvarStSIG/eXGbSznJwKVJkuzQUK+lYMrCYpJAPljwzGYCQdqdswTenInH2zvT2
         UiKzTPO5G/5Vve2AaqhfO4+/c48hf9KlWC5ZCp6TWQtgaLRmt2xv778HRn36/igX3qa5
         edwiyUee9u34sv225Mt6PJzw5ZmksF737TExPqu/UJJLI8XhRXKGnU1MIiff5iY+49Kc
         kcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760091409; x=1760696209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RZH9pVVic2yrv+vJewn6WEN5CmY70TqVTWa15Zi6Jo=;
        b=vkn+decD9E4KMod17ejasof5jUQ8bjLTFB9rPV8QrVrGmnIrLeRpKADoAvmGbbG2zh
         ORU2jf6MSSDVC2T2NE06AdWl3kflu34tTSvlTpZfadkhGrcUnqKCzNbwz3BJ3/6uhM8k
         LHGRRBrYJsDmlC7ka4sA3U9e7nHIV+EYwXmN2McORT5Li9hmusA0dV7r9KReLneQEvVE
         Xd7QAZOuqvo+jeA2CjCpt/3nquNTM5EUXEXSFOvgtS6Mb1sn8qTA7AJIZlsc6o2OE9U3
         qDt6BymFigks3O0tBUXG1htiUXX31qZb9fytfame1Nn+IHZjABV+CuoR6vdEhK6cOrIT
         9kkA==
X-Gm-Message-State: AOJu0Yx2yo5NqHQLXjnPZeP5oakz5+06FZ9uKRear/XELuy5LzcSdKKl
	Ab64PswawB1rZ1NkPn2kCnhsMszG5gzz2VS7maaN2HjLV3f/VfPqIQf+EJcV4FrP4CtQZWYsTYR
	s3Jy0cLhnXykQYp9zTmoGcNdlelcTG81Zi0GNdzqGvMndlh0XAaJsopM=
X-Gm-Gg: ASbGnct11Mmy8ILNcotAXAURdSz8aYYSzAnDPuE+RgtTSa+TSSNCOHYaPB1AFmWgyn4
	P7zqWt6+A2H30Wu/smZz9N72j2u2XSKJ6GGFILmQwV7JkfHhX5Ow//X7HZDCYPVZaXqShSlwluI
	OQ/qnlZCffow8AKrPzUxQUUfKent0694lngaMwYoIY0s2n4NP9b0mDjHS1y5MZ/dCVoPtVNROjC
	9yiIntnVfj13fyLY9PbGrQf6fcux3RIwkOjkTnlD4RNkiKSfQEPVfNZLEM=
X-Google-Smtp-Source: AGHT+IEXRvJ8XhmXj2vuM2dNk1/SZz201oiVWS3ljN20y3owcyTmbgsfzpPD7YEtTSRm4xRpV3qILIAV4rfaovTTwgE=
X-Received: by 2002:a05:651c:198f:b0:36f:13c8:d8b1 with SMTP id
 38308e7fff4ca-37609cf7e11mr28806811fa.1.1760091408953; Fri, 10 Oct 2025
 03:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919153008.324338-1-marco.crivellari@suse.com>
In-Reply-To: <20250919153008.324338-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 10 Oct 2025 12:16:38 +0200
X-Gm-Features: AS18NWAlKW3rJg0jncQpstAVBsGSGT6yTYbs_WIXlaZOyA4r94AD4HhFVgeaTI0
Message-ID: <CAAofZF7datQsN0xJXXJs-t33vh09D5+=2F67Q+GL=TSsqCb_zw@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] PM: WQ_UNBOUND added to pm_wq
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 5:30=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
> Changes in v2:
> - WQ_PERCPU removed from pm_wq.
>
> - WQ_UNBOUND has been added to pm_wq to make explicit this wq is unbound.
>
>
> Marco Crivellari (1):
>   PM: WQ_UNBOUND added to pm_wq workqueue
>
>  kernel/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Gentle Ping. :-)

Thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

