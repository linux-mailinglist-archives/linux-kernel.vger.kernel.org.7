Return-Path: <linux-kernel+bounces-898989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E1EC568C2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 406924F4EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0DA2D5A07;
	Thu, 13 Nov 2025 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="frQ8tYzU"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5615219A89
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024593; cv=none; b=aSuiXFXB3QyBLEosp2EZpWVZoSeCG3/yTzg6JEr4fYq4C0a7ZYzphBDL9WSb8b99BUOp+/NB10sx5bbtjPRqycAwYOMLuNXxFptgLi4yjuh7d/W3tGOiR48qsSWaQZ4w1+ziTac/FtUb1OX1+MXf38dFEQ26VVJRNR8PxY3eWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024593; c=relaxed/simple;
	bh=1qJEfRw4TWsb+iH4lJmihApC0am8WujNnE5VUBqqhEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RT8cHpng4q7OvLJD0wSTadpXEfDhTcb9XR++R5IbJ9dJ/n9y3j9Bi1AwePFvtYr8YLf63iSTA38wkAVp5ojMFjnWQM3/r6Yj2V6nwDEHVYIZD2IP0EIVXWY1eFKcY+Vxm4zEgPPUW7AmaP3gevVS+O0eB70L2vEJrdLssbq5x4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=frQ8tYzU; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ede12521d4so195401cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763024589; x=1763629389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOB/yH51AnYH17hSLOAEXfAOJQas7n/hm1VBQOje59Y=;
        b=frQ8tYzU7dnBy1URTC9rv5lRSG7/qAln34KAYcgD9XQab+CafIgVA4A9pZSE/zjODO
         1KoQpy+jj7nWPpRujLGqpfVDrfILg6dCfaMS5MyykKb2SOYGVS2lL3VynPazmumcsP3p
         jdkHsYGMakOxyNxA4+o8KOtAxyCVxvCoT/0CUCw/zqqoCFZpGWhWBAJtaralWYkZ2Jrj
         Hk8aNiQpMNn4orS20fQEf9wyXLybsKcdDnZmG+APNk5zUxzBAqonbfDHWHf6ZNFRcAFe
         KKdbXjqI6zNKNKtXk+H90jyz34+huaOjh9PYLeFQ0O1DDtL0KTy58khMIp2Twb4Xxxyn
         Cb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763024589; x=1763629389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LOB/yH51AnYH17hSLOAEXfAOJQas7n/hm1VBQOje59Y=;
        b=R/lWvCEVbrF3JM68SjBBO50mRy7qBvqmRezW7SiYMuV2X/PnkjHi1altzle/E3kjr2
         Y1jwbZveYvwFujHIbpDI64X/bWqFmY2X39yU5zNnnijdeTRkaE/Va/3Yq1EWhvHKUnGt
         bTXOez4c+vCDZz27jVORYXq4yKOdEgGDEeUkNAs6TdkUoZkjUk5dzL5gLBiNlRE9b0kY
         hRrCMWcU4yJnFT7snawsifQAQp2H5w2B31L7Zz7GTdi/gRS5keDbGwtJLB1OmGngZPwO
         OsGZAqFyBCuZFa2a0looWXKqtwdm3MMI07Ig0FlTrYicQ/Sayaw7izP8aNYFPL7x3SZ9
         hZ2Q==
X-Gm-Message-State: AOJu0YxdLPbxLuwTRLmK+Kh255r81ZuG+eD3pHdqGoq0jly9D9wr6Oz+
	SlRVnzFfgaRuRc5MMuvY8TEndY2VZnqrOqs3eVa1GmWKurFIdUtUkrAubvMYWC2lZsHIztuWLlG
	kzoF6Y8ed7SLPacwEqV8y2qAIZi6bjzXREBSNuQc3qjE8wpQnHtJDK5TP3ww=
X-Gm-Gg: ASbGncsQRZ3NR0Ixwa+H7z2jO9ksV+WoygdKJFdnnoXoVtqoYbREvd8KVCxithy+84h
	/iLRn3mXCkb+wsSknAHSLDQD+0W7+vureSOOeHfdEmbN61IbDvG1wsWF2KZG0ptJ7HC8WmJfNN1
	LdfGmqvhf5v0gyYwXGT4nTnFqezj2h47hCKAhfZEckcz+WwgRQHNOVjMEqOVB0P6DkDTLj9MKQF
	XMlnzTc8t/4vPtThYW50IXx7ab5SM/PCpEaAgMQYdjKrZA5w+FCipU2Yv8NzX40+amGNyd3/Lz3
	6W8xOw==
X-Google-Smtp-Source: AGHT+IHvM4Rr/it/OiXvTmOjjjZiPsM26bCYbWQbduY+0IK2KFcI3qm1XgKj86hqIY7kbsyGOcnmQ/Oz22SOtB+zXbE=
X-Received: by 2002:a05:622a:1354:b0:4ed:341a:5499 with SMTP id
 d75a77b69052e-4ede8b97449mr4152451cf.11.1763024589061; Thu, 13 Nov 2025
 01:03:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMOZA0+TMC8FsFfboe5RKqYNRxYm=cg602p5FXAwpyA64Y4yHA@mail.gmail.com>
In-Reply-To: <CAMOZA0+TMC8FsFfboe5RKqYNRxYm=cg602p5FXAwpyA64Y4yHA@mail.gmail.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Thu, 13 Nov 2025 10:02:33 +0100
X-Gm-Features: AWmQ_bkN2XW170H7YscZnV4Y26YQoQUtGfu887O4ULsWmcRf75dIjGdh4Sup1sk
Message-ID: <CAMOZA0Luhva=s3O8qawEf7YiKbUQRBeK0t4FX-SBTcPgRGOSfg@mail.gmail.com>
Subject: Re: [POSSIBLE BUG] behavior change in irq_can_handle_pm() introduced
 in 8d39d6ec4db5d
To: linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de
Cc: Luigi Rizzo <rizzo.unipi@gmail.com>, Sean Christopherson <seanjc@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 10:30=E2=80=AFPM Luigi Rizzo <lrizzo@google.com> wro=
te:
>
> BACKGROUND (just to explain how I found the issue; it may exist regardles=
s):
>
> I have some code (soon to be posted here) to implement interrupt moderati=
on
> in software using using per-CPU hrtimers. The basic logic is the followin=
g:
>
> - if the system decides an irq needs moderation, it calls disable_irq_nos=
ync(),
>   adds the irq_desc in a per-cpu list, and keeps IRQD_IRQ_INPROGRESS set
>   to prevent migration. The first desc inserted in the list also start

never mind this thread. I found that disable_irq_nosync()
is enough to make  irq_can_handle() return false
(through irq_can_handle_actions()) and that prevents
handle_edge_irq() from calling the handler.
In the end, that simplifies my use case!

Sorry for the noise.

cheers
luigi

