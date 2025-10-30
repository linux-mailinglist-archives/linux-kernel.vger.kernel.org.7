Return-Path: <linux-kernel+bounces-878580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03393C210ED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21C81AA34AD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19363655E5;
	Thu, 30 Oct 2025 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FCYpm8Y0"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466541D416E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839290; cv=none; b=fYfqpz4Ikmf4SzBOxjjBP544Qxv4CidlWqpCnehcShx+mzs7lyZoPMMgNyBOa2I4UpZOJ8MWA2hAiXc+eGkDr60vVay2X13h1DxARBRQiwgJtlQ1QQpsYDg2DPQGL078UkijWFJQ1m2/0bCPmTP0oe2wG39D83EOA5ORTPT5Oic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839290; c=relaxed/simple;
	bh=IpU7GJxoAhoptb9OzUsmCWXeRz/eOpVnzu6jshFPfgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5zvyl2Np263mzuMjc3dweSWADf9xstekdqdZMLb0UY+ZdA6bLqTwEeuASPelawUUdpjdK3cl3PGUgbqVoOee9pDya6ZW0qaoCq+9ZbJ+eKY+l0qdQYDk9yspH3NDXlJyVcpt5gOTNxFUbh4zoChyH+scx92zlRy9w/7kT9b4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FCYpm8Y0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-427015003eeso1045442f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761839287; x=1762444087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HWxBeoABQOaJup6gmfArW1toZ8leGRleePWDa+gNRPs=;
        b=FCYpm8Y0SCA/TvO3zy9VKJds3iGMrv4OTjPGjZSwswLRfwQwJvtE7A1igVwMgHBfBj
         F1UlsCnf/WgOE2/tchFnXf3UYiKyVVdgdsfGRShh9C4BmYrLuuDAJ1UWc59+17+R+V1O
         nUvRP/p1SXJbrpKEHSkK6Bg1NL7ip0LDGzUhEhVnHhk69l585NLbE4sI0W2IYRqSUGeG
         Si5fbQ1nCS8FT4H7wgxpi1Oy0aWrdRptsYDUxrSViBUKvUKkFvz3R3UK2xnpdl+kTdFI
         dt7cXACi/0G+2XF0fY3VpxQUJQfH42dHPVFH6Pr0DLTHgxEQv2cH8MvxtfU0L8705UP0
         Rasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839287; x=1762444087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWxBeoABQOaJup6gmfArW1toZ8leGRleePWDa+gNRPs=;
        b=fazAJL4rtamrO/mPcnymvvjeQLrpAkUytJO1jxPtT30f3vaZ1XwKylbZbLSyJT1zam
         5QSEuYxW41x9Up5pnzdKApOaZtRSgkfNFXwGF2K8WkhpDXOV31zm9NPJuaz3CjV5OpmY
         To5z6n/mvLciqLRsjRrJhd5HGytuLP7HMFTulo1D4bKTJFwTVuYEHLU5iuIhOCLllVb0
         x0UjgqgjQiVrKVfjdKyupGPl6DvS37xzWGy7Jg3LFveX7fevmR99097suyW+qqome2Jt
         Is31kAw+pVQ7rYhDzebuVn4TguSU1rlKKRTE1EZ6R3Gk3k7aO5Bd0MB5csrhhYgRHwI3
         sprg==
X-Forwarded-Encrypted: i=1; AJvYcCWjpVAlM6qvYH7P6beatM298koujvLEuKxFxR79Z1kitGqm2RSiHPQ/FcM5d9QPDzR9Z0UZIeUIxGdXhDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt7W3S6E5Nvcwmpc9mk8TCQHjanyLabK/+G3CJ4xi1tthow3bj
	Ve+lnqbEoK8K8J1CbHfl7JjmnJATEEH9ldLWcOE//pM0Z0qkoTohp0qW5tpWemWZl5AfIRV/n6u
	Vv3uu
X-Gm-Gg: ASbGncsOO59S9OpcODEUFlR0YOsc0B74aHZHCt8pqVIQXtNzCM57ckWNuSyeU5ye314
	a9wOLI5COgsGtBQTCAjZZBzuP3Ta5RsOSe0QRoKETikjIktw+BZyTkXLH3Frw8u9/iL+YfhdK4v
	45DGy1gjHMrLc8cOeloN/L9/+3v963FB6nh2bKNTOPxuksmEXUKGdtQ+tPsjy+K0hE6pHHMVpOy
	IWsJR0yaqPjd7Q9Z2IXasgeZlZ9MRS43eDkNQcXq+tjPh/T9xAmBP1G7RaAsYX1QDew/Q8utYCV
	e3cV4wYVdlgsLEwdXcGBvFBwJEO+uPhsrIrRmr3wMSsWjLZl0StKulrDdZ4JiyaztbRgrkI21eJ
	E+AWd7pmiNwpTBXfoGYEdsyP35HOkoSnX3YLo3MwwziLAzllj/zHJTPOCiggDJt9G0tlp0Dzlfm
	beVSg=
X-Google-Smtp-Source: AGHT+IFFkrSLNBDvg+wLS7FVx+LN6dQjKvBO65zRil3v4PgBMfRY+hhPz5X8gEaIDGuIH0AC4q5oLg==
X-Received: by 2002:a05:6000:2387:b0:3e8:9e32:38f8 with SMTP id ffacd0b85a97d-429bd683416mr54554f8f.14.1761839286558;
        Thu, 30 Oct 2025 08:48:06 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db964sm32766704f8f.33.2025.10.30.08.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:48:06 -0700 (PDT)
Date: Thu, 30 Oct 2025 16:48:03 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Feng Tang <feng.tang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/6] panic: sys_info: Refactor and fix a potential
 issue
Message-ID: <aQOIs5ZuSHhnOwuS@pathway.suse.cz>
References: <20251030132007.3742368-1-andriy.shevchenko@linux.intel.com>
 <aQNxM40aDIrpfE0K@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQNxM40aDIrpfE0K@smile.fi.intel.com>

On Thu 2025-10-30 16:07:47, Andy Shevchenko wrote:
> On Thu, Oct 30, 2025 at 12:44:16PM +0100, Andy Shevchenko wrote:
> 
> +Cc: Petr, sorry, forgot to add you to the Cc list.

Thank you for Cc-ing me.

> > While targeting the compilation issue due to dangling variable,
> > I have noticed more opportunities for refactoring that helps to
> > avoid above mentioned compilation issue in a cleaner way and
> > also fixes a potential problem with global variable access.
> > Please, give it a try.
> > 
> > Changelog v3:
> > - addressed an issue with empty parameter returned (Feng)
> > - gathered tags (Feng)

I like all the changes and do not see any problem there.
For the entire patchset, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

