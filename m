Return-Path: <linux-kernel+bounces-873631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66113C1449B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14510188B211
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6FC2F0C67;
	Tue, 28 Oct 2025 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFvnHyxM"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F962F12CD
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649586; cv=none; b=llsBcHQCAx3p90SrCuoQC/VnHF365WKEfGWWtP+6efNYUHmOpRQGGo20+5UIWekEzvBx5A1UeGe25Jtxwo2rL5EEXkdDrI1P1efhzq0PwiK2Utp/Ps1dvJZ47VlkDPgnVbLVahjTT6s2Ex747Fw7K7tJmIiXLCnxz20DpS/INMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649586; c=relaxed/simple;
	bh=iUWmP3PhZ8tlgKqgNEzC2Ad8cbsR84+pstOsL3UQMkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=toYZM8auB3M2MyO+bK+mH4zkfqXZm1TBRJF/0wXLj1Py9mNWLx+Jesb6b4SQlgRVM+fUQb3jXvFQyj7KvhrzK1AtEQhShIvL6c0nP2/gAoTbqi9BaP1Uy+PX5rhe76w1fdEm5yYNFdZt3ZYf+jbTE9dZN0rCMFmDBqVzTIlfZrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFvnHyxM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-28a5b8b12a1so60519175ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761649583; x=1762254383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUWmP3PhZ8tlgKqgNEzC2Ad8cbsR84+pstOsL3UQMkk=;
        b=IFvnHyxMVsrn6feyplU6oBcbanJDS/iuuMAuzXgQd7Z/TwRcKfTJIZZjcs+IXWmFb/
         wRP6qvHkAgKxhT9nv30fLL9wpKki3e8D1X/qEEx4qogSE2pYKW6dq3O37bfZUriVpPc5
         dUReK0usIvBmAMQ45WJv3mdtFF4wIbBEerCzFSVYGBUk3klSGfSiFb/ODwE5HFHW70XS
         1Isxy3hRagKdC178VOqsloso75lQH9+srSJbSQMazY/x3jkVIEtwxSYV6WtM++OsLU+b
         niXaYVudNm6PeGa0aAS+B3gdIJSXnfIZ/2yv2l0l1m+YlSAdX5pwiKDCi4c7m3bKuhkX
         mmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761649583; x=1762254383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUWmP3PhZ8tlgKqgNEzC2Ad8cbsR84+pstOsL3UQMkk=;
        b=Rk3P/sNfLA+PKlPNt/bal6tbN5WIJQp9LmW6r2Tc8e2nyP+Rp7gT67w00yn3vpLRJ2
         P3kMObKM9zuouRztCbmO2OB9HCa7BiU/CbAUX0ybiS1Mq1VWa5Rujhy6pzgE8SAfeaTw
         iy/cgPZIWC0xNW92gFw6Ls12C9Os7isPzTvq7KqJAtLFKMCoZQJ/MnKLOg1tdgd4xiat
         9IN0ero20+KcxGTxqRqtoJ668quQdC4/c/BPr18Mb6iVE233lUVdjmfgdLKqF/hEh/5D
         jNuIpD1a1pNZxu/Jl4TzHHlu8Yw1vFttKjc1FZXDJvqoKzExpjhN4uh8KrQISS5k2yQ8
         wKfw==
X-Forwarded-Encrypted: i=1; AJvYcCUhjPb5wAwHbV+3cpVuDIJvhb1nGTpqVfl63VTzsO6I3FqeCbCZvVos2rNH/xqmGg0BSDabvjN0qo6kZuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyApjweWdh9nV4rZRb6wldShN6u7thJqh6cG3wsguKq4z9EVFHs
	0bXnK2T5yepQXGGESsiizNA7F7X1ncjkEjmBK+g7kLJptMRzOIGryVFcnTyf5KixyRnl6KMa983
	SkRJ4zwIfh9WGX0U62B+nNDCPq8hkMaw=
X-Gm-Gg: ASbGncu6uF4u3nzD3rmF8Su74DI3UjBjSRwXkmv337dH4QyjDh+LAAtafnthpL7LQhv
	JoHUUBamvq5GbRQTCFOXNyXLfVmFBcqBm0a/SNJBGwXW+RsiDN0IUKXDHzOlgMvF5OCuUq8cZuX
	JHclwjTNxpVWwgDasDMEFQuxZQ1LRzR75iCRnZ/a/I/UwYz8PlAHRrU3S5UAIfzb4Rvge5G4dxT
	Sb9jnkhG1aAsmOlsVwFnaBbkfY1vBkp6g7yj55YarKI+XqsbHKfINcPnm285alvj+xBsFqf6P4s
	ryMxlwgvmrtmvmrsq0/CXCh4FsRwl7TLFkBvYlW5zdkmUUfwHPUqQQtugdIj6GIqixD0vArCIw9
	8ZEk=
X-Google-Smtp-Source: AGHT+IF7FNORVzgaeQ1govCGZtEXJ05FSICIDDXxzpekPFmsjSkXmOeYH2v4GP77oi5zhp/UIA8gm9W95L73ZNdDHns=
X-Received: by 2002:a17:902:cec7:b0:283:c950:a76f with SMTP id
 d9443c01a7336-294cb67398fmr45724665ad.43.1761649583232; Tue, 28 Oct 2025
 04:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928054913.7871-1-opensource206@gmail.com> <CABQX2QMgZ0VGQ+-RhF0suTyL9qkU1Hf5V7g2jvPQ+CwTEidZKQ@mail.gmail.com>
In-Reply-To: <CABQX2QMgZ0VGQ+-RhF0suTyL9qkU1Hf5V7g2jvPQ+CwTEidZKQ@mail.gmail.com>
From: opensource india <opensource206@gmail.com>
Date: Tue, 28 Oct 2025 16:36:12 +0530
X-Gm-Features: AWmQ_blOzU8MNjg24AK7wPsDJ9kJPnWwRA7YFclINRCUysc4TIihhoHenBhIG7M
Message-ID: <CAKPKb8_tHVEFrkWHF3ycuDXOCJ9-qr64_sii9O4bcUiu4uuvRQ@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Replace schedule() with schedule_hrtimeout()
 in fallback wait
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, bcm-kernel-feedback-list@broadcom.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zack Rusin,

On Mon, Oct 20, 2025 at 9:48=E2=80=AFAM Zack Rusin <zack.rusin@broadcom.com=
> wrote:
>

> I don't remember exactly the schedule family of functions but isn't
> schedule_hrtimeout leaving the task in a running state? In general it
> looks like with the patch the task's current state doesn't match what
> was expected, plus I'm not sure if I quite get why the uninterruptible
> non-lazy case is being replaced with a lazy wait of NSEC_PER_MSEC's.
> It'd be great if you could explain a little bit better what you're
> doing here because the commit message is missing an explanation for
> either of those.
>
> z

Thank you for checking the patch.

The existing code does not specify any fixed wait time during the
fence wait. It simply invokes schedule(),
which means the task can be rescheduled immediately to check the fence
status again.

By using the high-resolution timer family of functions, we can specify
an explicit sleep duration.
In this patch, the sleep time is set to 1 ms, ensuring that the fence
status is checked at fixed 1 ms intervals.

This approach allows the CPU to be released to other tasks for a
deterministic period,
thereby reducing unnecessary CPU wakeups while maintaining timely
fence checks(FIXME expected the same).

