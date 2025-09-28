Return-Path: <linux-kernel+bounces-835515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E22BA759C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7AE3B61A4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 17:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCFB23B638;
	Sun, 28 Sep 2025 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEaY1OpE"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB322D7B5
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759080959; cv=none; b=JszMKK2HUY0xkRhGwJhuXLa/UEJrbewdxvoe30OIfCVZyKh+RmAL+DvnJiq1bkIoeQmksXX/ujvakZIWjYssTTQig2o+CyOu/oYaltkqfhXctsjgvIvMtGwzP/1OWNspwloxmBFdsyYar0iG3zzm/76ZdIggERiUY1Kv+I7ABBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759080959; c=relaxed/simple;
	bh=1hWHgpM/rb70qd87juqmeSrMZFHqG1itquQCJwHGhEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VG58MV4LllokcEbpG5FPKW228UU/terXZYX5eJP98T5B1DJzqCIfZfGJjclcsxelHcvLT/V7uExvu5Xr60wA9bOZyFasJacugTpU8nG8dSL8OC0jSdzr8ZDfWUL+RWEnI+y+meHkwiOAj1bnCzwm+Fw9HNzB1toFytXN+CVlZro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEaY1OpE; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63486ff378cso7507337a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 10:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759080955; x=1759685755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hWHgpM/rb70qd87juqmeSrMZFHqG1itquQCJwHGhEk=;
        b=XEaY1OpE/dFh9j4YVGsxeLW4nk+JFwe0xPU09XYNqFVJVfkz9/YKmGA98d0gTte9Bb
         djtUHhO3mEm/g+z/tflYqgw0BtjK91KiLlZFg2KuMsI98UcnbrywSUlKEf5syJmuUYwu
         xevmNeWOz9dwjA3SsPPH9s+wWJ4ed75E4NMp84AmbDD+VpQ44dOC8sckBBP56GvafQyj
         V3Ne6Kq25yZjYpNjlPaKIjx3T56b7QxQ+cNsAVlk9s60XpIcce/auME6UmP9kxJaQHmk
         Cq2SR1jCG9crhZ020EAYQ/6KssWrbr5CY8GrgyoZdKIfdJIwET9JFHbp4Aufx0EOCncF
         8iOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759080955; x=1759685755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hWHgpM/rb70qd87juqmeSrMZFHqG1itquQCJwHGhEk=;
        b=JX+asFopdlEpCYYgE0W1lVBgzxQJo8xvHYuthAgxk9AG58yBxxh+wCxkNNfnd1hbuO
         sD7sznvYNvZsQ/EBhirKN7IuBs6pOv6iO4YO89SXr9DP+Eox974/Pz0n8XbskCpIiM5Y
         mo6vqEdHxlUD7ZH1p9pZf1+UfZNFRM52GXqhJhscUKzeOAKojdQHztWnaB48axN8VemJ
         zpv6mY/MCjdqlOQRI/RX/6DhElUe6RSvR29pFp4MkP9X99H6vc+7qLf39LeGoHNhMgoC
         dt0bV5J/40F082xEdgPabGmFj2h+VQmKdLOa1Ahf4C+q1o5dlNL2kGWj/SGz3dOq8fZK
         vO6A==
X-Forwarded-Encrypted: i=1; AJvYcCXjQLv+0LkrS1mEXvJsNH9l8YbzzyLHCH3EGV1lND+b+Am4w5V3O2lo12fcqM2JKw0yzqt4fvThvNT5ddE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhaOZKifHALp6QmCZlfolgvyMT8nBjz4+mDB6MCcIJTxmiV424
	M6mUV9xYvk4vtooUHHobUWvo8MSQ7O5MxobdR0vKEZ51rMmOmVafg02DD9qid6lVFYtKi8HPan7
	zdFQ6jiiifq/j4mlqhHBSjR1VceGeS2k=
X-Gm-Gg: ASbGnctoF9Zxhu3G/PpdiplRdiL8moBt6Lxafu1drOeyLaYRQqwSK3rzcjjsqsVRlDy
	b0aZSCMhq2+5FJI8cC0fWKcMWCcwQjSv10/hy2ozqt5Ea7iujtEoQRi9NeOh/zZIiEXeriPmBLh
	1X+OF5joxyJaXUNn085k3FmaVk6S5Nf8TSU0+y/nu4/gCuB8fYk8Ersh6DTit1dBxR8cfrwyhhw
	wNOG5u1ONGNADZ+w6g=
X-Google-Smtp-Source: AGHT+IF4LtUw7v9U/JYoQT0Wh7nzvSFhJ3UqproTerTY3SiJCa0Vl/rRvk3JMudUZqWnlv9RN4X9SRqdzNlv4OAcKN8=
X-Received: by 2002:a05:6402:352:b0:62f:453c:7235 with SMTP id
 4fb4d7f45d1cf-634ce845b9amr4127811a12.15.1759080955040; Sun, 28 Sep 2025
 10:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759071169.git.leon@kernel.org> <512d4c498103fcfccd8c60ce1982cd961434d30b.1759071169.git.leon@kernel.org>
In-Reply-To: <512d4c498103fcfccd8c60ce1982cd961434d30b.1759071169.git.leon@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 28 Sep 2025 19:35:43 +0200
X-Gm-Features: AS18NWBtQV3w4fhUJT0qJjc42RZ2Y4lnsCSX8_2AFcicJQutzVlCWs2uQTVZ_oE
Message-ID: <CA+=Fv5SzdR4=NXz68gRg0iXY-6Y=GRsO24UA-DF4tuyJ8r7w7Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] alpha: Convert mapping routine to rely on physical address
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Geoff Levand <geoff@infradead.org>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, 
	iommu@lists.linux.dev, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jason Wang <jasowang@redhat.com>, 
	Juergen Gross <jgross@suse.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	sparclinux@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	virtualization@lists.linux.dev, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 5:02=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Alpha doesn't need struct *page and can perform mapping based on
> physical addresses. So convert it to implement new .map_phys callback.
>
> As part of this change, remove useless BUG_ON() as DMA mapping layer
> ensures that right direction is provided.

After the changes in v1 this runs fine on Alpha. I've tested this on an
ES40 Alphaserver during load (build kernel and unpack tar files).
The v1 patch fixes the errors seen in the first revision of this patch.

Tested-by: Magnus Lindholm <linmag7@gmail.com>

