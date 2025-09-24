Return-Path: <linux-kernel+bounces-830139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC30B98DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 670734E2D08
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519382472B1;
	Wed, 24 Sep 2025 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1djX5vS"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FFA2F56
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702499; cv=none; b=aFL48sq6j09Dn/asjhqppYkdduyOOgWh6n0k4bmyBLExEzYCBEUGp0H58pFplTV45m331bWsKjb6jI8lo4Y2lqM11nQQa7urfJW7FSfqHArfsjVzv4GODBJpOz8lMqAS0jC6BPJf4mEgLm3PO6jZ4g2MdbGqheCNAPsxnHHCXdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702499; c=relaxed/simple;
	bh=n0UzIsMpU4D1UpgP8b7QotbFpycmctuT3gIHpLefQyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrMY4qGlE752do10LtRYRC6X5Gv4AvbsP9O558c3ENH4AcDPEiH+8C4ndcXH74dMENmUNyEiGSwsLQRAS6jgVOuHEJFtMJTeWrwOyn3Lkg9GFYODJ67sEjXHkxbgZKhqpnX9UYHFDfCIBYhDUiwaLjRYrKZyFDhoN+bjIpA2L4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S1djX5vS; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-355102ff142so196108fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758702495; x=1759307295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTVkzl6UYOFqbtfOkUTSEgWlYPfNoRJvRz5e440qqv8=;
        b=S1djX5vSsGp5ogvH0nZRqrnFG24Cuko2fJ11Gl8Z2Tlbqr5epcIDbiQVS4hajfGtAb
         iGCP07wa+CGJ4b6+HqI+emi+E9cUIdJcaWhF4kgax3cJKDvWCCAVDREmvd4qVGhlJsHE
         cHjxQXubYf+VMz68dxooTOtVhldpJrvGxt6qJ02SkdsJOlp01Ya/WCD1jxspNNKGsFTx
         nlLphZt3/vET0QpI2E7EPsP2aL/c//gUYhHBHBjY/AKMpviLEf5MHWGCvxXOZ3TxYPXt
         aLE60K+ctvxm9D6cPiF4aS66SwqJgZ6lZZ5ekX7Auc7ha9vViwLnZQV8iy7s6BGsqKVx
         0hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758702495; x=1759307295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTVkzl6UYOFqbtfOkUTSEgWlYPfNoRJvRz5e440qqv8=;
        b=Z+b2V0OEeZiSkIeLNHowEB0GylSgUIm0X0fxtza+bsYBFRwwKWh+kiA4Aiv5QxMUN1
         YuI5EFQN0ryYguagN9u0/mX9a7gAnZtFWYM+zs8TZ8TuRhvn4X4w8Uvc7fvD87m6MlSi
         WkF1ZhDi4iG/8MTqvg6uGZHuDgTKsWDRmp0KcwEnkbqJVvUKexlmVDQzdv5eD3Sd/Du1
         G5vv81aKVMyB5nG9N0+cWXQK6zAoIYfZ7eY5ro/2bvhOwcMWjnQYw2ZJof4CwSlSNHjt
         QomldGLvVMoDZpT+aBgmGdHx+WSA2cwShX1gcWLR7Ioa8K74HSmogjLp/mquOKEgB/GH
         keRA==
X-Gm-Message-State: AOJu0YxpmRj2aaggGvUd68TxdnzPe48y3gJroemLYPvFIdkfnZp+wKsp
	K6raG4GXXeiNfUMfTDIMLgaXt3ZgaYxkx4NMV5rCnB0UBJyofG4GTWtXeFHgsY7jG0uog52SWf2
	BdshNPfUCfdXpGTUL6fzIx8wLSY0o6Dr3aTvfwhPqbw==
X-Gm-Gg: ASbGncs2fqhw71AhbI2XQw9e9GkIywC1glVSjxAYrDTzkAwY24A0ec9xoOXto2/uAkk
	y9BJXTE6BQRL/yum+G31bGjGZYvjiOetDZf0t7EI7rx9LM4ywGlG9n5uwNL+2Y0J5hvE0bIkaYi
	LE48oSYW36uYvpjrHnXM77cE5A94A8J5rAfzVUGL0g22BZsNXplYcd3z19M83f7uO6/Ednzhty7
	696CwUX
X-Google-Smtp-Source: AGHT+IFiZs3fit7JmrwTrcdOE3PuEb7BgKG0XRjkXlRJI66gxsYXWU/izU5IO2sIbpWcGOQKmMbdO6vVroeM7IP2Zhw=
X-Received: by 2002:a05:6870:a908:b0:347:b473:5f58 with SMTP id
 586e51a60fabf-34c781131f2mr3086804fac.1.1758702495151; Wed, 24 Sep 2025
 01:28:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922083211.3341508-2-jens.wiklander@linaro.org> <aNENxpvdpW7ItjgT@sumit-X1>
In-Reply-To: <aNENxpvdpW7ItjgT@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 24 Sep 2025 10:28:03 +0200
X-Gm-Features: AS18NWBtHMnzvD8ACh0gV2MjOlJFNbL_oo8xYwwc8TnXxOERP-GW5Ztr25D4Hzo
Message-ID: <CAHUa44FtbqOnbBvOSNkX+jdqUK-+hTAM3hYseMPbhOt0U_Nxqw@mail.gmail.com>
Subject: Re: [PATCH v2] tee: fix register_shm_helper()
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	Jerome Forissier <jerome.forissier@linaro.org>, stable@vger.kernel.org, 
	Masami Ichikawa <masami256@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 10:50=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Mon, Sep 22, 2025 at 10:31:58AM +0200, Jens Wiklander wrote:
> > In register_shm_helper(), fix incorrect error handling for a call to
> > iov_iter_extract_pages(). A case is missing for when
> > iov_iter_extract_pages() only got some pages and return a number larger
> > than 0, but not the requested amount.
> >
> > This fixes a possible NULL pointer dereference following a bad input fr=
om
> > ioctl(TEE_IOC_SHM_REGISTER) where parts of the buffer isn't mapped.
> >
> > Cc: stable@vger.kernel.org
> > Reported-by: Masami Ichikawa <masami256@gmail.com>
> > Closes: https://lore.kernel.org/op-tee/CACOXgS-Bo2W72Nj1_44c7bntyNYOavn=
TjJAvUbEiQfq=3Du9W+-g@mail.gmail.com/
> > Tested-by: Masami Ichikawa <masami256@gmail.com>
> > Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer=
 registration")
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> > Changes from v1
> > - Refactor the if statement as requested by Sumit
> > - Adding Tested-by: Masami Ichikawa <masami256@gmail.com
> > - Link to v1:
> >   https://lore.kernel.org/op-tee/20250919124217.2934718-1-jens.wiklande=
r@linaro.org/
> > ---
> >  drivers/tee/tee_shm.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

I'm picking up this.

Thanks,
Jens

