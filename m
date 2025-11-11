Return-Path: <linux-kernel+bounces-896095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BC5C4FA2B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F5F84E56D5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF9B3321B0;
	Tue, 11 Nov 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keUp0W7R"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A7D330B30
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890297; cv=none; b=CYP3nfQ7t2hA7fBgw4mENtvWQ9MC7IT3DQ2RvpWk0iEUX5AV/gj0vUZVWn6mYi3gRyVKKQEsUDU8woumJIdnVMLxJwnGEonEeZtrUw0/eBRMBOF88fOl0QmOSXERUHxzKj5U8/mt/JWCAQxYxNlseMHiiZJXtM1Be8RVO9te8XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890297; c=relaxed/simple;
	bh=7oWpdWjh8bUsjMbqkolVny17Ncf5rKANuor1AjH+n/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsYlIEOdBcTCTImo+UloMdThmJ4War9jmeeH/fMA4GGaVrVix2YcdFyTSGuPWxjXHlFIhzEKm4+h2Qp4/K5WSkHoLMyU/xBupRMDa3oz8yBerKK/myLpAuOnaF3n34peevIapOhzh3lgpF7IA29OrLVJvtBQ++Z8tZ77NUpkKCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keUp0W7R; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b3108f41fso16426f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890294; x=1763495094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1vL8T6v//WK5ms8HtdFj+QIL7sFTl22SJ6QXIGnOjBo=;
        b=keUp0W7RWwNrWaLT9DesESq4xUlrgnG73P1bYhcACh+Ay3B0aLJ0FJGx1xRtwZvWtU
         yeaOfE+OVLk/8quh1jcBWAqY0lBcoSgCSvdH46cY5+hBaLWtmf5RB9XzOBO6txhICV7y
         iK3hZimEXtl2JCqNZ+sGKK0MpOjew8U1wE0yaXwS4aB7zNNyEtWd0IhXr3x3jYQdFbeG
         9gQAfIfk5GuQH/tsG3P8VLhj6hw3/nGUqYS1KHEiIAnGTR2hWZLg8CjLF4VyCv1xGx73
         X73WjRkb8vWVwoQcKnUr0+IG4rCujwDuZQk3bJ4iJ8FABS9pqvcE5kuYvqkB446rpW4M
         OGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890294; x=1763495094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vL8T6v//WK5ms8HtdFj+QIL7sFTl22SJ6QXIGnOjBo=;
        b=dsifpT/c4Poo5dpAqTawW/cA9B4XIbuV3bdYewsentKCpH9GyX0BgU3ysayHx/1K/n
         pOQ405/kZr67aenNwGwBjB6+cLaizFhZGCxCirYOqfwDauZmFOoGtooz5hQ6hH/spJBs
         TzEzOwr+HF+MsyU42LIvtvDlRHIleQuk1S9haJh3EgXqLhKeQaQeArPl0CR4we7sL/od
         rXg/XsITVAdPsFkXCemGQOHbgmQER2prosSvoJRm0xSnABvu4n186sWdxo6zdzoqsOmv
         m0jnr9JeIj2Q4nvx2rgDP2bIXKkbXwiK7+ps/Ub9Ylj6zDpf/ji6hWAdp+FLSmPpjufW
         2gaw==
X-Forwarded-Encrypted: i=1; AJvYcCWFsMjbh1nQp9vuTiYkhNt3WXhmzWJecoucMqwtpwlhY01CSZh10juj21+4WEOMGfHrQt1wfo4QuYVcJlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSMFtF/QE3eNuBL4ml12BLUEnybQHITM76vIMt4SBR8zvV0wNA
	g50uh/JItG6clSALGXpK4jM8bXhLDy+SzS/XODHzrjr6eEkzvlABHz4C13xvrETX
X-Gm-Gg: ASbGncviqsu8Nf0QZ8pUkJenWo5otgE6pZA4GjmwpYHfR51Z83i9K14m48b7V5XZLwv
	AHytgfK5jnRRSuQrIHB/IxitD4Nv4eEpXfaZSXMISfcxQCRIBcd6lEsOZDgDR7u8qbuThRmXClx
	3+ne++f6pXs4m9iWW6Y7F4XJy+n1Pf+rgVa7lCOYWqKfVXeIHHbZ4XEZ90giVyl5zTAY1l2ZKXb
	Bpeqbf9FFUIttw3NvmdWSq7JniEkmknUVy0OZk93RXggxj0WS51Pjyv10kC1nyss+nFkkjBuQh/
	O/8NCVh+KgKZZW1JnngyShtgfTi56KlapUd7vUlt/bRqGwXs5xiqUinJTtRsCyA9NNIJXocKhVk
	wTSCpK7NCZbfLs6MlVUM8m51i72abxdF6+mGCB+4fGNG10Wd5+15HDcyXXD9R6uaRFb/h+yr5
