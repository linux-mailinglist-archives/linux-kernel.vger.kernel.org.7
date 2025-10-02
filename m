Return-Path: <linux-kernel+bounces-840736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE9DBB51C4
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F96948481B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97E7287249;
	Thu,  2 Oct 2025 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YwjKSrA3"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7BD27A904
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435903; cv=none; b=XHcgmQl4HiZtd8UXmMTumvVHyI/vgwpw5472S1+uEesG2AHUGY4UENrNcB5++23yyutlJfF8GRQwBtOq2wMiLEW0DAVrBghoMgvRg+dV7BAl5CH8mCpbeVa1hEsrHSdyIn/OMnvC3uwnjmwvInifTyBhsXNY+Mq9MKkiKDThqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435903; c=relaxed/simple;
	bh=9Xmptz9A0AZI6GVLqfIYyRp8yCNyKVavpmva4MS99eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZEBOE8IYLBHaTmO7MRXbnlnWgU26HHh88tU4RBYPyoXxpdpZZAmxk44ADJlyzRXH5Ou1nFFf9AgAg/P7dgGpK0g0YV6mm6dB7MilbrRiXotmBemGbOW3Q1XZM27FcRXmMKDBpzihF9OfGtOnFQDIaZFzxw2vimIRBzlipYKTeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YwjKSrA3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2681645b7b6so8815ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759435902; x=1760040702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Xmptz9A0AZI6GVLqfIYyRp8yCNyKVavpmva4MS99eM=;
        b=YwjKSrA3mK1AI/iw1tQUMemQjvhwoUbXSyAu+ghnVPr++0Ut/qB8P9D4L+d8dve3ye
         i2DWtKGqGM0931Ev/Pdgu1nzs7RmO4VxvA7O0sKjIFU6ZlKZarOz3iSjBo83KGqsnzZi
         AovWpg/jbIunUVhyXyBi5U1UtIsLPDdJ0Lz6EiGm/ZrtZ7jFekBNzKaxj/gs9BRgQEq9
         I0fb4r+lUhr50UhzuiOxG3LqqVKJd2SwbPSQLOmIZuLgg98UO/PsZP7ZmD2kcoH5pElX
         a6iMbsIIBcnHF34h6i0LF4FCSzgUTOcnk4CWRV1Vid99GNCxgCE8CVm1O3bLS2acrstV
         LDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759435902; x=1760040702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Xmptz9A0AZI6GVLqfIYyRp8yCNyKVavpmva4MS99eM=;
        b=rAuOukJEzrjh53fF46jqNsHLJ2P+gws8TCXBCzMiAO1Gg3uhvCbAAtTvzvgx5n/UzT
         +F4sjETGRnI6dW7v1FCRcWuF1G8PvP/uXP0C8yKrMsvSjbQQGBl5QapKBuM2qELBhIqq
         cFLt2TCv4uqNYwx5iCzcxhardKG/Ig0c/S0RT+viC202qPWwikI9K2ZBceVnE5WMFuLj
         3SM0d5+rq4uhjVSodF+pw2ksbJW9JFV6SU5ZIWq/wPMn9lqjcRzwFqxi1qflgeS11PQ6
         7J0S60lv6eDkFbQiERClcPl60Y6PyDLjDeGpBgujxviv6q8MN95kJx9t78fq2z37PExG
         jgnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVylp+44F2DNlS1M4O2ISgo3Z0awJqVBsgG3b009PTdZ4161vCgvUfakljsbOrZvrpg7eGuvLnZOXXOc08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzLzi3zr3EEWdqZIbmXBxSuR7B6vlroqshKwi6THWRIDOf1jQL
	/IHNLXp9zlI8t53djxeNxYMMitsUZ+I5QrMs/SX2qVPb7cFGNjumVySj1reoUlV01ITdaIp/0LV
	s+Wujz5c5nOcvUdU3deFLYdIqZkqdEMqmry6MsnHP
X-Gm-Gg: ASbGncvNTIR/p5x26gGnxqvvDp+ii1RWJS1RJji/z3cKypPJ5rSmVSuzJ/6NDVBmqwM
	/MsS9tJwWNfViy5ZcxgIsKm/hPVhlKhwxn481ivR2Mz9DaU0u4HLdwn9zQOfUvw7Kox3OlAndLP
	+xhWwQs/3aHOPIPnPgVTi4tjJkP+xeu1kPqTXYZ4K847y6WPU0Ci83MWQ9uRjfRaZaQbigjsdjR
	/SW4foOH8prXQc1vAVh4OK7Jzhp1sPd51vpoYcU/MtAybb0Zuz+BAVyk6aPA7KvvBDd
X-Google-Smtp-Source: AGHT+IEDnv7xA6yTgSjXYL7xRPt7GJqeog/t9tQkEO11Hq9eG3As031Vk1GqWBEZmEqKXPhJN17IuiX62dFIfHEg2yE=
X-Received: by 2002:a17:903:38cd:b0:25b:d970:fe45 with SMTP id
 d9443c01a7336-28e9b5b2f2bmr118665ad.1.1759435901284; Thu, 02 Oct 2025
 13:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com> <ca47d298-331d-420c-8c4f-83cd29bae902@linaro.org>
 <CAP-5=fWUYH2eji2SNp37_2uHu55qEfRxuhhROYsMZeCixjda+g@mail.gmail.com>
 <CAP-5=fWUVycpDss_+MNQ_DM93AYKWED8aYOUBKLziYTOn68QJA@mail.gmail.com>
 <cf050a7f-b341-4e14-bc46-8bd30e366b19@linaro.org> <CAP-5=fW_WfAzb=qm+AnA-xSn8MOHjmTMcpEvXB6uVi+0Cr0=fg@mail.gmail.com>
 <CAP-5=fV0Qqi1m72-7us9rw7K3hbh05fAzutVtcazY7iTu3g3+w@mail.gmail.com>
In-Reply-To: <CAP-5=fV0Qqi1m72-7us9rw7K3hbh05fAzutVtcazY7iTu3g3+w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 Oct 2025 13:10:58 -0700
X-Gm-Features: AS18NWCOIOOooIYNzhifJ_WElQoGyrFKUK_3pLXugWDvVz-KeMpwCHFzRx6va4g
Message-ID: <CAP-5=fX0bOj2kEJYmRs33RpL0ODaOy2wCvDzwLDmNxurVRpGew@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] Legacy hardware/cache events as json
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 10:58=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
> From bisecting, this change came from commit 9eac5612da1c ("perf stat:
> Don't skip failing group events"):
> https://lore.kernel.org/lkml/20250825211204.2784695-3-irogers@google.com/
> Taking a look.

I sent a fix:
https://lore.kernel.org/linux-perf-users/20251002200604.1792141-2-irogers@g=
oogle.com/
that makes it so that only if all events are unsupported that perf
stat exits - this is addressing a bunch of latent issues and fixes the
perf-tools-next regression. I don't think there is a difference
between v3 and v6 wrt this behavior, I think you were probably just
cherry-picking the v6 patches onto a newer tree. When those 2 patches
land I can rebase this series on them and drop the first patch of this
series.

Thanks,
Ian

