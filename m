Return-Path: <linux-kernel+bounces-880834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 368B6C26AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF2B334CD8F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8023330AAD7;
	Fri, 31 Oct 2025 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="gkFVYKms"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F6A2FC865
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 19:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761937926; cv=none; b=HaJmuN5qxNKfG3QqR9Zq9Jpfbn4qmcK8niLKH3KMMg8LKZud4Z1t/sX52/WRGOlLoYiZqZTHHFgS7zAt5mgaWhZZ0FGhQyHVxrlqCVmJ7FCOQaALXyt5GWY4rWcHms9JLGgqNBcse3tLrhI9RYsg//1fyc01RLfEij8aLBUEOu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761937926; c=relaxed/simple;
	bh=VW52jNshrh5SwG3OJpB/yIJkkVhz+nrrHyDT6wGQ7DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpLyKrHl9QFC7DGWi1kQ89n1f97pR4ukJzPx/FsCocJvD7/kfKEfm9CpqOmh+hgshhHfd1iILeWIAYw8wuwMnltRgWcMWGcFxc6wcSUBuMulm9Z6CYDTJZZgOQBK37U7VoAtJY/jQ2SrC7bG9bZSC2TR6zvv17USWam+us1oMqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=gkFVYKms; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-89f4779fe03so243517385a.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1761937923; x=1762542723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKR7crf4GwOivpvRLCbaBASd2D3y96XEYtat0+ID5i0=;
        b=gkFVYKmsUhH7219PMU5/7DzGttB7UVX4MOYWtHDgDdwSCNzferrPWTe22WVx8LDtWV
         T28AyLes6ntM1TULE6UdIvciUJOlqSaDCMVhzZm2oqvtlZWLFrgtvP6qJTSeuytmcRRK
         0Z+1i8LgbQOWqWM7X9QAJvVu/MGucxB+vAyDdPoNS7zV07YzlZZyug1M9QwPSqm6spAt
         euGKj5KlWk9U34w+7X5/gKGCrG0Vvx14vPrmKbh9FLU54VWoD6fY5RnbcGAhU98+ldqs
         jEBXkXzyxZ8/kiAN5gHMMO4EQ4/ApskO+553acQaVcdOggCYnbusaJETBgxJr+13/uly
         LZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761937923; x=1762542723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKR7crf4GwOivpvRLCbaBASd2D3y96XEYtat0+ID5i0=;
        b=BBTIMHGUG/JIxza7lACUSJb6GgZHEHqA56ads9TsdZTZ1S/jqIuu3r+ITZsaYMAZm9
         cFwXcBKZdhb3iAgGpFmsDeiXgymc9E372fP6MBKC/L2ekBpjb6UDezGSJ9e/rND/MeRI
         e0PM0Pbpi7UAQPUABVoQvboiK4SvegK148ddFQsD90/RalIM2G9cdcd9c7PTgkv7bsXo
         r3igGfs/Q/CF/xffwtVrv7ZqDSppgUFyiV7/WYtKvGW09wvq8nFfEyr076rjOYJw5xst
         wlaxu0W92nGm3TMMR7+ewAVP6qf+UD5VqsyGWvVrreMEn9nw1LHVozYZccfW36qZmFfb
         gtOA==
X-Forwarded-Encrypted: i=1; AJvYcCUn+pmp84EduFRYXiy1i/KM+1FlhG0bhpFnv9PGoIWbYxIZ+svTInxZ1aq6y18kt2YNOyyadezVb1Fu55E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgsUd6MitjKWB31iGqfIDd+SmpTxc5wIF+Yn2Poufzn3V7qEij
	8Hk2AdIHiEBeh/RIsQEYY3eTffZmNq5gseFev5zAIb40jimiNDY2ZFIOoUI360tpozcoFh4FCnd
	OanyYOl6W0CoJSNtrPQWSy6y9NTHBXOAims7CKySu8w==
X-Gm-Gg: ASbGncsYvLP6w3zbjlOUbxOwZGA7vziGIbsSmPI2fWTJ7ntJEg6HqEsicRoqL671dtX
	CcRNHicSMtEqwFRQ3apzWSUHNhyHgiMweDsE0jk0jDQYd8Wy9bv4hXmuwO0iP3wsyWRv0z0eQFy
	TYYbTqSFklLd8mNoQbFzWz271QECHUDpT1hsZa1+XrmoLMcF2hzg8lwbGQ4IThdsplhJDpHTT0X
	9xxeBWMi1UBt3/wNwNcuW5Vcb4Oph6vIPxt1GNt/L77voAu3BqLg7hqBm3V3A==
X-Google-Smtp-Source: AGHT+IG3iKrNw7U2RiWr5RCEwmcEiYiWNVXYOelNJaGUT4rwn4en67o6PjcX93opjYUMUdYHKXkmLkViJEygAirpqBk=
X-Received: by 2002:a05:620a:170c:b0:829:b669:c791 with SMTP id
 af79cd13be357-8ab9b2b5fb2mr518908385a.78.1761937922975; Fri, 31 Oct 2025
 12:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031140043.939381518@linuxfoundation.org>
In-Reply-To: <20251031140043.939381518@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Fri, 31 Oct 2025 15:11:51 -0400
X-Gm-Features: AWmQ_blubeC_F1ghhkUZnTlNc4Rapn6sY8JSKK6GBZ0QDFQnn6VHLBWB30ACz6U
Message-ID: <CAOBMUvhbgiLkKC7rhz02-+V6RySpirEd=6FzsBZDQQHf3ix+XQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/40] 6.12.57-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 10:04=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.57 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.57-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

