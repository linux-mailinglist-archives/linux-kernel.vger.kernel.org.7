Return-Path: <linux-kernel+bounces-727973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61895B021F5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB02A659B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2976F2EF9B1;
	Fri, 11 Jul 2025 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e04bJeVL"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F32EF66E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251936; cv=none; b=HRZO8YX/T8+FQ+08QqC8n3yFAEs4slyPSj92dKjTczCWcfH7CFIkybNjqjVibgSGkfyKIOS96VwRS6Z17sVuFnj18DitPYgZ+rwQH3GJXL9HjkfAl4K4q1ie1nqjklo5zR3EUX6Zxf5wJxbxkR2NoyRUGrx94K7YBub2NvpJ/n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251936; c=relaxed/simple;
	bh=GUHNdNzh4MVenPnIJ3b3PJlz94KSj55El0YY2Y5dRbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDuRbKmBdEI5ZxPHV+evJ39aUnkDpDsQ1ev7DNDTGt8OHXN9tV1TrGObfjaieT4RZSJ22pXs47cV4MeG3g2VzwFTC5tfyBT6PFI5cOO+8LPE+zN1T/aBIX6wbbZ4nP22oIiudVtnMbX0iovodIYQ74E23Fc7WMUueELJaQ7g3Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e04bJeVL; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-611d32903d5so259a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752251933; x=1752856733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUHNdNzh4MVenPnIJ3b3PJlz94KSj55El0YY2Y5dRbo=;
        b=e04bJeVLhcRswe4mTIUzewlyQiA64c3rHvgp7J4vnEC8jv6gMUPdTIaaeqljIRXeMq
         ttWFcFx0W7Me790mThOJdd5YNZCUYPPHGZjb/H0i7nUf8uf1xunGps8iWlCTbx5mtOmt
         3FzXhKD3AOlvw51G30chEbIKtssSNuj12q4fECjRzDsa4XLq3X+H0z8wiBaOhVjyfDnY
         Ghk9LVCnMgYMcvnPREauQcmj5wHeVOwnGqpDkKoXH3dHw/wC4RZ++kixW4H6hB1iQ5it
         gdTpdLD/ozQFUkIiBKOEAQaU1AXDWkdAsWuZglaXz2IsygngyJHUh7QdZtGWVUo+v2jv
         GsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752251933; x=1752856733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUHNdNzh4MVenPnIJ3b3PJlz94KSj55El0YY2Y5dRbo=;
        b=ZeKO+I5BiLezt1qLOvsR63LRL3miTAmRQGb84V2yUotcArYWyNPQPkcjXjMxZ9ggg8
         ORMHtWCxdz4stZEdZJYxIcGfwYMzGfiwpAFhf8ujAkY+Xf+WdPbV2TXoFkwlUOkidX/l
         qf9dVmMlg42d1ytYVuKIlh3ZlN1Zxnd7UT2l6wHq2evnm98p/VH7mqvfR7LWmkL8IeHk
         ssE0E8K2B8xGeZ9cIkqUZ7SG13Orzc5u0r3Kr0jBSKVnSmHCaWgZgE4mS1e0RNkhcLv1
         skRy+gSABprQFICs6Dxvsaq3pPZrjGOBWXur8SYkDr6oLu5aITcuXOI5En0oHBpQBfAo
         7tyg==
X-Forwarded-Encrypted: i=1; AJvYcCXunR8frtoEoina1VxTDdUQ+qx8FhSi8yi3+0ZLjVBEKZfG7JlH/uHj5VVJ+t4L740iEhYLQzn26937lgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8YubFk8ENPh9zu6TbiiHLKnSeDMB1FhEVPx+wlzUcGjrDO4TT
	1VDSo2H8cNpaXdDdqdFYScaC7qxW9k2qYWNFL1SsLIdxORGHZcBwLTkwM3ypnA3VDn5k0YtIVLz
	VjfiGIbNQ6XfAU7TMFjEGYPxnyv2ikULmLSqoJfeT
X-Gm-Gg: ASbGncvVunxNIVFQoKa/fxMC/v5z+1aCgsa6P/TMrMFT5lbSF5A/Z9uT1Mb6FQfYaW4
	6FvZO7qtV2X6qZDoNrN6Vz/TGFLPUdkq4lip0KW7MPkOcL3LIQIKKo3BXFdXFkTVunOuQ3E5HAE
	xOxdU6UKYekvwpN6zAMbj1mXJDn32EsTxEntqnFUXT8X0MUi8nE1GlNYd58SGDgG+3TxGx8o0eE
	frJ3BdbesP7uUI96flGerwRD5Xj+0xuNw==
X-Google-Smtp-Source: AGHT+IFMqWeUnIhM2GUfvqZasar43+JRQEzyaYqWWnI+VEdWQL/yjU8uiXyK3Tt6lYFu66zeKZ//khzG9Fk7nhUZTPA=
X-Received: by 2002:a05:6402:5519:b0:606:f77b:7943 with SMTP id
 4fb4d7f45d1cf-611e66b19acmr119955a12.0.1752251932816; Fri, 11 Jul 2025
 09:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711-epoll-recursion-fix-v1-1-fb2457c33292@google.com>
In-Reply-To: <20250711-epoll-recursion-fix-v1-1-fb2457c33292@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 11 Jul 2025 18:38:16 +0200
X-Gm-Features: Ac12FXxBR0x-gWBXPHgR-w1y-RdUePMpUnV9bTKOU1Vmk9DbTBaD1sVhfK-yPDI
Message-ID: <CAG48ez0fWFjw8-RCLfKGXR4aNaRfZ37-GdDH=Rw2TFupAhocVg@mail.gmail.com>
Subject: Re: [PATCH] eventpoll: Fix semi-unbounded recursion
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 6:33=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> A more thorough check is done in reverse_path_check() after the new graph
> edge has already been created; this checks, among other things, that no
> paths going upwards from any non-epoll file with a length of more than 5
> edges exist. However, this check does not apply to non-epoll files.

... of course directly after sending this I notice that I put one too
many negations in this sentence.

s/does not apply to non-epoll files/does not apply to epoll files/

