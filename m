Return-Path: <linux-kernel+bounces-841743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7508BB81C1
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B21594EF1A7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC23226CF7;
	Fri,  3 Oct 2025 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Axb0aDr6"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702A0156F20
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759523464; cv=none; b=OPl29eAr25+2SA3Hs4wkjDqKxT4uLsV4Wjrqa3IZSuSTVh5aKsSH53rCv73L5stp3dQ6JAWLjrO9+FwI7WDNKVbOI5jeDLywIp5sf1FvmglHkhN+H2gsH9gk6FCFLxD/Yg8uuUa14ks2qx3VvMA6K2J0HsjaR2vZSEdq/J28I9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759523464; c=relaxed/simple;
	bh=9U5eS3tpDOTjwSiD4mB9OJpQE2C2hcsY67cViEkUtNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u76DrtqDPZvglcc88FVA+UiCiKtDRlgFMf+HZr0xzzpbyz3AyrHGnqba40VWNSOwW1iHexLMBggYax8Jf7FxziERMaEIUzU4lGxqUw3vkvkImyHeOz5LFNBSJ5sMrWPgdaodOzxFRov0g6ccMHQsRXTVHeVekySyawSFkJw2VFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Axb0aDr6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso501617966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 13:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759523459; x=1760128259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5sV0LwkDjXxD47FzgjFP5G/bZQe88QSp2aEYpPv4PQc=;
        b=Axb0aDr6F2/yUHRlMGRT24wfQr1gYYo5flnGmUEhb51Nl9X6QIHj5Xmaqfs0fZHqPj
         WcENU+Juz47/Vnd1jFw3O0Dvz2WXR6N1OwO4XNHsatIot+INC9ayePCIJO7pm4v/RJWO
         EyhuHUCE0w2YyB7gaOYTZdY9wbeBbYsJ1dQ+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759523459; x=1760128259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sV0LwkDjXxD47FzgjFP5G/bZQe88QSp2aEYpPv4PQc=;
        b=sKbjzMqdmSwX0Gx+UMY0uwR6si1vL0/dVLsCHeorkd9qKMDR7MqPCYUx9lyCbv+KmL
         LW7hftfOQzuosotv6pacSJ1DjeqM61nnXVsZKiidTU40XVpTQDDYcxoIzTMl//FX3u/u
         Q6wXYEXeQ3/Y+AN6TD5vDIITrK04JEeTKOw1Q6Gl+zS1nF1BQSKd46zonkz6rFzpFvl8
         SN9fMgqiXUylGyu8nQD9Z5EwxIf/mMS/QPFRepv0ZCHyaRouvF7J0R8xQmJBVg05WtfP
         anlZH6EgBLjSM2BsQ2Xlrq3hocrIeaCW7DJvpayYcLItuQ1in5Fmfnc9+oMb8F/qI5ck
         mtyA==
X-Forwarded-Encrypted: i=1; AJvYcCXOXdd51kSYPkM6NLTN6mxm+4QrdYHCr/y/EkP0vcCxMM3P5I2jPz4mJBSeOEAW5Sr4YWZNKc2rTP57Xts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxROyb4aMDzuP9piDrsrlJiB/M2TnAzc/zDYTjgoK3warG7B9D4
	Vdg1PblDFAA3NZntusPEnmudjgMIPq95qNO44WehsOEmm0SY9vH9d1PiHdrmga2MraciD0lvLI7
	QVKcV9t4=
X-Gm-Gg: ASbGncvCsVwl+0UCQcyHxWFrV5PpwObCgfgq7DKlCFdlDx2uqPH9UODOMoaOFuBMyQQ
	jVD6lzfGtL9mb2gsOkwvy/FoM6jdoeSMJI0Cbpgmdwq2EwFmPz8nl47ZQZmejfwEzhiXT+6WI7j
	H3iVzwBBBaZ685p4Eh3jcPjB6eiUWi+z3tuEJ1DyEVrd6qpoEsKfgEayGtAEyVEzyV77S4jxqbe
	IU+RrfuEdgSnkLuqNAYknYEGyhfILjIBU0LWiNG8EA5cnJC0gR3JqMY8WpV0DDXeGtdCcgx62MZ
	wuL4otJRIUriqp793q4RmqwdbQTwH36OCfwtbOVZ3cN28qhRdll8uOdfa2b08w1e1ZfYXHsrY+K
	do/LONKJjdLCVB+1py9tKync1akvGagTYKmN0kgnpeGod6hZ0x/HHY7cp/L3RSo/QeKX0JyKQCe
	IJoHN5SDcsOtFJAT42RsO2
X-Google-Smtp-Source: AGHT+IG9GHCA5QzzR6JtPelTtM6ocAUqg9OkIXC1occfEVt4SkvGmITDyqN+CaiUn+ydFBihtADqVQ==
X-Received: by 2002:a17:907:6ea7:b0:b3f:e1e9:22c1 with SMTP id a640c23a62f3a-b49c3e6e2e0mr505452066b.53.1759523459412;
        Fri, 03 Oct 2025 13:30:59 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa035sm503955966b.15.2025.10.03.13.30.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 13:30:58 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b472842981fso380263566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 13:30:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXClbKV2UopATtkXuhFpihAWEgexG/CDDalOmk7+SiFyRhaP6m/nhFuDHEyBIRPzZ1BWTE7qUtVaaU+QPs=@vger.kernel.org
X-Received: by 2002:a17:906:9f85:b0:b49:3ee4:d4a6 with SMTP id
 a640c23a62f3a-b49c19769e3mr582057366b.18.1759523458139; Fri, 03 Oct 2025
 13:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
 <CAHk-=wgO7S_FZUSBbngG5vtejWOpzDfTTBkVvP3_yjJmFddbzA@mail.gmail.com>
 <CAPM=9txjNo==nMA7XcjzLWLO155+1bk2THwPs_BmTLu_5kU_bQ@mail.gmail.com>
 <CAHk-=wgR61VxiHyOKXBJv_HinoFVA2av1EuSHg5NcRGC1fNq3w@mail.gmail.com> <CAHk-=wgX-2+hH5fM344_wKYNZS5CSf4ispS4X+s5xkma_Mdu_Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgX-2+hH5fM344_wKYNZS5CSf4ispS4X+s5xkma_Mdu_Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 Oct 2025 13:30:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWpOvU_cX7srXCHJZCxYhRJgMGQvWzR9q_Ly_4LZ83QA@mail.gmail.com>
X-Gm-Features: AS18NWCcD8PEzt_WikzxTevpQNiKIibOqs2Awv0nw_OSAyxfhplw1BskHQrD0yo
Message-ID: <CAHk-=wjWpOvU_cX7srXCHJZCxYhRJgMGQvWzR9q_Ly_4LZ83QA@mail.gmail.com>
Subject: Re: [git pull] drm for 6.18-rc1
To: Dave Airlie <airlied@gmail.com>, Sasha Levin <sashal@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Sima Vetter <sima@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Oct 2025 at 13:02, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Adding Sasha to the participants, since he's been doing the AUTOSEL summaries.

Bah. Let's use the right email rather than some ancient five+ year old
one that was randomly picked from my email history.

                Linus

