Return-Path: <linux-kernel+bounces-888635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E5BC3B8E7
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F0C563B41
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFB133C536;
	Thu,  6 Nov 2025 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9x5nJ4A"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C32E0934
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436584; cv=none; b=GzpCmJOH9se3GcPafUE853kG0LS/VchcCKT43qxs0l5bh4yq64CWQYTzIlkrulippyWMQeIpoWC5bVZ680iIysq1NW8L8RDc7VAxba+MqpYSqoQG4njLIJkB1mrl6EAvAsaMknFsUCHqhXxiYh91C7+rP6b0xLHjkdnEbhdALdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436584; c=relaxed/simple;
	bh=yM08vXYgeS+2QUmB9lU/TpbxKmTJ2bayDxKCYSgsODA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5m5rz/Q84bLAHwhwlVNEzwO7bSo+ckw/jMCi/boEwMr121950nQND3G1X6sT1o508kA0AYjlf/4P57m9jM2IUH2uGopIDbzfvGOkggUkuaKhNSpMA1dRyGsm4bN80vfkniklmdp1lCeLqGZ1TfIEsWmna9fiZbVRxkCmZXBbOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9x5nJ4A; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-427007b1fe5so636376f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762436581; x=1763041381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4DaQeGVyB05KYzPS0LHKvWlhb6TnpUA8LWnzGCb6LE=;
        b=l9x5nJ4AF4qOQZd2QseTvTvF/rCgyyJIN6Qv2MsWPmsPJ5d451JTrINWDA8Q80ZAzI
         jyAck/zrgsmhQFqcT6p2/BvTEZu4VTPZd8133qGGTnw6O74kmjSQ6Ap4gTLbhaQDT9QB
         r68iBUc4wxX1MrLQ0jlIaIbh6nUKnpEBd0psRiUjJQpgR2LYFWa4K2YJ2NGt3ecrD2rB
         4g4U3Ci0QpWeZHcbjuaHFfarQncTFQz8+QWo469YWfUiMszgGcNXO1YSLDpP03HppifK
         BAe0mvnkUA32K952D7kSNEQ+R1PbWgm61mqKQ+Afj2AycHhVbB8s1Zk7UbJDd28ymJfZ
         Yi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762436581; x=1763041381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4DaQeGVyB05KYzPS0LHKvWlhb6TnpUA8LWnzGCb6LE=;
        b=L/U1+UMU2boyWGLg363rZYYfrd0+NPdssnrrci678zi2LS5vqZ8X7sKId92OvR92hG
         vIFs4vf6HWinaYBGB7HJtTJ7YbEL8mTkE510YCWt+8k4GfGHfW79036J3/gmSQkEGtCq
         o8wNdyuIoMcXZlLYL5UUTOzkpaF9H9JvuILNYl5w0jMuy9o0DydXVzgKDbV8UuF8biqo
         dxlF88jGw9bhUE+UzGHm6pqD/qmoe6c4vjKDKhqb0V4th6eJYCP0TMJuJXl7MEh91Q7o
         eyREcTRmV6fmi7bCvEKfwighlowgFCtjyXU0o66uUU25NW3k/eIe557ZhgIMEaDRleWj
         MOXg==
X-Forwarded-Encrypted: i=1; AJvYcCVzf0/YQNMQJCnfH+g6+XFh/eCAzw0Z1XziK6d09Avio0n9I/srGqFrt9JH/o5GH/WMiBfIv18KaYsdofE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx18DwfqRN11NjXJx7zfd1AIbYr+yp8C0Vw/oI7JPte9gYHmlli
	qiQ21ynG0ty3LlYOpjHpI977Ovd2ih6ehqxVUO7UmsHXsip/2yvQftGM
X-Gm-Gg: ASbGnctU2T3DSlAYuyryrknA0vY6UZ+c7YQsiSZ1Wn2enM3Zj6FRiRp8oltuSV8j53x
	xnWjH+bRPfczjG3pjGq0/QlDGCvsRcx0WlRRoSmtf3vvhTgBClqY4aLLHAV5HodmPQZGFNB8puB
	qPA3B5VQj11ljzyQfp97qsOyB42H+eQqM3kLmd2qLLZNHlH08aFzsKjeUUVjHmA5rXFaLUWs1DG
	X4S7BQq48YO4VJD6bePKYFv+hYeFGxHJHKfQ0qaaE+0I1cMHqpHrin8Ti5ieXgyj8nIaRPVSySl
	pQe5NhVs3cyRN2DJSzP5STPhkOkdJgV0P1PccyDqwOlxdBcRPxCX/6vbwjIWslBdPcj5/fwK0vr
	2BjKrFWxtAosSmjSBLgTc5S8kARISilGtcvFeuND2kcZS4hCSmV65BhAy5yqm9p8QV85jO2X/HU
	a4sKnzT6nEF4RS+lC3k3mz0Mzgwu7WxS6rN6ualRuTOOgfBH0NME7XOE0rGRrh3rg=
X-Google-Smtp-Source: AGHT+IHDsjJABGBM/pDAFp2o03YAq/Y+Phzta3DyuV5Jfm/SuLEOelkoMEjBy0TTBTORIGeE1uEwkw==
X-Received: by 2002:a05:6000:26c1:b0:426:d81f:483c with SMTP id ffacd0b85a97d-429e33088ddmr6854934f8f.33.1762436580431;
        Thu, 06 Nov 2025 05:43:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb42a354sm4888852f8f.20.2025.11.06.05.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:43:00 -0800 (PST)
Date: Thu, 6 Nov 2025 13:42:55 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Andre Almeida <andrealmeid@igalia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de
 Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 10/10] powerpc/uaccess: Implement masked user access
Message-ID: <20251106134255.2412971a@pumpkin>
In-Reply-To: <20251106123550.GX4067720@noisy.programming.kicks-ass.net>
References: <cover.1762427933.git.christophe.leroy@csgroup.eu>
	<5c80dddf8c7b1e75f08b3f42bddde891d6ea3f64.1762427933.git.christophe.leroy@csgroup.eu>
	<20251106123550.GX4067720@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 13:35:50 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Nov 06, 2025 at 12:31:28PM +0100, Christophe Leroy wrote:
> 
> > On 32 bits it is more tricky. In theory user space can go up to
> > 0xbfffffff while kernel will usually start at 0xc0000000. So a gap
> > needs to be added in-between. Allthough in theory a single 4k page
                                  Although
> > would suffice, it is easier and more efficient to enforce a 128k gap
> > below kernel, as it simplifies the masking.  
> 
> Do we have the requirement that the first access of a masked pointer is
> within 4k of the initial address?
> 
> Suppose the pointer is to an 16k array, and the memcpy happens to like
> going backwards. Then a 4k hole just won't do.

I think that requiring the accesses be within 4k of the base (or previous
access) is a reasonable restriction.
It is something that needs verifying before code is changed to use
these accessors.

Documenting a big gap is almost more likely to lead to errors!
If 128k is ok, no one is really going to notice code that might
offset by 130k.
OTOH if the (documented) limit is 256 bytes then you don't have to be
careful about accessing structures sequentially, and can safely realign
pointers.
I suspect the mk-1 brain treats 4k and 256 as muchthe same value.

Requiring fully sequential accesses (which the original x86-64 required
because it converted kernel addresses to ~0) would require policing by
the compiler - I tried it once, it horrid.

	David


