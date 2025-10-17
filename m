Return-Path: <linux-kernel+bounces-857561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD589BE722E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B803A6CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBC9283C8E;
	Fri, 17 Oct 2025 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="huNCcGvr"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992627FD5B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689454; cv=none; b=jYbEQzJ+wQQN9gOvTeu2JMn3PwmFGl9ehMqHQQT4NdNlJwdlVG4cjfLjLelxov7OKtIbybDXCNLz4V9xNEKfmTsL529WCm907fVZUP3XsJc7dQhe0clfGqNXQQIEc0u1HUhQouGuuGQGrF2wSjLeSw8pGUAhAjq4piWzg11pKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689454; c=relaxed/simple;
	bh=McM2mvMkVPJy9yLZ+uSH+FTXEhHL97V1HuSxYXMMEXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HnclbpBtQv6T+z6cRm9QM8ud8G6e+t+asINqCEXn8y2oa9wB9PKDSx4mb2RVo9CCW4TeFwVmmgoEQx0/K6R3dc2510hJgzXXDCpIE7jbPdYAIvfDw5+IbF4g2Dw7kkMbROdnTr6ELChVxAHnSY6KM4Rh9lRh1NDN8VjDw2l3E48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=huNCcGvr; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ev
	ao6NDYDHHUvt38y+3qbDIqPKeXIb3vM3lrstmESlc=; b=huNCcGvrtBl2873RiK
	kh3XtYCfBMM3A7o4Gtx3zCVJSvR5YkxdMArlK8CS0aQ06ycfT6cMLEMcE1UUx1dl
	0QsbL0hwJ9YBvOsn0Tu0aeejSFaTr5mu0vWsOhTHoyVq3kas7zkTsRj53TaskGiy
	CeLonXajkdNDkg9Q85B9Kykfg=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBngNUU_fFoP8qQAw--.60681S2;
	Fri, 17 Oct 2025 16:23:49 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: hch@infradead.org
Cc: jackzxcui1989@163.com,
	jiangshanlai@gmail.com,
	linux-kernel@vger.kernel.org,
	tj@kernel.org
Subject: Re: [PATCH] workqueue: Support RT workqueue
Date: Fri, 17 Oct 2025 16:23:48 +0800
Message-Id: <20251017082348.2998547-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aPHhmz1C7d9vt2x8@infradead.org>
References: <aPHhmz1C7d9vt2x8@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBngNUU_fFoP8qQAw--.60681S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar1DWFyDCr4kJF4xGr18AFb_yoW8Gw47pF
	4YyrZrtr4DAa909Fs7Gr4xXr4Sgwn7tFyUGF48G34Ivrn8JryvvF4fK3yava4UWr93uw17
	AFWFvrZ8Cr1UZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUFii3UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCwBUbJWjx-RWIDQAA3f

On Thu, 16 Oct 2025 23:26:35 -0700 Christoph Hellwig <hch@infradead.org> wrote:
> This seems to mis an actual user?  Did you accidentally only send
> patch 1 of a series?

It is a cross-module issue, I'm not quite sure if there is a better way to handle
this. Initially, I was thinking of proposing a patch to RT workqueue. If that gets
accepted, we could then use the newly created system_rt_wq in the patch to fix
the issues we found.
One of the issue is that where the DMA completion work task for UART data is not
processed in a timely manner, it leads to anomalies in handling IMU timestamps.
The proposed change could be to add a new function called tty_flip_buffer_push_rt,
which would be implemented as follows:

void tty_flip_buffer_push_rt(struct tty_port *port,
                             struct workqueue_struct *wq)
{
    struct tty_bufhead *buf = &port->buf;

    tty_flip_buffer_commit(buf->tail);
    queue_work(system_rt_wq, &buf->work);
}
EXPORT_SYMBOL(tty_flip_buffer_push_rt);

Our 8250 driver is implemented based on the TTY layer, but the tty_flip_buffer_push
function belongs to the TTY layer. Therefore, a possible patch for a user of the RT
workqueue could be the addition of the tty_flip_buffer_push_rt function to utilize
system_rt_wq. In addition, other changes, such as modifications to the GPU driver
code we maintain on our platform, can also use this RT workqueue, just pass WQ_RT
flag when creating the workqueue.

--
Xin Zhao


