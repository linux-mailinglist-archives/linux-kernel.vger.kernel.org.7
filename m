Return-Path: <linux-kernel+bounces-841070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54287BB6303
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 09:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0197619E8204
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 07:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761892475D0;
	Fri,  3 Oct 2025 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-teism.eu header.i=@bit-teism.eu header.b="PD7BSwKd"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ED31487F6
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759477231; cv=none; b=aQRDRktaobac43vZQEZMDvS0TC0jYRZ2h6sIz3N8/334GBPYxE3ocDgte/bm1Y0xv5imtfI+L3T261nzcqUiMcG14JQnGVhm7Et+1JRCTJVPjeYqRHVehuaewv017zZJZjdR7317RVdLHkleH5fSgS4kFNlK6hS2lKTqGH6/vgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759477231; c=relaxed/simple;
	bh=YNN/WRf3lVqOVJMSkuCIfjG4EcQkZZjGi2TqdQxCD+Q=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=JnpPMVtz35S/DlnfGGfU5BtafvBwshImp1BEXZc1/CO6yBJJrvXi8XF4BY+hSM/rRJMg++wUv/Awa9XHyWd6UUZTE1YhOq0z9d6gPTnD5e4/WO77E+KLF5S4Um1K7Hu051WiErn5sBOwYYYg1TyQz6OeGoWG6eq/4sOVWMsM94g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-teism.eu; spf=pass smtp.mailfrom=bit-teism.eu; dkim=pass (2048-bit key) header.d=bit-teism.eu header.i=@bit-teism.eu header.b=PD7BSwKd; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-teism.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-teism.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bit-teism.eu; s=ds202510; h=Content-Transfer-Encoding:Content-Type:Subject:
	From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YNN/WRf3lVqOVJMSkuCIfjG4EcQkZZjGi2TqdQxCD+Q=; b=PD7BSwKdIluHwSpuS+gKLKZvvo
	iWN86NBcBl3ncHBXu/MVrymf7RrpuP3nUAHNKMT6F3oIY32xy5Z7m8+ltjIbQkxRJJm+5v38uwZYB
	5OXqtMCqZU46iE+EssE+M4YKNaKzjRAk8J9f7xs8FBN7aNoZPydtNLqCAHau5nkgKcP2Y2foEezif
	CP08zLRH9Y1y2dlh4ZL1ESCdeABjwdf8V9yn0gomgwX9vZEz1nd624LEiSq/vj6a1v4UlqwvYYrgY
	fk0LAzifMRDvKmKucNKVK+S4qHaIX/9ZAFHWuGGdvSa6YCoP9Vq/YwuYeO/Hk65sAm0w53gZRwZ+H
	2pBOZkBg==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1v4aOs-00GGmO-4q
	for linux-kernel@vger.kernel.org;
	Fri, 03 Oct 2025 09:40:22 +0200
Message-ID: <ec5d008b-f39e-4f37-b580-3eca1b083cef@bit-teism.eu>
Date: Fri, 3 Oct 2025 09:40:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <budi@bit-teism.eu>
Subject: Listen to reason indeed, but not "one less"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Updated my email.

Listen to reason indeed, but not "one less" - url now bit-teism.

Ywe.


