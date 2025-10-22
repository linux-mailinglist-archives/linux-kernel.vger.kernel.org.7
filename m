Return-Path: <linux-kernel+bounces-864221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3A1BFA340
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 879164E2224
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1322EC0B0;
	Wed, 22 Oct 2025 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwPinwZK"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED12EC54E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114166; cv=none; b=iY/YeFMsAy/Ogzum8U62Nr0LxgkI/e0q6UWveWEFEgnUeBiUzIv0gmD7951d0zB+7XFIrPgTFj+r27e5yJRqTFIE7qr9N7oWug/WouK9Rr7idKUwkXE20FAFppmvoGTbQ6jzTn4mwW+eY3bW0/hrgP7g0BnMh+1sYj3rwa/IprI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114166; c=relaxed/simple;
	bh=Hv4Hqpny/wwjvcr04Ei/KTHzax1khOu9XVxI/A01ZhA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c+qnXptBWL4Kksuyh+G+hmxVKyHST7zkCwd3G0YShNWOlK50Aj3oLPRhBCI0bgyncWdLma0rr4b5R/pkruBVU2t1r37GfPFDSLXsSx8oR/hXIWjTcbGfnkSTcnG7ulRMUG8dP/8RBPpUj6u227x1CiQIzHVuqWf5+ybOmWxwUoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwPinwZK; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b62ed9c3e79so4611901a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761114164; x=1761718964; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=66xaQjwwj1DSC8zMv7g6skogb4iqDm/A8Jr7F9vtkEI=;
        b=YwPinwZK2EAjAUTCX18DU7BXVt5m+7CsSggkhxMn7+srVOUp9NcIopRbvctlkbqwL3
         OR8e8BfOZK+d97z4A0FFWacdbNbahpZCXHxsmlgy6tko4Fown+Edmc4nrhp3arHEwpD+
         uyUughhYjjuUPMTlFJ9oUzQ/Cwv06Whic+fl7T2hNSIxrwD+PyZyVO5Hj05JK0XwEfB9
         TBrWjzy4w2JCidWy4TEB5d1JBRDevAZA0B/nNJFXLF8xjS2kYF3zaUgj+b2ehKAj292O
         wKsYiauk83goNBq4DN+BxWw7mMZebMl06ZW39NNMVtIbM/N3QyNljf+qNQ6wSu9yXgFL
         uwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761114164; x=1761718964;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66xaQjwwj1DSC8zMv7g6skogb4iqDm/A8Jr7F9vtkEI=;
        b=hFBu8HsMBgcIct/Bamsrgz9q8T3VufSfbQfyIriOQaM3hJhEbodt42wGkY4A1S8zGa
         uRgEE9f2E5Q7EqLSqrTJmGpPZrcmcHZbAtxsq778QvDIxJ9YFMNkbvBTpTAZ80Df4UUf
         +STAz8/lR0RyXjd45N4lk+WTUP/bkwgo8GG0IRGwkL+0bdshGD3EX/M5KIrF8yS8si7D
         uqjNjXZBBV7KsquyR0zsteNRXD6TaXxnxldgA14vv1nAMX6n/+oO35iJN0joAFOj1I8g
         7YWzxOwpQM8zKa78N5M71PXdlFIVCWSOi1GSVmoN/TRMO4Dyr+6d1ry/mT/33yV99VUv
         DVRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfZiAWUFo8/4X8koTBUfd5nOe4Ui0t85Ze6B7Owr9X5c5nDBDqaYPBGruO+q2tsOCLLXtEOVLsRqsJXLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDK8dW8nk3GaoWjQGGpC1iC90FpqFrF1t1a/F1iRrar+odKGEo
	cUmMC5q3YDKl8tCFMSVUY6K5lQQlG0S74tEYC8nZqC1/lVM4cIE/X/oU
X-Gm-Gg: ASbGncsklM9I1FOGWK40atsLDLX+z6q9wxw2a8taldSQT4Fsh72jKrWT2SL8LqiC12i
	pqX46YTqkYgOG7PQgPhCxQd+LvASVtxId86GsiPI9OUn+FkRt+Mg1DDIntP3kadtJ7lgWyWicLO
	Qzlb6cebQdpyuZfr9bmg6b+4hkxqURF1ExZfXGdSIOMFLW4uwYuLA4Px8IluEiTG9pC1x1tVGOA
	Li+d0213L8AITvrs8+3i50dL4rtgU88cNSfyhtZRzxL/T34OWd+OtmYra0SO5mEEGbVh554esy6
	Wk7Ddvrbwa/tkSu9BRykp6rsc3pMBRYRAErHgNqCPzFGEIcqzQQ3uyruxi0v8dIrEpVP3vdV3Gj
	G0jMJ4Sl2rYtv1bLl/ATxjZRF13J/DtZMDbaSm8J0+mLlALbZtQJckePl5zd9vXJ9KSkAf17cgD
	pOpdz7d+Z2lA9sHgnmU0+XUmqaYjcflxgdo0EhHsN4
X-Google-Smtp-Source: AGHT+IHu2r/Kai1JDZIkhOth/5ZzefnErwla/yQFec1EB8fhz4Cuv3VnlejE3F+2TDlKzVO3OAm7Hg==
X-Received: by 2002:a17:903:2381:b0:266:cb8c:523 with SMTP id d9443c01a7336-290cc9be17amr232330815ad.48.1761114164378;
        Tue, 21 Oct 2025 23:22:44 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5850sm128748075ad.66.2025.10.21.23.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:22:44 -0700 (PDT)
Message-ID: <49ca09ea3dce52fa7bd300f930ba3eec4b9b318c.camel@gmail.com>
Subject: Re: [PATCH 1/2] nvme-pci: Print error message on failure in
 nvme_probe
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Gerd Bayer <gbayer@linux.ibm.com>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
 linux-nvme@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Wed, 22 Oct 2025 16:22:39 +1000
In-Reply-To: <20251020-nvme_probefail-v1-1-a420046d98f0@linux.ibm.com>
References: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
	 <20251020-nvme_probefail-v1-1-a420046d98f0@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 17:29 +0200, Gerd Bayer wrote:
> Add a new error message like
> nvme nvme0: probe failed on 2004:00:00.0 (result: -19)
> that makes failures to probe visible in the kernel log.
>=20
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> =C2=A0drivers/nvme/host/pci.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index
> c916176bd9f058b49e6e6768675711df52b15765..7544c4bac2c4a230d32cf729abb
> 9e94bf93a921f 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3519,6 +3519,8 @@ static int nvme_probe(struct pci_dev *pdev,
> const struct pci_device_id *id)
> =C2=A0out_dev_unmap:
> =C2=A0	nvme_dev_unmap(dev);
> =C2=A0out_uninit_ctrl:
> +	dev_err(dev->ctrl.device, "probe failed on %s (result:
> %d)\n",
> +		dev_name(&pdev->dev), result);
> =C2=A0	nvme_uninit_ctrl(&dev->ctrl);
> =C2=A0out_put_ctrl:
> =C2=A0	nvme_put_ctrl(&dev->ctrl);
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Wilfred

