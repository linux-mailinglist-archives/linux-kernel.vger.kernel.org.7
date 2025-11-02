Return-Path: <linux-kernel+bounces-881935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC49C29445
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 18:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF09B188CDAA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 17:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9A62135B9;
	Sun,  2 Nov 2025 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWnOZQmL"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256CD2BCF5
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762105804; cv=none; b=U4SRv6dKrTZqozzoLIz/CQ7zwh2yrrz+uXWiYtUyqJDrzdZaaeXN9/7q+4frG5fYLd/ONwpkrihUoYbecQ7hFxpcqpir3c7P4VP3RfdkUBoxCKQaV5r2Q5K2kJpHhBlKqHrmMUd6kzts3x4e/ZLsBcv2lUagIh2pzStHgUjJ5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762105804; c=relaxed/simple;
	bh=PKuLXyGpDcCEZkqcVfQFI1pVc6mP+RuSlOflCcXwco8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dgc7LhCmbYr8nHhJlpa1xEAhSpgck0Letfsxxgl3Ba4MiZzppOZ8w3Ahkthb6QvFSJ+TXvraRK6TKB68BHr4ecNFXBCnEGCY8RSsxkTLtY4WFTpscpcXUULgyJuKbSDYpAbLVc3rGnbj2HSzudquUvKEvdQURh5i6LSLymhqMcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oWnOZQmL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2959197b68eso119105ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 09:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762105801; x=1762710601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eQOuzyVymqrjJN7nLk0xcoaAwNBEOp8HsZ+4tadSh8=;
        b=oWnOZQmLPbZ4zoVGI6dHJWD5n10bD12EqRgjhaFGmUBAK0kwg+XzGyuWEqD1UQRkfO
         4yPwZyzZhl3RioyHzqUnym6HwLbva0dDy7FX3rAR8HGoN/qCbC76mmOpaLPll9dBibul
         jumtAdieti3oVsrPRPr+RIiJn5GfYhKOAcP0/xc83htwWqpgukko3ry8WKLQFVRmhAGZ
         6R1nG+9vEZxN+/FV9aVkHqnjF3fGL6txAmdixR9djsTbqhC8Lsil6jXY5anTczhHUDgo
         mbb7Z5RdNw2DcRxurKXugHx3W2hYgg229zjG/JIVIwUMLPTzESfpuNMGqjHxtCkDzXYG
         8cJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762105801; x=1762710601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eQOuzyVymqrjJN7nLk0xcoaAwNBEOp8HsZ+4tadSh8=;
        b=oXMx7/LUlgEVHYuykudTy/izIAjv+J2QnBs4UwwsiaqzCKc588072M0EyWr1UNTax8
         Yt0wsWF/0f3uUVFbkROvO0FTW4PM69S7yBXFFF7vPqGTofgAsJvj9TK6+jF7ewwr1c3O
         46sQec5MW9Tu+8z0BPeguOTF51dkQ9l9fHeoqTp2V54gX275yjH1IPE9+z8rLDWa5sUR
         iSXAAcWz/uR6b0KyGdyLk3EK2aen0arrpI4MS1IdWh1GYidqixOO583E+xUtu+orzSzV
         cIqzbIao07LW5UWL4cDGgVq4WH97yuxOwIM3ezWisRPjwUvy03NjnM773lwREulV26fa
         YZrg==
X-Forwarded-Encrypted: i=1; AJvYcCU4/8zKfipubohUuRKiQlzH2/dvwHRHZhQ/8chY9GadeZ1+g4ZzN5VRPe1PMf46X0UWVAhWp9NEWG6zaEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP8hiih4yAXBMAoA8M2UqhfIL0ov1XbRTFax/ZbAieD0b2wpwn
	B/DjoxJYM/W0FDbvapoP4/Hu7g4HPi/r5WqYtbZXU+xbB4i5L/+CC/Ml6aBIr6sIIMROe0wvsth
	q3xQhIeRLPN0gTNQXp39kMt4LM9ckFgFKtoJ0twfL
