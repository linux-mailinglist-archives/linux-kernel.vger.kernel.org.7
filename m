Return-Path: <linux-kernel+bounces-859518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D86BEDE22
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 06:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD993E8281
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 04:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91C01E2858;
	Sun, 19 Oct 2025 04:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-teism.eu header.i=@bit-teism.eu header.b="QHnGPW8c"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC10DC8FE
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 04:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760848155; cv=none; b=mcuS6nbxkPYlZxx2BHcxtHqa2MMijgkOQZGalOmIAS5iuFNWRvi7K5Oo/rTYjDJBjfsu3NiLRvby2qASBwya8z7xINgdMub2XdA8DRV6U0u0QQx5nJUzmedu4ki1abbfWdpTvaXbC73pBky36YUWeFvFMO69fKRgv9rhCGIBuoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760848155; c=relaxed/simple;
	bh=OyCRfFZBfLQqRFqA6IKc9ZpY1xwIDpl6ykvD9lwM378=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=T+3u9LAZtpYd57W07TzjUkVQs1DTcQ9mrhMHNwCwTr9OigyS6qbOJr7vOkS3Rtw03GwOBZ7agPD+HsBjDLRKVn9bKQAIhj9jjCECdB1DH44r+vu+UIslS8fh78erED0Dla3CyfrlbGNqDXMNAJVHbgD35Lv5V8rGRJb8nTIfSP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-teism.eu; spf=pass smtp.mailfrom=bit-teism.eu; dkim=pass (2048-bit key) header.d=bit-teism.eu header.i=@bit-teism.eu header.b=QHnGPW8c; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-teism.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-teism.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bit-teism.eu; s=ds202510; h=Content-Transfer-Encoding:Content-Type:Subject:
	From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jNgBL3gQkZg6PNJ4Fv41NDe1FH4u8puDnXJe7vhGxtU=; b=QHnGPW8cOe3vxvDIL4YMsfIoTh
	8jBZoDX+sunu1qFy8XgmEVJSmQBP+hqFS932pdh9ZtCkaPOHLi7TJeiao6L5AhWBW6GuKi8PFua3f
	POzL4XiuHtBJRemjFnSyePgOZz48VwVUuG6be5y1Ci9C42yq0JjJdPHYLetlZ5qHMSdDLYtyTVPDb
	H2eMvGgYqGG8rGTL6beuREny5oiE/W1QPzG9O4oWlbTcrXPsFMD78xzFKVtBBjXFdp7rPylkNt1gm
	5vjG977YGefk52UMQtXQoKft3vx/cXNr1dW5BPqpB1NVj/WIBKZWncoDY5ZCqJCwFpLqG+bkKVOpX
	j+ZRYevA==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1vAL2Y-00ChVV-8v
	for linux-kernel@vger.kernel.org;
	Sun, 19 Oct 2025 06:29:06 +0200
Message-ID: <11919610-7c25-44dd-8bf0-65acedfd9a26@bit-teism.eu>
Date: Sun, 19 Oct 2025 06:29:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <budi@bit-teism.eu>
Subject: Idol Autist (was Unification in Bitstreams System, Fair Pay Teism,
 Low-Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

In hindsight I see the idol was Autist. Really wanting to be like "Ishtar".

I made a little playlist on it: 
https://www.youtube.com/playlist?list=PLC_UaRIv9A25B5A6ep_nf3vugFgo3Tc-u

Light,
Ywe
https://bit-teism.eu/

