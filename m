Return-Path: <linux-kernel+bounces-760435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A6FB1EAF5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 328144E4878
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AEE283FF7;
	Fri,  8 Aug 2025 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsAM71Av"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D6928134D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664984; cv=none; b=RLj0tBuIWuQsgnr6bZpd6XcUzTpebKL437FMiDXUgYOQjpjRTI8LDCFQwvCCxzai46oN2BYmACyY5LnOacVu9JdBDgXo8gLo/f7bS6BYeRzxgEvKEbXM86+509hU2k8/QgHzmnye292ikWfYYuzsbNLTkTJVhX5KyWPiyqjHnNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664984; c=relaxed/simple;
	bh=egryD4WW3YF0s4Kmr5JVpmF1EeVvDVMQww6rkW/FnLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhEknkX86wui5ZbKJTYM9m9e84/J6x26Ma5TBs+ozwi+EHZd7e3lusoucbkyAOQrQ8ateehwys00jCnccC5C5O8ayT6IVIcKTvzyKr4PcCrws/GttKNMEHG1lWFDFaIOkfdoop6ZqsmW2XXfkTCn0fAE+0kSwv0aJrjiQu2WW2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsAM71Av; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC0BC4CEF4;
	Fri,  8 Aug 2025 14:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754664984;
	bh=egryD4WW3YF0s4Kmr5JVpmF1EeVvDVMQww6rkW/FnLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qsAM71AvcL3/GgGTXXznKonz3ypj2ZlSdmaA7/Bpc0c088tMmaZlEVKdc1Q3OOR1f
	 xYA66GTz2t+Rq4uQzyEni4KRkJChTxMLpsfA0SdpJwCP8a2EP/t4ZvZEZ7Y63kfv2d
	 yASHh6ndVKIaV7jeA4yI0GlFnQXbEO+QfMHD5MtOJZ7Lwt3autBZyPY+w94t3e/Aq2
	 M5c05+jxCuSE4HXGDjFFbK9w+g6/Av7bx4lF7HM61kSkZlzo+FQ9ToqASaomX+m16H
	 E8F6nMz/1Xv4O1d4V+A4EsRUHVaK9Y6ekBFWG+/EsuiSVM3ZPnvWELgr912RHHuTCI
	 GSH738OOTeE/g==
Date: Fri, 8 Aug 2025 16:56:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Xiang Gao <gxxa03070307@gmail.com>, 
	"mjguzik@gmail.com" <mjguzik@gmail.com>, "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
	"joel.granados@kernel.org" <joel.granados@kernel.org>, "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Message-ID: <20250808-erleichtern-hinreichend-35335e412d9e@brauner>
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
 <20250802022550.GT222315@ZenIV>
 <15b18541f37447dd8d5dbd8012662f67@xiaomi.com>
 <20250802084525.GB31711@redhat.com>
 <80be47cb31d14ffc9f9a7d8d4408ab0a@xiaomi.com>
 <20250804114900.GA6656@redhat.com>
 <20250804-gepfercht-delfin-0172b1ee9556@brauner>
 <20250804124402.GB6656@redhat.com>
 <20250805124300.GB27131@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250805124300.GB27131@redhat.com>

On Tue, Aug 05, 2025 at 02:43:01PM +0200, Oleg Nesterov wrote:
> On 08/04, Oleg Nesterov wrote:
> >
> > But. I need to re-check, but I just realized that pid_alive() can't
> > really help, tsk->thread_pid is not stable even if tsk == current.
> >
> > This means that, say, task_ppid_nr_ns() is buggy.
> 
> After the quick grep I don't see the problematic users, but if a zombie
> task T does task_ppid_nr_ns(current, NULL) the kernel can crash:
> 
> 	- pid_alive() succeeds, the task is not reaped yet
> 	
> 	- the parent/debugger does wait()->release_task(T), T->thread_pid
> 	  is NULL now
> 
> 	- T calls task_tgid_nr_ns()-> ... pid_nr_ns(ns => NULL) because
> 	  task_active_pid_ns(T) returns NULL
> 
> Do you think this worth fixing?

If it's not too much work and it is an actual real-world concern then I
think we should fix it. But I trust your judgement here!

> In any case, I think that task_state(), sched_show_task(), bacct_add_tsk()
> should be changed to use task_ppid_nr_ns(tsk).

Sounds good!
> 

