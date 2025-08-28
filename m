Return-Path: <linux-kernel+bounces-789162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF20EB391D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADBB682A20
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDAD261B67;
	Thu, 28 Aug 2025 02:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RT41DvCK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F4325B1C5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349011; cv=none; b=LF1Wy2BhHos6IcdYi3uvlmCSRCLG+FwqiYMZBne2e9FnpRA5IOgpTL8nqA9agHpFpGfe/NcsnjtBNMo8zjLrpOA71m/XYaJ9Fx0cFr5JeZGiqdSAbB4Qs/qZgLTwZri/yWcGE26ZG8G6++E2lC4JdLojrfjprRRvNol6nXV0w44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349011; c=relaxed/simple;
	bh=FtEPTa4Dy2lq8qJWWzsiBzS0C8SD7cKdkopMOEifno0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQM3/8ZGy8n36B8lWKuKemFZ/u0Aw2HdmjewiYDtM7oIQjU9WU5Mni3QcwEoOCT5duVY57PYhn/GE5ECZGhNl9LJHvpDeIfsYwIhPoL9U8rxpK/tSvmYVrfk1gpU4ft9fhDYJGzvsUCgpKl7k50Lt/lSECSLP3WJKLtHcIKKHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RT41DvCK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756349007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVzFqi3qYGzTZymoMc9gsg7jQyopRP+VJ4wN1OXKbW0=;
	b=RT41DvCKVJ+5aj2CbX7npWxG5/ImZulpmQjulIfvC7NCsnYm7Wmrmu/oaKrtWy+tcF0+Rm
	TgpCFlMVgR5ca0XMzk2Qoo4cZEQ0hBtpHhKyES7sU9ZV9lpTGpYkZfZqFAMhlbcRy2l+09
	IWZ32jU8btXzWNTAh7YY4OHo4ZRR33A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-NlsvkanxOiyrlfX1t_zFDg-1; Wed, 27 Aug 2025 22:43:25 -0400
X-MC-Unique: NlsvkanxOiyrlfX1t_zFDg-1
X-Mimecast-MFC-AGG-ID: NlsvkanxOiyrlfX1t_zFDg_1756349004
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-61c69c2872cso252276a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756349004; x=1756953804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVzFqi3qYGzTZymoMc9gsg7jQyopRP+VJ4wN1OXKbW0=;
        b=Dr8MZlKoYTOk2QrTqfWeUma9tLJeyQcYG1RXMDVATcSaXMwnDeEQKhzEqQBCllS8yR
         Wn/dhI+I8Fh3FmcQEMgH178w8tzLhErSZjmMN95gAMq1xH7PAMhsaOgb0KTOqn3bJjCy
         jHcDUSxlpnGxHtRop+9OA/ExoRJKbqA5lVliuP95TUhPtI5F9rqV2ss7v60AbcFvYdpg
         B7QbZMIDBybXGTA0lfR5RopjuBBMHJsiI2b6HEAR3m2bG8s/n0NNPRdA3AfaOQ2Qdjd5
         tZK3BRP55vNernIWkS8YDvf0AAE5JvD6kt2WdPdhULeziZ+s5i/h57o7SPFsa+40SE0C
         txsg==
X-Forwarded-Encrypted: i=1; AJvYcCUqREcX1Zh5SBit0Lxr/1mZtSat9PXvWn2DPvPxOMSDUeLIQqFCN1SX6ken500RZHhuNuECOGHhmw76fvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzzCk0aHJQK8SaTuWx7xMFJg2Hredp9SEewVE2x2E3bhTve+57
	9mTNvzq60qcyeASvM2NW0fVmCByyxCbPx3xsv52QkO182ejs8VXgLJWWuZOQUH9u9kaqJwbMkT4
	w5JazHkPpXZS1d5UP6jQ+B9CkVyLUOIYBRy/DrbQofoMDrIkQd1Ku+AeRWqeAIuZCjtwb4uIIPk
	8l88TBVLf4rZeNfTaCxDC75BHI/SC3M5cocb867TTM
X-Gm-Gg: ASbGnctWrjqqs5SqYAdZoKhBMQL695wWEef9d8+dekM8hIjckzixbdCe5KQOE1w83R7
	UHzDddNSRrhrTztWEvajCPTZMFnv2ttUsD5Y0IJ63cr/QLyxaFQTBsQ4QvtrsNVAguvVfd5e9K4
	ULcW76ZmxMkVdyEqfW81eObg==
X-Received: by 2002:a05:6402:280c:b0:618:4a41:80b2 with SMTP id 4fb4d7f45d1cf-61c1b70a459mr17263466a12.33.1756349004189;
        Wed, 27 Aug 2025 19:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLJP7RVQ7XggHy4wLklb0+/anyb2o4/+NcZbJ0ac7BY7NdvZ8eKkWZUKb7OLDIF0YQ0f0iZv5O0U1kANohzIg=
X-Received: by 2002:a05:6402:280c:b0:618:4a41:80b2 with SMTP id
 4fb4d7f45d1cf-61c1b70a459mr17263447a12.33.1756349003785; Wed, 27 Aug 2025
 19:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com> <20250827201059.EmmdDFB_@linutronix.de>
In-Reply-To: <20250827201059.EmmdDFB_@linutronix.de>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 28 Aug 2025 10:42:47 +0800
X-Gm-Features: Ac12FXxm1PYVDZmD5Ru0N_nQlupVeshkDMt_GvrRtBisXzJaavMi349lmdLEkns
Message-ID: <CAPpAL=weN2kjgz4n8JtAPytHQi+828v2xUTHJ4Tr7GdTchk24w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited task
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches's v2 again with vhost-net regression
tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Aug 28, 2025 at 4:11=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-08-27 12:41:04 [-0700], Sean Christopherson wrote:
> > Michael,
>
> Sean,
>
> would the bellow work by chance? It is a quick shot but it looks
> symmetrical=E2=80=A6
>
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index bc738fa90c1d6..27107dcc1cbfe 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -100,6 +100,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
>          * freeing it below.
>          */
>         wait_for_completion(&vtsk->exited);
> +       put_task_struct(vtsk->task);
>         kfree(vtsk);
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_stop);
> @@ -148,7 +149,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void =
*),
>                 return ERR_CAST(tsk);
>         }
>
> -       vtsk->task =3D tsk;
> +       vtsk->task =3D get_task_struct(tsk);
>         return vtsk;
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_create);
>
> Sebastian
>


