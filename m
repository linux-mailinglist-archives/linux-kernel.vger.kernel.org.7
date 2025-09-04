Return-Path: <linux-kernel+bounces-800034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51163B432A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE2D3BFF30
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E99227932D;
	Thu,  4 Sep 2025 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ixYY/KrJ"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82B6275B0D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968011; cv=none; b=hs5lEr/IS1ftWjF6bBlNEbgH3h21EWYMeS9dAMGVzg7AkQHkX8x0WcbTRvzCIuCgSGjbFq9nDXKFagY/dSl8z4hRALoMDRIa8MWt/RVzDndJLMQ8vApa62yu7jyssNpHG89UwRtwlM2X893Zwl8kdL6VNiegh9dP5KtpCiS0VO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968011; c=relaxed/simple;
	bh=IglsR+oUgnc5OGxBKrJvs30oGCTNsAedJE467XKBqjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W17H19EmzD5NEAqyuoUtoougA5LgmtTzcb9WCMgaeUF61my146E1fk4X1VB7e1EaDd6ovqs/Yg7mq0jEirU0UzIiY0WYW3sCXfj2IbWkMr0X5TvhpzNRF+XaOO734qeXfbE33n5+9W12d0r3IWyhtqP1t39iRfGDoSK4guef4bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ixYY/KrJ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7f7381bd1fcso47949885a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756968008; x=1757572808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IglsR+oUgnc5OGxBKrJvs30oGCTNsAedJE467XKBqjg=;
        b=ixYY/KrJz27IVLo5C6jpPFL0BrV8zsXjCbzxzHwOuYuFFjFIgsgoZRno4V/0/zE2F2
         CacaalTtVB9LzVXWTE80zTpipQl9mPfHeC0D4OSa/iJyo2wGs0Umg83mK0yv3ge/jFI/
         XmFNX/X5UXBg7tmV5pLwC5zb43tgnLLNhmUCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968008; x=1757572808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IglsR+oUgnc5OGxBKrJvs30oGCTNsAedJE467XKBqjg=;
        b=imZ/GCc7I64tmqIeq5jFV2Lj2S14KEQ/gOdGRMJBmaS6/mdW0x2BXtsoJP07WUHMFb
         7Rcrpcfuvm9s/TsXhFRk9i2ApulM3WPt0hnCEQh3awFtYqOTwY2MOrp5Bt5gfCL+Svdd
         /78SKhcfs66qFbou9hQT1IYnXa9jzKMTOQCMuWYUG/VPGDqGDt5NBO/28y7RBXfOb0Gr
         bUOaNfw0FOtN9G3KTlcwatp1pW6dl0seSvQ71p1EBacFI2L1BlT7cWCLpCD04dAu60kR
         1FwYRZqqpzvGoImv+656NwLzyrQ6d4JJ38qg7YJlynHAESq4mL4MTO9t/K+r23aY8V+M
         nbaA==
X-Forwarded-Encrypted: i=1; AJvYcCX44noosZeMOWaETrgzNwqbxJAutMpGqr8/mxU6C6iYpWPbm01hBq7/263TZYyksK9XUvcGj2VE9Je+2J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzCqS2q8FgOZkjrA/TNkyoxPXwx9LxsJIR1eB0pgkbLVj5V99X
	2VeRG5b8GgA/iKJyv5T9I/vtQbUIU/Q4v02Tltzm0QsHqg+IssNPHlVo9ujWUDyeP78IAm0wijl
	tFOU7lQ==
X-Gm-Gg: ASbGncvdBPHmY+QG4LrNNLwiarUO2AzpuJWeb8VKpHfBQnkQdtRIzky8cdG8ONW2fKI
	dlX/mEyNDtI7kuiU2f0gcVuPxrU73yVtSOV+ALsoEHPmHre/JlYpMURO2T70iYiYTIHNlnkjtRg
	MfVqLe4LuSjsNQQyBJT4+ESmBx69c556C61xLK16Cr0iNz+0RxKvIYXIhMsYUEqFsDnBgc0Zo5U
	ttkOal6t55UQXmltpi/oVhtLilHlGwoYj2H/dPWPPCFuzL+PBnOQjj0i4X9iW5VY0pZs4vJm3ra
	yoKNjhC/fc1HitvDKJDDnozFlPyzDWUetXVzIORwUbvRGNW+cKUxA3Bg2VOmuzPQcgcZFpyJheK
	/RhDPpyQNsZqOcphXldH2JCtB2bCpyBNoDbZZsLLMysx5RTEK6EhKhxhl5y2erQ==
