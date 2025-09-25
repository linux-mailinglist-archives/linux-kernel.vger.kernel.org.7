Return-Path: <linux-kernel+bounces-832530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B880DB9F989
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98A7F4E32F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A894265626;
	Thu, 25 Sep 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+owLuDL"
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD86261B7F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807301; cv=none; b=WvG5U4H4LdTD6fAHHwff54Wg/B5NaYJuTb0qXl+uMkekAKZkWm2sr2Ck5oUYQRx0XM1UAEd2xGZfidLZsOwkYWT4na6CAxmCyhbcWzwQfBKswA1mbLJDgRPoA6Ut4d44RJsMXg4keq40lMomRm6txKdsNPASvMURcHZv01oa9z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807301; c=relaxed/simple;
	bh=YDVkNcZQalJ2j010y9V0+C5w7+uerTdqWyV+aIv2oSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQ5Oum/gDzazzaPQOfP2Q/6WdGW2vTNDRlXBvrJQnk2R1ISxo715IQAeoNu57tQDpb7EQaVvLsdaMnDpewmPRdXQG2WWxdKMFi/+RUp/vvP3dvIQaG0Ey2n5hILvMmqTiaeRXsCrRZzbDXR/kWh3Qfx59KCUYrRQMnq30YuDIdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E+owLuDL; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6353e91a04aso521902d50.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758807299; x=1759412099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtNjzQKudYD0ky97v1743lPf/WrnfS9KJCemG7a+/I0=;
        b=E+owLuDLYt4n1hzwq57nBBJ8yA0AlfUKkNZEFQHc09LedRYkZtyTwMec/67yXstYf1
         3Me1GFSvw7XqEf1n/I0rwC39f/TmdwoTaGy/Q9ANGAyknZLL+LzBvCvipuIeUUdZsoTA
         v3KqJx4O9P+004pW9tK4QuB4Ze6DF0lVi4a/ZAJi/1cXio62UYexRjOgihOLL47GfiUY
         A1QShO/ImHlRxq9eAYbYqLxe2pcOusl9i9qK5IM2Ix7Y8sT7d1MtN3kdUarMNDw2oNiF
         a3VxvfhMgkS4D0GTS4JjV5RpnnebLHkbmAig7F1PPCqyhdOax2Jj3CpI8IRUugX75Bgq
         o9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758807299; x=1759412099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtNjzQKudYD0ky97v1743lPf/WrnfS9KJCemG7a+/I0=;
        b=ovSRVSRtRnovWW/BGt5YLXhvpGDWLGEhDThG855TZadqTg01owejdLHT3gN3QsxwaQ
         JHfC8jZHzNuNLxuc1C1nAJqSMI/CnZ/zwecpLBjLYMe8dfBIKSijfiPO8SQyHd/XPCJN
         UEhLkqRNyGvRUcGa9TijsLMaY3NlSaUJW+e3f4j9s9xLLSPE+S8CsnyZpoJVJZUQaQZa
         gvmpgyFJUoEgB2xxuVQwCT4zIz+VKUfIPhY6jp4K+ei+2wOVOqS7+AK535lW+abQVUdL
         eEcxo9peupL9TN0BKxIpOwhOpODYY5HgOtrqywUQtYdlmv26Gkgxkls487tHZ2muXSzB
         C8+w==
X-Forwarded-Encrypted: i=1; AJvYcCX9cTpuOMVQuvh6g9VH9+kpdlROqLndCa6ui4Qa9267EWvGVKhdNoViLW8/E0y7JMUQvi2OMUsXEO2yY1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyujY6mMrj/AKosmPLqTxkwvNt+QcOwO0rha24jDSWjYZIaXtb4
	lq++Cd/8CqChjA8XZBUhIUuEiZvLtuelzPesSrEZV6bQwtdgzc6xcuOnX/xhS19UcCzdnK4oCGf
	LMa+nnyB6NpA/bj2V0Yr3AGeJLcHxRLL9nI/EpN9T8g==
X-Gm-Gg: ASbGncsSltDAlMVjQrZd9LpFzSaK46yryHuaaLiriL93FbdXkya6MEA4tJNQuEwX7Ek
	lB/KbjPqk/c8TaQS4Y6G776iMgUpgMZTnAvV/LPMZH+E3ZXwjYdVMMagaNcvCSoHV6vbp3MCuYT
	JJ+UvYd/sEvmRKGdfgED49s06lpSP2aILOEz6LoqbQFxch0Xy0rD9EJ4tVqztVZOnSJzq7rcHKq
	0OB3Ld9
X-Google-Smtp-Source: AGHT+IGimO2Q23ZQRuh/31hfKH0M0gM5VQ+Kb4vJFyOlHv/p/Vvr462F0FI6JqMOIO0OkAJ4FQSVqaMbzzoyb5VvJmI=
X-Received: by 2002:a05:690e:240d:b0:636:d335:2515 with SMTP id
 956f58d0204a3-636d335263emr142033d50.3.1758807298695; Thu, 25 Sep 2025
 06:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925090412.2068216-1-yangzh0906@thundersoft.com> <20250925121155.2401934-1-yangzh0906@thundersoft.com>
In-Reply-To: <20250925121155.2401934-1-yangzh0906@thundersoft.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Sep 2025 15:34:22 +0200
X-Gm-Features: AS18NWBTeJE3De2V6Q2_nyOlyupwgaA4ybsnxBjHtD7xymMmZJcjw6ksT3sbAGs
Message-ID: <CAPDyKFp3onTDGgygvOrK-G40w4mSx4S5=PbdZ+26hsQ+nPVRSA@mail.gmail.com>
Subject: Re: [PATCH 0/9] arm64: introduce Black Sesame Technologies C1200 SoC
 and CDCU1.0 board
To: Albert Yang <yangzh0906@thundersoft.com>
Cc: arnd@arndb.de, adrian.hunter@intel.com, bst-upstream@bstai.top, 
	catalin.marinas@arm.com, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	gordon.ge@bst.ai, krzk+dt@kernel.org, krzysztof.kozlowski@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, robh@kernel.org, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Sept 2025 at 14:12, Albert Yang <yangzh0906@thundersoft.com> wro=
te:
>
> On Thu, Sep 25, 2025 at 05:03:57PM +0800, Albert Yang wrote:Subject: Re: =
[PATCH] splitting SoC and MMC parts
>
> Hi Arnd,
>
> I may have missed an important detail in my previous note. If I split
> out the MMC-related patches and submit only the SoC parts first, I
> cannot validate the SoC on real hardware: both the kernel and the root
> filesystem live on the MMC device. Without the MMC stack (DT bindings
> and the controller driver), the board does not boot to userspace, so I
> cannot properly verify the SoC/DT changes in isolation.

At least to me, I would not consider that a problem. As long as you
can test the pieces together "manually" that's fine, I think.

I mean, the platform was not supported in the first place, so it's not
like we would be introducing a regression - or break something, right?

>
> Would you prefer that I:
> - keep the MMC pieces in the same series for initial bring-up; or
> - validate everything locally, then send only the SoC/DT parts first and
>   follow up with the MMC binding/driver as a separate series?
>
> I=E2=80=99m not entirely sure which approach best matches the normal work=
flow,
> so your guidance would be appreciated. I can proceed whichever way you
> think is most appropriate.

I think doing things in parallel would be the best/fastest way
forward. Validating locally and sending the pieces upstream to
different subsystems.

>
> Thanks for the review and suggestions.
>
> Best regards,
> Albert

Kind regards
Uffe

