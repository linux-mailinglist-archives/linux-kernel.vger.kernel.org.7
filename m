Return-Path: <linux-kernel+bounces-746263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FC9B124C0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786463BB71A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2F523D280;
	Fri, 25 Jul 2025 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Rxqs2vHw"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3782D052;
	Fri, 25 Jul 2025 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753472121; cv=none; b=hOPO/xHPdAfVb4EzFc/bZUrgj8La609fv41mxAroMx+XwrHiDMn/uLGkylAhp6/So9x2bOWcAEI8rVjZd+cotfywJq9jZk6d2U2O9obYQunGfSq3/wRJCGkkJTfZCbdm6ezr3keeKtCWiwfvO2oewnmf1Smp83tYQ+VnqXTMeUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753472121; c=relaxed/simple;
	bh=3Xlemyi/uapW2J9j70OiiGHjNEZEJkgBsZ/R6FXT6eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QB/thy2kjcew9uP6fukETeVpTYOzxsB4IeaXP6OlcU9B6EPYoy5rw4AF9zNREXj0C2yK1Bpj9BjEUi3rKpY+KA8qW2HHR4E6wFIeHKpXOSibO8pkaKQas6X4mmXjDGuKcU79H4/2uNZWCDZOeM5zxXpCysV3Mebdf4CtDrf13CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Rxqs2vHw; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753472111; x=1754076911; i=deller@gmx.de;
	bh=wPO1NhkN4jIGEIxnkcFc0Y7dQYtvaXtp4zYP4NfbYcI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Rxqs2vHwU9u3bbekWYEjO5IkGOXUj0ePd8WNq6iAXyRBOTKTNI25egIBZIRCZ/Tw
	 QWtb309+VC/QD/VIOn+CnkZzvVwOp4o0MQaMhenBYbw8P+aeUyd+uCOFqme5yQ2fc
	 32e2xpRnVExj9ofcUB3h46DYuqEXZpiErCBHXnF6GE1UrbVpcRbMAg01g9xnFD0nL
	 Dh2tKOJJd8SzDiPZunnQ/AWwrsQFldeyHnuBdgvZe4Vj4ZrrkHp6J4oaV8L3Y+fct
	 4W6+DQnBkhndRPV6jWPHorOSO0PubN49Ceh+dbXi0xhG/XWxCkXRbLRPGX1zVElX9
	 WS4OAXRA3dR3/DFnuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.22]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUUw-1uMYdf2HV6-00dMuh; Fri, 25
 Jul 2025 21:35:11 +0200
Message-ID: <7496ae20-7ed2-4823-8646-5e1b1b22284e@gmx.de>
Date: Fri, 25 Jul 2025 21:35:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: Makefile: explain that 64BIT requires both 32-bit
 and 64-bit compilers
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-parisc@vger.kernel.org
References: <20250625073054.802365-1-rdunlap@infradead.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <20250625073054.802365-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sKa2Nfb5eDUkuxl2E+xPqeS+RaiBP6YKniCfAcU7bV8T+I/rfQi
 w2oivkLa+eKbagELf5mv9/A1oeoh/CGMhIr8ZufqR1WoxMb+agSSIuCqfMUDJxL4m+LTkmF
 1ubF3vmxYu6qoVOLQY9f4A102BKH1P+xN6jqn15yU1dIjB/YtsOobaW5mf2QkVqd1HD1hlT
 0Q+tgftUkYn0p2H0nAu0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D7g/+jrr/0w=;sJTHicYzxwaCp0XsJBP29uLSkiY
 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
 NzDR/jRtfRBFZ8G3ouUFXm0=

On 6/25/25 09:30, Randy Dunlap wrote:
> For building a 64-bit kernel, both 32-bit and 64-bit VDSO binaries
> are built, so both 32-bit and 64-bit compilers (and tools) should be
> in the PATH environment variable.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org

applied.

Thanks Randy!

Helge

> This wasn't obvious to me; I was seeing lots of Assembler errors
> when only the 64-bit tools were in $PATH.
> I didn't find a better place to document this.
>=20
>   arch/parisc/Makefile |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> --- lnx-616-rc3.orig/arch/parisc/Makefile
> +++ lnx-616-rc3/arch/parisc/Makefile
> @@ -39,7 +39,9 @@ endif
>  =20
>   export LD_BFD
>  =20
> -# Set default 32 bits cross compilers for vdso
> +# Set default 32 bits cross compilers for vdso.
> +# This means that for 64BIT, both the 64-bit tools and the 32-bit tools
> +# need to be in the path.
>   CC_ARCHES_32 =3D hppa hppa2.0 hppa1.1
>   CC_SUFFIXES  =3D linux linux-gnu unknown-linux-gnu suse-linux
>   CROSS32_COMPILE :=3D $(call cc-cross-prefix, \


