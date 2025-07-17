Return-Path: <linux-kernel+bounces-736079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E0CB09857
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 01:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD4F1C43E43
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D20225A39;
	Thu, 17 Jul 2025 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="NkbcIlH5"
Received: from mail3-163.sinamail.sina.com.cn (mail3-163.sinamail.sina.com.cn [202.108.3.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A3921A928
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795755; cv=none; b=glGSi58yKVdcPCP/b8nXOOUw2tmEZX2mRL89skAPLj6dFy/x27i0N3PESqfYZ8vBUC6C0QbUccFVxrQcii1cRUBQofKVAS7RyABbEg+mW5UMz7Y2ZIj541EXDmFVPbH/FjYataDk9nNHFYNfYST2quRXU1GBA3XjaWaRgw0WBZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795755; c=relaxed/simple;
	bh=tLMeuWcY5dZ/SP2YIJD/jIA7A4PgzYheE3z+47KMQRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXzg0YvpG6lFFc5q1YAifYwu5k3IX4F0ivXhjd4VtbtPkBwsxb61jTofcXsaZw7K7j5LKBZ4VcPE1BBfgs+X1oTJn6vvLOUzQr0DPb/uj5aEewHcnRJPBJeO29C9m+4fYwh8aNvXJdjaRKeNcNNINY+vCa15aAdW0FssS8q2Fpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=NkbcIlH5; arc=none smtp.client-ip=202.108.3.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752795750;
	bh=0gdzAFi3nL1mlUMjX1WcxIl7a1Y3sVw0Mhg8EU6lFuQ=;
	h=From:Subject:Date:Message-ID;
	b=NkbcIlH5XMoQRyj58il5+8Z6+aHUmvQcpK+UcEXk/uW7ova3Cz6EISlfBXyPVAJOl
	 pPsj+GrwlB8tZlwbpzxUNi1ea0H9Gjqh6JzWxkQ86FwMOh0CKMFN9s2MKqoOuxG5iq
	 Do7LD5G/MfChq23b4GAE/8BA8YcHaI4kX4nQuHaY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68798A5C000060FC; Thu, 18 Jul 2025 07:42:21 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 091516291755
X-SMAIL-UIID: 730DF730D7E4429D9DCD6571EC87227F-20250718-074222-1
From: Hillf Danton <hdanton@sina.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: syzbot <syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org,
	liam.howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com,
	vbabka@suse.cz
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in mas_next_slot (2)
Date: Fri, 18 Jul 2025 07:42:11 +0800
Message-ID: <20250717234212.2329-1-hdanton@sina.com>
In-Reply-To: <4c29e030-4ba8-48e3-96bb-015d43768db0@lucifer.local>
References: <20250717014623.2253-1-hdanton@sina.com> <68787417.a70a0220.693ce.0037.GAE@google.com> <8a2f1892-3184-4aaf-91ea-522e9ba2391b@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 17 Jul 2025 17:06:34 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Top reply is not encouraged lad.

> OK on second thoughts, there is one additional thing we need to do on each
> loop to avoid observing the same VMA, either the prior logic of checking
> directly or a vma_next().
> 
> So this may be a consequence of that.
> 
> I will respin the series to make life easier...
> 
Better after syzbot gives you Tested-by.

> On Thu, Jul 17, 2025 at 05:18:17AM +0100, Lorenzo Stoakes wrote:
> > This looks to be unrelated to my patch and some issue with syzbot (it's doing
> > weird injection stuff).
> >
> > As I said, I have tested the change with reproducer locally and it fixes the
> > issue, and I have been able to reliably observe that (note, without any of the
> > below stuff happening).
> >
> > Thanks

