Return-Path: <linux-kernel+bounces-831291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9504B9C4A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93EAD2E2EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BBE2877E2;
	Wed, 24 Sep 2025 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="MJzCc31p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ih/yVxHh"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D28F15D1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758750121; cv=none; b=bmcKZgxOcATI2FLfb/VfKrWu5rZQJjOpis4uUn0VYXz6UVPEA4AcynAsk9xwKeJEa8XFZ63H1N1vxqVGV2T2SS/IeROJWosMeKfi0Gspkozcp1E9eJaZJxB1M3tVTPDQvK6B9CtBWOINkOzMkat3FR2QAna/Ef83cNKx+LPXRL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758750121; c=relaxed/simple;
	bh=2ehXYzc97WyICXv7CyLrgbg10pZOL4YT397boIJDc28=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HPtC4ATVfnNWoFhP5dpcpmxaq1LKccX9fRyyWKQN5QERZ6LHqDQUXkXa4lq6S7JSNDPR+yybRFjQQw6wuETH4AzfNqBsPbApDz7eiBCwPyDuUdvQI91dZuXlJAOyfJnd867uXLOhtLDyulA5JS4ausTgD0QOE6rWHXrQYhuyrLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=MJzCc31p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ih/yVxHh; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C229FEC0166;
	Wed, 24 Sep 2025 17:41:58 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 24 Sep 2025 17:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758750118;
	 x=1758836518; bh=eV9m1lbbNAGh6h3l1sH9V9DqLA0qIHvnUDzEmR+6feU=; b=
	MJzCc31pfP6WqYiHGZRDNwdiGIv61wBAFzdRCll0clFjAu6u+AFHfTgyQ0L9ditT
	shy4TzaGKqX7cz3VKPOGm+RLn91UfRoMbyy+8LxNz361cqA71vBGSScMlrFc5W7P
	D4sW7SgY1IHsE75YpSsabCcDmspHxqBXIowrpp4iJYN6GwiX3dj/jqsmQnEttMMh
	M7NnOpj8ozEBfCcZiy7b6e46lL+QVAE03fHTUPh4q6QP0dIYMMw+n3dcn5Qdmaso
	XjK60u2TWXFrlakQR6TmPOI58Uc2rxCHUhRtvdCReNqQ84fpN77aysgr9wNUS569
	h3JpQKHJ/CVzZGPrOU0Ypg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758750118; x=
	1758836518; bh=eV9m1lbbNAGh6h3l1sH9V9DqLA0qIHvnUDzEmR+6feU=; b=I
	h/yVxHh6EZOciVQB+SokLGJkDt4QvGdJ1qJsYD5wY3tRSxUz+M0mFNH6f5K7oq+E
	lv+3uuF2iLIwhyzsdkGdfIQqmODQHPjUh7tzPdrIumDlHo7J0/HZLhAt4t1PKbDY
	HhV2FzcgmaAPVoYJl4xFAMKsnO7PQ3cXp3KvMHyTIul1K2027AsMqUzvajKd8BFx
	9EBPNeJ89c3WBzzDAtcfpN3ITZMWSzpdeuUphvCg4HKiqKzvwzf0g/LFwxl0a4Kr
	6eQKWYzViXjc/bx6I/kAaW+JTBHeF8MksCy0K54axPgzYMsRtWjAFswmC4oHPknq
	FQdOy3GNCb/ltkIz6c4rA==
X-ME-Sender: <xms:pmXUaABkbcetRg8_mL63nPWzJ-GCGc0aflloz3E-iIvuzyImhEFFhQ>
    <xme:pmXUaNVn-jyDrKmbBOURmorRs3SYgrJyMzVCxTsiiWOIzSecDq33YYz9FUg9e4bmg
    hA4s6sM4kqNZfz1Lo8UKBu3kFW2DCiSPsTK_AYzKNSfvWLCzaBeO2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopeguuhhjvgesughujhgvmhhihhgrnhhovhhitgdrgiihiidprhgtphhtth
    hopeguuhhjvghmihhhrghnohhvihgtfedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    lhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepshhotgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthho
    pegsrghlvghjkhesmhgrthhfhiiirdgtiidprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pmXUaIn0VCkiaeulDJrvkImm0TwOVGbsfy407f_dk99be99qoteJuw>
    <xmx:pmXUaKE4-SdrNlQp01E9yXmdS3eWU5SF0lYvb0dxHVnA1uGZlaRdXw>
    <xmx:pmXUaI6eraskte5Nqh-p786Q_W4FHrR-sWkkaMF2hwIZwrwQP_OC5A>
    <xmx:pmXUaKmE9_IwYZEN1N1pi2kUzRDcOi2Y2J22ZczgDb6myy_J_9N_fQ>
    <xmx:pmXUaMmQ8JIt9Lzebn8H0vliZ4m6aGvM2sI2mhyoX_rVD8CHd6Mv7U-m>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 23A7B700065; Wed, 24 Sep 2025 17:41:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2mPhEQg0_sB
Date: Wed, 24 Sep 2025 23:41:17 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>,
 soc@lists.linux.dev
Cc: "Karel Balej" <balejk@matfyz.cz>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Message-Id: <c0516d21-16c4-4101-9d9f-a679f7459ef5@app.fastmail.com>
In-Reply-To: <4685744.LvFx2qVVIh@radijator>
References: <4685744.LvFx2qVVIh@radijator>
Subject: Re: [GIT PULL] PXA1908 DT changes for 6.18
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025, at 18:52, Duje Mihanovi=C4=87 wrote:
> Hi SoC maintainers,
>
> Here's the first batch of PXA1908 DT changes for 6.18.
>
> The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a=
25c6c:
>
>   Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

Hi Duje,

It's really late since there are only a few days left before
the merge window, and you unfortunately based this on -rc5.
Since my branch is based on -rc4, merging your contents would
backmerge all of the upstream changes and somewhat mess up
the git history, which I try to avoid.

If you can send an updated pull request based on -rc1, I'll
try to do find the time to merge that, otherwise please
rebase on 6.18-rc1 once that is out.

    Arnd

