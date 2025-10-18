Return-Path: <linux-kernel+bounces-859296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2064EBED3ED
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 18:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78C154E0649
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 16:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE573246BB2;
	Sat, 18 Oct 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vgdy5QvA"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015EF1ADC7E
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760805512; cv=none; b=RU/hn1fkuitnz9wDQdFMWpj4/5Rp0hCHOBxbfL28rQ7+RvA5UG0cX1WWI1WGnRWE5bLFxMcckT4cO5RtNgNvgySr1CKKjRbvJ6gMnHCek5p3buweWw/S1V2XX4Mn2FV5dw/miPwP6pwKEWXVSh1Ntm8CJgP9n1HucoIft14Iadw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760805512; c=relaxed/simple;
	bh=AuQWRY1xfxI05PYvn0L7vQqnU62iWJjchUF8NFBttXQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Q9P7jzdL55LNRulBAMANkmmsAWaU16Noo0d9fDMuLQZpxeL1BoGQIo4xOe4kQZkBLI5a5Ir1/dZT9uX1p6TYysKvOE8s+s7CVMaYOiRw9Zq//QiwgYQcirWCz7VZIV+0Oz3Yg9HGFZv4ap60og/QveGab5GwrnPg10eSLSFHoyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vgdy5QvA; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760805494; x=1761410294; i=markus.elfring@web.de;
	bh=AuQWRY1xfxI05PYvn0L7vQqnU62iWJjchUF8NFBttXQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vgdy5QvAKDJd/Hpp+4k7MfK1JGqyOGQHTB5fJQDBqhYQQQh1qFXKW/bPT04rgp/w
	 wn3idFB+X3xlH1weoiDSrHOMu/p+plOD+fwTPARnXOKo7S0rbKbNRczC4vW5xs49J
	 txptKczS3JxFBYRTKMMkoUReqA8zsUVnUjTEcS4LAGhrU0dHcvaZ8ouxvf9IPigQS
	 XIFTzGuAB8jpApDaEmdJqTuqmlJF/lNB8R0PELAHiUS0nNHJE7tQFAZcI2cKAyZNY
	 2nojReJzHvzMy7PsePpIOBoEAstcc/bE2w0sq2pYQMi9h2z+MuS13MX/QWECEhD9U
	 NXMKSBHV94vUmCHc1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.233]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjgXH-1uTRSn0T0t-00l0xI; Sat, 18
 Oct 2025 18:38:14 +0200
Message-ID: <9092f8af-72d9-472e-8d5c-f950c8ce782d@web.de>
Date: Sat, 18 Oct 2025 18:38:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Huiwen He <hehuiwen@kylinos.cn>, maple-tree@lists.infradead.org,
 linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Andrew Ballance <andrewjballance@gmail.com>
