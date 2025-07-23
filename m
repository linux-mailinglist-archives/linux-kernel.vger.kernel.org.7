Return-Path: <linux-kernel+bounces-742793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B432B0F6C5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA5B3BE916
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E06C2EB5AC;
	Wed, 23 Jul 2025 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="IWkwUuPr"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733222E542A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283432; cv=none; b=GzRMRlr9WvadprpVMDA3EmTtYhq7Gf4QkrSyGEmfT+74NNIG41NMtLVEXYWwG0tHb9dIWISl9J9DW6Ci/1SHyR9qkpZEDpL3g+7yE8TGEaa3QxQdQ+f+TKeEAoURjb/XLb85evRN9puqLhxlrbsuuSlY+K3weFWpJOxWK8NpAJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283432; c=relaxed/simple;
	bh=s9X3Rf4iKvd8tihzYDWl7G2SYC11kejhiYfJ2FtSKJ4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=ubllsiVmEp6pvGU8bKy50/JeZhGWw4lAR7fgjB0dCpzuXeQ5ZSus6erI46cF6QfkGGrf0luCnaTtGeplFQlyrNZBVgvRf+r+ztOL6VS36yngAmjLWlVAiWkNZAC4FWDgT+DoKq/KDdC850EMmPnxgz7GTdYUCGmZ5zseU6O4TD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=IWkwUuPr; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-75ce780af03so38136b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753283429; x=1753888229; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuChy1LULay+ShDL03IJdTFrOKC/jWx8pEhX699NilY=;
        b=IWkwUuPrIpKXTGqhnVt3lRl+2UlmxYF/OhDKZZRRNJE45l3GBqGD0sS+MNVh1YZwHu
         ToNbcTx7YZCG0PGJJ4cjLXQol6PKWBQtHgtKLfW59f2SHVDv68B50kJHitqg1Vly+9wa
         v7i/xQCFE5sM0fNGH6h0jhpgj8DrlV+OMCiwGR4Bfte5SKBj0fihLMQJaUzqpwP9H7Np
         3IZaAYS7t/pQ/dEqIKi2RHSmXltWmBFqs+YiCYrJuFS6FNtZuiiEzOcGaZwT8DzpkI6p
         FYP+E+TNQqDFR+Kah0xH+48yypHXcl9owut7qUN1DhOC0kV1+dR4Ehphqdn6kmnFxWJ4
         JFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753283429; x=1753888229;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UuChy1LULay+ShDL03IJdTFrOKC/jWx8pEhX699NilY=;
        b=TVGccsciIQ9vPRA+YlAohH2NuECxzfkpS2t3V3TTTwFXLFsJrb3biRMlR3Ko/gUKu/
         6gn6HSPhHZ1HpFeOZyzrEPVjGadO/54T077Ph2JFHwy4HlMCqis62VuYo7cJiYN4yeF5
         /a5vpyyYsxFUXbkXAs3PD+pgq5R6ZSU63NgRnjur+BBEttFO4sXI2nAtF3okYt4oaWtE
         YL5Mnl6wZvO/Nbj9Asw6Gn5M2wS69T/1drl+OuyVZDIr9xuIHwoaUVnKTexyVTsSiccO
         vE7D1EXgjnlaujc061UuouU1ALmdVm1Ls7kuu79gO5+YyzJlzPPWLFR+3uu6J4ElxQyj
         1c1w==
X-Forwarded-Encrypted: i=1; AJvYcCWSx2a1NO4Ki1UNDTeZOVbA4NfEa8WdGqxr6HuieZv4TZd7US42Butvmq+nHI45lItaY7osB7spBE94xQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt4qAFfVUL3gYSZsMoJlNxmHVy5dSE2E7rSghYXbaysxtoxXPM
	xLEix7FZq2mnsYd3rMiR3d5uWWDrl0jo9gUpT6P0ts+ZyZ9iJvePWteLi0N3GrJPJqk=
