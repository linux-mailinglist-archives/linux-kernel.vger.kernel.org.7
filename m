Return-Path: <linux-kernel+bounces-743569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B09B10055
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821BB189ABE9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CC4205513;
	Thu, 24 Jul 2025 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqHk4e9B"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CDE72600
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753336746; cv=none; b=naFYO2OjCg+B91K79qpnXp/A6Jgh0OJyxNFbnG3PRfIVcYZpC9S//lfSl4Z1MfeB0oXSwpiFI3fvbb3seF9d56xndA4Kk+6WJkPit/gOiaC/AXE6DoIfuYK3PY+/50dOFSz6852yzD/ytnefXgIe+fgKB1K/lGLyXpLxq9ZmEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753336746; c=relaxed/simple;
	bh=izwWcwAlyNzcUue7ZJtqHz1Knry6CkvUfxpn/QbnBRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJeotHv/4cQRGekvgPTBRJOGaWnOVemzXNlU2rTIomKV8FcSZmL3KnA788YFfAYvGnFH5Oix8z3+6x0ClB6bDjU2U8QW4nMnKDpzSWhxGl9sS9WHYu8S3BvqBaWHsy+KMYnP15T0Wf5pF6F4nZAzwTB21O93hfolD+Wok9tNPKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqHk4e9B; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71967cd1072so6673677b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753336743; x=1753941543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5M6fAaUbUEZzpsoqwr+D7CJN0VrnnQ/DkdQr+OyZ5Nw=;
        b=fqHk4e9B42It18XqEIQfpwRaHF/3aH09WEpLnw6USqM8oazn5vPYoKa8Luyp+tEOjD
         3dcS2dhhRaWPc1oFn1PcdUAiZWm6rJrnw9aTe6Kk7Ya2DQ4BeOS8+ZHezdPBdJ4RgnEz
         TTJBPlxVMgtYkMDHXFvPZGsdzzzKz6AacKe81gpHTk0Ny8cnDDvGxmwNVLk0n16xJAW6
         aesvLjEqmvEdvXR9f8qWCrwxS9pAywjP6UbI1rZxVv+lF2HEdAwi9AFSguqMDkv6oA1l
         TTnhdr7cuAnk0VqWVwCsFHLk2l7/vyoAlyjSDyPOoy/7CMeqOVPfNiGrqxpbNmLAfD3G
         zkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753336743; x=1753941543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5M6fAaUbUEZzpsoqwr+D7CJN0VrnnQ/DkdQr+OyZ5Nw=;
        b=K2QwPu/OIkUUiP4SPdUTFDgIOWwNFfMShmNaUKgAJVEdzx81E45EhxdyjxZDo2skm6
         UZdZuk3dN+2PEgSEXvtUHnTnkVaL2a0vpaC6Cg6Ayysnwzlk0v2kZ/dcW6VJ2Qrgjr/t
         BtCBnt3zD+miObHkvs1v31XT7kcinpdulNpUb3dU46bafCdTdQy0Cxp9S52ZFGjdQUdv
         bHEn9ovsi9nDB5KCThSxpDbr0FGev91JdyQBQ0CFfK4awVzpO/YNNdUZCdgUDt4oJ1wE
         gCzOoljRNWNGCMXDVUkwdcxdGuPeQQaK23D4w4IYtOSyNB8IQFBMFrKuwxudNpEeOlit
         hMcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv63BHr/BpcaFeaXjKskPlVMFV1xt4S65K5gD40fiG1RyXNCkN4AsISzjTDJlD6ogiBv1TEqg6ARldGVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2xaV7hx4q5mt344YyQ38xGOQf9a6AgZuYpoTyJN8jIp0Sjnh
	GysEux/Ia58ox1aS5I++z+UPjC+IShecTAOzx394GM0Sw3SrK3BVadqJ9Tks7lnwrde7p38HLWs
	eEkRDLzzYqbCw52Ws2I8upITqz6T8mPs=
X-Gm-Gg: ASbGncu7K/mWhnzz74KNzoH/D/vdBd7yIzVTp+JjQmlz5L1gBpktG3K8SHtX990pQfo
	VjRq0vW2F8gu0X2vqFcGtD1V6EvRAKmeZICrGbpqxT/9AP/d1luEin2a3Z393+T3sNvgsByM7ai
	tXqmQzgjhSkoCEOU6YxNX1HChcnsgUJ+6dHlI1muG2Bh+u+ysoEL6TpjynPaV7PD74yYIGR+vmH
	NAXWofnow==
X-Google-Smtp-Source: AGHT+IGv+XnYKYQFlDRXUdEuQHa023IswAQR5p5jGxx00eCdvOfJ8DjYnL6NJ6zL82wg6WDo6lWuri+GSGAmTX10Fik=
X-Received: by 2002:a05:690c:6912:b0:70a:192d:103 with SMTP id
 00721157ae682-719b42da8c0mr75741347b3.28.1753336743546; Wed, 23 Jul 2025
 22:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721213528.2885035-1-karunika.choo@arm.com>
In-Reply-To: <20250721213528.2885035-1-karunika.choo@arm.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Wed, 23 Jul 2025 22:58:51 -0700
X-Gm-Features: Ac12FXx1bldgo-CMdxf7oWj3RatSCFZRHsdIZlcQkiXYERDBG_838jlNsnwZFk4
Message-ID: <CAPaKu7R3yZwOetKjUSr5nRYw3simfNcHN6Xm208mv53dzvCmLg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Add support for new Mali GPUs
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 2:36=E2=80=AFPM Karunika Choo <karunika.choo@arm.co=
m> wrote:
>
> This patch series introduces some minor refactoring to enable support
> for new Mali GPUs.
>
> Key changes:
> - Addition of cache maintenance via the FLUSH_CACHES GPU command for all
>   supported GPUs in place of FLUSH_MEM and FLUSH_PT MMU_AS commands.
> - Added SHAREABLE_CACHE support for GPUs from Mali-Gx20 onwards if
>   coherency is enabled.
> - Fixed minor issue with the setting of the coherency protocol.
>
> Firmware for these GPUs can be found here:
> https://gitlab.com/dliviu/linux-firmware
I've made minor comments to individual patches.  With them addressed,
the series is

  Reviewed-by: Chia-I Wu <olvaffe@gmail.com>

