Return-Path: <linux-kernel+bounces-728064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E31B02348
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689945A3631
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A36F2F1FEA;
	Fri, 11 Jul 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="EkufkGqD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BcOLyHdW"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF1B2AEF1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256923; cv=none; b=bXxfWgrRqfMrsSE5WrfXiugkpyaRTCjwtRzt31K2UOtUQY3v+bQt7vUu7GIzpaIkVsekd1Gm62gVWoM670j9NgieUu3KTS4bx2RWt7COdvUDF63yqVDsw79iY8HG0G3la8P2HZbKLavgMXSk62xZXPGVlRn8CyXHW7vhB/DOqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256923; c=relaxed/simple;
	bh=AUBn8qq+oo25ZfzcJM6bsltcDO59aSp6GlC0tU4vOI8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YKn/BhOkpA/3q6oV8APHWBm/Tp3Bd6egKnGhyTTjzdN1sl181KO5DTNPO7+0qd5Xs63LsaqWdXkQYLJ5Cwzmbbtbc5JdnGJpZ2lWOqNvBkqTrgOpY641R2tdE79WOWMBghKL7RU5gj1GMnjWagSVfpef5j1SQ2lDuHicSm8K+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=EkufkGqD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BcOLyHdW; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 68F30140010F;
	Fri, 11 Jul 2025 14:02:01 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 11 Jul 2025 14:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752256921;
	 x=1752343321; bh=ViqQEitTA2AtRCPGhVTpWzvVqc5soWd+CPn7R0uYCtU=; b=
	EkufkGqDS5HcVWBW4Yo8S4jDHibXCcchp/jcjJaVsbDLe1Mn0TRI72/n/vUVrR2T
	vq1Bh8mkDARZrIIZr/NU+8FD1NzF3lFHaMJyu64NqlwVQE+OSSZcyeM/bgdMqVGv
	v5BqttemmGKCwlnwXHvQVp96gqqGMLL/emY4OpV+G0bw6JL261VcNVdq0LoXxSoq
	Ei1x7LJ/NOC1XrmndN7EB6YpRxRm29A56007MdgvGe2WhmuiU9UZ4+AJEsOUi+45
	pHLELgAHMC5XQRZ9uLWuD8k9GgrNxgdB8d70dX5UVElwuzSS0DGp9wksqLmCTlac
	LYv9wWmiGZezDi2PPGxUpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752256921; x=
	1752343321; bh=ViqQEitTA2AtRCPGhVTpWzvVqc5soWd+CPn7R0uYCtU=; b=B
	cOLyHdWV5Az3GIEKPLW6MicLBf8A5BPEFGvZipUSGnAM7cuV1tZtiOrn0PovgjGV
	43lt5/pxg/xbL2YQRG5yCBfSh10ur4MRVqXeYdp+/y9KIjAl6LhwCZtAjXcJ8AIw
	lN2KBLMrtNINRavzP6RnZZyE/sQjewDR/K9VQx/fnNz++vzvVNXXiiK8ChMPa6hY
	yIEFhh2BqDm1+NvWGN4lrlszCFCLVMbla87R2yhyZzPQ6hZdNgqzuiZhHMWUybrm
	3nxOgk5+B1JANNzoUUtFFBQnDFpLIGFHldi0in5/PoBbEnNE+w2kyzuHvMaaAqRB
	4ZnqVYr7DlYITDNtwqIiA==
X-ME-Sender: <xms:mFFxaMKFod8MHhVr8NwROtAGlQzR_9lEl7WF7AnqTdb-bWUY1TJAXg>
    <xme:mFFxaMJbwCgm51dud8-WDkbzrF2hAdQq9c6lL0CcJEXoJ1cs1AHAjhiAOiaYOFbPt
    LyxPn0PlL1ijQGZKqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopegrihhrlh
    hivggusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughrih
    dquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthho
    pehnohhuvhgvrghusehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpth
    htohepsghskhgvghhgshesnhhvihguihgrrdgtohhmpdhrtghpthhtohepthhtrggsihes
    nhhvihguihgrrdgtohhmpdhrtghpthhtoheprghirhhlihgvugesrhgvughhrghtrdgtoh
    hm
X-ME-Proxy: <xmx:mFFxaAQhMLOsXk25VIb3itD4WmXklckNeHv7YYHGe1lhCetJ1CqiVw>
    <xmx:mFFxaFD0TjiR3i609iQMkg5SSx2yLZe0PgG64NQbC4zCneuGE_JzpA>
    <xmx:mFFxaIstXrN_dLpKmfkn6xPjLq-yTQn9gy_Jz5ClAZBn1HiJDTectw>
    <xmx:mFFxaD_OkqHW-_k_Q9Y9C6MF0AO170XMah7yfNLIOc2KR-xssqZMUw>
    <xmx:mVFxaAvYFPbpk8PsXV3b7Fp-6ljQAPE3syY_c-8haspNeuKfVg8w4q0K>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C3DE9700068; Fri, 11 Jul 2025 14:02:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T5e909394477f2510
Date: Fri, 11 Jul 2025 20:01:40 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Danilo Krummrich" <dakr@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Lyude Paul" <lyude@redhat.com>, "Dave Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "bskeggs@redhat.com" <bskeggs@redhat.com>,
 "Ben Skeggs" <bskeggs@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Dave Airlie" <airlied@redhat.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 linux-kernel@vger.kernel.org
Message-Id: <0a66b263-0d5d-4758-b6b5-fc3905612d10@app.fastmail.com>
In-Reply-To: <DB9ET7AG2N2D.YCVQRF9398V2@kernel.org>
References: <20250711072458.2665325-1-arnd@kernel.org>
 <DB9ET7AG2N2D.YCVQRF9398V2@kernel.org>
Subject: Re: [PATCH] drm/nouveau: check ioctl command codes better
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jul 11, 2025, at 19:41, Danilo Krummrich wrote:
> On Fri Jul 11, 2025 at 9:24 AM CEST, Arnd Bergmann wrote:
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
>> index 1527b801f013..506eeb44f0d4 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
>> @@ -1284,6 +1284,9 @@ nouveau_ioctls[] = {
>>  	DRM_IOCTL_DEF_DRV(NOUVEAU_EXEC, nouveau_exec_ioctl_exec, DRM_RENDER_ALLOW),
>>  };
>>  
>> +#define DRM_IOCTL_NOUVEAU_NVIV _IOC(_IOC_READ|_IOC_WRITE, DRM_IOCTL_BASE, \
>> +				    DRM_COMMAND_BASE + DRM_NOUVEAU_NVIF, 0)
>
> Is there any intention behind NVIV vs NVIF? Indicator that size is not
> considered?

No, just a typo, my mistake.

      Arnd

