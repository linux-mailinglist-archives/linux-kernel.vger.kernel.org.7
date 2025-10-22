Return-Path: <linux-kernel+bounces-864443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6FDBFACF6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6969A5841B1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA7D3019B8;
	Wed, 22 Oct 2025 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4kXMwh5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10C1301038
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120501; cv=none; b=HDdkweUbf3j3j29etvGTGtH95reFyJaX3Rqr0loiXRnzxZSO+lYDyd2/V6BodCmymRLBuSVz+CuffSmQ0xr8umqeFf3fhtMcPC6hMhEzbJ9chpQ8b51YAKr0r4aQJTb0+RgQS8KNiu6sPhWI2QXRk5zj/dVwfGKYm2HR3i2qnAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120501; c=relaxed/simple;
	bh=tFK1KO4D+0gMTo4v0IBwFOBDfCPoPkcaJ3yQdNMsf7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvSE2zt4micuTaIPLUFQITvcG3k+Wenb3Hsx11rYgoRCEuUjmmoiZo7E8kmfxw48fCjWyJkWx5ro0M/BkKYM5h/PR6tpo9lxfC5D/QGOv8/MrUbNz2bMqbMikIW4rEvHmHCIF4ctcJQd7FicMOMM6fC7TKZxbg3GwQwIC2BeuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4kXMwh5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761120498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tFK1KO4D+0gMTo4v0IBwFOBDfCPoPkcaJ3yQdNMsf7M=;
	b=J4kXMwh5+O9lYhwp7kIc4fhrXGHXb+ddpmxQp4iJcX3XNUaBbXawsAnIJJUFplI0EfLO/Q
	nS4srEWCLUQF29Cmn4YNFzeNGbP7O8BcgC/DgFOeu75latozfwBpOqqd5v8poNL5Pg+ArI
	Z6tNkLgH5Q7IL9IlWfuZhaEv6BUtqDc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-MxjTP0KeP76JvURrX645BA-1; Wed, 22 Oct 2025 04:08:16 -0400
X-MC-Unique: MxjTP0KeP76JvURrX645BA-1
X-Mimecast-MFC-AGG-ID: MxjTP0KeP76JvURrX645BA_1761120496
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290cd61855eso52626155ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120496; x=1761725296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFK1KO4D+0gMTo4v0IBwFOBDfCPoPkcaJ3yQdNMsf7M=;
        b=mSW5UhQ5QR+wjBuIyhQVaUy26Lev8gCV6yK2+rODys21E1DAAzT+ESPEfgKwo4qYG4
         7RZOcpqMuGltbe3JpS/B1onP0FEGDEprLP5D7Tb/NcDU34OeSyZ5nKNZYH6/x7LZOZBk
         3YpK6uJ4zVrcYZszVgLW+vVCVqzxuDUDgzA8RvVHh6jNoCqCPhw8YmrGxxXRLOfaeEBI
         4YpyjR8qJgkhXE8RyFrZ1yUB6HE0x8wB+ohT4VvDCWqf+73CmgFcWSLNdQxnx2j4jF2h
         HMI1FV2uWHBkkhUlDcC5XRk1PYUkS8FpSVfeeTqaOvfas1rr6YzrXpfIKUNFdNGwWUvx
         Qlmg==
X-Forwarded-Encrypted: i=1; AJvYcCUoIezb6VXViWoqZrRfJgBE6gfYO/0tkl/vzW4Vu8gZ7/Ht8tqzCPMsd3JqI13o+uWOMnChTKoSRIJ8Z5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz81ZiWeUAB1V83zrGBKETl9s+KVo1/b1Zd86La4eSjxdJTG4Gp
	vn1aimtNI+shsPVuVhANVc7Kz1OXHzAVysltDhk2bH1LcoGeRKWsqqxWqDRPsTp7RmRwM5TZ6QO
	NBf2tbya1l6TLAgM9rlbuKGpzlH+FWveVOn9fT9KXj5VGNcK3h6nrLTGbxMvyLdqLBDgz7n94C0
	JbCQe+tlPqBtmkx6kfG9F+QloPg112DZd8odXQpTl6
