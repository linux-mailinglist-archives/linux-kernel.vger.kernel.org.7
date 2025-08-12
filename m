Return-Path: <linux-kernel+bounces-764344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4A5B22187
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E96B7AB920
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9399C2E542E;
	Tue, 12 Aug 2025 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="R/lXxPyS"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E842E2F09;
	Tue, 12 Aug 2025 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988277; cv=none; b=lXDW8gEYWkJj0npd+Z+2uKqfu4Th0MLgVEcnlq3Ia1VK+Q32VO2p8mxFJNpooMBmrtX4sKJPb1cwdCsJ6NyasXL2hVYv8RdpOeLYmTxnYjDblFdWG8o+cyy5ZFkMF6JPD1wtcdL/zRld93vDAtfyNI2T1y0gjuZ/84XVXrxndVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988277; c=relaxed/simple;
	bh=0sa1+cy2n9/ztHd24898UjwMnXyWFv1CIPlwh8OfXik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9uaeSZi0HZdkPe59mkHa9it4/gIHHgYSogcrMp44hMl0Qi7lOBYSin3mj4Nijgj7PmvpdM2YqLeeaMCTpiXVZNeujAOiHRWRcuuPuzqHx7LcdXu2c0y4jORJquWMcDgk7dsjfqariIySSA1K1oFb94GieyJtOfHHxTfaeaf4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=R/lXxPyS; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754988272; x=1755593072; i=markus.elfring@web.de;
	bh=0sa1+cy2n9/ztHd24898UjwMnXyWFv1CIPlwh8OfXik=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=R/lXxPySpxrdftNIPm6ASKlJ+yeyMhqki5CUUMWIM/UBCtJrKfM5t5P2ZCHIgQT6
	 d/Ue2n3sS6+9k0rUYp2GevXX+ttrvDa1OMoITtHopkPCCWV984fGaIUE7XhWei+lv
	 T+s80xIR0VdaBMvO5iY5GbrW0Tamkc0jYyXOBarJDPDUmyLojvH2qXe8xuRdcn3Lp
	 0e7wm7v5LRNpmbX0BKLmhtMnKXoyeZjHewHjQ1LQwb1paIxWhbDbTFsdWDjXs72rh
	 ZQYvT8fgo/Nkx57rxhcW4Rzyhr2CWxjchD+D4cLRx/s6XrLGxQesNiQ1v9+R2Bqnx
	 qP4RYHQtw5Clzw5ucA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.213]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MumNL-1uTfcM3Yot-00yEEF; Tue, 12
 Aug 2025 10:39:01 +0200
Message-ID: <dceb4471-82d9-48f0-94dc-e9277eadeada@web.de>
Date: Tue, 12 Aug 2025 10:38:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: squashfs: Avoid mem leak in squashfs_fill_super
To: Dan Carpenter <dan.carpenter@linaro.org>, Scott Guo <scott_gzh@163.com>,
 Phillip Lougher <phillip@squashfs.org.uk>
