Return-Path: <linux-kernel+bounces-872454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6EDC11455
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8E43564ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2F231B812;
	Mon, 27 Oct 2025 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8VS+K1+"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5AF2DA740
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593749; cv=none; b=TU0ORDpd3fldAf/ISkhGrPyyRu5Rt5TyOMOLZeqjajIdx8WjK3ea62VuwGqhHo1Dc+yyIpzaMCWd9Lth6R7TUJa+j9cj0RbCTraW9eMWp1lj4JJUAHKQI9Xydyst4AqnnBnx7itZpmBnsb2LPh1QCBqqieE2UxqKC9pkOimDyPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593749; c=relaxed/simple;
	bh=Xoj023B/V6X3Ah2oWRRk1SrS+L09yWMEB3QsC2dKGgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZrEEF6aTfL+JXBKnjU5ybSCZxC5N6ycywpYoACBRgYP8F2vgRiF7+YiESWPa6E3N/PeOoLTzRG+PmyfYar15fbwxu+6+IbiOGIZJGEbQXeTZQAqBOqxJDM2FXD8iJ7tGgLgP6BfFb9NQ8ULcoQNaRFvXzpK/ASZJdO1lo3i7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8VS+K1+; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-9459db1337cso245770539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761593747; x=1762198547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MIt2U1EDF+lEVbThYG7zsgziArCGEJgNGIfSIGlv++o=;
        b=M8VS+K1+FfviTxSMTU5jgYSKIL/6Hd5+QG9XJ/XJ1OHzcPXRYTSnkrLA5iVXdUm7Iu
         t0UmpEjMrm6vOm60+U4E98JWV/f66zwAgIQfGo0bHtk12s1LRbUXaa1GAz/42wtUFZs7
         CwtKvpfoBrDZYP+Q+rZD5Oqzv7BQx+AbXhvFlAkJ0Oe/DGqdDTJG4Z5AeSa9kR7QoNf4
         vv8K9Xae9urUn3/21gX6GFclOcU06W7XAR/g7qroBGavR4MN8EDxFbuw357RvHHol28s
         bUIfD+y2wqRcjVBst6FJAgwwgJUgbUpo9sRofPYHfS1vswwTLqdolFCcjhMVd379TU2e
         oFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761593747; x=1762198547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIt2U1EDF+lEVbThYG7zsgziArCGEJgNGIfSIGlv++o=;
        b=cMPU5uO85A/Cs0EL8xl5OXFA43iwbz5W9OQuJMSSQLi8hvYT6I8mLm54lPETzEM5nS
         FYJT26Z3XlHIBF5diP8UWIvBIR44icuevmRdP0rkYxmHILWgX4MLSRmQ4WOund94XLDH
         q0UlzwnsG+eoFKCRXLMPEt2qKIP8fWo2wkJnRmlQzuwckNZ8eu3IZvCJSopwcave8oQ+
         Zt31Pu2Y5Yn3qd0ZZAURXWihbUtKe6MOAMyE2fSNuw9KY4vpSpwJwZXJ9BxO3RyHqyzi
         08RZSxAQczuvb1FSvVMWfa02OQMoX287FotyDMp3clvxpPIjY6oRws5bXpGscVwsq3SM
         Wt3Q==
X-Gm-Message-State: AOJu0Yz4LYYu+gXSVQkZ4B9ribax9XLC+8bV6aid5soLDOTC6H8ZrGhf
	zapdN7AF4Gmj4pmtD2fgDPMV84dXvXxs/8sS+0jI6n1xiyUJUC+04+klGRZ/0AfUuIKAtj9Qvos
	GwErjBVsJMWDnmmvgy3KTw44TkyAoFks=
X-Gm-Gg: ASbGncvgqrun0WfzQlG6HJ/KgLk6tAQh6S+Qa5C8GFpGoe9TpAr5UF/oEPFekzoIWev
	ldHtE+2iuNXaR5aytzdbKip8AwH3YnG2peHoYvHQFfqldi+uQjyHUMV9llKMVBQVGH7K/G1+JUT
	E/Ntk2IB3u7dO+7UKPqybjqp2ki2gVlKg5Qw9XiFrccl1Taltwpz1bIY0YUsDOf/1t7x5suCZ2G
	0Yg1/FCHrOx3/ELoaFG4gVs5qzFCgpvpBj/6dU2+55wQHao3WGyOASvbZ3wt/FxTJpnnGYPn7mY
	CA6ZEZ/6DbJvQ5TqlQ==
X-Google-Smtp-Source: AGHT+IEXCxIX5QqEWGoiy5/PF709NAtwqem4s7iWflESBuFsW3Fz+Uw56nse2/NMToWTe2OlYWWxOvazLhwZp8NAP6I=
X-Received: by 2002:a05:6e02:178a:b0:42f:8b0f:bad2 with SMTP id
 e9e14a558f8ab-4320f6ca803mr19882585ab.10.1761593747402; Mon, 27 Oct 2025
 12:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB95QARfqSUNJCCgyPcTPu0-hk10e-sOVVMrnpKd6OdV_PHrGA@mail.gmail.com>
 <20251026211334.GA1659905@ax162>
In-Reply-To: <20251026211334.GA1659905@ax162>
From: Eugene Shalygin <eugene.shalygin@gmail.com>
Date: Mon, 27 Oct 2025 20:35:36 +0100
X-Gm-Features: AWmQ_blDqxQeU_Ky-v3nv9n-HPXGPvs6mQRSBYNlLKNci8X16CNqY4IhZSxzUBU
Message-ID: <CAB95QASG1pZJT7HyqxM90_FExhSVjoHmPqYHeQWXnrAzCNErmA@mail.gmail.com>
Subject: Re: Can't boot kernel 6.17.4+ via rEFInd
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Nathan,

On Sun, 26 Oct 2025 at 22:13, Nathan Chancellor <nathan@kernel.org> wrote:
> Does applying
>
>   https://lore.kernel.org/all/20251026202100.679989-1-dimitri.ledkov@surgut.co.uk/
>
> help with this issue? Also, does 6.18-rc2 (or -rc3 if it is out by the
> time you see this) have the same issue?

Thanks for looking into this!

Neither the patch nor 6.18-rc3 work. I'm going to try to revert
5b5cdb1fe434e8adc97d5037e6d05dd386c4c4c6 together with anything that
is needed to apply the reversing patch.

Cheers,
Eguene

