Return-Path: <linux-kernel+bounces-725477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B07AFFFA0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EF53B5F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5272DCF5B;
	Thu, 10 Jul 2025 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmYU3JJQ"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D3ED27E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144553; cv=none; b=aKOq13qlRDnftzT8cZqFhGWXougdoHVIZDV9IYxNZU2I6sNwFDWzuwLPc0v8Ur2fSR5cZZ8V4vWPz69nBRF8hku65glL7OYUXgao965K5vyv8nZTu/aEslzuKylFNcaE6WVeZ1OAsWT4LUVGWCZBz1vlPxonA9L+7MmSnTnMhSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144553; c=relaxed/simple;
	bh=0ERYadl4idWZ6bP47UPPD8JzYK00w75uLtXXgxW78Zw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dTU3DoSZIWyNkFDd2/p6np38/iTfBFiwCdra2L/ukCsK9ixFYWEEih0L8W0gDS45naMUQ+0SlAc5+kl+3uz26u4r4at5Lbpg0MTzscUji7WKSaHUvHSyTsdWL0Dnwez8/dFMXGdxSWHqWFGvuLRt5RBLwrRcviSG/S62GXOFpOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmYU3JJQ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a5903bceffso10440341cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752144550; x=1752749350; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0ERYadl4idWZ6bP47UPPD8JzYK00w75uLtXXgxW78Zw=;
        b=OmYU3JJQnnvK3nwtmJEceD0lp/qDuRaqJ6k/A8Xr4BN8SOTWJ0TCD1qhl1vYkgJTCE
         b6llf9XKdQU/yDtO/VUGe43HTr4kV5z2nnChJZt31z/axZa0/aOkG5ystTvpFIuQKmkp
         499EUzn3Up57hHynIxvWogUlFvUep62kqy+KBRxay2tiJtFTu4S5wFZeBrQiv5+TfAXl
         0ZLxvG//e2IB81ObEZgyRiBa9f1JzBpBQQthYJ8ba3d5i4NMOhgqAbLQbE6769YA2ksa
         qlgukIjfWmTgd082fSE3e+ngmMhobJHCRqq44QMj1BKxmDESFBKlfOzobFVEqMu/hY0S
         kRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752144550; x=1752749350;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ERYadl4idWZ6bP47UPPD8JzYK00w75uLtXXgxW78Zw=;
        b=D7HLh6czyfCGgO0eW8IPBnoH1+TmW8cs8fEJUYQ995M70C+DP6wDoZ2R80LJ+W0K1I
         RV9FDz+dhzi8VPvdbIKg7fSPU+l9Z67UeYmmwAc4Hmx8TvpmfvYkPDnZMMgynsOI9FtU
         EZIxLv1eb1jU8OsyEfU4HE9gjxVmiwwTCdx/4qJk1Hj93swgR5oTUhwOf2ABtCqxD5Fr
         SPsa6HJESZZoUuzk2A20C6+0RY+3zerQhp4H2LnrK6AhWG+MxHnRWmiuszcNSKT80mMJ
         sCcqIjbsP6oYAH/JQHBIX5Gvg/KTBiQofZOAQ05EpLcmC0Ot5m/kYqQA+cUMrsL6k/1X
         G36g==
X-Gm-Message-State: AOJu0Yy963BbrdkGfSlvsLwvmq3V0oBF/MylxSGV91s8Gk2G/kwiuh4b
	4fO4dNsz9s4Fc3RZ6ADXvYXM1dKdxnoWkvCt3e2cMqsQF29JZF5ZmDvzcnbIgkxmTxYAbXDglFG
	r4MreHyriHXVsv8a0xXzooaWRwFPzb6HGr1PQ
X-Gm-Gg: ASbGncs4B8FQuyMTI9n7pcgl7iUaCM0+NTAQhGekz6sgdI0tjAxZQdKdchr3xpmcHcV
	gZJKo/vLwGlybD5LyUIb9nYVJP5KwtlcStggbC7Gs/y/+APzohviz5E9h5uYhFD2phDkRm7s9lq
	Yu7CwGoVu3DirD4nxDIvEOgNbBUEQSadl2MkVIJmlLRnLd
X-Google-Smtp-Source: AGHT+IFfr8kJQV9FJWQycUxIa8dP6V91KBEAjTrEKw1zKdTlXVoU+j9LvAiNC6/xeTVVtS7xK7hqbLjuVmTNqh/Ow08=
X-Received: by 2002:ac8:5713:0:b0:4a7:a8a:eed with SMTP id d75a77b69052e-4a9ded580ccmr93586081cf.39.1752144550405;
 Thu, 10 Jul 2025 03:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Samiksha Palav <samiksha.palav27@gmail.com>
Date: Thu, 10 Jul 2025 16:18:58 +0530
X-Gm-Features: Ac12FXxQNGBbGTiF2l2Um10neCCQ3xCZlwSn57b6WQVAOArbHeTjtgAUjVxM9tw
Message-ID: <CALq_ZGHoPG3oEtUBSEjK6nsRJDK3astbFtQJ1Q4nR3x29A8iWA@mail.gmail.com>
Subject: 
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I=E2=80=99m Samiksha (a.k.a. Shdwcodr), an undergrad BCA student from India
with a relentless drive to get deep into the Linux kernel. I've
recently begun my journey contributing to the kernel, focusing on
staging drivers, learning the kernel development workflow, and
understanding the culture of patch submission and review.

Over the past few days, I=E2=80=99ve:
- Set up a local kernel build and testing workflow.
- Sent out my first real patch (not a dummy), with more lined up.
- Subscribed to key mailing lists and joined IRC channels to stay in the lo=
op.
- Started tracking patch feedback and diving into
`scripts/checkpatch.pl`, git send-email, and the entire mailing
list-based workflow.

My short-term goal is to get multiple patches accepted into staging by
early 2025, and long-term I=E2=80=99m aiming for the **LFX Kernel Mentorshi=
p
Program in 2026**.

I=E2=80=99ll be lurking, learning, and asking questions when stuck. Thanks =
in
advance to everyone who shares knowledge and guidance =E2=80=94 it means a =
lot
to newcomers like me.

Looking forward to learning from you all and giving back as I grow.

Cheers,
Samiksha (Shdwcodr)

