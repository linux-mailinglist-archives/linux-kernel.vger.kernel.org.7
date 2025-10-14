Return-Path: <linux-kernel+bounces-851597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A50F5BD6DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104C419A01F3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21438296BA2;
	Tue, 14 Oct 2025 00:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeCSFKGw"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333AF79F2
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400917; cv=none; b=piN/UkdoA/XxvmtmK6ljQgrf3GBfDvz5x6EGDqlRO91wqnPO2vUUZMy0JFNJ7FfrnSiEFHQK3O+tEfShwXQrbIhpw2MWahIv+yKBk3VE/0PlxNb3F9tfhaf+PpibmUnikNGT8kDeQhkJp+Qqei1Ww4g3PUPMY2oJPFcXhiBYASk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400917; c=relaxed/simple;
	bh=vbtIGUm7hDdWO8OPCXJs9MmT4PDfOXY/wBQB8dWOQGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTaJiKqHrORQLQJ+derJ5mzaN6nvRAgXBTwC4gDUsTbq9aNxpxEuGWhKPwKD1k8uyAMN7CwO/5PDOTU0NEtynKccqkPRlwImMtQMEEKXsQpepoaKLd0ovRYZux9PYAWzosUrDIv6571iCPT1UjrUd1Sokvzvv+ybLnxWaTX2iVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeCSFKGw; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-330b4739538so4484644a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760400915; x=1761005715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbtIGUm7hDdWO8OPCXJs9MmT4PDfOXY/wBQB8dWOQGc=;
        b=HeCSFKGwr7E8XCLsM7jqGL0sUNJPfKMJ+gySIOCB2J/36RUowrNa+BlAhRId3/X4Yu
         m+Y/FwbXAp1RI8X8nqranpfLed2kZ5IH8fTU1ML4B/fo59bwwnrDl5aLHSPeSQlhxXQv
         4QxYjzxRfKkU1nHEmzuh0+fbHMLi15dl/YKD7o92zuk76nKvlkVf0ON8+YVysvnQOrhf
         XPnCSsQEnK8lsuT3K5OREbbdZrFsj+SrITDOoEU8RjkhmGQ+a3sEu3gJ0rtHAFmi9Q4D
         mTlk0wahXasBfbKRsjw2FmeimJgIlzcOU1dPcEz0jXFkgFjJuCDZIm7X2z6OzwEwQunw
         Wg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760400915; x=1761005715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbtIGUm7hDdWO8OPCXJs9MmT4PDfOXY/wBQB8dWOQGc=;
        b=Z8KjEi50fHo+F46gio6H2YTm/chnXuTjgu5QUe58bAoFA9Mnt1o/eYrOkFD7S3t1Do
         ugyynHhc/4IpVdb9odNjb5QigqPoadnE35igJUcVYxKoRVrE1S1wdEaU2PsvwP5Ip+/J
         wk/MI1DAJw3t6rOY+0atqaYePNZo7ySja4UO8uzo55HGhtmKfcpH9a4Az5PUSG3yiq/r
         TghaEfEcP9E38sY1qlC3TYfn0+ue7R+hO5hOZTALFQ5+IGSd2cxdyMAAIeP+e+4Blvku
         SVLqztzMyl6RiFYZl+30wX8GAM5oqIdBRM0aCxBiBnIsTuLb3UcfT+wVZVxTPcwGx7OF
         ysqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxlH8RhGgAM0h4Z0uCKnxuZfTYBY3xXxRGDEipVD2MWhbUJLUecXQItwLpbO0RayFegBzfptzmWn38k5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUqtSZpiR/Q0tG8kUWNK6XJqVeBrLAE71ty1EadTCpGUsiQYFf
	pOQikvYUA4KTFckMzBsXCb0oA1Ho4Vpt6zqEAtEaoo4ciYwwa5KF+Vr2/rcw650CyoHVKTtZeVO
	Bcn7duGKhflIn7zpr5k/xzCFRbQAjbVg=
X-Gm-Gg: ASbGncs/vBsmfliSOHh6tHR69ZavrNUnKGY1pFADSfMUxezLLpVDdZ5AofWI1g8GAXn
	N9IVUF6lVTktlBmmMQ8bprE1NIu0feFmrJzjC7U/cAoZIB0zEiGH4gzuZPEfS5APkDV3Pf9NPAf
	/ER/K03xJbvUod7KcXWi6pYNYbqnNJIfTWmJFrMFWpNNpfitagGkqpSxxfzWZD4yL/IJAVtgV1J
	JDbJvfNtUmvQFsKc8AgvktDIwmHZKab4MSqLCAnfA==
X-Google-Smtp-Source: AGHT+IHARnLdlryg1PhvKDEi7oBisiWZjKWZuSu8vpVm+0nfd2Qp81tXbKk1PVPW5Er2+jS8pPs2aKsNpGBsv4cI6g0=
X-Received: by 2002:a17:90b:4a52:b0:332:84c1:31de with SMTP id
 98e67ed59e1d1-33b513ced6emr28797119a91.25.1760400915524; Mon, 13 Oct 2025
 17:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com>
 <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com> <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
In-Reply-To: <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 13 Oct 2025 17:15:00 -0700
X-Gm-Features: AS18NWC8zop_0pqhOu3uFzZiyqIm33mL5cLx3lr7v0iVW2czeb3AtY-0ka9aqwc
Message-ID: <CAEf4BzaZ=UC9Hx_8gUPmJm-TuYOouK7M9i=5nTxA_3+=H5nEiQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: pengdonglin <dolinux.peng@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 4:53=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 13, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > Just a few observations (if we decide to do the sorting of BTF by name
> > in the kernel):
>
> iirc we discussed it in the past and decided to do sorting in pahole
> and let the kernel verify whether it's sorted or not.
> Then no extra memory is needed.
> Or was that idea discarded for some reason?

Don't really remember at this point, tbh. Pre-sorting should work
(though I'd argue that then we should only sort by name to make this
sorting universally useful, doing linear search over kinds is fast,
IMO). Pre-sorting won't work for program BTFs, don't know how
important that is. This indexing on demand approach would be
universal. =C2=AF\_(=E3=83=84)_/=C2=AF

Overall, paying 300KB for sorted index for vmlinux BTF for cases where
we repeatedly need this seems ok to me, tbh.

