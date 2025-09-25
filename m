Return-Path: <linux-kernel+bounces-832936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1907BA0CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB1F3BB3BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D302F30AAC6;
	Thu, 25 Sep 2025 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hpY9oTfl"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F653125A0;
	Thu, 25 Sep 2025 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820644; cv=none; b=TGkqCr3DxC3r4NiGS7jktC4qyEpcCONeLwmn2b1Dat8HZVr/hm8OL/IkrZzTFHDBD6tBnRSpotT7uLwU7TjZuzn2ZrVAWZyAHCTQ5VDt6bqoNklCT9DGyZwtxkdq26eInji8ZIieYn/VzgXLJD2k6lfceww+xU5ylC/dFLNyf5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820644; c=relaxed/simple;
	bh=b4VzpwgralNUi9L9scHLC0NDtEXl9WZxkYIr9fqv5/I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lUNZrq7HjaevQgp6CDQTxSb46tvwqIUPN6zcIg6vzaaPTP4eyFVeQhllglvcp3xjj7rSjRZDGZpMdSLbhqT7WAMuxKFh7s/UJdMTpP90ka6+bFbBAmzu884n61veRJrnZV2ZSwTyVrFPWrLErSvUxy38Qnlg9SBbfX2nb3HkXRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hpY9oTfl; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 98F47406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758820637; bh=8HHf4Rzw9zLqO7udTqH4NNNLYhKD9oSRMuyK6w7UafU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hpY9oTflKeB6ex3w6SyrC6mrJ8IR0ulyNydw8SXXD27o3jVykPFWCb3FZC7XHPf30
	 60ljUEPq5vwxGM5/BT8V66cAfzHuF0TpZuuOAtP9T5cb4zItRLKXuE06IKt+ItnuqS
	 itlute/klXgPvoJZtNHCkx4A2yY8o+N70YzhC+B7RDHh5kUrKI4gRKNZk/btahXAPU
	 enbCvHgGNErGdlg5RKWUF7SGVctfieBeqRKuWAxqYcXmMi+h6FV2csuVbpOset3djN
	 z3hoyUWL6Ez5kLSrbR8oAi+osB8oskQn1B+9YZxGwxJzsUCi33IYrjFqEGjQ7JYC+M
	 2RMmCzMBu87Vw==
Received: from localhost (mi-18-37-83.service.infuturo.it [151.18.37.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 98F47406FA;
	Thu, 25 Sep 2025 17:17:16 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, Randy Dunlap
 <rdunlap@infradead.org>, Mark Brown <mchehab+huawei@kernel.org>, Akira
 Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 0/3] fixes/improvements for top of docs/build-script
In-Reply-To: <cover.1758539031.git.mchehab+huawei@kernel.org>
References: <cover.1758539031.git.mchehab+huawei@kernel.org>
Date: Thu, 25 Sep 2025 11:17:12 -0600
Message-ID: <87v7l6310n.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon,
>
> This series contain the 3 patches against build-script I sent in
> separate:
>
> - patch 1 solves a problem with Tumbleweed build. I opted to be verbose 
>   at the comments to properly describe what we're addressing and why;
> - patch 2 solves an issue that sometimes happen on my machine while checking
>   for CONFIG_RUST=y;
> - patch 3 contains a request from Akira to allow running just the PDF
>   step when pdfdocs target is selected.

OK, I've applied this set to the build-script branch.

Thanks,

jon

