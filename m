Return-Path: <linux-kernel+bounces-834740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC40EBA5657
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 01:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182D71C069E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2271E279DA3;
	Fri, 26 Sep 2025 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSvdm7Gh"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF03D86359
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758930344; cv=none; b=j2Gfcce1mo+otP+etqCwuNXYLNliyCUv8srSJxjaBkv8v/cnl9UvUy7NO5lZa/LQ51t1fb5FYCUlFvGGTd64Hz2cvl72aOt/zO5p0AwVnXm2BdvpMvbvY6j/cKMwg2Nj7jGmZ4pWO2/wx/FN93shgEMnaY2rsr9vBhxXpXfcLo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758930344; c=relaxed/simple;
	bh=L/vIybsN3LeKF+j6ObWJ3KQFN6JCwMXCVroUvbrCQ9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQmQbNrNlc1I59rS0R+Qj2GMUBFceME/JllXbM89bc8xr4gh/OMZBT9+7IfpWJo6GyAznmByhKSJFZpPrTuPTnjKFGudIDHy93QWMtH6h3pWSihBkNXfgTsw2WlRCUMV+1+gEFwQX6M5gBvJZDTMC4BUiO2TwZN3y9yI5dg1aPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YSvdm7Gh; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4dcc9cebfdfso68811cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758930342; x=1759535142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2v6l/fjiZwwbxRv7L9dB6Gm8kHK4dyhIGUYaK+C169s=;
        b=YSvdm7Ghwz1ZbHcyT8ubhE6WSgtfx3yaUBsRhKmCuG5Rxh2JPnBlias8siDA4aArtk
         iRFmGi+/INGAgKw8w/xap/M45Admda4AueUoiwHhRtbdSjxFVVZ3T8ejuvvteurjbMse
         9mKf5Hps1MnvcSua6bFmfMAg0ktYN/39UU8VNwHVBh6dFobylE40a3NtD0TrOvj+USLV
         HaPxwSajVK+VWCdzZXxRM016y22a5/5DSqGP/Z5njRCf/SuDtIotSIqnJeIJz8HcNJMq
         MK2DEbWoehYQKH+pLHiaGggCmHNiGQxH9NftZQRkgSqlUv1XJ509rD+LEgueiJ4pHcTF
         0xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758930342; x=1759535142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2v6l/fjiZwwbxRv7L9dB6Gm8kHK4dyhIGUYaK+C169s=;
        b=P9aCf/TqVPlBYfBObT2nbIYfd31cmMSwIzyP8+yd9hUcA2M8Ji5wmssBVmZnUP7sx2
         QnQUSzhmmju/Y4iFiY8R0ANjoMNQmHp7QUlEpX2oWQZtfMYFDqLuI2jNhluusPY0BdW7
         91aIk8HOnqN9K2PySq34WQNm0m3pif3s273aE2rFIG3k7scpWarRb/gzbeZXkdadv6t+
         QIBhJjYqklfB7pcthaE2K5Q/hHWUPZvRnRtUwzXwfr/GA6tiAETIbMDRCjYEtSnODRxn
         +AUlm7A1MQlZa3P7lQBTz6ZIkQY4tpBTVpi2mKn2oiUV4Vy1l6SbiImJeyP3mQrdQF7g
         Ggng==
X-Forwarded-Encrypted: i=1; AJvYcCXG26rIHvwkPk7hdpUXDmOtY1iPsPXSD30QrKYXS5KCZFe5mnFvE9Fcx9TkjqKLOsZE53Mp/whf7N/bmPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YysOqr+TNGLyLag1aZkjxkG2oeBis7WsG9gmp3973hpb4/UvjjQ
	WYgNnmmtR+E01FzdRa2gFkzDKU9rrHJS0QUmP+LxC4vCBTbZwOqdWwL5mtNpKR2i78lmzwqMyYE
	8Tk7v/837fsGxe5JpX1Ao27QqpokdH1DweAtZ4Bh/
X-Gm-Gg: ASbGnctG3rXj8SddBT4QWBLz/Tb4xiGZ6r7B3FIlxRYy/jiUNudRWOv/Wrj7qIw4H80
	bBYlw9sTXTn7Xqs8Nd6ey3oY+KDSh4AAQsVbWQJAhFuPeBGwjKlsvLileU9iUxu4q0+reE5K1Ad
	6jf6yr91iNVSa2entJfNuibYMHqSPRe1IlT+lMMinooVmL8e84lus5GO2L6BWjvo2Zc7TMxoysh
	Xt0rdBRmBIF
X-Google-Smtp-Source: AGHT+IFXlGPNT84MM6UDMyxHqowIC+dEanCYd/TyBPjybtAKnhlvS2IM+5MVQP+4ScKwabi2zbY1N6OMYsUijzd9Dt4=
X-Received: by 2002:a05:622a:5286:b0:4b7:a72f:55d9 with SMTP id
 d75a77b69052e-4dec710b632mr2671331cf.13.1758930341409; Fri, 26 Sep 2025
 16:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz> <20250910-slub-percpu-caches-v8-16-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-16-ca3099d8352c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Sep 2025 16:45:30 -0700
X-Gm-Features: AS18NWDlkUCiWuVTsoik1lE1b7RxpxL96KRj-TH3et2oYHZB4-tROqStc3p33LE
Message-ID: <CAJuCfpF8TDS0bjksssRJyvxnr1Rbb2SpgRfRAxJmPS5oQz88dg@mail.gmail.com>
Subject: Re: [PATCH v8 16/23] tools/testing: include maple-shim.c in maple.c
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> There's some duplicated code and we are about to add more functionality
> in maple-shared.h that we will need in the userspace maple test to be
> available, so include it via maple-shim.c
>
> Co-developed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  tools/testing/radix-tree/maple.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/=
maple.c
> index c0543060dae2510477963331fb0ccdffd78ea965..4a35e1e7c64b7ce347cbd1693=
beeaacb0c4c330e 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -8,14 +8,6 @@
>   * difficult to handle in kernel tests.
>   */
>
> -#define CONFIG_DEBUG_MAPLE_TREE
> -#define CONFIG_MAPLE_SEARCH
> -#define MAPLE_32BIT (MAPLE_NODE_SLOTS > 31)
> -#include "test.h"
> -#include <stdlib.h>
> -#include <time.h>
> -#include <linux/init.h>
> -
>  #define module_init(x)
>  #define module_exit(x)
>  #define MODULE_AUTHOR(x)
> @@ -23,7 +15,9 @@
>  #define MODULE_LICENSE(x)
>  #define dump_stack()   assert(0)
>
> -#include "../../../lib/maple_tree.c"
> +#include "test.h"
> +
> +#include "../shared/maple-shim.c"
>  #include "../../../lib/test_maple_tree.c"
>
>  #define RCU_RANGE_COUNT 1000
>
> --
> 2.51.0
>

