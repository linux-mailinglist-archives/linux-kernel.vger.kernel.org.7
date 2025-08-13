Return-Path: <linux-kernel+bounces-767484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB2CB254FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8BC1C83461
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A7D2D4B5E;
	Wed, 13 Aug 2025 21:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rJi5ZP8d"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4EA2FD7B1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119361; cv=none; b=QfqVU98U+clL14Hdtb06Z6rum6PiAsOr2U/pp8bx7UMDB9WNVDUFRmFRhPCIQVudE41D7QKeweyJXoB2kWjgDxP0jU8g6PP/J5dlGKFCHpJ2lbveA2hxi2vyR0oLjVL4tLntZ6KXMGcyVoWYVtjaElF803zWCg1brq6fSEoviJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119361; c=relaxed/simple;
	bh=4u3pspi0LxwpT347z3FRHuIvIZrn4aXuvxep9Cs+OBU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=few6OA1bUg0bwhXA+IdjhNBD1h/OYERNLrZAeVUSUfHfw9Nql+QcMwbQeEzXEi8qCVJZ7CDWqTKg0ONfFjviz+ugRBhZOd2tZK9Q/jNkPgl6QPaal08EsZuDeksHzzrFJtT/CU6h31ODS+wLFa5clW33tJeNpiM4q9xxptSJI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rJi5ZP8d; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755119357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4u3pspi0LxwpT347z3FRHuIvIZrn4aXuvxep9Cs+OBU=;
	b=rJi5ZP8dJ82mgx//xwHe8c2a9I0aLu9bkntvpAhWOufawy8SfMDiVzeVDNMpbYz0XuxhGx
	gjFHKMTDuk8sRwE1moxe7y0Jnuk/mJn2T6VAL3HI58VamgrURHvJNHKd1dpJaNx0bv30Sw
	WA/RJXDGTHVmfuI7Cn94QmqO+UapT8k=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [External] : [PATCH] ocfs2: Remove commented out mlog()
 statements
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <2ca08337-e750-4d96-9e81-7728dbccf600@oracle.com>
Date: Wed, 13 Aug 2025 23:09:03 +0200
Cc: Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 ocfs2-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B3709B1-EAAC-434A-AE72-1ADD3DD7E54D@linux.dev>
References: <20250813180622.209305-3-thorsten.blum@linux.dev>
 <2ca08337-e750-4d96-9e81-7728dbccf600@oracle.com>
To: Mark Tinguely <mark.tinguely@oracle.com>
X-Migadu-Flow: FLOW_OUT

Hi Mark,

On 13. Aug 2025, at 22:33, Mark Tinguely wrote:
> Did you want to remove the one in fs/ocfs2/dlm/dlmrecovery.c from the =
smae commit also?

Yes, I'll just submit a v2 tomorrow.

> Reviewd-by: Mark Tinguely <mark.tinguely@oracle.com>

I'll keep your Reviewed-by tag in v2 if that's ok and fix the typo :)

Thanks,
Thorsten


