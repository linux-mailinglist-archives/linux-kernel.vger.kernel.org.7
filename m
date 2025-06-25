Return-Path: <linux-kernel+bounces-701356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C82AE740B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 03:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17AAB17E970
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 01:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B311177104;
	Wed, 25 Jun 2025 01:09:08 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F48D3B19A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 01:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750813748; cv=none; b=ikvtuA/CodrJuKXRLZX8B/HbLwawwec9YLkomRJYkAdbDv59gDj8RiKk4JCtWtZZfIYxIvsp+AGzrJp6lU2bo6GSOmrbcDWi8sbAzn4wFCShplFU9gt05KnEzcQfrprEyIWoPEoFFS6f6OOwHwM16aJH8v+JU1tgM58zPQoiwDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750813748; c=relaxed/simple;
	bh=jY+C/TpjBj7NczdPxP5qJzNzfhMM6ZTS+CIqe8D+ro4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7RwdLlCCbndLpVgAAclgwFtu1Ck7WdMuPxtsV5Epi7YbSoxW5rFUOvyMQu4oGeNa7tbGvC6XdsHIXrz+EDsLMwh0ItBQT2W5zkY0dTJvXLto59VPbUktAos0izsHwAnqMyqk4iGIAwXDkCuTfYE1UnqFQrSXGYNAafHn8eR1fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 55P18vOg012417;
	Wed, 25 Jun 2025 10:08:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 55P18uSx012413
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 25 Jun 2025 10:08:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <945bf443-32b4-4432-8702-41ff7b15e420@I-love.SAKURA.ne.jp>
Date: Wed, 25 Jun 2025 10:08:55 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] lsm: introduce security_lsm_config_*_policy hooks
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
        linux-security-module@vger.kernel.org
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, mic@digikod.net, kees@kernel.org,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        takedakn@nttdata.co.jp, song@kernel.org, rdunlap@infraread.org,
        linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-kernel@vger.kernel.org
References: <20250624143211.436045-1-maxime.belair@canonical.com>
 <20250624143211.436045-3-maxime.belair@canonical.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250624143211.436045-3-maxime.belair@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp

On 2025/06/24 23:30, Maxime Bélair wrote:
> +config LSM_CONFIG_SELF_POLICY_MAX_BUFFER_SIZE
> +	int "Maximum buffer size for lsm_config_self_policy"
> +	range 16384 1073741824
> +	depends on SECURITY
> +	default 4194304
> +	help
> +	  The maximum size of the buffer argument of lsm_config_self_policy.
> +
> +	  The default value of 4194304 (4MiB) is reasonable and should be large
> +	  enough to fit policies in for most cases.
> +

Do we want to define LSM_CONFIG_{SELF,SYSTEM}_POLICY_MAX_BUFFER_SIZE as Kconfig?

If security_lsm_config_{self,system}_policy() are meant to be used by multiple
LSM modules, the upper limit each LSM module wants to impose would vary. Also,
1073741824 is larger than KMALLOC_MAX_SIZE; kmalloc()-based memory copying
functions will hit WARN_ON_ONCE_GFP() at __alloc_frozen_pages_noprof().

Since some of LSM modules might use vmalloc()-based memory copying functions from
security_lsm_config_{self,system}_policy(), the upper limit should be imposed by
individual LSM module which provides security_lsm_config_{self,system}_policy().


