Return-Path: <linux-kernel+bounces-869547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3B1C0823C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D736357133
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BF62DA75A;
	Fri, 24 Oct 2025 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iH4iJt5X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532802FCC1D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761339611; cv=none; b=JSvSX//Ws2rR5EETh4muv6Wg5x/jFxsAl+HRCM0gKyctMrQpGBd6gr71LT1rypBnAZkE8a3vWg/gxCi06ZQTXZlUpqcNhITYYt4PHzxMUu84enzf0W328i8SJcYB+KwZrkiI+LSKCOPQ8s1Xrn8RNxGEz6I67HeCslmI6g7qrps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761339611; c=relaxed/simple;
	bh=ZPgjwfZPJ4N5YUXQKwtdNaeTaiAVXpDtI0YR8v3s0pI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XsAsCOGYIlyMkj0JRV0V+miOmddFKU6ax5gpnrZNCbDU65CfFoa7Wz762OsMWfX5b6rtNSu3D/zJ3t/RnRzvjs5x/p6vHV6QDTU05VeUN3g2gbQVAXerPZXodYxORTWZc1pi1QrhIv0GPnBRSljJtuAuC7rPNocko/8qk4f2HUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iH4iJt5X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761339608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5kBJfzZ98Wj4hO7jbrTSDKgQFWU3QI5hycI3xZokODY=;
	b=iH4iJt5Xfy3Tpa+W2orbWWyoqg3E/XHCwtsPNc46OISqwYX3fuDsKlTo4arw944Hk8ZG/a
	jPiTGr9PdlQXhRKvU+UonECYZqJtTiQT9TXf7D6cfI5whXt3MZXiZavtH3NmlTVAv2Grj3
	dTRpICReFegUSEARJVl8hdH1Wj+v5BY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-aX4iQX6oPxeUDViVo6DTPg-1; Fri, 24 Oct 2025 17:00:06 -0400
X-MC-Unique: aX4iQX6oPxeUDViVo6DTPg-1
X-Mimecast-MFC-AGG-ID: aX4iQX6oPxeUDViVo6DTPg_1761339606
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e88947a773so111453761cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761339606; x=1761944406;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5kBJfzZ98Wj4hO7jbrTSDKgQFWU3QI5hycI3xZokODY=;
        b=xG3IBYRbpzB9ymcf7f2rOr4b8dQd47eTmQF4nn5cxkPhbssCHg2V04ZBgfJhGExyXH
         msMqlfVHlxhy0Py4Mm1zkSFIlPdRzF9/BZ8z0WT0V5slW5LFVDm6qHKxPgnZ8Zqd7/dj
         b9EBv/rJXSXo6SBTE55W8TmP3/xPlXuUsGaEW6hLFulei+7ASuorvB/RHqiilZMC0BMp
         BnPdxDBkNUUlCkfenq5kmEzWPJyOCztaWOF1Nq6FdDS126jRUxu5TCC2r3CBAULa9eRN
         VSKfuJkn8yqFqwh1e3TK543bzNNid8rfNUuAqZD6BThokhGxOabUfM/7YxVpzGpKZMFw
         JWcg==
X-Forwarded-Encrypted: i=1; AJvYcCU6RXJP1HJY/69XqzqDnaFBaQ2BweN05lRkYU+Yb7pLfXH3Kxkb3OvMWKTgGcNi5B7vaAzlRLKisFBfCU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww1oMnnMk4gYkx2NbHuK/JGC3PrQ/Y9/piQmUKLzd2yeiD09WB
	I5dK2xeVhXpZvzj81JnVpKR5UUVsP0oDIRZbBU+s3MjbL/SsMW3Ym+RfbbAh5d2EnUltYQLeyfI
	DP1vUoQHW85uAjlV+T4e4VgGLN/Q43NZsPGxFezk8Yw1ywYexd6VcsqJKSr0mEBpQ3w==
X-Gm-Gg: ASbGncuxH0eWMgvXgPDW1BFqrU8KWpJAv7k9UG+R0gJGAa2640SsoJYSSaByT9QsCHJ
	Fk/PoGnnShecdr4Pp44ch2kPl9vITOn2epysU+6bpiLwkq9k3gcYeyRL/yjustQPa5isevmWlBm
	j+LisjdDWFu9A31ZMnKF91Emqj4Y5vbKYhfnEKPOxmzxcmNConwUMZNXYPxRKdNfgqwbQuoUzWq
	PC2Fw3TzOZuY29HD1P0aaVaARoPmKszf32ftd+55Wz+zMXQCL2ItCrbPQulMS8sdJkqvZ7NHYjW
	IwJ5Wdzx2owuas/U1LTtKva/8126c0yJ1y3aUHOXv/ocsSDrY8VykZSxamdE8KZgnVEb1oFVWcX
	ZWCz34Y1L34gDzLY/+mxm8w73tXst9M8=
