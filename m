Return-Path: <linux-kernel+bounces-826017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 148B6B8D562
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0D72A0225
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 05:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A931F2737F6;
	Sun, 21 Sep 2025 05:54:50 +0000 (UTC)
Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21724226863
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 05:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758434090; cv=none; b=XwHdM/he9TXESCovP8AzjmcmSIZ+uZodUcGuTaiTtaXdXRKkkOw7Rx+DdvN3OASMcjKgGW/WyBFTri8lUirRiOewfeDLgi/rkzN6a8WwqQd3ioFFIdFN9Z2sHITJhlkciSgIrxoEfDS75uwa5h9rggQq7jm9yoOoTyY68J4TNyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758434090; c=relaxed/simple;
	bh=IQOMjv/XWFU6ZeX6ZY4a3Y6cru0sQECLaJUnw5UqKBI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E1TQtILtmmE+hDFaOrMBPlurObjyFu73bBuPpPppKgYSnLzAK6T14ajRgBZPquPqAG8n7VmcNE0HmgKn/shUJ3S7IZBVaFraDVD5vGZe6Abk/nQJSh+/+571x9AmT0KBb9mQm3ydXACWs9lxudjoftE1E73i9DleHtZErlZ8Uqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id AF8151003C5102; Sun, 21 Sep 2025 07:54:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id ADE391100A8ED8;
	Sun, 21 Sep 2025 07:54:31 +0200 (CEST)
Date: Sun, 21 Sep 2025 07:54:31 +0200 (CEST)
From: Jan Engelhardt <ej@inai.de>
To: Cong Wang <xiyou.wangcong@gmail.com>
cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
    Cong Wang <cwang@multikernel.io>, 
    Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
    Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
    Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, 
    linux-mm@kvack.org
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
Message-ID: <3ns36rp5-rp37-1nns-9q43-op05or6s26nq@vanv.qr>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Friday 2025-09-19 00:25, Cong Wang wrote:

>This patch series introduces multikernel architecture support, enabling
>multiple independent kernel instances to coexist and communicate on a
>single physical machine.
>
>Each kernel instance can run on dedicated CPU
>cores while sharing the underlying hardware resources.

I initially read it in such a way that that kernels run without
supervisor, and thus necessarily cooperatively, on a system.

But then I looked at
<https://multikernel.io/assets/images/comparison-architecture-diagrams.svg>,
saw that there is a kernel on top of a kernel, to which my reactive
thought was: "well, that has been done before", e.g. User Mode Linux.
While UML does not technically talk to hardware directly, continuing
the thought "what's stopping a willing developer from giving /dev/mem
to the subordinate kernel".

On second thought, a hypervisor is just some kind of "miniature
kernel" too (if generalizing very hard).

