Return-Path: <linux-kernel+bounces-810918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ADFB5217F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979A2488649
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85AA2E11DC;
	Wed, 10 Sep 2025 19:59:37 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156426CE26
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757534377; cv=none; b=MPmAj+IZEgUO9IHXaobxRXNBpfk7OI+ZTf3T+4lptwo9iCo05rzHG0dJtQlc8mQP3X0yhNzVu6nbX6BYV2gdiWLb7quDCXX5heNRR9lyGOTIGR0fGF9GWIYL/47ux0n10O+PqF2/u84Hc+e2ENlccZ6QpkDKIxw/OeeJdLuGOCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757534377; c=relaxed/simple;
	bh=L+P5yZZfaz2UZ/A+ieU33ytsnNjJDuKZ4CYymzgFooE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jy6DKSih0ehtvw9wnaO3YEivu99et+JRVONrHUm+3uyqYp9wTyF27GMaVyAO4c4GR8pnnMyN83zppWO3EKvLIP2/syq/SQCfkb0meMLhynofXtrXZdCVDVT5MsAcSaURc8bPbu+aq3wLylugW0AiBL8a4OWOjjwArbkr2CW3sG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6229f5ed47fso7100406a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757534374; x=1758139174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSyW+bCKM+mTcYP257eKxq8oqjrK37Brx0AQ56rh9CU=;
        b=EfoyO59c0GIBWXYtiy7Jf+vAJDm9wxY1AGOugH2DkqqdfhVNPqd4DOWYFEj9jEmKxe
         gaWBCtgDwuNAMTevMks8hjfMsnTtw5aSR7tDHI8mATk8Uxfk4LPeoObSXHZ7/DRcgH/W
         WWYvqB36eo68aFE3RcheopwkJ/hkBGrvHFPe5bWzwnYez83BlHP5GeVhQelwa+oHvxaq
         x/PBu+3Lj4pLArZwKfVelTYl+8py83MbUOrC5WkLaONkoOLR/hAF+Ss30V1P9KX6YnKf
         GsC6jqDIJUjkrfH6MRjTEQq6qlW7FHKXp/mG8EVOS4iuOeXqaoFWqzuusw92c7zAvd2N
         KPew==
X-Forwarded-Encrypted: i=1; AJvYcCWDC68ZlTlppa1oA7dhJdYNsmu20HSBfKQaog4eSZA+FlHjQ0CyYtDRXombpoKniarnF+ITLFsnWdRClnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEtHJlAvSi0I5kvrkB5vcquQ0DFwsIjRTuBaZ2M8EnmmXDzKNa
	YEi0ntvH+v1Jv8A87U0kkKiDVygD5wmYGmcKbjjgUFMVjFIzZLW9ho2T
X-Gm-Gg: ASbGncuBD0zops2z4iCPRSzHDlEKN7vaFmzI3J2LhPTWy5nX+qUr8zAtGGDmH3tCngP
	m2LR4JISFC+mmoCsGSd9Gj9x9Dog7cLdK0dQmBMWrbDXG5Pf6measBRO/jDrj+YJZFAzLa6KUu5
	bNKO1kV5EaVIMem1Ts0XeXTCCmFVg1wHjX9AtjTpfZIXAGckkIi5jLoiDMivMJTiSp63wm6PGLC
	UiIGCmZ5U5slk3YKZKwrkiH+ufFTAKp7WW5Se80LzZaK3xh0wo1Snywt1Uv3XSBD5zZg4CLsYgj
	GNUFvC9/IPxPX/kFyKu3OraFOdJziQWnYkPqq6tAPNae7D6L/4XZ1zLbVPPyfDISHIEYlB8HPRS
	WsFNWcvSy52xBjQ==
X-Google-Smtp-Source: AGHT+IHnlnmQF7cjCqFq5bXs72wG6wVY2EzGivBZpZmg4onT8Pw3/dnwNDVwAAeyGz4vDiDC7oXEUw==
X-Received: by 2002:a17:907:3c92:b0:b04:706a:bcfc with SMTP id a640c23a62f3a-b04b1547768mr1642728966b.33.1757534373934;
        Wed, 10 Sep 2025 12:59:33 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:43::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0783047d98sm227097666b.22.2025.09.10.12.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 12:59:33 -0700 (PDT)
Date: Wed, 10 Sep 2025 12:59:31 -0700
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests: netconsole: validate target
 reactivation
Message-ID: <yj3q6gy5uxz5vosqxpmq7a24qpiu6zihj6gqgi6w7lnyekhqxk@silweslakkev>
References: <20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com>
 <20250909-netcons-retrigger-v1-5-3aea904926cf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-netcons-retrigger-v1-5-3aea904926cf@gmail.com>

On Tue, Sep 09, 2025 at 10:12:16PM +0100, Andre Carvalho wrote:
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index 984ece05f7f92e836592107ba4c692da6d8ce1b3..f47c4d57f7b4ce82b0b59bee4c87a9660819675e 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -17,6 +17,7 @@ TEST_PROGS := \
>  	netcons_fragmented_msg.sh \
>  	netcons_overflow.sh \
>  	netcons_sysdata.sh \
> +	netcons_resume.sh \

we try to keep these tests alphabetically ordered.

>  	netpoll_basic.py \
>  	ping.py \
>  	queues.py \
> diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> index 8e1085e896472d5c87ec8b236240878a5b2d00d2..ba7c865b1be3b60f53ea548aba269059ca74aee6 100644
> --- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> +++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> @@ -350,6 +350,29 @@ function check_netconsole_module() {
>  	fi
>  }
>  
> +function wait_target_state() {
> +	local TARGET=${1}
> +	local STATE=${2}
> +	local FILENAME="${NETCONS_CONFIGFS}"/"${TARGET}"/"enabled"
> +
> +	if [ "${STATE}" == "enabled" ]
> +	then
> +		ENABLED=1
> +	else
> +		ENABLED=0
> +	fi
> +
> +	if [ ! -f "$FILENAME" ]; then
> +		echo "FAIL: Target does not exist." >&2
> +		exit "${ksft_fail}"
> +	fi
> +
> +	slowwait 2 sh -c 'test -n "$(grep '"'${ENABLED}'"' '"'${FILENAME}'"')"' || {

shellcheck is not very happy with this line:

https://netdev.bots.linux.dev/static/nipa/1000727/14224835/shellcheck/stderr

> diff --git a/tools/testing/selftests/drivers/net/netcons_resume.sh b/tools/testing/selftests/drivers/net/netcons_resume.sh
> new file mode 100755
> index 0000000000000000000000000000000000000000..7e8ea74821fffdac8be0c3db2f1aa7953b4d5bd5
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/netcons_resume.sh
> @@ -0,0 +1,68 @@
> +#!/usr/bin/env bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# This test validates that netconsole is able to resume a target that was
> +# deactivated when its interface was removed.
> +#
> +# The test configures a netconsole dynamic target and then removes netdevsim
> +# module to cause the interface to disappear. The test veries that the target

nit: s/veries/verifies/



