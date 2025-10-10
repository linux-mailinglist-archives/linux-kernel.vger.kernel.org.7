Return-Path: <linux-kernel+bounces-848079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECC4BCC756
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8F4E4FA6A0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E7270830;
	Fri, 10 Oct 2025 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KERdXAdw"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B3F23B607
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760090544; cv=none; b=fCtNp6ZpwRtls9taVw0aXuFGJeYyiSkcHM1FWDIBspBVWnfYocDctHQZ8v7xbQ18QRPFgVdsk5tzVSB0P8q+TQa/4zGErk4nOyEGRf+Q21KE+hr4AFuMHyuqVePUIx6hjiV7nnHu6myNCqbFqYUGWDzLGdOoeMb9nPOPuAITWz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760090544; c=relaxed/simple;
	bh=huBZl2ZVgKVDp0vhnCSEqeRysXHxlUKICdAlhcaoQwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKxOUGYPYOoD9Fmftv2QHlwRN8aikTvRq1ablaII5NaN8zAm3OqoNQQpqxJ+5xZ8pIjHzyB8LcOUPKx0zaIlXezJzi51y9ZEwvxZB068e7pa5Aim0+19vrimhtP/GIz/6iI687LSKII7sXnKohkjdXQl7UitjtEPVkPPxngp5/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KERdXAdw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7835321bc98so1926789b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760090542; x=1760695342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S3WFlXEJ/gSBsMTRphzuDKkXK1TylSSpVK1C8MARDlY=;
        b=KERdXAdwsg8Fbzw/JvwXhGR55O8S2hGPljUxtKGoIhCuBR5zlXigJ2w9ilANUwLBfH
         QMkRIYVyqYuUg1GE7xhR8o1TW4yB8gev8gG936/Dr3AUUQZO/z5nP7AD4UCxkO1arSNv
         wOwfcYb/6/4FTlytamoOFoF8f1oYaI3UDFNOH5AJJ78wcyVUDGQZ4bIJav8n2x8av50N
         sG1rO/mHgWcX3NRA7cJaVMx63nusYY51Nki1BW1o5LAESucAKeRw+YklSEmOMov36oJ6
         wolIMvhXTIOhlWsHgwiXZ0N/kBcCSmRG5Iug4xE67WCPRStnTjsNZKLZt0Chm6dq+tq5
         vLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760090542; x=1760695342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3WFlXEJ/gSBsMTRphzuDKkXK1TylSSpVK1C8MARDlY=;
        b=QZatsZ871szRa65UzKfsrD8BFvVdKqP/n2xoZwptuKe4574zKS/TBDXoWAltAd7Ztz
         wIrk+SyJW6xJ5g5v3FeTFG5jWgj32sv4yd4YlYjESK8mkg/atIXc+XGM5t7RWCb7HDWS
         dKU/VNLroih3MKtM3o5kwxInmm+pMoZJ3iUWwXTIp6g0J5kQryViiFGVY6HdHC/syNjJ
         cxX31rZLt0ZoPf6G0pEOzGUioWlC/HW8WNIL1Zm4oOPDC2eeGIVbT/VmzhPNefKkjIIU
         X2SYJr0LHzDbGc12oKauzkRCz7j0i53+RcpjM1azUQnNGWZ6A17X0X/33sHaVCMK/ktV
         cktA==
X-Forwarded-Encrypted: i=1; AJvYcCXRIdqeRLgskukei/uf8AGrQFkk1Cb2qAIBrLI1QWaSMFlLL4/BfzgvCUZuYOaOxAylhgAp76ArOFE2968=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz87dHm287ByYfw0CpE7ANwFp063mhEyIKLEXTSVClKt4Jm2hLo
	CCr7tbLGx+Z2ObL977FOmOD5O382y1rthzmOu9rv6oHfJUcCcJfm/w4p