X-Google-Smtp-Source: AGHT+IFEAzTDVSrfQaHBrVlArTCwFpw+84GrpGpmau41XAtyPIE4+iKVGaacK933d9ZcIjgxgBLgkg==
X-Received: by 2002:a05:620a:6919:b0:7e8:902c:7f90 with SMTP id af79cd13be357-7ff26f9fdc9mr1917938085a.15.1756968008300;
        Wed, 03 Sep 2025 23:40:08 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b4665fdasm41334976d6.40.2025.09.03.23.40.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 23:40:06 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b5d6ce4ed7so183311cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:40:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWX13Wc5EqaxDrINbk6rVkEe9cRW1FzyqKCVP+7mChAKobCNfVFl/2YqBFSMUp1+MCnOkGyBHDPANSANUQ=@vger.kernel.org
X-Received: by 2002:ac8:7c56:0:b0:4b4:9863:5d76 with SMTP id
 d75a77b69052e-4b5d909e59dmr2246271cf.8.1756968006022; Wed, 03 Sep 2025
 23:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820075405.1041838-1-wenst@chromium.org> <CAC=S1njQ5z2Ezz2OXDJ6Pk_9EEPgG3gu=Os7uFv6Lmdq0X77og@mail.gmail.com>
 <CAGXv+5GgGs5LEGJV4fpUpxOXC=_Fvo3CA4S10zZGxes9C2HrEQ@mail.gmail.com>
In-Reply-To: <CAGXv+5GgGs5LEGJV4fpUpxOXC=_Fvo3CA4S10zZGxes9C2HrEQ@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 4 Sep 2025 15:39:48 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B=0Zyyi2yJ5xD41LDBVYvAWoLu-oM_2XQORWgTDWo3uA@mail.gmail.com>
X-Gm-Features: Ac12FXywePb9g-RtWrinDg2p3M3RDgvhb_q591PKRsUpniRhwiiIjF_U8raEZa4
Message-ID: <CAAFQd5B=0Zyyi2yJ5xD41LDBVYvAWoLu-oM_2XQORWgTDWo3uA@mail.gmail.com>
Subject: Re: [PATCH v2] media: mediatek: vcodec: Use spinlock for context list
 protection lock
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Yunfei Dong <yunfei.dong@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	Fei Shao <fshao@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 3:18=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> Ping?
>
> On Wed, Aug 20, 2025 at 6:37=E2=80=AFPM Fei Shao <fshao@chromium.org> wro=
te:
> >
> > On Wed, Aug 20, 2025 at 3:54=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.or=
g> wrote:
> > >
> > > Previously a mutex was added to protect the encoder and decoder conte=
xt
> > > lists from unexpected changes originating from the SCP IP block, caus=
ing
> > > the context pointer to go invalid, resulting in a NULL pointer
> > > dereference in the IPI handler.
> > >
> > > Turns out on the MT8173, the VPU IPI handler is called from hard IRQ
> > > context. This causes a big warning from the scheduler. This was first
> > > reported downstream on the ChromeOS kernels, but is also reproducible
> > > on mainline using Fluster with the FFmpeg v4l2m2m decoders. Even thou=
gh
> > > the actual capture format is not supported, the affected code paths
> > > are triggered.
> > >
>
> We really should get this in as this triggers a very large and scary
> warning every time the encoder or decoder is used.

Just to clarify, it does actually cause BUG_ON() panics, so if the
original change is already present in a stable kernel, this fix should
be merged to stable as well.

Best,
Tomasz

