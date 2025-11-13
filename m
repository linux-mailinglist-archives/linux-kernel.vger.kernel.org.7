Return-Path: <linux-kernel+bounces-899800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 362B5C58E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E4FA4F19EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F43C35B14F;
	Thu, 13 Nov 2025 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D2KIlBds"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ECD35B142
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051080; cv=none; b=RB2Lv8AuUEZa9jzhbXG3j4z9iJknF3eYnUJmBIWF8X5i+VcLfsETcGvvTnoLzKZZQCV8bHWqbtRE6AXCeJtnzmAdHKtkjqv3YRQqZQqJkdys50jW2BLKKq4QCkOF2Y7Mw6XVIyDul2cyHsFWNLAOzuP52297aKEwfMzaHkp2P1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051080; c=relaxed/simple;
	bh=aeVmA8Pr92K0H3iROp7gH8ySG1VZ3qmx/UfHcCZzabI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEOGdrYMbZ8iuqV/qcmlZ8rNIo/M6Q/p3glIB8gmePPWnsv8QRczvsuXXgfTASz32vzA9gYuUHE1OOzXpo42rsqZJR19K74gNKONUMdFpR2LQnt7wk6je4SzT4dlolYkoS96aeg+kfWLLeXxTN8ALvNrVaQ3LxgfiU0Z1UvFQ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D2KIlBds; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-594476f218fso787941e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763051077; x=1763655877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1lknOy+g7X+WANvKXEUsNPHel1RfvJ2YmIlYIxgr0M=;
        b=D2KIlBds56wIptSYvoPtNnD52UDjtWYobQF37C0KEF00ycy5MMG4JiG1hqRB8+XT92
         fUD3avPhlPYXEsI1aP6vy1Pia+smJ8LaeCtQaGQoADuzrlZ/W9gyNk3R4yqSIXYfyWN6
         DjoBuS8Oqdix5dAKOwHKaVfUkNuqUkaOXrUa9StQqBJKtXfNVnSiq3Cfd0w38tkKhT0V
         uVy2gBhJ2wFfsGR1FOo1K1Do0YrVnPAdQoSyS2BiLPI2Vgl8gJlLg8bEQM99dqEfKURS
         cmIeCBxW1f7v43L9fmFekvcOKDYW2oPhsb5GmInj57ll3A4Uep/atUS1jME/3BlRgnoW
         39oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051077; x=1763655877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b1lknOy+g7X+WANvKXEUsNPHel1RfvJ2YmIlYIxgr0M=;
        b=jsDoEoq7pykcxBO6fwncTKDLNUOromnFg60CopOWG4p+q+chY97Kq3Srzt9upmPziq
         vTXlWAu2Uahej/HBLMPy5RsP53A8cxh7wLlTlpy6npfhqa5A3m1NkhwNjqpO5qxA+bc1
         myu4CkdOre8XSvceeXCucU/15MNgmpjIhIwJLXvcBPF6BXQpwqwRw85J0/b9N1jUjdJ2
         Bj2sqPVhKa07fA4uuIlAG7oNwfn0cYX9sf1RQ+dDhsR/npbnbKzuDHkgeu9/VyPQ27Zc
         SXrL0bKOh/J6FZ0QKr9ACVPaG4TBPkDarLtje0gDqNGXEfHPG5I56tAebHn81XaAiEU9
         4LkA==
X-Gm-Message-State: AOJu0YzznKbhpw2Em2l7NnlPBU+6SNnFG9hmgefwnVVzZ3+stWp7QSQQ
	ykeJUQEa/bw3YVuWwlFBEj0Zdh7y8VFUQjjT2MNV5cBO+B8LR5GB4LFQ0VWplFz4teTsJETKvQi
	clMWoH0pe9TQ6OySj6iCBOG5fcQjO/mS4D8UHOqHcHQ==
X-Gm-Gg: ASbGnct95325uoRD+lSWpvj+aAskBgepZUabkvipP4Zj+AmXBoDbKOl2dAjnzx0exMd
	6GfPOCAWSbmwTAiHBtQVBF++T+TqMx8Ze/fpjz+ntu8oWicU7pILrHiVbnmfTcfF/cJJVVTFjLv
	q0qBaXhgdtgjUuz+/lW7VGaRWCNTlQqHv8v10SOzsCWJelwOz07rmL+PYj+NLsZ3D9yBbX/7/oL
	KtNwUhbbMAfZgH7VKG/7Y7/5SVPgmUowdIFr9pkHHaRFphi/JWKCXDx5ZiDbvTtQsjofiO02VA1
	PXTZidpEvxGp2ceMUA==
X-Google-Smtp-Source: AGHT+IFodDdmDF4OGIpR/wS4dGrXhmEdlZZmBi+Eep/VRxdV/hIiOL+UeuLXUUOhkIo/i+h/vdsVzGczBZsRa2swZ7w=
X-Received: by 2002:a05:6512:308c:b0:594:3311:1e6c with SMTP id
 2adb3069b0e04-595841e601bmr31650e87.32.1763051077082; Thu, 13 Nov 2025
 08:24:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105111924.141555-1-marco.crivellari@suse.com> <176304937940.1554738.14671753263913309288.b4-ty@kernel.org>
In-Reply-To: <176304937940.1554738.14671753263913309288.b4-ty@kernel.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 13 Nov 2025 17:24:25 +0100
X-Gm-Features: AWmQ_blXPA8QEo01XWRXsor7LUf07lJZK03vUO23wsNB18k5wcBtaYpHFDH7Bhg
Message-ID: <CAAofZF4PKmWYU5jj+8CuPDp6P1CvtivqESFAYTuTQ-Hucukr9A@mail.gmail.com>
Subject: Re: (subset) [PATCH] leds: trigger: replace use of system_wq with system_percpu_wq
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 4:56=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>  [...]
>
> Applied, thanks!
>
> [1/1] leds: trigger: replace use of system_wq with system_percpu_wq
>       commit: 88aa23c12888348bb4910e75a6088f0affc86923
>

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

