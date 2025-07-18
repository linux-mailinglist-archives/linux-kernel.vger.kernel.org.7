Return-Path: <linux-kernel+bounces-737016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04696B0A6AA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BFF5A57FD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46A72DE1E5;
	Fri, 18 Jul 2025 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3J6d9SCj"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CD51C5D57
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752850412; cv=none; b=YQbCr6knuSc84MvHQIegeGltZdmtKhbOOmZjPqT0ikKKyqz25CYwcFwk28POCk7iAAg1MT0bIapo51o/AXlUTs4XsRWozOuPu+6PNfCEIFeQGXH+siz/l+tKsv+PlkVHI1gSqZH1b1fqXp69wbbU8Pv8ewgd4y+6OQ+4dvUG6ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752850412; c=relaxed/simple;
	bh=+cz4HCPr5tjchC6wb2VLVqvPWbpYeCdVtpSnQppLTSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hY7/1TtoU2YC6on5xaFJj5j9tEcZpxjBTl9DbPhQTj9QRSF/o3C3jciz2uFfEQc/qh05vsLqqHdMZHgXuQ7VsgDrKt1EqSiKQ11kvbN4nfS29aeCe4CCMwakZIS5SB1bHYfPKUIA6cIIjJofomOrB9q3uBuN8uD3b2Y2oOJ9Qzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3J6d9SCj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso9799a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752850409; x=1753455209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hzBLC06b+5l1Jibi7tNWcnqjU2kBOrH0ilPtK5Nqww=;
        b=3J6d9SCjRHdZJtVgVlLOflA9rtmh8HrYLIyP2MO4YmnSiqCAwIkfJR13ADdLXt324y
         zRqiVa8o9ULQX3LMUVvGdIrU7wufoJUHLrgjtBCLFV7+MzFxvxJB4ym/dh33Am6fhKzi
         6yoxoN+tZE31hBU4f+X1hvJUXbpvWiDgV5CXYrNiXSfJNs4FbGS65KYImpP+U6dbA7yG
         +7n6GPljBmNgRUja+n+Qgbw6iSnBVQTdV1gqB+D+h35h5YsdA6NQIaDumIgpldhUp1Z0
         zEnjuT5I1M97ka8yaixU+xjPvQ3CN9QFMQSZT+s0VBnZuWCtcNo9g8jOvDZgkr9Ym7lA
         n1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752850409; x=1753455209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hzBLC06b+5l1Jibi7tNWcnqjU2kBOrH0ilPtK5Nqww=;
        b=bLjsHZgM/I4N2bhR4IMiFyl++l1/GpEt8WsqlQRaC3srHNaBJhHzAHwcR7I0l7eb0v
         XjtqXxi6T0sFNTjsV6U2crR49wErfAD+MLrC8b5ZQKjG1P5Paau1w5Uey+WzstwW/tPw
         cZhcq1Ea6YBWrbjBeBOqRHiwgugTsLZq4XgN3iMjnrkzmXLyQLY3cM+pDXAvnGzIHpAh
         dAjNUTUCkDX+wlHG6gx8/Ngu5rpDoRU47uiEJhwWhlMu/4o+eaRqkxN6eo7vD9YXMSds
         OsRsRgQ8betKJqDLnEQ75XK7C5NQOosBzaueIDsQci2y4UgWGoJuei9QyUnHy71YS7+/
         x4fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaY/WLBgHMzGtzhDeieNbxSCTnViPJWBnXW5SBm6PW6/bG0s4IWwS/ULx/BzfEFjoBY+p0wCmJmLDgB20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMd3s2PgSfAr4861DQ5dfolOsFEiYd9B0FyIy9DBDPXqDpu1hS
	VD1XZ7Et3jLRw4kiEWYW9wJ431t0o7rCICw7ckIhX5+AYFitWbesbrU8YbJ4jhzCj1u2Wy65XDB
	3N/iER8SR8jXpukIsyMYk8Pfv+icOulJuJJN507AM
X-Gm-Gg: ASbGncvLnFdkk5t7ZYEeD6Jd5bK8XRfPZo2OGUWXF9DZw9ORJT6di9UU1oQaqYTTrk0
	fpmsMFXr+yI3Jd8QPcOBNi9Vk5DNwQznhPEl54aj7gvnQ/Wr853japE3aeKKt2CIWbaEWnt/3o9
	RpunLYmFSf5TY3zfiX2oe1d4h7XokgPgSsvDYDmL6tIW4NHuBk+stC8VP01ZDyjADeZTiKlv0+5
	HZrMtntbaDXzA+0U2PPR37jzthgL+9oEhsRUMdbB2E1pg==
