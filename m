Return-Path: <linux-kernel+bounces-895343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93792C4D88F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B966A3A6A98
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1CE357711;
	Tue, 11 Nov 2025 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b="BQR6Zk90"
Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDF027F01B;
	Tue, 11 Nov 2025 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862146; cv=pass; b=fNbtNRyM5Chg+W7YGtb670tnDD7XiAFUKsE2WsnBpoMziGIHUFrbWBWZv//ya83kzCecJdpUiQA/71H7OpHA2WVs7BJmoqXe1Pic45PN+HAqmGMhB2P+2jXSxzBIoo1BMSZOV0y+l4O4hSCuS6AwGZystpymI00OwhVqMjvdIoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862146; c=relaxed/simple;
	bh=Iw4vgcU5pRFqc660/a2NMV44yFh4lrLdmh67uM7HCrI=;
	h=Message-ID:MIME-Version:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:Date; b=X/K5Hb5/uo0M1Eu4XoCuNu95tabDRV9xN4wIe22zrxSjayeH4pPkx5faiG6cghRN2xCi6Xq0pseUugmzb78kn0qgo0Aq0go/QgzYYkEzvdZKs6KVP05FASpVmmFbf3dRqp3pcdyBarNN/FvyyBdaIGw1PSO4p3a+o2WbD6JS96g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com; spf=pass smtp.mailfrom=rootcommit.com; dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b=BQR6Zk90; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 3E4031821BF;
	Tue, 11 Nov 2025 11:38:02 +0000 (UTC)
Received: from fr-int-smtpout30.hostinger.io (trex-green-2.trex.outbound.svc.cluster.local [100.121.225.152])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 217AD18033C;
	Tue, 11 Nov 2025 11:37:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1762861081; a=rsa-sha256;
	cv=none;
	b=jJzObw4TU8KRSucN5sBufP8kHUy29AHDor3VA3LH3mWMtqk1ZpmdvrQVFMVjMefbkbc6ga
	RbXwTN/4BE59BiPVT7KkkQLJQton2MifHCPkQtIohjcGAiteoTZ2h1yf8iDG6o60Wz2eR3
	QACMt51ETURo5WhSgcsnzqlCumI4NPNBuvc67S2shVdp3yg6Q/DkwXMJlmlICCkmqZnMfL
	6YuEKKIpA42E7sF+e7zwph015fOQrayUTIMPy5cYQNDbIXc8Z7yCKx7OXxr0/pRhG/eRc6
	AB/Gp0rmdoqiEfTrDt2XXFlerJNVbu3nmHe0ViCMgBLCja0MK8ccU/PQVawE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1762861081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Thxmb9T0BAdHQZHt3TV5jxQaTn4fq6YyiNYTq+kOTD8=;
	b=JqcPZe11B+qR9NeWQk3ZgBJuZX/7pa7GShG4UzdyA0N1qCo4F62hD64DVz3K0fA1Fa4Qpi
	8IVoNT3WCD939CBpuNvxRHuCUCSMBTIX3HTJg8oe2lpUFibwh/JLKtXJUdVwPecSImHZ02
	fsXwCssjateM52j8jVjKQhSX9YK19NLeScdwyBjzWTY4y0kitMPlUUaVkYqgtVj9bQY4Nl
	25S6koAL5KKmyWOqWYHivisxYQfKMtgRzvN1KMBMSd7/csbWq6v3ZMXTchF/k/JgYtIu0g
	IbJ4g5J8sxM8omFPD5tJ+WiWslUiBz+l7/nCboFtkA7jVeGAep3bpZQNYT0NZQ==
ARC-Authentication-Results: i=1;
	rspamd-768b565cdb-8vj2s;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Whispering-Robust: 30e8d534303519c3_1762861082040_956378664