References: <20251018152305.1612722-1-hehuiwen@kylinos.cn>
Subject: Re: [PATCH] maple_tree: Fix potential NULL pointer dereference if
 mas_pop_node() fails
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251018152305.1612722-1-hehuiwen@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tWq7IF+SHdHvK+h0mg0qdgE+1P+T1R4XpwQEm1ez0oPyPu+yHce
 6h7C9PcnvEHIOlg/gY3KSmLpc+8ErrsFkyK3KbrotLwWYw5ihO5qgK2T63NgodCyui1miKL
 y6HNMbYZapukAMh+7/+Vj2a6GAgi8Kt0D0kHiuYIzTAd9/WTDtYj5pjnKhIdRgEj24/2Tnr
 Gr1JXbu59BZA/MaLxJ9OA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JQQ5sRdm0qk=;xmbFgh8X4pPZlEzDCi0LhDyzskD
 iKhB6FkrWuLJF8Uov/gKyl+RSiubJZdEZsoYHjImhtd87yCtSZdC37IPrQ/eVHDBBhn59TwTW
 2Tj6HJNCP5Q7wdLmt7SeRuwi8TA6DgeJ2u2PwY2kRCTToBYrHaOJGvLyj+QvDKtz61yrREQ5M
 O6jRo9NJ3DVr7hQTQpDddRqOdvyxiEiYC/kcaJw+FHkDfO0tNVeRfc/d94pD0+1qRwza2SNMA
 wsqz8EzqIXFLyaUB1WOPEU0l+TjpP9ma3bdE4GsKXSYHxtZ6SswbzompoyfMO3xitlYdaTNXz
 jJTkpeTVzd+ey/rurtOcqu4h+jqH/kr5zC95Zm6PAMWGHvYhLHCcT47bGw9EMAlQpXziLFCc3
 oNDVsKVEITTRjPbWVFGFCimaEjwY1VZAivTbIitPZXvQ88/W/9aqTggZm0clDnivchgXXNu+4
 FgDPbDeTsc8G/fPz5i78gf54/LFf5KJUMNraf/gG8scdqAIR4C2Czyh74KukCwz82zMXOYfNO
 ghY96GtAjuu/86fuuFEeZvxa3bu4UqPUSMlSo3HXNdCymEFvlTNusVANnHHENDAafWfLZFZ6i
 k2DuRyqr/0XUNWDVs6XkCnXylgFOzNLMsIWiG27d0UPzg5uK6Gi7P5fTExWBCBGMryltR9B0t
 o5kTruwZF+Mm85x+7i855mtNXeWSjy6OYHEKyVfEpRHosN+yTAg7D5tK7ZhcGmUxMr/t4qwRp
 CRze3J99fKIm+8apl5t7Vgwvh5gF1Ns02EpX5ErvDt39W3rqM5PLzd73Kb0cxGnizxejan3EY
 HLa543MOddIVtcSwE6Ee9YsPoQIC56vsCDvziQS8oIIkU/1w0TDUU10aU+TEpZ533iDnC8/mI
 HzvurUW1K1Rwb6B+g/R7ZUiD9xl1Mp15WZbav485ozvfwUy/dcB0+KnL6rE4zQFuXIaOyWRbd
 vovZjV49ITdQfPc0v5iObD8t9aM8Bc0dcucj1Y8fDDGULh/ltAgAHD/Ad+nb/7z+xyvmM2s4S
 O02hvKFahQQ25g1uA2RKzMvqK9Tj5amNQkLdCOUEJeT5dl8JxzIoOuKZoiZmD9O+2EQqsx1XE
 AG2J1eHgH57JnaSs+iuCBR+i3zlOtlA6CmSm/4Kd6WYIc6HOUZGkq9H1FU9XQBqNrCC58BU3x
 Zg/S0P6oQX2Wju+4CEs2IFmf4plZNZfIIPzFFMpPxkciD6jzC2e+JzqFdBJvi3m2eG5IsrcHB
 IDDe718FbitTEmi8EErbYJqBH5lfGsJh9rk0f6C3/dC19qqryoDOkDKPqOhdM5ULXqx+fE5Kk
 2VEPXpLcH20wyzoDvN7/Pvd3RpPHHK8VDE8BmFwI5ZjjqdmI03lQbJP3BXyIUMNvhZGDGWfyb
 qLw0ieuWVvXYgzuVlk9aFKrKHlssM5brv9B+iSdW86R+qfbvYk7qArExK66/OxQzE781FL8O3
 AMV+4Fga5y4YjiqGUu99EjN4gsQlGJeNk1UeQs5pL75DYY81lFAz41rgIw/ukWfJhDqk5LZ7q
 N0htXC/sX0BlnYCXl5PD56ZzgBuAak+bgAQpGSjGOXxV9CSOeYxjnQ7OPvBaPbv9/IpqWvXFW
 NJIgtW0LYRD3ynYqPNHij/AOmtvgalDn4GgWXYUKrhXLmK7NcDttHpeyQtTBly7WvWN4+qmeX
 mKABCHiWF/iC9UwKGSBXr3Wd8tR+pGbsWi6FKMtRrHCp4AvTgb7NqDHrj+D812UdBIb+qNS25
 gy7HWIRarQ5qDZNx+B8hTxOnol4N9ZQzSHmSBRQFDPrVYxCdng1er5vHBzxc0or2Zu6x0jAEh
 fG7mv/6NLa68wdQKbU8/wf/pYuwoP2eFXm7dK/FHFeX1y4EyyAEWz1cpP3vG+s+hWjHdLUzsX
 TmGM6pCvNFxjGbru5AjrdX0YXv73ujCNguTdy9YZvRApJR2/XCCPC/HRCTEDbD1BpT9DeMfKN
 eVi7HRvT89+eSFF/UW1u3Kmvic2CJMRKbkWAAJaRbopTduQYS4vzRez7I4RVdK8AFN/jRNsgQ
 DP8szR8gIUWkrtealpaqKal7YoWoMFdt6kz0V0ujpBmjnjm11I0sqFmUd4HEBeTfsJ15WplyZ
 hSa1GvYq33sqT/m2v+RUs0xAHYL5VMsDrqfpmUO0O1Posq6AOL/o0+8O5ZnKcOyRWfzGJTrrF
 erMxYyQhbJ9xdF7XynJt0A8gvm2roCurvyqgBQBzQRnUyIZP/auf6DwNOTb38DCA5ZoIka9iA
 W2wa8FeKORhbVfDT6PVsm/hiOsLoqvayejIe8HbmrtkwhMXjZWudx3SpJDZIKpVQ0MeJhbYPg
 q1C8JDUdKF3FuahkehwhzBYTJryMaJxujTIZIE8Gc5/c2jkAOpvAcaWNLzmuYqCwUIlWdZOgm
 gsRmHEc5L684WZI6vlCTPef3WlVwIUf44OZtP6YmAyRj+E5JUiYBNXKjSGeSCo9ahxrYXVzhU
 5J7/mKzX+dcfmxKZNTCrAgoFMxVdQ9ufioIi2r8bg2TMk3kSAitCBYXCLHDbnm46LwZYEndE8
 5o9pi/MOVhqZqexGmeEExlzxe7a66HkmlPdui8gqr4qoKr1TqSVAcpVbGNwdG16snAw6DeD9d
 E8hhHddxurUWq3Erkmj/Jrri/hud34Zz/jOTlS9M91bjj9CRs+SYva1RXuzmoG0IQxTaYv6tJ
 koWdp4uiwo2iLNfsoagDt8g0a5ZIboX+Wkr538AxKlWWGAeScxgMr1q/qW6D2p+urUvHDMIY2
 rcTeNLumMIRrSBWqkxh2XUtfUZ0MnbX+O2cUlcmWUQlA5bux3VoryuDTPhOMy0uTk2xG22UnS
 ThQRIRfy8cmZOGfqTnwgqAEitkddetv9LNZiMxVEJDGhbDUG7DVfqRH8T+WMe+GwlvD++lnVb
 Y9Vb9/mqxSki1JvK7sjiPoo644+sNHLTdJ7BTTDG41SrVClUtzhlOtTHo1D4tqQjAoNG0YLPL
 UCW7Mw4Rjqa1xlkDMySP4xYH3dtojc08isflnQsHKnd3p5Qj5YVvTBMixI2Ac4PPuf9ImiYvf
 tSxw7HnoNzNW3CSUjINmsO+2JjQiDlgzuhCOPxzS/8LrChyq7wtH/SouaVB0vWsq9UksE6XWp
 bIPb/t4q3EEM/FDnWuih6qOFUrRWzyGFBeY8XQXPdeFy0ioJFvBQh0JTyDIcVOzbyYKKb4VHd
 8ojX5dErT8EDgoft9H4j06Epeh3HLv4jiTYsO84I6CX9e0LuAFAo2+w2n9q/19R4cXiYKIl7E
 9BxPLkZfbXk3qlpoyYbzPERCTyLXXu7Vgjf+jpo84XQPWdShCjL6ndt185WloUg0ntfcWV2A0
 gXR1u2rlg546vC86xoQuOr5mAQ5ewhhir41oixOuhFG731Czdp5T1q9rgT6p/ceiVkX4n9CU/
 qBsHDDTOfcOXpWzvNKRd3McCinC1hOGxwsVshoWo+TJQyxzNv+H4yNLvTDv0BwwH0NIJ4RiRN
 m6CJEEiq2J0uYYUwQElFnmwTxPKB1JWet8rzVhPxvsakb5Jai11uN0R6rs0lfqVFqrV1iX7Ek
 X8cWz1Nq5Y/oKvAgWFGAbgolCUghBNyWOIG25AfPLewQZZ7cR9qZEzup4TBm5CgBsj4BZnIt7
 u0QrysP11VUR8b9tVLyET9hxF51X07ujy4OT3ERJ5ExOLF/CJyBgvJ65pMzoaefQlHXd8Acxs
 eAq/45l2M2/zwjzrtV4OGDfhavhDyWOd9SlSY7TX4y/mzJBKGSApasP/0OfgUZpCj9PAxgunC
 phacHlWEcOlqz5s8Lwm/a3SSPhIoJ0HMtwoJKwZtw3NMow6KvZlIpivj445y/8zxVj+D8sdSy
 LRP2UAk1w8I5hKsA4nP3VWCOfNGIyUTSZzX6EaBNod4FOqE3VsGKjxBdcfGEZD0C3mOljEn4y
 Miq6r5QOtu/7yTvGR2eEn9E2Rif3iXQ/1P5xQwCTC2VZJWwnO6h4XmBkPHIbP1FM0kAN3uXdM
 LJqpjXSkJHImDpbk7pTnhWm6RDh6ni46x3DEXBRiIbFKTq7dRXb0OSHOIJK+13V45a7v67GNu
 noNB0EEsm+daemYNnP18S0dotUe4c/NMuy+uE2vHzcC4ZQ3dEM49GoSZf3Fz8G2Lrv9WJo/mI
 iOSxC8lul3/+nD8bwGWFhZ3hiNHyRzWSfYEZxCna2tIkTSkORqLZRO7I3FR8ySujQLFVhyEov
 0DsdC/2Z/NKs1JwPDuGHf5cklhvPedzLI8jzAjRXL6U+l72yHOTk9c7Eg/8T6ljVeXO7nLF0N
 GZtl8F+IWpddeTqR0PMCN+JvLlw89Zvo5cofWXyaLmdw5gIEWYkV2Yn2BTtUn2iU8z96UVG2W
 IYrKrdAhuz6ok8EQMQV6huw0EKuIqEHzpyInuQXqPcZIY6v08O8x5N7/QY08IsxTNrKSKdmch
 WFMCvAXL/j19jWlaM0b1Md640cj0B91qH9CNQxSvRwstyuaoPKo9GCF5rBckeaDk0o4C892Rv
 cWODIvdP62rwOx4XT8pq7lPePKyAxiJrdatLAggj9xC7nsZk9B1H8J/y3mem9K7K+ZaBuUogV
 kT9Qja56RiH7RhKSL5u6BVBKzIQF+HQIinN0pJzo7ybbNw2U177lkn09pk5h9Q8Owv+0O/eT5
 HUSudfQEso5bF26wDy4Amu4lD70JuzR/dKpSCeigY7mgkw/1q7knGn9gGNmuEkQn9xu2IKmQ8
 ELe+ymg3hGBAqjZtId2epYOfWz9tsFIFOrJJGpcM0oRW6OmlMBerGd30emVPmbW9oj+vevI8i
 SJow5NPs1y9dQebHBFVcQyOvUscudEPOC6WwvtEZNkTmu6XT9rE1ErKcIqw1t7mRxeitrXwx3
 csZuWHWOd3TyrTNFzf8N8Qpij1dbJz4CneRMGN51BSSyk+EZVICY/MwH2b+guAXpJSIQ4tgdP
 K8AMocNRLp/+hR/M5ksN0GOlshsuQ7damF0IjSCkmOSygNzoLQwlKuU2eFG5xqALo1M5SFx3x
 cmksfd487BFosrlGcHPSRhSJMVJfe+2ZTvj/Y980SbmQbbuNT2xe7UXP2YZ39fZUOIugz/CHC
 K1TpA==

> mas_pop_node() may return NULL when memory allocation fails or when
> mas->sheaf is invalid. Several callers of mas_pop_node() did not check
> the return value and directly dereferenced the pointer, which could
> lead to a NULL pointer dereference and kernel crash.

Will another imperative wording approach become more helpful for an improved
change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.18-rc1#n94

Regards,
Markus