X-Received: by 2002:a05:622a:138a:b0:4e8:947e:16ef with SMTP id d75a77b69052e-4e89d265f9fmr382356551cf.21.1761339605865;
        Fri, 24 Oct 2025 14:00:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLNVhaK81BrJnKYK1JoNVu0V1nl9SpXqeB0PT9Cm45xU7eGhzyqHOxksmutDw6Htl+hrp3CQ==
X-Received: by 2002:a05:622a:138a:b0:4e8:947e:16ef with SMTP id d75a77b69052e-4e89d265f9fmr382356031cf.21.1761339605381;
        Fri, 24 Oct 2025 14:00:05 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba37fa7b9sm1065531cf.17.2025.10.24.14.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 14:00:04 -0700 (PDT)
Message-ID: <de1ec7fcc1711e3062cc321ab55552339630de30.camel@redhat.com>
Subject: Re: [PATCH] genirq/manage: Reduce priority of forced secondary IRQ
 handler
From: Crystal Wood <crwood@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
	 <tglx@linutronix.de>
Cc: Lukas Wunner <lukas@wunner.de>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot	 <vincent.guittot@linaro.org>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Ben Segall	 <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider	 <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Attila Fazekas	 <afazekas@redhat.com>,
 linux-pci@vger.kernel.org, 	linux-rt-devel@lists.linux.dev, Bjorn Helgaas
 <helgaas@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver
 OHalloran <oohall@gmail.com>
Date: Fri, 24 Oct 2025 16:00:02 -0500
In-Reply-To: <20251024133332.wSQOgUZb@linutronix.de>
References: 
	<83f58870043e2ae64f19b3a2169b5c3cf3f95130.1757346718.git.lukas@wunner.de>
	 <87348g95yd.ffs@tglx> <aM_5uXlknW286cfg@wunner.de>
	 <1b3684b424af051b5cb1fbce9ab65fc5cdf2b1a1.camel@redhat.com>
	 <20251024133332.wSQOgUZb@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-24 at 15:33 +0200, Sebastian Andrzej Siewior wrote:
> On 2025-10-03 13:25:53 [-0500], Crystal Wood wrote:
> > On Sun, 2025-09-21 at 15:12 +0200, Lukas Wunner wrote:
> > > On Sat, Sep 20, 2025 at 11:20:26PM +0200, Thomas Gleixner wrote:
> > > > I obviously understand that the proposed change squashs the whole c=
lass
> > > > of similar (not yet detected) issues, but that made me look at that
> > > > particular instance nevertheless.
> > > >=20
> > > > All aer_irq() does is reading two PCI config words, writing one and=
 then
> > > > sticking 64bytes into a KFIFO. All of that is hard interrupt safe. =
So
> > > > arguably this AER problem can be nicely solved by the below one-lin=
er,
> > > > no?
> > >=20
> > > The one-liner (which sets IRQF_NO_THREAD) was what Crystal originally
> > > proposed:
> > >=20
> > > https://lore.kernel.org/r/20250902224441.368483-1-crwood@redhat.com/
> >=20
> > So, is the plan to apply the original patch then?
>=20
> Did we settle on something?
> I wasn't sure if you can mix IRQF_NO_THREAD with IRQF_ONESHOT for shared
> handlers. If that is a thing, we Crystal's original would do it.

Do you mean mixing IRQF_NO_THREAD on this irq (which should eliminate
the forced IRQF_ONESHOT) with another shared irq that still has
IRQF_ONESHOT?

I suspect it was a non-issue because of IRQCHIP_ONESHOT_SAFE disabling
the forced oneshot (the other irq was pciehp).  Given that these are
pcie-specific, do they ever get used without MSI (which sets
IRQCHIP_ONESHOT_SAFE)[1]?

The issue seems to be that the type of oneshot we want for forced
threading (unmask after the first user-supplied handler) is different
from what we want for explicit IRQF_ONESHOT (unmask after the last
user-supplied handler).  If we separated those, then the semantics
would better match non-RT, and we'd only need to care about mixing
when it comes to explicit IRQF_NOSHOT.

> Then there is the question if we want to go the "class" problem to
> ensure that one handler can preempt the other.  And maybe I should
> clean up few ones tglx pointed out that provide a primary handler for
> no reason=E2=80=A6

Either way works for me, as long as we pick at least one :-)

-Crystal

[1] I realize that the answer to "has any hardware designer ever
done this weird and bad thing?" is usually yes. :-P


