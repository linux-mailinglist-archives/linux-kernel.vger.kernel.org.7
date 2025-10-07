Return-Path: <linux-kernel+bounces-844840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1ADBC2E48
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BDD3A8269
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4A725A2A2;
	Tue,  7 Oct 2025 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5+hXYg9"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93741F63CD
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759877121; cv=none; b=pY41aIbZEv+yS2WvEcdl5QJydXjOWwPWARZ+OcAcIzN7qY6apQs5wsHCg03Yoi5Xg/MeT+7WSz1FLauq/DUhJ5ICoubcgd183cPl2tx7yilkhWcOors09O5azUOEBzoCfBCmNtkjdah383W3izf9HtVelYXyyJ8wlvlU6WNNnSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759877121; c=relaxed/simple;
	bh=acoKweiE9t+Y6LeZfG/5kZSShYTLMPG+aiKwdlW1U+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqUsh9ZwxInwdA8PbMxLVvhWzkZwQ7U5ImjBegx1OViYaORnUpWnzvAmD/gWlaqT6s032cmWj0JaNNOR2FgfVLliNuvCTcHkS0R/s42qAuKUzCHD4N246e5ke+e3eM8TGZuMTkGohtxKr5cWkE/LypMPoOhT6NdhchTsEl2a7+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O5+hXYg9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27eeafd4882so98295ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759877119; x=1760481919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acoKweiE9t+Y6LeZfG/5kZSShYTLMPG+aiKwdlW1U+s=;
        b=O5+hXYg96ZewNH7mEoKYMlOyuVQuYOqlf3QyNFTRkQpAgQRFI1s43f53cW5AZtXGPh
         57+/rhOr6NLob0Bjj1age8Wl3AO79UjHeDkAuQQF8dB8lGmLUZu3K1JMBQbAQ7aWbBCg
         AF9K3m3PI9VvKIjvqzgrXw+gPJK48En4kqslMboZzDyHldVFnLTsKpdOkUkgf+rMWFDW
         EPOfseR6Ms6B+0uePc42WVZzXlieCcTXXzmiYMgV/wVHLoXYR4/U98+b9IUxdC24Ega7
         F5DCcjx7q0cUWxzCJflfIoRtScgugFCox0mrtZLBeR3ce/rvGHkBVsPaOovWQQ1I3Dbw
         D2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759877119; x=1760481919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acoKweiE9t+Y6LeZfG/5kZSShYTLMPG+aiKwdlW1U+s=;
        b=CF2JuipnpP2BqJ/ezHQzXdpxYrjPdTgDNeY2fSw26N6gnDsGo9sp+BEWpmqAMevcu4
         ELMqxuk1NwzR4WF+MQbLoSax2mCiuJu78clCZqL9eGzAutNGDXfTHwjMg07rMF3ONZwV
         X6iWThimCxs/D0xiUfQyaqw3IJEBC369LfOf+WnEcXzR2WLfiP8aopzsnJtKZ4T+58fa
         DCEvCajqsTEz9chNANxmSMpMXme/8xJy8n/rZjmPCSdLC4Wbsn983eyYPJgTsg+oDCRQ
         bOdtCHlc9Jo0Ne2G4K+Vtjd9m0MvO+uY9U9WXXfjux4pdzfphV4egZSdYYZQhwz/nY7u
         Fx6A==
X-Forwarded-Encrypted: i=1; AJvYcCW+B6AdpKgQc92YEjGbsZeY6lQGh1tw0/OeMfwlC6b84AQA+SDX9ztru3u+uBzx2XO+0UVJheQYN+vseP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YychJfPl+8eo51iAm272EvMvo0ZbRO+HWbjPIvJPCxiy6MbpIRL
	A223plf6FoqT0lqH7/mnNfnAp0yV0+iGSzjJxRHpIrLwMSkixBW3PwexyNj7KZzMj8JqN35bufZ
	zCMZ5PJsuWf2D6TlG4bLmuxYl27BSU5hU/tjM0T/D
X-Gm-Gg: ASbGnctamqULkFJ1bcPjUY3gdieCNdJu5ruBmuv3VSa20evJi3rtJAo+7eE9k2zk6ws
	y7ZW/njfRtjso1eqOWayN6MWUuNjolDdyfVmN19u6q8P5Yov2TRqkefIx0AhRogX09g5hHt8tsG
	Hdcowy9m70Bjv2Psco2T2sJ9V8omvTnVBFpu8z0QOtZV+cdCLGqanz4FW4Hy7H39+BQGVTxCSPK
	xtZ/Wv8/u8pTBZzp327DRWm0hl7e7Lv68R64CdSzxUultoPiZIpVilg1ZQRuYlhYr+Sf3vIFDEs
	0cg=
