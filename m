Return-Path: <linux-kernel+bounces-774775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 259A8B2B758
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18F344E3A93
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0513729E11A;
	Tue, 19 Aug 2025 02:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOSeZ3Z/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097013FEE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755572216; cv=none; b=ceFPwt1YINdDoUrzQPhxVRddzATbEguHGB4Ostg1PJx1Wq0erPYaQO8f0qULj5vqOTo5mu3wfaAko5xYV0xjqG97o79PvAx2t46pWFRkZko7x5i+ANDD7ZNx64YYSSbsTG4iJMzlq1uwgMiwmPcS3pp0ZUypvk+wRc++vymwBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755572216; c=relaxed/simple;
	bh=vOTsLPHrmR4KWPLCxzIidma6yhGcdhM6/jmIPZ0Y6GM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACXC39Vvwxj8qsd8DzmBQKJS+sd/qc/UZak5YVVsu0naWeFCVGPOhGK8XalEfm1RJa4jC1h1VAliUAQ/S9G+R6Cf2Wy+kPrjn7DbwwCugmTvLO4n1QXFqGcqQxmr8fapEDLlT3b5KKoYauRYNoZXk9iQiZgp16B6zsO4Fn1OvDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOSeZ3Z/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755572212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30rtf85COe0Own+57CwCTiuCFuWNx+52rsJaNL6+eGg=;
	b=gOSeZ3Z/ILE9sAufFY/na3pQdkWDx5+IZHUgCFu7Glu3kH9X8PhdfN84fbwqDLMTFBlQ7Y
	dMHKCMyRVoyPnExpT1kekcaRfRHHmogb2TKTL+dm1HgjcNRhgTjTJkQX8GWWpCLGNKKqq3
	zMjWMcnEefZragmFIcfVlnuhfqR2UHI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-_6s0c5fVPna7dhqS2kWJ-w-1; Mon, 18 Aug 2025 22:56:51 -0400
X-MC-Unique: _6s0c5fVPna7dhqS2kWJ-w-1
X-Mimecast-MFC-AGG-ID: _6s0c5fVPna7dhqS2kWJ-w_1755572210
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4731a95babso2598946a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755572210; x=1756177010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30rtf85COe0Own+57CwCTiuCFuWNx+52rsJaNL6+eGg=;
        b=hpRpXWKsB9PuXVX6+LfCyVhkI1Omq7Zv6+2GjZw0E3vE7dnwJ+q8Tmk5mhU0m/9SvW
         Yn8cQEF+cQitK91pky5eQdVa89m8mX1gtVUH5uU9eVzXQwz7y4S3YkdZHuv9rZCwP/WK
         SWMKm4igpRSK7FDHxGnMED+H+9DuIo8YUTTDzbZjRI2T65e7vuAbyjHpvJMXUZa7JZ+2
         dsh23lkVn1QF/YKz94HKNzjcBsGAsh21wTuK0P03rGVw38RAy5JZAhtr0bQ3aA6hjFAI
         qat2FOqZCcC/1v5CPRm1AtkE85fbTnG1IGgEyeJ4h0qInFbaERBi+1bBCEgzvWb/hEZH
         IFqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdjvfO8eMjZcpZNKrpc9NGnuSiq6lX9o/Bjiy9nM1XcGoect+088JntYkeXdcSzMCJBImEl0/aiGOGIE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHd4uTVToz9Pe4lVi5D5xLrInSz1xrpnMtz1Xv9MaumZV8CLVd
	nqtYoKkRj3ecNpHOol4Q2eKA3l55v3t2tKuKrHWvFTHUpYJE5PxAEcG4plI5L3ZQa0U16jcbuBA
	fyzzTvA24w5QqLfeogS9G9RCmZMPZPdMugRx2hiUfmR4lxuIrpAD9gORys5//b3ZfDPbT5n71al
	Z3QB32S4ccpOwO2C+thCizrSPPFIJTmXYxjJiuzjlJ
X-Gm-Gg: ASbGncsVnKa8Nz/RPy4U/V9F7MQm6T+fkqiP2IZg4DirUm4724VPJiSW2U951MXYQCM
	nwhxpUvGkQGLIu5UghVOM4ngP16iSINjCd6kI9Y0ANWGCVeIeEGqgpAIYd0DGRrHHQIJbJZuAuO
	UF8ehXehJbZ3v09TspJaYVkdQ=
X-Received: by 2002:a05:6a20:6a24:b0:240:750:571 with SMTP id adf61e73a8af0-2430d4c1313mr1346431637.42.1755572209910;
        Mon, 18 Aug 2025 19:56:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnlIuMdMyqhr/p8CYdMvQzUInme5H88bLRkT2Jl0duOeXAZIWJz9QHEu8m1RFiElzvhplq7z95g+i2y/CkKNc=
X-Received: by 2002:a05:6a20:6a24:b0:240:750:571 with SMTP id
 adf61e73a8af0-2430d4c1313mr1346412637.42.1755572209496; Mon, 18 Aug 2025
 19:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKOLrqklBb9jdSxF@google.com>
In-Reply-To: <aKOLrqklBb9jdSxF@google.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 19 Aug 2025 10:56:36 +0800
X-Gm-Features: Ac12FXz4QQ7I_WS0I16x3o7tcM5Be883zhtqEJVTDk_lwuE3fHpjghTmF64HFYE
Message-ID: <CACGkMEvm-wFV8TqX039CZU1JKnztft5Hp7kt6hqoqHCNyn3=jg@mail.gmail.com>
Subject: Re: [BUG] vhost: perf tools build error after syncing vhost.h
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 4:23=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> I was sync'ing perf tools copy of kernel sources to apply recent
> changes.  But there's a build error when it converts vhost ioctl
> commands due to a conflicting slot like below.
>
>   In file included from trace/beauty/ioctl.c:93:
>   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c: In =
function =E2=80=98ioctl__scnprintf_vhost_virtio_cmd=E2=80=99:
>   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36:1=
8: error: initialized field overwritten [-Werror=3Doverride-init]
>      36 |         [0x83] =3D "SET_FORK_FROM_OWNER",
>         |                  ^~~~~~~~~~~~~~~~~~~~~
>   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36:1=
8: note: (near initialization for =E2=80=98vhost_virtio_ioctl_cmds[131]=E2=
=80=99)
>
> I think the following changes both added entries to 0x83.
>
>   7d9896e9f6d02d8a vhost: Reintroduce kthread API and add mode selection
>   333c515d189657c9 vhost-net: allow configuring extended features
>
> The below patch fixes it for me.
>
> Thanks,
> Namhyung
>
>
> ---8<---
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index 283348b64af9ac59..c57674a6aa0dbbea 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -260,7 +260,7 @@
>   * When fork_owner is set to VHOST_FORK_OWNER_KTHREAD:
>   *   - Vhost will create vhost workers as kernel threads.
>   */
> -#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> +#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x84, __u8)
>
>  /**
>   * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhost =
device.
> @@ -268,6 +268,6 @@
>   *
>   * @return: An 8-bit value indicating the current thread mode.
>   */
> -#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x84, __u8)
> +#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x85, __u8)
>
>  #endif
>

Would you want to send a formal patch for this?

Thanks

>


