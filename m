Return-Path: <linux-kernel+bounces-835069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD1BBA62EC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 21:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D4C17F026
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 19:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD7822D4DE;
	Sat, 27 Sep 2025 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzCAcnBs"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14C16A956
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759002158; cv=none; b=sUiCCFQ1ZAqmd/AnC/7HwxrrP+a59hktf7MwcvBb6qPNy34wfE0BVecK87EZlb98Q+UmoLS+8+9NJyryA3iTsL6qpjU1tcBtela469i2uBQrzePFDF4RquDl79sXkzc0I4ZkKQFGzX2718e6LWQIJk7I2EWkViCLEqaueiuMf98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759002158; c=relaxed/simple;
	bh=6xQ9bzFk69iukmKUY25ufCAqjrKMzVtKfHbiTqiaUsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mop3VaZSn0Pj4DQ7AdTCFwwcF90ANV12D5/rZwcb57Dblt/9JlPpakLsH/8vnKGKN5OOo0rBSSxjVXWonklJ93ry8qdnb8ynv1SiN+v1UhYU+isN1RwIo2353X5n3mN1DOtIQWIt3Xy1p6zmNXGesrCcPlZspv1BM3jz/fvygqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzCAcnBs; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-59dff155dc6so2036924137.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759002155; x=1759606955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xQ9bzFk69iukmKUY25ufCAqjrKMzVtKfHbiTqiaUsA=;
        b=JzCAcnBsgRzq297kFaoqSfI42HnzpWsgrqfN8m7wGU6mF2MDzPSNIRHpZBig6I4v9n
         hh4VjsNH6btMGl/QFhxL+SJQ4mRO7rGdN72yifQhLd1dr/x6LM3SEmexPQyuxKWloMRn
         R45fDgKKR0Ld1ndURMUFwXRDoXbNzwpWqx17Lak26CfwnopQeAADpN7wYKenRSWL72p5
         E+4W8z93AmNuDd8dWotqRS8R4vje2XE/sa708iTT7BQYRGJ0omzgoRpe0ge9IT+nSEQ1
         ulNmgke6aI1CrGAWzfOUjb05W7RBslPhxuuETjiuPXLSMF32ftbbZ5oS4d+nOOsbH80G
         6WbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759002155; x=1759606955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xQ9bzFk69iukmKUY25ufCAqjrKMzVtKfHbiTqiaUsA=;
        b=w3PQblHNH0yKonloy0iZ7qBNsBqiXnZoJ12YvqNpZqcW6gObwSmGrIOVI/s9q1Yg2U
         DJrhFhCI2xi6/13lc3eYup70JhbPH4PggspfdZWlq6q9XQFrBgeXoi3uqXtOFQ9j/V+W
         9t7uk30qvZB6EzEVaTl+R+A5lICek61ws0jriFd06JqABly2a0qiOuaI0kH+DfmadB5q
         3p8j/1a5iUJm4PeHAVDZVDs1++DrHnVzI/DlVPaMWilpYKwOGW0eH53pKNWsGYVpFAxc
         nhLUNN+zY75fK9kLk7W1HRAew4C6DUiSsUoL+AgFvmSKHNJ55e/iZMgfOYPIReug5IOu
         92xA==
X-Forwarded-Encrypted: i=1; AJvYcCVhkAS7AtN4Q/M1J2Ctg15eIgH6qIgw2XJPd2G/48quIvB4ToaE1z3zNZ9orCknEEczqlg/5w1kmsNyxjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8PdmEEfWEyJ1LUzdwHkcqJKR2Mnts5SQ1LgiD3ZTw0K6aM6+Z
	HZ23s7F+cDX4UNMt0m7l0MqPRBcHMxTXpV5DHwabGbxFhYcq4KogDnpK0bzyN2rA6A16MYoroL5
	aB/txWG6gnIFt7L19znhiVMu20v6v1hMnOw==
X-Gm-Gg: ASbGncvVTY51mUXjXncXqUER+lJAT6p0g2gPOUDAZ2WgC05cpTwkQ83SsZJ63dnxtIT
	WZqXK3FEHdg5stiU+cTSsNLWdr+9CKwwbf80t3BKKyuwsRi4TvLqFKusz4ZDS+65fJK+ifmPDLp
	D0EXq0wwTUm6cJMAB+3hSCpqg5pm47Q4SJUqAWmwZr1foxMZ4rpL6O/5Ls7pkP32TcwESo+Yocy
	VjgSbbBQvBLYFapUGNO1/PIITmIAxq7bSowWbvbZ74Wkjaw0DQ=
X-Google-Smtp-Source: AGHT+IGglDo1/gdOcNhsuSzZl7FEO053NNm+ZSGFGErw4ULSPn8POBz7Kmhwj8faLx+8S9aP6qgFUy5HNQzHFDYGmS0=
X-Received: by 2002:a05:6102:6499:10b0:5b9:c38a:c4f9 with SMTP id
 ada2fe7eead31-5b9c3a94dcbmr1525519137.31.1759002155340; Sat, 27 Sep 2025
 12:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <20250919212650.GA275426@fedora> <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
 <20250922142831.GA351870@fedora> <CAM_iQpWO71vSV_0qXiUYeKYZMYF0xWNz8MrUVRkqKwDEtQvKqA@mail.gmail.com>
 <20250923170545.GA509965@fedora> <3b1a1b17-9a93-47c6-99a1-43639cd05cbf@redhat.com>
 <20250924125101.GA562097@fedora> <CAM_iQpWRZ-vihMEa=k-j9EYN9itUeZLhZ14AoCvZ9mturFxAyw@mail.gmail.com>
 <20250924190316.GA8709@fedora>
In-Reply-To: <20250924190316.GA8709@fedora>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 27 Sep 2025 12:42:23 -0700
X-Gm-Features: AS18NWCeP2cGzDoATwSVHNUS5qX7kDmrKwGEMa7Qt3ofJhYYTiaA4U-AxyJEbYo
Message-ID: <CAM_iQpXnvyZWrv4W45SBTDV-tCXU4Fz1=S8z_0s5en+U29vSZQ@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, 
	pasha.tatashin@soleen.com, Cong Wang <cwang@multikernel.io>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Changyuan Lyu <changyuanl@google.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org, multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 12:03=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> Thanks, that gives a nice overview!
>
> I/O Resource Allocation part will be interesting. Restructuring existing
> device drivers to allow spawned kernels to use specific hardware queues
> could be a lot of work and very device-specific. I guess a small set of
> devices can be supported initially and then it can grow over time.

My idea is to leverage existing technologies like XDP, which
offers huge benefits here:

1) It is based on shared memory (although it is virtual)

2) Its API's are user-space API's, which is even stronger for
kernel-to-kernel sharing, this possibly avoids re-inventing
another protocol.

3) It provides eBPF.

4) The spawned kernel does not require any hardware knowledge,
just pure XDP-ringbuffer-based software logic.

But it also has limitations:

1) xdp_md is too specific for networking, extending it to storage
could be very challenging. But we could introduce a SDP for
storage to just mimic XDP.

2) Regardless, we need a doorbell anyway. IPI is handy, but
I hope we could have an even lighter one. Or more ideally,
redirecting the hardware queue IRQ into each target CPU.

>
> This also reminds me of VFIO/mdev devices, which would be another
> solution to the same problem, but equally device-specific and also a lot
> of work to implement the devices that spawned kernels see.

Right.

I prototyped VFIO on my side with AI, but failed with its complex PCI
interface. And the spawn kernel still requires hardware knowledge
to interpret PCI BAR etc..

Regards,
Cong Wang

