Return-Path: <linux-kernel+bounces-860348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C49EBEFF01
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F53A3E4CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE672EC08C;
	Mon, 20 Oct 2025 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-teism.eu header.i=@bit-teism.eu header.b="corPdZYQ"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70A2EBDD0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948736; cv=none; b=cIXz346XKRusAiX5KlTHzKN/oA5hc2LSWv2U9gxHryWAdbCYXgK18DIYGc76kTkUfky44ILyMU41HWmdHxw0clM1TzsKduVgQJjmZkWwUz9JJWLjQG7NJ0595URb604yW6CEfjwA5FIVC6W0qeYHr/XbH1HZCkYps2aCB5RNGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948736; c=relaxed/simple;
	bh=uovba8NHo3v/KDn8qixnjawg7C7j0iqWiXdXrhsyDDo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=b2vGzp0BxVV9UkRJT24gMdaWoMCWJKLf0jdgdxLS2w41eKWEgq0PQVESTHU1qtzxa5U2lS6GHfLiwrp1OgNLrlVK1TdSEdTzr/tgHiWBKr3zNWwoh6NmDyrexFNUE9Q+HMLT+nyGv3JTqmk8eh8qQagcdg7p8bV8SNIEPH7n4Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-teism.eu; spf=pass smtp.mailfrom=bit-teism.eu; dkim=pass (2048-bit key) header.d=bit-teism.eu header.i=@bit-teism.eu header.b=corPdZYQ; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-teism.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-teism.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bit-teism.eu; s=ds202510; h=Content-Transfer-Encoding:Content-Type:Subject:
	From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=meFf9LsFzoK+uSBrBHJCtquIZXhGUh7pihRgc7i5t4o=; b=corPdZYQx5Oq51m9R2aXNCDXIt
	H5lG0FYYKGlaWfLcOhSISe1ttVNpis3o7apJjrzhgSe0io54pqAwi5onBF6RTsIZRQYtk4M/3zIKp
	o/li15zXdnjpD1U9nRBu5Td1+MuCpUrU3td32Xf6LJLiI1ABWKKn1FyIfebtKquKv0N00i2GRAzIW
	aPNzwG6DB3iA6z6YkHNT+mH8h6OIHca0XrVJ70OARA0V2sqQc4l99wx4zCyj+wB9NbvtciBhfBnAy
	6w8LFm+HPTVE5i5rrpNdrbFvz1UX+lCEGujr9VeEQLp/DsK+fJ3aU7+ofOv2DNhhQlPMTX+0p+jiz
	5ymKK5dQ==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1vAlCo-000Mlr-Lp
	for linux-kernel@vger.kernel.org;
	Mon, 20 Oct 2025 10:25:26 +0200
Message-ID: <ccc57d56-b349-49d5-89df-5f3fff61b3df@bit-teism.eu>
Date: Mon, 20 Oct 2025 10:25:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <budi@bit-teism.eu>
Subject: Linus Side = Gnome/Git (was Unification in Bitstream System, Fair Pay
 Philosophy, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Looking back, the two big ones on Linus side is Gnome and Git. Couild be 
combined as Gnome IT, where "Gnomes" could work in stores if they wish. 
Would be a fun thing, probably getting a lot of attention and sales. A 
big point for the Gnome Desktop.

The other is mostly me. Wanting a tight inner loop, low-jitter oriented 
APIs, no bufferbloat etc.

The Bit Tao Icon is perfect for this. Bit Tao is also the philosophy and 
design guidelines in one.

LIGHT!
Ywe.