X-MC-Loop-Signature: 1762861082039:1160088958
X-MC-Ingress-Time: 1762861082039
Received: from fr-int-smtpout30.hostinger.io (fr-int-smtpout30.hostinger.io
 [148.222.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.225.152 (trex/7.1.3);
	Tue, 11 Nov 2025 11:38:02 +0000
Received: from [IPV6:2001:861:4450:d360:3bc5:3dcd:eed2:25ed] (unknown [IPv6:2001:861:4450:d360:3bc5:3dcd:eed2:25ed])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4d5PfW3CN3z2xNs;
	Tue, 11 Nov 2025 11:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1762861077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Thxmb9T0BAdHQZHt3TV5jxQaTn4fq6YyiNYTq+kOTD8=;
	b=BQR6Zk90DmY1oZE0JrCbX/6/0SplX433JCgprXfWw41A7rgSfxDFwFrMNR3yMazSgs23W1
	YTgKF+tiYqvofWBfbIoc/llXV4FUrd8h8JszIkaBTxZiO5tPBBZonT4H4VLdKB36b7bXAV
	03+DL8X4Wr2+EFWuAciw16g31Ho1gM5RPaZsEchl5ThEEPRUziba3KIMZHbSfLh5AO9DVA
	MY4fuwJBSQPTqwfJY8rtMS+Dl0m9e0LVKFG/+jk3kwf1xXjmI4AOeI+8FHDZnZR/tRzmWW
	pI/E3ZJhK9Bb980kCwk9Wa2WCKRyLKf6pPesALJPIT/zbStAJesLapMdaufgNA==
Message-ID: <7f69b746-afda-4d3c-b78d-f6d95a6a758d@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: riscv: spacemit: Add OrangePi R2S
 board
To: Krzysztof Kozlowski <krzk@kernel.org>, Yixun Lan <dlan@gentoo.org>
References: <20251110220641.1751392-1-michael.opdenacker@rootcommit.com>
 <20251110220641.1751392-2-michael.opdenacker@rootcommit.com>
 <20251111-inquisitive-ambrosial-chicken-861542@kuoka>
 <20251111101149-GYE1651402@gentoo.org>
 <af7bd4ab-38dd-4a5a-93e5-f457ae3460db@kernel.org>
 <1d469324-84c8-4b5d-ae68-d77e3c822656@rootcommit.com>
 <2eb5ea0b-d071-4e17-abc8-7db5c78919f2@kernel.org>
Content-Language: en-US, fr
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Organization: Root Commit
In-Reply-To: <2eb5ea0b-d071-4e17-abc8-7db5c78919f2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Nov 2025 11:37:55 +0000 (UTC)
X-CM-Envelope: MS4xfD7nlJ4/BJGImMueYHopBfT+uNoFbis3yzux4sfWhB+oB3CTgBNBBxZmYUbNd3SdnezEXWhYzeDKxibakg1GdRUS4lRCTS9aizs1a35/jO67Azl/QCQA Kq+KY9+dbq+QVh+wqo4I+zBhOm7GgTtnrou7TKPq25ynM/N8eH6ntcpSBjuwP7GZbjS9iJHSedEz4tLYSKSwRDZghHFTSZW+DvxiaAuG6K4Rzpp+LvJdtf8s 5KLkMXq7SanUvR1sxzhXw9lrsFRlNTMguVzXb56dJr9kQzSzHbhafeoKdGLm9GLod982eLq7MD0Vx71zTwEw1k8J2xdIz1XmkAGjIFO17vIX5XrJHo3zcsDD oHBewFF2Bvaydspwcbz7JKjjPTyR9k0m4VFZqkT7SBvXk3UvKzNasAKoIIB/DmMhGOx8OMpyDv+zMs8We0xTYjLPVRpPBp5hHgwHr0ybS3KFj6iQrv++epkH zDpLk75KXqM7zYaBR/hKhXlETBDRyVm3CmPmjkiAubIZMaUCq5NtPXQl4q0iKAO0ajoDC2SzVanL9lK496Wd/A2ZPfwHIQUm9GSd4TielHhNwl75LIs+J4No 4CX5TnyWntWWRGrlqXutih8Av8yN/4RegleACgbgZyHoCq/hElyIbA5H1NYlu6v2ny1IOoOKpaRKIMI/liF84Gz/SwqF5RcVQHtRAA0bVQt0I92pwlvYDDYA pkz+PH4wJWI/utivg+xwos1LpRDNbV/eboMbthiFTdwxv8GvnA/tMi9UZvaDhac8+/oW6IcVwVZahttXYbiP2MUBQupayDZioojTKS2VVrWAerbeFibk/A==
X-CM-Analysis: v=2.4 cv=DJTd4DNb c=1 sm=1 tr=0 ts=69132015 a=sEYliDYKNDM94lrOIDkWOw==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=d70CFdQeAAAA:8 a=jWY-LL_2j1N7cWvRbmcA:9 a=QEXdDO2ut3YA:10 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com

Hi Krzystof,

On 11/11/25 11:34, Krzysztof Kozlowski wrote:
> On 11/11/2025 11:29, Michael Opdenacker wrote:
>> Greetings
>>
>> Thanks one more time for the reviews!
>>
>> On 11/11/25 11:13, Krzysztof Kozlowski wrote:
>>> On 11/11/2025 11:11, Yixun Lan wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On 08:43 Tue 11 Nov     , Krzysztof Kozlowski wrote:
>>>>> On Mon, Nov 10, 2025 at 10:06:48PM +0000, michael.opdenacker@rootcommit.com wrote:
>>>>>> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
>>>>>>
>>>>>> Document the compatible string for the OrangePi R2S board [1], which
>>>>>> is marketed as using the Ky X1 SoC but is in fact identical to
>>>> Maybe, just say it "same" to clarify the ambiguity?
>>> What is exactly "same"? Same die? Or same blocks/pieces? Whichever you
>>> choose please make it very explicit.
>> Maybe Troy Mitchell from Spacemit can shed light on this question.
>>
>> Anyway, I could use the same wording as in this commit introducing
>> "OrangePi RV2":
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch?id=bab8dea259100a99e047fd11a48940b229d30031
>>
>> "The board is described as using the Ky X1 SoC, which, based on
>> available downstream sources and testing, appears to be identical or
>> very closely related to the SpacemiT K1 SoC".
>>
>> What do you think?
> This clearly suggests they are not identical thus you should have also
> dedicated compatible. Let me then precise, I thought it is obvious, that
> except writing it more detailed in commit msg, you also need proper
> binding expressing this. If this is not the same die and they look
> compatible, then usually it means you need a compatible.

Note quite, the sentence I reused says "identical *or* very closely 
related".

Anyway, that's not up to me to decide, as what you suggest would mean to 
fix the DTS for OrangePi RV2 too.

I was just trying to share code for this board too in a very similar way 
to what was shared for OrangePi RV2, so that people can use the mainline 
kernel to collaborate and make support for this board better than the 
custom code produced by the board vendor...

Cheers
Michael.

-- 
Michael Opdenacker
Root Commit
Yocto Project and OpenEmbedded Training course - Learn by doing:
https://rootcommit.com/training/yocto/


