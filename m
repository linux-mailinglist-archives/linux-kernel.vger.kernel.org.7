Return-Path: <linux-kernel+bounces-881756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A4C28DD0
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 12:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E43C4E282B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 11:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A4B1E51EA;
	Sun,  2 Nov 2025 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JbsOBmfR"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3ED34D394
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762081394; cv=none; b=N4beS59JgBtFXYkVTbU30YUlzOlNjEwf+HwhBTZV2Yq20C4m3x87NY0s2Ht0vL4f425DcjSG2cGtyPFl2i3qfysDEkkVPKBGdrV+SrxtklzHU8Vxbxo+YRxtpO2qfdT4DblpT8mf2p2kPXdydVEmyVIUk05hDkxDsLWHXqI7c2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762081394; c=relaxed/simple;
	bh=g7d4ONTP72Eap44bI89033fV3APaD07Gd2SdEM3MoEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXNo7k5fDyxlHeFMwHpHd8ybCAAAeIiGuADqiIuxLFUJS3qTwON/Dz+o2jTPcZNagWf1w01YNbATsWm9mKl8+xBP+SfnJ7HH2mmb9D5Zlx9EwxHflOHlR15fvrpHW9uacKxb7UyBwbs/b8RQwdxRK3vkcyPppkqMSI1nzCVdvvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JbsOBmfR; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1762081390;
	bh=g7d4ONTP72Eap44bI89033fV3APaD07Gd2SdEM3MoEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbsOBmfRzxYhYcv5VR9mTSlmmuxIE9EdPbVxrKB1JO2mfu+Uriu1Yo21uHVlGHz5P
	 60cCOOkz1d6Sa1gEuLFELZue8CWN2IDCD1G8+756QiEhR9wURpo4trGZpF3Y4n7HT6
	 Mx/GYqtkdO0jsvKQvkr9riKyhDVzbJjfFg+pPCJw=
Date: Sun, 2 Nov 2025 12:03:08 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tools/nolibc: fix misleading help message
 regarding installation path
Message-ID: <a7b58ef5-7452-4751-90e3-c9fb637d7897@t-8ch.de>
References: <20251102104611.24454-1-w@1wt.eu>
 <20251102104611.24454-2-w@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102104611.24454-2-w@1wt.eu>

On 2025-11-02 11:46:08+0100, Willy Tarreau wrote:
> The help message says the headers are going to be installed into
> tools/include/nolibc but this is only the default if $OUTPUT is not set,
> so better clarify this (the current value of $OUTPUT is already shown).
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Applied.

