Return-Path: <linux-kernel+bounces-755060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF7FB1A0BE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DF417C14C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD2E253F11;
	Mon,  4 Aug 2025 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeiCc3MZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BE123817D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754308225; cv=none; b=kv4lBRrBhDUvOlkBxULvCvpwHzAKl2uIFuLBGrLXv0jmm6fbbKDAS94OviGOvF1pKu2Xx9GNoxPWeKVlDHspWYT5VCaZLjgrU2hHpUExEQLAaAUJJvO0mSdPXCOKTtumcxIzWadYaVmkPZWex5eJG98ieusewbT48vlkfmzco8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754308225; c=relaxed/simple;
	bh=3Vq1R2/+ixLeOy0LNVLPRd9W2ZeEd91Hx9hG97pL6OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0BIpQrsT+QAxm/Y/e569qf/e2HsGAQxnUh0RQqN8eDhAgG5c+qhTlSIuzOw5TRx88pHGV0X4wrgSACCUUA1iIakajaVGA/aQZPa3rYw9Bl3ds+SKiw0K5z8klnQNiMeOHv8gMgJpMcUPUoszaASMO5SSWbzf1ZqUEC9ZJ2Y8Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BeiCc3MZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754308222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mdaQlvbfPB2YeAnuUI5AJMrKcbE2YmdZrPTpHl1ML6o=;
	b=BeiCc3MZ+g3Kri8k7ziAJEghKs+vUYIXYcTYXCuW40jKFDxgPPp453Idigiz+6Linr2x8X
	ktMBjLLKQseT9+7oi0M7HVVF+hHCBHpoPxtm1qgfk+WdLzZlfUerMdBRGEcx9jxB/paVtf
	L1h407kZYronzefH6wDiekSrDTmQps0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-Z6PMZ6DUMwmZTXgYwTTL_w-1; Mon,
 04 Aug 2025 07:50:19 -0400
X-MC-Unique: Z6PMZ6DUMwmZTXgYwTTL_w-1
X-Mimecast-MFC-AGG-ID: Z6PMZ6DUMwmZTXgYwTTL_w_1754308217
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FE221800288;
	Mon,  4 Aug 2025 11:50:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.23])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8D08C1955F24;
	Mon,  4 Aug 2025 11:50:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  4 Aug 2025 13:49:05 +0200 (CEST)
Date: Mon, 4 Aug 2025 13:49:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Xiang Gao <gxxa03070307@gmail.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"mjguzik@gmail.com" <mjguzik@gmail.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Message-ID: <20250804114900.GA6656@redhat.com>
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
 <20250802022550.GT222315@ZenIV>
 <15b18541f37447dd8d5dbd8012662f67@xiaomi.com>
 <20250802084525.GB31711@redhat.com>
 <80be47cb31d14ffc9f9a7d8d4408ab0a@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80be47cb31d14ffc9f9a7d8d4408ab0a@xiaomi.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/04, 高翔 wrote:
>
>     struct task_struct *tsk = current;
>
>     struct task_struct *parent;
>
>     ...
>
>     info->pid = task_pid_vnr(tsk);
>     rcu_read_lock();
>     parent = rcu_dereference(tsk->real_parent);
>     get_task_struct(parent);
>     rcu_read_unlock();
>     info->ppid = task_tgid_vnr(parent);
>     strncpy(info->ptask_name, parent->comm, TASK_COMM_LEN);
>     put_task_struct(parent);

So I guess the kernel crashes when you try to obtain another process's pid, not
the current process's pid. This is was I suspected.

This code is buggy. tsk->real_parent points to nowhere if tsk = current was reaped.
rcu_read_lock() alone can't help. Even get_task_struct(parent) is not safe. And it
is not needed.

You need something like

	info->pid = info->ppid = 0;

	rcu_read_lock();
	if (pid_alive(tsk)) {
		info->pid = task_pid_vnr(tsk);
		info->ppid = task_tgid_vnr(tsk->real_parent);
	}
	rcu_read_unlock();

Oleg.

> 
> 
> 
> ________________________________
> 发件人: Oleg Nesterov <oleg@redhat.com>
> 发送时间: 2025年8月2日 16:45:26
> 收件人: 高翔
> 抄送: Al Viro; Xiang Gao; brauner@kernel.org; mjguzik@gmail.com; Liam.Howlett@oracle.com; joel.granados@kernel.org; lorenzo.stoakes@oracle.com; linux-kernel@vger.kernel.org
> 主题: Re: 答复: [External Mail]Re: [PATCH] pid: Add a judgment for ns null in pid_nr_ns
> 
> [外部邮件] 此邮件来源于小米公司外部，请谨慎处理。若对邮件安全性存疑，请将邮件转发给misec@xiaomi.com进行反馈
> 
> On 08/02, 高翔 wrote:
> >
> > Obtain the current process pid in the ufs compl command. This scene is possible.
> 
> How exactly your module tries to obtain the current process pid?
> 
> task_pid_vnr(current) should work and return 0 if the task was reaped.
> 
> Oleg.
> 