Cc: Scott Guo <scottzhguo@tencent.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <20250811061921.3807353-1-scott_gzh@163.com>
 <24759bdb-b427-47a7-b9c3-724a11d0162e@web.de>
 <461ae944-5fb9-4860-81c1-1ac48c3d888f@163.com>
 <aJr43n1np2nB8bht@stanley.mountain>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aJr43n1np2nB8bht@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NGeLIdKQ0SEVmD5c9tS+S9veob3IrUuUr7BATf3Tgeg5NtO4umb
 m8kvQnKd+iRJSlC3Q5ZrOOWzKX2/kXpEIJb6w3aq/TcxGkQywLSLU/eF95lGB9+mT/7/PAg
 MzwV/NUEjry7q2BC3DnZZMdx2Hwg4WFdI32vEBytBBCadi8IkdKjraVBbn17+Q/ETBvFR73
 a72pQA9I0XN5S4lhy6dMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eESia0PHrSs=;eUb+aH6kShBM8jjyM7pNMYUmkJ3
 i3Owe1cU9NborU+9d27NvFZ8gLvLA2IR56NGOofdWA3LQOW1aM7pVGXiaYiLdxCTfW7Ia5PFz
 8eIOGGc+1EEr7z+VAcR0Or+eIC4YsMHtu3equvNLibvFk/usUKR7AUgRr/KBS4s2YFtQwMWa3
 SxNhCGY9cVmHrwAjiv9WYXuIv2BvlIg0E/tHuVBaqZ6mQ/IzHUP2FXi7N+ZAIISvz8jY+JpoR
 TQX/VuE0lhULGIMLb2b7AH/IhHrSJFkVatXLevypsWoa5SjXrCh97nQqHD+NNFfD7koZU6rXk
 UH/lE6XnzNk3HjkG+f3Hz5wlM/PoqhVJq6iK7MWlxNmPj/+3UxgdcDbMNC7cHSOJVdrhmhhwd
 3vmTSvqjHKxdCe0MaiHxjtBGFr8Hn/asYcktee5gzQfj3eVnPBLIoZf0iIurIPXSeTaKPYcdS
 io8EVclyYS1O4NnDonrbUyjK8mcL1n4ZchJ9/T+2+c4GplH2XR8GNts75XLuWAxKhKSQnFpMO
 IEZ8r/BWPv08v37CpTKQI19BxIRgXPK5AUZirUVdzmIVQ9eAwU4lP96Naa1dT760kEc0Y+cCP
 +nkye/V73XBYiKEm782mqW9o+lXXrs5wsgHPtryEworFOFA7nyQ0tvSt/lzeqq+VpC1SCe6hf
 CDUKhz6jqyvS/8jacl1JnSgxcPKMwrQ/eLFiiyzqs3a6opDvTHgCTqvhoB70BX+Nmpguswhr/
 /yl8+IadVfL+QZDQUDHiBmB+tWjaRijBUMoNe35WsVuaAmoCwZ4wd3zH7MIm62Ha2y82B01NE
 0KkrNBOt7Ec6epmQLbzPSBjdmhGukLMklqRiuwy1iq+hcd7wIGvzwWbTOiWeBk5DF7sC89+Pk
 KJwJBKIPLzpAC+ybfJ2RPP8LLqoCBjA8IcFXh0CxWhCtWJkX+x9pxuc4Wb68TntdQCPSK4CLW
 wFf4zDOqCigvQJgvn91q/C256YRcr4VHQqsuOGm/P+n+DqxJBrL+xUY15jp+B9DWA5uRkrH0d
 mZqFyTYzTRWOCsZWEV2bjr/cyhFYNJk9z71MJTnbg5N/U1HQL5za8QWGax2pZ4wto+E4X3WvG
 f20Lnn/DojGyUij6hSdVfw9yEOecvgtpWPhyjJ/6I7Z68Pr4WWkzhxfrZk7WO+rJW6o0i+6qD
 puxgeiRfITnDD5ZDXe6a/C8zl/G4s8lDfYXOqDYFsCGoSVMWax0RwP346/J9e25AH6CkhMILl
 HBTUZ/qwg7sJfji4hq32oLDIIRM+AtT4r0fUgRLJ9K3q1qTdC2x9FSQOVHWrt72Q75ipVnWIk
 +g8Op9tBpJMPp+1DBkR7QZRR3gW1RbjKe9f9ElhbZlJ/gBzNpjbYq2wLM/KPXVH8DyO6lrb49
 9wnsRBfRnhyY54TLY8OtnuprQS29sBuaiE4ourez0BFCXdJ+LHnNiHG3ckQFxJ+lq9RDr3rTy
 lZgv8yXO1etgqhG4a37Akn8NYbvPGjucE9ilLR0VYBDsEvtu34UIZInhxxtLZGdTsRyTRDIMr
 LnFFa/bfiXM+rnQQc07xfx9uccuY85aBuv5eIWBG4c0UVJEcwDgm3/KzOe0NWbAPy/3+xg1gr
 I0+XwBuxZX0/XjBVy3WZ7QFF9HOhapvc/gc0IqJq2mbxTApxGtY4dWso3PsJdKxoHtN1OBexN
 6vIqwMfJleJlrfSI/clOOopfUW4voiitkTZ+wmek9spxXVGPCG8UQAAoib0C+89WRr8CdtAxv
 T+E5PakZvIydcxBF5Lwu87D64c7ETl8J6z8enYMFahSb7SY4/7FdzLNyLeOJfRiDG0GVIAq3S
 thrkVgtJhb1vkAXIQ1bVAXWyfIhAc91inHSXG2oH6r1FldDxMkhZWwa31OFTPSwwDXhOM7E8X
 eNqXGybGN25ybxJNhTztcjFf5CktPbpaol3Nuq3MQCCD8o4Ra7q+4aapU1/cq2CaOmsQL8AFd
 bHHxlHR2NLAE+i3bfuKhpGsdLh4mRyOJoiuWFs3zY9zP+R/4KWVAx4mkVojHpFyFN5vwpVjVO
 8BJsHOmx6RQveYwak7NpNoEnRzA6fEsFkhCdL6r8QfhtmaTrhwLLmkV419/rpdcWDlIjCzQl9
 5co/ILrA93Z17RlIcggzsrm/vnysN9v1o6Q0D8U4qaXheihOWUg1beZDytGJkaaJ9GC7HTz1d
 PXw7WSQ1CxhBUDcgqfviDXaseq0pazRisyACyLKSN8KN5o1Ei2dH5Q/VI3GQf65UZnV2og+ey
 UXzZlh7hIv7XZBSMDzF19xMAnf/RZ2DLdDa5dwAvkKs1P9b5DsHMgVpEmVE+yPgToNHVaL3rS
 C71rsFV1Mkn2vw9Or4iIl88yS6mUOjlKBuQ8RAeHXnnbBTdITnwPjGQUHopS6nl+vxDufEqKS
 sCfAckVK6nTJrhsDFhaa77l6QwgSPNdVUxvH/A1FsJYhiWXA6Q/CoEBBdx1W7UyrCDnr8LGcV
 NL+aL7IbVj5eyZVn3Y1xu2pJ7l2OgCw7aEzMeNKBA7QujctjDc9CDts844a9O+Qr675beZkjy
 bdGUQ0xWh1X+Q+pDYQVwiXfl7HkX1nCFhLhQnNUsvwCvnJo0+S5ejC2w6skv7Iq+9C0RjcVz0
 HHjeITlqSoZ4w2zVt/hO+BxsLKweINg/FVU1SzWk+/fijyvTId6T/cOiPAnMA14gd9DKnJmse
 Jaft37BgGNXiewu+/v4K6CveZ+X6pJ9BmYzXndJWQ2cP7ZpAflxvA5LkDcMc2qVBZUJ6wJwYJ
 YKzxeM7Ss/c3qV6g7CYC57UUT+cjMOS2Je+JjY72hZy5F0JXxkRwvpaSpTWKQ5woEY913ZJaE
 zj8ghHQuzazh/M/asaC1cBxdiqHbRCQp6+UkmuVyUrFOTzxF/2hSO0Gn4stFkASiUXkBff6PA
 2TL/liPm/kSRS5SFOohF1K1vwpS/jNCITcyZnePPQ9E9+a9sv8U3R8j0EzmfA1bTxv58FsAIf
 foGonTn4ApOc90489PudHKo5JANwgG+1uP2Iobsido8JwuKzJ+bmWUwmQwFAAbo2uiLr6of/j
 5CGUgFFF5cGnl0AtEk4KDk327asTB1CZuBkNIBDsaQPnqv7ertCcTNxMNWYa/cGfFzY2bDhZ6
 3jY4XlbCeJEhy9i/0j0nMkyHeZN9CSXO812MrP5l57z60YkT3DMJZ8LcXBC8/4L+dB5e2NXaZ
 NUpGpZBAIWNMKJHeQcR/rIGtCnTi5IdOYusjcEItYJGAeUmDBGuzsrAHWO/iR4/gVmyvmfK60
 /0s3luygvU0fuC3oYyburd98IAGC4PbQGTPbSFkrvmRaWbWZm+/hPUTkddyl4wiK46+Sca/GN
 AOVtdJSRRHvUnWy4IjMAIQQi0/P0VwlcoFVbaBZZN+Ind0ByrVnH25l5Mghdi/M8LHeagts2g
 vmiEfU0MS8Zxua663gQw==

> Please, don't introduce more of those e_inval, e_nomem labels.

Would you find any other label identifiers more helpful for sharing
error code assignments according to better exception handling?

Regards,
Markus

