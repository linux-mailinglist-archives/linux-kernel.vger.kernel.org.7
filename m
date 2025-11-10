Return-Path: <linux-kernel+bounces-892776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 312E5C45CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D6B64EB86D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0AC2FE578;
	Mon, 10 Nov 2025 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O0kz/qFH"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C30234964
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768706; cv=none; b=OtMcr4vYQQkvPYjSea7FRVUxFtd+GSpzJcWRuFkgfhszej4lExS+36pW5yW6dClKDo4o/PDhIhmkfyYBhTt7tsPDxBu1Ngf3LALfSOKWVZAKazvxjN/3GhScTYsR6wOXMJ9XoNqS9lWT2p9tcoeX8YmsGnpGK9tyC0RicPLQSas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768706; c=relaxed/simple;
	bh=Pr1wJd/7uGgpha5iPQ4Q3WZe4ih/H/T0063vCmTBsVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r33Qk4XBjTo6rJxMTuB8gkPfYeGElyOU0DfrGLkw/oemI5trnMWCR8YPVvo+/Nj7/SaYRXy8c+lrg+Tcfgd5oPgY7VhTqOkJVN/pGzfSt+UhEK43IkOybQiUzLeOlVkBuHGipSJ68+5WRPpzq6SWUVbRfysXDC5Km8dlWvp7EWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O0kz/qFH; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-591c98ebe90so2925476e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762768703; x=1763373503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pr1wJd/7uGgpha5iPQ4Q3WZe4ih/H/T0063vCmTBsVQ=;
        b=O0kz/qFHrNKb5iwf8nkrqE6EJDPyvFZh/dKJPVOfRjD6JjsrwVdkmqTUcyen6nrRQQ
         sbGobThUSA6/jhOAqnxZzLK7EDyA9f7tVy2iXvIfaxMcHiujI/6UAegwF9dgaM6bxshO
         xUp8Ee4ZjNqMv5R/3eEMUJzbJqviGKR28pkORfiNWDpeKz8XdUHqqzGv77kKTfhUiczu
         0i1+kZz92AwUeFS61/4/CIEuYg7yj2Kj37ZCFZ1DE6Jb+9qn3T7+mjxoaVlvps7gnV2/
         geziC8jlJ45F/HdnusZAomkSq+U471LAHj8+1KWt59SZ9avggebvss00zdGsx1h3S88s
         5vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762768703; x=1763373503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pr1wJd/7uGgpha5iPQ4Q3WZe4ih/H/T0063vCmTBsVQ=;
        b=T+N5KZAjmMEfQrWtU1nxnMnzvduA16KIV7cfi0vyXMrVytxFSAdNjmPfwr3/cly1yQ
         pecx10tNHrMmMXOALUQkfXDfikHSNwhWtrEfmKAAOeeju+KJyDph4BeLDUXjHeTj1FK8
         tnRrN9Hf59B/fzcXFBxT3SsfU3E8DAC6af5au+ANL5xRs5hvRI6vUcWsG5h9Y4peULFv
         DApQXcVgmf/fBiLE6HMJ95rEgzg7coUF78Q5iOOkfX9F9tZ5YgPfXhn+6C2duTLolu2b
         lCAN8lpses2TUQP6RzdB1nCa4B7ulWD1WpchmXJZ0kr+U4xw5U6quIXwK2XcCJ9hk+zp
         kSWA==
X-Gm-Message-State: AOJu0YzhWI4LhBbvhKavu0Pz8RrM2b2DH0tQtpJxZTvoJWo5Z5kjnsbv
	h6VE8NfKWCteHVoQ+gySumMp8zvJF+Ua4q4c5CVnt2M3hO8HGPQujOpczCzcs7CNm+bkoxZoNVI
	uLs72kp3/3wgfl2/vk5UD+KrXXrOfQz/GzpBADVWXdQ==
X-Gm-Gg: ASbGnctQxJgcAanr7V1HtNLtdfiZRsO+VWozYuWs8JG35VrDOsWoXwVemz9mO8EgMDi
	ctNNTcxdRgDSyiErf14R7CpXkINpB+zILqZpYRpVA5VQabvbXV7vqub2U/FZ/fd6hNfQzSdLVhd
	iOnPrJ5eWy5APyvKcvZQk7MOe/vHZEGgTl9wN246oINJ+yL+rcVlmEJpyZx3QxlKeBT6W11Bgaj
	1TFcAwqvbuw//lf6dKASpNZ0i8HVnqQwt2DjMh7fAlUfBh944nV0gVKZHZd6bKpocdjsyrxDFaO
	HUzdlIADNXrLafOKoOdJg8xEyuzp
X-Google-Smtp-Source: AGHT+IH8nzVycdeOgzQi/3FgjBc86W9BwlRBJUJ1/mzPe889ufxIQJ9HVlvKbWPBD1jcEM/roczq0ZhI9VyTgtrOyjM=
X-Received: by 2002:a05:6512:3d04:b0:594:2df2:84ab with SMTP id
 2adb3069b0e04-5945f186cb5mr2251235e87.8.1762768702626; Mon, 10 Nov 2025
 01:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107152950.293899-1-marco.crivellari@suse.com> <64df8b4e-6cd4-49e4-a0f9-c8f9c017b06c@csgroup.eu>
In-Reply-To: <64df8b4e-6cd4-49e4-a0f9-c8f9c017b06c@csgroup.eu>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 10 Nov 2025 10:58:11 +0100
X-Gm-Features: AWmQ_blCrzzwtNXT5OJKtaKmerZRqaCu4AKrtikaapFNCbK_j5LVXjJ3X5YXl6U
Message-ID: <CAAofZF4QD_vAon4CpHPQCPpgQpp991QOJ-Zd=Qn0siaWz+jtDg@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qbman: add WQ_PERCPU to alloc_workqueue users
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 8:44=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> IIUC this patch is part of a wide work on workqueues. I assume the will
> go via the workqueue tree. Let me know if you want me to take it via soc
> fsl.
>
> Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Hi,

Every maintainer is using its own tree, so I think it is fine if you
use soc fsl.
The change here is indeed under soc fsl, adding explicitly WQ_PERCPU.

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

