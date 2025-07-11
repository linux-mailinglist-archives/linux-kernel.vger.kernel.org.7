Return-Path: <linux-kernel+bounces-727381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DEFB01966
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5550563A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E26627EFEA;
	Fri, 11 Jul 2025 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH2JSOXL"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4B1F4282;
	Fri, 11 Jul 2025 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228550; cv=none; b=biWOQm8sGjZ35o05UckKngAtdudzSnkX5HbVDFjp27ESJS7mAXwuAd63Lii4HNk3IAcer44aS4rFOCVX6Fnl9Z8bBiMu2qYfmDoM3WpLI6m4NgqnovBT6051OtmaoWTrASuNju89G9z6riRljNmc3u42bgL4wrGQ3KVE6b6TH30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228550; c=relaxed/simple;
	bh=6DPlrQTYkt+ZE8rRAAVfPF09NGI7WKsXkRoeE2olJfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5h9OG3rjx8A6ZjY2/4ZsANROnnDMPIL/t4Hdnp+8jivcFezqns6XsZFe15fhZvwnbH2lJlxEhX3wnj0Bd2sVX4z2rOrL1GbS8p9JmevavIasX2soeFzyQjuRPElzMbKAPvAdemnKetQDw++hkhauT321810sZXPc9Q2nZL2rX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH2JSOXL; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-710e344bbf9so19572597b3.2;
        Fri, 11 Jul 2025 03:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752228547; x=1752833347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DPlrQTYkt+ZE8rRAAVfPF09NGI7WKsXkRoeE2olJfQ=;
        b=PH2JSOXLRuWrcCeddVeyMy4QByIpdlqXPNqFTaQ3nnTI6zoFqSUvKBneAZdw2HyR2M
         830mOB3gBmBQlRQMGcWFLjZGBmwMQm+oO2UMAjYNVpmksWEjmty0o0EzBsJ6r0xiCFoB
         u6/5a8dJFd5jpHEiMKDKQBZPIErUNl/bvDtbmPV1PwWub/lSk/0SrBL3ajpqW4xsCHDn
         YP2GDkKmyzLlDgRubpUeR3b2LFxuVzVyncsNkTEXeLKqkG5W3Lwtl63bqMSnKx6iw336
         ln5B8B22/KQC45FeI9GJ9fJ+uALYD4N5QvrCsRQyTMCbRp1MKWYq322c8CUIfIWTJL1z
         xWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752228547; x=1752833347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DPlrQTYkt+ZE8rRAAVfPF09NGI7WKsXkRoeE2olJfQ=;
        b=G9zY9Heg3f8rgRO25hTHb5Ot4Vus6+9oANh1zyKnm0K+3B6BvH6UBMk/2PIUN7vgyY
         ppxDZWT7SwqJKOB2jaMQAgUqWiIUFZz5aNvRURYYKKpmI2GsiIrJH5qZZIMyAGKUfVcn
         69RMvy3tcpUiATMZnmBAh+lJ2lQYR6oZK21K8TVGc0bckDyCA9PRlQNfYdJQKWcQVeUt
         YZ+U8yxrwdT+s23fuYqTsEnm7CmQYtgMTO7rxIT/paE92CuX6pF4OZRdI2JIn6slcIgL
         aHVvSST2iw27ktyqIfdlLvSpHIT0TS1yFbWZX/hNvU+dmKgZW7aATbzVFo6atnSj2PPe
         wa9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXueJLbDURtLu8HC3A5cq0OvLZD/zChIVAmsG1esBhXRnKScWyINrNqgusjNnWDK+Ep6Q7ZpIy++TL3Cy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz09gGSWr994/+RDu0xYG8UM4LZnKpQzErKJsz1VVcBOuj3/45S
	dntloDxEHxdLA/u6l4CU6muD9Ko8ZmC/coa1jPynknvBzQhbJ1Tk4LWG+ZBBW90eVUdeF1UCJUP
	4t9NC9O0s7D8Y3XsyDTdlPzv6NbPzcjk=
X-Gm-Gg: ASbGncsFWSIvVB0NV7Sgrqo9gq4GWdK0N2GjZ+GlfxkJ41yKoXZJJWC1QvLmEgVdjLv
	LRbUYQds3x5w7rRN3gWoyvLIcTKyGWPvLL3sYzAixfTJEUkXZGYpFmneHONRJk/OcGsfDpVC1ld
	2Q8PMeJG5kfS1vFTAZNJbWsVuKrmr3kiGWPxBA2cffnYfugXvDm6ICeWJ+Md+JX4q8a8BhjO4cB
	87UKA==
X-Google-Smtp-Source: AGHT+IHQpevq+XY5yL2INS7d4S8i9FSRzaPoq0u9J3IcMyelf48WOLt+P9Cs1J1wH/z+tAIZ8PQ8eE45oNJasrMgO7Y=
X-Received: by 2002:a05:690c:4486:b0:717:bff8:4681 with SMTP id
 00721157ae682-717d7a0ec81mr41763067b3.24.1752228547438; Fri, 11 Jul 2025
 03:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710162737.49679-1-stefano.radaelli21@gmail.com>
 <20250710162737.49679-4-stefano.radaelli21@gmail.com> <56a860ef-7994-465c-a902-ca5ba2f90f73@ti.com>
In-Reply-To: <56a860ef-7994-465c-a902-ca5ba2f90f73@ti.com>
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
Date: Fri, 11 Jul 2025 12:08:51 +0200
X-Gm-Features: Ac12FXzZlU0AU1NAJ9x1FPayIcmG2Vzc5ZawWw5m98FRFxy9HHEL6Iq3JdutXZ8
Message-ID: <CAK+owojYvje74dZbd3_35u2SMT--Lq8mG8tQcBGdmFD4oKjPcg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: ti: var-som-am62p: Add support for
 Variscite Symphony Board
To: Andrew Davis <afd@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 12:39=E2=80=AFAM Andrew Davis <afd@ti.com> wrote:
>
> These mailbox nodes are now disabled by default, you'll probably want
> to set them to "okay" here.
>
> Also, these mailbox nodes, along with most of the remoteproc stuff can
> go up in the SOM DT, these nodes shouldn't be carrier board specific.
>

Thank you Andrew,
I will fix mailbox nodes and move everything MCUs-related into the som dts.

Best Regards,
Stefano

