Return-Path: <linux-kernel+bounces-836540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7ADBA9F79
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8F0174674
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A5330BF5A;
	Mon, 29 Sep 2025 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFJUZ6ab"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E572309EE8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162263; cv=none; b=SdB1h/99nuxB4cZ1DuEDLcSa9kUzrU3iyTHJJhXWIqEWaVFJ1VOswWJMJbDHQJN9xdQbJ4BvLWOIcpU0Zp6waRMQrC1J+9+ZDuNf35gosYSYGEvY0pA1v1bgJZyFr4606yWlQQR7x98RCsscc4hwQxJ47qdhIW1EU+HZZatcPMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162263; c=relaxed/simple;
	bh=TnRd13LTY/MfKHuFsX9dGJLSiRHknR2IKwuhqq8+DcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1PtV4e3FjAfGwrsAWSd/LMMjDyz86dpqR9rWACsQ1JLguagwbvjFhI+BQ6FpDWPwul8HYEiHMqLZe57/HEo9GPuA4laoTiyymlnuXgQeku1mg/V6my4A8OrUNGOEjHYJf2alHIyyQGh2i9fb2AUpp6afrpN4CZ0o0Rg3qnL9c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFJUZ6ab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4441BC19421
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759162263;
	bh=TnRd13LTY/MfKHuFsX9dGJLSiRHknR2IKwuhqq8+DcU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DFJUZ6ab25RklS9kO8oV+tivtUHwZbSDaUluINK09aygf28NgXYFZ+PI6YaW/JAv+
	 n3z/M3Wo85Nqdoz4psMCxK7E9r03URDojGzc5qPUCdsnXuoF+UDVCDRrNU5gdvvJpY
	 koHbVdbYYxCIuUnxIVJSwwrArrLIfJ8HCqismRwWLlhECRDwGGadxd/RSf55sPK1i7
	 x7VzBbBTmu/EyS9V5qA3ndYOOORON8gyac4qn73YqOt3O7HNOBL3s+vfDb985nLifb
	 WdgxuSM4jEcixnsDoLy2NYcWZ6dPxp9zyNvj1+Kb4bhMdIb2qfqwlPOzbnQVZ6+pPF
	 RnAySxeFdHwrg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-363f137bbf8so47058671fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:11:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlPFmA9Oz2QzDsgekgla8cH7cim3ErdhVigIxWB6d7i0/eK1bQ70u8MJbhCNxblkTvph0QhROvV+vtEA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO3XPD81Aza9cCjBq1K72Yu4TsWy60hnqksU8LnELM3y4hCGQZ
	vUYEg+HNHOyCyQ1oJ5n0FlMWTj6CKDw/2uVFG8Rv3bvr/eXcimgeXPqkUnepTkWaAxSXArm6J7H
	d4oFaTSMZBGYA995cA/xP782oRC1GX88=
X-Google-Smtp-Source: AGHT+IETanXcswW69UMb0c9QLJbA83VZbKW5ySv3KY5vq4DrpUIMFVRtBjjjKR6of/ifN5P4H0F2sjZNeyUHIEGCoZI=
X-Received: by 2002:a2e:a917:0:b0:336:9e1b:b640 with SMTP id
 38308e7fff4ca-36f8020caf5mr41859811fa.24.1759162261600; Mon, 29 Sep 2025
 09:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922130427.2904977-1-abarnas@google.com>
In-Reply-To: <20250922130427.2904977-1-abarnas@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 29 Sep 2025 18:10:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHfDVXXZwFhNk=b25Uz6aVDW-NmNHJdWGOzy6j=YpKsRQ@mail.gmail.com>
X-Gm-Features: AS18NWD4BtMfXpGmuN2UIzHJaQT_CZZXKftd2Kvqw_-tFPRBtvNfc-lJsFN37gc
Message-ID: <CAMj1kXHfDVXXZwFhNk=b25Uz6aVDW-NmNHJdWGOzy6j=YpKsRQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] arm64: modules: Reject loading of malformed modules
To: =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Dylan Hatch <dylanbhatch@google.com>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Sept 2025 at 15:04, Adrian Barna=C5=9B <abarnas@google.com> wrot=
e:
>
> Hi all,
>
> Here is version two of the patches I previously posted here:
>
>   v1: https://lore.kernel.org/all/20250919122321.946462-1-abarnas@google.=
com/
>
> Changes:
>   * Renamed the parameter `is_module` to `skip_dry_run` in scs_patch()
>   * Moved comments to module_finalize() and improve justification
>   * Instead of rejecting all modules with callback, reject those with cb
>     pointing outside core kernel text
>   * Replace -EPERM to -ENOEXEC when rejecting modules with incorrect cb
>   * Fix missing return in apply_alternatives_module() placeholder
>
> Best regards
> Adrian
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Dylan Hatch <dylanbhatch@google.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
>
> Adrian Barna=C5=9B (2):
>   arch: arm64: Fail module loading if dynamic SCS patching fails
>   arch: arm64: Reject modules with internal alternative callbacks
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

