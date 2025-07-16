Return-Path: <linux-kernel+bounces-733745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41431B078B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38EA37BE480
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D360291C05;
	Wed, 16 Jul 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2yqOD7L"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969D222D7B6;
	Wed, 16 Jul 2025 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677288; cv=none; b=dsCrpL5LFUCThyIwNLd4sFN6IUdTDrrmDacGskpR3VUfOl6o6W394ZBKatMH+75eCGcYwYdH+wtVEyC5WsH+FH781v9DW6H3DxDJ6CMDTR9ueJ+u+C9tQeMqMkVsW1mG5FQ63tNuFCzJIAJtCApkQlV1cdeZwZZO0CpAWpwJf4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677288; c=relaxed/simple;
	bh=buYIbE8b+yBnGJkQj4nap90I/0M3cyLAegERBn4DtZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kK77K4frvG3ar5hOpHrpto5C8UhDbAJHqTbBHjgDiOVvvLJXbPx/SjuQlDdMlnuY+JmWw3TWWTpi+3DLNENR2OrphydIyiYuM0UN5tIpAKpqeyl8vn1wVsG9t/P5fULPTitRIMuu7GeH4x8x55mPxRHd+fLfVzhqeXfQiCJqILQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2yqOD7L; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2350b1b9129so45866515ad.0;
        Wed, 16 Jul 2025 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677285; x=1753282085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLKg2EVNsiY8pEWCCtBrcomCdD+iwAcVZcaj3AoOsps=;
        b=c2yqOD7LlAucvyUbRT3WKksB5q3Ud2lK6yvp+64w9dEVf7CWxI0vhCgCZUMN5nqHX3
         dmruXO3SNeMO6b/FOm8yziVc5e+BEGsw+v766Nb//mQKKo1H2K/JtPRrP5XpeS9t9l5F
         QHPTCXnVuEhKAV4E6mqVg5poCpTjMwf9Dt5f0/G3f3jL8CpAbyGmkxc7Ais4UxCV59k3
         XaIkSTQLyF9W44fYFJhZZ7vOunnWkEapLJ6fTMd8mlzUn5wX5SMDhrq2QeEIkhEh7f9Z
         ZgqZ2K6zUcPlH+S3Qw+Qbp6bjAwno0+Yym+KApnXmmfZghBm+CLMa6/ubMlw9HvFDuA/
         MhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677285; x=1753282085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLKg2EVNsiY8pEWCCtBrcomCdD+iwAcVZcaj3AoOsps=;
        b=I3f8YPAeOOMpJwg9D7Qhe4N2Q+VZ664KDCxYs4W8NCR9zDIbI8/Vvn1vUuMbZjGvbW
         djT56zlSrDex98X+my2va9iu3jRIJbWS+AMdySm2ccnVm7Rl3CSD/LsEkBVKv40Cwmaz
         U4aBYzv/WDDWnHS/Znu5y8MdqbSF+F6I4j2SxkxgpFckPbenrQzQno9X72QM2qPY+VFb
         DDoNPjbUI4QG9geXdHPQvdFEBW3lLSrswosyb7LU/UTv4J96VcutGEaGXJV6l5L/c3ER
         WsH8GTduIjoNkcHfqMp9KnK7RtFbUE1yhg+cAYGZ5ss74eBNqn5/h3vWjVMWrZqPsqCL
         /bQA==
X-Forwarded-Encrypted: i=1; AJvYcCUclXDEu3YqPqWb/vDAHea5i1++vg2FRO5ET5lEVvGDhCvUH5To8nWdp1TLWD3ph9/VuVuNiKCHtk0L0sTo@vger.kernel.org, AJvYcCXhWyZHb+Pj6otcHTZ/ydfRCDQ+B8dfnjUlG21I7OaoxjHxdXP5AvdIs0TeW5Ulsf5Itw6TeqOrWo5RHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyIb+AvIYjSFz5NKGU1nhXsLVCgV1xZa4tf8D1Mpmfy7m6c/On
	K9sUzouANlaEQkcp3EKb5GO5+dstGPqjm9NdThwbJgnMd2Bc6CppRKwc
X-Gm-Gg: ASbGnctxLxEZ8RHzkfiPvhAjl5jc78e+yjn/1CgqiHf73ZqChvt4+ftonlzP0y4E8sp
	zfr/Hl/FmqJczgawrcmREgO3hePTTydR+yA+tTh70QpoTmUD065tLeeEV/NvKM5+FvgPLJ8tN+a
	OmQKBzHwcI5khSVUkb7yaIAWnyLet+26oHbGLrz6LUl2Y5GvXPrjkrn0bdKrfUtKPX8soeWv8g8
	eAcf1zJyp6yrwl9JgQl3ipSOfQ+wzRhsatqx+1FQt+0+bd9E9EJ7gL+55aoxTMCAzGUHQi1Rx7p
	azT8ryWNX6o1rUrdvID3OgH+6eg3FxfMpKexHSRyLiTeHvDrAQHWpIr6oZ9p7LhamTyCuV+thO0
	I/fPuVbaQuJJ7g69y7W+LNd8rbPtgFI0/2Cw=
X-Google-Smtp-Source: AGHT+IECtyEgUczaoPOLaIGNwOtcRqgorDLvQjbeRFw9z5fqGFExQtpeppviy6cQ4ZcWp0JL41yi+A==
X-Received: by 2002:a17:902:d2d0:b0:234:8f5d:e3a4 with SMTP id d9443c01a7336-23e2568542dmr50953805ad.2.1752677284798;
        Wed, 16 Jul 2025 07:48:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322b17sm131023205ad.103.2025.07.16.07.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:48:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Jul 2025 07:48:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
Cc: jdelvare@suse.com, linux-kernel-mentees@lists.linux.dev,
	shuah@kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: max31827: use sysfs_emit() in
 temp1_resolution_show()
Message-ID: <607fadd3-1c7a-4efb-8d31-8117f1ee6e50@roeck-us.net>
References: <20250712131447.326995-1-khaledelnaggarlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712131447.326995-1-khaledelnaggarlinux@gmail.com>

On Sat, Jul 12, 2025 at 04:14:46PM +0300, Khaled Elnaggar wrote:
> Replace scnprintf() with sysfs_emit() in temp1_resolution_show(),
> as recommended in Documentation/filesystems/sysfs.rst: show() callbacks
> should use sysfs_emit() or sysfs_emit_at() to format values returned to
> userspace.
> 
> Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>

Applied.

Thanks,
Guenter

