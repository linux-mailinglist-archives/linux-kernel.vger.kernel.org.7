Return-Path: <linux-kernel+bounces-749426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C807B14E24
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441F13B1A77
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4294236A9F;
	Tue, 29 Jul 2025 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XE7qB4jH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC9E1758B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794754; cv=none; b=RbGqTpYbJU7NA55M/Ln7WWI2l4c4+5jyUrkgybU8VkBnxFzwKVnwvbqOsz8uoZHoHm8eVqLFeA7/DRhe4q+lnAcq+bJOensUoekTTB0WYxqDWUpBzH5Kzbi0NuaPVdfTX20DzemtqmtrQPtE9S1hVSDStou8TPxMNwdyTovQSjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794754; c=relaxed/simple;
	bh=yGktK75e2PayS3m6dLJKhN+QyBnGs9rTpFNh5Uw1tH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1k3Z4Do6/j0RqluDWJl/PzJ0HoGWw0AveFfcpyb8NH1qOv8R8Kpdxg8H4EDgjwWrljOIYjYcEgJ1KWVXC0ynd0fF3TwTH4bQG5zdsgiNutgsqHSz71Zh5lkB/VQ3TFBO9+0sH5pjAOU5Tg8bIjUMEKcUWmQwqEDvvTaMHYrxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XE7qB4jH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753794751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGktK75e2PayS3m6dLJKhN+QyBnGs9rTpFNh5Uw1tH4=;
	b=XE7qB4jHrLlga2CFLQUStx8Gbhy74hlcLXlPpiRfK/5XGr71wuy2LPkibzqeQgnBAkU/HM
	RapGPx77Q9rY1K/BvA7cpoTKqq1gT7+RG+VDceo8sCvTkVto12aTXd5cXlUQ9JQrixibCI
	xS9rswX1mQ9nMLLlTT18nsEDVu4J8Tg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-jeW6ChuAN6mSq8Zg84q1JA-1; Tue, 29 Jul 2025 09:12:29 -0400
X-MC-Unique: jeW6ChuAN6mSq8Zg84q1JA-1
X-Mimecast-MFC-AGG-ID: jeW6ChuAN6mSq8Zg84q1JA_1753794749
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23fe984fe57so40042315ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753794749; x=1754399549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGktK75e2PayS3m6dLJKhN+QyBnGs9rTpFNh5Uw1tH4=;
        b=vipdcVKjBxbkwLjYAJChx48uOhOzm2T+29Xu4JjtvDt4P+dL4LPC0R4VcX6qsJsie4
         dcJ1KxiOdgIGUvTBzxnDF0/qOxdV2MuXXKw+wuRDoHqlbIc+DnI+yDYkBQ7M9ovBBtGc
         rWmVB7oVQ+fv5yKCcyoT6d7Bg0ab24GRTd1qQNQzf+A8WYY8AtJzlbWItXQuRyPptwTl
         GsFOwwyQt9cEFpY/E7wDRzqiN5PfpQu1R0nvfUjst59sjQo1RqvTj7oC/l6pyGnOE1ko
         Y4Ixk6yAu6Vf+NYDnAN0plCbYQ8nvNE3FgfFefQp8gbFVslDofkBocibyKHUwAEAZhx8
         Pg1w==
X-Forwarded-Encrypted: i=1; AJvYcCXVFFb8K5+8HxMJ7gNsgN9rhq9nIiizaLjBxJ+sZbM/tzJWB6i+9R3S9w7Dj8z6/f3VfqQsNdHHesqNPi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmrqy7cHvMzefoDmnHK4pYWt1AY/BAXauir6Qu/OiZZic/7+ZI
	gjxFmmkPoNV4uOncwa3avW4RQjqKTx/MisSb8yy5rv9Ol94KL5rO5r5cHR1RLKVPE0APEnuvLOX
	XMzo8lvnKWmOWnRrCNbO0q+15WfKv36NpjKHG/GJOhWNS8ynDMDdKcGPjLE0cX9gGdFUJoocPJk
	0NdlEIwwX+wdVAk6T0tfBpjxbb0+6z4JozUkrQFwOn
X-Gm-Gg: ASbGncvdyQl5m2SwCvT4YmzddXSj9BOYbB2HPNRavx/JuOeAtfjA+4yGUYUv7qWXL3P
	fYSOoRvs9uZn0SWDw8oeDHpAzdtBR8rWP8VzAag4EV3E7LUzixvh6kM1w4+Xs1mI2XUELPpVSYv
	0bGoUOZFnvtstE3eBcR2A=
X-Received: by 2002:a17:903:320a:b0:23d:d2d2:b511 with SMTP id d9443c01a7336-23fb30cb6c3mr225672285ad.19.1753794748584;
        Tue, 29 Jul 2025 06:12:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1psn3OcEesGJHe+B3xilmqfbqkCCVe1Iwh6GM5j1+Rv5K7pbahMYXP+auHAPPU4oiuTDereeklBYW5LyOIuI=
X-Received: by 2002:a17:903:320a:b0:23d:d2d2:b511 with SMTP id
 d9443c01a7336-23fb30cb6c3mr225671825ad.19.1753794748111; Tue, 29 Jul 2025
 06:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729113638.1925201-1-colin.i.king@gmail.com>
In-Reply-To: <20250729113638.1925201-1-colin.i.king@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 29 Jul 2025 15:12:16 +0200
X-Gm-Features: Ac12FXzgLBMRVsOJXcgqlJnJHj6Of1bbYEOVyc2J0oa2XadRWV0FlbBU2KJNSYU
Message-ID: <CAHc6FU5eD+ROzxpe1tjP99EthOWKBrd8hWToPj5mPurki2JyZg@mail.gmail.com>
Subject: Re: [PATCH][next] gfs2: Remove space before newline
To: Colin Ian King <colin.i.king@gmail.com>
Cc: gfs2@lists.linux.dev, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 1:37=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:
> There is an extraneous space before a newline in a fs_err message.
> Remove it

Thanks.

Andreas


