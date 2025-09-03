Return-Path: <linux-kernel+bounces-798743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD14B4225E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4A73A8D9F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40A930148D;
	Wed,  3 Sep 2025 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="IWNw8XWw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SOOInbE5"
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5064C17BD6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907255; cv=none; b=RKjnE2hcFa7iz7JPlD3o728yUEsAhH7wUY6qc2Uvh7NZ68Wl217coCNUg9jp298V9z7iacvQUKnRPtea6VTsz31QiJnOBnR77fBDt1Za9YAqxILjXVVDU23mzBI5N49ddWISCaGIDo1A3MhMbTV252H/uVSraBTAN2dbldFvvmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907255; c=relaxed/simple;
	bh=cf5WfLqC5yDQiJux02XLazqN1A8EU3mDFhAaFl3ZMD4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZy7Swp7XRHhX0pLzPpP8mxvIKeLZ2nrIf5E3zVY5HFDbvT4Ps72rjCy4E7v+Mgb3MlnIuBupjMZk82hjMsy/gx373mjEB8c07l2tOtARzXRU8/F182EGgjPsc5+zrer8hf7Xo36o+ytEwf6FYc2eEFxhQIkMsKuHRCQVhgzLgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=IWNw8XWw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SOOInbE5; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 554EFEC0342;
	Wed,  3 Sep 2025 09:47:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 03 Sep 2025 09:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756907252; x=1756993652; bh=cf5WfLqC5y
	DQiJux02XLazqN1A8EU3mDFhAaFl3ZMD4=; b=IWNw8XWw5oMCoUUV51zqe5MzWH
	UqrIo9RLrnu8FCgACEpKK9GEXAtCuxzArwhsCwGxJ2zyPMj+FPmGQIxC9DC6H6rR
	7E56EN0mMAT2xVU2QcZka8FL2gXyG5lICE5OAJAxcQYJU7EtyQkTNXTaRK9DQmo1
	fnCow4KomjmLB9feXOzHj/EB4IEBP4I/E8vfi/U19tfoTukDQUIVROMec/5MTt2t
	Um72puEnQipnm0b7ECvtlPywM0ItBAbX5buboDqBcmhi/E8GFcp2Ev5yZJBZ1RUs
	T1KXqx19+PTlDmjdg0EG964oRTAMjrMehWG621ygEvXFqTBzRGI3N/yYGldQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756907252; x=1756993652; bh=cf5WfLqC5yDQiJux02XLazqN1A8EU3mDFhA
	aFl3ZMD4=; b=SOOInbE5BsCCoggsDPSA8iur0/AT2R4+9i1L/oXFW3WJok9ExUw
	VYVEbzB6+fUhRgitHXzIpDaRFpL9mw3Gsi4oWGbGbbWETYLxNr8Ct01OTXDJYL0t
	tYdiUTKtKCe3e/oT9oMeUH6IX0VMDvr+j4aBXWAu0urKOu33IEZqho5UCD7dt4zt
	+EZY470KYdiuysXwfyyn2lDIIoewW3oWWr07QM+/WY8q9sJ0uf9Q83J3gyOjtKjr
	NX5DKoaeEFITr1KLA2KDaAh/rPszqXqFwDJg1FSxHs4/QbK+1tx3NDn6XMeMJOTQ
	tBOCz1gUR9Kig1AsqjT0uOFLaAzBgGdjeDA==
X-ME-Sender: <xms:80a4aE0wKPtMW-EKzV3YzICla78VQfGxfRaDcdDuOAJF1lwQsjvGew>
    <xme:80a4aIj0vgXexrgp7WC3JSPVvlX_QJPBlxTaSMZ9z2cWJmjMzZRqmQ_OmJOJfef9b
    stZQqRZSiUsl_Pb_MI>
X-ME-Received: <xmr:80a4aMeb9q0T-S_dMbLT0kpNgb0sUrfcMRu8Ty1DazP2pDQm8z_Nqf02EcA_gvCEBhTgnvNH_D5EMc6fIrLZ2JM6AhDHP2Y6aGk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeffedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvd
    enucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihes
    shgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepgffgieehkeeuhfehud
    euieelteffveegueeikeefgeefgfetvdevtefgtdeguedunecuffhomhgrihhnpehgihht
    hhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhi
    rdhjphdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epmhhishhtvghrmhhiughisehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidu
    feelgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvthdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:9Ea4aDkxVFd4UBV_WwECFetIe0UrSwfUC5Lnb_H6pRYuzHcFAkGgrA>
    <xmx:9Ea4aNsRy7ysPzImVsbaryWRfJWU9J5OGTtu9CNKz-n1aof84m7_6g>
    <xmx:9Ea4aB_vd9empdOE9moeN0qLOZlALhsemia37G6bESl3lqUXlUX9VQ>
    <xmx:9Ea4aHPUG1fkqGxRgCbBt0TNiXZ-vXQJD4Rd3-M1bLPfc4-I1A2BxQ>
    <xmx:9Ea4aBsqiHwk2BMHRzZ2vssOR19-4he7FyALQtbzxqU4MMJ9XuDHVKcd>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 09:47:30 -0400 (EDT)
Date: Wed, 3 Sep 2025 22:47:28 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Aleksandr Shabelnikov <mistermidi@gmail.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] firewire: core: bound traversal stack in
 read_config_rom()
Message-ID: <20250903134728.GA134568@workstation.local>
Mail-Followup-To: Aleksandr Shabelnikov <mistermidi@gmail.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
References: <20250902092745.8326-1-mistermidi@gmail.com>
 <20250903132048.GA77442@workstation.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903132048.GA77442@workstation.local>

On Wed, Sep 03, 2025 at 10:20:48PM +0900, Takashi Sakamoto wrote:
> Contributions to this subsystem may not provide a strong advantage to
> your career as a software engineer. However, knowledge and experience
> with the KUnit framework will certainly be valuable and beneficial. If
> you are still motivated, I encourage you to give it a try.

My collection of configuration ROM would be helpful to see the actual
content. They includes the ones from some music instruments:

* https://github.com/takaswie/am-config-roms/

When parsing the content, 'config-rom-pretty-printer' would be also
helpful, however I note that it has no support for "Extended_ROM entry"
in clause 7.7.18 of IEEE 1212:

https://git.kernel.org/pub/scm/utils/ieee1394/linux-firewire-utils.git/


Regards

Takashi Sakamoto

