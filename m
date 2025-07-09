Return-Path: <linux-kernel+bounces-723267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1DBAFE51F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580391C45323
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F83289E26;
	Wed,  9 Jul 2025 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oOH+uUcf"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C2928934C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055536; cv=none; b=mMeWYgs2lrtBLR/fGbwgh7mXmrio0LU/MaVoRi69nigfVQEHpwROay4+rtOckGK2FIxS6knhmO/dHhtRPoolcmjvYSj1S3uRBVkSreHhovK9v3jWInrbDwMyAqoknTZELaAOknnw2gXXrxgVXzujNMO9A4E8Tnw5VO8m1lsiV6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055536; c=relaxed/simple;
	bh=sFZ+QicVm3fqRKkbFrQtDvOSQDGAAazW2i7zJFINsO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrFe4eliSxvRVdRY3Z+PEw2nF8s6iF9kuhFa1BOai6ogm/JyYKxgvF3jGDGZzBMOvTXPIQsVJHVtOhVA/XEZherSjqWi5DwGDTvYc2RsMdzXf1tt55FRXNS8jxDllLLlRaRvD8SIiBOYX/O4Ghhj8mbZ66QGHJj2Xb/iMA+VmKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=oOH+uUcf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-453647147c6so50831245e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 03:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1752055531; x=1752660331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0x+leR6VZvjdpbbABt7eT4Ar2h6toyeGs2XG4qKz76A=;
        b=oOH+uUcfnhLxUX/1TiA+CXk8zszEO+RvDOZpSh1MK3SLwG4hej9TrIEfhRjP5ACAe/
         JVnOPk6e60AYZ9eNHFDuq8HkNU9jMJaqn7lsMLI7Zs6170KUpGZjUsCt4opf9k2M7y+m
         Qo16wHkDizWZZunTYSA63dNpHLFMyU9bqRSAVG/DBCH0VanzdsgantFrgUojKgA26tmD
         T+OhS73xOIkkmlmO5I43CYeX4zeWh0uuJSxxiH2Y02NyN3PR3bMbntyreKCzbVNeFzWU
         qFtJ2XEYt8JqAoMcRpA9NdF8OSOIVDYVZZouZ2l1cSWEnW9QEfAKApvbJG/eliA8+ZpD
         mhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752055531; x=1752660331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0x+leR6VZvjdpbbABt7eT4Ar2h6toyeGs2XG4qKz76A=;
        b=TVUVbJMDAS5rDWZhEwBhyl27ilxfK+PzzT96gWnLz4Sq80D1vrdj21kCei4cPy8s9V
         TCs5fzMCJolDn7U5hgmJvgc25orNZHbt63pHqt4RNOO3TTkU9lol7N7P/AhUSPo+2olo
         dzqfrzAA0dCAF+S5R2VeMxA2MkJEEaNMI3typLUA0x1fFYXtvLF0bRkK45UHDqnwmsAx
         oeJDhIp80ak09U/72Mn906Ak1ZeTjXZBSY8gpu7M+rUga9vVh/5SddmN3yfpAZ1zE2dD
         8C6Vy4kSrY52q8GlG1kj9ThlPr0aHiv1/43acFVrof6CFF8z9Dn9Vl6/rwT2ekxIEk2o
         8l7w==
X-Forwarded-Encrypted: i=1; AJvYcCUDw/0zDONfbDZ5+djezbmrrEBbpZvUEdiz16UGHSsW2lPa+jRFJMC1PHGCRF554Xo3uvizD/h/Dxy+IfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn3Z6/1Bro03m1olsxLsOadA8qj+cTFkwa+5qVoXXUiwzCH2fh
	OIL2NBLImC3K+uu1oePjDpj4B1G8lsiAH9MKajEADAYw32cbsiiv6dIUK8BXgFu81bk=
X-Gm-Gg: ASbGncsWRPsNGaqzqFLGabW/rETHH/4d+G7dZ99XjaEHX5BjPH2AtrAahkK0y6523QO
	4cgNZFxvfG5lHG36LXA3mKmdDfxKIiKQYZV5S+1B7ApFfkY5duk5HV3BMkgXIx9gcNYCr21S3iA
	zE8i8n3gk/DDLWd3dC+qf/eUDhrTM1igGseUQM3zoNm7lMhGup7V/XPIaKLkdxfZd67PnNtqIRJ
	EHgHH1LIVfdjYAF2mEqBgzJ7dfRTT1RZihMqJikodz9x3/afKEZ9C9hkxzusnsd592JFXQMfX/W
	7QFVihHcCJmncKGe09kI/OqtbwVbLJJ83CMQT7mjRxaXRbmCypcc9gz9yH1OLsw=
