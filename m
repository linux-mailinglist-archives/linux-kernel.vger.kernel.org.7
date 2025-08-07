Return-Path: <linux-kernel+bounces-758516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA89B1D02A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29EF81887D56
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01D519DF6A;
	Thu,  7 Aug 2025 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a6zgw/4h"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C10F944F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 01:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531067; cv=none; b=U0VawkbAKMdJoqR6v3hyUYd5usAVIal+ELRJUBAF+oosGwy53gZMQEMOgbxn0788O0HTx+32egBGUY6neiboiuIb6JBQlzQnJIHFLfqnk5KpK+P0xbEQg6Ke+BO16nxgpKcw0sKlRhv39YnW9Ylaczb8s5ThQj6q/zgHGUzB8d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531067; c=relaxed/simple;
	bh=2mkVdtlCixWWJ//o7YVUSuqsmwIk1v/nc9pdkOIaeBE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=fJXR1TQ8kkQG5O//5vQa5DS6+RaosiFaFzTgHIVcZgMgDiOBdQ4lDPOj3svBe7Y4QXErGZ0uzKkCu132FDtkDNgXYWVLrQaudsnJNObk6vZsk1tHksraWSqvTzmnT1foCeVGozsAYXVeHgwExzkRmpDVSNjeuqT43gccTrnllKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a6zgw/4h; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e6696eb422so61041185a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 18:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754531064; x=1755135864; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9dw5aKL3fdIEzWNyCmsONRucRn9UMVk2LBQjL3Huq8=;
        b=a6zgw/4hJobrTDUJe/vn6GAy6fJUvWJg3ekhVv3UFyTZ52/7y/xll7sRZ6tuH9xMkz
         O5ihvQYNN+M/UwZW8J6+7VSXQ5MvZXRbayqFefsoD3yAX3DRwGuzSHnDQl6x7adTEMbw
         7Xjc99PzlDUtiGkdWPmuCAALCkYht30k/yP91MYJK7lYc3OpuxzuRcPQ3gIoKw43lUXz
         TYdGH8ivydJfqaTW6xKfOyUhXzIGYAWLkzAagokElhm1qS+vWSmDzD7k/FvBg9dioWR7
         dw4wcxWU/o+ttYBdnDHdHB8yOb8Jw9x6G3Cn5/IrNVEV5mqTMpjfmu6cK8pN0SJVk29c
         mjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531064; x=1755135864;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y9dw5aKL3fdIEzWNyCmsONRucRn9UMVk2LBQjL3Huq8=;
        b=RLiXw01Rj3ftFldkTIqiZHRo7nG+eC6IZdWRaLLQm+zWh9pZ+QfvOqCdNvtV/uIg9B
         zGmu+76gvDLfEqvvned1LG5LMXsnGDTSgjCWT1PAd5HkHNyXRk30yisnOb3QETPeqWnc
         DCrWe94AgHzRS0VV2le34r0kT4QCqM0AFV79ziZrwRpL33m1PQX5Lj1Jp336tKpi/rnb
         83wuWyDXo1YmrTMJiY8M1pQhjYv5KwaQIUlJBJ2N9+XpHNW1deo4CQNW6tRs06KH4r9t
         43FbYaim42HgeYq32WaZLKmvJkytL0zdVm7PS+aYm9mFe0m8dsQu2pocsnRhsj6bOcq5
         PFsw==
X-Forwarded-Encrypted: i=1; AJvYcCW3z4O94MZzUj7LT/+ECvKq+RqoiCnwHWw0WWV480DfCi/llzNMCRvKBfc02MMVPJUQ9pkNqXQhJRAahV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7JXbYyN2K2fAAkJ9iO4qHI65gd8NTjJc9WvCbD4/TqWgkSDgQ
	09On620+CjUPg554vAOiXSfytvje79HIPfEgq+vDlhKWO8AbmmceVeSUQCaiLHlNg4zsV6SDEC2
	oyN0=