X-Gm-Gg: ASbGncuAXfRh2csnL1tPuhEKPGF5Jo1AzceiF1oY0oupW+bmEBwu/OwQxLLImWIbSO7
	9tVv4Lvvl7f5bvwR7EyytnvBjUDU2HxuxS24vLPpQqODcExx5PKQuPS6nRwUDN36r9FygpXCpQl
	qPw11quwFXIRvFU1mu9BzZnt4AigO9/tKwu86563lOhza7Ji8s/u1rAHlkKOjKYifgTkLb95XKA
	8FsLLsEZZm7w+PrSNVobNVIM9u7FS2mXEVzxPA45OYhbLLU4aDovrmJqrvdhzkkK6UK7caHxOqD
	Ee/iASuSEiHs4yNULTsXhkZXTNbTmyVoXh+JGJze8xGJLgUh4DcLIUPueTXe6W4F3SFfJ8QjDcz
	gibxMx/j03nFQv69b2a/ZZNrQ85iJ6alm3D8lq6lp9X/dEqC0dnJeLMyZ
X-Google-Smtp-Source: AGHT+IFWAlMW0WY6WsB1azworHAHgQMMUZ5qCKpyy62RTrsHc5HavlvwNfewBf16V5qGThJVcvJeqw==
X-Received: by 2002:a05:6a21:790c:b0:32d:b925:4a8 with SMTP id adf61e73a8af0-32db9251fc3mr8682285637.3.1760090541604;
        Fri, 10 Oct 2025 03:02:21 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992db864c7sm2370015b3a.82.2025.10.10.03.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:02:20 -0700 (PDT)
Date: Fri, 10 Oct 2025 10:02:13 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net-next] selftests: net: check jq command is supported
Message-ID: <aOjZpSSOVZg9INj6@fedora>
References: <20251010033043.140501-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010033043.140501-1-wangliang74@huawei.com>

On Fri, Oct 10, 2025 at 11:30:43AM +0800, Wang Liang wrote:
> The jq command is used in vlan_bridge_binding.sh, if it is not supported,
> the test will spam the following log.
> 
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # ./vlan_bridge_binding.sh: line 51: jq: command not found
>   # TEST: Test bridge_binding on->off when lower down                   [FAIL]
>   #       Got operstate of , expected 0
> 
> The rtnetlink.sh has the same problem. It makes sense to check if jq is
> installed before running these tests. After this patch, the
> vlan_bridge_binding.sh skipped if jq is not supported:
> 
>   # timeout set to 3600
>   # selftests: net: vlan_bridge_binding.sh
>   # TEST: jq not installed                                              [SKIP]
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  tools/testing/selftests/net/rtnetlink.sh           | 2 ++
>  tools/testing/selftests/net/vlan_bridge_binding.sh | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> index dbf77513f617..163a084d525d 100755
> --- a/tools/testing/selftests/net/rtnetlink.sh
> +++ b/tools/testing/selftests/net/rtnetlink.sh
> @@ -1466,6 +1466,8 @@ usage: ${0##*/} OPTS
>  EOF
>  }
>  
> +require_command jq
> +
>  #check for needed privileges
>  if [ "$(id -u)" -ne 0 ];then
>  	end_test "SKIP: Need root privileges"
> diff --git a/tools/testing/selftests/net/vlan_bridge_binding.sh b/tools/testing/selftests/net/vlan_bridge_binding.sh
> index db481af9b6b3..e8c02c64e03a 100755
> --- a/tools/testing/selftests/net/vlan_bridge_binding.sh
> +++ b/tools/testing/selftests/net/vlan_bridge_binding.sh
> @@ -249,6 +249,8 @@ test_binding_toggle_off_when_upper_down()
>  	do_test_binding_off : "on->off when upper down"
>  }
>  
> +require_command jq
> +
>  trap defer_scopes_cleanup EXIT
>  setup_prepare
>  tests_run
> -- 
> 2.34.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

