Return-Path: <linux-kernel+bounces-761157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EBFB1F50C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 17:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC513B1C6F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF6727FD7D;
	Sat,  9 Aug 2025 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="PGegFFGM"
Received: from panther.cherry.relay.mailchannels.net (panther.cherry.relay.mailchannels.net [23.83.223.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D02017BBF
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.223.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754751751; cv=fail; b=H3cfZ9RKjQtKb1BoHYxWRlMvbsrH66IiZ6vh9DBqzMjXwdJAiNRbvQ/kgtQxBYHg1xqIB/N5kTLVRqfdV2fD6bPlfnde2HffMYlt00M4CrIBhWTUW+GtCuLGcyHaoL/Qy2kB2h3IWhCTGqdrFnJYZFpOrbGM4NTY+vE2JZCDK5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754751751; c=relaxed/simple;
	bh=gbV6koIabzkmSdrbQX/alqdB93gTBYfPiSdfB6xV0gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQDBNPADfHdHY0IMRKJECNkDLD6701djExrodIoIEdKS7H6x+4CRyUOUh84BQUWqXyKERk8p9NBTNyyYsEThEuTskmynr651q9f0fUaY9BFusJwY/SCaZ8oQq3WecdwoTAEK7HbD5oz9CTsk3CTvIlpz4C5XpNqo27iFeW5sB9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=PGegFFGM; arc=fail smtp.client-ip=23.83.223.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7CDD94505F;
	Sat,  9 Aug 2025 15:02:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (100-96-55-144.trex-nlb.outbound.svc.cluster.local [100.96.55.144])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1E39244A29;
	Sat,  9 Aug 2025 15:02:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754751742; a=rsa-sha256;
	cv=none;
	b=ZifmuoKFioLVwij0c7PQ0BPqScyMki5tbpOGgMfV82o2Ka1ezKFVui1lYpBUZ8mnguJykm
	lFELoDcx5aepgy1xyRoBUO0u3jBZSiV0NP92aUR0Bp/Q/uiC1cY4nHF+fYSO7ICmNBw+i2
	p3IpY4eeuoiiHFMKwofozFJUZAG2ZsfO0rzQ1vnpA/I+KOCkTOfHiqIZVb/rpE6H9POu7x
	YJFSHkMT6ASwPn2rwQLCeskZLgAIi3JpQxYphQADaM47OOh3T6ZN1XxVoS0YNbErqUbDKt
	4fCgC+gGTDMndO32CMQU86QyGvsLv9QhZcDM6tFxrUjM2sAQEXfIueVmit7rzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1754751742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=m6IMy7lNX/Af0fhZL9pGdjjp7pfTiPVYPel8oysoPb0=;
	b=oUBAu6row978mdiominQokoIFj1cG3gxFtmMTCTZlavc7qTUXvMVowjQKjqCqIMasa94Ci
	Q5q98gpA2pUOLlgJxixv/wl+ZKkLJWO/yuyiGxOnHabXrtMeWON3aLg7i2s9Jmdkydg+3p
	IoFgx3xF0tmgWUAm4LKeniujx1mCgP0UhhnuNyT49sblnOUbW6EB3bOk6qYUl6T9GdbtWN
	LmWkZOGAS4jD9vEfr5x33bPDKMcmlBw6F71esuWfJZMgKb9YFPVx8Ym2Pz/MW19jZo9vE/
	E/EEwsb4YVWwbXcWBF3oPg83a1W7/93vgrUx36/QUFwH0/Yh1NgCoRicAt7Umw==
ARC-Authentication-Results: i=1;
	rspamd-64567b6586-jmh4x;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Gusty-Snatch: 705235065017f21a_1754751742366_233136106
X-MC-Loop-Signature: 1754751742366:2427474581
X-MC-Ingress-Time: 1754751742365
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.55.144 (trex/7.1.3);
	Sat, 09 Aug 2025 15:02:22 +0000
Received: from [192.168.88.7] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4bzkdn3FTVzDd;
	Sat,  9 Aug 2025 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1754751742;
	bh=GWFLV3j+XOANdYBimYJ4zedPVrX3giwHycaRYnwL3b8=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=PGegFFGM9+Ol5b8kO1xxUpeW6IaRnNljkSlO6iG+h50HfrlivQ9rTwi1LvOBK/F2n
	 eLn1/QuQDC/0Cl/t5Quja9xkbCRnM8T9BItAtVj+MAFhDs4D11SL+LI5XDdQ38XT34
	 4p2lpHaj3Fp5XsqDCKRExFtcgCsOlI3iBigN2hfFSQr+9Gii8Z29hdmpi7Ok7wABIu
	 p87NbZihRm4v5ykz6gg1B7rP6b8yI1T1YnxfVGCN7x41KlFayid8wssmbEddX3+Wqp
	 sqXdVlgr9O4gV+Z0VAEG98yOJo6/QXpbTQX/oBJ6E3mmJQnhpbAVPI1FULNDQGG/Yk
	 fvUkMZaKQtx1Q==
Message-ID: <feadab5e-915c-44ae-a1a2-46a2efc5f113@landley.net>
Date: Sat, 9 Aug 2025 10:02:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Add 'rootfsflags' to set rootfs mount options
To: Lichen Liu <lichliu@redhat.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 weilongchen@huawei.com
References: <20250808015134.2875430-2-lichliu@redhat.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <20250808015134.2875430-2-lichliu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/25 20:51, Lichen Liu wrote:
> This patch introduces a new kernel command-line parameter, rootfsflags,
> which allows passing specific mount options directly to the rootfs when
> it is first mounted. This gives users control over the rootfs behavior.

Works for me. In an i486 mkroot build against stock 6.16 with this patch:

$ root/i486/run-qemu.sh
...
# grep rootfs /proc/mounts
rootfs / rootfs rw,size=125728k,nr_inodes=31432 0 0
# df
Filesystem     1K-blocks Used Available Use% Mounted on
rootfs            125728  764    124964   1% /
dev               125728    0    125728   0% /dev


$ KARGS="rootfsflags=size=1m" root/i486/run-qemu.sh
...
# grep rootfs /proc/mounts
rootfs / rootfs rw,size=1024k,nr_inodes=31432 0 0
# df
Filesystem     1K-blocks Used Available Use% Mounted on
rootfs              1024  764       260  75% /
dev               125728    0    125728   0% /dev

Tested-by: Rob Landley <rob@landley.net>

Rob

