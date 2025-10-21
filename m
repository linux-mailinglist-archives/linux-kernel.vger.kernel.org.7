Return-Path: <linux-kernel+bounces-863102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F99BBF7047
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA12E545B00
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574D52BEFED;
	Tue, 21 Oct 2025 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBs96o1a"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276AA81AA8
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056327; cv=none; b=RwocH7ZbdnLVRY8Hyrum3aQfwLnY0GyXfJIIYlrHkL5Axc4psmLbJmBX3j3vHraq7ZDheIHzQ2G19KEQ2XfWt1mMjR5U8EgoKN754TPZ10543F2EDGnZxQyRCH6VPjMSJO6uLvoHW3tYAN3KxZmJq1W9qu4Cgz5pM6Ib8mYZQPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056327; c=relaxed/simple;
	bh=td0wxdJvwksCsQ8szApwyuadUAHIWrEX7VEhKsxp9ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agHmSV90u7K24DNIDR5t/amNodbBz5sK7ZazQh/yyiMa7BzgxZLHPgzxs/a8QPLVvhR2HfYxbHbjkRlMuVbB+38HNEdBv2SF3igL0qQb2BNqQvfFxoaz+e6zeTRpWjPPMy6AneoJoKMmgMUj959kp/YiMDHPubNDLZQAIDPrOYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBs96o1a; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42701b29a7eso2659430f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761056323; x=1761661123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTg6iWTU9Y0FmHMWVr7mpqpsIik70Dq7Hr+fkZkn6eg=;
        b=PBs96o1ah+w8aX0y9oKe7fpZGAOu+zu+VpZA+sClRj0ZqIvIRIN1YOvUh6F5NtPzyS
         8mSsy9/uArSliWIBBMxPkzBP8aQYL8cS5464cU3eTZG2IhGgFUcrE2WCNEeUl0/eIbZ4
         zhNi5HalEiUG5GWsIcQDLF+XVZob0jBSP2POq+nBYpbxUyIIleC93j7fItiBGHaby+QZ
         8FlCq5rwcnTM6s711duD4aKwJ2ucWymccpdZKnHsk4hSsS5iZ/f+uKXlJyfzLD2znLL6
         tns2UN3WiT2t/mcyprUsvuqqGRV4aIDZC83yocuouLJFNir0b1ttUl6T7u6ITzh0pC8O
         rlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761056323; x=1761661123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTg6iWTU9Y0FmHMWVr7mpqpsIik70Dq7Hr+fkZkn6eg=;
        b=rEHVL7WZdYBtKMFdw0Y3UAQzBhl5jNBcwqCLYyKkUV7dbjrFlmPbta+cT/Kmb9yX8X
         ubf730Da1gGswrAyi1jlXYZk5N2RBMOQqrm2wc+1+0t6OozBdbaJLWGshxwUi5FizZx7
         zbLlD1F8w+yNbDlfE4rKEhIDtfVaQSvNeXsCMIbAEilA5r6AvXjL16bk65O7tmnkXGtL
         oeQ+Be20K70CAJ6V7vxPcWi9VASlxUML7LvbnXnSvm/mEFtYfao0atappIuCzTAL/XOT
         WwZq03b6xFtMIbt1zbSgUCd4ajbND5F/KKBoCp7G8wZehXW49HqOkFDXa6J5yJWOqKap
         7KHg==
X-Forwarded-Encrypted: i=1; AJvYcCVuFvTPPeA965zQFcAS4unxpXI5+MQ83yFZCabTwX0EDVA74XWShEMIL7oha6YaC2RiKJuBbNcDK3nwigQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUavFXRnjvpJ/v5na1ONnoInYIKPRIBxn7VHU5G7TtIKNt3/cY
	Qhs3BTxNNcKgQKu4RVwAJsCwngMRdYEBMb+HmoKi+2xlbIVZGG4wAurU9IBC/2rr344L1Cy1nHY
	iWxH7MJYFflbgmQohd8X4QTb3hgNPcUQ=
X-Gm-Gg: ASbGnctJr+UxAgmJE0/Y13sv6w2vc4ftM3VE0K/ea7os2zhPPAzh/4gqUtHG/cloS1M
	1Z9dPCSlPXQii+ak6meTyrQFpbsiHiF6FW6ST8CHVzMmgMTsK7f+peU41v05OSAElCaWjHWwzZx
	1CaYiE+z0jOIvRbN5y+g7z1MM8VTk0IUflml7uI3AGThCzeGYprlvBFkQchNaEuQH0/r8jYz4Ae
	mYdj3+S8O/iuYZAzPpq3Q/Iyz0LkglhU74TfBQbo2G30TZKoqHt3INF41MGAEWjDUwhHpqYwKU+
	rDCFb0w4CkltnEO7xp8=
X-Google-Smtp-Source: AGHT+IFa3o4oRIU+3qLtptCG5zaP5IZUIUu7lzLKc3QkSze+Ys7kW5YhqHaljicbPhcJw59uJZEAVQ42kFJjUoq0zdA=
X-Received: by 2002:a5d:584c:0:b0:401:8707:8a4b with SMTP id
 ffacd0b85a97d-4285304a024mr45398f8f.13.1761056323420; Tue, 21 Oct 2025
 07:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a6024e8eab679043e9b8a5defdb41c4bda62f02b.1757016152.git.andreyknvl@gmail.com>
In-Reply-To: <a6024e8eab679043e9b8a5defdb41c4bda62f02b.1757016152.git.andreyknvl@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 21 Oct 2025 16:18:32 +0200
X-Gm-Features: AS18NWBzXNiBqt2jGmlRH7AZ1KVpx77wzAqEXOoi8Zzb_trF3c5-FIFSgDdxD7c
Message-ID: <CA+fCnZdG+X48_W_bSKYpziKohjp1QVgDzUzfYK_KOk42j58_ZA@mail.gmail.com>
Subject: Re: [PATCH] usb: raw-gadget: do not limit transfer length
To: andrey.konovalov@linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 10:08=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> Drop the check on the maximum transfer length in Raw Gadget for both
> control and non-control transfers.
>
> Limiting the transfer length causes a problem with emulating USB devices
> whose full configuration descriptor exceeds PAGE_SIZE in length.
>
> Overall, there does not appear to be any reason to enforce any kind of
> transfer length limit on the Raw Gadget side for either control or
> non-control transfers, so let's just drop the related check.
>
> Cc: stable@vger.kernel.org
> Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> ---
>  drivers/usb/gadget/legacy/raw_gadget.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/=
legacy/raw_gadget.c
> index 20165e1582d9..b71680c58de6 100644
> --- a/drivers/usb/gadget/legacy/raw_gadget.c
> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> @@ -667,8 +667,6 @@ static void *raw_alloc_io_data(struct usb_raw_ep_io *=
io, void __user *ptr,
>                 return ERR_PTR(-EINVAL);
>         if (!usb_raw_io_flags_valid(io->flags))
>                 return ERR_PTR(-EINVAL);
> -       if (io->length > PAGE_SIZE)
> -               return ERR_PTR(-EINVAL);
>         if (get_from_user)
>                 data =3D memdup_user(ptr + sizeof(*io), io->length);
>         else {
> --
> 2.43.0
>

Hi Greg,

Could you pick up this patch?

Thank you!

