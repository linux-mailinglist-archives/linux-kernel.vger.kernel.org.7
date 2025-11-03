Return-Path: <linux-kernel+bounces-882969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330D9C2C0D4
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1F01885DF5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900E724A076;
	Mon,  3 Nov 2025 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="fges7CDJ"
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F92D25393E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176180; cv=none; b=BtTmAmp9jA9l7VuP/pBsgwxjauSnSY/z5Uhd37ZmAzMqgh2P0txdVGbAzTpNI5a9PUqXhXzsGOtExWaTGWy2P+xWdZjBfKD2swFHIyEOikwgO97ZGXmR1cwEaN5CU26xQNF0zYKKQxZA+9anaLz3k0waB6KfOlsL3kkZZ3oD+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176180; c=relaxed/simple;
	bh=BrnOhvhWvEvKEwR+w8+4dOOIA/8UHTK9BhpJ6Cvc6jw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=boqhRkR442K47ou57UcxBKiXQz1/sEXWLAE0x3BI9cHhUGfKO5viDBncb0rSHsAYYduMfnMdik8IEEu9J2IRegsyrJH4xmktvqEp1gMVH6lWMC+S4i4+eVVDxdUq/LKLsWVRxZDuHQMSW9L85z8VmGTct1k9xzSpa2XL087/Uzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=fges7CDJ; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 2cc398c0-b8b8-11f0-809d-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2cc398c0-b8b8-11f0-809d-005056992ed3;
	Mon, 03 Nov 2025 14:22:41 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 0d477362-b8b8-11f0-99be-0050569977a2;
	Mon, 03 Nov 2025 14:21:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=+7sZtG5AAjxgFYL7Bv2RYLvwr2fUcbbLMcE/XSo/QQs=;
	b=fges7CDJhFMLqIzV1ImDebe31BflrEreI4mGLUByKiyxVG1wi1OwcDL/blE6JP1Cli+AOVofI8L4K
	 +cXtwJyaXXuOU+fJPS9O4ugrmWoyMnjgZ0t0v1RAQRnG/2xWVCQFk0seh/WWkm6io1N22jo5sqm1qY
	 YOy4EKt1Jiu77/vwrmswR5OhTD4cfb13s6tut3CkdomUZxWxQW5d8Pc9hGgP1oQyk4oQz4al/OPXwo
	 DF1k3O0Q3rTev2q6mHECTeF/qhuUgluC/NaGmqgoZ+FNQB7M9i0R3aE9ltyhk/uoqcb6TbJTv7L/SO
	 Hvx8WtDu5uuv6ueHr9BdJy0yj2ekCyA==
X-KPN-MID: 33|8QgKmv8LxMmyw+hAg3ZsR3uWPpbE1Gaxpk282DWxcrZyXumHlntlh7tiUbpVedq
 XKnaplokXxb3J4VM/nu2uIoPSetKk24m4QNkWxA/aAS8=
X-CMASSUN: 33|NAbl/Yrsb0pPoPfJ7TQ6jV/Zteut5hdcveBHSz7RmGmznOAx4btapxDneroDIPE
 i/NU/eCDzblWfOdMGo4JDBw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 0d3a28e4-b8b8-11f0-94b1-00505699eff2;
	Mon, 03 Nov 2025 14:21:48 +0100 (CET)
Date: Mon, 3 Nov 2025 14:21:48 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Taotao Chen <chentaotao@didiglobal.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	linux-kernel@vger.kernel.org,
	syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Message-ID: <388208404.3543067.1762176108384@kpc.webmail.kpnmail.nl>
In-Reply-To: <aifdv7l2aomyyjdldpmhucnujstfzadjafy2s4kjqq5ecsk2hf@q4nph7xhemrg>
References: <20251102135239.2203389-1-jkoolstra@xs4all.nl>
 <aifdv7l2aomyyjdldpmhucnujstfzadjafy2s4kjqq5ecsk2hf@q4nph7xhemrg>
Subject: Re: [PATCH] Fix a drop_nlink warning in minix_rmdir
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal

Hello Jan,

> 
> Looks good, just one nit below. With that fixed feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 

Will do. Question: I have fixed another syzbot bug report in minix_rename/unlink
and posted the patch. I figured that because they target different syzbot
reports, they should be separate patches. However, I forgot to add the
EFSCORRUPTED define in that patch (but did include it in the #syz test). What is
the best way to rectify that and add your suggestion to this patch? Or should it
be a single patch, or a series? I want to cause as little work as possible for
you and other maintainers.

Thanks,
Jori.

