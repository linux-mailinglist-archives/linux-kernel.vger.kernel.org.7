Return-Path: <linux-kernel+bounces-878967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96466C21DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3D73BE638
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC972F6199;
	Thu, 30 Oct 2025 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0yQSi0/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681232594BD
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851382; cv=none; b=IF4uCbaiEsiK4A4BfuLPldUwKmkYPWVTT1JFk1g4GjOJxbLVeAzVHriCUSPcu6kjz9RymQfJJHcTELs4K8FgbOmJHf8XbJwmASnKBYeetOICUNciq1tIySC3WcXvKPoDLzP8nobToDQbR8NH8TeymxTUuBUr6xu4ocgoR2gYmDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851382; c=relaxed/simple;
	bh=EyuBk+X4Xtv/VHuZ4DGi74RMzDlECKuEB5Qc0qEFpTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucvgkeQtg3LHdZtXLQYMKh094rSmvaGWqhQEc5TJqZYqs9YFj+nKg69sRSxEGCiANqRLKK83dHMVNxWTsOpvJzew5f4mTwfJ8ELFtMfLJn0kct0P91TZopyShKmlKcL59IUtFlQ6Kp2zw0Xk1bmg0tqqchf5RO3Q4BrKwNo1cNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0yQSi0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2321AC116B1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761851382;
	bh=EyuBk+X4Xtv/VHuZ4DGi74RMzDlECKuEB5Qc0qEFpTQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M0yQSi0/XE8eNzL6xoP8KLZ9qWEF7xhkttoGPFaBgcL+A3OUuSJpU6BxdR1RIxeM3
	 RXr89YpAc1UXykMgmtR88wRQ05EU1tX7WgDbpJowAUhtB/yUBuOMzz1JTIHy0zE5z7
	 jR1q+sG/uDfWDgQZLIkB0EfAZc174ffgjp5ADzC2dRVqsjmPXdGXXyuCVikEnLRy4m
	 7ua5MuewGOoDSZ3cSRt2L/WpVM1c5I6nyOZAtGupIQz0CKkKP019yBhMXO1q8WWpJG
	 ruPNnRWPYA2FAiXEo9QHZYTy6tvicSJnf44LrvgOaVcHmc9YKmSGCVywqeDaZ+zwhY
	 pZc5C/oGibCEA==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c2948b774cso963814a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:09:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfe55jcLaVKHB5Mrp/mAXjvUQu77AfihGToANGjV7B58IigmMaWAec5tdKL0g9gddg6vmKgmygzSrBejM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxen59q6YctQuokBNguPhbs34jIooGxnL2Mq+SatEYNLEJCIPBV
	SI2a+CgiBCtLcUsTH0zERdMGuygFYYiyKvxkacmmrB6OBn8HcFGiF1gCfE/0Whj8seybdbkzqly
	QMvNttVwfXzUgdkFqXZvQgPVL0JNdPOc=
X-Google-Smtp-Source: AGHT+IF6/vemkc8wGB+v/a2MDv0yQBS8cuTZTP4rHdPYEzL/6vxgdSA6TqUt5s0tYWepDl2HrqbLJN5OwR0Dh4tATmY=
X-Received: by 2002:a05:6808:c2d3:b0:43f:7287:a5e7 with SMTP id
 5614622812f47-44f95f86734mr380125b6e.34.1761851381403; Thu, 30 Oct 2025
 12:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761046167.git.luoxueqin@kylinos.cn>
In-Reply-To: <cover.1761046167.git.luoxueqin@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Oct 2025 20:09:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jmmHORHg7HSyTKfZrSwY22geh54JT3T6JemtXpaXgtiQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkYHuPmGji0cMG97NrFUpvvbXYCaLmgmSgt2giu5eTBAk8DrCmpLOZ62HA
Message-ID: <CAJZ5v0jmmHORHg7HSyTKfZrSwY22geh54JT3T6JemtXpaXgtiQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] PM: hibernate: make compression threads
 configurable and support dynamic crc arrays
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 1:37=E2=80=AFPM Xueqin Luo <luoxueqin@kylinos.cn> w=
rote:
>
> Hi,
>
> This is v5 of the series to make hibernate compression/decompression
> threads configurable and improve scalability.
>
> Following feedback from previous versions:
>
> - Patch 2 (`PM: hibernate: make compression threads configurable`) has be=
en updated
>   to rename the GRUB/kernel command line parameter from `cmp_threads` to
>   `hibernate_compression_threads`, making its purpose clearer and more
>   self-explanatory.
>
> - Patch 3 (`PM: hibernate: add sysfs interface for hibernate_compression_=
threads`)
>   has been added to provide a runtime interface under
>   `/sys/power/hibernate_compression_threads`. This allows users and
>   system integrators to tune the number of compression/decompression
>   threads dynamically without rebooting the system.
>
> - Corresponding documentation updates have been added:
>   - `Documentation/admin-guide/kernel-parameters.txt` now documents
>     `hibernate_compression_threads=3D` GRUB parameter.
>   - `Documentation/ABI/testing/sysfs-power` describes the new sysfs inter=
face.
>
> This series ensures that both boot-time and runtime configuration of
> hibernate compression threads are supported, improving flexibility
> and scalability on multi-core systems.
>
> Xueqin Luo (3):
>   PM: hibernate: dynamically allocate crc->unc_len/unc for configurable
>     threads
>   PM: hibernate: make compression threads configurable
>   PM: hibernate: add sysfs interface for hibernate_compression_threads

All applied as 6.19 material, thanks!

