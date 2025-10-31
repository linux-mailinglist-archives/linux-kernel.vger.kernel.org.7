Return-Path: <linux-kernel+bounces-879449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A3DC23235
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADBE44EEA04
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0D41F03D7;
	Fri, 31 Oct 2025 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z6CTXole"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0214A91
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761880573; cv=none; b=Lg0oXFNHlYXjPvcytdszEI2Om8NSeHvd8e7hLRGaeJ2cv3AREGYNUZn1WHgtdjz41SCf72eJBW0RzYJgH6ttBvxVBcRS1S5MjK58AWTd9ZEjeq9XK+YcmKNHYZGINsHdQybULQiMOsQ8ugp6ZOCxs0526nSmuyBpVxoHZUEXEYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761880573; c=relaxed/simple;
	bh=ycwZPKE4HPl68tMBtCzlaMNaxNK8m3tdAjqmCuJ7bZ0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kkyf7fk4sC6Ua4FTgJ5pP9AJQuss/hQvZ1VyshIfHjtNWRSC6UuQfm7IeuGOfgCiDNGUlLhWzB+oA83rSNMzYfCvRFB6nALvUQqrmKzBHkMLTRVIRnIjKObxm2gtWytkNkmpH6jf6vKFNCfRT1VHaMOYc1L7EZoId/jQ42pJRC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z6CTXole; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE506C4CEF1;
	Fri, 31 Oct 2025 03:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761880572;
	bh=ycwZPKE4HPl68tMBtCzlaMNaxNK8m3tdAjqmCuJ7bZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z6CTXole6jczHMe+YacFIf1T3G/a3q/cNPr4cUP7e7aLsSCoIPzZITFzCkCM5VKRQ
	 BboW7KkeQFG2uTfkIfo4XPKOvPZtLGaRWQx1vahS+xwxPLyujsvno0kfrgmkVds86m
	 kC+2zpGP/ucD2BxbpjHIEkwTATCRsdyC5kYYiqns=
Date: Thu, 30 Oct 2025 20:16:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Feng Tang <feng.tang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] panic: sys_info: Factor out read and write
 handlers
Message-Id: <20251030201612.8970ca04e861a4f111cc1371@linux-foundation.org>
In-Reply-To: <20251030132007.3742368-7-andriy.shevchenko@linux.intel.com>
References: <20251030132007.3742368-1-andriy.shevchenko@linux.intel.com>
	<20251030132007.3742368-7-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 12:44:22 +0100 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> For the sake of the code readability and easier maintenance
> factor out read and write sys_info handlers.
> 
> ...
>
> --- a/lib/sys_info.c
> +++ b/lib/sys_info.c
> @@ -43,18 +43,56 @@ unsigned long sys_info_parse_param(char *str)
>  
>  #ifdef CONFIG_SYSCTL
>  
> +static int sys_info_write_handler(struct ctl_table *table,
> +				  void *buffer, size_t *lenp, loff_t *ppos,
> +				  unsigned long *si_bits_global)
> +{

checkpatch wanted this:

--- a/lib/sys_info.c~panic-sys_info-factor-out-read-and-write-handlers-checkpatch-fixes
+++ a/lib/sys_info.c
@@ -43,7 +43,7 @@ unsigned long sys_info_parse_param(char
 
 #ifdef CONFIG_SYSCTL
 
-static int sys_info_write_handler(struct ctl_table *table,
+static int sys_info_write_handler(const struct ctl_table *table,
 				  void *buffer, size_t *lenp, loff_t *ppos,
 				  unsigned long *si_bits_global)
 {
@@ -62,7 +62,7 @@ static int sys_info_write_handler(struct
 	return 0;
 }
 
-static int sys_info_read_handler(struct ctl_table *table,
+static int sys_info_read_handler(const struct ctl_table *table,
 				 void *buffer, size_t *lenp, loff_t *ppos,
 				 unsigned long *si_bits_global)
 {
_


