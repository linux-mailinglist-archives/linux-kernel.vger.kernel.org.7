Return-Path: <linux-kernel+bounces-805919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8114B48F51
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F61216BA18
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C79B30AD06;
	Mon,  8 Sep 2025 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="OcwfbR0r"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA054A06;
	Mon,  8 Sep 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337792; cv=none; b=XvOvyFEHMZZsm7DxXKhpsMOHlwwIxbYSZXdEwZKZEX4lhNAtklrVsSKe6kBzYrLBk7emh/ZSrg7MmDPxkwJd4RN98zE8DOAvm0bdHKn+7YcBXOLdugj50UpmLiFVvMagBuDU1jCH5i5iGyxqOblwTPGHXzzUtPOvSHJrko1I6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337792; c=relaxed/simple;
	bh=jE0T/fmVHyiTTnqmMQr0pMsurg8GrSTzaCZsztr/3Cc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=liXOvEJiV+pm5k5FkEyfk2C9TjdiSggEJFhnRUDgcMcqrpwJ9Xt7OVyE5ty8aBZ3wlfg1FV5fUSJPi/gWEyj4YKV/QhfCKmwRBcEgUgE3b8PRjnU1fS+zTxljtOxMUpJeXvphs+/Lndv/8awqKnspr1O5HKzEz2SUSAqF1rxHPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=OcwfbR0r; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4ED5440506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757337790; bh=jE0T/fmVHyiTTnqmMQr0pMsurg8GrSTzaCZsztr/3Cc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OcwfbR0rby34GzfIxaov168IheTrZ+ikAV3382xRCrGMWfTAjdqQXDm0IkI+U74cI
	 vk465Qd6Lu3MfdA8wLw9iIjKnB/5tMtlds2arjrrdEajdYy9raICA0VexG3g7GOELm
	 /ORjRT8Is7SBQNrMvVYte2jM2Q8AtUUnGKGtxf82MfuYtXvnwwxw9cuecSPwFsaAUK
	 yLr75Sfsx+wQ+QW7X2wAeup6ugtw6Acc7AQNvEwtpEGCusrkrBb2jVHXelS9K2dUfA
	 bi+uS/sTiKw7s4XJ2SZM+yG6L60yW9s7cR4D2f9DpSkLgvN6CaAoDsP/E5XpEFMhm/
	 a4nGwUYlIEMxQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4ED5440506;
	Mon,  8 Sep 2025 13:23:10 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: hariconscious@gmail.com
Cc: catalin.marinas@arm.com, hariconscious@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, shuah@kernel.org, will@kernel.org
Subject: Re:
In-Reply-To: <20250908095450.42929-1-hariconscious@gmail.com>
References: <871pp8a9ze.fsf@trenco.lwn.net>
 <20250908095450.42929-1-hariconscious@gmail.com>
Date: Mon, 08 Sep 2025 07:23:09 -0600
Message-ID: <875xdtyt6q.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

hariconscious@gmail.com writes:

> Thanks for the suggestion, will correct and send the patch again.
> And my real name is "HariKrishna" and see that it is mentioned in Signed-off-by tag.
> Do I need to add surname as well ? Please let me know.

Yes, signoffs should give your full name.

Thanks,

jon

