Return-Path: <linux-kernel+bounces-899666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87911C587E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 816954FFBED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F202C2F7443;
	Thu, 13 Nov 2025 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoGY2WRp"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64772F6571
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047942; cv=none; b=eVVaKyGbUNNVKkdp6YogO8yev0YK13EAtxNxe0qgE5Dgq6Cp/D3FrQH3qijXnk3+fmD/m6OoNV9k+LLgUQWGF5TQN/2PCabLqWaAug8dIY1XJmBvnz8cOyu+VzIV5PMKF/aSFZbqBpk34eO/c94Cf8kQsmG3Q3pCBNam3dM4oyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047942; c=relaxed/simple;
	bh=HK/XTH1vs5ogHtDfEDHsy2lCYQYNnOlTeFggXsOVopA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIk1viBtShs7pOQpOneoiGCGhWKXz0J4ZJMFV73PuhypMAn/MHZQ9Jfy+d0kmy1JID0PIwO0u21YVs/AFph/TnH4pNrWA76e26/lMfgAq4v7/TbXLBd4aAXqZ+SrzwonLuy+mFATP4MMra//iCLaj/eG1U4lx/4qF7fwOchWZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoGY2WRp; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-89018e9f902so526798241.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763047940; x=1763652740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HK/XTH1vs5ogHtDfEDHsy2lCYQYNnOlTeFggXsOVopA=;
        b=VoGY2WRp5yRxVTVQ32riyXohtSVfxELDM6I+HgSmAshWIggHOjoVQgFogt1jNiU6W+
         yXjIB0XGBlWXqWLQraK7842v/4Nolpx9bMqH+SEb2xObtfG8lOvoilvotJ2b9Jabnp5D
         g/uTmF5UuqlZj8lWdhah+1HBYoxqU4dnS3vkvOOxyfqRIjHvW2ynIZc5CjQnHJdXkOds
         o1MbKETrnKKNgYwik+Az9nfB0DdG2+ysCBJ2uW6wz6EgOgsFPlQiOd6gFbtArQQ9YriH
         UbUX2tk9WKAG09P3q4G7yOpG9Bv3cUDSwLxDg+w4oyWhFeQaA8mwfR2urejJy+0FWETY
         qeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763047940; x=1763652740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HK/XTH1vs5ogHtDfEDHsy2lCYQYNnOlTeFggXsOVopA=;
        b=Tz0ZgWzaQzUJ4cJRTIj/g/ZW8bFOGJ6/qKmeD8Q6YO9wGCyO5prsl9Jg03s1xJzT6Y
         cNXeT+t+iGfsa3WbpNYERBytCO8U3mvkVblHHB306EhePb9eXxoTVX6J3BYEfySx62kI
         lNBkLzy68aXfD5IhmfudtAyHgZOj3XaP/V2bG4se0V5pzLh/dPjNURv9opIv1Pun+XJQ
         Hkx6PLADk3rsoHRZbbkob3G8f4U/dIk5q1wh92Q+PjOwrNCe8NOckMEqLd47Jlf5LjRn
         6xzcZ31nIIKb0lLOJuWp8HQET92nHQZ14HXwuL7m2JvSiXPlaAW5vPji/ovvjHUkGwgE
         CbRA==
X-Forwarded-Encrypted: i=1; AJvYcCUQrwRvb8Tb3DWr3Q4XN6ZXPDZnIbJFKSUa3tWkcEoEz3sAhe0Nxe/XGIkjK6wEEF54Xq59rJh7vCxxJIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAGD7LpWmFTBsgK/BLf1jnchcNdPGYVHTzPnH7m3O2tJtSOPDv
	tNt0H0zyV2v8SYL7xCgMPapGak49/Z8E+cvrjx8C7DfsK9pYN/DdKuztj39MfkSXsGNTAVeP02l
	iFNJswWT+H3rY3lhLoFoWhYP+ZFujt4Y=
X-Gm-Gg: ASbGncupIsgEPWKcViXu1m4XeLXxTREVwmYMXQFTq3l6qiPYUAZDyqVMwURVcORtsJk
	1cKJwvGR4EFCap2EB+tK9dhXD3fkAFhcLp8Ms3qt7Uiq7RjlUITibGUhZvmgooli4rUvQCZj6+H
	nSDok+U6nSb7RbEnTcYKxVi+RKn8fV/vUSg4/+8jv+c7t0xjmvpE2nYLYitI+vWeKFeCrEEikux
	NmSPcbKx/spz76qyzKxVa1VikEa2St0B4BIc+DIlVgHTeCpXZVdBFPaAO8elh8=
X-Google-Smtp-Source: AGHT+IHjkzaJR98ABGf7JPdxTaIgrD7ydPjrcLBtkfxsqqWMEkSquvfD6fsm6+pA4EMyJmcW5nPIV7Bo8G1boiTHdOs=
X-Received: by 2002:a05:6102:cc8:b0:5db:ce49:5c71 with SMTP id
 ada2fe7eead31-5dfc55b0bbfmr17704137.18.1763047939722; Thu, 13 Nov 2025
 07:32:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113092606.91406-1-scott_mitchell@apple.com> <aRXM079gVzkawQ-y@strlen.de>
In-Reply-To: <aRXM079gVzkawQ-y@strlen.de>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Thu, 13 Nov 2025 07:32:08 -0800
X-Gm-Features: AWmQ_bk4Cs4HA_t-WxTixgm-463gTBOmlX39m7CT2eAG1Up1wBQtX5vxCBOeAL0
Message-ID: <CAFn2buDiAqpdzo=50=QA6zS1TZyFVNHqKdqvoixCuWcGLF=uAw@mail.gmail.com>
Subject: Re: [PATCH v2] netfilter: nfnetlink_queue: optimize verdict lookup
 with hash table
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, kadlec@netfilter.org, phil@nwl.cc, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Scott Mitchell <scott_mitchell@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 4:19=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Scott Mitchell <scott.k.mitch1@gmail.com> wrote:
> > Signed-off-by: Scott Mitchell <scott_mitchell@apple.com>
>
> Didn't notice this before, these two should match:
>
> scripts/checkpatch.pl netfilter-nfnetlink_queue-optimize-verdict-lookup-w=
i.patch
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Scott Mitche=
ll <scott.k.mitch1@gmail.com>' !=3D 'Signed-off-by: Scott Mitchell <scott_m=
itchell@apple.com>'

Good catch, will fix in v3 (coming shortly).

