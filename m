Return-Path: <linux-kernel+bounces-731500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4921EB05549
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94BF816404A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FC726A0DF;
	Tue, 15 Jul 2025 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ef+jRMVR"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF54D2FB;
	Tue, 15 Jul 2025 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569286; cv=none; b=tUB9mELlUgLHLJfiIBldeyqQsVnCvPt2B8H74L3Cx5v+CjyTmq4RHNpK99jLneJm7qeQBl+voD0HXKxbkLgW/fIajP4k2oWsbFlavcYpN1zxSHgZ163PXfIYuWyzDgdvClO7tHE7Ad9zR2qRDnkJ67K9e0CFknL3q6yq4ULczrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569286; c=relaxed/simple;
	bh=Sxhj5g8gVZGC1952hSXVSZSvox7q3kGrjDdEklg0tJA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=SiAokxBFvNxdi1xnABBBNUnBz7xYpnR5+cwUHCMptK2drL8koPVZp6fx3rZ13WhGSc30+Q6NCThTgaDNskha7haiCA3BV39lXuF62nmEHAIAuhJLYyTIE/1WXRYSyndU96AhDoNR+Sx7ItOvJ7kcS/ogkvV7uH7FLxMOjT9dIN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ef+jRMVR; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1752569262; bh=TAWwiMg/tBAq8p0IBBI0q3j7v7MD3F9Kcpzix5eTnY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ef+jRMVRwm60WqnFXvApDGruIlqOLc+cdHi8VMYHkTEqCheVIfr6OIH0GmkXeWFeo
	 89ICvihHXjJplumn/zGgV3lHAApOP5b7k191eQpLoeWIG2ILcIK9c+XVjGteF42WTl
	 2z0rTJCKlrossMvCorPLVKrh+sqGmyCI9s5z63Mw=
Received: from VM-222-126-tencentos.localdomain ([14.22.11.163])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id BE9AB4AB; Tue, 15 Jul 2025 16:47:41 +0800
X-QQ-mid: xmsmtpt1752569261tcppgu9pj
Message-ID: <tencent_15EB27E9BF5F35D7A364A591E102DCC6F90A@qq.com>
X-QQ-XMAILINFO: NCJFlKxSknUZs4JoxYmIyZcNwZslULh/SUHFSNi9TP+3saUIm7a0iwhXs8/NwL
	 1W8Y3Er26cC1JPj417k0wgMcmGkW7scc6WIdymYoXK+euP+nitQDTZ2nBx2B6K79VgncAnIHoAf4
	 3Mau4NgDC90Y5s+x07ChYAi5CoROn+wpKJttuzUYjqlece0nTMCauV4ObV72YByMZ5exF+SC+Unr
	 AvBpPYb5ksPNnvk83vv+emhZ6FyU5yknlYIT6cZJcXr89wGUjYiUHskyp/4HKXt0MOwQCQyHSIZg
	 WwUHB6NRg58nsN7joUjOJ3jTaUHz6rerIWJckfGACgNbgaGLXsjr/OBMy87lML2WmYtZq4j96m4I
	 GEo5TC7vFPt4mpR3aeOlNZypjZ32dnZ9iAMXAAJumhB359XpKUY6N9Ag5WgPZzZ+vrvlIrzA9vrD
	 srHtj12mccoFhDDX++cvbgaDY8gWJQ34gngBN67mqaj5j6Mx4zWudcSRWmCq211QdXplF+XIdL26
	 U9kSYj6f4aSe8wWSntB3sPb2/3PTUvXNXcZwqfeqxONnmslZKiiZRJaceK9GLLJ2JxY9NuQzg11O
	 Xq33BlqSmFHGW62QAeXAiythUYoAdUfGwji5huCcmy3mbBgRwHn7ok4VtJJd6ENJ5nfne5zqqD5Y
	 QHjhfsNs/xB1Wo4AlMi2y4p2NeuRd0wRHW7/OELYGPnfxqaIvV72NsTjSbXxHVz3kyapQLdLkc2G
	 lOmTLD7KDM75RPk8uVRm5+ggX9kerpUtQj99V8i4Y/tjrOfNoZnSBLnP309ugWOzCtXPmygh10Tg
	 Uxoi3N/pnsL0R8gQw1q30ry1/ml9CA4ir1uA3kKeA9wBvCmI74flcwYpvIoTzk7FbCwlC0zbdigr
	 tav44xdKBvXCo8hezEhuCmd1tNzARk2i5RhvIWVjVktqxjGcOoh2bOtWFkv4CXADYsvQuVdJhN93
	 ZjMFd4r+2MIsuWkH7/K+LfMpdSOC4yyFX3lTJvvHYYPTPdwExYpreUoE+4SBVso/LE+OD7jmZ8VJ
	 05HPoriUMUrl2OguoXzonsrm0p3rWLm/fR9w25N4I4OL+4m0u7
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: jackysliu <1972843537@qq.com>
To: gregkh@linuxfoundation.org
Cc: 1972843537@qq.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] usb: gadget: functioni: Fix a oob problem in rndis
Date: Tue, 15 Jul 2025 16:47:36 +0800
X-OQ-MSGID: <20250715084736.3157098-1-1972843537@qq.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <2025071539-tattoo-knickers-a775@gregkh>
References: <2025071539-tattoo-knickers-a775@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jul 15 2025 10:32:28 +0200, greg k-h wrote:

>As per our documentation, you have to always disclose what tools you use
>to find stuff.  Please always do that, otherwise your reports are going
>to be ignored.
>
>And then also properly TEST your change to verify that it works before
>submitting it, that didn't happen here.
OK , I'll mind that later.Thanks for your kind reply.

Siyang Liu


