Return-Path: <linux-kernel+bounces-848397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3D4BCDA51
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913CA3B290B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582392F7442;
	Fri, 10 Oct 2025 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CAxjFQoS"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FD52F7454
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108275; cv=none; b=LnQTE3FgKwQaaGnU1szWwcfAnGiRDbeYtRh2qUMsvrpD3CbzEAXkNNSQkibt4FlIU3IHgBTEprKAzb2Yq/SKyXXcep59+6FkurVVIrXS7rP19JJyUlG4E90pX9e2/kDMHfsh/6yZyeWmjLvl1LF371IQJ/BWxLSRho9Rf7Z7Hag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108275; c=relaxed/simple;
	bh=QQVYa4ebCX8v8+c+fDYRRGNE0jM/1QXakKg6oLLEBx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cogFbTRZyR04fVjnE00wmeroQ19Stnwnh5fEAQiTDY/G6megDYnxeKnbI7OuqGzw9uj5oPe6CoYZvPdoY4Yx8dElVhExmMMGx1ayx8gVK1aUHunLiBQ3bqdz9NOEMdDEQu7EG6KNULIxlF1QfS8RxjHAwSxQAwjEi5bhIboncbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CAxjFQoS; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781251eec51so1911324b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760108273; x=1760713073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhktQ9njw3xUQQNiviiU9j7Lv0g4dtHdRAIlg2dWPdo=;
        b=CAxjFQoS/jb4TMgFpWob4hN+EWlm06MxLcWp3sBs0aS+t66J7GzQ17+8CC5dQwgoOM
         ZUQ8dm/H5l8PXcTNEoESIIFiJZOHdZ/papHwKdTEZULt3l4v4l6vxRzRIZI7gjBbOmvH
         Sdg5M/SwQAnA/0tjDna5p2Ha6K+jSMzyXKknBq6GLTlBwpmmdCNh2HWbT0p5cNFF2Qnu
         angK9QQL0nwYh+COink+kqkvgcNAK+rxsap8OjiiFjFojOAJdUzrMY36sVd3HDGbrU29
         XNdsscGIbv7ujwfp8M6YOntytm4sAPNv236n/3iDtEV0ZPi8qxMYoD6Yz7UnKMv0dMON
         8jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108273; x=1760713073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhktQ9njw3xUQQNiviiU9j7Lv0g4dtHdRAIlg2dWPdo=;
        b=qrKjMI14OSzSPQpDHoyBjeX3j2cu4JMa1TFTEkLBGMhPypeBNuhCo6mlJaHH9w9aSQ
         SfANb0n0EWlo4cSAJtvQBBu/HYxkdq0MNBSvdMV5E2UYAKS1Xq4+G24ihnvsvU27TIe0
         yjHMfcgT0o7BCvjczDs1fvxfuf70Fcis5kznliSdhcAl3w5GOMh6oQ9ZooGB6MHg9koG
         spf2UFwbbN2XDbimSzBfqWAuCC8fDhZqAdSQzhIUT6PcPNIEr/eRqSDV+qGaPKuDG3Hn
         MHoGQ/uB+qzfn/2KB9KarqoYxgdlkfoKfL0HACiKYZ3aCicqkION8z2DH3LpPPjBU4Ay
         kh6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHpWTgoXUQmr2BU9qpMOO0Py1RX2MGiSOm03ddzcEyVcNZifk3ETKtivsgykuxpzDGK9cyxSIL0XuPYKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDAet++l1S4nUQEt1TWpJCF+z8eqE7EZloaygOqKtvoU5yX/xh
	CblB4bgrshPIRGoPE4sC14KST397wix9X76rvzLC+BSZGEJpm24nogMjU/e6T17TsTMjXatYGwN
	QETyDLFB5v0TEPhRorJHv9d+GwCp50V7vQfcrIkVn
X-Gm-Gg: ASbGncuF1GnxoogGg74qSYZTOhYHWezjOb/wz4cezB0l0nDe1WZTWv6asNittbhFPSI
	DWyZN+L9Wb6zDCwWnNi+HOCCLtLIoIzLmAoKNzQIfBSjAsoUDzYKL5IB2P3ZwifmbwpfnZaS2Xj
	qNaMfOrcl4rDtoht74wlkoo3geF1NWAqZSWDqxj2jEDnn+Zfqs1ufKGAP70uJhyM9gZCmPAw869
	5ABqELGUIO5wPsHdRFzGhqIBz/R+mT1Y7HE
X-Google-Smtp-Source: AGHT+IHkK8Gm9viP+PnMJqCf6YwcaiPSZAhk2njG3CWT6nK+53DU2FspPpHEd0UmuOb2fdMKjhpGzmFzl8fSVbMyvcI=
X-Received: by 2002:a05:6a20:6a26:b0:2e3:a914:aab1 with SMTP id
 adf61e73a8af0-32da83e3df1mr15879251637.41.1760108273442; Fri, 10 Oct 2025
 07:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010132610.12001-1-maxime.belair@canonical.com>
 <20251010132610.12001-5-maxime.belair@canonical.com> <CAEjxPJ6Xcwsic_zyLTPdHHaY9r7-ZTySzyELQ76aVZCFbh8FMQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Xcwsic_zyLTPdHHaY9r7-ZTySzyELQ76aVZCFbh8FMQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Oct 2025 10:57:41 -0400
X-Gm-Features: AS18NWDDlD9d-obeXSKEgVeXrkg3pQGOfVLXHTxpEsZnDxFwMdZ6CYaIkCq_crw
Message-ID: <CAHC9VhTSsUf-XJTNSxs-7DeAdR-0uBfL7reZnjMXhma3ZSOF+Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] SELinux: add support for lsm_config_system_policy
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>, 
	linux-security-module@vger.kernel.org, john.johansen@canonical.com, 
	jmorris@namei.org, serge@hallyn.com, mic@digikod.net, kees@kernel.org, 
	casey@schaufler-ca.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, song@kernel.org, rdunlap@infradead.org, 
	linux-api@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-kernel@vger.kernel.org, SElinux list <selinux@vger.kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 9:59=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> 2. The SELinux namespaces support [1], [2] is based on instantiating a
> separate selinuxfs instance for each namespace; you load a policy for
> a namespace by mounting a new selinuxfs instance after unsharing your
> SELinux namespace and then write to its /sys/fs/selinux/load
> interface, only affecting policy for the new namespace. Your interface
> doesn't appear to support such an approach and IIUC will currently
> always load the init SELinux namespace's policy rather than the
> current process' SELinux namespace.

I'm distracted on other things at the moment, but my current thinking
is that while policy loading and namespace management APIs are largely
separate, there is some minor overlap when it comes to loading policy
as others have mentioned.  For that reason, I think we need to resolve
the namespace API first, keeping in mind the potential for a policy
load API, and then implement the policy loading API, if desired.

--=20
paul-moore.com

