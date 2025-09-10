Return-Path: <linux-kernel+bounces-809936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B97B513A7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABB3177C36
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8382731194C;
	Wed, 10 Sep 2025 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="mBqP1bs/"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3748B25F798
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499402; cv=none; b=tpktuDoiSyPVAAbUnq/qABhzLwd9H5gHeAfA8Otdm/Wdt3xK2M33O7t83ttbVOnZzeE9gxVjRP4MIBbmjWfPB2AHKiFlGtBhZwRIY3MqSMRdSNmWlf5KVIIgJc5+IBGgNV+WVQMdphdBgXO6yQye1y4lPiMyOIn5JJOz2Kt5OAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499402; c=relaxed/simple;
	bh=JQGFgf4Q/DkQ2yeI/CGdFJTyTRKPZQ4yJe9U/HIrnSQ=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=n2l8hP71NpD7QuPwFtcM2bsS7CVCBiQnXOyYEn59wa3opQmIo2D8N6ukfd4oEWit+4z7h/1VlueCoa0MO1sgNlgmbfg+hlb2GIsCfLzYCFRLI0b56AvH05BYVTh7ZqwiN2T1KHYs/49Dpjd3NY+aiwonOw1iuBTU+dP2DLxvUkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=mBqP1bs/; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1757499398; x=1758104198;
	i=markus.stockhausen@gmx.de;
	bh=XYzAE/10QWCzldGWM8VHUVk687IDvvZkqpd+QoLFOFw=;
	h=X-UI-Sender-Class:From:To:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mBqP1bs/kHm0CIQ6ErrydEYnbTElzylB1bRB/iZdLwEVCSO0jlpLZjVXl0Lel6CZ
	 Zl506uqBYV+HAldEY7KBvhPJBFAGGXvvr2DbZeco1ijygsGvxPk06Vxb4CX3rG7AI
	 cUxQ7fTNG5jk/FXkMIFlHZKou+ubvoYD843QjVu+84yo3hVHf3do0DWZUj6kYiCus
	 v+uCNB/ouQZgRFaBbRojq2Rfda964wPPymsCem637m82hOGL7c+0rl1INcTm6zxNG
	 RxKUakznOsXnLmhrVxYdpYGLh7m0sbR+Ew3wdimsnmISAsx0sj/IoNvpJXdhzsn0Y
	 2KNYB6mVzo6zkEmARw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from colnote55 ([61.8.139.231]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIwz4-1uhNeu0Cfi-00LMrh; Wed, 10
 Sep 2025 12:16:38 +0200
From: <markus.stockhausen@gmx.de>
To: "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	<tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>,
	<howels@allthatwemight.be>,
	<bjorn@mork.no>
References: <20250804080328.2609287-1-markus.stockhausen@gmx.de> <20250804080328.2609287-2-markus.stockhausen@gmx.de> <af4a09e2-5b3e-4223-a926-4ab33b327416@linaro.org>
In-Reply-To: <af4a09e2-5b3e-4223-a926-4ab33b327416@linaro.org>
Subject: AW: [PATCH 1/4] clocksource/drivers/timer-rtl-otto: work around dying timers
Date: Wed, 10 Sep 2025 12:16:36 +0200
Message-ID: <007901dc223b$feb371a0$fc1a54e0$@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: de
Thread-Index: AQHp8yyrgZ2WnUFiBUflLXXXxyaZiwJVKvFZAo3A5nq0SXNUIA==
X-Provags-ID: V03:K1:va8Svmd18ICIkEeKWhUuc2lw7GFHuBavfKXZ15lI5bZy5Dj6aFc
 HI3NrMYt/hwDfqgGzAvAcVjbjnqiN4fBRiJrqsdkh+j7H1+YHiVHEnHJWyGtwg9JxNHMeRB
 2I/rAIUuMFrcylURw2ILhkk7CkG1R+rV2nJrz9DKTU1OSX6r7LBEDucBoEaNbpUlDDaQeoU
 Gw77xH85mJWKsuQ6Ru6xw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OVxd3E1pbac=;Bu1lfeh/O/hY/QzkOFRykJ7hQ7e
 Mkbhnw2/kg++Tn4/P2gysODX/ZyJmylm5J6z6pBrRoZTArthA+oXjUvbpxdRe4+WNID36HUkO
 hx79RKhjBql/lzjistssR07PSDsax6QRCnfagBIe5uFiRCYBM9RNIJ7OehbIL8hZj73ABJvmE
 itZKaUozGPYQ64oMVaSjPED9Y6icEMuRhqBixAkVgRE3m2eh4qg4C+aLya0dau9jWQ5d1X4KI
 wfGwoj+AwrLxzJTgX1YqtjFDYeew1X+A8d7BRxh+tx/OkwFr+6Ihd1F5jhKI6JPjlxgZUPK7e
 SPmX/bGS3iak2CHKX2uAnvD11grXGduHAl4J+fKFmysnLj/5zFx+oahiLqwbcYm/IZycOrW2O
 CcKqtd6BH07SAopEC9xpFLv4eYrnv8e9VSLNOueS5W6h+mpSBR+55FMOO9CnMdlIljC3jhAdq
 yX40LvmFyuLM1CEyBW+YrXtG3V5spq/iFWqRLRmkF9QyYlMFHQXUTlPNW3bSZVsz1zoOWjIJl
 ylZyy4FDombdxFFA2IRcKCIEulZaJE9vQ6OcVBXHpQQYIUBsZJuicRGONCH+so8qGBLOv8xRw
 2FeH5N8BcX5UTMy84llDR4rDHcEMadipYZvGogPPCtyRcwDZmmzCrena1z/wqg/3WwRDe6pIp
 U9Odm+zPDdFRTR1s3ham6NxaEHRU0Rl7MRzgdVYHclIs7YOrLPfWOzc6fCW26IdPLeSIf4gs1
 cVwv3Wxqqxe99+NqegT8fytOsqAN6qFcHOAeteuCWrruPPqevvA5D7H0yiPtQb56cXveHxLDq
 yE21dMiAouvDgB3/dtayVOL6xx9m2gJK1sr8/1F5+YI1zGRJni17KM0vaocwxFvxfRO2uS4CD
 kgDPWh7UuZtHr3WfZ0aRkW1gAFxJxOAsPk7x9dGQpnsEhZ3hES9jkQ3n67j+bsWW/FPkLXs+N
 0LNHvp4qTBNHdKup5UUtfcRCbzo9pePJVIRIajTvG+EjSzecspqVuQQaGxdSJY3BdYfMkISiu
 HODiYY9hMhwDPhcJXhL8LWeQrSzLw7NqVZHZosUmPtnb2QP4tPvIN4Ep1HQp6FmgrYz/Yveot
 7Awp0mOsh97K2DNyZyJFAakdFARRKAC8QpfQT4amaDUHQB4bv+n6zQ6eehrf4tVSyWAYVdenI
 oFEZU6HwoDsm5wB43qbCWzg9/2OA3xcq5FiHGTtTP2phyBnQfbPR3boXSpxUq6PWLb6ETD8Bp
 Y/8+brFBG8rdyZJDiFDyd3s1NDN7yCz8/LHqBRL3cxSrfJCYDUVilPJSEpv+ZelMf3wScgqD1
 xrZSZRQUS70zIdY2eLMdiwN/YAWxJD1SOrvoMMMAlRpKtRQjmSa8kumGQZTfg72kLZoAmJpd1
 XnPjvVJ0wYdlqJuigy8JSU6qM7sGlo8nKAKRXWVa1uS12K/gzZJnk3avcqMLq1qIG6kpKysY6
 7HTmDRzO2mvEGVTTbQHNsbRAVxBHj0wWng7TE+6nFjVSQhOtRQlWtsWPEGJmY781YYr+HVvY8
 K1nOgRbD8ss4s65gENDxS+7ThlCVxUFIvVPkeYJXDr374yAO0+Gzr0N8uJLe8xnhS2YykewZ7
 NASSoVvJck0ub2Y9PpvoH6D8xXnmUneQ9McXkI02ar0yivOWGLxJra3xNYO9jCgOvO27gWIWA
 yY8U5XkxtKM8mt+4D5bKfkTKEH5KPZP8fyx2bSvUpkzjbMXFBhHeOFFIxQaF3svbCujwqmbDL
 HlswGthBTIOkyUGQQ7AnW/Nz0rQI4gl5ZN2x2x99dKQUw5hb4QQ1tJnwinflQfNdc+jMENWS2
 ErZwilqYYQ+VwlqcHPAbeeymHfpchVJJLga1RcZP2j+MgyfY7jBzt8gvKLjfcVze7cCJUTkrp
 OKn4XHH/4xKY9nyonvoAtN5lc3Kqb9gQt9DnUxub2GykvRTVTdyc4TPfeRQFPN1qDB8MAFmcY
 PDEySAbwfa6TXvioq/IJXdTJXrh6pAkknMHKXYdvbqK7PuspVXk1zbwvaWTK6BOqDlu3NbNSx
 DfeJ63DZn92OsEw/beDc7JFG6pm4XEOWRdDx/ybtLMhLjd8KpVqWK6QuMqCbzMo/Gjqfr5a4v
 aMClU+WJOBfRahtizp13ZNrtYnAFYxpqA+1AMQtj2dJmS24uLle1o7WFYq5VTDKYJlkpcPAEO
 1uEh/C8ASFTh3fz4k8ECX3fH2mr8Jz7JIU+UBzQH9qNwn5I6W4oI+d1ii+HGKtcdP1Ljq192a
 Z+b1DgmIuhZOQBvZW7XYmyeeN2QJWeDmsNmJ3p28W5/o30BGYJ+LoH94PfOrf0FmitVno0WSf
 k2QvT45KvtVOnrndKDLnW2FER0KHLXY+PlKAi7ZA/o2YgXF4cZimjVIJ/VVy5FfE4DoB7Ygmq
 OKUV/4hRlmkwgvcT2k9bBsaDoO4evR03rwSGEgCTA+03cy1KlOzlZJX8eBCuGPq8U27xvHHle
 7t/zh4of94b/zBvBcuAjj047FZRlZUr2eZul9sftuL2cdibq/zxvFeOtWFSkAIhLTnA+obaz/
 QtDFoQb522uO91t/7ODUzVbmj+IGI7HcBG5CJDvsiujZY/h4wFe2V+dR71z5QNfDAheNOYuyq
 XN25Ucit52US2eyGkc0O6V6ibiiCSsHiIgY3BM6Fy5RyTf/0m2z55CwZHwXODbX29DGMiwi/O
 1tgCk5J6Ml4xIA+CEkxvHZhw0XwzVxSH58gonmbxnbQFyiTEQUoY8r+kSZQwuGZXKmXLLm5Dl
 4qhJ1qSSiIXtmsm+DDhWUxvYZfqFIpeJwDD0M5MnzVEupULvQ/+IMB3c+n4u6skqtkd/ApOxT
 2VlZA8G3YMNtdqgWSEPuqyEWG1HMUa2MTwugonxFIwkn8ZXcHVusFcG/uY8Vnbp4S4ZFjzfk8
 SPSqPhsiDYx8DiZpBK68COtXKf5xHH89oXj363GjWRQFeqAFqvClY+DJgF85tcfzLYhhfBJUG
 5P82vnbfYNkHWuvnB2y9L3OwPqU7Yp6TFLhfB7tKcQXtnP3fp5SXIn7R+jFOBVzynHlbHpgCv
 ZkxQifNLH/nrVzDOey3hfuHUlgnDR0PPgEOZ5Do46WbBA56G1AhFfdGIH0FSOlEp4dF7b38s3
 6gz+ggO2qjMkr8ZgGa4SiztHZLtnEN0QCvZ1WHd4D/rvh4rw63Md3pzc6Djr0FfzMCaiUSXVY
 F+dByzvZ7o5X+qNLErHBsU/zC+I9syyTkhMCzt2O8nUlDibx80JnwKxGMOIXsgIxtEg7Q+34S
 Ch1muDFQ4uColrtG7ASL/gPRxgxNWQTIDHd20e29qtwxkzKNMwE+ERB10udDKg/uJtPVuK0X8
 2+n4UIRq1ZFLSb0kmU+OxmnmMll+OZAE05MeX/eACrXVdS03SozEvEyNBgmU78v8wt5NjA56A
 Y9NviM8/d9UHSHadH621NDLd62yu2fQV26ArMopYhdG8Zk+2sBDUNb8PfzoNHfFS/ikD0G3eU
 rKsfk+IsCLdQrIQ2FFy2bw77olLAyKZCGvIMO4znsuq51ohsBNJ3fAYOacvqRVAG4+rsA2fka
 UXMn78dbAsEvIZK1egPCaqEz46rsY1bPqM1zyXUaq7xEEJA1w+m8Kjkc7MOnZFkuNij5FAUxX
 ikLSv/aykeyyIVxaJueNgTOqoR6XHgNkCz3QCr90CoP7R4KTH9Yom0jaqHNWdRF7JO1m0hY94
 iMQAbKvd2sriDWp1Ph2A2VzvbXoYqegmgp/N2+gh6c5bkQVWRB0tmEz4JZlLLyFnRUiDhYfJn
 7bABRKSzsqqk382fpmMfWrnpTniLfb59IiFlMDb30LQMZo6OWbqUMhpvlO8NQ2FGV3x29QE3i
 75dzM3hT1+lLSwONuDbL54WGC7CSIwwMML5RKY0dtZOuurKtuRSEHg8IIlbCPCy2D/oorWvKZ
 5C4DISGeLyia6a3b8fQqmus7Xp6vQ8Ft9kIEXVu8gyJPG/Y7W5jipmAXPzCGrAIfbRqtj68Up
 TfqdSvKtu2HWoDhoygTlob91ctBfPQybFqf2FYMl+BG5Z4ecFpnfxZQy5//l4fkrF6VTzSHQH
 13fciuAP9KX78autTYn9ypNheDxK59jiTkvCwrTj8d1Gj+B4OYZnvq5YX3NaRXH5GoS0Ozr2G
 z9w7gLyCg8zWMCwRBWkIKOYGccsTZTHwYmPEGmEl40HM+t5ZgBoXRz2DOyrR04KgRY5yzdg7x
 2OcpDqTjUtX37HSE+oUBtQvB6IXcKbA776tRftN7tFcknasUvrJaLPOalexr0FZDPirESBxBe
 raXTQ1KDUwfBx9hXXqlsPV6z4Go3QYGXG6nN1sjqVPxlczl/KPJEZRYcyz2AqIXI/+AD5vy2L
 JjMm3VDEdt/oOfblDekfShr0vSmlmFYl3mqA5enietxnTR7zv+O55q8SQ4yzeqJORFl72yUZ9
 hrNkGflTxniaq4JnYR8BRJps3br6bVvJbohFc6w2iJFcmmu+Vw2Rv74OPu0gTu934ZOnDUFix
 313qDqq19gSXqxzYV9kTkklYe5k4ZYguT3myglaNlaAisCHNKtGR8ROCEySu/eiz0MBrU+Xzu
 em+h1ngfGTEi6AmpewJEDJpxfqL3UDnuotNlqlGjGOJNPcOyXiUD6IteJfzIkF38i223O3S40
 6+UvG/12T6QfUCxb2imLjPXEuglEEfXPgmjm2nYWRWChTKaagxCTiGZq0Qg==

> Von: Daniel Lezcano <daniel.lezcano@linaro.org>=20
> Gesendet: Mittwoch, 10. September 2025 11:03
>=20
> On 04/08/2025 10:03, Markus Stockhausen wrote:
> > The OpenWrt distribution has switched from kernel longterm 6.6 to
> > 6.12. Reports show that devices with the Realtek Otto switch =
platform
> > die during operation and are rebooted by the watchdog. Sorting out
> > other possible reasons the Otto timer is to blame. The platform
> > currently consists of 4 targets with different hardware revisions.
> > It is not 100% clear which devices and revisions are affected.
> >=20
> > Analysis shows:
> >=20
> > A more aggressive sched/deadline handling leads to more timer starts
> > with small intervals. This increases the bug chances. See
> > https://marc.info/?l=3Dlinux-kernel&m=3D175276556023276&w=3D2
> >=20
> > Focusing on the real issue a hardware limitation on some devices was
> > found. There is a minimal chance that a timer ends without firing an
> > interrupt if it is reprogrammed within the 5us before its expiration
> > time.
>
> Is it possible the timer IRQ flag is reset when setting the new =
counter=20
> value ?
>
> While in the code path with the interrupt disabled, the timer expires =
in=20
> these 5us, the IRQ flag is raised, then the driver sets a new value =
and=20
> this flag is reset automatically, thus losing the current timer =
expiration ?

Something like this ...

During my analysis I tried a lot of things to identify the situation =
that
leads to this error. Especially just before the reprogramming command

static inline void rttm_enable_timer(void __iomem *base, u32 mode, u32 =
divisor)
{
  iowrite32(RTTM_CTRL_ENABLE | mode | divisor, base + RTTM_CTRL);
}

What I tried:=20

1. Read out the current (remaining) timer value: In the error cases
this can give any value between 1 (=3D320ns) and 15 (=3D4800ns).

2. Check if IRQ flag is already set and IRQ might trigger next. This was =

never the case.=20

3. Reorder reprogramming sequence (as far as possible). Only the
double reprogramming helped here.

So nothing we can do to actively identify and work around the buggy
situation. There is some hardware limitation between expiring timers
and reprgramming. Due to missing erratum the current bugfix is the
only (and best) solution I have.

Markus=20


