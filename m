Return-Path: <linux-kernel+bounces-828190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D34A9B94244
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABFB441253
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D699020FAA4;
	Tue, 23 Sep 2025 03:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2eWY/Ege"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E0EAD24;
	Tue, 23 Sep 2025 03:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758599156; cv=none; b=mOmrxM9Np6u4j71F1drS39qEn3EjxBwPCrKSi8r8fMyLKL+aE+K9A0Zg3WbgGHk8PE7wXQGKxKIfK4+xhtLW4R0YmXQ0i+uDdM5IQEjGdLmt1Of+1Oh8JZODIkqQbJMqaar4+fELKLIG/Q9F2vtcl3dLpfZPbqIFwkmWzNKlwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758599156; c=relaxed/simple;
	bh=4FYnE6UjEl+v9tCA7afKFOyTcsRenwoUA1DIPv4FPs8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ApJ+L8i/CqN536OmSuOKBqWOWM2sz6Uu4IJJjG+QGmhfN56IvqoImbOzxJ7kKbzX3NhX82ZzZ2eKaVIT3kkTD0Tt3XnhPn8SNVfGB8tyShUySQTKvC0HZdXlG/w2cDMEEn9wa0zbuWb5IHjO+Ymwlz4mPC50zcyYzGGAVtFm8gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2eWY/Ege; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFEFC113CF;
	Tue, 23 Sep 2025 03:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758599155;
	bh=4FYnE6UjEl+v9tCA7afKFOyTcsRenwoUA1DIPv4FPs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2eWY/EgeNLsi8dWjVN+k0XHxDXaKIdXUVxnnZSTQB2Ufa3eF/B74Fp/MbKLA1AX5c
	 IGagOOyZ5yR5zXBoLVxIYQSZedi2soVTFR4VAzOvyaFPkx1uX06AHDRjTM6TiT75wC
	 5tLLq1AOQFJBnA/ShfqZPr9dp40j49zLmsHnNQAo=
Date: Mon, 22 Sep 2025 20:45:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: lirongqing <lirongqing@baidu.com>
Cc: <corbet@lwn.net>, <lance.yang@linux.dev>, <mhiramat@kernel.org>,
 <paulmck@kernel.org>, <pawan.kumar.gupta@linux.intel.com>,
 <mingo@kernel.org>, <dave.hansen@linux.intel.com>, <rostedt@goodmis.org>,
 <kees@kernel.org>, <arnd@arndb.de>, <feng.tang@linux.alibaba.com>,
 <pauld@redhat.com>, <joel.granados@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] hung_task: Support to panic when the maximum
 number of hung task warnings is reached
Message-Id: <20250922204554.55dd890090b0f56ad10a61f5@linux-foundation.org>
In-Reply-To: <20250923033740.2696-1-lirongqing@baidu.com>
References: <20250923033740.2696-1-lirongqing@baidu.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 11:37:40 +0800 lirongqing <lirongqing@baidu.com> wrote:

> Currently the hung task detector can either panic immediately or continue
> operation when hung tasks are detected. However, there are scenarios
> where we want a more balanced approach:
> 
> - We don't want the system to panic immediately when a few hung tasks
>   are detected, as the system may be able to recover
> - And we also don't want the system to stall indefinitely with multiple
>   hung tasks
> 
> This commit introduces a new mode (value 2) for the hung task panic behavior.
> When set to 2, the system will panic only after the maximum number of hung
> task warnings (hung_task_warnings) has been reached.
> 
> This provides a middle ground between immediate panic and potentially
> infinite stall, allowing for automated vmcore generation after a reasonable

I assume the same argument applies to the NMI watchdog, to the
softlockup detector and to the RCU stall detector?

A general framework to handle all of these might be better.  But why do
it in kernel at all?  What about a userspace detector which parses
kernel logs (or new procfs counters) and makes such decisions?


