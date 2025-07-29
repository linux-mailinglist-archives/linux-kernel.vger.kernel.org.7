Return-Path: <linux-kernel+bounces-749694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADCBB151B0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 164357AE572
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5EF28EA72;
	Tue, 29 Jul 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WsTQF9iz"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1697534CF5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753808065; cv=none; b=PRP75WSuM0pWZ2h9kCp96CdBUIkG76AKEIkom0LOFy0a+4KGKCdLeDMa0LuMTnjT6Ujl20VvPn7k0919WdpZNPoEcE4nG2HoAiGDARbEQ6onRA8oWtjnPr0nFq6XlCTPNY974PIbO9oRV3+j+Kj/Aca70e0jLfwFGaMJmdPH184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753808065; c=relaxed/simple;
	bh=inGoQI+jlKm0Co+aY7zk5G2hEN40oz7ZZCbFKqxests=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=syf4stA322r4ZCAgtFK84Wm9rJrxhwGq865KMo40nI7Uzi17DRHgjG86TWXV9nKsGLHJxg7ZxLYqW/egryyU2kHGJh+sZzUjHr0kLoVya+EkwG5kjKZAiqXsWKy12YNhMoX63v6PJzuznXCdKx3lHiMlHjKtrTzNVBVEltO6uX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WsTQF9iz; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753808058; x=1754412858; i=markus.elfring@web.de;
	bh=inGoQI+jlKm0Co+aY7zk5G2hEN40oz7ZZCbFKqxests=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WsTQF9izZGYSsBCZfbSHdquOBEyRXNsUSgPEcxgEIxYYQrzdJzAdKvnR02xmQZVS
	 MPnnEugpvQGklWoGftws8P3MpE52IprrijgFWa5A7eT9T0HRaLRFI/gGbM3T3l6t0
	 3NWiX+1xPQw3pEIcQNjPE0KRa3+G93Q+rndQ8pGLq4rNLxBFB7+GP7wolPkCzehu/
	 lsGFIjMtczyS5m/Uki7gJZIMq9+u3+Ip4t4D24nryEtDDSDHVvrS7dC0LbKDvTps8
	 ajwz3HDGpuEGBMCHm9fBP9Bk7L8w2VzEDJJlEj8+MowOkqYgwv1dxbGe0o+YAsq6T
	 gZBy0+eHFz9/8VZKbA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.201]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMp8Y-1uzQPG00DU-00RlRG; Tue, 29
 Jul 2025 18:54:18 +0200
