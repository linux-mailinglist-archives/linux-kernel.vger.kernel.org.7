Return-Path: <linux-kernel+bounces-774086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7B7B2AE77
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2443B2A7D73
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48F8341ABA;
	Mon, 18 Aug 2025 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XIQkQvTe"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE739261B99;
	Mon, 18 Aug 2025 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535469; cv=none; b=PCU5q/k6dnb/GSfeMRMMfKWc+ggMqSe2CED5eri7da16zeZRcracV7B0/WRp01tTenGN/9cOeqw5XYYJQPVPdEiHz6WqTQNpCcKoL9YIyZsI7kJNJUgsUpwjdHYB7cuxMxvemdTz52jm3CfwKb4qbZfJidGzpUUeCNm+JRB+Rxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535469; c=relaxed/simple;
	bh=mAu53RQa1p4mwxImYjTqIgP/UIrdc4uU5KnAdcoHk/I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PTmvcH4NiGv2GVHpgGkBpVZ29DQ0nefqpARqxgZJYcMgzBsd1+MPjWTclkeQjvv7ZWWjU2XHvjkBPxF0z3jBUMM1abqvSWaTdIrPUbazpYe7iNNE7tA0agOHrysJJ/CSva81RhrVzH6Pqvmt8XGTswwHIFcRZC85cl38EnERfeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XIQkQvTe; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 06ECD40AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755535467; bh=uZM+ty5L6QX52OSYlv92YVmvHeMNoqJ5c9r7mKCeJaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XIQkQvTer66IgtoLqikVHYiFfqFj6AcIS0LW+kn0kEKf0IPrnYNZxMTn8bwDjLIbP
	 AnFQ2tbLrJ540lDAe5qi9kG9J/4MkgEAy71Y9KJtpWSE8iZFESebvRMtv21mRCKJK3
	 7WWtPBKohrONzeMSA057Hv2p/q2lZ0Ox8YFD0HkTn9AJvOsdCJBj/aCr04lrRz6rqV
	 gIAl0WZqutqUYZryhpnfUgNoUD1Qv3QS9EC/wGq6osvd464B9B1LyjOwfelqK7F9ta
	 0NZ1yjV7iz8O5suwQGzwI5Nn3HqP5VnkJXyeC15M4JyE49ExlHWzEoUR8UDMjmGziO
	 hyH0xQEKFLhzg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 06ECD40AB4;
	Mon, 18 Aug 2025 16:44:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/9] Documentation: Fix typos
In-Reply-To: <20250813200526.290420-1-helgaas@kernel.org>
References: <20250813200526.290420-1-helgaas@kernel.org>
Date: Mon, 18 Aug 2025 10:44:26 -0600
Message-ID: <87frdo8tqt.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bjorn Helgaas <helgaas@kernel.org> writes:

> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Fix typos in Documentation/.  Based on v6.17-rc1.
>
> "git log -p --word-diff" or similar might make this easier to review.
>
> Feel free drop any conflicts; nothing here touches code or messages.
>
> Bjorn Helgaas (9):
>   Documentation: Fix PCI typos
>   Documentation: Fix RCU typos
>   Documentation: Fix admin-guide typos
>   Documentation: Fix core-api typos
>   Documentation: Fix filesystems typos
>   Documentation: Fix networking typos
>   Documentation: Fix power typos
>   Documentation: Fix trace typos
>   Documentation: Fix misc typos

That last patch conflicts with linux-next, so I've dropped it; the rest
are applied.

Thanks,

jon

