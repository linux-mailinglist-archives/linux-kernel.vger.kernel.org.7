Return-Path: <linux-kernel+bounces-818043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F45B58C06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E2D3B53DB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513FB222566;
	Tue, 16 Sep 2025 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8dNiZd7"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB41B7F4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757991028; cv=none; b=sL9tOOtsQIP5Y2P4GJuL/2G+nMu9ImnHR48RU6ecCi0cXAGc4CzP/LGYm/rhZbiHLbPTAIxWOOp+38byQ0Ye/wxl3aE6ovTP5ZJohNSSYKmkb20duJu6gmM0u7IZerSceTRvw9y1M0EAuUJNzBhiUfJ3HcST8vxZM6Xd9RbcsdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757991028; c=relaxed/simple;
	bh=0BZScZqwkLp8TBGKyHYDvCnuDY5A4//FIvL5EisHnTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9q4AOO8uOhdIuJOlvBR8PA/36kfInnxbLqTf3EEhoqGvXuHichy4iOSaB7v98d32MjSJkkZhNFgfeuVKWbhWMgaaj+4ZMHkVQZg3FZ/GKelfSGIK6I4F1FXIZJzdzhO0B2ufLauPfVDy1wzvvOxfPHpOpx1VbUzYUaK9HSCjZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D8dNiZd7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2637b6e9149so71735ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757991027; x=1758595827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BZScZqwkLp8TBGKyHYDvCnuDY5A4//FIvL5EisHnTk=;
        b=D8dNiZd7hJWHDzCbc5Peon1WCZXAIArdWbvKO7uOCPloN4STNlbhShpGRdNFlX6zYF
         tbizWMn3hONzAOrXdBY+z2wLAblgUG/uXFJ5T0tMCpU7X7FcSDq5dFz3zXp283DVxbJo
         kdD5NzUbVckbk+ZaVh8Py4bQwmOnFFvGvo1UWNxSivAcxvqrn/eV2qxyuMSgPUQtwO65
         CRoGQb72+sFivtZxGMBLzVEFHmOMFUJwiro3U5MYanyp+W2Y9lhyvnNELWUi6QfDiUSo
         FkcC17Tc4FW8f3k63GHxlYNAOOR788bTR/ws0fwftpyOJnd5N+dAdZP+Z/GGnvxySyp0
         K6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757991027; x=1758595827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BZScZqwkLp8TBGKyHYDvCnuDY5A4//FIvL5EisHnTk=;
        b=dYB464OqvtwACvyy5HRXhbyr/fhfR7GGlj+X5WqWkAEmp1eFaybS5S+Hy/4RjXOyRi
         dZpSudvYAqgUvZWukv7pWAex2etXP5NI+uKQ60c8vifI9Ltr+eD8nYRXFgs63J+3w7Vo
         0o615ofSqejXfmZ6VelwSd3Ng4zVmONNrro1Kdvk8qUqZtSF8fCUlAyq2ksFrlCM/XNY
         RLdDFatUzygA7L6vA/RrOhUUmKd7HiT/J8VrOFCIUtnz6thLdczEp628yCFYM+omUaMU
         2vgLziXr+GW2ZziMq21iWfwSScpZHM0jwz8ffDUIPfmk5CMffGyNc6BXR2NccuZWJrMg
         BC/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLG26YvPTfER1te0uOD+pk+V8gR0fX4eK72xSKsrox09DnQbP88UnZGWvD5kce5/lHUtM5FmCwX1Goawc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztArPJKElzmOd0W35XMGPUj2oPW1xuX+j28P0jXWxXOfBYKNp/
	URR0htQZz4sfOCf6GprV8f1+SqtkHN9EzrqDqCA3WHErS6rY63Ju9/U8Vm57qN/Vj3mlKbW2iKT
	2e/3Qa15AiEaK5B8z/IyuRBkqTVNyIbP1k62FCmeZ
X-Gm-Gg: ASbGncvbC53j40MqkyxZ3VQ0v+YzSM496emwfHpMC6UTAPICe3oXZ6cAax5lN7HF6yQ
	LTcpQ+lzOTB43D4XsT6UXSYKvxeVOAZ+9P49yAiZDyqchNPR8V7/Bc7hmjU/T6G1vNwI3x72w5f
	qrMIiF2c5XT8zCblPHcbVp+/6wBiRR/id0Gdg/m8Wq9E2BfzGAl8OtizlaykPsTJlTj3TzNrFlL
	TEUjQPUyilreOQ=
X-Google-Smtp-Source: AGHT+IFeyVTW5EhpdU5hsvYCz6r7UZGqUVYyh/d/fgXFv2LFAjtq9iQbsFb9hepaT779jpkPhC9wzFom13aDSrCRIGk=
X-Received: by 2002:a17:902:d2c1:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-267c9e63015mr1730905ad.3.1757991026132; Mon, 15 Sep 2025
 19:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915035355.10846-1-cuiyunhui@bytedance.com>
 <aMfpwYPX6_i6ROOY@willie-the-truck> <20250915103506.GA3245006@noisy.programming.kicks-ass.net>
 <CAD=FV=Vr67+uRK2bYu34MDXRJN4w_VH_EO7OW4eVLJ3wqUUBog@mail.gmail.com> <7366f87a-1924-4dac-8945-389e6674213f@gmail.com>
In-Reply-To: <7366f87a-1924-4dac-8945-389e6674213f@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Sep 2025 19:50:15 -0700
X-Gm-Features: Ac12FXwGtpNoLqYtyQg6lqv50KBS7uhzhnYxEQJsAkff9-AdgmNoT3fws4BF21Q
Message-ID: <CAP-5=fUs7WPQ1U-iXzZQDwa5Bm0Fg11Riw20AFnDDOScoY6BnA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: remove HARDLOCKUP_DETECTOR_PERF
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org, 
	catalin.marinas@arm.com, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, kees@kernel.org, masahiroy@kernel.org, 
	aliceryhl@google.com, ojeda@kernel.org, thomas.weissschuh@linutronix.de, 
	xur@google.com, ruanjinjie@huawei.com, gshan@redhat.com, maz@kernel.org, 
	suzuki.poulose@arm.com, zhanjie9@hisilicon.com, yangyicong@hisilicon.com, 
	gautam@linux.ibm.com, arnd@arndb.de, zhao.xichao@vivo.com, rppt@kernel.org, 
	lihuafei1@huawei.com, coxu@redhat.com, jpoimboe@kernel.org, 
	yaozhenguo1@gmail.com, luogengkun@huaweicloud.com, max.kellermann@ionos.com, 
	tj@kernel.org, yury.norov@gmail.com, thorsten.blum@linux.dev, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 6:47=E2=80=AFPM Jinchao Wang <wangjinchao600@gmail.=
com> wrote:
> Should we support both modularization and changing the backend after
> boot, so that the user has the choice?

Having both together and then being able to choose one or the other
sounds like the ideal solution. An issue is that
/proc/sys/kernel/nmi_watchdog is used to dynamically enable/disable
both watchdogs and presumably renaming it for the buddy could cause
issues in user code.

There can be unexpected consequences of the buddy watchdog, as the NMI
perf event goes away there can be extra cost in setting up the first
event such as allocating buffers for the PMU. While enabling the NMI
watchdog to avoid this cost is kind of odd, I think users would be
glad of a workaround for what may be perceived as a regression.

Thanks,
Ian

