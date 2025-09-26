Return-Path: <linux-kernel+bounces-834534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDF6BA4E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FC53B5A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B5730CDB5;
	Fri, 26 Sep 2025 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyClwdZh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEB32FFDDC;
	Fri, 26 Sep 2025 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758911048; cv=none; b=jovVJwvsepdLFD1t2msUoXgqL1MDYh/8k7/MasijrmdQnfqsUoOQ/vIXIIZlm5lCHyHiuvcfKz8LsFdKn8YbCp6K82xvBSPK70x/PtyykDTDGGU8nkT5V6wniSHThiu8N5VeG8HQMNLK3sxPU8ie50YHHM5a1TSn8SJSar7rF9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758911048; c=relaxed/simple;
	bh=AIkk3EyX5ht9YW2ATcSunMpPHItGJY1wTEjeAZxFQF8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvotr8sQ1jfU/w4Ixf3KgVhQRWE50yLthXlT4sh2rnIr327ZOtA5KGwHDHa+SS/xxyorPebjGSFOPBq6caYj8F0sMzBRjmbWQwxfHq4C0yJJiI4KArG0MlrtowTTZm57ApeWUqTXz2ws6z8QEh9cqEKSlpmDUDRjF7FuXbvcLig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyClwdZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECE1C4CEF5;
	Fri, 26 Sep 2025 18:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758911048;
	bh=AIkk3EyX5ht9YW2ATcSunMpPHItGJY1wTEjeAZxFQF8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OyClwdZhVTwUlnaEK99ytqgZc9q86MZePKBjY23EFc5t/1Uy7JEbWOZIfF9/7e9qu
	 WR3Dot649NLU/sOJIKeoT9Semyd/Se0X382TrzFtVlE8Gz5sI/+WeKYV8q9NrURUva
	 37gQiOdOvAugk4rBZkfDIauxV4PrDAUG8HsAZZihymY55HpGPiaMBeU9jcaWcMm/0P
	 7EsFwxJCKKcThJJCBuI1kww/ZN1ZyLHv0rJv2w3+HBGdDwH41wem/ckfU/h7tQr6RT
	 H2VUUjkpLWHgyw2HGI5DjBUM08//QfdCzkerLrqHtGVj6T/dcWdQSeCqV5F4BHu8J+
	 PYwWDuCcsXKjw==
Date: Fri, 26 Sep 2025 11:24:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haofeng Li <920484857@qq.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Haofeng Li <13266079573@163.com>, Haofeng Li
 <lihaofeng@kylinos.cn>
Subject: Re: [PATCH] net: ynl: return actual error code in ynl_exec_dump()
Message-ID: <20250926112406.1d92c89d@kernel.org>
In-Reply-To: <tencent_16B08FED03C970A0B8F75F16AE3D7A2F3305@qq.com>
References: <tencent_16B08FED03C970A0B8F75F16AE3D7A2F3305@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Sep 2025 17:58:20 +0800 Haofeng Li wrote:
> Return the real error code 'err' instead of hardcoded -1 in the error
> path of ynl_exec_dump(). This provides better error information to
> callers for debugging and error handling.

Do you have a realistic example that can happen today? This is not
kernel code the error is always -1, and the details are in errno.

