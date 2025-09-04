Return-Path: <linux-kernel+bounces-800123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 701CCB433AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A68658532A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008F329B217;
	Thu,  4 Sep 2025 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FZlTYS2H"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D339529AB00
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970463; cv=none; b=lV8car3+TohXRI4dNeKNr+aslnZf+vg873Jjrf6IOMYOIfvbKOrT8ckfea7gOffp0Smo18Qn6xThl/SocS/31DGvRozt7i4CsHqicLOWN8YYHNlg9Mg5UJyMvqE3Fvux2syi4Biagy6S1/a55bLQc9uSBBbOgPCq5EACkOjUPlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970463; c=relaxed/simple;
	bh=IzaUyr2QUQ0u34pCN4ankMSHh6IMMQrZS71LWFjV2Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Doew6GH9/B/Ve5Zi2CoqY7QzHLWD9A7qs8DFEmo4uDF1tk4dR4cSTpfO22lz4c7ulwpuxzNDVKStUeo5gljG9WDKHUJfFenKnbXrE6Wn7FNQL2JOdXtU/lXaTfbFFE3gzmLp+0g5JNrriJH6ilY3ZT2EWMRDhx4oSHUmReCKlls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FZlTYS2H; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-248cb0b37dfso6915995ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756970461; x=1757575261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ck4Bse/Qz7JlMSXOfz+yprHWM6hsZTobGzFuDFsmoa4=;
        b=FZlTYS2HG8qWSETAIvJAfIcqD2klgYWH/sjiho4fyoE1NVIKyNDJUum6b9tpel+Z6/
         P6DSOVNcWO+Kqg0hoOzYU4z39oz2l1tcNTPB7/X2ZZmz8ZW5j+3zBN0dAiIj120WyKCv
         dwkyM3xbQJbfYtXkrwK9lQRrQgulZzA9BDlF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756970461; x=1757575261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ck4Bse/Qz7JlMSXOfz+yprHWM6hsZTobGzFuDFsmoa4=;
        b=VnIpen4sChb2FvXvDkoftcB7eNNAd70H8qgrVUQwca2iIjR536/1M52OK0A7gB4vX3
         h1CuvoggvRZT/b5dVWaTyNgXCupdPQVzzbBWmAWMbhLdLhqgSJWbSlZn/ConBKhzsreD
         rBULOgqQUBbXmfmjVr7iD8W7tUplgf4s4Jo0a9kpgplX85J2T0YgRAB391nVOTKTcSXN
         3zD95JlUOYlEmnBNKb6kp+d8zLzKfOWwD/c5VczVfpdhN3TMwSA+X2sSGQeKBrmhVPV9
         ps5o3dOAWCsHh27tm/3kpNbtvobCgHJyJNZ0OweRsI89cbcx94R+sepBwOLtMy16GqY2
         8evA==
X-Forwarded-Encrypted: i=1; AJvYcCWpEMrsHRdhfQQpMleDu/itgq+9On8I5mm4jEPe/FqOGQG3/R4Ux0kZTfhVHhOx5qpYjPDFIGWceDj4sZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTXCLg+jcllcqeehNKUKsdxy8plX9RQCmGqHl7LppXgp5tIiH6
	xAuOTQh1OZj/WLbGjrMhQB+QfqsTPQX4J10NKWfMC1qlIh1CkVdcv0eh2DvvIxqA9ThDvW46M7Q
	acZw=
