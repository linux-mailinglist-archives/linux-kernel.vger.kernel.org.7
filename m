Return-Path: <linux-kernel+bounces-724024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28950AFEDB6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A1A57B59F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5812E7F18;
	Wed,  9 Jul 2025 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7S94nnE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E672E7F10
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074811; cv=none; b=oShn9waoEzVUXiSUKh/DEUd4ubqXJnRjsf8FcQ9IzADsQOFbWgQZpptWFke1y6J9ix+4lZ+RcDYPshk86+hj0OvSiSK5UUYWncQFPk7JAZ5PXva7Sq4jeCf1zlviC9DAKD5LU3YnW5H8Mye3OTrupDiKZVq4Jc5MF0f4ruLWX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074811; c=relaxed/simple;
	bh=Lf7bJFk3uV9MKQuav7jQz6/MttJtMdGad9u+KUEboXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xscyxqw/bNuJJlQ6i6OmcpCmLC7awuphBKlEbXFYWTLwCJDVbNLVxKFAylYbTj2jBOTr7D1w0Ke91dMV9krRQiHsJoUmMQUX/xQ/T/mPNrdnieiivk2q7vURl+mvmedlEMpAfa1IQmsppY+viIxjat8nrLHdRA39nDUaZRVrr6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e7S94nnE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752074809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lf7bJFk3uV9MKQuav7jQz6/MttJtMdGad9u+KUEboXU=;
	b=e7S94nnEGpSrKl0vjipYKF8SDOGfV4owufizDIvNlO0d3nq4F1+J3Q9rnuJfIZuz0PrlyQ
	V22Dsxm68Y6EPeZ5O1wcwnFTSje6dmk/5Vfje/3vpvVLhnkqh4zvF2yIH797UUrsCxVbLQ
	zd+vH/cbGBw0euLrC2d4pwUdrrRi4bE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-KfTWJwmNNqC5Co2mcI4eJg-1; Wed, 09 Jul 2025 11:26:48 -0400
X-MC-Unique: KfTWJwmNNqC5Co2mcI4eJg-1
X-Mimecast-MFC-AGG-ID: KfTWJwmNNqC5Co2mcI4eJg_1752074807
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-714078014b8so737627b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752074807; x=1752679607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lf7bJFk3uV9MKQuav7jQz6/MttJtMdGad9u+KUEboXU=;
        b=C3+RDFjUrdJXiS3JlNbyF7dvEc+2HNyPrGLbABY1kYxwsUmmYClUPwt2i1C/eDtg8X
         POeUh1xGfJQUV6lermwhWHjXKQxsywaWAAUMJ9QSohXLspcQZetlJSIHnYbmI7d9AN0k
         Sb41i8bouDtvw4RvI613EfHefXbLP8tXFd+2sZsRpccTBmMupD2nZtI2RVr36rsr18Y8
         CUKBbrO3WJ5TizKjXdKkbbSmMVY8U7oMK+FajXczcZLLH9XiIN1rVOTrqewU7Djm+O8c
         gYGeBZ8QwiNgdkQc9XwPHhYurepuhNXr7aLIneOIPjuzPC39H3/gkRR+4iA50RaCGJDs
         QEPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfQUEHhU45r//MrioRulQY+rE4lxuXu10ItRS1Xge/f5NMt/53xr+aw8Xqt8Y1EHTFglQFj/T49AzD8e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYdujzrYzcDwY4zE6UUM1gQIvHcplQ+fY7O4KPenJPyFRs+9fR
	c9/tZ/pk9otFbI96veRnOAGzmYU/P2ykDO6s5TYpgcA5sE1F9srAZPOOFLJe4BB7GhzimFRKRPe
	hKBVcl0HLUx/fBVIsumXvYhnNdvMWiv5zesQce2M9QwIJEZPJ8VTZ0ySB8tk+0/UogjQgMBgqiR
	hlQIseOCK31bqKrhaJnZnX/0Wh+jHf1HUQjjcviCcM
X-Gm-Gg: ASbGncsXGmP9yf1GarcK+1MOHB0L/bpwVWD+7eTZ67dclAXv4E8vW8MxB3Q92e4htBn
	bhGD7lhoflkAKkWtLJZKwnfHkSrbHS7+06jQjaF7y5FATktv8P3VzPZ8I4RljyAXveqUydscJgj
	VX/P+5
X-Received: by 2002:a05:690c:4d83:b0:70e:326:6aeb with SMTP id 00721157ae682-717b1696280mr41605347b3.10.1752074807345;
        Wed, 09 Jul 2025 08:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9oyUbfKLC5sveWj0ptirc82cNeL70EgaNkak6GlzIurDedMJZY/972EbTHi8rpQ5YCU07IRWEQOOiaTHdLVE=
X-Received: by 2002:a05:690c:4d83:b0:70e:326:6aeb with SMTP id
 00721157ae682-717b1696280mr41604877b3.10.1752074806659; Wed, 09 Jul 2025
 08:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <472a5d43-4905-4fa4-8750-733bb848410d@linux.ibm.com>
In-Reply-To: <472a5d43-4905-4fa4-8750-733bb848410d@linux.ibm.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 9 Jul 2025 17:26:35 +0200
X-Gm-Features: Ac12FXyNj6u4xw4GpaDSraC2WH1PFh63NMAa2Sk2WZqN1f1LqOBvccFzhXYQrfM
Message-ID: <CAGxU2F7bV7feiZs6FmdWkA7v9nxojuDbeSHyWoASS36fr1pSgw@mail.gmail.com>
Subject: Re: [PATCH net-next v4] vsock/test: Add test for null ptr deref when
 transport changes
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: mhal@rbox.co, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, v4bel@theori.io, leonardi@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 16:54, Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
>
> I'm seeing a problem on s390 with the new "SOCK_STREAM transport change
> null-ptr-deref" test. Here is how it appears to happen:
>
> test_stream_transport_change_client() spins for 2s and sends 70K+
> CONTROL_CONTINUE messages to the "control" socket.
>
> test_stream_transport_change_server() spins calling accept() because it
> keeps receiving CONTROL_CONTINUE.
>
> When the client exits, the server has received just under 1K of those
> 70K CONTROL_CONTINUE, so it calls accept() again but the client has
> exited, so accept() never returns and the server never exits.
>

Yep, I saw exactly the same issue while testing a new test.
I already sent a fix:
https://lore.kernel.org/netdev/20250708111701.129585-1-sgarzare@redhat.com/

Please, send a T-b/R-b on that if you can.

Stefano


