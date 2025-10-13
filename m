Return-Path: <linux-kernel+bounces-850708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A730BD3A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A6ED4F641B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861DF26F291;
	Mon, 13 Oct 2025 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyjqRqSN"
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73979221F20
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366101; cv=none; b=Kupa+1rWQRbj2eELXz+NWvMZoxvjFNSnJbO5k8VSZFd5JGcE/PTAHVyw6zBRgA+pM4ZlAxGk82WKH3mltRmBHDtZCpD5xIJjl3zmj0ibdWZ998nmsIMyKg3vFwo8mVvO05BHc//2l0sxYiCMllcuMsBH9/x476DokhbNX55rU5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366101; c=relaxed/simple;
	bh=OUBzFA0EWu6+C2ZUWePVBWalhb+/XSYRn8tZPem7vlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nb/LyiJiSkvTVNkNZ0HkFsB7C9V5B/I0nMBTI27NxOEmnXbHw5iPl3Z9KgGcJsKyELv2tJDE5ZvHw3Ft94lGVh6qd08fs3ILcYPF79MPeOdXWkL2odosZt/YtwLmrBjmtDR5yDYGt10PCdghVIlBe3wTEmYv0gg7WfO6Esedo3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyjqRqSN; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6360397e8c7so4420789d50.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760366098; x=1760970898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OUBzFA0EWu6+C2ZUWePVBWalhb+/XSYRn8tZPem7vlY=;
        b=JyjqRqSNf0aHm1e0wI7D8IMTkbZFdzBXxlkaV5ImUpnd1oi8nzMJt2UmWXUbBsKyf9
         2ohdTWeouQeK8ATmOJw/45XynzeNQmvlD2iGCyZcNH0Dr3RAMMDlucCW52gBTL9Qp4kx
         ehg0239ym6QWWTJLVZIybj9q3M/+vbW7uT0xVbEllXjGZ8dNGOrabtuTiXpvGQqVMRSk
         fUUuEax2OEhtWgwbgEbU/HWaW/ueKKVFd8EhCsbmEDb+whcX/DhebM3cjNRYNnXv3xsc
         sR9X7DADJ02kIJ/ln5Soj8G3T/kTInCaVnD/6UMqZX23qdAWuzoqKwhlHBHqVZFfc7+Y
         afHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760366098; x=1760970898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUBzFA0EWu6+C2ZUWePVBWalhb+/XSYRn8tZPem7vlY=;
        b=N7DRxZiGQg0jotr+KMG/BjGMOi7pyzebaTrRG51M+kP+Uq6w4H7A4oDC0K5yRvWZ7R
         E4q0hEPPoHHGkhFUKonYprX3Itarrjd9nY/NnJAwgl0drbfuJZPSpO0A0oI8v2NMqkhR
         bvvmu5iHVMafHFoOWfzOYg027lFQPiwIg3erse4+rX9Y3qlIHdkTS0cu2BwsK5D+4rNU
         xZ3HxzH1gU+brYzwkm4+EmxUTUjhhxwAhAi8qklFn9QRicay+W3RKqFGJjZ0AykMTVKA
         B9Brq8PYElm9HLXbcC9EsQhGm10c560NuxzCxrERKxoLxUcFNeAJcU7rd5/4j8h+03Ku
         uy6A==
X-Forwarded-Encrypted: i=1; AJvYcCV2HkcyTWkXy+epq7ACS23bsn5SovYI32X63zKT/6CcZ/J4uFD6bpkJPPwShNJjL84/fqDGRrJbdj4jvkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUVoPSuEOZ1G4+/PmjuceAp6tVDLIPX5ISGJyvh1mJChKyp13e
	fYWkUj+Z2OwTaNPjMSjbEx0CuA0WZ7/2EJBbfNIDP3vIfqAeRE+nyR4ri3zgh3tc9ASI3nzjk8t
	UcgiM/6TH4Xmq7o1xunIXNUdwyU5LlhuLdZvafA+XZw==
X-Gm-Gg: ASbGncuaYB6kqXVdG115qXx1IXhqnBA1QAy7W0tS3lK6qMXZfrbSbsbwkhmC3ttnb+4
	ohPrRecteqNKkvErjrQdxiKeQEd5OoqOP+iyXSdz4/FMRqto0OHoZk0hOBV5svSsdDqFXxOXMhS
	4FtWSCvNkDajOEVuN8dj2/AWJSIwlJLhrgtOZbzloAasWIaoiJTs+hlVIPaZTWI8IucNdFkGg/B
	NM3wHZZCWqGt+Wz0WPqKrpgpCTn4IID3cXEH40P+ke+66ZbpEc6LNjLRaU94OSIN4TVBdmSefXF
	i79uNOGKSqupZu4=
X-Google-Smtp-Source: AGHT+IHLCK4ACBaTIUEA/LGVtl3MWQLwbAyoauPQDGgrE+Yd88kcEKxoUMbTBKKt6QPyVCxc2yUDu07Tlaopdnhokyw=
X-Received: by 2002:a05:690e:246:b0:63c:da95:21a4 with SMTP id
 956f58d0204a3-63cda9524a8mr11633399d50.25.1760366098354; Mon, 13 Oct 2025
 07:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930112810.315095-1-kartikey406@gmail.com> <4962e5a0-a03e-4e9a-8f8e-5db04504c30e@huaweicloud.com>
In-Reply-To: <4962e5a0-a03e-4e9a-8f8e-5db04504c30e@huaweicloud.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Mon, 13 Oct 2025 20:04:46 +0530
X-Gm-Features: AS18NWA6PkfGAzcoJajFKMNWANM0EYZlmu0IVwjM_yZHVDaXZ0OiTvbHLF7CG7g
Message-ID: <CADhLXY7Q87ZAMV_j0a003pNqJ0GNqEpC9gBLAeTaW1pz=589UQ@mail.gmail.com>
Subject: Re: [PATCH v4] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
To: tytso@mit.edu
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com, 
	Zhang Yi <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Theodore,

Just following up on this patch to check if there are any further
comments or if anything else is needed from my side

Thanks

