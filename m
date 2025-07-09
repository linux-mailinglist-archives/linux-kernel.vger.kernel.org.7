Return-Path: <linux-kernel+bounces-723434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C70AFE6D8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC67B41265
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA29124676B;
	Wed,  9 Jul 2025 10:59:28 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590AB2882BF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058768; cv=none; b=iGQDQud0BFHJNVe1dZgmZI1JM/y+LsXWkpfmoaZgFNOnwYhccUQ5V5fSQOEQttvcV1cwul0WshiCr6n6L97oDFA88ecpuOxlKqP+XwLopCksdiYs6bhti/hrMHwyEwpGhxyMzWfnELIRsSrRgWmE14jvxTKPFjAh5+BpgbOBv6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058768; c=relaxed/simple;
	bh=nroZtb7CcNsJWvIP5IyDXnbfeHRiFuSdeUL2mtj3yik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0mS9OFLhnVXlYnYo9rAdOuq7KgjSuSMgZQEZTE0hHz4tgBt8dPUGvGIoioldb4XMFEGcEJ3TmKaSz2BnxMGhB0zAai0SZxbjRfVIJHdJlNkvi/kL8D/ZZiXtS3fI0Dd5pqBWDjJIpbLvefs6xWrVXUsC6eguEBKG/YeoISPpQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 569AxOQL003680;
	Wed, 9 Jul 2025 19:59:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 569AxO7L003674
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 9 Jul 2025 19:59:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <be405f31-d6d9-4ecd-b941-503b6a5d2011@I-love.SAKURA.ne.jp>
Date: Wed, 9 Jul 2025 19:59:24 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] AppArmor: add support for lsm_config_self_policy
 and lsm_config_system_policy
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
        linux-security-module@vger.kernel.org
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, mic@digikod.net, kees@kernel.org,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        takedakn@nttdata.co.jp, song@kernel.org, rdunlap@infradead.org,
        linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-kernel@vger.kernel.org
References: <20250709080220.110947-1-maxime.belair@canonical.com>
 <20250709080220.110947-4-maxime.belair@canonical.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250709080220.110947-4-maxime.belair@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav201.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/07/09 17:00, Maxime Bélair wrote:
> +static int apparmor_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
> +				      size_t size, u32 flags)
> +{
> +	char *name;
> +	long name_size;
> +	int ret;
> +
> +	if (op != LSM_POLICY_LOAD || flags)
> +		return -EOPNOTSUPP;
> +	if (size == 0)
> +		return -EINVAL;
> +	if (size > AA_PROFILE_NAME_MAX_SIZE)
> +		return -E2BIG;
> +
> +	name = kmalloc(size, GFP_KERNEL);
> +	if (!name)
> +		return -ENOMEM;
> +
> +
> +	name_size = strncpy_from_user(name, buf, size);
> +	if (name_size < 0) {
> +		kfree(name);
> +		return name_size;
> +	}

name is not '\0'-terminated when name_size == size && 0 < size && size <= AA_PROFILE_NAME_MAX_SIZE.
Please check boundary conditions by writing userspace programs for testing.

> +
> +	ret = aa_change_profile(name, AA_CHANGE_STACK);
> +
> +	kfree(name);
> +
> +	return ret;
> +}


