Return-Path: <linux-kernel+bounces-824562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E03B898CE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3921C8561D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF64722257E;
	Fri, 19 Sep 2025 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkkwusPa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34994205E3B;
	Fri, 19 Sep 2025 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758286449; cv=none; b=g5oWO/Xu7l+/BOXsV93F0VacQqqITMAHwR5gZYRNl73EI9NWO1hNTRGy+Obl8enoCQL544jM5ec32g/u2igPn7021oYiGPn0w1oHSsgKtOZryNvQXQIshX/Dth1qK2ADKJHLpWhKrj0hw/7nGcX9EJ0iinic4grPfg4tBvWHm1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758286449; c=relaxed/simple;
	bh=wvCz/ODysmVAfSXymsHujU8202f0DUCvDBTGn+/TsY8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q6mSraaosHFJK/ZDrrtIo41Nm6/sKw7roYMX3G5TVeI9WritRkTZ1lw63h97sE9/y2MK7ZFL39gVr4u9px3tnJqo00Jn2NUlLSZ7BrlHlpIhuLkUyCZvh+8qLeUwq9EBvYSNQMnUWJEhOiGsXyjRCo8IVPNTV4yYtwKX0UdUMZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkkwusPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03920C4CEF0;
	Fri, 19 Sep 2025 12:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758286448;
	bh=wvCz/ODysmVAfSXymsHujU8202f0DUCvDBTGn+/TsY8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DkkwusPatofdPkPXpw5Xmpz6kcvZmYhCds0oy0jtoxZYzfZXsm138d1FIajwS/q13
	 Gfc1uKHTQ8XUaxSs0FJTXsprqm+s+htoQWUkCAY2XqJnscyOulT7HH3U+JDBzRbPKy
	 UO9/0SmaUXKdw7ABZq6lCmytzf0NWJGp6dGyFQMgSUbce4A9xqVBLEj+hLK9hC5nUf
	 QdP8nBUTD4F9YJH59i4D0j6QUHpV8ni/eRUVhYJGztc9nL83WQvD1+xuw1IdKFdpXd
	 uio4FwlA0IXS5nFDJkgq7xbCcUuEz30C81koQ/f0OAz8YNGErcwUBJTxoR5dMTccPY
	 af9SizPzfYNiw==
From: Mark Brown <broonie@kernel.org>
To: peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, linux-sound@vger.kernel.org, 
 sound-open-firmware@alsa-project.org, 
 Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: linux-kernel@vger.kernel.org, lgirdwood@gmail.com, 
 daniel.baluta@nxp.com
In-Reply-To: <20250909225111.3740029-1-samasth.norway.ananda@oracle.com>
References: <20250909225111.3740029-1-samasth.norway.ananda@oracle.com>
Subject: Re: [PATCH] ASoC: SOF: ipc3-dtrace: fix potential integer overflow
 in allocation
Message-Id: <175828644460.102649.6097725617056769364.b4-ty@kernel.org>
Date: Fri, 19 Sep 2025 13:54:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Tue, 09 Sep 2025 15:51:11 -0700, Samasth Norway Ananda wrote:
> Fix a potential integer overflow vulnerability in trace_filter_parse()
> where the allocation size calculation could overflow.
> 
> The issue occurs when:
> 1. capacity is calculated by adding TRACE_FILTER_ELEMENTS_PER_ENTRY in a
>    loop for each entry found in the input string.
> 2. capacity * sizeof(**out) multiplication could overflow if many
>    entries are present in the input.
> 3. This results in a smaller allocation than expected, leading to
>    potential buffer overflow.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc3-dtrace: fix potential integer overflow in allocation
      commit: ce2335cd14b6585d57dc05a4375a506079adba81

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