X-Google-Smtp-Source: AGHT+IFaIln3yiGIh9seHXdbbc3BGtrHgn26mO1mY0X8kAuJekH79JQX+ckG0i3gu/pYK/9GFm+SlA==
X-Received: by 2002:a05:6000:2509:b0:3fb:aca3:d5d9 with SMTP id ffacd0b85a97d-42b4bb8ed31mr286811f8f.1.1762890294369;
        Tue, 11 Nov 2025 11:44:54 -0800 (PST)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm28841586f8f.9.2025.11.11.11.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:44:53 -0800 (PST)
Date: Tue, 11 Nov 2025 19:44:52 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/6] selftests: netconsole: validate target
 resume
Message-ID: <nb7mfjnisgeenoazh5wi2e2twt5ooxfg225oqq3tuq5iqezi3r@mm6z3s4npsrd>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
 <20251109-netcons-retrigger-v3-6-1654c280bbe6@gmail.com>
 <kv5q2fq3mypb4eenrk6z3j4yjfhrlmjdcgwrsgm7cefvso7n3x@j3mcnw3uaaq5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kv5q2fq3mypb4eenrk6z3j4yjfhrlmjdcgwrsgm7cefvso7n3x@j3mcnw3uaaq5>

On Tue, Nov 11, 2025 at 02:27:53AM -0800, Breno Leitao wrote:
> > +
> > +	if [ "${STATE}" == "enabled" ]
> > +	then
> > +		ENABLED=1
> 
> Shouldn't they be local variables in here ?

Yes, good point.

> > +	else
> > +		ENABLED=0
> > +	fi
> > +
> > +	if [ ! -f "$FILE" ]; then
> 
> 	if [ ! -f "${TARGET_PATH}" ]; then
> 
> > +		echo "FAIL: Target does not exist." >&2
> > +		exit "${ksft_fail}"
> > +	fi
> > +
> > +	slowwait 2 sh -c "test -n \"\$(grep \"${ENABLED}\" \"${FILE}\")\"" || {
> 
> 	slowwait 2 sh -c "test -n \"\$(grep \"${ENABLED}\" \"${TARGET_PATH}/enabled\")\"" || {
> 

Ack.

> > +		echo "FAIL: ${TARGET} is not ${STATE}." >&2
> > +	}
> > +}
> > +
> >  # A wrapper to translate protocol version to udp version
> >  function wait_for_port() {
> >  	local NAMESPACE=${1}
> > diff --git a/tools/testing/selftests/drivers/net/netcons_resume.sh b/tools/testing/selftests/drivers/net/netcons_resume.sh
> > new file mode 100755
> > index 000000000000..404df7abef1b
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/netcons_resume.sh
> > @@ -0,0 +1,92 @@
> > +#!/usr/bin/env bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# This test validates that netconsole is able to resume a target that was
> > +# deactivated when its interface was removed when the interface is brought
> > +# back up.
> 
> Comment above is a bit harder to understand.
> 

Agreed. What do you think of: 

# This test validates that netconsole is able to resume a previously deactivated
# target once its interface is brought back up. 

> > +for BINDMODE in "ifname" "mac"
> > +do
> > +	echo "Running with bind mode: ${BINDMODE}" >&2
> > +	# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
> > +	echo "6 5" > /proc/sys/kernel/printk
> > +
> > +	# Create one namespace and two interfaces
> > +	set_network
> > +	trap do_cleanup EXIT
> 
> can we keep these trap lines outside of the loop?
> 

Let me try to do that. I'm using different handlers depending on how far we are on
the test but instead I think I should be able to use a similar approach as you did
with cleanup_netcons() in https://lore.kernel.org/netdev/20251107-netconsole_torture-v10-4-749227b55f63@debian.org/.

> > +	pkill_socat
> > +	# Cleanup & unload the module
> > +	cleanup "${NETCONS_CONFIGFS}/cmdline0"
> > +	rmmod netconsole
> 
> Why do we need to remove netconsole module in here?

We are removing the module here so we can load it on the second iteration of the
test with new cmdline. This is following a similar pattern to netcons_cmdline.sh.

> Thanks for this patch. This is solving a real issue we have right now.
> --breno

Thanks for the review!

-- 
Andre Carvalho

