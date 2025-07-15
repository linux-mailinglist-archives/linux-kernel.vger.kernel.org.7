Return-Path: <linux-kernel+bounces-732577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDD8B06903
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB787B25AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0CD2BE7B4;
	Tue, 15 Jul 2025 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dev-mail.net header.i=@dev-mail.net header.b="r7GeW2zj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WHXmuHXa"
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE34FBE65
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752617001; cv=none; b=NFxEd7kOEuA1EtnkXx3Ecq0uBOMys5Kg+DsvM4RF9banp46ZtWgpe8mdVBEj3xAJYdqeTzX39wdCUNUowbDAfFfGDbnqCC8mINsX9U3TKQhol/i+sFZ3o092HFO+7g8t0oVI7cScAn0Rg1InobZ3ZXl4m3SSUdxz0Qz3Xk7TMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752617001; c=relaxed/simple;
	bh=GEBjZyDK82w+i3NQ0B9iJOjRPoixX3o6gD7NS6l5sS4=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:Cc:
	 In-Reply-To:Content-Type; b=mjz1e5Dh8I9bmk5KAp8SkReoxWvArE86zgPpcM6+cuabb/Ps8T43k/ZMEB3Tb5EGptM9Mur24X+o4W9Wgb/MpH5+LnbLFnoj2148FzTheVc5nRRKCypLJn+BxY/NB7mI0lxxqGsQ1T5kjGfu7TzLyqnwQ3x6iizIwy+Bo/XoGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev-mail.net; spf=pass smtp.mailfrom=dev-mail.net; dkim=pass (2048-bit key) header.d=dev-mail.net header.i=@dev-mail.net header.b=r7GeW2zj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WHXmuHXa; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev-mail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev-mail.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7FAE27A021E;
	Tue, 15 Jul 2025 18:03:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Jul 2025 18:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev-mail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1752616994; x=1752703394; bh=jg8X7VDOB/Ufi1wHZnT5zMtrg5ie9mPOez9
	f1zmiJIs=; b=r7GeW2zjPTyjVe4IxNNGJTmChw4szhmiMmT0ZcoY0j7fdkPKN6Q
	Xyc1sRgWtGKZCN2pIAA8lTQtFnlvZ+io2LzfjxZi1cYAK3gac1awo7Ku9Jg6aA1i
	M6z5uBhmX+vvF7/f5Nwz0v3LsdIfXKxSZ1YgCPdKZCJ9TdLn1yK1LfZkXEClh3EQ
	TY5BKUKi+XzoD/viSdLcMrjCdgp2cQBytncOLappC+i4HoWPtgisK92w4sDoaKbH
	qYZiOtUt5I7N+rCWeuARM/WM1MKi2Ho9BGBKPCKKGXSDEYOmJavhgoFjp2X5Ij6i
	anbXlbNNbXezWCODGOjbtWkhEdAFja1RfZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752616994; x=
	1752703394; bh=jg8X7VDOB/Ufi1wHZnT5zMtrg5ie9mPOez9f1zmiJIs=; b=W
	HXmuHXaYuTkEIGdDYBrWLpWlfjH1HK5MNA7duzL0nSGAPP82kMt7QOnspF6g+J9t
	RcQhwsaJqi9Y84pmk7C1z/pq9QPeqFPmyXQ4XTdgkk+oq+JPClAXxnHANkrvNg/r
	duqGYxOIVKKxv1GSMMn3rtMq7ybA7tRRL51yzms7IAvLUzXXU/JzVSBCV3xX6RBi
	QN8S9WW8WU/rT2ZzZhNKim0f9D76cYU33aybyjmAY51YjT+wEKp6rOQLzaOWEtuc
	2YBJbbtyC8A2U29AYOcjz1/aiWoyUVR1ROY+/IaY7bgBtlTt9pJX3DUS+n7Lqijz
	WQp4T2srWLRt5mjMc4y9A==
