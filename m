Return-Path: <linux-kernel+bounces-806116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C83BB49217
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E953AD22F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56B22EFD86;
	Mon,  8 Sep 2025 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vg42yqlX"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353D7F4F1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343189; cv=none; b=hciJJK2YB8DAY6fxQ+H1Lf5D2Ysc7Mh/dpko3psdlVuNhuasdPFFqcPb75S4GumJIoW9txJRPyf54YSZG8HwH+Oz5kvDO+8mNQLZ9flfpWYQw70TuKjV4dec8OGnHvcxyDILGXObaiewOBbQ9EFkHRXJ3w9e10+mqU5Sgqi8Wq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343189; c=relaxed/simple;
	bh=w908XqzITzwjbcbAyDCDAnUAsclxmaNblnj33zPUwdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcPXWf2iXmK7Q0eav2YA8XZqZIFIibP2A1uxJS7ohMj1VKTK/0gqkXduZ3jwPT9iYKPB4/VAWiig5+XJyU4++F5kyc7cvnpsClyDj9dzIQ2E1AcgfNWYeCqrWXCylWnhTKWnXw0UREGIUEZ6Gu9Hgzp/Xy90QW/pUsxo5fCFmNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vg42yqlX; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f7039a9fdso4664756e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757343185; x=1757947985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZgxsRyjTNfqBSFfm5OF0LiPwRAdn1CSfCB3geckfQc=;
        b=Vg42yqlX9QIN64GqvUqiBLRnqwEoAfSlyCjlZqqJHSLfaLLpoLy1BKDspS/gv/qpSS
         vWAG+lwBNrRFJ8NXkz02WTABjzY0795H+FgM4PI/nBmkuksOp+JZCmzNv+CEZDHfpPG6
         gE1AyQzY/6DWPar308zHxiq8CsVFYjEmhVO3AhMqn10sctNug/HAAO8sCc1bPzdnDtdQ
         b2MhZxC+cLN1pSaEK2qRnI4thScQl0pr6++/LbGP9JIMmf0W1hQdpyJxcA0DU5uYr9Zj
         sshSO9vjK/u5pNWPGGhdXc0PIwE2p56DJvzvD3yLnp83QMA3dqD1s8LKkOVhxRIGZmhG
         /cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757343185; x=1757947985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZgxsRyjTNfqBSFfm5OF0LiPwRAdn1CSfCB3geckfQc=;
        b=lxSKt7/IIqVdNZlgU0+IMRUtfhf1V/tTHCYIrLzhoWclLvuQz447jYhNsArlCHKvfP
         QofZf2V6W7zmi62EeUmooC4n2myFgUIgoPczumu4f0AvxqXSWOZnQuhuGC7TUZe+WHq2
         kZLiieAfGu8RvQx2Z546WnuhhFAcGKfI/c6YAfJ5oRMlqmUv4GtHTTE8julrk9Wl5DuA
         3y4kM9tAyktwD/1owIYBLwq/Tn1ZSgNi0dGDO/K9c47ILe27VKZgPClM7eQKaz35sCvC
         /JClQCfMFAXlIZ6TtTafOzsrKcbRxYpufMMBBJfEnt0h/48OW7OQDCVPHzAKJwY9u3Ks
         Xfjg==
X-Gm-Message-State: AOJu0YxpL86qtCS2TXsqvQbbTw3ARyyhirosUC1V4UpOXLji0xuIpH8x
	H/OzJVTki9OkS9DUnOfhYhcdlLzwUasOWWdlHKDQOuqJRrFsId3CTPUcHTXlZ3zUFk4/CKo4j3S
	oK0gc09+DVzNcSkAPu9uxDzXOs9MEI0fnPeShMkFeug==
X-Gm-Gg: ASbGncti7jWdV5t49YvuyvNvDIcFKUMUCk8l21dM6BKGSxESbmDZnpsT4ZWIhA6ebEa
	KhMoaMy2vWqwgFhjIFJzcCk2x3y9TGcU8V29Bw9qdhzB6r4kZ6aTlenpoUF8mlNGRJEnNGOgvlC
	gIcv5txdIgsXQh4hvv//8bPcxnJe4nOxGqLBsVTfoIJs8Pf4MMcD6FIl8U+gNYDA7+hQ9kyJw46
	+QcQsIbmPgGNtuLHxwNNxmpTYfisFfQmR21aSDwyjXXLI4zSgw=
X-Google-Smtp-Source: AGHT+IExEfPbhw040Ax9lWYW/00RYCi5NPaxixND3pSwMj6GHZiYvxD5N07cD0pPsVKbbPShd9omKE3rVgQGsIM5504=
X-Received: by 2002:a05:6512:128a:b0:561:9635:5b1a with SMTP id
 2adb3069b0e04-5626275d86emr2242787e87.36.1757343185301; Mon, 08 Sep 2025
 07:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905091016.109428-1-marco.crivellari@suse.com>
 <20250905091016.109428-3-marco.crivellari@suse.com> <54446af3-9ca5-4932-a3fd-e44185751dda@sirena.org.uk>
 <CAAofZF4XEFXWQEqeKJ3aTjPRuu5RgOEYRLX4Aeq=RGh7gnLGTQ@mail.gmail.com> <863db036-c077-4b2e-a65e-af80ea3c2d24@sirena.org.uk>
In-Reply-To: <863db036-c077-4b2e-a65e-af80ea3c2d24@sirena.org.uk>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 8 Sep 2025 16:52:53 +0200
X-Gm-Features: Ac12FXz-x46Jv77tsnZjCak9n0-W3djTFw1DDQgyBPHKQcYYQKtSTpBFVrLvLDQ
Message-ID: <CAAofZF7kqQmPAHedq4F-7T5fYH45WbOF=fWwSRbMcc7ZcSNxbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: replace use of system_wq with system_percpu_wq
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 6:05=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Fri, Sep 05, 2025 at 06:00:04PM +0200, Marco Crivellari wrote:
>
> > Hello Mark,
>
> Please don't top post, reply in line with needed context.  This allows
> readers to readily follow the flow of conversation and understand what
> you are talking about and also helps ensure that everything in the
> discussion is being addressed.

Hello Mark,

Noted, sorry for that.

> If we're going to convert everything I'd rather we do a sensible
> conversion now than have multiple rounds of conversions.  I strongly
> suspect that most if not all of the current users don't know or care
> that system_wq is percpu.

Sure, we can do so. I will send the v2 hopefully with 1 patch only
(meaning that every system_wq can be converted to system_dfl_wq).

Thank you!

--

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

