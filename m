Return-Path: <linux-kernel+bounces-762985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 355F2B20D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D70621ED6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86E12DF3FD;
	Mon, 11 Aug 2025 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lj9QAutn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99932DECB9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925045; cv=none; b=rcLrNX6qI+nKg6/F36t6/kIOiN6He3XpqcTHgXdULqnNU76eSrik6f3qZblVlsYaRHpuoDwsdxdYnksRhntgP/6tniGfnI581Kp88gh3dSxyfZhG2bqRZOFHEMYK3UJ/0WD+svJI3r9CGiIOFmCLz1G7duE5qj6bdAbyT8/cfOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925045; c=relaxed/simple;
	bh=3WKxm72NITbkBR3dIdfO/Kv+ilX6wgZ3vwfq7CUUo2Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X0UyMPETofos2OajmzJiFvAEz/DDXjTGvvL/0B2/AhMS9Oytd1dmmhJhE1IzfwAoLo0Ie3eXzXlX6bjWeSRHjprnxzwqZFnWXUze9bnol8zI0Bbg/Tn+3+7Cp+kem3fRe0GcID96IPDtHZnFQAJHFOgFqP5SQRwyOy9xCvlCmdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lj9QAutn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754925042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aO9z+XXpX3ErnQZXNBza1RvhYs7AB5y4bts+goxtcPw=;
	b=Lj9QAutnTgEol+LwZZjWZeNaDvXYULNmKAvy8Clh7WEEczVPWZgc9rt0UJsYfEXw3XQh7y
	L7ypiF4/LjZ2mh8YWBr2kESxYmWvBJJyU858ZOVe1kFvfeNDu9wM/qYOJKAe2PdKheHs/6
	ACmQaROasKgUYW2FeE/txT3Xq1RY28Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-nAQ3sGEiM12ZM1rzu8n60w-1; Mon,
 11 Aug 2025 11:10:41 -0400
X-MC-Unique: nAQ3sGEiM12ZM1rzu8n60w-1
X-Mimecast-MFC-AGG-ID: nAQ3sGEiM12ZM1rzu8n60w_1754925040
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E92B11800357;
	Mon, 11 Aug 2025 15:10:39 +0000 (UTC)
Received: from [10.22.80.50] (unknown [10.22.80.50])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D6DD3000199;
	Mon, 11 Aug 2025 15:10:37 +0000 (UTC)
Date: Mon, 11 Aug 2025 17:10:29 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    "open list:DEVICE-MAPPER (LVM)" <dm-devel@lists.linux.dev>, 
    open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dm bufio: remove redundant __GFP_NOWARN
In-Reply-To: <bae5bba3-a73e-4a5d-80f8-e1506d0a302e@vivo.com>
Message-ID: <4fe735d7-736c-7bbb-173a-1bee27bbe92b@redhat.com>
References: <20250811123638.550822-1-rongqianfeng@vivo.com> <20250811123638.550822-3-rongqianfeng@vivo.com> <649a5bf8-309b-8128-b3f9-971d3a0bb350@redhat.com> <bae5bba3-a73e-4a5d-80f8-e1506d0a302e@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811712-898933741-1754925039=:1480606"
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811712-898933741-1754925039=:1480606
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 11 Aug 2025, Qianfeng Rong wrote:

> 
> 在 2025/8/11 20:44, Mikulas Patocka 写道:
> > Hi
> > 
> > I think that GFP_NOWAIT already includes __GFP_NORETRY too. So, should we
> > drop __GFP_NORETRY as well?
>
> GFP_NOWAIT does not include __GFP_NORETRY:
> #define GFP_NOWAIT (__GFP_KSWAPD_RECLAIM | __GFP_NOWARN)
> 
> GFP_NOWAIT tells the memory manager to only wake up kswapd to perform
> memory reclamation, not to perform direct memory reclaim.  Even if the
> request fails, no error message is printed.
> 
> Best regards,
> Qianfeng

Yes, but if GFP_NOWAIT allocation can't sleep, it can't retry - thus 
GFP_NOWAIT should imply __GFP_NORETRY.

Mikulas
---1463811712-898933741-1754925039=:1480606--


