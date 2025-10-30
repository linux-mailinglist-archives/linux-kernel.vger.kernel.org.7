Return-Path: <linux-kernel+bounces-878380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C88C20707
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 748A64EDE16
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C769723D7C4;
	Thu, 30 Oct 2025 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KQYIhZkp"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9DB2236E1;
	Thu, 30 Oct 2025 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832725; cv=none; b=Qoo7ZoHGLx38iIav9M3xoyw0u/EyH7vypHSPy7zmrO7g5qJbdU3jRam4pCbgbix1T/VT4qkvJleT9/4i4OD0s/Rb6zj01CWlwrB0TYD0ygL+MAVZbd2prDsw91LNC8tONOkXuOFJ/9py9wrML3WTulqDD9k+EhXbjXALPdoYM6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832725; c=relaxed/simple;
	bh=0BCh7TE3NxTYXcEaOAB9G89XeiCZmRlSqj8pjwfOcpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XvK3W4CAlzB8zHidKBbD5T2pJ506O0KKJdUu4tFTAbudQWTuECbjiH5GLGwCpYJX+7PCOjtONwDp8JiWfxL09Zy9mzcs0jYtjfkRuiQJFaRYiCW0WXPFe6ijLbnvSl2LcW1AOZIsknJ6D9juWCVX/pZfkOmfLW6Dy0e5rlf3yG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KQYIhZkp; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761832714; x=1762437514; i=markus.elfring@web.de;
	bh=9X4nc7LqhbPCSkQ6M6wo8iFhNhlOAgdihW/7ns75Z6g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KQYIhZkpgUdvbos37+Ke8uXPK72MLjokzA8kvJ3kmdZme853XUnwX18td7xws/34
	 lM9grfzSjc+NLC6aRMHdPisU+cbBAKvJ4jCsUjyf0OEoAINNCQXUHR0CJHXLjKx54
	 YvKA6waTASW1fDxQZdpKfHEllis8ietz/FLwWb3CS2DJMiP1J9KVhKmJpG+8TJ/tU
	 EwJX6LcFnKR2AJ3Uz+VURhthqXsQQtJ4kgMyMmoMVcMLvT7eaBMX/BSM4fGe5cyE5
	 lHGgknKA+dUVBh0u0u3kexKwghrwMYFe6S5BlffHpqDQDYhWt55rpTPCHIkl2ffo2
	 IHZDLdwV6EjWxceO9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Md6tt-1vmydt0Eol-00lE3n; Thu, 30
 Oct 2025 14:58:34 +0100
Message-ID: <414793e8-6961-40b6-8721-cb1aab30bbd8@web.de>
Date: Thu, 30 Oct 2025 14:58:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments from
 memcpy() calls with SmPL?
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
 <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
 <60f881dc-979d-486b-95be-6b31e85d4041@web.de>
 <aa99eded-be51-af3b-414-7c3bbaddea4a@inria.fr>
 <aQNsecHJSO2U68Fc@stanley.mountain>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aQNsecHJSO2U68Fc@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J2hSSGA3HEIAAJzQ4kq27hOw4yTlyx0MtxaC1dZwQb3TMS2g5Dx
 VzpVydgGNJJBqXmY4NDZFdBPVg2qYTi+DTiks+MeIHNe1rmmhGFW2C55/KaCWluQ8Z1qjur
 B/CgcBLjNK4qLMvKF5SbKXk6FvRmE6MlEa70WFtI7ojScoGYR4naFszH2AgQojNYuqpD+db
 l9ju61B9CURYzXqaXp+sg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eKfcuK35uEY=;InZEmrwqW3YLxPLwf203UzWBP95
 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
 BMqMgu6Ag7jtrbmi0mGAPJl8S4=

>> - target =3D object; memcpy(target, source, size);
+ target =3D memcpy(object, source, size);


> No one will thank you for making these changes...  =F0=9F=99=81

Will any more contributors dare to try adjustments out at such source code=
 places?


>                                                        Please don't do i=
t.

How will change tolerance evolve further?

Regards,
Markus

