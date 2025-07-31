Return-Path: <linux-kernel+bounces-751954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB83FB16FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C424C3B28C0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0892BDC07;
	Thu, 31 Jul 2025 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVf7me68"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83661D63DD;
	Thu, 31 Jul 2025 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959073; cv=none; b=gst2EYec7Rr68/pSai4a4pWWfLy5UkswNnpZtVr85jk+GL2pr5jpzUUGaUKh/7RCJXZmrdiM9Ecaxl/s6NVL/McmzVBj7RFFMnzLrmtWp1gtSZ1om11ZuDK991BAAvtYBWfccDvrP+Cu5A1jxrVZM5Xtcr46yqywM6H9ySaePwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959073; c=relaxed/simple;
	bh=1qKzTJ3IXdiAECE5NC//5P7xw3P5jyCKGm999/A9fJs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q+LMGRFaGXSWrN3KclJXLCscAAViTJg9h79ah+iAZj81l1Qe+8a/y4o0dmMJJdLEqDgq3J16tSGuCzPSr+QeIMZbVg2EpQqAB1bMiVCcGrbGTyfaubpw7cpUz2L/56ENdbN85HXXwWMpesMjVi6tBV76qos/uwX7d1sdPy4zyy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVf7me68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3050CC4CEEF;
	Thu, 31 Jul 2025 10:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753959073;
	bh=1qKzTJ3IXdiAECE5NC//5P7xw3P5jyCKGm999/A9fJs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pVf7me688ba2P0I+laro3P8Ss1PfblDqXLzIA+5vFOVP8X72abnytGUykwGOferLh
	 g5hW7y50ctO7UUwLsEJOPs0HkfQKWmbPBOIiqtmtNHu4kFCScr+S2lGFsnmHtUfF0B
	 AMVeAqrxi+3/b5A3k21bMBdnRjBGUaHYjkZUUNkbyJNEXvZhwCw3QUiTQoFwaZjMH5
	 3W8O9nnw8GIouFrFQ2GdRwfTLaOuiu8pRWH9S11J4n+WdzqdK+Gxko00ViGzo3xa8c
	 /v8vJcx3vxOZqsV5+QSXXHDWHvkQ4mPVpVKIOtrIbPXULXJh9aweV798QaGsxQ8aTA
	 CvDRlFOH9QIIA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 linux-leds@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250724112030.142121-1-colin.i.king@gmail.com>
References: <20250724112030.142121-1-colin.i.king@gmail.com>
Subject: Re: (subset) [PATCH][next] leds: Kconfig: Fix spelling mistake
 "limitiation" -> "limitation"
Message-Id: <175395907193.1126536.15996950782714661180.b4-ty@kernel.org>
Date: Thu, 31 Jul 2025 11:51:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Thu, 24 Jul 2025 12:20:30 +0100, Colin Ian King wrote:
> There is a spelling mistake in the LEDS_BD2606MVV config. Fix it.
> 
> 

Applied, thanks!

[1/1] leds: Kconfig: Fix spelling mistake "limitiation" -> "limitation"
      commit: 9f633925235f1798f61091b7300b0ef19f24c8b3

--
Lee Jones [李琼斯]


