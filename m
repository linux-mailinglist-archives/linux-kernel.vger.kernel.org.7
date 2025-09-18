Return-Path: <linux-kernel+bounces-809094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD79B50864
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C03A1BC6370
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA490261B60;
	Tue,  9 Sep 2025 21:51:59 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D2122A817;
	Tue,  9 Sep 2025 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757454719; cv=none; b=VijKM8N7f5E1a2OGPL6/ZN724WMb/cfn5DyepTp4ahkAFpipObjAsVMUnlpnqoYan9cywm1SXTZeLA1Pf3Qwt94Wzj7DJAwLwX6LBb00TORmFiznMqPTgO7bSHQcYn82GSmoU8zxkZg8ZPtgLx3HaH6EEP2qxlb2xq9xDMaYofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757454719; c=relaxed/simple;
	bh=bjUkjTH9OdxS0DCNUZKqxku7vJbh17gd1/TPchE6Ctg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xr7L3+0l3cQhN1CGp6oXzrTlWvb0HKBGNn9osKgOdHHn0/KY7Pg5z41XpLpCWFG0RREHFTeOFkAS72bsCS25LsCAgEpkzTRqhtVmIZCdQ59cAKyiY7hbB5t8ZTt7D5+MWDHR+fVdUMJoPrznSn1P1MFp82P6DHnaeZAYn3nri8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 37F7411AC15;
	Tue,  9 Sep 2025 21:51:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id B3CED20025;
	Tue,  9 Sep 2025 21:51:51 +0000 (UTC)
Date: Tue, 9 Sep 2025 17:52:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 jstultz@google.com, qperret@google.com, will@kernel.org,
 aneesh.kumar@kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/24] tracing: Add events/ root files to trace
 remotes
Message-ID: <20250909175240.4db7c0eb@gandalf.local.home>
In-Reply-To: <20250821081412.1008261-8-vdonnefort@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
	<20250821081412.1008261-8-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: a6dhj43w5f1j4i5ea6e1kz1oidpsfdiz
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: B3CED20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19NE8UX9pout0gmp8nK4qQdOWNA+46veZ8=
X-HE-Tag: 1757454711-688199
X-HE-Meta: U2FsdGVkX1+5T2tCPQ+moXus8fA3OM8acJeM+WEPmFi/qhIBWOI3c1MIrGa8HCGVuEPNTJpPFnstSsHWuAqGhXNajKOEStbjgqTlnZzV/TGwuesdpTEnH/czE+NNgquHlm6dtXATZx3Ygwq3Ay3ZH2ovgcIxKBk5xyiyIAO31TrYvniPp/wSl2JSupBAhRGenJEdGZ6RLnX6LTapu3t5pEqVwyIfG0Y6oBvF4w8lI5adQVgM/ZDhHkx6yFiV+1aOk0521araOy7Rc5SDUxEzZxgrGaxDaxU1Ko+DPWVghsinHexkE24dcer7txlzXEnZBK0ctKUzoE9rmB/+jnGhiIx7KKmW664l

On Thu, 21 Aug 2025 09:13:55 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:


> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index 822cdd76e334..5065b162c8ef 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c
> @@ -710,10 +710,118 @@ static int remote_event_callback(const char *name, umode_t *mode, void **data,
>  	return 0;
>  }
>  
> +static ssize_t remote_events_dir_enable_write(struct file *filp, const char __user *ubuf,
> +					      size_t count, loff_t *ppos)
> +{
> +	struct trace_remote *remote = file_inode(filp)->i_private;
> +	u8 enable;
> +	int i, ret;
> +
> +	ret = kstrtou8_from_user(ubuf, count, 10, &enable);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&remote->lock);
> +
> +	for (i = 0; i < remote->nr_events; i++) {
> +		struct remote_event *evt = &remote->events[i];
> +
> +		trace_remote_enable_event(remote, evt, enable);
> +	}
> +
> +	return count;
> +}
> +
> +static const struct file_operations remote_events_dir_enable_fops = {
> +	.write = remote_events_dir_enable_write,

Hmm, why not a read as well? Or is it too difficult to figure out what is
enabled and what isn't.

For the main trace buffer, it's:

 0 - all disabled
 1 - all enabled
 X - some disabled some enabled


> +};
> +
> +static ssize_t
> +remote_events_dir_header_page_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
> +{
> +	struct trace_seq *s;
> +	int ret;
> +
> +	s = kmalloc(sizeof(*s), GFP_KERNEL);
> +	if (!s)
> +		return -ENOMEM;
> +
> +	trace_seq_init(s);
> +
> +	ring_buffer_print_page_header(NULL, s);
> +	ret = simple_read_from_buffer(ubuf, cnt, ppos, s->buffer, trace_seq_used(s));
> +	kfree(s);
> +
> +	return ret;
> +}
> +
> +static const struct file_operations remote_events_dir_header_page_fops = {
> +	.read = remote_events_dir_header_page_read,
> +};
> +
> +static ssize_t
> +remote_events_dir_header_event_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
> +{
> +	struct trace_seq *s;
> +	int ret;
> +
> +	s = kmalloc(sizeof(*s), GFP_KERNEL);
> +	if (!s)
> +		return -ENOMEM;
> +
> +	trace_seq_init(s);
> +
> +	ring_buffer_print_entry_header(s);
> +	ret = simple_read_from_buffer(ubuf, cnt, ppos, s->buffer, trace_seq_used(s));
> +	kfree(s);
> +
> +	return ret;
> +}
> +
> +static const struct file_operations remote_events_dir_header_event_fops = {
> +	.read = remote_events_dir_header_event_read,
> +};
> +
> +static int remote_events_dir_callback(const char *name, umode_t *mode, void **data,
> +				      const struct file_operations **fops)
> +{
> +	if (!strcmp(name, "enable")) {
> +		*mode = 0200;

As 0200 is a bit strange.

-- Steve


> +		*fops = &remote_events_dir_enable_fops;
> +		return 1;
> +	}
> +
> +	if (!strcmp(name, "header_page")) {
> +		*mode = TRACEFS_MODE_READ;
> +		*fops = &remote_events_dir_header_page_fops;
> +		return 1;
> +	}
> +
> +	if (!strcmp(name, "header_event")) {
> +		*mode = TRACEFS_MODE_READ;
> +		*fops = &remote_events_dir_header_event_fops;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  static int trace_remote_init_eventfs(const char *remote_name, struct trace_remote *remote,
>  				     struct remote_event *evt)
>  {
>  	struct eventfs_inode *eventfs = remote->eventfs;
> +	static struct eventfs_entry dir_entries[] = {
> +		{
> +			.name		= "enable",
> +			.callback	= remote_events_dir_callback,
> +		}, {
> +			.name		= "header_page",
> +			.callback	= remote_events_dir_callback,
> +		}, {
> +			.name		= "header_event",
> +			.callback	= remote_events_dir_callback,
> +		}
> +	};
>  	static struct eventfs_entry entries[] = {
>  		{
>  			.name		= "enable",
> @@ -729,7 +837,8 @@ static int trace_remote_init_eventfs(const char *remote_name, struct trace_remot
>  	bool eventfs_create = false;
>  
>  	if (!eventfs) {
> -		eventfs = eventfs_create_events_dir("events", remote->dentry, NULL, 0, NULL);
> +		eventfs = eventfs_create_events_dir("events", remote->dentry, dir_entries,
> +						    ARRAY_SIZE(dir_entries), remote);
>  		if (IS_ERR(eventfs))
>  			return PTR_ERR(eventfs);
>  