Message-ID: <c36fe8e0-332d-4453-817b-89fee2525fad@web.de>
Date: Tue, 29 Jul 2025 18:54:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pei Xiao <xiaopei01@kylinos.cn>, op-tee@lists.trustedfirmware.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Balint Dobszay <balint.dobszay@arm.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
References: <ae66122a86295f0ca5f2ff385ac2850360a805c1.1753251689.git.xiaopei01@kylinos.cn>
Subject: Re: [PATCH] tee: fix memory leak in tee_dyn_shm_alloc_helper
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ae66122a86295f0ca5f2ff385ac2850360a805c1.1753251689.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ukuw785zlRpcHAZNQe983kdqr0vrMa2ucPuxnjyNRiLmvxF/Py6
 trA/lAiSy5XMWTmf2WtFAogyGyXxRhy1JJhUp67OLBTp2hOYzSHdFfNWax/mH6Lr/zeT/Qg
 p3u74fAZ1BtwFu6xbhsl9tfycZ+rqKmYDhs1f5WwxewUWdyFp3QQMsUJk6ybCRo+c+RqHMW
 /AnZsDBmO17KY58f3qknA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mCC/UdzyTC8=;Y1j3B71erkza1Eb5BBgRtzhfYZD
 8+9OJorHX55NKV1RMzYpVsB6NjWmMRfnvVIbiZ+XBhoZENkAwFlj8KRpfa77M1uVLWcbxmNS4
 zNGnQcg+v9Yd0G04Ryo3wachu98dJGhoRoBuILrh6jJG9HUs9sd3SsULuie/U9KPd6K5AU87v
 4peaszM43NLPyukSOzueOFnj/YeIQmCMI6GJdjvzUuUy6G0yQhNfPot5MJBdOIRFDcHFSPsDq
 3FUqIEirq3eNXIIy8QKjSLMejMWiUAI+RZcD5+Mb9fCzQ3BUpa47KIKPMCjUCJMTEkCHPHlAu
 oHsNBXu7wB5On15RRqn38TkrjKf4P7HddkQX/F8vOqFXFH50F/ckT6Vtz3Tr1WeCIN/BBx11U
 FcSvg5E4lIzXjfnQIEYfKHZx5YPJ0I+cCVlKEb68887JVknsJo4yx49pIOaqoDRhxtoOltNZ7
 H9xqDdpV+yuCYHULxyu7YMx2+tt1AKFVMoce1E9e5s/vsjznk8a64T4hhSbZUqvXO5+P/gxxG
 OsEUh8Bjvy+rof84Win/kCTaAzTvgWPhFgHjYwJ9D8gLOHmOYmiej5SG6FCsD+raReDkOv/bx
 NvKwMRyky5mm15ykl89iOapa15XGGle7Ntm8U7SRsYKcoxAoqHnKImd/uHJvd6Ck/MwXntHIT
 OT9kPqabeN0RwJuNncPevB8ac1zKbvZr5EQZGAwFqLBEo5dE5kPn5iikqDjtyr6pH6Hc79krs
 o2VkNo7OjDUq7obUvh/smFbAVD7lZofKNrK7Yd119eUPj/SC57iqjjog/ErS6y6asuLy9gskf
 pU6OzoIzwhLAt4lx07i/boMC3oa0Jgn/Hao+3iTkNQK9ucmiSCgK9/fC+ELjAr4BlM+o4sjGE
 BRlgHnQt58Dh6ilzXbk3SqcJP0dJBGx5gThUGssDXSriPGKF3XjTxIn8GaN5pxssyhVIYzE15
 Xs+qUTGlfpDKenjg24dVzMlDDVqxq/8oX5GmWMfBN76Jreyad6RkEWXTw7NodGztehVQnXWRE
 wd6Pliv0hvWsY0GwdjVxXTO6hn+B7GImndjAaqHz+zTGzS7jjV7oZGGTOeCkmC0NI4VblrCWy
 RaBpIvQCj7o8o329KZcL+UAmIa2F7tb8o2g27JAFYLf7kcetLctrrN8DvQwR2U7Rqik7t18A/
 z6e5F6NdUgXns5KqXdV5jiBK6UqtHz/6SNBplj/nY2gDG4Qozklz6/qiV3j5iYypwgIza0l6C
 +cNEeA0+gyqzoiu0wOh9oCMjqAEOuryc46TQ6qqA7mxZsOCtX0fQounEyYE7IJ+u0q4NLzVp6
 TxcSVHoV7JlsLX+UMUe//g0rQAPGYF0jTmqxh/MW81KNu4WrwmCgOJ0dmPAbXk/Ark9wvQaOP
 wmLCex/+44b7QTYIgR/OA0/cY4plBPqDNittGa/6MiUM032VGbdHKCEcp/KoARl5pKQ4BxRSg
 12Rs9ySS9NPaV2lH4/uHAIlnS7sYQ+/K3h5/MUR0Dhm+n81Jt/P0zMtkY0VOPpkmtnzg5+HCO
 TeFb4/bOkrDBe0gfijW2Pp3Eul1nnMDP1KstS/X3efRzGbabmz3vGDCuAY0FOQ26oddS5BfG+
 DlTJHMbEZK/i6FZ0u7ZcrDy/p1lRROCLo2VRbc1LgRXQH4eLeXye47IY+2ZAgxne359IHttsz
 d8n8qhAJJ/OLLXfG55mZolFIbIAjHEh3u47yLT8bZ+UPTQB9mS7GirBzAuYpO/sbUsh7syW3V
 I2Bp+VR874ixchGzkRxv8dIAq0jZsGiuKXdonfCaNN/cYNsUL2FvsetxaBkoE2gJev+niqYnf
 KNSpmBz+N+QmIbf09Sxk5mDtg24RX8GbYlHvIE0nk1qYLYdNvj22VU9hAJCXMpKOxK/Y07vLT
 LovhylXD0qrK/lIVAhRONknPQcbtoMxq0OWGfvrGkBL3Hta5BPwVqbRFeHLK2pssFdDLNDJK+
 akbFMrINl6krcEblP/FJtCn4EbAEKpO4iBXdnkB0ecnb89dAm51g2TP/+9kGlfF2Wen/u6gmU
 xJ/4KAyMRzOn4MktRv6yeyXs0jRAMwn74EnAhcJmpQjLPZlVT3p8h7pFriftNNEYfh1qAGadB
 kQpdG5I2tycqvkxWxAQ28i/CXw8NpZ7yZknl9bg3ZKv1hqspR6W/g8XmapkQSmdUpjElnikWZ
 LK6nXBpQ2cArFfNcuCwOyGLNyrkLD+NahBCou2oh/FELL5YQVnNWjq2ki49acqAJWDxuLpFCc
 t56KESJb0G6Sjnva8R4BTbUsFbL0F5VQLBxrH1YWAMT05r0U5pBjVlFZMK7oNjlRYMJ31xuJx
 que6DVnDaEmSLJc5RQGIoR8gMKpEhdEOZTHiPOr48d5mkz2FlBSAQwYHxVoZJ+dRQNTwYVY38
 GBTaklgT+DUR8ksaOxJZIx+m1N04qs8XciMxBJYGjM05Tt9R3uRsiY0Q1+i7zntqc2jk4f0Gq
 KEQFXb+Mrwgz8zUNOm+rkwM1ISGRcMhWWzI4f8MMavbcMkdlZEiBCPc802tZ6in4RVSqFZxm0
 TatJmRX1SXzl9bhsIumM/jS3trFOxDvmpJJ8ymyT+elHlEnckQpmS/NF054fb+BIcyblZoigY
 lqui5Pg7QQ2hUU7SIYPpc6/4NIeOGXT9e4Sk/7qmxoU5WkTlaqNO9qhELC+QFz7GmQXRActsm
 yF1lcVvvTR0S/Q7aJyyaLZo1sc7gSBCsXntOraNVkq8p/N2/HnngAvvd6V99uVxfYjfGmxBbY
 qnLORT31fCagJADMxavbGHDpAPz7+yfoOd7wd6gT6WU2BH8+6YhqjYXCH1SxEi4ruTmF3ypef
 4p5O5/M5jb48NRrFNq4oDUw6WN0AAz8OhyyonaUwafWEzu5kR+luaRhg8TzCpdPeH+0n+rS26
 PkOnRFmtM2I8lKsSmdGo3G+IqeUMrnA9ZmvVdB3cwvfL/vQgqYwkdXzOSm3DUeFsHi2cMCuGH
 4WzXfc688/BUecXqT2K2SfSChBCT4td5T8tDHP89RQRawZnL+q8KMMnZ4hxDT+7CM075jIjA/
 Vru/RQxHf5qfH7GXNLGdWgEGBHXUgp5wSeAPj6g/dkBH8q1sUz4OFt/AZgCIYl4UKqsU8TGzz
 UuvEsvSncfyElxRdJPC/24YSQs8q8UQVatRYswOqvOiU43QXSCJ9X+YvgksMQQFA2IIQt0NpV
 4vU96fmGyU4Gyp9zxkisSEoBDdkQHVPzhBXF0tTBy6hNMV9BZAOn4KqnU2n/bTHPkLuh9PqQS
 VcGvhW2MRL0ZBnRcAFWECrbyMFoQokqIUWbk0/4q5J4aU12SFuKsJxcsHe4D2SPFoJodkVFw+
 U9fxgsJnecC2i+W/5f3kjU2CjKSD2Hx2UzoWumgLtVkw0jArcMaq30NXwhkKCSTfpsw5H3jg4
 Ue7vbOLydES52HNBnGMDoaF//ey8IcDX9Oc01l48AA/ATNqygqBIxMv8ZGoL3fbeHHwZMsTqX
 ie7nqfRaMQeVChNNJ6Gn8rfNJ1Jb/D+n9z+7bMW9+90/kavke+nEs

> When shm_register() fails in tee_dyn_shm_alloc_helper(), the pre-allocated
> pages array is not freed, resulting in a memory leak.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.16#n94

Regards,
Markus