X-Google-Smtp-Source: AGHT+IHhIPDeunFBo1vWbIckgOjZNTBX+72Iuj3bDcvIABI3tBDgDiU9nGOHjPKBy83vW/xX7fddjk+XYV/k/HG0dn0=
X-Received: by 2002:a05:6402:31b6:b0:611:ff6c:50de with SMTP id
 4fb4d7f45d1cf-612c234e830mr103625a12.4.1752850408383; Fri, 18 Jul 2025
 07:53:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718-yama_fix-v1-1-a51455359e67@ssi.gouv.fr>
In-Reply-To: <20250718-yama_fix-v1-1-a51455359e67@ssi.gouv.fr>
From: Jann Horn <jannh@google.com>
Date: Fri, 18 Jul 2025 16:52:51 +0200
X-Gm-Features: Ac12FXwt7R8GLFUkdtizIwT7mYdidtRUy78w_KziKqUlTZowf2o8kv3DmkXhuRM
Message-ID: <CAG48ez23HLtb9GJ-BbSXaWFhdPjXyFNED9fbuyaNP5EXJ_Wv8w@mail.gmail.com>
Subject: Re: [PATCH] lsm: yama: Check for PTRACE_MODE_READ_FSCREDS access
To: nicolas.bouchinet@oss.cyber.gouv.fr
Cc: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Olivier Bal-Petre <olivier.bal-petre@oss.cyber.gouv.fr>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 10:47=E2=80=AFAM <nicolas.bouchinet@oss.cyber.gouv.=
fr> wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>
> Currently, yama only checks if the `PTRACE_MODE_ATTACH` mode is set
> during the `yama_ptrace_access_check()` LSM hook implementation.
>
> In cases of call with the `PTRACE_MODE_READ_FSCREDS` mode, nothing
> happens. Thus, yama does not interact properly with the
> "hidepid=3Dptraceable" option.
>
> hidepid's "ptraceable" option being documented as follow :
>
> - hidepid=3Dptraceable or hidepid=3D4 means that procfs should only conta=
in
>   `/proc/<pid>/` directories that the caller can ptrace.
>
> This patch simply add yama a `PTRACE_MODE_READ_FSCREDS` mode check to
> enable an interaction with "hidepid=3Dptraceable".

Please note that PTRACE_MODE_READ_FSCREDS is actually a combination of
two flags, and the intention is that the PTRACE_MODE_REALCREDS /
PTRACE_MODE_FSCREDS part of the flags should basically only be used to
determine where to read the caller's credentials from:

/* shorthands for READ/ATTACH and FSCREDS/REALCREDS combinations */
#define PTRACE_MODE_READ_FSCREDS (PTRACE_MODE_READ | PTRACE_MODE_FSCREDS)
#define PTRACE_MODE_READ_REALCREDS (PTRACE_MODE_READ | PTRACE_MODE_REALCRED=
S)
#define PTRACE_MODE_ATTACH_FSCREDS (PTRACE_MODE_ATTACH | PTRACE_MODE_FSCRED=
S)
#define PTRACE_MODE_ATTACH_REALCREDS (PTRACE_MODE_ATTACH |
PTRACE_MODE_REALCREDS)

> Combined with hidepid=3Dptraceable, the following behaviors will then
> happen while reading in `/proc/<pid>`:
>
> - "restricted": A process that has a predefined relationship with the
>   inferior will see the inferior process in `/proc`.
>
> - "admin-only": A process that has the CAP_SYS_PTRACE will be able to
>   see every processes in `/proc`.
>
> - "no attach": A process will not see anything but itself in
>   `/proc/<pid>/`.
>
> It is important to note that the combination of "hidepid=3Dptraceable" an=
d
> yama "no attach" also makes PIDs invisible to root.
>
> No access reports are logged in case of denied access with
> `PTRACE_MODE_READ_FSCREDS` to avoid flooding kernel logs.

This seems like a major semantic change; I believe it essentially
means that commands like "ps" stop working entirely on systems that
enable hidepid. While that might be desirable in some scenarios, I
think changing the semantics like this without making it opt-in
through a new sysctl knob or such would be a bad idea.

