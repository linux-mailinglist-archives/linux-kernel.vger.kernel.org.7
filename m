Return-Path: <linux-kernel+bounces-849005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6719FBCF003
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBFF54E6581
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1890A1F4C87;
	Sat, 11 Oct 2025 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4KoTLsx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA441DB122
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 05:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760160198; cv=none; b=Zc0xRTWppMsr6vnANvfHBnbrkzWEXAngMS0kwn+FLij/f+dL3Sh24PQNK5W/mXvXC37m/rZAqI66VEn7bk3+wqa0CMb2/fb7YBd6T+Wb9pXZ6f1xwsyTdjqX51Vkx/BFbaBzYxSET20tut0FBIaQ4uLRo4ZAA7SnWH74pCFEUaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760160198; c=relaxed/simple;
	bh=ML9ZQr5qtEGcPY8cDifgT0HpjpbxGqYI3jcd5xULUAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqnQe8Qu/5VCYlK00AqoMKhmaJDwrkgYO8Lr1V2r6QvsABX3IF2qQr6DDB7d1KzI7lEZUQI89yTv8vtk8qlOCHJWua8/dFaYJW2Fs+3Hjxt6/pTfhZNUz4aJNzRqiExpjzgXIIzDQ//+hvo+1SELz3iFuFEuuEFw6NxhSQjB50M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4KoTLsx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760160196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWQu2WGPhVIahnhNe0m6Df6o5Q5Z3ctJ9ZyziPIltjs=;
	b=D4KoTLsx6PyE1CzGu6K45Be+CKLDSA8jXu5/hW2VzmxU7e1Hw9ZpuiSlJ3n3CXPFB2Qq5N
	X/Rortx/hixhEeu1HLn2jA7HLobqgHVjAA5bIY+plEeXsptYAxOSjEJLsc5Ve/zYZ8EkyU
	r2ZIXM7KDkuWpHYXJyg5Evh/sExHp58=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-sw__syfQNiStRTETCbyArw-1; Sat, 11 Oct 2025 01:23:14 -0400
X-MC-Unique: sw__syfQNiStRTETCbyArw-1
X-Mimecast-MFC-AGG-ID: sw__syfQNiStRTETCbyArw_1760160194
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3305c08d975so6732108a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 22:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760160193; x=1760764993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWQu2WGPhVIahnhNe0m6Df6o5Q5Z3ctJ9ZyziPIltjs=;
        b=nBFddMELujv3RL7u7Q4BAZBtNOH6O5N/Jb9sgUzNyXcerLU/tsLZZefagm6FO5yCdk
         fAQuzSGTEm7f0DOHxVGa2n6dx0AwWn04Dvas+vVUQal+4/8m21XOVVIHZHF+tRqBrO+L
         euKD776Quwa8J9pg7WLCWwCEBb6bYEpQe057asfnj32CT9jVXGzNhJJ/YVFibhHUAj5R
         YNwSIbacvBfyzhlsA/mWZI9maf2ohcup8BADXMe4Jf5CjMm8l09xgNR6MZz7G3qy7nQn
         1OVBilT0rTsF5dgQh9Cdz2d8SIrk//R6XImF0n4UyJafPN+8c05ln621v32TZ9S60QQK
         5GKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtpkaXDlvt6OTgq0coPQL2QSMmDXVSXwwCrrA4MgHhHRWCSaSaxOfOr76lzRdhHI7u9uOTvj1wD2IHI2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5X1HPJ2Vw59KrSBNKia4+fSI3KwzxtoV3cAD0sIN9wWp5yW0O
	v4htS/xEYOr0PgTw8+62y054YpBIEIC/Pcn6gFbYuDJh6w6I6s6EF22IjouwUnfZFf7yEnmi/tb
	Mkmtpg7Xnc9yKSdDwWJoFg6rOvQDxxN1HVKTq2Z5U6EA4QfPawTrhM64De7jLWn08rcl92Zhbq1
	0mYncdy4Xbzkm26mAF2sAt7o4WIbjRZAOhhNzKdr/f
X-Gm-Gg: ASbGncuHXFN/HjazPZG/BE4wZC4NHGtnCrmjJIPfXkX1DwZHWGRXBae7HZ566z1k7dT
	jlcW5tWYewlScsUji86mo5BggpMa1DqR0WWlbL1rxBbe2Kn6Mz3nQJXpeNuh3G4ZfRWYsXt2DOt
	Da5kt9aEX6XBC+YcqZxg==
X-Received: by 2002:a17:90b:1e06:b0:32e:936f:ad7 with SMTP id 98e67ed59e1d1-33b513a1e9fmr21398906a91.27.1760160193682;
        Fri, 10 Oct 2025 22:23:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP5N0j+lF1l6DP1UUMeDKPPGWGysv0k6+OdDZIQppdrlog+Rls2Qb28QkmANh5HgziapaNwTapps756d2070Q=
X-Received: by 2002:a17:90b:1e06:b0:32e:936f:ad7 with SMTP id
 98e67ed59e1d1-33b513a1e9fmr21398889a91.27.1760160193302; Fri, 10 Oct 2025
 22:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010085827.116958-1-eperezma@redhat.com> <20251010085827.116958-6-eperezma@redhat.com>
In-Reply-To: <20251010085827.116958-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 11 Oct 2025 13:23:00 +0800
X-Gm-Features: AS18NWDV6gt530hRMSNr0SDAAntHl3ul-57z_6fY_ncu_SQpA-XmeSLZwozh8LE
Message-ID: <CACGkMEvSm_YQGgrGjaLU0DM7XW+YLeGi1AdvRn8PzKwRLW5Cpg@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] vduse: refactor vdpa_dev_add for goto err handling
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 4:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Next patches introduce more error paths in this function.  Refactor it
> so they can be accomodated through gotos.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v6: New in v6.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


