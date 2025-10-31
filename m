Return-Path: <linux-kernel+bounces-879743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08164C23DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4725F40162C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77BB2EBBA1;
	Fri, 31 Oct 2025 08:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d7Qacd9M"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013BE199939
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900183; cv=none; b=sMOrNsmVbAx7hK6ccNe7ErBli5qkJP8Z6/aH25RB7n9C/VO6RuKDKaoZqVA9OXFjhSirA+VLG0hxPWn4Q2cvhJNzeaAFM7DaPCDaLpEV3BPk+73xyJxpVxVbqG6Z1NNJTD2ar7f+1maBHBqgTtMEqXfEl0rQmzjTERtUlKhyNHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900183; c=relaxed/simple;
	bh=8VPEaVnHIyEEykp68DuPbpbxptxzT5e1LgeffYCAMUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IofYHV3L1IkD1PZEiXs7b96j5qR21PdKndEHCJloLd0xa9PPRs6qqOwYF6ojJ/QCQrsGwoL3DLmtiYj/Kq1qd74/d1c5GZIL4r4b+PcIz1u9DzIL9SDhd5CX/JEGTUk7mRz8b1dAqmSGJdda9O7OZNEsjfcub6BP9+5ySPmeGRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d7Qacd9M; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57992ba129eso2607884e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761900179; x=1762504979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VPEaVnHIyEEykp68DuPbpbxptxzT5e1LgeffYCAMUg=;
        b=d7Qacd9M9o5ajtFaGXhuhxsjBpH3FYJfU6Uh/Ku9fSGT/oP4CAJS3S1QePN6f0zdlX
         yOrAsHG2pEMdh5vzTRk77znaJbJLAjQWQoPbOe1lK9V86+wogfz6gZSbz0WDrhyHOKnn
         HBgUwpQImOoh5yqmpQy8CyOAwAt3GV9Fs/cdlPiinbyK00ieIzyv0NAkYIFmO/TzEdkw
         idx5Ma9j3Y/iME+NuMZmZkqz8T/oag7HV2awt2H8i8zAJWqDaRavkIm0qocZmQkwc27N
         TOqHxd9yFaTkwj7GaZncxINSf97uid20g+p54eXSuKkXrb5Xw34J72U//GgMvMomTiY1
         Lg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761900179; x=1762504979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VPEaVnHIyEEykp68DuPbpbxptxzT5e1LgeffYCAMUg=;
        b=whT5hRB1+5EHz53cOvGUBbvYuRef/1CwIWW5ZGKiIz/OSPZHQ3cHMEVYChq/YR9Iff
         a6hcf6v72mbVKq0MYmb2RvHRQgvR3Q0JVehNqeGnLw3Fd9FtVS1I0zae2ZCBIr3Quf7s
         vPXcb8lCjPSh7weedFH/Www6pUg23E8Ul5kM077LITCsQaadn0QU7qtlQZo9Sz7NCfHA
         DlFk6aCur7pb2DvbrkPu3bK+/LqlNexvDWA8sMmaX74PGJZFZptDSrjbKs1A6abTmUHg
         5ZXGTdbplVkElWABJCo6R789tHnzqYxb0tMdtclJFVcvhSxHpKdJXkRuyq599jsgDAQY
         aXNg==
X-Gm-Message-State: AOJu0Yy+2eA3Dn4SzhmvQEG+ea/9ETpTaSlrpZbtEPtzEW/ty1WpVLx4
	TaHua2qbdrDJuYv5NGbaUHcucQJMVQ/REmY9+sZttU46bmt070NifpysVjv2IAAXsswy6U9bTjT
	8E1c+woS1giyEWsoe1AlDjU0NZ9aZOmKBbTpJiqDlOw==
X-Gm-Gg: ASbGnctKOaA2x1qqjB+Nwmwr+cRTJCGvHwJS38KPsJIa9irAhNFGjRzMoNurvAfiPps
	wP1SNIKan4XqMrXYI2E0XqNfxrTDgOxvpVZdCCZzE0Q7Arp7OZXBzYHB+fxwDdSfrVHj1VBviCz
	cZbncWI89V6jsLeC9AsbHw/CCtsXxYEJ9l+YlW+9imYiVH4AMtsAChxNeiBLUvvKyKIRjladHD2
	bS2D+CltwJIusEcL0UwhhF/X/hV3w7c1qOL6+yNOwiSuVPCLN7H0gfHuQqfehS4Vm7okeUSuPlA
	y8iTrHFKjzI03EjQVIf6o0TEEJ51
X-Google-Smtp-Source: AGHT+IHGJmqlIXHNOm1UUUwV1F7p+xTwNQl9Kedsi6/i4Xko3qPnKOYsj5yIF7hW0Osmxc3o0wmHJE08wvPDk4Ri8KE=
X-Received: by 2002:a05:6512:3a8a:b0:593:f74:91bb with SMTP id
 2adb3069b0e04-5941d52bf43mr870426e87.23.1761900179006; Fri, 31 Oct 2025
 01:42:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030161011.282924-1-marco.crivellari@suse.com>
 <20251030161011.282924-2-marco.crivellari@suse.com> <813d07f7-b430-4c95-bac3-931188415593@amd.com>
In-Reply-To: <813d07f7-b430-4c95-bac3-931188415593@amd.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 31 Oct 2025 09:42:48 +0100
X-Gm-Features: AWmQ_bmgqax5gxHAeWzVR_zTAqsONzdP2NZEDUwQUNjiw7YBE-IHcZ7XDLkhobU
Message-ID: <CAAofZF7d+t8Qqojawes8WAR2YOWz7vMtgt2y=ofJHN6mChX6DQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: replace use of system_unbound_wq with system_dfl_wq
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:14=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>[...]
> In all the cases below we actually want the work to run on a different CP=
U than the current one.
>
> So using system_unbound_wq seems to be more appropriate.

Hello Christian,

system_dfl_wq is the new workqueue that will replace
system_unbound_wq, but the behavior is the same.
So, if you need system_unbound_wq, it means system_dfl_wq is fine here.

Thanks!
--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

