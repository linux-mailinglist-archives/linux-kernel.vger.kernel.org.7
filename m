Return-Path: <linux-kernel+bounces-870400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 446B7C0AA5C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3FED4E6F53
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB702264B0;
	Sun, 26 Oct 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQAeo93U"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B442417A2EC
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761489387; cv=none; b=Y97UwLcxL0UZUszTV5kn15RHmZMtOvQAJxGwTSU4nFkewL078qFnCJSFPQ7Hw1VGZ3+PbPKNdgAvp3nsrMiCXD5dkQVVTyDz67JeXcMs+UsB0UOrLu5iJDOg9oyrIlKRnUzbtwX7bBHRVdKO2eyk1QActzZihCSTaBpdXW5zguY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761489387; c=relaxed/simple;
	bh=bfoyaV7fTySChzd8P59MrJSB//MaEELP8QuOboq49AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUnJdiXpGpV2RUWYBcdFGhN8NdzI7xvBPsqiOF/N1lo4lQGjeN/Q0r6O6nfwhz9kApZbF0l09clzjsDoTv20kmXDMGQTqVYbIbgXRxGScKZ86pcseMZwxQpIE+TdjuyveM9sHTeITIgL9qGY9X2CEvTJtkULk6QyZQetgkTKJvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQAeo93U; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290bcb326deso7115705ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 07:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761489385; x=1762094185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfoyaV7fTySChzd8P59MrJSB//MaEELP8QuOboq49AI=;
        b=ZQAeo93Us11vtF87iN9bk9lQ/T9k15adBvNdbj3aB01YqVX/2pxeYugHa96FA/kpfn
         tODejB5gL5uirMo4uKRcgX+WyLB9d1F9Sc3cUXgJLxSMpEQ8yjYuGE5pcg9RGaFn26Qt
         xnQflWASDS/O56IKTpWX+NKg1AwBzyVIeJVbzvI+qnMXRSPW2vxrB9/+XwF4vWTatdP0
         icc3nSERjsjJ42X4omY557GpMb3y00r3o/gKujtKA+JlB8cVVu7PLSD6LeGZRCIS7/WH
         pnJ12X0p6k9aYhwHVL2DT2WH2iur3+b4YBsqgKrzvO3/KtPsRsPypkcDL7AN15/k554n
         wxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761489385; x=1762094185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfoyaV7fTySChzd8P59MrJSB//MaEELP8QuOboq49AI=;
        b=YCALjx9bHfZjOW2BKN7h1QHU4zHjgfnqKezPKqXZOV3oACZBF1hkFHr+zq+YieqmvY
         c3vI3gn564V4EthzgmJydqSGwiXbQVqZlqHV/Kpqp2QWyh9nF7N6lU0k9vkfMdlFoH/g
         PGg72O1+LvqwOv29VIrEjtHw11mcfmQyBV91YM+TyuZ6hTZ1SE9g1bU51ajsxcEBuMqq
         rRxVVm7KItLVVhnHNO2Hftp9gFkH3U2MB7jm+6hlJVeOTtR+OWsFoE/iyESWNcAHThtZ
         1raFZPMFt0lLvIU6fanoJHNm/zwjPGD3Q8s9MCR9JYunM3sNVkhi+6SaB811TFlgqzx6
         YxGA==
X-Forwarded-Encrypted: i=1; AJvYcCWqkGi/Fx/xzkK0dqMpFkoVnSkmZCwwLo3ug7XuIPP4gYJaolyA5XbVQCj281sm8UPIClvUl/BMJDUHv64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWIq5y3biGGnQ0w9R4C+g5Q77gKgN17b6dgn+LIPCFqs/qilup
	IMAPLN2cfs8mohX7qo76EA0BEshjj1woY2xXdcGhVsu6GzRbdf+ItBjdxC4fNI08+DaE3h9ub/3
	ot6vvuEqO6zSeGgvFMOzCNNb60IzvHng0u0s2z2M=
X-Gm-Gg: ASbGncsuaIhaIYZstMS1balnYUW9bCMsP/N/DtFJe3VqDJglS/GFrlJ0CL7DwtelHGh
	weohX9QoQgtEh+1+sf64peycabYse8pTsSzJP5et194kKEWzbQrvXTDOIwVFzQ4YIiC0+Y79Vaz
	3/9hql4M8EvngoSW10gqJHDNNFhR4GVjRjeNbxhRgJPlMX2tqBvYveOlK2siKTHCK/ViYy8sNeU
	cz9b8Wlixf7YoiGZeTffAJUBq9Kn5mUREXNIUyXetzyb8PyocJVsuaJ9xlPoAGSPi+23G3TQr7j
	Ug+4iKieX/J3lJRtM4HLsKl6prnZ6TXQrp7AeDP/RhN2BJ4rjH+1OYQGf69nB3LUamK0FU7T885
	WQOYGLd6gFtMjPA==
X-Google-Smtp-Source: AGHT+IFVxex/Hvf1Hd/vAwZCict2EGUF2vy+UiYI/sA1gePu0MO4UxHEviapG32w53ALhrtBy1cpvP25qhGoJgOjZGs=
X-Received: by 2002:a17:902:cec2:b0:261:500a:5742 with SMTP id
 d9443c01a7336-292d3fd9a38mr154422155ad.10.1761489384860; Sun, 26 Oct 2025
 07:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRnB2U1uvg1vyZe1kDi7L3P4kTFowfOo6Hfo9WJED4qve4ZZw@mail.gmail.com>
In-Reply-To: <CAFRnB2U1uvg1vyZe1kDi7L3P4kTFowfOo6Hfo9WJED4qve4ZZw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 26 Oct 2025 15:36:12 +0100
X-Gm-Features: AWmQ_bnxMU6b-D2cZjIfU_QUJYdxOKaC3c8ozScS8fUS1p7ym5Bwb9UakSfUcCA
Message-ID: <CANiq72=t=oLcpR6ML63Nofs-f5NFn9b38SDgKoKDwkGS-USK0w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove Alex Gaynor as Rust maintainer
To: Alex Gaynor <alex.gaynor@gmail.com>
Cc: rust-for-linux <rust-for-linux@vger.kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 3:30=E2=80=AFPM Alex Gaynor <alex.gaynor@gmail.com>=
 wrote:
>
> I've long since stopped having the time to contribute code or reviews, th=
is
> acknowledges that.
>
> Geoffrey Thomas and I created the "linux-kernel-module-rust" project at P=
yCon
> in 2018, as an experiment to see if we could make it possible to write ke=
rnel
> modules in Rust. The Rust for Linux effort has far exceeded anything we c=
ould
> have expected at the time.
>
> I want to thank all the Rust for Linux contributors, past and present, wh=
o have
> helped make this a reality -- and in particularly Miguel, who really
> transformed this project from an interesting demo to something that could
> really land in mainline.
>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>

Thanks Alex for the kind words, it has been a pleasure!

Cheers,
Miguel

