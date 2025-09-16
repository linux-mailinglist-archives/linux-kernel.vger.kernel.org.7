Return-Path: <linux-kernel+bounces-818194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C98B58E16
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDB216F8D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916DC2DE71E;
	Tue, 16 Sep 2025 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vyE6eyT0"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0642C21D8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001743; cv=none; b=Re6b3Dpbb4XC2pbhazV4DuG9E3GAaEXBA72bpqxaZ+Heqaa6stdc84oYRGS6IlZ3KQEaG2ZIdlnr8YEw93va/+JU8ao3GMc9fPvNmlcN44QMgTvf3msAy6N7M4HYRUnWyHBlRsnfSwP/R9eIeNhc+HEkdaVr6EIVGgEYTKxQzCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001743; c=relaxed/simple;
	bh=aablpwZgkDY2HF/H36K+OQMk4Kq3szZsC1rhL0md7XU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KZALKVN004MFnqwhZsHkP2qM7y6lsfO6ddd5r1GPedJ4GIC+bRx+wlrnp2XHyw3UlorKRa842yjCQO/I4cQNhiKddtnIpCz5L1vBQQolH1CeRcEcRYqMnhz2ZPquvFfTzMsBRwnWQez4UHEEQS2JeyK9WkmF0Ki9AxD2sWR3jYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vyE6eyT0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ea7af25f42so1304340f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758001740; x=1758606540; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+Ij4gEe2LcS6vPzM/CR57NuWgzn7Jx8huZwedt8Tqc=;
        b=vyE6eyT0MwN2srMR7la91gruLAHsfDKkC/uqT2y7dnzmpxT4aBrJvFBUXFuRjrlkhg
         BJMlS1SEf/CJiuAYvoagzi0bw1l+08ehlBDgdoabYAvuN1iRY2J89XjLcEsNGDN9k0ac
         aOjZLNk1nYz+PjPOearTnT8jGsO9sWDnccM5RosHcGGE4ns9SCCi+jtQ9uqyS6IjwXRQ
         kXgTpCZ7C8UbjDFqTDMIU4WYwJNH2K4wzKvVh/FMpDu56Bloqs0h6jObhVfoUPcDQBJ0
         KI8LDEN3FYm5wE6p822OY7ocAFzSOHDGxrmu7nsNAA2pA6lnpeVond2gJ0vTGVm/MMaI
         ak/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758001740; x=1758606540;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2+Ij4gEe2LcS6vPzM/CR57NuWgzn7Jx8huZwedt8Tqc=;
        b=dZ1vp3NKNZUjgYKnu3vmgpx3QW9CRE5jhFXB0wujmUY1oy2B9+0aJ4r5dOsTapSV1x
         R5Sou+pnZhf1oooDOHaIP6fsxk4MLrJ2PTG0bEXNN0ZwLF/Ha7vwbv9t/hlMEhFbtDpy
         YzxoXtjKj7lMsdZoK0bQaNJ5jLqB7IcAEeI3GEVMkzeS7g31CBxv1J/tr8pM9X/WI/ri
         dj0EXgOnf5st+5qSX56K37iEbQHsCRvubneifeXX30s4DxZ8GpIsTSC31CjcDBYpygpD
         7vKdP3F2fmiMTKJcdIkwzwrrUfYIMjTdzO00xaasYK6457b8jIF84ohFKfYmUIjna+MZ
         tnoA==
X-Forwarded-Encrypted: i=1; AJvYcCUhnXoeVN0JHWv3uo0vKPuWsjlMHBaphlaggi4IHn/qytSpHH1iqVIpvJC5ZqfFS+llWXESGYgRnk2ieHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YysTBEYcVW5s4MuHDus+xwr8H2C4F2BdP0QRPXx6cy8J3Xt0PRV
	nuJ504tTbQdFeyqB6IcnULKkWmJLHXATCfg8ez0z8ydCcNMdlXTNhX7rzHn1SLYCgDM=
