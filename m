Return-Path: <linux-kernel+bounces-837238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C2EBABC17
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09432175235
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8006C2BCF4C;
	Tue, 30 Sep 2025 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fRkfoK5V"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216E21F462C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216122; cv=none; b=nMlFpj6sx9J6JgHB8EpbEndFMzvkBXdxz2IDZg7HocXPsXkLHqnvsLopWoFoIrI2jFti1uI60AR171vFM9d7L21VQjX48gCBXWxuZ5RDMPHBdeCiwIObSpGCYLYVFz87bAMzidRznPFeqKWfIEpI2uZAy96ylakpVNavfn+iZ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216122; c=relaxed/simple;
	bh=qWQPUUkCkkV19zNqrK2WGTgoeDTRNbYXHAJ/vA9PTP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDv2GZS4/gDQp5plf/vzjHy1gTYiW+zzjYCmCw3GD8/gUDcje6bNTS0ZEdg/h291v6h7/Rbh99ECAQoZMx4pnmct+28cabmIV3tXGbpKsbMHSYOu+mspyNODlSuolDdmmGFEwn46oyqBG18kZS7RZhD1HehvMd2KvGo2nALR44o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fRkfoK5V; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57bf912cbf6so6323307e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759216119; x=1759820919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwe+uVVGDXkZSpUyoeD3Xi/i6aYh8K/CqmdbPD2pAxw=;
        b=fRkfoK5VoJp4UP9RnZqEqMpiy7SfeKib5tBwwPDGVLaY7mmxWKRcgTyHXWqrg8WQ2X
         +ubIkcZLy/h0pgIgt/oF2mXuhxoWyiq534BIy19nfgh9BsWIUVC+wDVFIsEGNbhZMlvs
         /KZ+4V9GWdaoR2pIwx2Vi26hK8wtMXFQkoMUHAx4dY9jRNRkc20n/kn+R9KE1ClTSJ7K
         +ArRD6Q2LFYx7631lMZ9Q8a73r4A90Sy4CK6FswGblIgdK6Vb1avr3nOB8Iqvh/c12fQ
         6rq13OJgt3Gm1wuX2sk5aGvlZWzLC51JvNJWSafVOAQgKEAojjdLiSlLyt3x0wh13W5H
         XOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759216119; x=1759820919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwe+uVVGDXkZSpUyoeD3Xi/i6aYh8K/CqmdbPD2pAxw=;
        b=vYPhSXmz7bEsD/Mpx8KsNz0oSFLUK0PL55B22+ZKJ1Xo43LgUBKVTJ2w7Xfi2xO9ir
         hXBGX03TqCn39KBFqHYFMzBp5XmPgjDo0oHs2zmLBxSKgnmiNLoyp3YMlCH02/7/xXyD
         UCci/2QWKtU8/2CwZZNJvApGCF6BBouE4uCr5LM9EEy/eBcyqtKuDnnfK6UYTbEds5MU
         nP85tIV9sPznFFvInUIudKvnOb2ERqyfcy5lNJOT3pFJ2b2NOo1VlEj5xc+/C0ucL92Z
         wKmGg3BSff5HN7CVa38DmnW8tKgXXec3USrgReCMbIcgxMg5EYcKWyruHG7xmMEjDA2p
         186g==
X-Gm-Message-State: AOJu0YxMpGXBoe/pL1458mJLhuE7XKkflbiMbr3D7+pRMfSNdg9CG15L
	2+b/yu9lu345Rmbb6MqnzY5X+/nr2Uca3TbSiwXJS1kxp0UjFw+HHHGQn8w3uUUAan4jh4L7a6p
	oyzi3nTCriw2ya+0ql4nAsnQAod2yGcRlFJco87gaUzq85y020867
X-Gm-Gg: ASbGncuzUZXvlFXe98Stk93147LEeT0hBQvbw4WYNiDZxBwop4fyQqJtk0lvgWdjUeJ
	w5Wg//3NYGvQ6ut79CgulJEorYR5xqfMowTekrlbV7Zc71fl16xS059DiA8h16OpniTf9U6WHPJ
	JHC4KhR1ymRaT0Qam/Eef4f02UMcLTe6S4ogv5rbqKiyrwZbMcgFR5D7BFezwIgKq0BEcK+AZ2s
	nAWiiepqctJpecekcWDtZaIIwYjY+UTD3yNss1phRncEZ84z/OwmsNgR2lYB0nkLXjjxp8tUMg=
X-Google-Smtp-Source: AGHT+IEn57+ZfFiQKbnwjnObh+24OGeSBpRxA1r0P3grMEzlyYxifukqiainmfdrIL7O0642sRpYNy5aojA3GcSdeKU=
X-Received: by 2002:a05:6512:2249:b0:571:8fad:ecee with SMTP id
 2adb3069b0e04-582d12ff836mr5326325e87.21.1759216119310; Tue, 30 Sep 2025
 00:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929155053.400342-1-marco.crivellari@suse.com> <aNq6pObNPCihWON4@finisterre.sirena.org.uk>
In-Reply-To: <aNq6pObNPCihWON4@finisterre.sirena.org.uk>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 30 Sep 2025 09:08:27 +0200
X-Gm-Features: AS18NWCtgfS6naUd5qaJZRE6qoUqnuVcPTzv2MtJ9EdtIxWfiNalcErVrgI-DOQ
Message-ID: <CAAofZF69Lcuv9hL29eNKVAYAqsOWdeAd=2_4PXocTd0rX-11cA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] ASoC: change system_wq with system_dfl_wq
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 6:58=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
> Please don't send cover letters for single patches, if there is anything
> that needs saying put it in the changelog of the patch or after the ---
> if it's administrative stuff.  This reduces mail volume and ensures that
> any important information is recorded in the changelog rather than being
> lost.

Ok Mark, thank you. The changelog already contains all the information.

Noted for the next time.

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

