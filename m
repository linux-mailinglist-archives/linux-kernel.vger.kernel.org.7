Return-Path: <linux-kernel+bounces-869582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F6DC083A7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 887964E6A67
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D1330C628;
	Fri, 24 Oct 2025 22:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-tao.eu header.i=@bit-tao.eu header.b="pQFDfYIN"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F30F1C7009
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761343936; cv=none; b=EDLxCHHq4gjnUfvGpJRztCaP7U/wFGI1UMXJjB0AU6u8MRcj1bWbVo+nuK+cHSRSIWlOCKBRorvLHNn12HB3fFA/D17XJEmkHTbfRI3W1Is/OL96p7CcnExokd2cEBAoweoVpmRg7UDzDVvlmFBldP5EzlLhPkTkOH0awX39TYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761343936; c=relaxed/simple;
	bh=C/eh8HQVrN0UF44fqwCffuaQpZeJ9ocqV2AfUO9bRuI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=GGplMFKAlspgrwpft1min9OVBGss4kTKxgmk5yg9ANQxF+Z8eI++DXEOra2KT00813qiefwuUQ8pH2FqGBWZovHxnq2KjocY1kAKGsd21d9CetOmC6oMzZ/WgHkv0QwoIkNTH5kZwsyJ5fsyE2JwakWsL5XvpyNi30RclQIaRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-tao.eu; spf=pass smtp.mailfrom=bit-tao.eu; dkim=pass (2048-bit key) header.d=bit-tao.eu header.i=@bit-tao.eu header.b=pQFDfYIN; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-tao.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-tao.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-tao.eu;
	s=ds202510; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m4j6B6yie6lHCKtZ4tw4ydBKP+XJNE0V9HHWdGoJaco=; b=pQFDfYINkFZd2QJkKPNA3Mu7Js
	axIfFnkhAp1pB4aIlvWHrPjURKQWie8ASxIz6++58cZK1lYN1XhfsXKclf4xmBPrAxV+R2vvT8/Sm
	Yt923khaJ2E5YvqXVhGu5QmVXwXCcIDAxDrxsBtK/pTXUgI1i4kBXI8Evxoz4SipDxI2vopHuum8d
	R7DQQBpfgvjw4gvukyZ2A5524Vx2uI9yNcDnU7Vi2fJ418t+IIDUCqmi/tYPG/BzFJqEHtpr9SWo1
	QwhG2AwB7rGKZ/yw0Wxes23TdBehdH3QpL0xNkoDUnZr/Sy3/t26anmU22oYhKzCk4hjWlxPZjVA/
	0Mm2aHug==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1vCQ0z-00DQo1-UX
	for linux-kernel@vger.kernel.org;
	Sat, 25 Oct 2025 00:12:06 +0200
Message-ID: <9f14e6af-16e7-453f-ae71-6bcf6425d1b4@bit-tao.eu>
Date: Sat, 25 Oct 2025 00:12:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <budi@bit-tao.eu>
Subject: Re: x86/csum: Remove unnecessary odd handling
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Xcuse me, but isn´t it time people show skill in highlevel languages 
running like low-level, instead of the LDA/STA MOV joystick thing.

3 letter abbrev "God" thing. Some people complain much about "God" but 
do nothing about it!?

My annoyed input.




