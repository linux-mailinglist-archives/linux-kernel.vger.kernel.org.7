Return-Path: <linux-kernel+bounces-851459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01D6BD68E8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F2A18831E4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813B730AAD0;
	Mon, 13 Oct 2025 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NA23l4/P"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3BA2FB967
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392685; cv=none; b=PWvJ0+xOW9cHVWTLVJGK/KTM+9SovwFGgZ7BD3TZT0bHTLymRciHhulhN7Ufp3DHDaHt24elC1WP8YPHtnr0YOE93KPdG53WuTJ6x1Xg8vjnzIDv+/+jUBfheXmF0Do7zDCJq+nS6aPPUaG8igaAjRqFU9eHNIdE4tgwn3G038Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392685; c=relaxed/simple;
	bh=a34WwR8TE6Aip8LlUbHfNQGz2RV/O8jHdj1Ny6Rgbkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVSEL6W/W5k69arT0i9OE0g3laXval5PPQnn8sVoE31jt0IlRd/8sY9j+hbg25Lp1tnT92VW/ReA7zNW4eL/zLlt5OnrPl3NSpOvW6d4PgxYCwgqLfMOBaRoyH4u7UNxeLCTT9StXe9iK8TbxZSfkOMQ6dja5GcgvRutogoWrn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NA23l4/P; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b62e7221351so3836044a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760392683; x=1760997483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHuZLOyOM7eE9XI8O0kZg4fgFmCZ8ASKGqgY/QnK7/8=;
        b=NA23l4/P60PYJsDuxUJg1fonq4VSvJ5ZOcY4sPT61IUBTPVBh3fpvcEVLwc6IOI9pN
         0NpshEsnF2Gqavjgqt1zsqlJFNZbaOhy+dleeew6x1aTAloSRuKwBVRuNjPEYb1NmpFW
         DwBOhSAzc03AGKdyDUalOQAiK69F7im+QuioQZn6D1XCZNv9atc2HEwTRgfQ3YfvZG04
         jGUuxgWWnu5AT/jAvf+P4JX/zsSIrtQ134xMFCjW7Qh62MehSSp+Xpz8mt6QMSlXX6y6
         qRJziyYYgYpfflXDqOzzIbYcNi7q4c6cPcvXirxAl0RAPenbSVTU9vOZ7vTvsglTzHjL
         B7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392683; x=1760997483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHuZLOyOM7eE9XI8O0kZg4fgFmCZ8ASKGqgY/QnK7/8=;
        b=TLxUwUa7paGPmzQn2PUFeRmNERo/amcNKjHFr0rewm3FTK3B8QoD4y9j6l8NIA8HAn
         QroPtyrsVLwKXBOX8EVrJxR9KLPWqfiZWJrURUpHkLWJEV4ZanwdtJomr7hweQFwgnWa
         xDdcYXOGmb+zzVIeuR+y6jOBq4Ra/TFKEWV9WuMyo7ZacyXUA7L7gutNhOIYbRFGIsra
         vhsQIkAFuS8wT42FUV8xrdDbD609hC16j/MGtrgFkuvNLMpMGsYu+CPAyt8HDfrCRsOc
         VaUtRHyPO2dUxR5tZulNl3t+EJKGlOd+xcimpeHuxuxMUXmGk4BrYFflKlUoRLkvcKwz
         7qCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/q91ouuA9c8bUJ+g4EpetPGpvcsv/Ao0O2qwudtL64/47VXo5hqMq5uAsUxHQ5gGYOlHVUJtJY3HQtBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxcys4eAweMg4Fc5BvvRhgnhA8w/zoV+JnwzxhhjHihM3e63WF
	Z1/IvCf6Ft5j/JQRMn1Ahllm2xGCpi3m6Qs//EzXMaL1ua6say0SfvaN3vuNl4FPXHbr4KKGsIf
	Lp2+bd3q0Q7ho6qs0VTCrMHkIOeN1j9g+WWmfq4HZ5puI3XHOl1w28g==
X-Gm-Gg: ASbGncsQYtkuO3RhbjL9IszoL2l9I+PDKD6sgnABwe0fKG0jRYp5CH173cHxqpw2dfh
	9IES4QwsRiZXNOURXT8+mjHVTP/E31b7dxQ2zZUcwynFEFgKR9a9m0urzpspeHePzkCwW/fVs9T
	PdMkrO04ETrrM8rOIBmEkStzbflMBrJd+HhK+njHgiWUYEt6EPtGHvMb+HKfwbmOG9Ye5pynMkl
	sXdlwY0DkEBtCvPT8l1Wv6dhdvu8fgJySbF
X-Google-Smtp-Source: AGHT+IHlB0VII3A3IwzmNDnKhCczB+qBWIrTNLYC3M16p8OAtV0z8FLfkNPVTBLZSOHZq13gex3BeUt78NYZRp8U3sk=
X-Received: by 2002:a05:6a20:1585:b0:2fd:71cb:e8fe with SMTP id
 adf61e73a8af0-32da80da680mr30442372637.10.1760392682856; Mon, 13 Oct 2025
 14:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001215643.31465-1-casey@schaufler-ca.com> <20251001215643.31465-2-casey@schaufler-ca.com>
In-Reply-To: <20251001215643.31465-2-casey@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Oct 2025 17:57:51 -0400
X-Gm-Features: AS18NWAwjSZ_k0afShpLgHgWO3Dk4i9SeBTOoW8dS7ECmUQlZYriulh-t6qGbek
Message-ID: <CAHC9VhTJBSejFr78csXudG4xKW5hXVy3undDP-m8YdjhJLYrYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] LSM: Exclusive secmark usage
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 5:56=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> The network secmark can only be used by one security module
> at a time. Establish mechanism to identify to security modules
> whether they have access to the secmark. SELinux already
> incorparates mechanism, but it has to be added to Smack and
> AppArmor.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h        |  1 +
>  security/apparmor/include/net.h  |  5 +++++
>  security/apparmor/lsm.c          |  7 ++++---
>  security/security.c              |  6 ++++++
>  security/selinux/hooks.c         |  4 +++-
>  security/smack/smack.h           |  5 +++++
>  security/smack/smack_lsm.c       |  3 ++-
>  security/smack/smack_netfilter.c | 10 ++++++++--
>  8 files changed, 34 insertions(+), 7 deletions(-)

...

>  /* Prepare LSM for initialization. */
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c95a5874bf7d..5b6db7d8effb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -164,7 +164,8 @@ __setup("checkreqprot=3D", checkreqprot_setup);
>   */
>  static int selinux_secmark_enabled(void)
>  {
> -       return (selinux_policycap_alwaysnetwork() ||
> +       return selinux_blob_sizes.lbs_secmark &&
> +              (selinux_policycap_alwaysnetwork() ||
>                 atomic_read(&selinux_secmark_refcount));
>  }

This is an odd way to approach secmark enablement in SELinux, and not
something I think I want to see.  Ignoring the
selinux_policycap_alwaysnetwork "abomination" (a joke I think only
about four people in the world might understand), the
selinux_secmark_enabled() function is really there simply as a
performance optimization since the majority of SELinux users don't
utilize the per-packet access controls.  Using it as a mechanism to
effectively turn off SELinux's secmark functionality could result in a
confusing situation for users who are setting SELinux secmarks on
packets and not seeing the system's policy properly enforced.

--=20
paul-moore.com

