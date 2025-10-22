Return-Path: <linux-kernel+bounces-865397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FE9BFCF9D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F324B3AB2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B6E24677A;
	Wed, 22 Oct 2025 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E0TC3giI"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3778A252906
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148315; cv=none; b=DKHCsfLy8Qyj3+8wRJvC0ymrAwHvh9tCDi07rDkly2HF2UUD1K84JSU7XnY9JS9hqBMMYgFEEKReKjj4cWs1LAvsZz7U2AdZzXRJYU739fYOiaPP+14xRrr6e2C0nu4SQojmYUr7T09/aGOlpje+G1TRx/WelpbwQhXrcp8+T74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148315; c=relaxed/simple;
	bh=cgJzKa03GZx576mtvOE16DNtsuFs0o60bnNsCmFfVIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/igWc+64pmXG0rVwOVrgUoW8796BkRtF2A5teilbZqzaL2izUzWFnyRTXOJYKDkENlLUPoO5ePrT+PAP9Kb9bdSIIYMuwmbcTNifovHqYcdeSygZDWfHTT77ScFz6x+061mZw7tZRj8O54amGxmGJKzFFy5q+Kvb66QZLeBtt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E0TC3giI; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57e03279bfeso1702450e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761148310; x=1761753110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgJzKa03GZx576mtvOE16DNtsuFs0o60bnNsCmFfVIY=;
        b=E0TC3giIFDOMyDGzIoJjKGHvrcwto8Fd8sWIwO0Mc5i6K5X7MGeWTZ+tFXTCXcqAD7
         UVZiO0u2cWZzQJWtrBwSAE8Zqvp7SaC15Hbf1PSyOaoWxpEtlU4vxdeietVDGNS4F0BM
         8b6/sHV936wOeFNi6Zw7H/GhPYsLP2pZMQGeeIqXB8koIzlzWNyLf3UdOOYgodrdNNzE
         SnbwnJhPnl4nnFLXpCztNiyvga9MIx0JopMBFXGKfrbpm/ahJqS3DRJtYkx0MjRUloY3
         HwRB7Za7yS8K0ipDMXqS1f5fbvvwWfSM7Sm9kvfXTB7UjFPfCMbnBtpbQ2B452fikxUj
         vMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148310; x=1761753110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgJzKa03GZx576mtvOE16DNtsuFs0o60bnNsCmFfVIY=;
        b=RLyDaGyjQNhxt/VQTO41/7OnTqtnqaMiXjctmsG5ZZ24WNm5UOwNPNfuVpnluCw1oE
         vrYficyAHAd+UfMZZ5z+Oj3u4ubJC/NnOiimzNbc5vbzy6MfBFcN2xyK5pY8N0asu6UZ
         aePaBA9EqD9IPxg14BueWnq0qTEZ3I0XLVbXyhYsc3UemwuzlDBHhmzPo7DYGc6sq9qt
         vNs955gCnSQPDPr04Z+Xp6CyXdF97U2rfJzgPcPvTlr8XeAuGnQ1PncznzOYMrw8PstL
         ksw/gESHaP5eq7EMMlPqD1ZUDJabf9y7BRrLF25aMihwaXcVm04Hx/uFsFYoc3qotq+V
         dCGg==
X-Forwarded-Encrypted: i=1; AJvYcCWMKz8/Scz00NAV7xx1B8qD9dgI71SWBj7E5yZd7oagbndVVBCp4WpXn4D1s+pl/QX6nHx+HhO6Nf/iu6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG7cFoS0xuW16NdotY4g8/pkktcoUTWaACu3anEHOvHxStLztv
	zwekQF159RB2wtGwfJ1ymfWma/SQW6YItrssuMrZkmKg7KZ2CCUDmXEOtg/35xR7/Z9mPwxxAJF
	H3KzcJz1JJ6xLGDoaB2p7j1GWFoTBTayRXMddBBdV
X-Gm-Gg: ASbGncv+0uzmxTQ0oae5TCG6aVhXu8nOVHntBDedl2yhtC30JwaTc+3cZDIN+C3GzxW
	SIDRbdGWC73+ysN4N6KBBe96NPSVoiSPa2KPL0GU+pIe423maLVzWGBEiaAb+Pgw6H+Qd0Kws0M
	ymJnqJA3mfCl1lxCVT5XfFmy3VMtDRw89W1OzC5DV9RSvZGnSmAvxc8ITyEKKp4KRcOIovDsWlq
	Ghsniz956Fbi3QNfRLo7fl1k1Bdp0LFHjAK0qugPPb3iff0H4wDqpgvuMGAYsMXVUMLmupEu2fk
	ZsLqmRaqD14Q1uumg2kXDpeiRSxJMtSmWG0o
X-Google-Smtp-Source: AGHT+IGSSZ7EkpARJ1sowKr4CL1x11+h9n8s+EYH3Pd7Tyt3wlYGrWJ8L7t1Eu8PFP6//7mTYXclA5aYbFj49+berZ0=
X-Received: by 2002:a05:6512:3b93:b0:592:ee37:935f with SMTP id
 2adb3069b0e04-592ee379490mr907046e87.23.1761148309624; Wed, 22 Oct 2025
 08:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020100306.2709352-1-jasonmiu@google.com> <20251020100306.2709352-2-jasonmiu@google.com>
In-Reply-To: <20251020100306.2709352-2-jasonmiu@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 22 Oct 2025 08:51:20 -0700
X-Gm-Features: AS18NWBmyjziaOJx6tw5QC8WegdDZjZcbgLt9Q6UtW6D8PSJyvC5fCPozboF9U8
Message-ID: <CALzav=eqwTdzFhZLi_mWWXGuDBRwWQdBxQrzr4tN28ag8Zr_8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kho: Adopt KHO radix tree data structures
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Rientjes <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vipin Sharma <vipinsh@google.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 3:03=E2=80=AFAM Jason Miu <jasonmiu@google.com> wro=
te:
> diff --git a/include/linux/live_update/abi/kexec_handover.h b/include/lin=
ux/live_update/abi/kexec_handover.h
> new file mode 100644

The need for this directory also came up in Vipin's VFIO series [1],
so let's align on a directory we can all use.

Should we s/live_update/liveupdate/ to align with the file/directory
naming convention Pasha is using in LUO (no underscore)? [2]

Otherwise, LGTM.

[1] https://lore.kernel.org/kvm/20251018231126.GS3938986@ziepe.ca/
[2] https://lore.kernel.org/lkml/20250929010321.3462457-1-pasha.tatashin@so=
leen.com/