X-Google-Smtp-Source: AGHT+IG7Au5xPNQ1Q+npLDoAk2/XxZWd9r/KEIJLvu4AItG4Zo6pTEhdDaHg6C23wmFiAa88C9hgJIStIMVh69InehM=
X-Received: by 2002:a17:903:1b47:b0:25b:d970:fe45 with SMTP id
 d9443c01a7336-29027603504mr2664305ad.1.1759877118666; Tue, 07 Oct 2025
 15:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916145122.416128-1-wangjinchao600@gmail.com>
 <CAP-5=fWWOQ-6SWiNVBvb5mCofe0kZUURG_bm0PDsVFWqwDwrXg@mail.gmail.com>
 <aMoTOXIKBYVTj7PV@mdev> <CAP-5=fX7NJmBjd1v5y4xCa0Ce5rNZ8Dqg0LXd12gPrdEQCERVA@mail.gmail.com>
 <aMpIsqcgpOH1AObN@z2> <aMpRqlDXXOR5qYFd@mdev> <CAP-5=fV05++2Qvcxs=+tqhTdpGK8L9e5HzVu=y+xHxy9AqLMmg@mail.gmail.com>
 <CAD=FV=VNmjTVxcxgTQqjE7CTkK2NVGbRxFJSwv=yOHU8gj-urQ@mail.gmail.com>
 <CAP-5=fW64xHEW+4dKU_voNv7E67nUOFm27FFBuhtFii52NiQUQ@mail.gmail.com>
 <CAD=FV=U3ic707dLuUc+NfxtWF6-ZyRdE0OY2VA6TgvgWKCHUzg@mail.gmail.com>
 <CAP-5=fVkw6TLjVuR3UCNs+X1cwVmYk7UFABio4oDOwfshqoP_g@mail.gmail.com> <CAD=FV=UWkZx8xQD=jBkOO6h2f5tw_KCoqhHciw5hkEOYU=GM8A@mail.gmail.com>
In-Reply-To: <CAD=FV=UWkZx8xQD=jBkOO6h2f5tw_KCoqhHciw5hkEOYU=GM8A@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Oct 2025 15:45:07 -0700
X-Gm-Features: AS18NWBRXn9S9wdPvMnsRPvu-pwDN6eIzlJlkT1nNcYocjJ91PnSFj4cTdTBrps
Message-ID: <CAP-5=fXTFHcCE8pf5qgEf1AVODs2+r+_nDUOiWgdQeEgUBHzfA@mail.gmail.com>
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup detector
To: Doug Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jinchao Wang <wangjinchao600@gmail.com>, 
	Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org, 
	catalin.marinas@arm.com, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	kees@kernel.org, masahiroy@kernel.org, aliceryhl@google.com, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, xur@google.com, ruanjinjie@huawei.com, 
	gshan@redhat.com, maz@kernel.org, suzuki.poulose@arm.com, 
	zhanjie9@hisilicon.com, yangyicong@hisilicon.com, gautam@linux.ibm.com, 
	arnd@arndb.de, zhao.xichao@vivo.com, rppt@kernel.org, lihuafei1@huawei.com, 
	coxu@redhat.com, jpoimboe@kernel.org, yaozhenguo1@gmail.com, 
	luogengkun@huaweicloud.com, max.kellermann@ionos.com, tj@kernel.org, 
	yury.norov@gmail.com, thorsten.blum@linux.dev, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 2:43=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
...
> The buddy watchdog was pretty much following the conventions that were
> already in the code: that the hardlockup detector (whether backed by
> perf or not) was essentially called the "nmi watchdog". There were a
> number of people that were involved in reviews and I don't believe
> suggesting creating a whole different mechanism for enabling /
> disabling the buddy watchdog was never suggested.

I suspect they lacked the context that 1 in the nmi_watchdog is taken
to mean there's a perf event in use by the kernel with implications on
how group events behave. This behavior has been user
visible/advertised for 9 years. I don't doubt that there were good
intentions by PowerPC's watchdog and in the buddy watchdog patches in
using the file, that use will lead to spurious warnings and behaviors
by perf.

My points remain:
1) using multiple files regresses perf's performance;
2) the file name by its meaning is wrong;
3) old perf tools on new kernels won't behave as expected wrt warnings
and metrics because the meaning of the file has changed.
Using a separate file for each watchdog resolves this. It seems that
there wasn't enough critical mass for getting this right to have
mattered before, but that doesn't mean we shouldn't get it right now.

Thanks,
Ian

