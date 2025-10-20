Return-Path: <linux-kernel+bounces-860848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD6DBF12AB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4560A3AC7CD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AEE1D5170;
	Mon, 20 Oct 2025 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWMiXQjX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715B62EC0A9
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963078; cv=none; b=rEentJtbr+gTi4dXww6JsbvxbfAtYmMaMu1uteJ4ynpQzi3M7dpEgu5orUyrh6Wo0w/ASVWK96EabrDmrzsNX58or727JmjFD5s3m2yaiTCh6/LIhpOYATgQUFoC5JiEDF1YsLREKm65DKaWyxPEwsejPNZmEC6To+fUBUGsj1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963078; c=relaxed/simple;
	bh=+Lf3jrlQiMB8ePO4EpY9KhHm/twT4LtufXHEfnWA+iY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=N4cr8uc8o3T7HUXD+h+Cg2bbS8+eErFoFBwF0uUyvGOd9vq4Eips7NqRAX5SLdSHXGVihYRnx6rjFyqPyOP5ftMmvR/oIoT9G5l6z6AaIsxBYNUECuH4kce/9idHkyrID7TjK6HJWPhcMU7oAEzX2+KGdQ6ra/z1kXw8ZWcylLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NWMiXQjX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760963076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEvXetqsc1+GJjAEF+CAZDaq+xk43k76wO3TnVDQxRI=;
	b=NWMiXQjXXaxgZxoKESQ1LBDU4m5FY37vx726tZp1kse5H4YfLoZtXFZ5YUjG3Mhy0ga8v8
	O3Tp3OfdW7xl4HKwtwVPC5x3nnvzApzGxryBy6El3CdZ1fAlrXpJw1FYs0aJsBInkd5gQJ
	7cOuwVA+Vk5OmsRFzz23w+GVENaS17Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-UsgcOC9mMRSJUHA-f4N6gg-1; Mon,
 20 Oct 2025 08:24:34 -0400
X-MC-Unique: UsgcOC9mMRSJUHA-f4N6gg-1
X-Mimecast-MFC-AGG-ID: UsgcOC9mMRSJUHA-f4N6gg_1760963073
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 573D91800637;
	Mon, 20 Oct 2025 12:24:33 +0000 (UTC)
Received: from [10.44.32.107] (unknown [10.44.32.107])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5B4A19541B2;
	Mon, 20 Oct 2025 12:24:31 +0000 (UTC)
Date: Mon, 20 Oct 2025 14:24:29 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
cc: Ard Biesheuvel <ardb@kernel.org>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] objtool: fix failure when being compiled on x32 system
In-Reply-To: <scpfhyfcieyydbzpjh7r25mouuzkt7gskqftqhzzcetuwb7hwa@2bvnhvhluyv6>
Message-ID: <38c99ba1-7370-61c7-8378-9e6bdec44e99@redhat.com>
References: <f80021c8-f8e1-9ed2-4791-705c4d7b7b8a@redhat.com> <CAMj1kXHsiSB6aQVhqTbS0vhcEgk0TpP+4bxzSA5T0s6WrK2ZjQ@mail.gmail.com> <scpfhyfcieyydbzpjh7r25mouuzkt7gskqftqhzzcetuwb7hwa@2bvnhvhluyv6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On Wed, 15 Oct 2025, Josh Poimboeuf wrote:

> On Tue, Oct 14, 2025 at 09:33:08AM +0200, Ard Biesheuvel wrote:
> > (cc lkml)
> 
> Can you resend the patch and copy lkml?

OK, I've resent it.

Mikulas


