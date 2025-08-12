Return-Path: <linux-kernel+bounces-764558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ACCB2247D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D3216ECA0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F832EB5B9;
	Tue, 12 Aug 2025 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DJqJTtTs"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02C12DAFCE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754994193; cv=none; b=MzMhT/kl8kV7oJXM8A5rO07LHIAUDtVETd6m5FSKHywZ3McGrmKGE7mZCkCvl9lFNLDqE1ucCXxcYSxhQVcIODuJwI767+qFXN2Bm2RNgxOjoEDnhypcNlWaUCtOMNOStFlydiMgBLeMqp/2oplu0lHFvFDsiP+wtVgNLRTm1l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754994193; c=relaxed/simple;
	bh=BCLo2AL5WIxEg2w3ddZiAoESknbWKQ/Mrmdj84avJFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmWDSGfxwXUhTSu+b/jVH3jcekiRKjCictlnhVy285BBiMIcDyzIVrgHETZu6dcDcq2lib51LWieJeqWBAkFxkGyUCYb2mwM/qbKx1qTO7vjKjsQywngW6f8qNpauc2V38om/51449vvG+rlVrnVM0JyPwOf0pZa9RMaJGU7iI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DJqJTtTs; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so9371735a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754994190; x=1755598990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c5T3EWH+tHdp67fqG75um8Xbg9dgk//vyJIlo2zmKks=;
        b=DJqJTtTsn2gYIvbiLunmsdcnrg5OgYlG6/dO6bQPbIEmT8XoJiDi6sEvnn84nVzVcw
         n2XBOjuP2W3jKZ9YS5igJ0hGr8cwuoEWJyqKRwel+4VcVngEetg7Xe1ES8RLwEUvObup
         RBoDP0Tr81MvdycLiJ2SlsD2l3b1gllDffuZJN4WMGLWXz+YgIT0m2X4ruaSeU3uFGOI
         hSGZAtrnwmctkJIbSqOz4FAHjWMRQtvRLPzTPDSeMO1PoXuhLHiUAx5bjfCh83KjgDtd
         NiwAGHS+VUdaD80qMprttuJhRnpzp5zDYyP6PIHvZ47lI9Zb9KrdpzmfDMj9uKc5sZRn
         WvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754994190; x=1755598990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5T3EWH+tHdp67fqG75um8Xbg9dgk//vyJIlo2zmKks=;
        b=rJRMXZtD+NDk+0+yEcXQ7QHEP3yMvymI9EfoyXmcgHJEWYiySNMIW1246KEOTi8VC0
         CTgv9OkCACdqdTKHExVjesFZD30oArzXmsCewgyXdf6IOhmZIK2C3b4dYqgtrHcfT/NQ
         Te78dku4cdNgWe8LYIYvFQixE0aPwBUqASzu+uTp9imr8vwcON4kXrgOFpmEojrIwYlA
         1lKMLGpASBJkBd4Er7/kXV8NfkpeYJ0q+WdIHZ1SiS57x5zJk6c2I20k1iL2TbyWO/Hq
         5+LnI/HbdQEAwLBZuU9xSz8sosXGX7jThmnDn3imDTUlbtp/Hjf5IJw7Cx3zqhogOkVf
         g+GA==
X-Forwarded-Encrypted: i=1; AJvYcCXY/TrVFBafua3QANprNVDHv/ka0Qhd/22+HLLDYTw1lEuTqF7Bcaxa/Fr8Y2RmGwYNL8A1GdlmVUL9bfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMWTwttw/PUVS0+eVegw5zVDCSGmDpddLTCr+xptKwnDrFrT0h
	kH9GAEfixJu26GHnJLYGK1LgQ/tqwOBE/2lZR9fRnZgq4JZnDzVx5YTcANRCvNx2lLs=
X-Gm-Gg: ASbGnctGPVROuIxNFA8Oxo+FQyzpUJKrdxCA4+QqoF9UIGAp2XqRZUH8QJG4bNev+lz
	8Qaug7RBpesB7AmFe4ZCbMOR8gnRP7/nY92rIzwUoCOD4Y61Qhs7U66c3ZkpnKrDAhQz6lkhitS
	zVzeIpBZQiYijBMrZBxSW4TIXpW1Uvi57CZ2Rwo+5YRX5hej7bAjDxf7xKI+8h/vdI4P07SkICv
	pYnrSVmHbxelaUlUHvEPIk04gewNU4t5uDYGvFN8mw9tqCpE2ExghX402hqYXzTNK7jMYQ+YYF7
	o9LJ6a9CXmhuYblkJ3OwYgLBf/WRvaIzvOs46Vrz1aFdSAM18J+k6FU7yHJ/NVc+t+2I3X0t0wB
	lrpbnTK0MDxFSSQ==
