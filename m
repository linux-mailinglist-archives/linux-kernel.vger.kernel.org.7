Return-Path: <linux-kernel+bounces-701371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33376AE743D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 03:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219963A73EA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 01:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5DF13D891;
	Wed, 25 Jun 2025 01:21:12 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8484228E0F
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 01:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750814472; cv=none; b=UE+lEmawyZFcX3dROw6vyV6HyUsvo71xRLaXvnK/hIoc7jwO1hYs9UNYsu2LslNDkaifRSreXos8nPrBEZwFEbJL1Em5Yx4FIqlTKgSamncjmGjykDclOX/oDue7jfOBkF+xpZ3lQ+nar/TRz3KarDz4OOWdOLtZNn2ePiYBE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750814472; c=relaxed/simple;
	bh=LINdDpNksnnx/f6tpqoh7uinTypzMUkZ0HdOvwoyNr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InXJwY0Nya6tVgE/psum1o5YunVb8R2VUsPJhvDlIfZw3uVHqXmjeNnd6y4ojfYWdiaECEy1tbxwnRvAWHoJwTwfmmQHYqptzUmoDw6LCBXHJXNqg0/qU7s3hjxK52T8mJYoMrhEEwIrLcYqZpuVjIqM8UO60GqMPyapM0wwlt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 55P1L8Kq015816;
	Wed, 25 Jun 2025 10:21:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 55P1L7LF015812
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 25 Jun 2025 10:21:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5313b937-304a-4f2a-8563-3ad1ea194cb9@I-love.SAKURA.ne.jp>
Date: Wed, 25 Jun 2025 10:21:06 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] AppArmor: add support for lsm_config_self_policy
 and lsm_config_system_policy
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
        linux-security-module@vger.kernel.org
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, mic@digikod.net, kees@kernel.org,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        takedakn@nttdata.co.jp, song@kernel.org, rdunlap@infraread.org,
        linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-kernel@vger.kernel.org
References: <20250624143211.436045-1-maxime.belair@canonical.com>
 <20250624143211.436045-4-maxime.belair@canonical.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250624143211.436045-4-maxime.belair@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/06/24 23:30, Maxime Bélair wrote:
> +static int apparmor_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
> +				      size_t size, u32 flags)
> +{
> +	char *name = kvmalloc(size, GFP_KERNEL);
> +	long name_size;
> +	int ret;
> +
> +	if (!name)
> +		return -ENOMEM;
> +
> +	if (op != LSM_POLICY_LOAD || flags)

Huge memory leak.

> +		return -EOPNOTSUPP;
> +
> +	name_size = strncpy_from_user(name, buf, size);
> +	if (name_size < 0)

Here too. :-)

> +		return name_size;
> +
> +	ret = aa_change_profile(name, AA_CHANGE_STACK);
> +
> +	kvfree(name);
> +
> +	return ret;
> +}


