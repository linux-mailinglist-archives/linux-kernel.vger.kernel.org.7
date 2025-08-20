Return-Path: <linux-kernel+bounces-778461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1BCB2E609
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9685E0DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ED228467C;
	Wed, 20 Aug 2025 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6qCMDUs"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BE128315D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755720314; cv=none; b=kTOS9ESP/BWIwSlj5k1bZnttg5i9KphprKjef5av5icd/RbdwrSPbcNb4orEmk1M8YglTR5iLJuzjPOZsRE5cr4O4CJDS/EhwILnhek77XqqSvQK/N0wEKXbgb7W5eeYlRsDNbAym4t70gvSli6oohbP8G6RvhOSm9SAGN0vmPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755720314; c=relaxed/simple;
	bh=DMT8gQy8g4ulSR+tilKyVevzgFxmeh4E1XZfeU97xY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfrqTF4gOkQZkRZSuvAg2lS+dnfUm55enAYBZWiIZM9h6xFaGsnocJevP7AmUe5xNR8y0lF6A4zK5UPiYyUXqwNx/eqJMeKGNhALkIpvtcd2s6RvrbTe3fxpblYmPdJVNpwXn4D682LGQgJvEHSFAJJQSjxEMaJmbT7orufqk8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6qCMDUs; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-323267bcee7so387235a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755720312; x=1756325112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMT8gQy8g4ulSR+tilKyVevzgFxmeh4E1XZfeU97xY8=;
        b=M6qCMDUsbYL4iWrkVqRVbHWFzyMbwR4uu9lwvPAzuqFaURwwtn0c8RUM5nPOzHplfo
         Dar98S4smU0cU7zXGVW1uQrianhJ6TNU9ctocOX7PRfjAgJIZCrf20vrrsR3PnLc60vB
         ANH4j6zfkKl0xsaD/e9M7NhPOT+bititloqsqvBlARqfjNSrjNLAq0sFKIh5zjRiRI06
         5Rmi7h8Am1K2QqmqX5vXTkD2j4310zvdGP2LLXQkZtFvBNK0DzHZlw/QURHt0FEsmSJ2
         fddCa1IfICN/Q04Jz6PPrmuVnChZgiB388XMVYbGZzSydSKohbGL0W1P1v46Ku1s24f+
         7RkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755720312; x=1756325112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMT8gQy8g4ulSR+tilKyVevzgFxmeh4E1XZfeU97xY8=;
        b=uipfNHmypQuNFC788jOdaCGdCRNO6aVuvSiGUohrET6FrmYRJ19BAA3CnmpCjANnw3
         K4K4dAzHYgkqfBo+PIwrB9sIh5DTxsXILc8+zeJPgYQhXnjevng9OAjqw5bCJ25WD+cm
         FHAIDg7Q6eBofKWP5/j8jgEx5v048PGAagjy1HI2sQqA0xyHOzUhEqPZjoLiYPOtHYoT
         3nE7YKtymD/hAvlouqa3QVGfwBenzsM6n23uT0kE6GAuUjh5uc1GGmWPiwbWQS0p5FWP
         8sn8nGLhre665bUu1OmGgBOjhZXbxy/1bxYY+AMWujgujGJV7dN4zCdPeUgdar62Lek0
         8Djw==
X-Forwarded-Encrypted: i=1; AJvYcCWAv77LxQMaGbDlWsSnRwM5HtNEidhCMbLAUQL/YznC4zuuR4WlUaBSvV9ksoJP5rIxvNqiNYeuXoWnfsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa9DeC6AMk3/y3GOJ8VNUzuDAcPFt8KEpQhg4SxrOEGiHyG1SG
	i4NJK+d1dG+7NFJWmwrGSS3+HVFpvB5IwKcOhiLw0cgPzs5/+1ZGjoKCUEtWf9ZJhp/J7mphyWl
	6U171t88tNFUVte4/rwuM3Hu0SDcJEVU=
X-Gm-Gg: ASbGncsCmp7GITQ6jxLsV8j3vUXFYDbcSICfvdxNKr2O8sy+BD8Gil6i3FEANXHbjvz
	DHwaCfmVORUSCT9mWbRFyVCKYbGaaCtC1JRWYIL+x8ljK6alFWkRmdVOfLk4IEPpzpTpHgoDXfe
	EbmXl9IBNEvsUF+byLUMx09oit6w3O97qC3CVlDgsHMLbWxIlm/90/7Tjty2wkKMo2yK0Fq5wKI
	hT76Mk=
X-Google-Smtp-Source: AGHT+IH1Qq+bzYkRz1Cnps2zoGvMW0iVPgJd3Hpn9od4rUSylQIwnGGuSVnds0b9IhrA2E8NXaxvzNjI4YmB0N7B2Z4=
X-Received: by 2002:a17:90b:578b:b0:31e:b77c:1f09 with SMTP id
 98e67ed59e1d1-324ed195634mr144806a91.19.1755720312413; Wed, 20 Aug 2025
 13:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsO+EmR0QgFGjCbq74gzwbQbb76wjt1vOOOJnsCqj9hAhg@mail.gmail.com>
 <CADnq5_PdzYSzFL7KDsPV7zqX2avwn-NhSJqyVVPYF9LOMEyhWg@mail.gmail.com>
In-Reply-To: <CADnq5_PdzYSzFL7KDsPV7zqX2avwn-NhSJqyVVPYF9LOMEyhWg@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 21 Aug 2025 01:05:00 +0500
X-Gm-Features: Ac12FXx31T4QTbPwCQYmR0dHjxWtSJ0tOEBShMpNL4ncHjKi4hfVUoS4MlpvRRE
Message-ID: <CABXGCsMYpMXEFeycCXp6yJV8jUekOEtSpk0RV_==1x2bdJxVxQ@mail.gmail.com>
Subject: Re: REGRESSION drm/amdgpu: Radeon 7900 XTX hang & gpu_sched "Trying
 to push to a killed entity" since 1f02f2044bda (6.17-rc)
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Gang.Ba@amd.com, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Deucher, Alexander" <alexander.deucher@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 7:41=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
> Should be fixed in:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Daa5fc4362fac9351557eb27c745579159a2e4520

Thanks.

Confirming the fix: v6.17-rc2 already includes aa5fc4362fac and the
hang is gone on my system with vanilla -rc2 (no local reverts).
My earlier test of -rc2 mistakenly kept a local revert of 1f02f2044bda
- sorry for the noise.

For the record:
v6.17-rc1 (d7ee5bdce789): regression present; cherry-picking
aa5fc4362fac fixes it.
v6.17-rc2: fixed as the commit is merged.

Introduced-by: 1f02f2044bda (=E2=80=9Cdrm/amdgpu: Avoid extra evict-restore=
 process=E2=80=9D)
Fixed-by: aa5fc4362fac
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Best Regards,
Mike Gavrilov.

