Return-Path: <linux-kernel+bounces-882994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A84B0C2C3B2
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCCE3AB7DC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0BF26E6F4;
	Mon,  3 Nov 2025 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XNsI3sMT"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8613226CE33
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177189; cv=none; b=i/ifCrcCH94hs17y3R6+PGggNRhO8fXg6u7lNMUEiC3mEFhs6xYH3MKOJ0noJEhJlTX2zn/rpro6h4Asn23EnYY8a3TqJY/umtQ6vqKDo0IPuEOPibbHNzCnTqTLwrzPGXPtbd9Sb1YsG1R2n4TIGeYnbnzlKYtGKQxRQ88Pg7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177189; c=relaxed/simple;
	bh=kTeLgj7WTbbGhF5u6TxRlGt9WwcaFkoX8T6Mdc1zC8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmncOyt7CeUdFEn/C3uFofSvbyImQ6e90vsq7CqJ4lS7E/DQUk2gxgVk3K1Ue9+9ZEWzf8r6dbSrhoiK9EYn8o+37hRKA31JmHUv6sQcRAmMFTHZZAOu0g4pW0m65AVci0B4IvAloX6VEPMEvA1LM7bxrfZsT3A3X5b0mXdnnVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XNsI3sMT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-475e01db75aso27429805e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762177186; x=1762781986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kTeLgj7WTbbGhF5u6TxRlGt9WwcaFkoX8T6Mdc1zC8w=;
        b=XNsI3sMTV3TwFGgPn0vsevnTeQ9wZaj22zsk0e7LsSoriIVR28ZzcW7cnwmnu4xzGW
         6IdZxf/SeIn6R2EThFfeKdWZnabC1S0lxyTRAP6jomlTtB4bAvH6Yq2JPrcIEjV90Alx
         WYkSQ0NMveOYHjylh6225lGOqcpRaWn7/t+4fG+HaSteD8b4XexzB/64NOhzfykWl5oY
         XqQBrs/+QM/CI0eP7dQN6K8KG/u/MKsWlkjwBjuTx/IRp+GnErwbY46BjWvmq1eESOZo
         DGQVBiwTKcectt4flmwcpImTw+FkK8Qhi4+avRl8afBbEmqF6ih4UoRDliI6fyN8u/Cw
         ubgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762177186; x=1762781986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTeLgj7WTbbGhF5u6TxRlGt9WwcaFkoX8T6Mdc1zC8w=;
        b=pDu1e+MGbay+vnHaZMWZMSqW6mIoSq67GAqGD17p9ZrLi1KMUmi6ajinf8THyPV2Cv
         dBUlkzXZP6NosycgAiLUfgsJUIudRjX+ogpUPlrv/1FSFF9e1fQTkAerZsZKPyqN4lLA
         JRD4KVqb6SypYRWPGWlNzu5CJtcZZXGTobgi2gRla02vNGP13ZOCLYoivMln9PDdi1qc
         TKbq565sXcY/1dV8UUWqqqDxiC9ohAmHc7yNaICBB/y4xDfhEyMk9dxKPO8NoM3bTaLk
         rCvCmaHNL+nBe+yotvwoeBScRkAeU9hD+6MEDOdwi5Mpvtg6AfiOtKSzS6wU2P2RnB+K
         ScQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1pCAkR2GoCyXrAdKw8/5oVsBcyZQds/sUilHKKjjntbNDLzogDFaiJN86MBDcjclW0DjpQpZSkKiybdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3q/JW8ofHy2uWML1ruXz/jIdIvXzq+yrOy5c1ipT5dilD9ULW
	ibIVrTg5/29oqF5TGFgeSb3vhL/y/yx7fqdxYb2Y2pT/zUceHni89EfM41ll043WCgI=
X-Gm-Gg: ASbGnctdBx27wrs7stuoEpjU+Hi6xgxu1FZMMkNY0B5Y2qk8SVAIWj5qi5wlTIB0Sfo
	rD66iaihem1t+2xkixU+BnOoKiYu+fdbwNKSwG91ojZGRkminiDoBOxhnJXhPCI2c0pQuVlrZ4Q
	7qzEBW6z1bD59dJRn6MnRjQ4z5xHJXgisxZl329OkJCW23NedBwJT5gRg9kN8D4bh6xTSQUN9fa
	4Awz1jaP1MVfK/t3QdJTRh8F/cUutMOC2UCJob9JvvVv+qae0IByLu9fF5Xn+fOxP8max5tNJ1K
	D68w3XJ22sBck2aW8cT1g3RGNZEsLJ1K9wSQ/Q/zhZwb8IMFwHYtkmLyfLxuqUsoszguskIV0rq
	VYpAJ8e1PCfc5e/yUx/atsTf1DDj4AqCL80K+EHdMi9iaBF6l4xJwBH/PIMUOvsB7fGdqDKE71G
	NohbK0jufQih5cWzA9XblUuCBbbn8lWMo=
X-Google-Smtp-Source: AGHT+IGibbck/AAf9SyS4zHylpAfJRcdzmmFe7WDPzZu/EC/amCYRsgsCfpZHjx/bb+cHpeylOXfsg==
X-Received: by 2002:a05:600c:5197:b0:475:d8c8:6894 with SMTP id 5b1f17b1804b1-477307e4264mr116932235e9.9.1762177185738;
        Mon, 03 Nov 2025 05:39:45 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c727cb0sm159035135e9.10.2025.11.03.05.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 05:39:45 -0800 (PST)
Date: Mon, 3 Nov 2025 14:39:43 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: llong@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next RFC 0/2] cpuset: Add cpuset.mems.spread_page to
 cgroup v2
Message-ID: <doalyrbxmhzm6vvkotoqganga7s375athzlsnbab343wadijb5@winjpuf5m7dd>
References: <20250930093552.2842885-1-caixinchen1@huawei.com>
 <wpdddawlyxc27fkkkyfwfulq7zjqkxbqqe2upu4irqkcbzptft@jowwnu3yvgvg>
 <0d67adac-7ca2-4467-9d2e-049b62fcd7a2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x4np274spoth5vwq"
Content-Disposition: inline
In-Reply-To: <0d67adac-7ca2-4467-9d2e-049b62fcd7a2@huawei.com>


--x4np274spoth5vwq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH -next RFC 0/2] cpuset: Add cpuset.mems.spread_page to
 cgroup v2
MIME-Version: 1.0

On Mon, Oct 20, 2025 at 02:20:30PM +0800, Cai Xinchen <caixinchen1@huawei.com> wrote:
> The MPOL_INTERLEAVE setting requires restarting the DataNode service.
> In this scenario, the issue can be resolved by restarting the service,

\o/

> but I would prefer not to restart the DataNode service if possible,
> as it would cause a period of service interruption.

AFAICS, the implementation of cpuset's spread page works only for new
allocations (filemap_alloc_folio_noprof/cpuset_do_page_mem_spread) and
there's no migraion in cpuset1_update_task_spread_flags(). So this
simple v1-like spreading would still require restart of the service.

(This challenge of dynamism also a reason why it's not ready for v2,
IMO.)

HTH,
Michal

--x4np274spoth5vwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaQiwnRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjYPAEA0KNChFimqInIrzKM71dn
obF2YcUBKSUirLlWPrHnpIIBAJJNZ81rVhSMOzP3TEfdD2Ga2U/cXiJiHQQezVcu
o3gJ
=2pY7
-----END PGP SIGNATURE-----

--x4np274spoth5vwq--