X-Gm-Gg: ASbGncuZLy4pgVKZFcObgho1t6BCT3trHs9VUVA5AEPCQiFkQy4C837RufmLdHsfZej
	PyccSMt2PIi5BfRriyn7ZeWQB1GMjrmGfyyJthCy2ZIU4R6E8NE3ELKmsKL31+mKQptPIF8FhH1
	qmMJfU3p//F3VYa+NmXkspdg2+EKdXVyCNFTuWyCLWHuQ2NaIsnXvNWTqh1lXqFfFFligVN8flf
	mpLA0+qjx+Pzv8BJZLAhwW4FmTeVufPF/HS9XJ5NUi/abm6BKw11YMC6/yhRpri2N+AeVx8MtGb
	hPWyA9gi3ruFTfqZwUc=
X-Google-Smtp-Source: AGHT+IEAICGtm6NZwDsByzAJ38ijLdVal4l1vq6PUUUbo88S4qCmpEjKeMXQGMqibYfiyxUc7Vr67BHJv3oovdCQ47I=
X-Received: by 2002:a17:902:cec3:b0:265:e66:6c10 with SMTP id
 d9443c01a7336-29554acb52dmr5165755ad.4.1762105801057; Sun, 02 Nov 2025
 09:50:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
 <20250917190323.3828347-4-yang@os.amperecomputing.com> <f24b9032-0ec9-47b1-8b95-c0eeac7a31c5@roeck-us.net>
 <933a2eff-1e06-451e-9994-757d66f4b985@arm.com> <bee6b93d-aa2e-4335-9801-89f02eb3eccc@arm.com>
In-Reply-To: <bee6b93d-aa2e-4335-9801-89f02eb3eccc@arm.com>
From: Guenter Roeck <groeck@google.com>
Date: Sun, 2 Nov 2025 09:49:50 -0800
X-Gm-Features: AWmQ_bltYJ86Q3HtfXxhBr-_kg1IjduAALHrq3mVP45Prvfz_NGkLOMlSeQlc50
Message-ID: <CABXOdTeOU0qeSicdDU6DjNHWpzCEhK-66kTdwWjb3M+=Xr3aMQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] arm64: mm: support large block mapping when rodata=full
To: Ryan Roberts <linux@roeck-us.net>
Cc: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com, will@kernel.org, 
	akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	ardb@kernel.org, dev.jain@arm.com, scott@os.amperecomputing.com, 
	cl@gentwo.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nd@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 7:09=E2=80=AFAM Ryan Roberts <linux@roeck-us.net> wr=
ote:
...
> commit 602ec2db74e5abfb058bd03934475ead8558eb72
> Author: Ryan Roberts <ryan.roberts@arm.com>
> Date:   Sun Nov 2 11:45:18 2025 +0000
>
>     arm64: mm: Don't attempt to split known pte-mapped regions
>
>     It has been reported that split_kernel_leaf_mapping() is trying to sl=
eep
>     in non-sleepable context. It does this when acquiring the
>     pgtable_split_lock mutex, when either CONFIG_DEBUG_ALLOC or
>     CONFIG_KFENCE are enabled, which change linear map permissions within
>     softirq context during memory allocation and/or freeing.
>
>     But it turns out that the memory for which these features may attempt=
 to
>     modify the permissions is always mapped by pte, so there is no need t=
o
>     attempt to split the mapping. So let's exit early in these cases and
>     avoid attempting to take the mutex.
>
>     Closes: https://lore.kernel.org/all/f24b9032-0ec9-47b1-8b95-c0eeac7a3=
1c5@roeck-us.net/
>     Fixes: a166563e7ec3 ("arm64: mm: support large block mapping when rod=
ata=3Dfull")
>     Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Tested-by: Guenter Roeck <groeck@google.com>

Thanks a lot for the quick turnaround!

Guenter

