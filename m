Return-Path: <linux-kernel+bounces-882820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FA3C2B95F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 672D94E2E32
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C094D309DA5;
	Mon,  3 Nov 2025 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAUnv3CV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279BB305972
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172086; cv=none; b=UzdmvPJtT4B8aNSQP9X+hmaN1Xka0LcnigniAnCYbRgpZ2uUngiiqu1jOVkpQT8hs9JFfqXDUOYWETTnyze7jCJZjUtfjC3huzRhL5NFnQ6kiOBAhKtaxPYzJijbYAV/u/eP+Ea+Guco9OSw4JdU+eyjqPKoDXWjHl5q5gfUHMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172086; c=relaxed/simple;
	bh=bzaIzwRImEZxrzm914boo7AANWB57vHEi6jeStZeu0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XR1B62WYcx4z2vR/EyHpx7wGsNdqPGoavap/9s2DXFUqjfQpyPPSGs84wJjs2gMMX1hSvFXMJvPU2vXgFvoFj6/2fdWQJrxqiYl0G3FmsThvdrq9Sdw/JNi6k7s1wD/tzR7V4KebbwW5mJLLvSJpMD2pIzYoPpqUzpaOy7QWSRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAUnv3CV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6DEC4CEFD;
	Mon,  3 Nov 2025 12:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762172085;
	bh=bzaIzwRImEZxrzm914boo7AANWB57vHEi6jeStZeu0w=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=oAUnv3CVU6qIuJGfWTAw9IqNluOdR7MHxm3bD9AK6Z4B4TEXI+sgi1Qfbz+/OIAOe
	 3a5YwMG5GsbRDTnkyQGSqLp3ww7GTRHbnKTawIWG5HZjYYvK8sssaTaEzxXrn9P0UT
	 ANLGcjluLLGDvdoZ/3pYI0TS2YVTALnf2dO53+lpZpjBcV7zJkaSOjoloxxMnMXn/e
	 Q/xgzBWICXYDokJmiNJ/v2Dfbrb+ByPh/bhU/4zGHFPjEx7wDtOpa3Yns7hH4H7NmO
	 Uil+E+K4OIJ05asrbdkKSoecJkih0AHw2C1sPSQbuzsZ7sDIOoQGMOwP/nLY9CxLFV
	 BkXra8Roy6P3A==
Message-ID: <649ca547-ab05-40b6-8e20-b1121720e601@kernel.org>
Date: Mon, 3 Nov 2025 06:14:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] firmware: stratix10-svc: fix bug in saving
 controller data
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
 linux-kernel@vger.kernel.org, Ang Tien Sung <tiensung.ang@altera.com>
References: <cover.1762125299.git.khairul.anuar.romli@altera.com>
 <f3f620cd38250ed9ae4e44a8bd881a16c05c7bf8.1762125299.git.khairul.anuar.romli@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <f3f620cd38250ed9ae4e44a8bd881a16c05c7bf8.1762125299.git.khairul.anuar.romli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/2/25 17:21, Khairul Anuar Romli wrote:
> Fix the incorrect usage of platform_set_drvdata and dev_set_drvdata. They
> both are of the same data and overrides each other. This resulted in the
> rmmod of the svc driver to fail and throw a kernel panic for kthread_stop
> and fifo free.
> 
> Fixes: b5dc75c915cda ("firmware: stratix10-svc: extend svc to support new RSU features")

Trimming this to 12 characters SHA. I know that documentation says at 
least 12, and not exactly 12, but the normal procedure is to use exactly 12.

Applied!

Thanks,
Dinh

