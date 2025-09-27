Return-Path: <linux-kernel+bounces-834958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB73BA5E92
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552C31B22603
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F762DF14F;
	Sat, 27 Sep 2025 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bf-el.eu header.i=@bf-el.eu header.b="HB7CkMwz"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8062253A0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758974157; cv=none; b=G0zzVQvUD7OXKoDMJGjOmF+FUdkmVqtwHs6edg9tTWyqwjh0puZRhUFqEmtL6ckN2SI9OGHuxhIwNcJ9959iyd6Xqaf4haMod0kzqggA4N74Vbf6LgcptEnDymy5tj3MdaqBj7zaWlZRg0VRamYtcfPN6knmQtK9XyQeHyAPKUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758974157; c=relaxed/simple;
	bh=73logTpoCg2++JHO11uErtDVwxZNceOIveY72apYKyo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=G+SOqNLZKKdE3RFNhDbJ6RqWsBNoHvWXWOIhIU92S7vJrvI9CHbGR6jvC+HWcvmkKffxrodxlEtoOyYMNT066aroqbRbmHpk952K0LPGJb4fg/m/ys1ItfJBXu6OOMJapG9pN6h/FiqS9oBSUHgFBO3BfupStPOvEWvu10+I1l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bf-el.eu; spf=pass smtp.mailfrom=bf-el.eu; dkim=pass (2048-bit key) header.d=bf-el.eu header.i=@bf-el.eu header.b=HB7CkMwz; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bf-el.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bf-el.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bf-el.eu;
	s=ds202509; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B18/uLVT0hCMAEoH0ZOZ54Krld3futrf8kSoQu+0/Uo=; b=HB7CkMwzXPYeVul+L1gghnio0L
	XzM0wG4vTjmrnbM5AQLTe6ynwxWnAb50h+aaUICLvOg3+Kj6c8jucGG1HgddblE0PvCxtSoTtdZfm
	y1tA6ognc1OepEcD6VY3H9slUvPwJi5qTeiEWdbikYvuKPHeIMRJP0IE12b0e1Q6ylnzFjoatWnVj
	/LIOEFA/GhCpfAye6uBR4L+FsnkRxnLG7AdK3mfD6TYoQ44RibgnOzHlG324jsfUK1Q7FOWY4gsvE
	bQUrrae+NUg2TjtjfEfcFvhAok0uekREMT/ZscI36LDXwhtKjZYK5D5BMPuly7zDClC24Bs3El9sg
	fDfgeD7w==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1v2TWm-00HUb6-En
	for linux-kernel@vger.kernel.org;
	Sat, 27 Sep 2025 13:55:48 +0200
Message-ID: <d2f5fd5f-d5b4-465a-b304-00d7418052e1@bf-el.eu>
Date: Sat, 27 Sep 2025 13:55:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <budi@bf-el.eu>
Subject: Bit-Lut Icon + (was Unification in Bitstreams OS, Fair Pay
 Philosophy, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I named the icon, Bit-Lut Icon. It is very descriptive, and 
symbol/letter correct in ABC script.

Linus has been a bit of a creep to some, and for this is unrecommended 
to deal with, as indeed many agree with. I have already suggested BF 
Kernel branch, due to "failure" symbols such as Rust and Datalice etc. 
(One is reminded how the "Amiga" was the "girlfriend" in olden days, a 
similar odd thing, maybe that will be in the "linux" version too, along 
with datalice?)

Do not worry, it was based on me all the time and my concept, Bit-Lut. 
(BCPL, Open Sourcing Unix, Linux, Benedict, Git etc.)

A good OS is according to Bit-Lut. As a Budi I only accept this, and the 
rest will be phased out.

Light!








