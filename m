Return-Path: <linux-kernel+bounces-821884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0E6B828C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6D63264EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910312236E1;
	Thu, 18 Sep 2025 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ79K9ds"
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1471145348
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160006; cv=none; b=CmZ2RcMpwjrD7dSHhq48i5lVH7kE2uWs5fJ2WHMkvA4X2tuGcpo799QeWQJdzxYP8DGLa+SxYHePQNBWaRSPy3MpDyJETx7JTK9XrT2ZfiHjyFG5RWiCwUeKdBfqVndss9bwtptRRPZpvDmYtFYC4A/b8G1HjQyKScka1WB5DlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160006; c=relaxed/simple;
	bh=Y1L1HO2ER0yGATtMeo6457ei3YCrxJF9T8bAgNAYWB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hY6CNqxkp7SNb2dVjfhoSb52vdG2gyCNFc6neafGNi+j6PZBKDHltnJa5/pbJWq7uSqhLz3W83RH6T3FYV6u1F1ZAp8wQxen5reUN9YcDWe2/QObHHy+UxFixVUdtCrA9/Lhmhp8nM6L/NRDNfSW0Jv9i3/O+lpREuJtgt3/Wuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZ79K9ds; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-62adfdda606so242333d50.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758160003; x=1758764803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ztic0itTb092Cg8phgOMtBzjG5miAwDaU95tKvoCG9o=;
        b=FZ79K9ds5qUX61monNgpC9K7AIGv9kPI9wToWjXcByaQVeElBM2cb7ojaDCoj/APp9
         0Vm8UkpoAs9XG7BxOyRHTUZeYOYCv2UVkGpNV2I47sGtrEZPNydgQek1gJ/lOa/Esup5
         LIY+O+wJb8MPIF5yWDJpGPRE2gy8JqRlK+K2GRPXf21KvVDO7g8YWF78+omy+jrpa9nV
         ibUuFVBiU65eTBNkR2A+7NmjG/JtXosPI+JYQVNfFCGINs5jgeWATAAsZk8DBvAzbGP8
         Cak5+Nzu7fM9rad3XujZw34DKf4EWn7/PouNj8hFNIsb4N2uUUaUA9q6gO/peYxlPI78
         LTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160003; x=1758764803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ztic0itTb092Cg8phgOMtBzjG5miAwDaU95tKvoCG9o=;
        b=wkBUCJJeDWU0OkCrL1Uz8Cagu5RabdivsWLNUTWwkmdukzqSIePf5bsfIIjGrTQjSJ
         CbTUhmTTtRZpSEid58+CQEcdrDX3cbCcLcpQMZT7u2ap//mFOBWMdQ/JEZWUXslbcqmW
         tx1+sFc18+55EMriOeDWGVDplFFdgFsF5++JfT21I6kzho9HnG+G/IGWHNStv3ooXSoq
         fIlSFwGRzITCWC12/DT6FJlWpePx+JreRJMpmIYmTv6JYeqqq+PzKbSAPnB+Oo+jH0ov
         9/LD1uvmj0v1EQbCfWTh0UKGnLdm32af4NGXwsomqtFZaMXqYwiMZQLt0tv9hTOmEeEl
         JGZg==
X-Forwarded-Encrypted: i=1; AJvYcCXMBqUY19z1QaoI2H3t2kYeJFBfW+zMqxFs3oPwG3tE7Axg/ti4NVSSuXY4DCo8b9vyeCao1L5m1liE2mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfXZniOZsjGG2/vxN+NT7qLXrhvSwRvaNIpvso9Xv7Ttcg6uFM
	VuLe+wPevKIwNT7Wo3LmKtluvLDR7ZRUSR2JsSm/e/VbQBVWPKFdH8FGXYmrYhsqXxxzThUp+C6
	2kAlv7RyfYvFW4o4nMmK8BveZ58/z8og=
X-Gm-Gg: ASbGncuMM7PniYAEkLRaid0u+cnK/j64UbigJ2mvz7r37oI7Pl1KA63CX+SEDkSlhBi
	a+47laHTQE4Loj/106N9uXjpCmTpo+L4dmE/md9vwnlzIN+35krPG52vBhjjZulWAsngZkoSISC
	hEdcQcxLJFeLp1O73dWjvu6WH6kGn3oNWjBw9kgZYVFWA9HzKXmx50FfKycChJ8LVhMZfpeum8t
	W4K8vzv1wv2F9SeEEk67n8t3Q==
X-Google-Smtp-Source: AGHT+IEoShjhtx9jFDawsjFMigqup5ul3VPAlqdVHAkcLniGQ0utQpaOOKabV6yB8aQ4BG4JD2NxCioJ3jgbCw7hSWM=
X-Received: by 2002:a05:6902:4a0e:b0:ea5:af77:e48e with SMTP id
 3f1490d57ef6-ea5c034f6d6mr3244542276.3.1758160003479; Wed, 17 Sep 2025
 18:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917045026.601848-1-masami256@gmail.com> <34b16512-b098-470a-afff-bc8321e2499a@web.de>
In-Reply-To: <34b16512-b098-470a-afff-bc8321e2499a@web.de>
From: Masami Ichikawa <masami256@gmail.com>
Date: Thu, 18 Sep 2025 10:46:32 +0900
X-Gm-Features: AS18NWCQDzJTwegu8k4De9r1ttP9WvpSRtNldMNb7nT_bgORV0G8wPu0xNyaVTk
Message-ID: <CACOXgS-VN6CDZE2NMtM0TuoRT1UZD1LR0JbY5XOQ6vsVmsTUKw@mail.gmail.com>
Subject: Re: [PATCH] HID: hid-ntrig: Fix potential memory leak in ntrig_report_version()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Minjong Kim <minbell.kim@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the review.

On Wed, Sep 17, 2025 at 4:46=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> =E2=80=A6
> > It is safe to move the kmalloc() call after the hid_is_usb() check to a=
void
> > unnecessary allocation and potential memory leak.
>
> * See also:
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.17-rc6#n94
>
> * How do you think about to increase the application of scope-based resou=
rce management?
>   https://elixir.bootlin.com/linux/v6.17-rc6/source/include/linux/slab.h#=
L476
>

I think using the DEFINE_FREE macro simplifies cleanup, especially
when an error occurs.

> * Can a summary phrase like =E2=80=9CPrevent memory leak in ntrig_report_=
version()=E2=80=9D
>   be nicer?
>

I see. I will rewrite commit log.

>
> Regards,
> Markus


Regards,
--=20
Masami Ichikawa

