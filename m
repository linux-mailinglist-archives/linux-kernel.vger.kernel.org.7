Return-Path: <linux-kernel+bounces-882167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C21C29CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08913AF18E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 01:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D882797B8;
	Mon,  3 Nov 2025 01:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzW68jO1"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616527815B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 01:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134089; cv=none; b=TXk8oeHLvEeJMvipYA6nTN9FCyjXdY7RuIeDtIBNeg+52ugC4pa191igngSf5xL3A/z+GNq95YIoFGWnw3qEOdasQKCSUnjaHREImA2xJkv0ufhssqCdlfVOkg/HiX2Gk92dUKQEKfgJMst2MP7pCYNlD3HurxsqarjpXOj7yM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134089; c=relaxed/simple;
	bh=r4JpTIJcUWICq0RhXYTLqHg0HVddUn7fLzFa6IMM6wY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8Op8CHRR0hyKmVArLOGQHCWrkFgXPhXUXZP0k5iwDGB6isbGL8yAVw7sfecoZh554vJZ7qXBJDPSuKFvXQFWnAcn0PBQdkNzMbubLvkBqXDgEA20O10QDcAsDdCPhf7Qr4l/kS3O6DX1nSsjJz3LHPR0NiGn4XRbchGviPMbQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzW68jO1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b6d345d7ff7so934860066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 17:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134086; x=1762738886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4JpTIJcUWICq0RhXYTLqHg0HVddUn7fLzFa6IMM6wY=;
        b=NzW68jO1vokfyMAlbO+E5u4EBjB1wur5fS8y0TI4uKXkQhlOVc5LJpHHxh3lwaGmrE
         1aeoPJm8pQA4gdCePnSWwG+jvuwDCCg+1mknnCT1bdQnWmLYsR+mGdTVOr/aYJXv/rIE
         Yv0HuXtAxaXW8HTZiMuDJPWogswu0zRwMKTriuF/stW7HdKtr+rVel/6+WWmsjotogHe
         dGDf9cjFY9pRqk7iXo1JyscwI2y82hGfGcP8hIEc6rb8uLk5szgZyXD7ZDMtjvQuURz8
         49HfMhih1Sgwr7kkqzpqyxUwMQ5IdDY+59UKyVAdOQ0AvftbeOMrL/qsLjQs9UboGv5+
         5EMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134086; x=1762738886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4JpTIJcUWICq0RhXYTLqHg0HVddUn7fLzFa6IMM6wY=;
        b=vfjh6hFDeVKRDMuanwanG5BIkcSXb+/y6U9lsLPCBWMYZgth1KY2USzBq79mRp+QQT
         noV77DVwEMbFNEWUWUdVkURz63IhlAOA90+qu5DsUpkEXEGOnDuVtNPq1KbAolcN9IqP
         QxZyxf1bz4XXtI81VpKqLPjyI20rl3nO8FQtpcxYub8VZLDnFp0UYUzlNVShboYMs3t2
         C0yT8YWD7PPKjCff7xGLlK60gF5GskX8n69S85kLBcAxcA1gGMoo9+iQfxUCIUPscIk1
         VUgTs9u24Yvk8uBELb+X3eAy6sthTDhKqakGmUtcnCA/mgfkO4pFUhMsvDalVnYCL9Ch
         5oKA==
X-Forwarded-Encrypted: i=1; AJvYcCVljtxIcKZ3Oan8eihof3/JhhCjknEOwQeo8PJVMj1kJyQ2K3GmRj9GT4oRJ89+lYVfU6OF9TF3VDGiR1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YziVS39C6pHMfdiHc7KFEJxC8roZXfwu8Yc+nNPDHhYrcQv0R5S
	A1A27fNfO50UF0nHlpeHLNPbCjHLTTPAedWtERmUNiqIWitDZ9k1J9jQ3pV0RQvwbvSb2WidZEy
	xNnCFIEixmx5OV1bvNpJhixfInPn2KRBM7lBv
X-Gm-Gg: ASbGncuEtSN9zS/2PuP1qqam8hmazsthKtejSzyU5EWR4f+4s0EYjM1qF9laNhkGf4a
	DEv4tPJhlDGGL6/SYYBWNoJ0XfPx1VYsG9C0dqckfJlHAZG8hKYAl+7wXI+92bB1tRxEHO76mzV
	UIB382xz9qbv+vNdjijcJk5/GzaNL7JN/69bSN8q0xvTq/d+npYlr9FekLaRYcTx0/a7IiIGKHu
	UeCQplqLYLDPQl+lrqZV7Ig5/37YwpaMNNFYQLNYtp3rfyVvq2CW01CwHEE4VujRYn4DseQlo8p
	OeyIug/7xfQtDos=
X-Google-Smtp-Source: AGHT+IE/eyF+U0mcVSVOCFn90kJhZxf4Zfg890G+o1Tfzad3V+RqDT+rlRzvp5279x6ptqJdKuJ4hl1LR6/bJWnRls8=
X-Received: by 2002:a17:907:7209:b0:b6d:ba71:a17f with SMTP id
 a640c23a62f3a-b705212b184mr1771429466b.18.1762134085841; Sun, 02 Nov 2025
 17:41:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030035114.16840-1-alistair.francis@wdc.com>
 <20251030035114.16840-3-alistair.francis@wdc.com> <20251031140310.GA17006@lst.de>
In-Reply-To: <20251031140310.GA17006@lst.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Nov 2025 11:40:59 +1000
X-Gm-Features: AWmQ_bkDRF4rEu0p3e9iqv7N4UGnz9O0eQ4ZvNxXnHXSrGn_2_G0UVFLViI15VY
Message-ID: <CAKmqyKPU8j-D9T-dLNfktf9EVQeA8-pdneOJkscN-0JM0UdEGg@mail.gmail.com>
Subject: Re: [PATCH 2/3] nvmet-tcp: Don't free SQ on authentication success
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, hare@suse.de, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 12:03=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Oct 30, 2025 at 01:51:13PM +1000, alistair23@gmail.com wrote:
> > Curently after the host sends a REPLACETLSPSK we free the TLS keys as
> > part of calling nvmet_auth_sq_free() on success. This means when the
> > host sends a follow up REPLACETLSPSK we return CONCAT_MISMATCH as the
> > check for !nvmet_queue_tls_keyid(req->sq) fails.
> >
> > This patch ensures we don't free the TLS key on success as we might nee=
d
> > it again in the future.
>
> I initially though we'd now keep it around for the lifetime of the
> queue, but I think we'll still free it from nvmet_execute_auth_send,
> right?

Good point. In theory nvmet_execute_auth_send() can free it, I don't
see that actually happening as `req->sq->dhchap_step` is always
`NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE` for me.

I'll add another patch to remove the call to nvmet_auth_sq_free() on succes=
s.

Alistair

>