X-ME-Sender: <xms:ItB2aFrhwDZLfKDIIJiLXKLrG8xCsgLxVKHi8D-47YKfU1n1Qn41zg>
    <xme:ItB2aH3F15mAoEVMs2mOwt7wESU9-PrihqzTOFaOyC7h_D-VulkV7DBWd0iec2RQ_
    ty1X-coUCZp9tF->
X-ME-Received: <xmr:ItB2aECtY_mH8XBt2gzMfn6JZumUO2jqPh_rN_bamjAzrxCrgQoz6W1iLq-dzV9Na84K7FXZiLc9NQ00LQkXrHoXk595eknzzfX9Fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepkfffgggfhffurhhfvfevjggtgfesthejre
    dttddvjeenucfhrhhomhepphhgnhguuceophhgnhguseguvghvqdhmrghilhdrnhgvtheq
    necuggftrfgrthhtvghrnhepteeukeejhffftefhtdetgfdvueegkeelkefhveejleejgf
    elgedtgfevhfdufeeunecuffhomhgrihhnpehrvgguhhgrthdrtghomhenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpghhnugesuggvvhdqmh
    grihhlrdhnvghtpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjphhoihhmsghovgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ItB2aPfB3t1_2irOyS1e94FF9QpoOHxbTrPGoB-3y8qe4Z7Fpu14yg>
    <xmx:ItB2aJhraDl7S_R9KR3RwWyP9zZnotgkK40ojDX7NdmqHgt_mjXxYA>
    <xmx:ItB2aHoS1R0dYCaXhNzWETJd5-IAin-HQm-YvOV6v5eOsRDXzI3Egg>
    <xmx:ItB2aJFxnKiIHyp66KYr3LMwXYgh9RPBSxoxnJhxqTQ54Ozodyryqw>
    <xmx:ItB2aD7g_KNPvCcZCd3NHSsVVugdoa7PbwvkAYRqy14I-Zo0X9nK_zXt>
Feedback-ID: if6e94526:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 18:03:13 -0400 (EDT)
Message-ID: <48ef184c-0160-4a50-aeb5-013e60fc7b40@dev-mail.net>
Date: Tue, 15 Jul 2025 18:03:13 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: pgnd <pgnd@dev-mail.net>
Subject: [REGRESSION]: fwd: regression in 6.15.5: KVM guest launch FAILSs with
 missing CPU feature error (sbpb, ibpb-brtype)
Reply-To: pgnd@dev-mail.net
References: <a34aef44-75e1-49d7-8210-5269542c1857@dev-mail.net>
Content-Language: en-US, es-ES
To: linux-kernel@vger.kernel.org
Cc: jpoimboe@kernel.org
In-Reply-To: <a34aef44-75e1-49d7-8210-5269542c1857@dev-mail.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(already submitted @ Fedora; cc'd to regressions@.
  advised to post to 'upstream' as well.
  not stable@, but here, i'm just told ...  my bad)

-------- Forwarded Message --------
Subject: regression in 6.15.5: KVM guest launch FAILSs with missing CPU feature error (sbpb, ibpb-brtype)
Date: Sun, 13 Jul 2025 17:37:57 -0400
From: pgnd <pgnd@dev-mail.net>
Reply-To: pgnd@dev-mail.net
To: kernel@lists.fedoraproject.org

i'm seeing a regression on Fedora 42 kernel 6.15.4 -> 6.15.5 on AMD Ryzen 5 5600G host (x86_64)

kvm guests that launch ok under kernels 6.15.[3,4] fail with the following error when attempting to autostart under 6.15.5:

	internal error: Failed to autostart VM: operation failed: guest CPU doesn't match specification: missing features: sbpb,ibpb-brtype

no changes made to libvirt, qemu, or VM defs between kernel versions.
re-booting to old kernel versions restores expected behavior.

maybe related (?) to recent changes in AMD CPU feature exposure / mitigation handling in kernel 6.15.5?

i've opened a bug:

	https://bugzilla.redhat.com/show_bug.cgi?id=2379784




