Return-Path: <linux-kernel+bounces-854423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 660A3BDE546
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C828B19C49A7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF37322DD6;
	Wed, 15 Oct 2025 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPJ41aZj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0222A322DD2
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529006; cv=none; b=Dppq4YFOmhVU+cAgR/GYybBZ3Ak88IxH3n6oZWri7TRXtPyJlPUPivb00s4MfrailCXLPW7u3dDhiZMyGE7iTlPrn6kUmBgonJ5fNfSHuFu8AYnxGOwrdiMplDbmOQ+qU6jN8hbFi4ETbVyT23yqm6HqoaK+Gz5eYis2I0ts1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529006; c=relaxed/simple;
	bh=ooKuFwes3Vhtb88vFNU8Ivf+LQKJ5Zbjhym0lsVJnFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBanyXgQaxuhXQra8lHQTdjwftLpuZ7K5zIC0zso/F+l4tHUg4e/VujD+CAn3O+BDuokpoBV/d0HLRHXrsNOAexFoF0waQyY4mGXnsMmamQcjBOrFvhVkONQMgQ3oRolLHcGAiOZ/xnwW0cE3DGbKbqo9iJ66CcNNMKgZVOOBpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPJ41aZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B97C19423
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760529005;
	bh=ooKuFwes3Vhtb88vFNU8Ivf+LQKJ5Zbjhym0lsVJnFc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pPJ41aZj0fSfWNlsmRArlY/pKEQBLwAbYCJ3Kf/Yt3x6+GMI/bwJGEEbarPL5snAW
	 QDvQJp56XVMi1HtOewG1p7T/wKe1rzfBT5o/gON0NXNUk6bFSwIILYGquGVzLCM/ar
	 OZFDNvlYW6WrgOExxd/bSi+1NboatmB481cuUL6ZMIDSVWtJxjK9bamkl57A28kB3L
	 KDJsCfzeYnRSvbYdQ1E4wfmjR4dVcYfdraE+B3qhfmts00p2Y6tgfofaR6D7cZcK08
	 OJpVg/24jR3zidWNa3BwcpmP6qOmfXzwYo80KTFlWGq9YbKUIPVn1FH9p9zQ2ilvXZ
	 IJmLilEizadJQ==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-79f79e37c04so4894828a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:50:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8t+h2sb50vYENIKmT7PJkMtYgJi8190Kn9yq7LF5+mvxGiKajZ2WaASvPfGMvLrHcTaSGcTxkZxdlnco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZc71G6lliqjc3VDOTtbj5s/GNPoRyjVKdLNVQ6Nn6rDHISJ9i
	g5LcHqnyH9AZ10fE0brcQCER6ZHw58PDJWjrtJmnbYtiZJ/B8hlimqAvTxCkPhmCKIqukd8lU4C
	NKuU2VCUkT74ku5L9LyC5MLgjP2oN/MI=
X-Google-Smtp-Source: AGHT+IEcOvtS91b8xBc9x8mFoNEL4oiSYrMPmBf02hvPxuJLVNB/9E+H2gs8poT1029kYj76kZmT5rKMedZ4Ubm3dj0=
X-Received: by 2002:a05:6808:bd2:b0:441:8f74:fcb with SMTP id
 5614622812f47-4418f741f0bmr10872569b6e.56.1760529005083; Wed, 15 Oct 2025
 04:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com> <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <8da42386-282e-4f97-af93-4715ae206361@arm.com> <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com> <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
 <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua> <001601dc3d85$933dd540$b9b97fc0$@telus.net>
In-Reply-To: <001601dc3d85$933dd540$b9b97fc0$@telus.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Oct 2025 13:49:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g7g7-WWTu=ZQwVAA345fodXer1ts422N0N+ZKx+6jXRw@mail.gmail.com>
X-Gm-Features: AS18NWATo-6k6LvzkPgyIf_Bc1oxboWU9Wp6VAZkaltVlveNh-c1lVAl4_h_8co
Message-ID: <CAJZ5v0g7g7-WWTu=ZQwVAA345fodXer1ts422N0N+ZKx+6jXRw@mail.gmail.com>
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Doug Smythies <dsmythies@telus.net>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 5:41=E2=80=AFAM Doug Smythies <dsmythies@telus.net>=
 wrote:
>
> On 2025.10.14 18:30 Sergey Senozhatsky wrote:
> > On (25/10/14 17:54), Rafael J. Wysocki wrote:
> >> Sergey, can you please run the workload under turbostat on the base
> >> 6.1.y and on 6.1.y with the problematic commit reverted and send the
> >> turbostat output from both runs (note: turbostat needs to be run as
> >> root)?
> >
> > Please find attached the turbostat logs for both cases.
>
> The turbostat data suggests that power limit throttling is involved.

Why do you think so?

