Return-Path: <linux-kernel+bounces-773949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DBFB2ACC6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01848188BC8E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FFF2571BE;
	Mon, 18 Aug 2025 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUyavoNh"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D3D2561AA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530846; cv=none; b=OkjjbjWBMb3ZdL68FHTt0htW1KSp//EOp6w9/OCp+900k3lnGmQcTgcnJCTGaZHQQar3TrrENQb6VCVB01TyWcu3kYawVpZwdvzhNggFWs1SDBv2Y3Aa2rIOPjWQ25yclRP2JzYmJOayn+UsvCeQblIgDUVsg6Usv0z7zjJn9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530846; c=relaxed/simple;
	bh=tMrNPOGaYVICghmcHfg1HzBnZ7RMQ9DCqzOebaaSyhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgAv4uqqbEVXRGBdRlxzDsiUo9OGQurjaGdfGKbwMVmPvRC4SKfxC2OPLFRqb8l64m3/zHjkJsCjEly8tauVBiWGjawAchWTrhRIR6PwGoJLIyFt7xAmcMnhBcsnUcauGk/Q38cuXPWYVKNm0BEVOIDVsGTD+ZifDYSs5EVB6KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UUyavoNh; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-333f91526bcso31092121fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755530843; x=1756135643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMw3gg8cXK66LujaDUzkJciYqkDPA+K8FcbK/5upvAI=;
        b=UUyavoNhveExPshurL9iG1CqrjPisZ4VvISd8ql3so2h+0TLkRWtEACn9wzDvmTFkW
         +JVwZEQ8St6EpMBz8eW/GcOu+V0BZd9pKl+1X4nZhkbxb5dlrT/sy9e3wLZWI8lPBbhI
         +14tKUfXHj0Dd7eTXuoDpheXboE1T14LKW08Plg31n1NhzVTlLEjiRwnLMEV80BnZ105
         aZM0kjWcyB8h9FsSuOQ2FpPpOubbZnKQXeWh/HvDWmlVpvLeg/ulP6Gy43kbzLivQPLT
         JCuL4uubQ+rNh7SkltBOjQ0Jr8q3egcPpBY8WP4NSCykNtoVE2n0hkpwscKrp1fcTSGv
         gJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530843; x=1756135643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMw3gg8cXK66LujaDUzkJciYqkDPA+K8FcbK/5upvAI=;
        b=chGU5bpXlBan3vfbu3PZbwKN795Fo6rCyDZ7aFzZpfGV04jd9SoFpjno0xiCiNDzmx
         Xk0XTGxpV5rV87maz5ZZOtFMV9tEakbidiFfwwN3glc8XFbjFrkIMvplSzogvGifAT0a
         TpSAIf26/uRod6eejfv288rIZmFYjLYnloQNsBdZo3e+sVUL3uue9XRmbrlyubYE4kb+
         xN2s8BWTciK5Bzhe+2yNxSZ0aKPmtBFmArscMcphhzMwkURGOFznYyGx1axM4Md1FMGf
         IiJ1Gw44ip/TQjrVP9uA27jqxpCClT8Z+sur3rpcOIaoQqrFQlJIMAVc0NHVhsDpUGpF
         9G8w==
X-Forwarded-Encrypted: i=1; AJvYcCWiZBtK/VbpwSNmBz5t68IiaoSVDbFccpncE4A4zmuDl7axQRmSAGCgo5DjpNkIzVAuZjY6g8xV7GlVnk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRvmyYcXds5DvnCoIMhXeNtE6AfpqPKxHFom4NeEqapH5VFu+F
	7U7IvWIKqLo98rO3KtvVFlDi9dEt9hQ0ZVdoHFytUiLnXxlKaHT4NGUKNPdsfV4UeqRlK6DOL9t
	X6iVaL+K0rVJS/s2MoBxHgktNM3JweXO71uVLgq9Zzg==
X-Gm-Gg: ASbGncvjiCkhL4vzTI1v4TJWrBhfanrtRkEFtT88seXicUQgfBlAQ6a/5bIOqpgYLFD
	lRQZ1BfUl2pk+fRvsOsXiGDxPSu0kneoiAeSLEYxNVSLVDO9u4KWO5kF8s+r9fN6tn+N3DL41eU
	c/hDr8xngQcqDIpaSy0ZtMv1W4HVuOInp/iaRwolRFRyNtsVT/ihlkcV3W6CoVl/LgXmvjQcOIT
	YshSfVmClPJ
X-Google-Smtp-Source: AGHT+IE/RelN2yAbXjKi4YiAK2CA61uQIhSY71HuMHqTGfIjg06qhygh0vmIXdnZ+86VPFbiRmacv1JnWnAJVi7TNPA=
X-Received: by 2002:a05:651c:1508:b0:32b:4903:f1bb with SMTP id
 38308e7fff4ca-33412bd8d5bmr31591901fa.13.1755530843331; Mon, 18 Aug 2025
 08:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807071902.4077714-1-arnd@kernel.org>
In-Reply-To: <20250807071902.4077714-1-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 Aug 2025 17:27:11 +0200
X-Gm-Features: Ac12FXxoI5G6Acp5M3TqMAyPwo3MxRWcQCOfhDx1XqcC9UiXnGUHpQ23OkKrttw
Message-ID: <CACRpkdacTwnFxgfEDE_eSd2ZBt4pau69RM_z9TnS4eJh-tvjgA@mail.gmail.com>
Subject: Re: [PATCH] ARM: stacktrace: include asm/sections.h in asm/stacktrace.h
To: Arnd Bergmann <arnd@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Li Huafei <lihuafei1@huawei.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 9:19=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The recent kstack erase changes appear to have uncovered an existing
> issue with a missing header inclusion:
>
> In file included from drivers/misc/lkdtm/kstack_erase.c:12:
> In file included from include/linux/kstack_erase.h:16:
> arch/arm/include/asm/stacktrace.h:48:21: error: call to undeclared functi=
on 'in_entry_text'; ISO C99 and later do not support implicit function decl=
arations [-Wimplicit-function-declaration]
>    48 |                 frame->ex_frame =3D in_entry_text(frame->pc);
>       |                                   ^
>
> Include asm/sections.h here so the compiler can see the in_entry_text()
> declaration.
>
> Fixes: 752ec621ef5c ("ARM: 9234/1: stacktrace: Avoid duplicate saving of =
exception PC value")
> Cc: Kees Cook <kees@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks like the correct fix to me:

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

