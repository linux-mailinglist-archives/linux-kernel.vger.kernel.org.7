Return-Path: <linux-kernel+bounces-765308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6CAB22E71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788231A24A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9C32FABF3;
	Tue, 12 Aug 2025 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVYYEKNj"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304682FA0F8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017872; cv=none; b=fxBRqgJdGH/6+Vawx4T27K6r+LfEFcaPPxV6mosqI85Kcr35EKVYOBioWJh0bxyYGeoZ0avsQ7SsA+92+mkpuX44W/Yb0GTQYsljGhHKZSyJ23c1QtX3YJHLYYD84RFfD2BYEphIAM344lpTnt6sggphQH4SsyUFpaiuuoPCPwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017872; c=relaxed/simple;
	bh=THi5EeRjYjU12pg786HqRQnWCXSwecn27iJQLPTdTuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOKROmTQUR9+ENPhovYpwZA/L8aU313zE5sYcKkvdUJhYOaS04TrlfRzPstab+gec5TyDl+yOiHQdhEbJSvm+Z1UZOxRVPCyubkOVb3Alclv8MBI1DpCDA7ujoYDsVbPlIa9TpGE0K0GplNTnXxjZAROUT2h5rSpeh5KnMbZXNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVYYEKNj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-458c063baeaso31473035e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755017869; x=1755622669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THi5EeRjYjU12pg786HqRQnWCXSwecn27iJQLPTdTuM=;
        b=jVYYEKNjcjqX0UaGZo/gvyM7rhZCw9ZLUc6NR8eyiZhmrg6WB0f/Er9Xa6vZi2YzSS
         jFXtm3NMTSFKQdEs0sNqpV1yNyrzPumBqEV7hOTrfgCfmAXIjiPiAGkjdQx/eysq/56x
         3o92Msq74P9WO1QUirZRIgtebyxqEJDR7AHCXEzGTAezTVy0Q6umJ6gy4ns5P6GW0YBX
         e1osr/nvwz0Np1JE4e3MpvJaXORUgpuuHaMf3BHsZ5hNZqJ6ubo+MZi5QLkVF1Oudujy
         7t447aWGJ6rgL1/LMJ1fZf7tTGxeuAcgH4BmQhV956aKqcmZdAdd1t1Kb30Q88ZNt9fM
         JwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755017869; x=1755622669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THi5EeRjYjU12pg786HqRQnWCXSwecn27iJQLPTdTuM=;
        b=bSeZpSWhiyhswZEQpqkEDnYg4LVB0o6HlKAiEA/2w8wPOSkYbVR+9SUacSnJ6KOuf9
         Yz1l5F6r6gXdq1YLZnvcHZYImSmOcQVD1LtFXJ5o/9O9UJF6bjL4ASAXJSnwCCpE2wZQ
         WKuu/EeNBXDhz8fNQ11VDEddrJM3H8M/yksQNK2bxDkUxbI9j654e39gaxMv3F1AGDOw
         /8H7V6pS/zA9f8LElfpGaIuxLSkpU915ZRrqrRzRsYUXbA++cTtqAo1bR8K8S0U297FK
         l35+f6HLAp9/ZmdGBGOdNiuCqBGjdcubdyXge+RVRA+whAjQ3H7t1KfpyVy44ACHdvNS
         dFmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI+kH0EtZlvlqggokmQDReirTP2YBdbT+TGogC9ntgvXxx7sFn174MCPypvozSIeMx8/U4MHaulS9oLW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt3kVtuasQAWq5+y1f3z6X7OW4HLnq+8pjt/I7sIKTDi7y+UuW
	sPVXmmRrjDgOMk+F2V8uNrB/Oc7YOiwl2DK3ribUYavrkQju17R+9Cc0DN4Nd6FjqawgCpRtQMm
	Fl48v4R3wYCmp1ZAlab4fjSESmw0Zfzw=
X-Gm-Gg: ASbGncuMDd0TvbpQsuD9QyzPuppqwMIf6eNiY/C8ayV/59I+f4wrB/fV+ZEiBgaQPil
	A0eiJsAnMUEiFRKd7EE9CUuH/IwFG5WdFlP0QU2bqg56b48raGro/N/FUHgEsKs0M0piH738QNu
	YyKsP1dSck482VuTkOeCHztLCSDKBKCHn1MkdRX21IhjVdy+Ja1EVlAVsvl4HN0cLkpWt6p0/tE
	EGYpuMMdA==
X-Google-Smtp-Source: AGHT+IEsQlhEeOC6eiZ93gGJ4m8uomE3V15azZrYXmJyDSkXZ3M01xCGgAXrwPBIlc9YO4MZyr7dBEomuI8DNX20blc=
X-Received: by 2002:a05:600c:548b:b0:456:1c4a:82ca with SMTP id
 5b1f17b1804b1-45a15b8ff7cmr4280275e9.32.1755017869451; Tue, 12 Aug 2025
 09:57:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812124941.69508-1-bhe@redhat.com>
In-Reply-To: <20250812124941.69508-1-bhe@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 12 Aug 2025 18:57:37 +0200
X-Gm-Features: Ac12FXxO7VtFtbvMzrNpRmaaDrUzWKgNXXMRGHfAEt4lFzHjRoU7D-oGMR2kngk
Message-ID: <CA+fCnZcAa62uXqnUwxFmDYh1xPqKBOQqOT55kU8iY_pgQg2+NA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	elver@google.com, snovitoll@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 2:49=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> Currently only hw_tags mode of kasan can be enabled or disabled with
> kernel parameter kasan=3Don|off for built kernel. For kasan generic and
> sw_tags mode, there's no way to disable them once kernel is built.
> This is not convenient sometime, e.g in system kdump is configured.
> When the 1st kernel has KASAN enabled and crash triggered to switch to
> kdump kernel, the generic or sw_tags mode will cost much extra memory
> for kasan shadow while in fact it's meaningless to have kasan in kdump
> kernel.
>
> So this patchset moves the kasan=3Don|off out of hw_tags scope and into
> common code to make it visible in generic and sw_tags mode too. Then we
> can add kasan=3Doff in kdump kernel to reduce the unneeded meomry cost fo=
r
> kasan.

Hi Baoquan,

Could you clarify what are you trying to achieve by disabling
Generic/SW_TAGS KASAN via command-line? Do you want not to see any
KASAN reports produced? Or gain back the performance?

Because for the no reports goal, it would be much easier to add a
command-line parameter to silent the reports.

And the performance goal can only be partially achieved, as you cannot
remove the compiler instrumentation without rebuilding the kernel.
(What are the boot times for KASAN_GENERIC=3Dn vs KASAN_GENERIC=3Dy +
kasan=3Doff vs KASAN_GENERIC=3Dy btw?)

Thank you!

