Return-Path: <linux-kernel+bounces-801991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F05B44C81
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C69E7AB3A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CA023D7DE;
	Fri,  5 Sep 2025 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuaZkvsm"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301DD4C9D;
	Fri,  5 Sep 2025 03:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757044304; cv=none; b=MGhdcLmsW+wG5cMBeKDh5cjZ5eQLuSvE5ZPgAhGFFEG7FjJ9o0hz6kqGUZokB2gRNbSvel7qz1QotWOIILxKrZr5W5R08hFyuFO5bx3nu9b6arTjg6OvRdKVF+QxDdR88S37ri9Ki47ZfMc70GcwW7OEM23jjFK/o5SZhQbZM24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757044304; c=relaxed/simple;
	bh=iUhhMIgV+jNQ0e52hg8WC7RP4sbGFDmIMx9YvAtQmA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLl7oGQcHER4qQCqMl6bhljk5g17APeZ077n7fYitXMIAnBJbwIxVVvI/ifbAtkLP5ZgEjIiajdYmYXFFjLivl2ParamC8JqFRDMu9QOfcvmZaMhuJl7J6uchAuW2VEq/W9tXjdAgjAhvl8YSsl+aOGkjJLpX3Hk5M+KzIMCfCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuaZkvsm; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b042cc39551so301378066b.0;
        Thu, 04 Sep 2025 20:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757044301; x=1757649101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTMZ51CLrVMw82swKEmpSkZ08JOWyuDnIwmJ5JE3KQw=;
        b=VuaZkvsmxalQ6FXlwFABhChf6APtV3EgFk61OQVOO0LxZM8xIbah4YD9+rEXjwfLyE
         ZKS/ECixSsdDpFEDZ1omVWXT/Ivkt0k9Ylp6Hjg1LCtd8GbZul6JQymoQGYFeQWPsYmJ
         OKhHcw2w4l+g0eUSgjltWw1OBqIs1dFfZfSllS16SbwH2icdWo2g7JGlGnzbPkfksKW1
         tj+5zSfqUDH8t5AAW1EOImAv1OoOgwJn60+ObyY8YQsuhtkmhJwPsDvUyrQPpQjudfGx
         ssM64dH8lJj94jOE29lundLnYBGK9rLgmQtoFggYjjypUlfC0eRajsDE8RhzvzHzpMTx
         GMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757044301; x=1757649101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTMZ51CLrVMw82swKEmpSkZ08JOWyuDnIwmJ5JE3KQw=;
        b=blugQ7Qt/ofz2jra6n/HAta6AsBKAIpycsFoCtcLMtL7JzbK2L10wMnV2Tr1mo4iKC
         Dt/Gm7vg0JOfXjWohjjhUSM3ZmWLQHuXpT8+1UPsFNcBuSOsICeUfr0TuMGKCaOYbXx/
         ng8+/Ha1GCLcFf7LByfcuAL2EVZIk3lq3MD/yiimZrMM+mjKWo44bEzMagxRoezKubAO
         tA0tSNiDEKKrHvNE5MW1bVdrFlM73Z+yqsGAXb07EzNAM8CpY1wgmFucOfV2L1dDOnzH
         2CHyO81XT8KIQ3FeFHx4CPsdhcvSFV54otkEODi/EcTIC9zFcnAmD/BWlyKuo2DRlXJG
         fdIA==
X-Forwarded-Encrypted: i=1; AJvYcCWRPibVGdGxB37aF87wcoqg+rtzV4tHUh1BHwJtzh1SezBTPEIBNeOvAr4N2XZtQFpbf+7IjN24k5F6gxcO@vger.kernel.org, AJvYcCWnhdFyhlXjzTjFpSD9taaif6X18f/No63lYRLxLG4dExNdxdaMzgKS8qDQVX00tVIHeElliRJPxtxB@vger.kernel.org
X-Gm-Message-State: AOJu0YwLngz5na2Na922RYSYJKT+Y/VSbED9kdPzBKaNgk9vQOl6UNev
	xpL9Zl/SPAXwhVNi4JSMXvv01DYjUUiNuZXY4R8DTma1e0g45qcbqrCknsVW9oFtorkMDxe8fze
	GJX/gkEWmqPlgY59WmBTZcg9R5qeTMfSD8vBu
X-Gm-Gg: ASbGnctkbzhHTClKsFzUXyGvWZ99NdDb3MGOymA1MzvbigfHdnwfpbKLwP0Au9kbl0g
	OwMXX+JEL5Ycvgee4uy4iNR5RTJMzuUecIxyF3gGpa+ZBARBPjhMWHYJp3m2khoFHfPnCotDG3B
	1cI/OtnwPqMf6HjfILAe2wpeUgDBzg8zmpfx1TyOMfw+5dZncDKezQNahATEwJZ9nzGOOnovPhq
	0PcFk2S/Luob+7Z
X-Google-Smtp-Source: AGHT+IHcVn7No3ANoqx5woQ67BZrl62KReMCA2T36hJckpRBJtNeq23+uG18xwyotgKBGRTvHgmGlRKcK8i0ImMDvRc=
X-Received: by 2002:a17:907:3f12:b0:afe:ea46:e808 with SMTP id
 a640c23a62f3a-b01d9793846mr1869389666b.47.1757044301283; Thu, 04 Sep 2025
 20:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825065240.22577-1-linux.amoon@gmail.com> <20250825065240.22577-3-linux.amoon@gmail.com>
 <e31d35c8-b2b2-4301-a13c-e18ad83a21d6@kernel.org>
In-Reply-To: <e31d35c8-b2b2-4301-a13c-e18ad83a21d6@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 5 Sep 2025 09:21:25 +0530
X-Gm-Features: Ac12FXxyDiiV3g7LkqGtc1SDoPuFAN0OeFKgOY8PLCoMNfr5vTocBW2CQHpvMww
Message-ID: <CANAwSgQOcqYdMjxN+ZmTDMj31VrCgCvACvkNpErJExvR0kiw4Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] arm64: dts: amlogic: Add cache information to
 the Amlogic SM1 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"moderated list:ARM/Amlogic Meson SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Amlogic Meson SoC support" <linux-amlogic@lists.infradead.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thanks for your review comments.

On Thu, 4 Sept 2025 at 19:07, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 25/08/2025 08:51, Anand Moon wrote:
> > As per S905X3 datasheet add missing cache information to the Amlogic
> > SM1 SoC. ARM Cortex-A55 CPU uses unified L3 cache instead of L2 cache.
> >
> > - Each Cortex-A55 core has 32KB of L1 instruction cache available and
> >       32KB of L1 data cache available.
> > - Along with 256KB Unified L2 cache.
> >
> > Cache memory significantly reduces the time it takes for the CPU
> > to access data and instructions, leading to faster program execution
> > and overall system responsiveness.
>
>
> This statement is obvious and completely redundant. Drop it from all of
> the commits.
>
Pending additional feedback, I=E2=80=99ll revise and drop them in the next =
release.
> Best regards,
> Krzysztof

Thanks
-Anand