X-Gm-Gg: ASbGncu4vvigkK3ae0Apmf7AuMG2fp1prnGjsDDkE1V/hwGLYJT/f3yxup06CnRk4nz
	uq5Bh8nMJm9ov3PYZJMR9WhojwjXIqjkYOePSbsPXWK4HF4/7UwJSG14FeU6Fxm0soN9/Ez3RGe
	gXyj7yGs43ZUnbZC5wm/8lLKv5DmOH1A+UnUoTfF6T5wFTTXgj1NahHUMy3qxpOa2wg8pLQ7sgX
	AIlE+FYUmsTqiUFtAEwUwoHLCdgdnX979MaKRBjZiuOP+tbRPZ6pVR/yqHBvePb3nFNXuTAcmZ3
	03v6kXXZmvJS/A5zYdCgI9MqWrbf8Tv6SC1X1cQ/gJHAzI8hgvuiJmErQ+G9butl5qPR7rkbr8B
	//03s7+HJBdncygQYl4RfjxPpG5D50jal4oj+hbTbe27Er0/v7fv8cHdzY2FeOTloQghuSDkPuC
	9dUowcl3gj1A==
X-Google-Smtp-Source: AGHT+IFebwqa3uyh4/NbXFIlc8TewS7q2Bro/xa6BCXb9CBrAmpzUB34yzqI4sryDJAcRPzCdaQDgQ==
X-Received: by 2002:a17:902:e5cf:b0:246:ace5:e1db with SMTP id d9443c01a7336-24944aa23a3mr244415145ad.28.1756970460684;
        Thu, 04 Sep 2025 00:21:00 -0700 (PDT)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com. [209.85.210.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc56f60sm5423645ad.60.2025.09.04.00.20.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 00:21:00 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77287fb79d3so699932b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:20:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOPyU2Til2mTaRBmE8hfcamoHAUeAlLdAbf8AeA4VXJeN5dgyWdfpFftMXogf/40tkx5c7AHx02MrDJvU=@vger.kernel.org
X-Received: by 2002:a05:6a20:4324:b0:246:1c:46d with SMTP id
 adf61e73a8af0-246001c0ca6mr11362895637.2.1756970458983; Thu, 04 Sep 2025
 00:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904081429.592e439f.michal.pecio@gmail.com>
In-Reply-To: <20250904081429.592e439f.michal.pecio@gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 4 Sep 2025 09:20:31 +0200
X-Gmail-Original-Message-ID: <CANiDSCuwHo_wLqVwPj8VHmNAgZw6gyq4zxoapvGxDwnb0tfkxA@mail.gmail.com>
X-Gm-Features: Ac12FXwZwul4UKpKyMxWTIvEC3mrs3OlDVCBkcPTmJKAOxRhisn9yBCjCfSFcus
Message-ID: <CANiDSCuwHo_wLqVwPj8VHmNAgZw6gyq4zxoapvGxDwnb0tfkxA@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Shorten the transfer size non compliance message
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Michal

I like the new writing :)

On Thu, 4 Sept 2025 at 08:14, Michal Pecio <michal.pecio@gmail.com> wrote:
>
> This message is much longer than others and doesn't fit even in a 160
> column window when printed, despite providing little real information.
>
> Also replace 'transmission' with 'transfer' because that's the actual
> name and 'max packet' with 'limit' because it isn't same thing with
> isochronus endpoints. Remove cryptic abbreviations like 'ep'.
>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>

> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
> ---
>
> By the way, this hack doesn't help much in the opposite case:
> dwMaxPayloadTransferSize is right, but EP descriptors are a mess.
>
> But no harm in trying, I guess.
> I can live with it either way.
>
>
>  drivers/media/usb/uvc/uvc_video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 82d9d8ae059d..baf4ace41dbe 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -266,7 +266,7 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
>         if (stream->intf->num_altsetting > 1 &&
>             ctrl->dwMaxPayloadTransferSize > stream->maxpsize) {
>                 dev_warn_ratelimited(&stream->intf->dev,
> -                                    "UVC non compliance: the max payload transmission size (%u) exceeds the size of the ep max packet (%u). Using the max size.\n",
> +                                    "UVC non compliance: Reducing max payload transfer size (%u) to fit endpoint limit (%u).\n",
>                                      ctrl->dwMaxPayloadTransferSize,
>                                      stream->maxpsize);
>                 ctrl->dwMaxPayloadTransferSize = stream->maxpsize;
> --
> 2.48.1
>


--
Ricardo Ribalda

