Return-Path: <linux-kernel+bounces-873417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 275C3C13E27
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A5B3B5E18
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E724302143;
	Tue, 28 Oct 2025 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oaeCN/Yc"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867352D877E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644532; cv=none; b=bxdd4l3dJFhT6DhGdzBvECxe6ZPbOtKMUM3nnacFBxQIAwAHoFEgPZYjGScFe5mf7QC+UD5ZWOS94vlHHlYnPpZfBW6bYw9V3UQdbq7uSzes2hsiLSy5hASZ86aK5OpDaKlsDv8LoYOLzJDb/+wDnrfqPeBmQFr6HCrM1Ejd+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644532; c=relaxed/simple;
	bh=F1LlzPFukHcBQZtULXqC8ZLbFGzwCc57krplxma1xrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyS3JKN1cjMoGwKUj+qDmdKfmPFjgTyIrTzo3K7ffkXafWNkv5DWCxYGFS1EQgn9gaGdhGdZFlIMCd1ev2WPgMg2F5rbMX5bPPC8z0MNaUmONhqtVxdhqhPq2TxYu105k/PBLrcgCN/FvtL3K2YBUcyfSu1Etu6Hz4gjIlt/eoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oaeCN/Yc; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7814273415cso47205577b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761644526; x=1762249326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ryO6rqNW3eQpZIb3tC0WKzyA4BnygSI6aKPZv1FgIo=;
        b=oaeCN/Ycd6aL6zDV6Fszq7RKKCrAyS0H/c6dUklaNNsq054R0cs/kaYmIm3aNBzkAL
         fEy+3M868nYbq5UE8mPmSmATnVbSijiZymcs3Bnta45h7k5W9Vsul1piHhGPYbTYgC/t
         kzBVGaYLhiGM7uLTRRC+JNtbalwNdlE6Qmt453Yi5Q9FMXDV1ZGN98ajF+O2oUnxk1Zl
         1Ple6GGAe98PN4IEGJ/IydCbfvhZ9KyarErVzfaewd7BxEm97Xz7sZUgz8wAnGnBf0zv
         jVjDWZ1poFXtytmT3/mkhdG1VxGfmyyLBRpK/bt0UZpzu73gkxAuPKJW7YiS6x7x9mH5
         6RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761644526; x=1762249326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ryO6rqNW3eQpZIb3tC0WKzyA4BnygSI6aKPZv1FgIo=;
        b=E4PYPEYliiS9VbgOcClq/ESZ0EThMUu2FqsVHnR7anC7VcEvBAyz5cz104X5gVt6lr
         kLe2moZx2Axv/CRLwVCM+085t/03tJ/OcwL4nrduCM98I7P7DDHs87rYf9UW8pE9/LQN
         PZWHsNisH2NEXfs4fobJoSfwWI4cUVR63LHhOIDgnXiSBQbpEsGlwLByo2F0PnTB8SjU
         8eUsyVhPdGmTYKDpMWZW1Q6jcgEMhDVwRmqbdr4BaD/5udzVA2TIkgSG7IftdRAcv7Wf
         E10eaFTUqP1fKq3s4IB9vKBqzb/nZN96X38k9shq1XhN48aXcVfieAMxr6X7wUp96aP+
         aWtw==
X-Forwarded-Encrypted: i=1; AJvYcCVpAqjGqTBj+bXrq9g0eNQ1P+e27nIQBfn55tUpiRadyTwWeSUf7Fnyva7A/Lg96RQ9pxVwIZ2qRilFxYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Rq3Zo28I3rX5/WCYnBYMeqkjyQcB94H0t3WrES6zoyqK7IfH
	+YeRX0U+oCPXEvWMlhEp20uSyLsoL+oy69j3UEj7MyxjmdACG40ewXtVmdPVJoN9pGnVObOuv77
	Eky8aAFdQWkWz7tPqQBjnO5jv1XTHUOyaf3LHRopJWUaaSClQDfIO
X-Gm-Gg: ASbGncvE8JWXBdp5nfkFy8g/a/XwzIv3q6eChJM8lrOLQhipZgCyi9bGQmoKNreoVla
	Kqk9E2C9yg8z14Bv5llILnaJFLzxtJhDLpy8Vvvn6W58ucx2MVTXvBMg+JRYZS1ViAn29bOkvYt
	H5qyzaTz7DEyegDZOuhZ4kgDlfU1rSPwwu8L4wbUjxbaeePFxFMvlYB4rO7j5lvhDxLHRE8tKVl
	F82CoR5A1V9gU14U0xAObayx/2ZCtYCfnx1LccNnzhJX50pLBehQXYEFcC+95aDt5ZpSSI=
X-Google-Smtp-Source: AGHT+IFEiW0LGqj4GnK5zWx4ulZG1MC2jB5sUY2t5vbme1LGbExfjnLMlm3g66hE+Mh5sqv7L2cs7b0WaP/8DY8oqTQ=
X-Received: by 2002:a05:690c:25c6:b0:76c:951:83f5 with SMTP id
 00721157ae682-78617e81492mr25704137b3.31.1761644526263; Tue, 28 Oct 2025
 02:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028132336.66819cca@canb.auug.org.au>
In-Reply-To: <20251028132336.66819cca@canb.auug.org.au>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 Oct 2025 10:41:51 +0100
X-Gm-Features: AWmQ_bmXW2ly6H9OO-pyXAZVpv4SH_iK0e7IfxVGRquiEeACii4_PqGPQ9ejOG4
Message-ID: <CACRpkdasr5x4KP5rETibMy3CKZOq_W84cKFBqwKsDog1O9xwcg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pinctrl tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Gary Yang <gary.yang@cixtech.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:23=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:

> After merging the pinctrl tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> ERROR: modpost: "pinctrl_provide_dummies" [drivers/pinctrl/cix/pinctrl-sk=
y1-base.ko] undefined!
>
> Caused by commit
>
>   7a97fa0eeff6 ("pinctrl: cix: Add pin-controller support for sky1")
>
> I have used the pinctrl tree from next-20251027 for today.

Aha how odd, I don't know why this call is there, I just deleted this
oneliner from the patch so it compiles, Gary can investigate
and follow up.

Yours,
Linus Walleij

