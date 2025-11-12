Return-Path: <linux-kernel+bounces-897141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A151BC521E3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742F7188A794
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1051E314B89;
	Wed, 12 Nov 2025 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LP45Rqtd"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E813314A86
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948264; cv=none; b=IcUrJonwv/bHyRNFcVY+Ws8RyN2Pb9gOG0ja4EoJ/KVPtOFX9F7aE6HjtnhjxAtmhF46H0/RZn4/bmtTn9sGgxa00U1UIFNL8Q9vh0NIwySOnIxD03PtiOvKhp1a7Sj+RXceXlRUTM2qH+kE/XlN2pkMCnqT3HTczJ+32LdofqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948264; c=relaxed/simple;
	bh=khSs2jIaNnzovstTr9PNEISsbMkAq+WBzKedqSbiF30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgPsOFrP27cuo30bSVlOqJxHwIFXZXPrcEEWXqcdQ0BD5Lo4q+gWwzbHtPMwGucsh7k8HmZ980uvRC8eBGLADCCgLWbCq85PHPNSNUfTtI7EHbNP+svBeRqtntJMnitNkjt4KHBQmoXDY6XMT+GhN32/8T27BVZbIr3Bipb1muE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LP45Rqtd; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5943d20f352so713590e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762948260; x=1763553060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khSs2jIaNnzovstTr9PNEISsbMkAq+WBzKedqSbiF30=;
        b=LP45RqtdP9ja/fJcKuSVRF3sBGMhAj+rL07FcD9JBx1eTfcH09INjFvijwMs30wAGF
         YMwODelXHhMjhx3SWGSECmSi8Y1BugrjEtsHApTRfE+5TPzLlcB3T2kdMBEkf7oz+9dw
         BGxo0C8mQjKO8NJ9z4DqofMF5DGj0aGQrx/+f59dCV04UrjkzthpZqFaallh+cjn5XgJ
         YH8nfV14g4D0ronWRMJKwtXBMu0x/CemjvInAvCQyQoJueTjjdtHaNZlRSRa+yf2ae16
         H9hiZ9pcf+oH2aohqGi9+fDSDRxyZ0X8ZpjCrgn3iZBq0dVqpkVk3ImJAgu9yjSMVo33
         snsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762948260; x=1763553060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=khSs2jIaNnzovstTr9PNEISsbMkAq+WBzKedqSbiF30=;
        b=MNhXc7CfmFaGzzxDUPMCE1a9v4mfwUdVQW6xe0/lyHgTNxwy+KsFqRCBq4qD7mspQD
         a5mERJswD1FHGykKn7sNoRAbWEgzb9VliKHdPGixDykceliBVm3qvgz5ipgvgvVehaSc
         F4uMKlqd6zqwXLUHI+9St/Yrd1vbR1eV9tz3xpVOBHEaZ4lS525iECLXLnZAAKGXKJ4y
         vymEbGahXeWDWZ2PhNsR9OOQDIjxVnvZj2Y0v9w3OYMIL/gejBcO/RsHkKWf9hdnFMd1
         2TYO9w2qZx+CusVu2S5pGeUFlY7kljFrjTnDs3KuqM7kUVfPu3soy4vyIPH1nahtw9du
         kjiQ==
X-Gm-Message-State: AOJu0Yyj+cpDYpdy+LcrapByG3kw5/ULd+8GdOCA5rgC9dd8+GPnfAei
	n8Gt838X5j6J1NdNcnQgnseGi/J2nMqK2PFjVlHcH71Ed3oB9n/FifHbiNFZ+4jPskNnVqi1QeR
	zQr6qpNIYgcEnebnTR9181Zf0mpfqb+OFI4oYo3owohxcoyS8myBf
X-Gm-Gg: ASbGnctnaftBv8euL2W2f0cioEsPDtpoH+RNr+XqY/bzhp//2BSFSRIJNgTuDuDQYvG
	qt5/uJHlfOhTSkSdn3xaHUB4BUZ4tCSRaVeKhXubyWZJw9DdRbWyG3+7c+RjS8/m+qRBYr5zCpY
	1FCT8/AlDu/fmqL170DqYQUEzNtlTYzXN80KS8VmCEWGJTpH1HoU6KJmH0G6Zqt0LchdMLcBc/g
	udQIDBxJAAcXMJVTZ9FKRygar7HJDGcUFKGWqQFG1b7nGzpCvhF8nf7uXy3DSYDtfyHNj54MGeN
	Am20POIsScrzhS89dw==
X-Google-Smtp-Source: AGHT+IEmrTGoE8kIxUupzcL3o/ACNi9/u4VX1vbVB8YO3B3Zg98bKfvXKx5KfyKYdU8TIau8KPlDz+YmTm7r4eO3RnY=
X-Received: by 2002:a05:6512:3b27:b0:592:fff6:b21e with SMTP id
 2adb3069b0e04-59576e09d77mr876640e87.20.1762948260395; Wed, 12 Nov 2025
 03:51:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107141654.226947-1-marco.crivellari@suse.com> <CAPDyKFp9ugYVm4dm6JkHV8z5Tudi6RWbLk2NrkPA26nCbawP5g@mail.gmail.com>
In-Reply-To: <CAPDyKFp9ugYVm4dm6JkHV8z5Tudi6RWbLk2NrkPA26nCbawP5g@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 12 Nov 2025 12:50:49 +0100
X-Gm-Features: AWmQ_blucbv9Z1Lf7SgC596nXzZ7zOuGuRbvDnJLSM-Fwvch4tzK2EHthRN71jA
Message-ID: <CAAofZF4TKr7Tdd52DamxTP2qoebGOC3J0FSrABJLG+AoSwaouA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: add WQ_PERCPU to alloc_workqueue users
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 12:48=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> [...]
>
> Applied for next, thanks!

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

