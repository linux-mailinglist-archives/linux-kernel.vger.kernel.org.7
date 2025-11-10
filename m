Return-Path: <linux-kernel+bounces-893970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB294C48F90
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FCC3BA67E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9521532AABD;
	Mon, 10 Nov 2025 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgpY6diF"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E5223DC0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802075; cv=none; b=ado+RySiPO+8Hs7uhjNkh8HKSDb05fH0fPe1uL2JvrzooiObsw6Jh5paJBOsrRLxMVbDsYUpLKrDDHiKe8wYiX3IaACP4os2R9Atu+Bzx7L7WTRfZ3p95nkG6nKWb7WXJ7f1AdGrFcQ7dryuWpaW19iXNs8CB7rdQOr5klt4k7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802075; c=relaxed/simple;
	bh=YwHDw+RWhOlZP/amR1OZvDu5iuKr2nALD25XBBx4YF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrHylGMPyreOwkcz4vycHzigCBiBN16lyNAzFlhWaMeGBo2KLu9EP4If52tE8F+6CT2EJxkYizqG5eirGp+mziXoFMzjrzSm+stx9rdNT3FPsAqwzEOodBBpXmzdssFCH+vuxUGa1/sC0kjZFow6iepzEh6fQQTUgP89vLMZj40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgpY6diF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2952d120da1so2791715ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762802073; x=1763406873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwHDw+RWhOlZP/amR1OZvDu5iuKr2nALD25XBBx4YF0=;
        b=JgpY6diF6Qckrv5GV2jhgzwuXQZf8tFMNqIt0NSiQw8CAkFFOcDLvzME8X/X1I/H7a
         FGdD1a7GCtU2hrT3lJYXyfYF6E0YLzjJg8Y66EoRRlOWXr7+oaD82mYRTkgQ0FUre1g1
         +n0fsYdYXY1z7B++tGjEr7ap3aLZE8tcBlIf+6tyhjRrZtMfEVVe+pSDnkLcWIa7wYLH
         lxWWcxVDkp4bJ6/MXvhCbJxeOti+LOoRe2lwjrFok0eLsRaknjr6Ds/u2yzMKb97zDsZ
         maGmKi4t2QUOzIGt9xOSKkDAhacKwcj0ze7rlKIfJb1gWBCelyBx4XcG0yjpTLTqCnd5
         UKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762802073; x=1763406873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YwHDw+RWhOlZP/amR1OZvDu5iuKr2nALD25XBBx4YF0=;
        b=eIlIY1kESShQN6mqNYZtwvzuxciRYsbP5Q67Z8eYYxk0jntPAMhPKv/wcWDKGuDM3j
         43KIga9CSF1JIXmFTBK6Z56OHgFBzmhk7s8xqkT4Ih58yWxICrKCwud7dd768PKq304C
         3k7YdNesPZO2E9axii0T4ZLZpy58S+1R099Q50TGaNkbji9sixIUBFVVkg89NsQkIrPa
         dk17bl/wFL61IGXtUm7778m0OKfGQC7CYyJ5fqvB61D+TE1HBu1tyY5rtYOIZgL2n6SR
         8ck02kXGdbS4rVPoSZukvFG/bewxilXVpsFOMFszd0wbjAq0H4xwTX5NZawPH1aDgC0+
         Knhg==
X-Forwarded-Encrypted: i=1; AJvYcCWCzHaVW7BmyntrWjkRkoVcxTmmj0SCuIe7/3Gi3cjHG2sPY8TsSimIcXTmxxaUbHEgNRvvp5+B3EgIvP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8K3bdQC5NHuLLEYmI1zV/Ab2q6/e6m5/o8xJMNQ7NF4r8IoIO
	ZF5za8z4KjFqEFjOzBtX01HIns7bx5Q+rqQFXq/aHvjTSc0o2sAe8Iu8s46FrWxuw7OKekqUNlF
	rvdel29hosJddF/0GQpEURD1sb3VjNEg=
X-Gm-Gg: ASbGncv+kWDvK33dTGUyZTLz9UYfghVmQso9W/R6fQ0OA61R4RFVjQp2dc4ZMl/mLMG
	D9ebcoPp1wipJzHUnwXcdfW/piHp0CxxFUz7vcWx+lu1OdGB0lxp6daMpg1QAtE/Oq/mR5pnLGg
	NI1HPPJLPtS78Id2uE9DnPa6sKtlz4qgGJG0lPP2H3/ojSSg8YDeR/J4LhHLftOquMNtwtkY/Ze
	isimIGYfo8xMQto/NXFOgruOFB4XdWz0iU8FvWyp9ZYUXUBfcA3bTGVuW2+iMrg+CFO+/o=
X-Google-Smtp-Source: AGHT+IGmoL24a5e2UsUDRuk9UBkWxVYKGDAVprVsr0fIJMe2VdBvfjSPwHiQpCu+jnl/LPBTuLwZI1mDrMEaljJsm48=
X-Received: by 2002:a17:903:1cc:b0:297:fe30:3b94 with SMTP id
 d9443c01a7336-2984107933cmr1991405ad.9.1762802072864; Mon, 10 Nov 2025
 11:14:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325210517.2097188-1-bradynorander@gmail.com>
 <CADnq5_MNBUY=jWbnq-gZQ_4_M_sBJGAgMD0bj2cMdnkoU9G=HA@mail.gmail.com> <9ab05b38-6f77-4b0b-8a1b-8314e2873047@gmail.com>
In-Reply-To: <9ab05b38-6f77-4b0b-8a1b-8314e2873047@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Nov 2025 14:14:20 -0500
X-Gm-Features: AWmQ_bniXwWbFIcQl7Z57OsTSHw-cwzsFFjBwmNKVxkysJ2r-AhfWVyV_dkSDOw
Message-ID: <CADnq5_No+w+tco9j35GBM3+CYBTo018eLwWec278d3VBJHPQxw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: use static ids for ACP platform devs
To: Brady Norander <bradynorander@gmail.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, alexander.deucher@amd.com, 
	christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
	sunil.khatri@amd.com, boyuan.zhang@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 7:11=E2=80=AFPM Brady Norander <bradynorander@gmail=
.com> wrote:
>
> On 3/25/25 6:12 PM, Alex Deucher wrote:
> >
> > While you are at it, can you take a look at
> > drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c and
> > drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c as well?
> >
> > Alex
>
> I think it makes more sense to handle that in a separate patch as it is
> an unrelated ip block.

Sure. Can you send a patch to fix those up as well if needed?

Alex