X-Gm-Gg: ASbGncsp+CwvkqNHLWpOwQb7TCh9C4MblxFGILTty9nm4HlL7aQpUis9aCvYAlPVwY1
	UwjD/BVldBKvCs7XmW1dfCNU1eBuqYCLiemTELglgT8Z/BMpOtyEKVTiINpGuTG42IwYrFq9rU3
	7xuoCTW5fxExoSS+mzramJs37kQq4XRwO3gaEWKvhvwZRUC4ObMAaq1u4afsgZ2nm8MC/Ztf2+M
	qdtGyvzHTKZMLwAPH4FrOrfVHq4JSKDNXBXfGcLfJfg9Azff9Ascv5T+5GD0L10lT2t+X0axfvE
	r3QMZ+OoHug5BwjHTC8OhKdY50TwRcpBYrgLSrXMPMt6j7qxwfKV0zno/cH3VA8lC3Hg6MtRQ3c
	GcxRBBHlcquNYLuJ5yINEVxeAfCY2Y3gRbKc4NlSe5cY6kSgt2QGQciE/id6n4BLNmh4r
X-Google-Smtp-Source: AGHT+IF7x+pGpXf85Vy38ChqF7Pkim2OKEyjFcqs8YYGtgVmrGA1ZIZ90uccF0N4NZf54XR53W2Dfw==
X-Received: by 2002:a05:6000:3113:b0:3e2:ac0:8c55 with SMTP id ffacd0b85a97d-3e765a3e423mr13059397f8f.55.1758001740531;
        Mon, 15 Sep 2025 22:49:00 -0700 (PDT)
Received: from localhost (054722ac.skybroadband.com. [5.71.34.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760786ceasm20896593f8f.16.2025.09.15.22.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 22:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Sep 2025 06:48:59 +0100
Message-Id: <DCTZLTRX455M.95MSJULLX6VC@linaro.org>
Cc: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <tglx@linutronix.de>, <andersson@kernel.org>,
 <pmladek@suse.com>, <rdunlap@infradead.org>, <corbet@lwn.net>,
 <david@redhat.com>, <mhocko@suse.com>, <tudor.ambarus@linaro.org>,
 <mukesh.ojha@oss.qualcomm.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-hardening@vger.kernel.org>, <jonechou@google.com>,
 <rostedt@goodmis.org>, <linux-doc@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [RFC][PATCH v3 15/16] kmemdump: Add Kinfo backend driver
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Eugen Hristev" <eugen.hristev@linaro.org>
X-Mailer: aerc 0.20.0
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
 <20250912150855.2901211-16-eugen.hristev@linaro.org>
In-Reply-To: <20250912150855.2901211-16-eugen.hristev@linaro.org>

On Fri Sep 12, 2025 at 4:08 PM BST, Eugen Hristev wrote:

[..]

> --- /dev/null
> +++ b/mm/kmemdump/kinfo.c
> @@ -0,0 +1,293 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *
> + * Copyright 2002 Rusty Russell <rusty@rustcorp.com.au> IBM Corporation
> + * Copyright 2021 Google LLC
> + * Copyright 2025 Linaro Ltd. Eugen Hristev <eugen.hristev@linaro.org>
> + */
> +#include <linux/platform_device.h>
> +#include <linux/kallsyms.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/kmemdump.h>
> +#include <linux/module.h>
> +#include <linux/utsname.h>

Could you please check if the headers are sorted here
and in all other patches in this series?

Also module.h is duplicated.

[..]

> +static int build_info_set(const char *str, const struct kernel_param *kp=
)
> +{
> +	struct kernel_all_info *all_info =3D kinfo->all_info_addr;

here ^^

> +	size_t build_info_size;
> +
> +	if (kinfo->all_info_addr =3D=3D 0 || kinfo->all_info_size =3D=3D 0)
> +		return -ENAVAIL;
> +
> +	all_info =3D (struct kernel_all_info *)kinfo->all_info_addr;

Maybe assignment of all_info on declaration in the beginning of this functi=
on
is not needed then?

> +	build_info_size =3D sizeof(all_info->info.build_info);
> +
> +	memcpy(&all_info->info.build_info, str, min(build_info_size - 1,
> +						    strlen(str)));
> +	update_kernel_all_info(all_info);
> +
> +	if (strlen(str) > build_info_size) {
> +		pr_warn("%s: Build info buffer (len: %zd) can't hold entire string '%s=
'\n",
> +			__func__, build_info_size, str);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}

[...]

Best regards,
Alexey