X-Gm-Gg: ASbGncv3kge5qVQt3Rsgp3AieOs66rvGDJqidlsJ2nZp6P7uCKVUh897MiSHrKT4Gfr
	DZFMz3tx173uezMj9YphToIbDn3auRMjfJz7vcTllDMyVheEFZhBh0V5jzOPM1yx852aZLyWwd0
	aivzb9t8zDjNFxGpXEUb11PJM/RluO9RJ7vH/+F5jmLwTcOd22W/oRys+od286Foq09YqoC4w2F
	07spLUZs5A8DSG/
X-Received: by 2002:a17:902:e5cf:b0:290:91b1:2a69 with SMTP id d9443c01a7336-290cb7560b8mr260211635ad.52.1761120495720;
        Wed, 22 Oct 2025 01:08:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo2XP/jVdY2pcYFKz6OnG7bzc461hULcT1/QO/xAI+P9k7vDhd+aVTkvwMGDjMEU/z3u35v2XMOR7IkEnO8xg=
X-Received: by 2002:a17:902:e5cf:b0:290:91b1:2a69 with SMTP id
 d9443c01a7336-290cb7560b8mr260211445ad.52.1761120495404; Wed, 22 Oct 2025
 01:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022072729.14820-1-xion.wang@mediatek.com>
In-Reply-To: <20251022072729.14820-1-xion.wang@mediatek.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 22 Oct 2025 10:08:04 +0200
X-Gm-Features: AS18NWB0L38kFa0XqRBxBuxoOL0blj0prvtzV3DKxomco7xkygfsMEqvL9322_U
Message-ID: <CAFqZXNuPqwfqA23LH8NOG6KM1Nb7WvW77wnpp-vZ5omU40j_qQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] selinux: export current_sid API for use in other
 kernel modules
To: xion.wang@mediatek.com
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, wsd_upstream@mediatek.com, 
	huadian.liu@mediatek.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 9:43=E2=80=AFAM <xion.wang@mediatek.com> wrote:
>
> From: Xion Wang <xion.wang@mediatek.com>
>
> We have a kernel driver designed to monitor the status of the Android
> userspace watchdog. The implementation works as follows: we modify the
> Android userspace watchdog code to periodically send a "kick" signal to
> the kernel driver via ioctl, so that the kernel driver can determine
> whether the userspace is still responsive. If the kernel driver does not
> receive a kick signal from the userspace watchdog within a certain
> period, it infers that the userspace is stuck. In this case, the kernel
> driver will dump key process information at the kernel level and trigger
> a full system reboot.
>
> To ensure that only the legitimate Android userspace watchdog process can
> access the ioctl interface and perform the kick operation, and to prevent
> malicious or unauthorized processes from spoofing the kick action (which
> could compromise system reliability), we want to identify the calling
> task by its security identifier (sid). By checking the sid, we can
> effectively prevent unauthorized processes from sending kick signals.
>
> Currently, the current_sid() function in the kernel is defined as
> static inline and cannot be directly called from modules or drivers. We
> propose to export this function, so that the kernel driver can call
> current_sid() to obtain the sid of the current process and decide whether
> to allow the kick operation.
>
> This change will help enhance system security and robustness by
> preventing the watchdog mechanism from being bypassed or abused.
>
> I would like to ask the maintainers if there are any additional security
> concerns regarding exporting current_sid() as a public API, or if there
> are any alternative or more recommended approaches to achieve this goal.
> Any feedback or suggestions would be greatly appreciated.

Couldn't you just use security_cred_getsecid() or the new
security_cred_getlsmprop()?

Untested:

u32 sid;
security_cred_getsecid(current_cred(), &sid);

-- or --

lsm_prop prop;
security_cred_getlsmprop(current_cred(), &prop);
u32 sid =3D prop.selinux->secid;

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