X-Google-Smtp-Source: AGHT+IFAZQZ177G32u7huGyMkLm4jEtxIapFo7tlTY7Y1RxDYuDQzMNWzISLj+sEfbKqTeV+G5Haww==
X-Received: by 2002:a50:951c:0:b0:618:161c:6bf with SMTP id 4fb4d7f45d1cf-6184ecc30f5mr1783744a12.19.1754994190014;
        Tue, 12 Aug 2025 03:23:10 -0700 (PDT)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8feaf2fsm19755343a12.38.2025.08.12.03.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 03:23:09 -0700 (PDT)
Date: Tue, 12 Aug 2025 12:23:07 +0200
From: Petr Mladek <pmladek@suse.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH 3/5] panic: add 'panic_sys_info' sysctl to take human
 readable string parameter
Message-ID: <aJsWCxc42f2Qjbs3@pathway>
References: <20250703021004.42328-1-feng.tang@linux.alibaba.com>
 <20250703021004.42328-4-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703021004.42328-4-feng.tang@linux.alibaba.com>

On Thu 2025-07-03 10:10:02, Feng Tang wrote:
> Bitmap definition for 'panic_print' is hard to remember and decode.
> Add 'panic_sys_info='sysctl to take human readable string like
> "tasks,mem,timers,locks,ftrace,..." and translate it into bitmap.
> 
> The detailed mapping is:
> 	SYS_INFO_TASKS		"tasks"
> 	SYS_INFO_MEM		"mem"
> 	SYS_INFO_TIMERS		"timers"
> 	SYS_INFO_LOCKS		"locks"
> 	SYS_INFO_FTRACE		"ftrace"
> 	SYS_INFO_ALL_CPU_BT	"all_bt"
> 	SYS_INFO_BLOCKED_TASKS	"blocked_tasks"
> 
> --- a/lib/sys_info.c
> +++ b/lib/sys_info.c
> +static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
> +
> +int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
> +					  void *buffer, size_t *lenp,
> +					  loff_t *ppos)
> +{
> +	char names[sizeof(sys_info_avail) + 1];

The "+ 1" looks superfluous.

I guess that it is for the trailing '\0'. But sys_info_avail[] already
includes the trailing '\0' so it should be already counted by the sizeof().

Note that it would be needed with strlen(). But it should not be
needed with sizeof().

> +	struct ctl_table table;
> +	unsigned long *si_bits_global;
> +
> +	si_bits_global = ro_table->data;
> +
> +	if (write) {
> +		unsigned long si_bits;
> +		int ret;
> +
> +		table = *ro_table;
> +		table.data = names;
> +		table.maxlen = sizeof(names);
> +		ret = proc_dostring(&table, write, buffer, lenp, ppos);
> +		if (ret)
> +			return ret;
> +
> +		si_bits = sys_info_parse_param(names);
> +		/* The access to the global value is not synchronized. */
> +		WRITE_ONCE(*si_bits_global, si_bits);
> +		return 0;
> +	} else {
> +		/* for 'read' operation */
> +		char *delim = "";
> +		int i, len = 0;
> +

It looks to me that names[] can later be used non-initialized when
*si_bits_global == 0. We should initialized it here, something like:

		names[0] = '\0';

> +		for (i = 0; i < ARRAY_SIZE(si_names); i++) {
> +			if (*si_bits_global & si_names[i].bit) {
> +				len += scnprintf(names + len, sizeof(names) - len,
> +					"%s%s", delim, si_names[i].name);
> +				delim = ",";
> +			}
> +		}
> +
> +		table = *ro_table;
> +		table.data = names;
> +		table.maxlen = sizeof(names);
> +		return proc_dostring(&table, write, buffer, lenp, ppos);
> +	}
> +}
> +#endif

Otherwise, it looks good.

Best Regards,
Petr

