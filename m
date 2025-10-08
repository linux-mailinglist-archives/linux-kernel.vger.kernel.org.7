Return-Path: <linux-kernel+bounces-845746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F6BBC6001
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E34819E469B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBE7291C1E;
	Wed,  8 Oct 2025 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL4YBHAb"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B92417E6
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940434; cv=none; b=RNwMsumZcFry+oTCUaGoD84zR7u9I3J2nu8qu6gAZUWTcpQkesPUMUmscoCOU4ofPFN7u3+zEZ/QIsJf+F8ymZW8BQjbm7EKhfS2HIKTB4pJOsdT3ovjfKBCJyUXpZ2Cb5JM03+W+dcr2y0/tf1kBPRqEWz1b7Ufi/O6+kBEKtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940434; c=relaxed/simple;
	bh=T/2YcwWKmAY+B7hDOTvxmnfQNfKpAL8dEcLckN0qNB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JG5SFNICfw41FQ61khGLfX1t1wfNH+KkOEHPhkBnIqMpG/3r2tSH29VWOs3UgUlNoqbyqm92cF12XnVcXAt83KaGnzYexMi4MkIUiBm+TmS6ZmA63gkzJoJAL0ICQayWhzKCsGEydESCtU3tc+tGBMbciAl7IfwQKhcRZwY8fOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bL4YBHAb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-28d18e933a9so13064235ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759940432; x=1760545232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzZhXiLzKKt9ijicdsXyGaAREF+VLijn+mpS3QdbwuQ=;
        b=bL4YBHAbuXDSHsqKXvVVFAU+gYMqcXihCfTPcWRuP7BGBMD7VRn9AhQMuwabLU7coR
         BBxCpC6waaj73/8C3a1kkpluZLJRlLFq87jnN5lntzPCCs5gxsJImZ4MYC/DkgHx+03n
         MfUI4UsIBMejHG87decTdY/zZAFoCVRzmF4rR9gVDBaSn1RcHJu/e6cZDVvclyhzfXBo
         mb03C5J6BWz4IMlbQL+zDbvf8PRzkngaHRMUfY1YP0/dJRfLkRHhnvNng6klYiySDybK
         GDhI3YMI0N6yL+iG+eZQay2aeYM92dtIzHIghzMf+X1osUVonZ2Dz13lwZzTPHRQbgkv
         gj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759940432; x=1760545232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzZhXiLzKKt9ijicdsXyGaAREF+VLijn+mpS3QdbwuQ=;
        b=SumXv3dzxTRzn0XddiJrJ99j2dTh3OCL7s1O4GY9y6X7lqDWQDGdRNfO4W2qJn8sSK
         JYYF72IgTsS4sMPT7ppxirs2+ZgY5tPx/60VXxPj+8DCil5trq1xJPMoXrgH9DwS54Rx
         aHX444bCaHrDcfpIJLs7R77rfZ57NBFJWKxrjv/31MzDGyQYVf8DL3FxeFYi3H6z4iiI
         UYarCIFjYk8G3XxDZ8NE8bWxAMbseHhOYk/mNRCl91uK+ul2W9Tay3sgOFeXjG+HVIKl
         siAi0eUIPMkT3WlcPZY+eexkYU3ERjiSslEHW1Tj41Mv53JHVdCvzML5ZlOZ2Bad2Bzk
         Sgjg==
X-Gm-Message-State: AOJu0YwfLxfl8taUlXDEY7EGl8TeXZOHpow+64FqnFXXSMB47nmPB8mV
	XsDbG9MQCcOEVVXZF6KrcoSOpsMioPR9IoQbnOinCGN4JNRVHHWN+QwY8lSd0gSEXYfFZUhJiY0
	34L69flw3JG0uMbajhfTeoO6Ln4Rr1G8=
X-Gm-Gg: ASbGncvSiIDGN9lseIlbUuQ6ylrUXF61I264q09GWYrVVU765Sn4u2KRXWospJ4je9e
	gVEnFaQEjh38N0n+aC6kvnbcSdrNgPVD7/UELnCXS1DQ/kLAQHcfJP+7UuPunNPiC+kJqF2PCsv
	wevrbCf1/APd/pwkkg+722kAas66h2vVqZApBbkdwseJLbYEnmpHpUqs6AbRQEMpbpf0yJOqGWQ
	YekjggaJHR8ROBxg4+uyBTq6LOxo+/IYx21qur3afQyoHLS1iYvGFa+IFy/JBbDjDVNGPExdYkx
	QUq/okl1t5Tdm/aVP5VoyPgDpfSwKlhG4jkXerd1narGlkE64A==
X-Google-Smtp-Source: AGHT+IFRtEpmUYO1NC+sl6QOX+ycPV+YRBQwmDD+/ZPRzUNkPTRekJQZRPUOeOECIkAwhtODxGST5I3Q/8aiX15xH4k=
X-Received: by 2002:a17:902:d483:b0:27e:f07c:8429 with SMTP id
 d9443c01a7336-29027215bd4mr28915515ad.1.1759940431715; Wed, 08 Oct 2025
 09:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008151554.340806-1-marco.crivellari@suse.com> <20251008151554.340806-3-marco.crivellari@suse.com>
In-Reply-To: <20251008151554.340806-3-marco.crivellari@suse.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 8 Oct 2025 18:20:19 +0200
X-Gm-Features: AS18NWAxIRHTDXe_UK4N5rbhlyy853rdCwdewKT2ZCEY4_Le0oNYYILFmF6Dh10
Message-ID: <CANiq72mt-RAH54KWmwh+R58OHsX31pQXc1cce7RgoBAgRpj0rg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rust: add system_percpu() around the new system_percpu_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 5:16=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> +/// Note: `system_percpu_wq` will replace ['system_wq`] in a future rela=
se cycle.

Please check your patch with `make ... rustdoc` (which would complain
here about an unescaped backtick) and others like `make ... CLIPPY=3D1`:

    https://rust-for-linux.com/contributing#submit-checklist-addendum

Also, in general, please use intra-doc links wherever possible.

Thanks!

Cheers,
Miguel