X-Gm-Gg: ASbGnctPURiOPsHFEZqmWK8+TzblSPukapoU1rkBcUHJy5CUz9AfoLKdbq6pgjGXDc4
	fVquEc4mPmY1a4ntwt7UrVr0VCUWduw30TR6qv9pJKbNbTEG+mtA/1oCHMPKDClsxeNbl4rY8mb
	pbyqL//LGcdi3+6UrJz2Xztq6jSpTSo3KAyPaNDjxVHUnuaDin7IOwBJr5FiCXJrvxJ0N1ik1Bd
	W2zw3izHrylbMOCdQ32RckkO1ROGb4rSsIpuHjBOsG20YoATKAYHs8A/J7XFCTXfV49HHQ82MBm
	3ClzW2MGSl0rYKT4Cw86ydgh3IzDbktyG0v9GTchkOVVbMNr61FNbIxc6GFSnfKJLSjGaIlwL/E
	jD6A7y4Ex2XYtFPqNcn46Nl0WIfVOGJy5UsPLcZrun0cjz7FYddBt9NKRlClKmNm7kXxuekJDlf
	pr8A==
X-Google-Smtp-Source: AGHT+IFQqik3VoMmOjFgbgtVaSo3JrVORZjIHKYevZqqyzR5Qtzz+l4dS+IoKGuxupght4GYwl3SoA==
X-Received: by 2002:a05:620a:4055:b0:7e3:4678:aae with SMTP id af79cd13be357-7e814e4c2a5mr787904685a.41.1754531064023;
        Wed, 06 Aug 2025 18:44:24 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e67f7045a9sm890330285a.44.2025.08.06.18.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:44:23 -0700 (PDT)
Date: Wed, 06 Aug 2025 21:44:22 -0400
Message-ID: <8d6e0d9d4bb99481d01500a7211e5119@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250806_1659/pstg-lib:20250806_1657/pstg-pwork:20250806_1659
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2] lsm,selinux: Add LSM blob support for BPF objects
References: <20250722212139.1666060-1-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250722212139.1666060-1-bboscaccy@linux.microsoft.com>

On Jul 22, 2025 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> This patch introduces LSM blob support for BPF maps, programs, and
> tokens to enable LSM stacking and multiplexing of LSM modules that
> govern BPF objects. Additionally, the existing BPF hooks used by
> SELinux have been updated to utilize the new blob infrastructure,
> removing the assumption of exclusive ownership of the security
> pointer.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
> v2:
> - Use lsm_blob_alloc
> - Remove unneded null check
> - ifdef guard bpf alloc helpers
> ---
>  include/linux/lsm_hooks.h         |  3 ++
>  security/security.c               | 86 +++++++++++++++++++++++++++++--
>  security/selinux/hooks.c          | 56 ++++----------------
>  security/selinux/include/objsec.h | 17 ++++++
>  4 files changed, 113 insertions(+), 49 deletions(-)

This looks good to me, one nit/question below ...

> @@ -5684,7 +5731,16 @@ int security_bpf_prog(struct bpf_prog *prog)
>  int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
>  			    struct bpf_token *token, bool kernel)
>  {
> -	return call_int_hook(bpf_map_create, map, attr, token, kernel);
> +	int rc = 0;

I understand the motivation behind initializing @rc to zero, but to be
honest it is redundant and will surely result in a follow on patch from
someone to remove the initialization.

Do you have any objection to me removing the initialization during the
merge?  This would obviously apply to the other two as well.

> +	rc = lsm_bpf_map_alloc(map);
> +	if (unlikely(rc))
> +		return rc;
> +
> +	rc = call_int_hook(bpf_map_create, map, attr, token, kernel);
> +	if (unlikely(rc))
> +		security_bpf_map_free(map);
> +	return rc;
>  }

--
paul-moore.com