X-Gm-Gg: ASbGncvp8Wtq0x2U5z09tlzDQdwxBy1e64bJzZcOFaFdUyx92T82X7w03nVoLVzwGUC
	sN3xvP69AkaXVBpag2cfPK8hOsth2WYTR4FUE9IQnf3DjMJXDkazwIvQTyauQ2s4rOhQzn8yd/L
	YYizLbgoCj0fo/C9EDCB7PO1f7RWSSg0aKKmLZl59lEJ/VsM6vOr5DjxaLkFKBspsu7xX8eCk0B
	wY3Id/yM5oLIgnCKXEhm/CegwnKfZWkb4Y9c+mLTsr7M4wyDhzwg+4zz8nrcNrHF0lTpIk3QwJk
	Idbg9/EJ0owShcEQYyqjTwJRRXHxAvOdjlF7yKdMOCPy6Pfvz0XzeZ0KZuxhj6vOZuX+UT9bf95
	R0Ns9rrNVgSU6fhBm6fTc5ZZoV/M+Hg==
X-Google-Smtp-Source: AGHT+IE+co2aDTbuxqywk9VXXdq95Qx32EuhMNzguqNw2C4YBMnkv2fPJd5DUodgNwdXPUs40Wvm1w==
X-Received: by 2002:a05:6a00:a1c:b0:748:eedb:902a with SMTP id d2e1a72fcca58-760353f328fmr4564271b3a.17.1753283429448;
        Wed, 23 Jul 2025 08:10:29 -0700 (PDT)
Received: from localhost ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb1569absm9971551b3a.68.2025.07.23.08.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 08:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Jul 2025 09:10:26 -0600
Message-Id: <DBJJ3QS0PN8E.3VW8UD9HEQAA6@brighamcampbell.com>
To: "Doug Anderson" <dianders@chromium.org>
Cc: <tejasvipin76@gmail.com>, <diogo.ivo@tecnico.ulisboa.pt>,
 <skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jianhua Lu"
 <lujianhua000@gmail.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Jessica Zhang" <jessica.zhang@oss.qualcomm.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v6 1/4] drm: Create mipi_dsi_dual* macros
From: "Brigham Campbell" <me@brighamcampbell.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250722015313.561966-1-me@brighamcampbell.com>
 <20250722015313.561966-2-me@brighamcampbell.com>
 <CAD=FV=XGO5y0F40oaOANW-r-q5qZPFYRwO7aQHi3R6Ag-aeMag@mail.gmail.com>
In-Reply-To: <CAD=FV=XGO5y0F40oaOANW-r-q5qZPFYRwO7aQHi3R6Ag-aeMag@mail.gmail.com>

On Tue Jul 22, 2025 at 10:20 AM MDT, Doug Anderson wrote:
> On Mon, Jul 21, 2025 at 6:53=E2=80=AFPM Brigham Campbell <me@brighamcampb=
ell.com> wrote:
> add/remove: 0/0 grow/shrink: 0/4 up/down: 0/-8754 (-8754)
> Function                                     old     new   delta
> elish_csot_init_sequence.d                   758     379    -379
> elish_boe_init_sequence.d                    846     423    -423
> elish_csot_init_sequence                    9136    5380   -3756
> elish_boe_init_sequence                    10192    5996   -4196
> Total: Before=3D33880, After=3D25126, chg -25.84%
>
> So the new way of defining mipi_dsi_dual_dcs_write_seq_multi() did
> indeed give a pretty sweet space savings! :-)

Interesting! With as much as I've heard about compiler optimizations,
I'm kind of surprised that the compiler didn't do a better job before
redefining mipi_dsi_dual_dcs_write_seq_multi(). It's nice to know what
to expect when the rubber hits the proverbial road.

> This patch looks good to me now. Thanks for putting up with all my
> requests. I know this is a lot bigger than you thought it would be
> when you posted your first patch, but I appreciate you sticking with
> it!
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> My plan would be to give this series another week on the list. If
> there is no additional feedback then I'll plan to land it.

Thanks, Doug. I appreciate your patient suggestions. Waiting another
week for any additional comments or suggestions sounds good to me!
Thanks for letting me know.

Brigham

