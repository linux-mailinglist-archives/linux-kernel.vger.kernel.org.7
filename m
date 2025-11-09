Return-Path: <linux-kernel+bounces-892023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BDEC441C5
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 17:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88F514E3932
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 16:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55062FFDDB;
	Sun,  9 Nov 2025 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-tao.eu header.i=@bit-tao.eu header.b="pJpXoV1e"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D972D595A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704191; cv=none; b=eg9Ek+4sPrTAPAOFSG2K+oAMgfR9rvf80Az4y1EKsrR5iuUDdBLNTuu2QkMAixCU1eQew3QB1CxnNOcf0WcIPOLnXaCwGqpV/2fvSQiqb+8M9VeaE+AlMfCd8V9sagGAt/oyxA87dX4y93SCIwmGdd2kMQWQXE7sVo3EfFl5U6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704191; c=relaxed/simple;
	bh=jPmpAy9yFmL2kjfURqiwFiWeuzLkhZ+9NfN9Z2Tau0w=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Y/FjBSgng9B046NTJFsffeQVbUWvUXSOyKOIcS/Ay0ObJki5HSqHAko5BddYqCZqhPn0QvEEXqa+dMWWw1pBjY+3vNK0Jej0sGWwQ6oOvgz3QIJ+YUW2aNpVST57SikQAZKL44c/39SH3yuEIwg4Fpqt4gJ1koGV0BkF3/u8AGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-tao.eu; spf=pass smtp.mailfrom=bit-tao.eu; dkim=pass (2048-bit key) header.d=bit-tao.eu header.i=@bit-tao.eu header.b=pJpXoV1e; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-tao.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-tao.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-tao.eu;
	s=ds202510; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jPmpAy9yFmL2kjfURqiwFiWeuzLkhZ+9NfN9Z2Tau0w=; b=pJpXoV1e4QwFEIgdbyNbTLyhUQ
	ZM9yrXHoqAhNEbuEu7+r+iipWX82UsWhkFnv76HNXTt9oYWSmaGLEIWawn31jXodJco87vHyokqd/
	dPpnqFe10oqVcLv7GIgc/vW8bmTeotlL0DvAXYPaBUGinx7wFzRy4pCPE7BQhcqCbkwikl3xy3G3N
	4unN2Ujut8CmYBTptSppTrYVfZsbY/7l0KWtMOe82e22pETB+JFwCxQ39avvSVfhE2zfAGXIoQX0g
	9g3HU2wjW3i/XmQ0+WxqyAIxs26nPz54NQCkSVDCs4Hld94iCXx42bJ1cuDLe7R5KSSmI6VtQ/KX5
	5VNe1a7g==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1vI7sc-008tpq-G0
	for linux-kernel@vger.kernel.org;
	Sun, 09 Nov 2025 17:03:02 +0100
Message-ID: <dc6802fd-b8df-4cd8-9651-34fb3109376b@bit-tao.eu>
Date: Sun, 9 Nov 2025 17:03:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <bishop@bit-tao.eu>
Subject: Isa vs Rust (was Fair Pay Philosophy, Unification in Bitstream
 System, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

There seems to be two major potential directions coming:

Isa vs Rust programming language.

Isa aims for Isa CPU, avoiding compilation. Rust seems to indicate not.

Linus will not be managing Rust code he says. That may mean Isa aswell.

Isa slots indicated optimality of this a long while ago and still is this.

I am with the Isa branch, and encourage so. (C really is Isa right.)

Light!
Ywe,
Bishop,
Bit Bros. (correct Gnu Gits)
https://bit-tao.eu/



