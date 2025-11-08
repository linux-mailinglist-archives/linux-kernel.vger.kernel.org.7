Return-Path: <linux-kernel+bounces-891303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A08C4263A
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 04:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1863B44E6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 03:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907A7227BB9;
	Sat,  8 Nov 2025 03:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmEDBOKL"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A29248F64
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 03:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762573698; cv=none; b=sM6pTFFWKebOdx5ILaA6keQY6gDwPkGOwv3Z/PrJVbox2wiUWS5AeeQOw5DwPwQefseL9zMGcR2JT398QbvE/6AuWtplfm7HUbXBx5HwLRhG1+Jw9eTvTZg1kMiUaztquqs6gvxHhTnrE80TgrEys0ESrMEPy8bJUnKu1r0AwKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762573698; c=relaxed/simple;
	bh=g6qBYlNsvEJP9TH5pmvQjVY0nV0/L4FtBPDF1Q4xoxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHJa1UdC3ydi/qGDYJyHQ1sxdBIK/UJXN2AWVdS5Z8inbKqMSym1P3islQ7nMu1QTT4Dg4CYxTaL6QKLXqTwdQ9IvTRudBbsQ0rECQE6tDQP6+Dq0/rW11reJ2yZeuvra61vbZagiqNVBo+KVf/bgo8mYnvhq2k8B/DNCPsFuZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmEDBOKL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29599f08202so16937035ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 19:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762573696; x=1763178496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6qBYlNsvEJP9TH5pmvQjVY0nV0/L4FtBPDF1Q4xoxc=;
        b=AmEDBOKLB2bUB/U7pjK6ugmcuEFR+wq4eAIM9eGWt6q7T6Cm+DK1dOa38I2jO+PQZ8
         agdW4pGdAXzMVrTzTVxq7fl8gAChwdGtbudaNursP7rIrsHImMVvQXbJcQL+eNmlRg3o
         bNyCmOIKVbyUJPyxULHaOg7/+xBFp/MbTlQ0SQ8xTFI5+f3jXGmuO8zz9ZyGxr8l17I5
         zVWQLIHZbG9UZiZD70Lkz+nIeff4rvoQi7sx3wI97jOY38FpTHVrFUmASLAtSguF5jcH
         s3GgeAa9Oz7pRD5ImNdzqXvPUCL5Oq5gbb79ewnfta9CfG9hyg9LsRg1Ttev1TyT5l7v
         aBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762573696; x=1763178496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g6qBYlNsvEJP9TH5pmvQjVY0nV0/L4FtBPDF1Q4xoxc=;
        b=ktI58qETD3z6DmyNkS8X396VqofxONjE025pr7rmWO/aGY/xMiHsKbG8JhxPY84o9o
         DwNr8nAIQSwXfRncbRauqPOw1Mul/Hb0PGuj3eSYBZ+VBL/7taCzcIZvqjWm+03eApFI
         ioqrZdbhbv+7YTj2HEB2N6vODOk7AaP19W9rD6hwXbJDylM88FnlHypMjHINWi0JgYM9
         +gXcLhBCXHOH+XyZmeMjh4x3MYrVaQlMgFwPBpui2tp7/SzOBo/sI0Z1TiCQVdTt2JK5
         0eACg1AY6EcxNaDYDArGNaId2ktCLD+Xf7B0PO/bm86ZuncR7XA+BgSxo0eB/K8QV1Lw
         4xQg==
X-Forwarded-Encrypted: i=1; AJvYcCVtKY8ktRM2RY2yH8dBHeg92FCCPQzk8sLeaSE2+CHEf3IhZCufWT7SD8k6JWFd6v60MLxrjNWSBunh6kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEvVc+UPXhTpBTPFdFKQmQ3p74IvEsijrM4bpWe/MT1luNC05S
	z9eweh9kP4zadNihJs+37b5advAbk+5EPaXOm50XAC7zcKOPA6iybtLA51t8gTYyMk533YcFacu
	J0qt/5iayeY4mWnIQtoS0UTdz634utg0=
X-Gm-Gg: ASbGncsFHjNTBBIbsmfX/WAWSMeSvgOqgJYSx6gewJSP8n7Js9QXtfrZ4AwE7BPcOoh
	36X37lJ1d2nLFtAEgTCSrSgx1HgKHqnqDdCcJCXe89D9PMBzbpHs6MzOs9srxeoBi+buYegI5jZ
	y/eYCI05jVe9Lx9BKh/u55KVgG0Y0wOV1/Nzvvdx9bKWSlhLUKQAJpbYd5tzH1ub0DglmZCHvIF
	hAlLmKaseic/aEHGWBk+8GC68Rd0kKs1rM3agBUkY3roUBVHUUHCkndUxH6NSXb6Qapong=
X-Google-Smtp-Source: AGHT+IHa9akAHnfXW7MjrEDntgAgmnsrMoOU0VMEeysg8ikJ47x2hE8nWs2Zn11ikMGKssYt6R8rrK0WBG76j7RjdQ8=
X-Received: by 2002:a17:903:198d:b0:297:d4e7:3066 with SMTP id
 d9443c01a7336-297e562ea48mr17028595ad.18.1762573695851; Fri, 07 Nov 2025
 19:48:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107041002.2091584-1-kriish.sharma2006@gmail.com>
 <20251107153733.GA1859178@ziepe.ca> <c9c8b90f-4edb-47da-8ad0-94f9e58d71e0@nvidia.com>
 <20251107191736.GC1859178@ziepe.ca> <CAL4kbRO+p0f6cKLONf=qqTU32G2YCEtkgQpu6shX=zBeAa1vFA@mail.gmail.com>
 <1b9b26a0-ebc1-44d6-ab6e-ac49126bd6a9@nvidia.com>
In-Reply-To: <1b9b26a0-ebc1-44d6-ab6e-ac49126bd6a9@nvidia.com>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Sat, 8 Nov 2025 09:18:04 +0530
X-Gm-Features: AWmQ_bktDRxKXHdnQRQkgDiqctnok3Lp4iS-hqmxZbQneqmRzpHV1JgL4zPlHao
Message-ID: <CAL4kbROVnD4BVB3=BuOCQ1=JUnD8UaZXJ2rV1Qaq1To6xvfofA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/core: Fix uninitialized gid in ib_nl_process_good_ip_rsep()
To: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlad, Jason,

Thanks for the confirmation. I=E2=80=99ve sent a v2 patch incorporating the
suggested check in ib_nl_is_good_ip_resp().

link to v2 : https://lore.kernel.org/all/20251108034336.2100529-1-kriish.sh=
arma2006@gmail.com/

On Sat, Nov 8, 2025 at 2:36=E2=80=AFAM Vlad Dumitrescu <vdumitrescu@nvidia.=
com> wrote:
> Can we have syzkaller test it?

It has been tested with syzbot, and no KMSAN or other alarms were raised.
Best regards,
Kriish

