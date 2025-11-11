Return-Path: <linux-kernel+bounces-895574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D942DC4E51F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F36C3AE4BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABEF31195A;
	Tue, 11 Nov 2025 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qkerQOBU"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF892EBBA8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870184; cv=none; b=W6jF2YApnlahQ6PtzSZxp2amtWjCbnZnk7IJKgD9Kq4Sh5Kz5fuCbMKuL32OVQI082WZc0y1TpF6DL8fVQJ+GCMlJilLQ1W0bjM3coDPsPGxIc6+sk8MUmW0zVaN8uaTS5hS6AF1N0/zJbqW1PHaaJWhLlqpw9mq5hdxeCwKd88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870184; c=relaxed/simple;
	bh=JZkQjf1Sarg45c1oEVUVCoWxz7kcsUmp2qSWQ5FlFzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3mBrO44L/qKFUOU3Lw2pSChlRxCQKpCWam5WWTXe+t4qKKMNc8UzLYYrIh+O731p04MuH7P1IyAP43btqZX3ucE0SY7hgwhaCog6KLOQ5Sa4ITCQ3EWLKMk+tS4h4egEwVnrxOayPfDjpuO4xtze3Apu0Nu7dOggrYlLhTuj2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qkerQOBU; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762870179; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=sYOG6nKjCxsoQ9O4ldDugrraizvxW0Zd9RlSB6q6qdY=;
	b=qkerQOBUltL8zrFLJrpGNYEowYgRx5++D51BGFcf+YaqQqPVe+EmvYOkVH/D9/2kM+/btkiF0BJyABECfwmnrnA3mRnyAHjFlzkCPNwN0G0SVT8oVZItMWb3j6kGssdAq8N/C42cBu+PT5CmbPhatePMaSQr/t23tuOAu7ndYWk=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WsC0OrK_1762870178 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Nov 2025 22:09:38 +0800
Date: Tue, 11 Nov 2025 22:09:38 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <ioworker0@gmail.com>, paulmck@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] docs: panic: correct some sys_ifo names in sysctl doc
Message-ID: <aRNDooww1M_3lH55@U-2FWC9VHC-2323.local>
References: <20251106023032.25875-1-feng.tang@linux.alibaba.com>
 <20251106023032.25875-2-feng.tang@linux.alibaba.com>
 <aRIYUzM65_ZigeIU@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRIYUzM65_ZigeIU@pathway.suse.cz>

On Mon, Nov 10, 2025 at 05:52:35PM +0100, Petr Mladek wrote:
> On Thu 2025-11-06 10:30:30, Feng Tang wrote:
> > Some sys_info names wered forgotten to change in patch iterations, while
> > the right names are defined in kernel/sys_info.c.
> > 
> > Fixes: d747755917bf ("panic: add 'panic_sys_info' sysctl to take human readable string parameter")
> > Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> 
> LGTM, feel free to use:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks you!

- Feng