X-Google-Smtp-Source: AGHT+IHpIFajgMol8nI7yV85sDxF3J5lIWIyrknMcsC4HlnClZXLtkHdvmnIZr6BNblri25TvejkxA==
X-Received: by 2002:a05:600c:3e14:b0:442:f98e:f37 with SMTP id 5b1f17b1804b1-454d53a0161mr13652105e9.21.1752055530479;
        Wed, 09 Jul 2025 03:05:30 -0700 (PDT)
Received: from jiri-mlt ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d4fc333dsm18171305e9.0.2025.07.09.03.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 03:05:30 -0700 (PDT)
Date: Wed, 9 Jul 2025 12:05:24 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Carolina Jubran <cjubran@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>, Joe Damato <jdamato@fastly.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devlink: move DEVLINK_ATTR_MAX-sized array off stack
Message-ID: <dugteasq4zxwqww4hepsomjga4rxpyk76p5eudk7yrs74ub4vl@cusxvnvgmmtz>
References: <20250708160652.1810573-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708160652.1810573-1-arnd@kernel.org>

Tue, Jul 08, 2025 at 06:06:43PM +0200, arnd@kernel.org wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>There are many possible devlink attributes, so having an array of them
>on the stack can cause a warning for excessive stack usage:
>
>net/devlink/rate.c: In function 'devlink_nl_rate_tc_bw_parse':
>net/devlink/rate.c:382:1: error: the frame size of 1648 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
>
>Change this to dynamic allocation instead.
>
>Fixes: 566e8f108fc7 ("devlink: Extend devlink rate API with traffic classes bandwidth management")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>---
>I see that only two of the many array entries are actually used in this
>function: DEVLINK_ATTR_RATE_TC_INDEX and DEVLINK_ATTR_RATE_TC_BW. If there
>is an interface to extract just a single entry, using that would be
>a little easier than the kcalloc().
>---
> net/devlink/rate.c | 18 ++++++++++++------
> 1 file changed, 12 insertions(+), 6 deletions(-)
>
>diff --git a/net/devlink/rate.c b/net/devlink/rate.c
>index d39300a9b3d4..e4083649748f 100644
>--- a/net/devlink/rate.c
>+++ b/net/devlink/rate.c
>@@ -346,19 +346,23 @@ static int devlink_nl_rate_tc_bw_parse(struct nlattr *parent_nest, u32 *tc_bw,
> 				       unsigned long *bitmap,
> 				       struct netlink_ext_ack *extack)
> {
>-	struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
>+	struct nlattr **tb;
> 	u8 tc_index;
> 	int err;
> 
>+	tb = kcalloc(DEVLINK_ATTR_MAX + 1, sizeof(struct nlattr *), GFP_KERNEL);
>+	if (!tb)
>+		return -ENOMEM;
> 	err = nla_parse_nested(tb, DEVLINK_ATTR_MAX, parent_nest,
> 			       devlink_dl_rate_tc_bws_nl_policy, extack);
> 	if (err)
>-		return err;
>+		goto out;
> 
>+	err = -EINVAL;
> 	if (!tb[DEVLINK_ATTR_RATE_TC_INDEX]) {
> 		NL_SET_ERR_ATTR_MISS(extack, parent_nest,
> 				     DEVLINK_ATTR_RATE_TC_INDEX);
>-		return -EINVAL;
>+		goto out;
> 	}
> 
> 	tc_index = nla_get_u8(tb[DEVLINK_ATTR_RATE_TC_INDEX]);
>@@ -366,19 +370,21 @@ static int devlink_nl_rate_tc_bw_parse(struct nlattr *parent_nest, u32 *tc_bw,
> 	if (!tb[DEVLINK_ATTR_RATE_TC_BW]) {
> 		NL_SET_ERR_ATTR_MISS(extack, parent_nest,
> 				     DEVLINK_ATTR_RATE_TC_BW);
>-		return -EINVAL;
>+		goto out;
> 	}
> 
> 	if (test_and_set_bit(tc_index, bitmap)) {
> 		NL_SET_ERR_MSG_FMT(extack,
> 				   "Duplicate traffic class index specified (%u)",
> 				   tc_index);
>-		return -EINVAL;
>+		goto out;
> 	}
> 
> 	tc_bw[tc_index] = nla_get_u32(tb[DEVLINK_ATTR_RATE_TC_BW]);
> 
>-	return 0;
>+out:
>+	kfree(tb);
>+	return err;

Isn't it about the time to start to leverage or cleanup infrastructure
for things like this? /me covers against all the eggs flying in
I mean, there are subsystems where it's perfectly fine to use it.
Can we start with frees like this one and avoid the silly gotos?

