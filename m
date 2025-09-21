Return-Path: <linux-kernel+bounces-826469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F26B8E9B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12A33B6C7D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E75C242D86;
	Sun, 21 Sep 2025 23:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOCKUZAo"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF7019A288
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758498642; cv=none; b=TUODMlUZBD3cCXKqUoOjZki0ri4UXxbcc4v+M5Hit5wnqj6q6nJj4GHa/vnT7m2PjLGLZfqPjZuCWC4vdE/1JvWz6+gIOAvaWnyav3OrNkEK5cUHXT/pYIQ5AhVbLWxU/2VNymm48mDLO2YRiNZY2z4ZPj02fBX7tnt6gt5+hjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758498642; c=relaxed/simple;
	bh=mvjdVpgbdeN/irx+t68VaFzCQXCqvCzbBN1QnKykMgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2N84EPlljwaflKl71YMa3kpocz8tF+vLX5jxP6ZTn9EYeowl4KTprGomI2zEDdqIRxFKPjdRrOAm2qeGlJWTKrG7H+trafa9VoMPcwAFSEuzc+WhFh0mgGvPP3VYmjUKMpiwgdQ3NiUUPfVLUli1xD3cTudrdV9Yf+A6PYcO78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOCKUZAo; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-580144a31b0so1739168137.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 16:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758498639; x=1759103439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvjdVpgbdeN/irx+t68VaFzCQXCqvCzbBN1QnKykMgk=;
        b=FOCKUZAogRvkFc0zp266Bb8CMflpzU3FVOJZ9rNYk+PfIN0aAttYXeLMLW/Pqaxavv
         RLgIK0XsaaCEvU2BPJL04bM78oFn4P6Q2QgRFvZXMuRNQatD07WqpjNRvlHbIniWZjcH
         GceLphGpOf8QRrkIpYCwUXS+3UQSyOuAuEMIdOwQSGoGqqk0hVeCBd5qlct9/xPg5S6j
         128c7B1reyc44Yp2cvwdWFn+JWBFv4PG3O56hLbKNaexFaDPRR1XjGf2POIUdzKpFVLU
         r1HLWQvgcPnRUtbpVWwGHRhZwjYSk7gxGnEwMzUWnkb6JFphKRLwirPjLmRHjX/jG2Ap
         aGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758498639; x=1759103439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvjdVpgbdeN/irx+t68VaFzCQXCqvCzbBN1QnKykMgk=;
        b=OkWv8IceawuhqnUbIVzc2+t3z+I385o3XCfGR3nUdufZh4P2axSLFt65wZguKAEDVA
         ovMoArZToG/tixxWZMl9mYhr1KK2sHk1gk7XKjDespKaj3+J9yYp/pWhWoxCoOJpDks0
         0aizR5bSzryaVDTtYwUOXu4IYBrTfOS9syKpvFOQZBeI+GmV9056Gnfio353LWWmIl6i
         F9g0CdZqzz673xIGwCOKo1P+7BCKMZk4PTmFmx1rPhLpikCagVQZW5QO/LlSC6xCNFo6
         +XvEOVDPiWUwFMtH75iTjugLpjA9HegoAJXZEnDOJBk5U+2oFch2vL9jyH1EPKeBb11E
         wYxw==
X-Forwarded-Encrypted: i=1; AJvYcCVzaL6pSRk1g117gu9uEDL9WIkGUdRH9+0rgMq+nIoUz1BtCivZ9GTpdZ5xnob/Tk6G0uZoGxKPCove5UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT5xac5eK80+aTAn12EN9oSbRmuSvfW41vTS6BJyU4pXXogj3u
	PjhYbEwYUtx1jf9Cqs28ed+3eL9MSsXdqUFxi1mGIkMzAL0RLU9gcXVQBI2ascILJW6yVdlgEbp
	sEFubduU02I+d+yYWfZqc+U5hiG5n/ZE=
X-Gm-Gg: ASbGncvQgOow/a3KH6r9M6m2wpiPI+O6+tyD/ebfhgy2CQPeDElmSdkpKYTJhvlGpa4
	XsPwxFyYQeE6TT/nTN//MZDpFX0gAlwt6qTsLXWdO9GmSIQ4oa+K1QE/K0E/bctwRpAZQuvsCm2
	0xVAF+n7i3f5YgxD38Ok2Sw+R3lYHYuCr1OIqomeArvuRoETUF4Ny1EJY/np8CcePqlDi9txmHl
	uL1rTDq2lqH+4YgeiUPYZtIvDoNuzVzKezr2jMd62B9apLmJxl6
X-Google-Smtp-Source: AGHT+IFcQgE9aofpHOuZly7koqtkrp5BwwJpTS+yAssVgzUlW6YQl2qRreA5cApeuJBxN8Btzi0VQKkzv5WobnqMmLQ=
X-Received: by 2002:a05:6102:148e:b0:522:255d:4d2e with SMTP id
 ada2fe7eead31-588daabec7fmr3849846137.7.1758498639611; Sun, 21 Sep 2025
 16:50:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250917011807eucas1p2dc0c24ef4ad8effcc1a2174d54cf4161@eucas1p2.samsung.com>
 <20250917011759.2228019-1-xiaqinxin@huawei.com> <11183850-d6d6-46c9-8079-330bf4c541e3@samsung.com>
In-Reply-To: <11183850-d6d6-46c9-8079-330bf4c541e3@samsung.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 22 Sep 2025 07:50:26 +0800
X-Gm-Features: AS18NWCISuJoSiHmw7_UD0kiJ-dJial5sFpMcZNuSdJVIVnVkgHLbQ-bRQt1JrI
Message-ID: <CAGsJ_4yno_a2vD9OHhruXbNOXuVKg97NcOdFHpe283FJ9hXL7Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add myself and Barry to dma_map_benchmark maintainers
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Qinxin Xia <xiaqinxin@huawei.com>, robin.murphy@arm.com, jonathan.cameron@huawei.com, 
	prime.zeng@huawei.com, fanghao11@huawei.com, linux-kernel@vger.kernel.org, 
	linuxarm@huawei.com, yangyicong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:17=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 17.09.2025 03:17, Qinxin Xia wrote:
> > Since Chenxiang has left HiSilicon, Barry and I will jointly
> > maintain this module.
> >
> > Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks!
Marek, would you rather merge this into the dma-mapping tree
instead of ACKing it, or would you prefer it to go through
a different tree?

Best regards
Barry

