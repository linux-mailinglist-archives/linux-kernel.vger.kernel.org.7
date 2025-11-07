Return-Path: <linux-kernel+bounces-890507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E89DAC4035E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8843B877B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F4531A813;
	Fri,  7 Nov 2025 13:55:42 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE01430ACF8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523742; cv=none; b=oP/Ka49+8EmZzjPlIESoS5KB1A7hmGnydnqh0tMppwtZJnKidm07DeWOYycHd/JYMjSi/sjoUmyzlqhZHL2AcKKdS+r4OrBBFDhpx9CULjSIa/tgTVxi8lgna/MzxBC7sWwg1CmmDk22gs0MN3KCbai4LFWiLXDakCFtEYw9B7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523742; c=relaxed/simple;
	bh=Hxb/gWTOsdtHlXVI0iFMLTENSvzBdCoasJxqnUiXeIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2JuLVwo8Zchj/ZwMmibsNxzvddv+EASkMvquYeceyqp1+hyYEe9rrZ+5y735klj7h4llSKE9y8H9wl1vchxXAYnSY1sBkYGMqcygS4/zfZvDm6lMpHFS3hvbGKOkW7P/kJRl3TSB5BNFF1wJ1Pj+OItenrXueaPcKUDLQh9zC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640f0f82da9so1511217a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523739; x=1763128539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZE6WJJFFBiJVTyI5OvLy2/eZGTZ4IdwtaNd7dO/eBE=;
        b=ntq9ruK5a6o/xDKF5jCy8sbNU/6ECVpniSuOCSrT5fx32PvQIXSNKopZhKYaG2jZ62
         fl8HHFSSivQxsJ/SHRJJ+ev5ne6YpVAP9VsME5+d7vztbLYMT0CitNbF6ec1bxR9BNlX
         BU+o+eXQaJDHm+gPOhHzorSn9/talH5Ayv7lyBxfrhJPSEPBGqkvdjlWDtxXAMMk7m2j
         OyuANyHCi7y9QwQ/WTy0qP65rFvrMfJu44Wh3d9F6c39NK2wNb1Urx+DqU5HCo1tK6IY
         FSLHVT8HXtbZeTrEm8Fy8riiyDfvc58Aqr9iLzmN+rQiXSyL7TmE8dqfFZQ69gou+EJU
         LDig==
X-Forwarded-Encrypted: i=1; AJvYcCVlc6hV4+iEFrmIU+a5+ZXWqqwc/OCTB/RGaQFt7A4b+YxUe36+GKGTOsQXcoy+gyg+SE8zzkteLgixWWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8N2c7NMitQ4wjpfKQmJwv1aiymXN4R7mYkgXfqaBqteXuEbQw
	k5GI83UZB9zzCWK25z/JzTxpw5CLNdkEDVt4ebH1ww/T0JlREbsQZwHH
X-Gm-Gg: ASbGncvuOZtVqMPyujaFIFnxDWbayn+/UFR74jRVJ9u+SDUjskIaWsidR6biKbyME/B
	U7GDXDtK0M265WjhrlZZA92J+GsU7GvQhcbFPbWIb4gc2OU5RcWy27JoqmRs12NhB3uC6zekBuT
	n1F737mqV7eVfSGgUKOpNa1V+UZTaBe2r9LLogEE1lB63+VWat3b8ubZC+NfUDOM4DgeCUpVQnP
	dWCRconToHQ3aJLnXIweq3EINuNBlsn7ptGB2+KhY5dF3u4CsfOspE3OchB6FvGv1xLqK8iHgg6
	ts4hz8q7m9S8OoL9wgpRhzWqszxTCCdT1GeWIOmgrEDAe8hUdmHHXy6MwnRQQ2wqcMkjsg/DmS9
	GwngG04duQq3snKqoz/hAfXh01pDFvjP5N1GLEEPJDXNrmQ5XM8N43j1B1CnEjVr8aO1+zzu/pt
	og
X-Google-Smtp-Source: AGHT+IHlTScJC+oO2U1HIWORq+rSxPXReipszaWTgQ3KvvBT9dPCs3MWAerxSZPOSFFxVPN9CHWH7A==
X-Received: by 2002:a05:6402:3550:b0:640:c918:e3b with SMTP id 4fb4d7f45d1cf-6413f0f5f4cmr3131005a12.26.1762523739041;
        Fri, 07 Nov 2025 05:55:39 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6412a27d68dsm3303524a12.9.2025.11.07.05.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:55:38 -0800 (PST)
Date: Fri, 7 Nov 2025 05:55:36 -0800
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v9 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <f44ccmfiiq47ecug5jyfxsi2imsytzhg25szr5yotpdry2b32h@5hxqifqyvsjz>
References: <20251106-netconsole_torture-v9-0-f73cd147c13c@debian.org>
 <20251106-netconsole_torture-v9-4-f73cd147c13c@debian.org>
 <aQ3ExWwuiiN0xyBE@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ3ExWwuiiN0xyBE@horms.kernel.org>

Hello Simon,

On Fri, Nov 07, 2025 at 10:07:01AM +0000, Simon Horman wrote:
> On Thu, Nov 06, 2025 at 07:56:50AM -0800, Breno Leitao wrote:
> >  function create_dynamic_target() {
> >  	local FORMAT=${1:-"extended"}
> >  	local NCPATH=${2:-"$NETCONS_PATH"}
> > -	_create_dynamic_target "${FORMAT}" "${NCPATH}"
> > +	create_and_enable_dynamic_target "${FORMAT}" "${NCPATH}"
> 
> Sorry for not noticing this when I looked over v8.
> It's not that important and I don't think it should block progress.
> 
> create_and_enable_dynamic_target() seems to only be used here.
> If so, perhaps the 'enabled' line could simply be added to
> create_dynamic_target() instead of creating adding
> create_and_enable_dynamic_target().

This is a good catch. I _think_ it is worth fixing, in fact.

I will send a v10 with this additional change.

	diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
	index 09553ecd50e39..3f891bd68d03c 100644
	--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
	+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
	@@ -147,15 +147,12 @@ function _create_dynamic_target() {
		fi
	}

	-function create_and_enable_dynamic_target() {
	-       _create_dynamic_target "${FORMAT}" "${NCPATH}"
	-       echo 1 > "${NCPATH}"/enabled
	-}
	-
	function create_dynamic_target() {
		local FORMAT=${1:-"extended"}
		local NCPATH=${2:-"$NETCONS_PATH"}
	-       create_and_enable_dynamic_target "${FORMAT}" "${NCPATH}"
	+
	+       _create_dynamic_target "${FORMAT}" "${NCPATH}"
	+       echo 1 > "${NCPATH}"/enabled

		# This will make sure that the kernel was able to
		# load the netconsole driver configuration. The console message


Thanks for the review!
--breno

