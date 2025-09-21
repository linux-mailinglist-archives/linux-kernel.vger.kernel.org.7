Return-Path: <linux-kernel+bounces-826314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EB3B8E2B0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292281715CD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68265274669;
	Sun, 21 Sep 2025 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfZ1BkaB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A9249E5;
	Sun, 21 Sep 2025 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758477455; cv=none; b=QxqS0NVx3wp/0SH95rJ5YuJ2nZw0wtIvHJXBgKPjfFIkzNPvm2riVN2NX54kU5yXd8cG5Cww9QaQPK+igtG4XHEk9uApVvUKkOsRtLisOOnRUH8WksB7OjGtoAMn8YaZW9VonoGYE4YJpwQdXrxVEzbXpMtzwyyhd2GYqStqvW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758477455; c=relaxed/simple;
	bh=RW6k+EG5Ua4vqTiIzsh8KWJ/AwayHY0BW24RxrZAnqg=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=d0FHYjn+OowlgKWeHYPUmVgyNuFS5Yv5mznG7RqoEmzd7ohwa46vr/m7C6VjEutQVJu6M4sgi9wSIYwmWKFYsZHXN3lQadZqPrlXpVl3TzPlms3HpcsykATBkS2YMV8LUVOT5dJux1KB3EeyMMeAgU+N5z7UpIf4W9REWJ5QhTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfZ1BkaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3ECC4CEE7;
	Sun, 21 Sep 2025 17:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758477455;
	bh=RW6k+EG5Ua4vqTiIzsh8KWJ/AwayHY0BW24RxrZAnqg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=LfZ1BkaByI+QniI1tWZYx0KDYIJFQnzy54IBIMXhndYA4YQNOMM+P54jJoskUewDs
	 yb4YMTmdp8qNvVFcxUjkooVYAvpQbnv9I4jl974EuXbbRnH6KKDcTMVg9VupPjYJq+
	 DzRqGXl9/VqDWMftFVvNrUcIxikumjKRVYFPPvpGd9TPwp01WyYcGEtuBQWigi8slR
	 PU7CcBwHAGrLjmg/1AxIgHD43axdu0i+q7QqKXrXEvTco/1h9PbJ6pEyy2cfE9kXNm
	 jviMJSi6Rwlw48LwkFfsjEoRGMltMfT6nDZZc2HjBhhRPWBT7CBFMo6FX0gbBCC7tz
	 tGlFqmljcgCSg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250729050842.1522-1-shubhrajyoti.datta@amd.com>
References: <20250729050842.1522-1-shubhrajyoti.datta@amd.com>
Subject: Re: [PATCH] clk: xilinx: Optimize divisor search in clk_wzrd_get_divisors_ver()
From: Stephen Boyd <sboyd@kernel.org>
Cc: git@amd.com, Michael Turquette <mturquette@baylibre.com>, Michal Simek <michal.simek@amd.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 21 Sep 2025 10:57:33 -0700
Message-ID: <175847745374.4354.6678140047976899709@lazor>
User-Agent: alot/0.11

Quoting Shubhrajyoti Datta (2025-07-28 22:08:42)
> Optimise the clock wizard divisor calculation by eliminating the innermost
> loop over output divider o. Earlier there was an error that is returned
> if the WZRD_MIN_ERR is not achieved error is returned now it computes
> the best possible frequency.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---

Applied to clk-next

