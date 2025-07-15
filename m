Return-Path: <linux-kernel+bounces-731582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE58B056C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610D5740239
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0A91DC07D;
	Tue, 15 Jul 2025 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agvkIo5H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27DA26E71A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572282; cv=none; b=bwhYxGgL9HJtw0Hsvv9POq/rr/tu5Y9KoYz497g7JFN5iqHS5vZyLx4lfs242d/5FqdK3a7jpawLiO0t+gwoE9O6MujN7gDOIA1h1LH/ULS16ZiX5nJ7xx+kljpJmzVqITPdyzNbJkcx/NP5a/2WirRJZeeDr0qvMl6uXXpHjDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572282; c=relaxed/simple;
	bh=QNCBtPaTSE5T621Q1/slm5WE9aV/EJ6j6EVIvjDmpKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nk0VtLPbaL/Fe7XeLg3pyi1NbcDx7/iUbIRzWC/y+0Eoab5a7agqScSDDWKW6MpzRAhvfv+4UufigvECAm73eIwFqrgxtA1+BOB9+q59esYhvYOTBDwAy8gPhvhb3BqBfHqWJl01Gq6B0n72jJiEIeuy0fkpYARXe/jwZevQFvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agvkIo5H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752572279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQjsg9ZhDrbt59Nuu5HEpW/rnNZPZCAGMVCPsn70hCc=;
	b=agvkIo5HOu3MdyeH/sTa8928tokufQ25u1Bu/e+hJyeCBnqj2Pdyydgm7pTrCfZNPCMfnR
	EFhK9kElWHxRHosuJot9pzY8f1yiMhtw/VvSvyjXNzjMzfCxoWQ4+x2pigoOCuuWH+STqa
	vx8y5pgN5DyBdyUcefPuT8HH9F5DuvM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-C3iUQRaMO_K3N1B9BRLBQg-1; Tue, 15 Jul 2025 05:37:57 -0400
X-MC-Unique: C3iUQRaMO_K3N1B9BRLBQg-1
X-Mimecast-MFC-AGG-ID: C3iUQRaMO_K3N1B9BRLBQg_1752572276
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a579058758so2102395f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572276; x=1753177076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQjsg9ZhDrbt59Nuu5HEpW/rnNZPZCAGMVCPsn70hCc=;
        b=LnVyxK1LFCZ2rmuMCwxjh3dSu92v5S822ywVNkFMm7ZIcuRurQT+rhlVsZicwqtElj
         98keujrAeo1uJTx04BPGyAdgrPwDWlqwDLjLQ9ccSFZ3c0iHrGcBL8V6X23grgJahH/1
         af+hxOV/Plv8t/HSumSLLw9a90UERNW0jlKNcPHubxh65H0oHDkwj87pIlow/2pqQ05d
         tpjhBWkZzIUXDuDMPKwUZHdP1aVLb3+vqnePYMlgoR2jnERnsKrDoeFtgbfSCU9rVEDi
         hh8zy7dlbDO1+RWr/4toMHrCb2WOZMsmtxuX23RI4xpsSVDe3Gu8kkZk5azPlxg0Y/tr
         uCYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdS0LadjgGJKsSEFfk4Sgnj7AimYgwBDCmpRu00RpOplmNHLMbPBmUIXyxBu5IGE+B3VnLC07R7lCegYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOiP/McqIfQ/vz6SBAMSH+LXv2VTogmeqazsiaF3RVHQu1ZxPw
	1ladZVXV4U+7g6o4aoilQ/45U643cBZFdpHTqJCdJUkA0cJ5wp81+M+h1BhgL6t05u45NjmeOFW
	VFKpPH8kuQCylvnYWvSXT5Q8zi2Fhiy/rtNKAWLai9nIl8STZZw2nRGm9tzmgp8UmOg==
X-Gm-Gg: ASbGncss7Rse9JovH9z2Vhg95BCt9EM+rICJQRlcHZ0Z62t2eazaY3nUL4JqYJmXT5y
	wJgn1Mi5mu/ExEFozy4MQbaq9Tp5bxEhlP5sLRyfNseCpqSaHvC2Pv24Fbjm7eGaek8I5fuAYYb
	7Hr8YYW93J3bhevvwO2+8fEw1c7lAV9If1lSTNImopmj4tzKTtdh+5ohTzLY6B1EzkNivawrhG2
	a3ItNnQGvXzONyPkZPAd0AnL3wS9IXK+3iwWHtPKGYl/NFRqFvWH3YWEaPAv8hUwm0IPGqJLjGV
	JABLbJrGd7p3xwoYKItPHo3thCOxKo1l+H+AmVTOoM003jf9INx3R8joX2UtlGUYxyruqMN/A1K
	Zg9akZYOJXW4=
X-Received: by 2002:a05:6000:440f:b0:3a4:ef30:a4c8 with SMTP id ffacd0b85a97d-3b5f187e383mr10123163f8f.10.1752572276258;
        Tue, 15 Jul 2025 02:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY7rnEyaVNTCq9R6RoKiLyFF22JsBtzv/zE5FdLGKRbnJHy7hamvgRydWCDaxAzMf/pvDQpA==
X-Received: by 2002:a05:6000:440f:b0:3a4:ef30:a4c8 with SMTP id ffacd0b85a97d-3b5f187e383mr10123135f8f.10.1752572275741;
        Tue, 15 Jul 2025 02:37:55 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1a2bsm14923256f8f.14.2025.07.15.02.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:37:55 -0700 (PDT)
Message-ID: <6d4bbed3-472f-4002-abb9-47edf7743779@redhat.com>
Date: Tue, 15 Jul 2025 11:37:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: bonding: add test for passive LACP
 mode
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250709090344.88242-1-liuhangbin@gmail.com>
 <20250709090344.88242-3-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250709090344.88242-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 11:03 AM, Hangbin Liu wrote:
> Add a selftest to verify bonding behavior when lacp_active is set to off.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  .../drivers/net/bonding/bond_passive_lacp.sh  | 21 +++++
>  .../drivers/net/bonding/bond_topo_lacp.sh     | 77 +++++++++++++++++++
>  2 files changed, 98 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
>  create mode 100644 tools/testing/selftests/drivers/net/bonding/bond_topo_lacp.sh

New test should be listed in the relevant makefile
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
> new file mode 100755
> index 000000000000..4cf8a5999aaa
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Testing if bond works with lacp_active = off
> +
> +lib_dir=$(dirname "$0")
> +source ${lib_dir}/bond_topo_lacp.sh

shellcheck is not super happy about 'source' usage:

In bond_passive_lacp.sh line 7:
source ${lib_dir}/bond_topo_lacp.sh
^-- SC3046 (warning): In POSIX sh, 'source' in place of '.' is undefined.
^-- SC3051 (warning): In POSIX sh, 'source' in place of '.' is undefined.

either switch to '. ' or use bash instead of 'sh'.

> +lacp_bond_reset "${c_ns}" "lacp_active off"
> +# make sure the switch state is not expired [A,T,G,S,Ex]
> +if slowwait 15 ip netns exec ${s_ns} grep -q 'port state: 143' /proc/net/bonding/bond0; then

Shellcheck wants double quote everywhere. Since in many cases (all the
blamed ones in this patch) we know the variable is really a single word,
I think you could simply disable the warning with:

#shellcheck disable=SC2086

(same in the other test file)

> +	RET=1
> +else
> +	RET=0
> +fi

/P


