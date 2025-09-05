Return-Path: <linux-kernel+bounces-803392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D23B45E91
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC12A62A2A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993AC30B523;
	Fri,  5 Sep 2025 16:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fLpfcSqw"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D6930B51A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090750; cv=none; b=gSFgYiRH3MJGb4H5cce2M0VYvVLjMY+E5neVu2dd/jtLLvreGMB6rehrB2oy9sAzZb2wbdvOM3J9ExRcYlIhVsHLOxs+Jne9YemRQzghqUYFN8eZcYPP3FRIvvoRs5BjLW3TsXLOoioVaW2jWFOt8E46lEVeg6QhixEP9psRJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090750; c=relaxed/simple;
	bh=2xMvOIo8IzMQk9643j9yAhJnzNrpONCHS9WH85nzQBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IG5EHs/4ThgOXFT/U+CNp/JcfwwktDqvighzcdlXNL0y7yZVlv3LIQuW8kj+gLJQ8DP0MFVA8HgecLlO/fRxRA8O+mXFmTJdt0Lnt8DZSe84T3MZfA/Nen/jBRotDyk/0nlHIuTYd+OxmBzXuuzDe8uyT232DTtbjLY+HQtqMqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fLpfcSqw; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-327ceef65afso2510011a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757090748; x=1757695548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xMvOIo8IzMQk9643j9yAhJnzNrpONCHS9WH85nzQBQ=;
        b=fLpfcSqweYhlvGsJBaBERif/W2unQOUi/CBPBVtzv48hzCxJ2bgNiZFWBuPY7z6uIw
         asrjE06QoUl7R1FxJwRkO9IqHFi5HUHx8n97topdIZ+Pn8eF2nvuDq0yhZXPXxVzoBp6
         eibzv5ih27/1TXfAO5A77vR2rIScpz9q/TAMb0advI6vDAyZezIjzda9J0z0FJCTPCQd
         jIzy9YJn71PrWaf4hoghehXo4+FAGqHyEOs7nXgpUauZBLMZTlnbbMUtubv/LuUqVWaW
         bd05+8C2hBynkmnAHAywzUsbwT1V79pTYQs7GiS0oSkY0Dl5mn6FCRDeNBLdBJu5Syzj
         raxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090748; x=1757695548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xMvOIo8IzMQk9643j9yAhJnzNrpONCHS9WH85nzQBQ=;
        b=aDRIq8SyCH8OJLf664ErQ/GJe340sXaJoMtxHo7JKoO8y6VOn4jxswHrqtUYUbR68A
         e5c0fO6F/6KkqMHNR7BwKTGVDK1PxyuKrtPdnrxpDaGhqSauP5iyQ5yc4gr7B/2Owfpk
         M8f0yE9fNNN5u7fg6p8MpT7Vm16QTuS3HRKlr6ttYIJLyYbnZUwF3APh5lJ66QWzQByK
         aKl6+XSrQoFiJdLNPMy5Rkg78nMmV9XE45bJGWjPKzW5IPWqVLMPXgayKPumLsOzP7Ki
         /2pOoM9w4pt8ipDxhtexFTzN1XW4HscweVYuvan/FV2PpToooiOi2ezP1dVbXB5ruKLD
         FDxw==
X-Forwarded-Encrypted: i=1; AJvYcCWJCrDh73ek2SgTd6WmCUjvKigvK/q2Otd3n1PnWMLkh1CjHwTvYqW/LJz14CxwplVqt7JTmGfSDo0zpis=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ9wu5ZMLgcTsjnaN69BiUvHzFcol6u2dqka30/E1cOwhkfOTJ
	V216LSEgi2rH9vlJ3EXPacqeRRB5mtrxT3x0CDqegIpoMWBueGCxs2EQGeQ8unQszdb0QabX44a
	7hjyW2F9YPOasQhmLnX+ASXF3ujbDZR2M492GKxr5
X-Gm-Gg: ASbGnct7WvEgbfdmMiqXlib2Ko2fpKG4B75wNmUOirun2BhoEyFxSlefuXjnbCpnBsR
	b/qz3kSUtVEGML6iX796jPEbFPWH8hZfVmmPOxybPgX8WxI1+I+XBzURhzykLMjfRhyU8ATPfuP
	A6sHq+jp9IaSZ77qqAkI83ckDgiWKxQ6j+a4SesOcd8oximc6oRpg0OTjLdeURPziyOyLemzAkT
	tk8pMwrFmur79L2zA==
X-Google-Smtp-Source: AGHT+IGWJh7u5PAd44ZJLulFMJ+7r7YGlUtbhoA5hYCPYuJqnmlWBAoXkvcO4V5svJI/aCAPBlexkQfLw/LGFbCdMuY=
X-Received: by 2002:a17:90b:57ce:b0:329:87b8:9fc6 with SMTP id
 98e67ed59e1d1-32987b8a698mr28292575a91.16.1757090747582; Fri, 05 Sep 2025
 09:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905100454.685866-1-zhanghongru@xiaomi.com>
In-Reply-To: <20250905100454.685866-1-zhanghongru@xiaomi.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 5 Sep 2025 12:45:35 -0400
X-Gm-Features: Ac12FXzPdJ_HTnyZNod5pdaRfBqEI-sY3U7IFCG5_usISf4LjaTZUtqU1Skuq_M
Message-ID: <CAHC9VhSW69hmvduJK1cKt_XffiDwEeHUKAtJ3YLbohKWff0+bQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: Make avc cache slot size configurable during boot
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	Hongru Zhang <zhanghongru@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 6:05=E2=80=AFAM Hongru Zhang <zhanghongru06@gmail.co=
m> wrote:
>
> From: Hongru Zhang <zhanghongru@xiaomi.com>
>
> On mobile device high-load situations ...

What are you using for a SELinux policy?

--=20
paul-moore.com

