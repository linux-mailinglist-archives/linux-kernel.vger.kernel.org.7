Return-Path: <linux-kernel+bounces-745489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF09B11AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C4054072E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F65275864;
	Fri, 25 Jul 2025 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXFWhX/M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B73E275AE6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753434845; cv=none; b=L1abpE0g7u1Isj2+VsSN9RUFTrH2HidCodZBbUZsKI9d46ZLe/1M5uVj3ER9OvPzD05JoQWSUwkQtEuBM7ZuTdDMF495g03hAmr0O2ItJrnRpVlcrAwmVpkrpgvroBa8SZumNJ66XKXIMVNyiKbPVA7knQuGBYEj2QkrNxrAH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753434845; c=relaxed/simple;
	bh=cUyg1SkNBxbS54LqH20gfKt7ycihR9zZ00+Od8G44+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMue2/ArTQPOL8Nx7xQT8Rg4k/xAx3aQ+6x+Dqf2G6mRKQ3wR1uvSGhUWwwxQaUobOvTKFBN34I1JSvkSNKwuuhyoFxsweuRx1JInkeyLzRuf/u7M1YN3YwXWgIRX6WsUXK1v6EZOohBjk6udXBsKCfmw4kSv4vGhCF3zQ568oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXFWhX/M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753434839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JydGIle7+KIUgbdtBYbE6AFRK1qmMolB16FeEOA/Yzg=;
	b=KXFWhX/MACuZ+SyM+uRf2zvaksaA3wCvAkPxR6yIiBioWjZaXfaEnlaijSvPtQaOmzC2AN
	uRbug1abByoYBxJUxXgsLWGXS3gEzYOEo5OWAJn50vUTS6750za5Ezwoqhto8hQg5jixrM
	pIa70KwvUQP//ADxy21jd5AX6zh5vSY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-T21jQ4nHOcSxIBKkS0tpAw-1; Fri, 25 Jul 2025 05:13:56 -0400
X-MC-Unique: T21jQ4nHOcSxIBKkS0tpAw-1
X-Mimecast-MFC-AGG-ID: T21jQ4nHOcSxIBKkS0tpAw_1753434835
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ae401eba66aso125312366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753434835; x=1754039635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JydGIle7+KIUgbdtBYbE6AFRK1qmMolB16FeEOA/Yzg=;
        b=mpflyDEySZUnU6q+69doUJRjJBLpMvbimnh5lwoPStUWBT5pH6N8Sn1YKroJBtjfvJ
         3DdDvsXEHEV19+u2R0Cv9zjeLmJ6ZOtdVcv0I4ZABnylPXAB8aXLK1yHAFgmaIfjk+zK
         ocAR3P4n0V9zeTx0XeI/gD4Mtev9/7XDn7rm3Pn+7AszEihmoTYeVAohayxVjP76+8MQ
         MQDM4+EyECpvFA8ghnM2/GXa/B78enOpm8DMd3B4CjCiO7KoAhNC8bKI5QmSpiaCqjrS
         eC8xfTzHSuIAlJFmaNzl9rfsUWXlu/xb4xyQmQLXKBpHuK6UCEsjlNrVELPYcTuT+ZhL
         E39A==
X-Forwarded-Encrypted: i=1; AJvYcCWkQvpmpdTcM+IRGkfLlMljfQoLLES5y59f0OLNoZSSAx4MhjwBGt419jtNEnz11LJnWB9zEpoaJnTcgH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycNXmwCLV39nnS6Jan05ltJk296D1Fvl/Me8XTT/l8RyBaK7PJ
	ttAJFqi65GFQ1vB/L6d+hTOd/0/JWrhKFIgx4V1E2p57j+KfrgaZIuOsbRrYAL2Yn4ZkGotHVvP
	ht0mCCy6ZqKRunB1RkslE8fFlM89s1ITV8OxkEfhkdkklvaobLjn9vZT5i4ZubBCMZUVutunAqs
	aOhpTbIn+boUNVA3crL77H06g+UBj4QsI3SSamUj2X
X-Gm-Gg: ASbGncuYoL/p0Ln/Ka4TouzTkuXR7vxc71okWCiRvYX+BH51dZIOaCeELdxsUWYPz17
	CxP5Baynxw0g1qsjdc29DPvuMXawS638iWF+zudp+BTn3wAJwd1Q+NoD7NDLbXU8eHdjtu5TNyd
	CtOkk8b/Nz/fxEXJdsc0nCY15+gWOqohHPJ6pVLMGlRd+zmd9T+O0=
X-Received: by 2002:a17:907:869f:b0:adb:23e0:9297 with SMTP id a640c23a62f3a-af61c6b913fmr140269166b.17.1753434834753;
        Fri, 25 Jul 2025 02:13:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTpH7eehWGEJJmFeTf+Td/G4IxZvXvweyFMbHchaLdc5IGS9b+k1MYrJRBTxvLHA9m4a++NsLGQ3PTlEI/B3g=
X-Received: by 2002:a17:907:869f:b0:adb:23e0:9297 with SMTP id
 a640c23a62f3a-af61c6b913fmr140266766b.17.1753434834329; Fri, 25 Jul 2025
 02:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723015233.173630-1-ipravdin.official@gmail.com> <20250724095627.572c1cff@batman.local.home>
In-Reply-To: <20250724095627.572c1cff@batman.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 25 Jul 2025 11:13:43 +0200
X-Gm-Features: Ac12FXwqtYT-kICQMGWTXZpELDsse6D6d7kSh7SWGB9TkFKXpKIy-t5EXJV3ZDA
Message-ID: <CAP4=nvQde7JcbhR56--4EfEsJ+F9oL4WBCRcLaOqfV1MZ-XvjQ@mail.gmail.com>
Subject: Re: [PATCH] rtla: clarify trace option syntax in documentation and
 usage help
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ivan Pravdin <ipravdin.official@gmail.com>, bristot@kernel.org, corbet@lwn.net, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 24. 7. 2025 v 15:59 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis=
.org> napsal:
>
> On Tue, 22 Jul 2025 21:52:33 -0400
> Ivan Pravdin <ipravdin.official@gmail.com> wrote:
> > Valid usage:
> >     - `-t[file]`
> >     - `-t=3D[file]`
> >     - `--trace=3D[file]`
> >
> > Invalid usage:
> >     - `-t [file]`
> >     - `--trace [file]`
>
> I wonder if the better fix would be to make the above valid?
>

Definitely. There is also another case where only =3D syntax is
accepted,  C/--cgroup. In my opinion, both are confusing, and both
should accept =3D as well as space. I even had some trouble with the
latter as it fails to parse silently and looks like the cgroup setting
code is not working.

Tomas


