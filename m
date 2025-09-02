Return-Path: <linux-kernel+bounces-795750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5727B3F75C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3811D2076FF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C792DFF18;
	Tue,  2 Sep 2025 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=m.armsby@gmx.de header.b="sI8JWhHt"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A22E8B74
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800006; cv=none; b=ZtVQ/b+qmXRjEqD4cdjI4n1G3fWIu75uEby9oDokkWgIVUaA3d8fSnm2OzZ66I1zTon5Z03VFxC3yrW/WadGg5avkBE3Fb2JAdOGoKVllOe0vYTjXPoMC8YntnTupLTiLqtewStbKJcdqnJjpXQPbvojpfJdKsJmou84mo+/Bxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800006; c=relaxed/simple;
	bh=GyQWy8JOWscW0ybAhRtNmYaEX3SEbhlunk2Mp/D2Cyo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Gy+/neAfjZj2+59VuGgRfJGtKUyMXwiXc8Cgn+vYJio6YfMOxmKatPAVPZ0tnp8sycLX8wEyfUqb8qVCBBVBESU1rzojgoRhgD02TPd3nmgzbektUXgziohLy5RYF43hsxSGyaYOMPfpw4n1kYMvW89OV334TOjsm8JKQbboc1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=m.armsby@gmx.de header.b=sI8JWhHt; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756799999; x=1757404799; i=m.armsby@gmx.de;
	bh=1CBYuzYpCXkGl5JES8uvRduOr6YdzywVe08CkRllJAw=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sI8JWhHtzr2O1dGOAANCNzznVbKHoyPpBOcSJ4X5jHMxUOX+u/Gokqyo9I0HzwIq
	 OmvT/HHhgzdtEuMUB6JhYPYLjdWQrt/+XR4JJisklanNkUOZzLSI9+/ckWuOvmdrS
	 3eGK+wF1enRjfJFoWYcWTaT6JEJQKHflMXt5xQtMf8EmyIhbrT3+rWsnBRdeJADxO
	 oLjpEE5NRojC7MknD1aqfn0/U4s/2z2XNyP4BOtEeWGROBFedQWzelLLKO6FWJULa
	 q+XGaq5z8e61pqVQCH0WfhDCJRaC8fO30nT+S4qhYszwbm9lUQpvWPT+4bnFj9C37
	 jbzg/yojqyItS1S5Pg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([77.20.253.70]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17Ye-1uUVTZ31zu-011Hvr; Tue, 02
 Sep 2025 09:59:59 +0200
Date: Tue, 02 Sep 2025 09:59:58 +0200
From: "M. Armsby" <m.armsby@gmx.de>
To: alsa-devel@alsa-project.org
CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>, linux-kernel@vger.kernel.org
Subject: Re: ALSAfirewire broken / Pipewire 90ms delay
User-Agent: K-9 Mail for Android
In-Reply-To: <FD6FDA7B-D958-47BB-B90C-1A82349F94E4@gmx.de>
References: <224C5A41-DCED-4FA2-BE82-898F257DA2E9@gmx.de> <20250724143813.GA23616@workstation.local> <FD6FDA7B-D958-47BB-B90C-1A82349F94E4@gmx.de>
Message-ID: <48A27ABA-5EF6-400D-A47A-103C1A4ABC6D@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+jWPIt2ohuTWS8lhI1A8h4PY8+EI2SKjodHg0QBbRAz3lUSMG0G
 4j8499EYPmYkfHzRSFlsjGv122eYVLp+/M0CCyD7MlTVWFheTUMle3STLWLwsWtHSahFe0j
 sR8ieha7GPUNXCrdw2D7jA89MIRu6BHY5ixrUqIzPPu05SamXtwzfJmpDRlo/1N/Sp9Cvnk
 LEw+/ErrhEqs0IYRGF8BQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kmP0ASunhWE=;7NvzwRwtVe96nDZsXZXD1ONtnWm
 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
 pkfBf2i35y4KNoKAoP8

On 30 July 2025 21:36:00 CEST, "M=2E Armsby" <m=2Earmsby@gmx=2Ede> wrote:
>The new ALSAfirewire drivers are very good=2E Well done to everyone who w=
orked on them!=20
>
>Today I tested brand new CachyOS with xfce desktop kernel 6=2E15=20
>Initial Pipewire test showed RTT 98ms at 64/44100 so I uninstalled all tr=
aces of Pipewire and installed PulseAudio and Jack2 instead=2E
>I first tested ALSA direct from Reaper with Echo Audiofire4, Pianoteq and=
 the RTT was as expected around 8ms (no 90ms)
>Then Jack2 with ALSAfirewire=2E
>The result was very similar and around 2% less rtCPU usage but a few X-ru=
ns on page refresh=2E
>I then set CPU to balanced and Jack failed with hundreds of X-runs wherea=
s your wonderful ALSAfirewire alone continued with no X-runs  :)=20
>
>
>So you don't need to re-invent anything and there is nothing reasonable a=
bout 90ms delay=2E=20
>ALSAfirewire is working fine as long Pipewire isn't involved=2E
>
>Please fix the Pipewire problem as now nearly all distros are issued with=
 it and everyone is blaming ALSAfirewire stack!
>This madness should be stopped don't you agree?=20
>
>Please=2E
>
>Thanks Martin Armsby=20
>
>
>-------- Original Message --------
>From: Takashi Sakamoto <o-takashi@sakamocchi=2Ejp>
>Sent: 24 July 2025 16:38:13 CEST
>To: m=2Earmsby@gmx=2Ede
>Cc: alsa-devel@alsa-project=2Eorg
>Subject: Re: ALSAfirewire broken
>
>
>
>The 90ms delay is reasonable=2E=2E=2E, depending on the PCM buffer
>configuration=2E
>
>At present, all of drivers in ALSA firewire stack works with such delay
>due to queued initial packet=2E Therefore PipeWire computes the delay
>as expected=2E We would need to reeinvent the packet streaming engine if
>reducing the delay=2E
>

@wtaymans =20
Wim Taymans and some guest programmers found a simple workaround to bypass=
 the 90ms delay:

monitor=2Ealsa=2Erules =3D [
  {
    matches =3D [ { node=2Ename =3D "alsa_output=2Efirewire-0x000a35003926=
b6db=2Epro-output-0" } ]
    actions =3D { update-props =3D {
       api=2Ealsa=2Eperiod-num =3D 3
    } }
  }=20
]

The communication from DAW to pure ALSAfirewire is not burdened with 90ms =
so please change the pins or whatever pipewire is using, so that it can avo=
id the 90ms like a DAW does when communicating directly to ALSAfirewire dri=
ver=2E=20
It must be obvious and easy to see in comparison and thus fix=2E=20

ALSAfirewire RTT =3D 10ms
Pipewire-Firewire RTT =3D 10 + 90ms

Please, many professionals are waiting for this fix which will boost Linux=
 up to professional level=2E=20

Thanks





-- Martin Armsby

