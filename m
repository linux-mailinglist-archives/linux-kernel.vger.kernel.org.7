Return-Path: <linux-kernel+bounces-831095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F57B9B87D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98B74C7389
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4523064A0;
	Wed, 24 Sep 2025 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwZRiJts"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAABC11185
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739198; cv=none; b=GtPdWMnCBPW1rjrkcr6TuH6SH7Rgbf8+PUcrkKce58OC2pnrbkNxrtCPyef828H8/jIvHIMVgPts/bFfEEvhwU0mgnW1tIxSkV/VfxS+Ri1aTaAEXOfYCVAWcpzRPXMLfMWJRiRnENBpqIrQCf9GVUGgBr9ofu3OSr8M5XtMWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739198; c=relaxed/simple;
	bh=ST5MIPZNh+rk0Xdo2MPGLb53Npr23yQ+YE/sn+TsaZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+K/SUiISqcxPMTd87gMxmgXnewX6bLxuk6uTaMesi2dmM5y+o5EApwj0NdQqOVNgQIf68vn/J53fioPS4vwcVlXGLrL5kRQ424XlgnUcMNBSU8GaKPIwyMqEqDSQbVxQMKL7mF5Ydmeo4gIAkdycPKEgn2/R5rAu+pAiWjoXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwZRiJts; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-8fea25727a9so19157241.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758739195; x=1759343995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST5MIPZNh+rk0Xdo2MPGLb53Npr23yQ+YE/sn+TsaZQ=;
        b=hwZRiJtsi+oD3Zg9HmVTsFOgshlgZK5eObdHS+VShNItAGcJrORpIImepcXke2K5MF
         r6hP/lReZoK+QpeSrOqMvmmvAcMZK62OCMBrBUQnRUadsY54bfYS1FYU9ucXsn89YDae
         HLUVQDbBLXMrCqOUICS+HIfbiV4w+HVw+ed3tWfW3iBXLNts2CrLSXoGTyhrG2ZSthoD
         qlh60FH3UkJKIUycHjlDbEcdYkp5jOm7M9tojlKWjDWitqbWfKPZD5dPsW9LJqjtsQkv
         1ihRO1CtIX7DzHTHK3yZFFy9wHxY0B9v9V6WWC1b2TS1ysRVNNyK7Tf9cR2LjVRBPSMJ
         I+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739195; x=1759343995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST5MIPZNh+rk0Xdo2MPGLb53Npr23yQ+YE/sn+TsaZQ=;
        b=skrTOSa5GkreDcsAxRpCp5+uBFOXCqbkOCfA/BMtuUXi90u33LcyTjuhqS/bTzq5My
         kKjcZEWpXE50vs71eSVIfMSCjWZhq/wxURGhPflJtUf1Si7PFlqvmVNWKZAAx3yHPbw3
         4Aaz6DIrzurmGyfp+g+xAIR9hlxq65RRRiXWDMEDDMSDZwxAooFoM2OrBlmQSPA7R5y+
         c3Huc6cLlt+orkELsyV4DYbjQs9ovZPQ8RyNaHybscVGadDzq5rlVsP51y3Td3LDI0/Q
         Tfe3Ta22pQAnJqwfObn/Z9KQuinQI40jgZxYaaljpBtDf5BsCIPmA/3jcrbzwHkxcDD5
         aC6A==
X-Gm-Message-State: AOJu0YxtxvzEPrPVxeJjYcBAwYcWZ9ShxNv159xr88Yl9BroHfwh2HK6
	EW8sSz7+W/4Y4RxJxdvRSiqmxJhcU0zSycEZIUIiyttC+SlrWnjgNaRXsANFfcHSmJtNzIuQOlo
	Hla2UpF1BIRQ3sNlXlAlmWDfScOFtRKA=
X-Gm-Gg: ASbGnctCxoa7m/sHBIpELfo0iO6H4Q37FA5/O7GG5OI+AbFLF96IYV7pvpYnYXgrwxf
	Q+wCHPZOFrg5X/xbENMspVuFS+fIulFI+wME+Rqfgxhj5tQnRyhC5L1z0m9x2eEOS3+dFaEpelH
	W3Wl7vFN/kvLY8BMrUeDvHvhgx6T3vK8gRz3JoaLy1d3+gKsbIZoMmqyhhA2toR6xFpuhvQEM5H
	zH9nMkXW7fxuvRpA5mkvyR7cqvLCak/Hj9dtIVc58y6uYmOww==
X-Google-Smtp-Source: AGHT+IFKQvu7KK7l/LdyC6yvPgiOYdOAsqsd81zbe9e62XVFhzH2deCxnYNW5eJ9DEvQFVudwuvTGiufcXziCwsP/r0=
X-Received: by 2002:a05:6102:161e:b0:533:ff66:698c with SMTP id
 ada2fe7eead31-5acc4a1ef0fmr489265137.2.1758739195537; Wed, 24 Sep 2025
 11:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com> <78127855-104f-46e2-e5d2-52c622243b08@gentwo.org>
In-Reply-To: <78127855-104f-46e2-e5d2-52c622243b08@gentwo.org>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 24 Sep 2025 11:39:44 -0700
X-Gm-Features: AS18NWCWklyrjJnbHl1kScwWNFAGeo0abQkt5rG3TPvdr87PEwYrqpVB-8wXyvA
Message-ID: <CAM_iQpU2QucTR7+6TwE9yKb+QZg5u_=r9O_tMfsn7Ss7kJbd9A@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
	Cong Wang <cwang@multikernel.io>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 10:51=E2=80=AFAM Christoph Lameter (Ampere)
<cl@gentwo.org> wrote:
> AFAICT various contemporary Android deployments do the multiple kernel
> approach in one way or another already for security purposes and for
> specialized controllers. However, the multi kernel approaches are often
> depending on specialized and dedicated hardware. It may be difficult to
> support with a generic approach developed here.

You are right, the multikernel concept is indeed pretty old, the BarrelFish
OS was invented in around 2009. Jailhouse was released 12 years ago.
There are tons of papers in this area too.

Dual-kernel systems, whether using virtualization or firmware, are indeed
common at least for automotives today. This is a solid justification of its
usefulness and real-world practice.

As you stated, it should not depend on any firmware or specialized
hardware, hence I am making this effort here. Let's join the effort, instea=
d
of inventing things in isolation. This is why I not only open the source co=
de
but also open the roadmap and invite the whole communication for
collaboration.

Regards,
Cong Wang

